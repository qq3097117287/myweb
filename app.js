const express = require('express')
const session = require('express-session')
const app = express()
const port = 3000

// session配置
app.use(session({
    secret: process.env.SESSION_SECRET || 'library-session-secret',
    resave: false,
    saveUninitialized: false
}))

// 登录拦截
function checkLogin(req, res, next) {
    if (req.path === '/login' || req.path === '/dologin') {
        return next()
    }
    if (!req.session.user) {
        return res.redirect('/login')
    }
    next()
}
app.use(checkLogin)

// 视图引擎 EJS（你原来的）
app.set('view engine', 'ejs')
app.use(express.urlencoded({ extended: false }))

// 数据库连接
const db = require('./db');

// ==========================================
// 登录
// ==========================================
app.get('/login', (req, res) => {
    res.render('login')
})

app.get('/dologin', (req, res) => {
    let { username, pwd, role } = req.query
    let sql = `select * from sys_user where username=? and password=? and role=?`
    db.query(sql, [username, pwd, role], (err, result) => {
        if (err) {
            console.error(err)
            return res.send('<script>alert("数据库错误");location.href="/login"</script>')
        }
        if (result.length === 0) {
            return res.send('<script>alert("账号密码或身份错误");location.href="/login"</script>')
        }
        req.session.user = result[0]
        if (result[0].role === 'admin') {
            res.redirect('/adminIndex')
        } else {
            res.redirect('/readerIndex')
        }
    })
})

// ==========================================
// 管理员首页（统计卡片）
// ==========================================
app.get('/adminIndex', (req, res) => {
    let sql1 = 'select count(*) as bookNum from book'
    let sql2 = 'select count(*) as readNum from reader'
    let sql3 = 'select count(*) as borrowNum from borrow where back_date is null'
    let sql4 = 'select count(*) as returnedNum from borrow where back_date is not null'
    db.query(sql1, (e1, b) => {
        db.query(sql2, (e2, r) => {
            db.query(sql3, (e3, br) => {
                db.query(sql4, (e4, ret) => {
                    res.render('adminIndex', {
                        bookTotal: b[0].bookNum,
                        readerTotal: r[0].readNum,
                        borrowTotal: br[0].borrowNum,
                        returnedTotal: ret[0].returnedNum,
                        user: req.session.user
                    })
                })
            })
        })
    })
})

// ==========================================
// 读者首页 + 借阅状态判断
// ==========================================
app.get('/readerIndex', (req, res) => {
    let sql = `
        SELECT b.*,CASE WHEN br.id IS NULL THEN 0 ELSE 1 END AS isBorrow
        FROM book b
        LEFT JOIN borrow br ON b.id = br.book_id AND br.back_date IS NULL
    `;
    db.query(sql, (err, list) => {
        res.render('readerIndex', { list, user: req.session.user })
    })
})

// 读者借书
app.get('/borrowBook', (req, res) => {
    let bookId = req.query.bookId
    let userId = req.session.user.id
    db.query(`select * from borrow where book_id=? and back_date is null`, [bookId], (err, data) => {
        if (data.length > 0) {
            return res.send('<script>alert("本书已被借出！");history.back()</script>')
        }
        db.query(`insert into borrow(book_id,reader_id,borrow_date) values(?,?,CURDATE())`, [bookId, userId], () => {
            res.redirect('/readerIndex')
        })
    })
})

// ==========================================
// 【新增】我的借阅（读者专用）
// ==========================================
app.get('/myBorrow', (req, res) => {
    let userId = req.session.user.id
    let sql = `
        SELECT br.*, b.book_name
        FROM borrow br
        LEFT JOIN book b ON br.book_id = b.id
        WHERE br.reader_id = ?
        ORDER BY br.id DESC
    `
    db.query(sql, [userId], (err, list) => {
        res.render('myBorrow', { list, user: req.session.user })
    })
})

