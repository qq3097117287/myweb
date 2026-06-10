const mysql = require('mysql2');
const db = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'db_library'
});
db.connect((err)=>{
    if(err) console.log("数据库连接失败")
    else console.log("数据库连接成功")
})
module.exports = db;