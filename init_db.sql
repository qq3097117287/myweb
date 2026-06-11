-- 创建数据库
CREATE DATABASE IF NOT EXISTS db_library;
USE db_library;

-- 创建图书表
CREATE TABLE IF NOT EXISTS book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author VARCHAR(100) DEFAULT NULL,
    isbn VARCHAR(20) DEFAULT NULL,
    category VARCHAR(50) DEFAULT NULL,
    stock INT DEFAULT 1,
    description TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建读者表
CREATE TABLE IF NOT EXISTS reader (
    id INT AUTO_INCREMENT PRIMARY KEY,
    read_name VARCHAR(100) NOT NULL,
    student_id VARCHAR(20) DEFAULT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建借阅记录表
CREATE TABLE IF NOT EXISTS borrow (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    reader_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    back_date DATE DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    FOREIGN KEY (reader_id) REFERENCES reader(id) ON DELETE CASCADE
);

-- 创建用户表（用于登录）
CREATE TABLE IF NOT EXISTS sys_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 插入示例数据
-- 图书数据
INSERT INTO book (book_name, author, isbn, category, stock, description) VALUES
('Java编程思想', 'Bruce Eckel', '9787111213826', '科技', 5, '经典Java编程教程'),
('三体', '刘慈欣', '9787536692930', '文学', 3, '科幻小说代表作'),
('人类简史', '尤瓦尔·赫拉利', '9787508647357', '历史', 2, '人类发展史概述'),
('Python编程从入门到实践', 'Eric Matthes', '9787115428028', '科技', 4, 'Python入门经典'),
('活着', '余华', '9787506365437', '文学', 3, '当代文学经典');

-- 读者数据
INSERT INTO reader (read_name, student_id, phone, email) VALUES
('张三', '2021001', '13800138001', 'zhangsan@example.com'),
('李四', '2021002', '13800138002', 'lisi@example.com'),
('王五', '2021003', '13800138003', 'wangwu@example.com');

-- 用户数据（密码均为123456，实际使用时应加密存储）
INSERT INTO sys_user (username, password, role) VALUES
('admin', 'admin123', 'admin'),
('reader', 'reader123', 'reader');

-- 插入示例借阅记录
INSERT INTO borrow (book_id, reader_id, borrow_date, back_date) VALUES
(1, 1, '2024-05-01', '2024-05-15'),
(2, 2, '2024-05-10', NULL),
(3, 1, '2024-05-20', NULL);
