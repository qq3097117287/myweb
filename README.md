# 智慧图书管理系统

一个基于 Node.js + Express + MySQL + EJS 的图书管理系统，适用于毕业设计项目。

## 功能特性

### 管理员功能
- 📊 数据概览：图书总数、读者总数、在借图书、已归还图书
- 📚 图书管理：增删改查，支持搜索、分类筛选、排序
- 👥 读者管理：增删改查，支持搜索
- 📖 借阅管理：查看借阅记录、归还图书

### 读者功能
- 📖 图书阅览：查看可借阅图书
- 📋 我的借阅：查看个人借阅记录

## 技术栈

- **后端**: Node.js + Express.js
- **数据库**: MySQL
- **模板引擎**: EJS
- **前端**: Bootstrap 5 + Bootstrap Icons
- **图表**: Chart.js

## 安装与运行

### 1. 环境要求
- Node.js (v14+)
- MySQL (v5.7+)

### 2. 数据库配置
1. 创建数据库 `db_library`
2. 执行 `update_db.sql` 创建表结构和示例数据

```bash
mysql -u root -p db_library < update_db.sql
```

### 3. 安装依赖
```bash
npm install
```

### 4. 配置数据库连接
编辑 `app.js` 中的数据库连接配置：
```javascript
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'your_password',  // 修改为你的密码
    database: 'db_library'
})
```

### 5. 运行项目
```bash
# 开发模式（使用nodemon）
npm run dev

# 生产模式
npm start
```

访问 http://localhost:3000/login

## 默认账号

### 管理员
- 用户名: admin
- 密码: admin123
- 身份: 系统管理员

### 读者
- 用户名: reader
- 密码: reader123
- 身份: 普通读者

## 项目结构

```
library/
├── app.js              # 主应用文件
├── db.js               # 数据库连接
├── package.json        # 项目配置
├── update_db.sql       # 数据库更新脚本
├── README.md           # 说明文档
└── views/              # EJS模板文件
    ├── adminIndex.ejs  # 管理员首页
    ├── readerIndex.ejs # 读者首页
    ├── login.ejs       # 登录页面
    ├── book.ejs        # 图书管理
    ├── reader.ejs      # 读者管理
    ├── borrow.ejs      # 借阅管理
    ├── myBorrow.ejs    # 我的借阅
    ├── addBook.ejs     # 添加图书
    ├── editBook.ejs    # 编辑图书
    ├── addReader.ejs   # 添加读者
    └── editReader.ejs  # 编辑读者
```

## 主要功能说明

### 图书管理
- 支持图书名称、作者、ISBN、分类、库存等信息
- 支持按书名、作者、ISBN搜索
- 支持按分类筛选
- 支持按书名、作者排序

### 读者管理
- 支持读者姓名、学号、电话、邮箱等信息
- 支持按姓名、学号、电话搜索

### 借阅管理
- 显示借阅记录（图书、借阅人、日期、状态）
- 支持归还操作
- 显示借阅状态（借阅中/已归还）

## 更新日志

### v2.0 (2024-06-08)
- ✨ 升级 Bootstrap 到 v5.3.2
- ✨ 改进整体视觉设计和配色方案
- ✨ 图书管理添加作者、ISBN、分类、库存等字段
- ✨ 读者管理添加学号、电话、邮箱等字段
- ✨ 添加数据可视化图表（Chart.js）
- ✨ 改进搜索和分页功能
- ✨ 优化移动端响应式设计

### v1.0 (2024-06-05)
- ✨ 基础图书管理功能
- ✨ 读者管理功能
- ✨ 借阅管理功能
- ✨ 管理员/读者双角色系统

## 许可证

ISC
