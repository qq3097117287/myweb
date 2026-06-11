-- 更新图书表结构
ALTER TABLE book ADD COLUMN author VARCHAR(100) DEFAULT NULL;
ALTER TABLE book ADD COLUMN isbn VARCHAR(20) DEFAULT NULL;
ALTER TABLE book ADD COLUMN category VARCHAR(50) DEFAULT NULL;
ALTER TABLE book ADD COLUMN stock INT DEFAULT 1;
ALTER TABLE book ADD COLUMN description TEXT DEFAULT NULL;

-- 更新读者表结构
ALTER TABLE reader ADD COLUMN student_id VARCHAR(20) DEFAULT NULL;
ALTER TABLE reader ADD COLUMN phone VARCHAR(20) DEFAULT NULL;
ALTER TABLE reader ADD COLUMN email VARCHAR(100) DEFAULT NULL;

-- 添加示例数据（可选）
INSERT INTO book (book_name, author, isbn, category, stock, description) VALUES
('Java编程思想', 'Bruce Eckel', '9787111213826', '科技', 5, '经典Java编程教程'),
('三体', '刘慈欣', '9787536692930', '文学', 3, '科幻小说代表作'),
('人类简史', '尤瓦尔·赫拉利', '9787508647357', '历史', 2, '人类发展史概述');

INSERT INTO reader (read_name, student_id, phone, email) VALUES
('张三', '2021001', '13800138001', 'zhangsan@example.com'),
('李四', '2021002', '13800138002', 'lisi@example.com');
