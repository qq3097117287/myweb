const mysql = require('mysql2');
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT, // 明确指定端口
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    ssl: {
        rejectUnauthorized: false // 暂时禁用证书验证
    },
    connectTimeout: 30000 // 关键：增加连接超时时间到 30 秒 (默认为 10 秒)
});
db.connect((err)=>{
    if(err) {
        console.error("数据库连接失败:", err); // 打印更详细的错误对象
    } else {
        console.log("数据库连接成功");
    }
})
module.exports = db;