// ==========================================
// 图书管理（搜索 + 分页）
// ==========================================
app.get('/bookList', (req, res) => {
    if (req.session.user.role !== 'admin') return res.send('<script>alert("无权限");history.back()</script>')
    let page = parseInt(req.query.page) || 1
    let limit = 8
    let offset = (page - 1) * limit
    let keyword = req.query.keyword || ''
    let category = req.query.category || ''
    let sortBy = req.query.sort || 'id'

    // 构建查询条件
    let conditions = []
    let params = []

    if (keyword) {
        conditions.push('(book_name LIKE ? OR author LIKE ? OR isbn LIKE ?)')
        params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`)
    }

    if (category) {
        conditions.push('category = ?')
        params.push(category)
    }

    let whereClause = conditions.length > 0 ? 'WHERE ' + conditions.join(' AND ') : ''

    let countSql = `SELECT COUNT(*) AS total FROM book ${whereClause}`
    let dataSql = `SELECT * FROM book ${whereClause} ORDER BY ${sortBy} LIMIT ?,?`
    params.push(offset, limit)

    db.query(countSql, params.slice(0, -2), (err, count) => {
        if (err) {
            console.error(err)
            return res.send('数据库查询错误')
        }
        let total = count[0].total
        let totalPage = Math.ceil(total / limit)

        // 获取所有分类用于筛选
        db.query('SELECT DISTINCT category FROM book WHERE category IS NOT NULL', (err, categories) => {
            db.query(dataSql, params, (err, list) => {
                res.render('book', {
                    list,
                    page,
                    totalPage,
                    keyword,
                    category,
                    categories: categories || [],
                    sortBy,
                    user: req.session.user
                })
            })
        })
    })
})

// ==========================================
// 读者管理（搜索 + 分页）
// ==========================================
app.get('/readerList', (req, res) => {
    if (req.session.user.role !== 'admin') return res.send('<script>alert("无权限");history.back()</script>')
    let page = parseInt(req.query.page) || 1
    let limit = 8
    let offset = (page - 1) * limit
    let keyword = req.query.keyword || ''

    let conditions = []
    let params = []

    if (keyword) {
        conditions.push('(read_name LIKE ? OR student_id LIKE ? OR phone LIKE ?)')
        params.push(`%${keyword}%`, `%${keyword}%`, `%${keyword}%`)
    }

    let whereClause = conditions.length > 0 ? 'WHERE ' + conditions.join(' AND ') : ''

    let countSql = `SELECT COUNT(*) AS total FROM reader ${whereClause}`
    let dataSql = `SELECT * FROM reader ${whereClause} LIMIT ?,?`
    params.push(offset, limit)

    db.query(countSql, params.slice(0, -1), (err, count) => {
        if (err) {
            console.error(err)
            return res.send('数据库查询错误')
        }
        let total = count[0].total
        let totalPage = Math.ceil(total / limit)
        db.query(dataSql, params, (err, list) => {
            res.render('reader', { list, page, totalPage, keyword, user: req.session.user })
        })
    })
})

// ==========================================
// 借阅记录（搜索 + 分页）
// ==========================================
app.get('/borrowList', (req, res) => {
    if (req.session.user.role !== 'admin') return res.send('<script>alert("无权限");history.back()</script>')
    let page = parseInt(req.query.page) || 1
    let limit = 8
    let offset = (page - 1) * limit
    let keyword = req.query.keyword || ''
    let key = `%${keyword}%`

    let countSql = `
        SELECT COUNT(*) AS total FROM borrow br
        LEFT JOIN book b ON br.book_id = b.id
        LEFT JOIN reader r ON br.reader_id = r.id
        WHERE b.book_name LIKE ? OR r.read_name LIKE ?
    `
    let dataSql = `
        SELECT br.*, b.book_name, r.read_name FROM borrow br
        LEFT JOIN book b ON br.book_id = b.id
        LEFT JOIN reader r ON br.reader_id = r.id
        WHERE b.book_name LIKE ? OR r.read_name LIKE ?
        LIMIT ?,?
    `

    db.query(countSql, [key, key], (err, count) => {
        let total = count[0].total
        let totalPage = Math.ceil(total / limit)
        db.query(dataSql, [key, key, offset, limit], (err, list) => {
            res.render('borrow', { list, page, totalPage, keyword, user: req.session.user })
        })
    })
})

// ==========================================
// 还书功能
// ==========================================
app.get('/backBook', (req, res) => {
    if (req.session.user.role !== 'admin') return res.send('<script>alert("无权限");history.back()</script>')
    let id = req.query.id
    db.query('UPDATE borrow SET back_date=CURDATE() WHERE id=?', [id], () => {
        res.redirect('/borrowList')
    })
})

// ==========================================
// 图书 增删改查
// ==========================================
app.get('/addBookPage', (req, res) => {
    res.render('addBook', { user: req.session.user })
})
app.get('/addBook', (req, res) => {
    let { book_name, author, isbn, category, stock, description } = req.query
    stock = stock || 1
    db.query(`insert into book(book_name, author, isbn, category, stock, description) values(?,?,?,?,?,?)`,
        [book_name, author, isbn, category, stock, description], () => res.redirect('/bookList'))
})
app.get('/delBook', (req, res) => {
    let id = req.query.id
    db.query(`delete from book where id=?`, [id], () => res.redirect('/bookList'))
})
app.get('/editBookPage', (req, res) => {
    let id = req.query.id
    db.query("select * from book where id=?", [id], (err, data) => {
        res.render("editBook", { book: data[0], user: req.session.user })
    })
})
app.post('/updateBook', (req, res) => {
    let { id, book_name, author, isbn, category, stock, description } = req.body
    db.query("update book set book_name=?, author=?, isbn=?, category=?, stock=?, description=? where id=?",
        [book_name, author, isbn, category, stock, description, id], () => {
        res.redirect("/bookList")
    })
})

// ==========================================
// 读者 增删改查
// ==========================================
app.get('/addReaderPage', (req, res) => {
    res.render('addReader', { user: req.session.user })
})
app.get('/addReader', (req, res) => {
    let { read_name, student_id, phone, email } = req.query
    db.query(`insert into reader(read_name, student_id, phone, email) values(?,?,?,?)`,
        [read_name, student_id, phone, email], () => res.redirect('/readerList'))
})
app.get('/delReader', (req, res) => {
    let id = req.query.id
    db.query(`delete from reader where id=?`, [id], () => res.redirect('/readerList'))
})
app.get('/editReaderPage', (req, res) => {
    let id = req.query.id
    db.query("select * from reader where id=?", [id], (err, data) => {
        res.render("editReader", { reader: data[0], user: req.session.user })
    })
})
app.post('/updateReader', (req, res) => {
    let { id, read_name, student_id, phone, email } = req.body
    db.query("update reader set read_name=?, student_id=?, phone=?, email=? where id=?",
        [read_name, student_id, phone, email, id], () => {
        res.redirect("/readerList")
    })
})

// ==========================================
// 退出登录
// ==========================================
app.get('/logout', (req, res) => {
    req.session.destroy(() => res.redirect('/login'))
})

app.listen(port, () => {
    console.log('启动成功：http://localhost:3000/login')
})