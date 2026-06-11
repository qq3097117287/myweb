const mysql = require('mysql2');
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT, // 新增：明确指定端口
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,  // 这里已经改成你的密码
    database: process.env.DB_DATABASE,
    ssl: {
        rejectUnauthorized: false // 暂时禁用证书验证
    }
});
db.connect((err)=>{
    if(err) console.log("数据库连接失败")
    else console.log("数据库连接成功")
})
module.exports = db;