/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : db_library

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 10/06/2026 21:38:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isbn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `stock` int(11) NULL DEFAULT 1,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '红楼梦', '曹雪芹', '9787211213811', '历史', 6, '中国古典四大名著之一');
INSERT INTO `book` VALUES (2, '西游记', '吴承恩', '9787911211811', '历史', 3, '中国古代神魔小说');
INSERT INTO `book` VALUES (3, '三国演义', '罗贯中', '9787911213211', '历史', 2, '历史演义小说');
INSERT INTO `book` VALUES (4, '计算机基础', '张明', '9787911263811', '科技', 3, '入门知识的课程');
INSERT INTO `book` VALUES (5, '网站建设与管理', '	李芳', '	9787911213811', '科技', 4, '日常运维的实践课程');
INSERT INTO `book` VALUES (6, 'Java程序设计', '王磊', '9787911213811', '科技', 2, '编程思想的入门与进阶课程');
INSERT INTO `book` VALUES (7, 'Linux服务器配置与管理', '周涛', '9787111213811', '科技', 4, '讲解 Linux 操作系统的安装、命令行操作及各类服务器');
INSERT INTO `book` VALUES (8, 'Windows服务器配置与管理', '	赵丽', '9787121213826', '科技', 5, '基于 Windows Server 系统，讲授域控制器、DNS、IIS 等服务的管理与维护');
INSERT INTO `book` VALUES (9, 'Java编程思想', 'Bruce Eckel', '9787111213826', '科技', 5, '经典Java编程教程');
INSERT INTO `book` VALUES (10, '三体', '刘慈欣', '9787536692930', '文学', 3, '科幻小说代表作');
INSERT INTO `book` VALUES (11, '人类简史', '尤瓦尔·赫拉利', '9787508647357', '历史', 2, '人类发展史概述');
INSERT INTO `book` VALUES (12, 'Java编程思想', 'Bruce Eckel', '9787111213826', '科技', 5, '经典Java编程教程');
INSERT INTO `book` VALUES (13, '三体', '刘慈欣', '9787536692930', '文学', 3, '科幻小说代表作');
INSERT INTO `book` VALUES (14, '人类简史', '尤瓦尔·赫拉利', '9787508647357', '历史', 2, '人类发展史概述');
INSERT INTO `book` VALUES (15, 'Python编程从入门到实践', 'Eric Matthes', '9787115428028', '科技', 4, 'Python入门经典');
INSERT INTO `book` VALUES (16, '活着', '余华', '9787506365437', '文学', 3, '当代文学经典');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NULL DEFAULT NULL,
  `reader_id` int(11) NULL DEFAULT NULL,
  `borrow_date` date NULL DEFAULT NULL,
  `back_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (1, 1, 1, '2025-01-01', '2026-06-05');
INSERT INTO `borrow` VALUES (2, 2, 2, '2025-02-01', '2025-03-01');
INSERT INTO `borrow` VALUES (3, 4, 2, '2026-06-05', NULL);
INSERT INTO `borrow` VALUES (4, 1, 2, '2026-06-05', '2026-06-05');
INSERT INTO `borrow` VALUES (5, 2, 2, '2026-06-05', NULL);
INSERT INTO `borrow` VALUES (6, 1, 1, '2026-06-05', NULL);
INSERT INTO `borrow` VALUES (7, 1, 1, '2024-05-01', '2024-05-15');
INSERT INTO `borrow` VALUES (8, 2, 2, '2024-05-10', NULL);
INSERT INTO `borrow` VALUES (9, 3, 1, '2024-05-20', NULL);
INSERT INTO `borrow` VALUES (10, 1, 1, '2024-05-01', '2024-05-15');
INSERT INTO `borrow` VALUES (11, 2, 2, '2024-05-10', NULL);
INSERT INTO `borrow` VALUES (12, 3, 1, '2024-05-20', NULL);

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `read_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES (1, 'Evis', '2021321', '13800138041', 'ZhangSan@example.com');
INSERT INTO `reader` VALUES (2, '小王', '2021312', '13800138070', 'LiSi@example.com');
INSERT INTO `reader` VALUES (3, 'Miss', '2021213', '13800138022', 'miss@example.com');
INSERT INTO `reader` VALUES (4, '张三', '2021001', '13800138001', 'zhangsan@example.com');
INSERT INTO `reader` VALUES (5, '李四', '2021002', '13800138002', 'lisi@example.com');
INSERT INTO `reader` VALUES (6, '老吴', '2021001', '13800138001', 'zhangsan@example.com');
INSERT INTO `reader` VALUES (7, '李三', '2021002', '13800138002', 'lisi@example.com');
INSERT INTO `reader` VALUES (8, '王五', '2021003', '13800138003', 'wangwu@example.com');
INSERT INTO `reader` VALUES (9, '李五', '2021001', '13800138001', 'zhangsan@example.com');
INSERT INTO `reader` VALUES (10, 'Acin', '2021002', '13800138002', 'lisi@example.com');
INSERT INTO `reader` VALUES (11, 'Pois', '2021003', '13800138003', 'wangwu@example.com');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '123456', 'admin');
INSERT INTO `sys_user` VALUES (2, 'user', '123456', 'reader');
INSERT INTO `sys_user` VALUES (3, 'admin', 'admin123', 'admin');
INSERT INTO `sys_user` VALUES (4, 'reader', 'reader123', 'reader');
INSERT INTO `sys_user` VALUES (5, 'admin', 'admin123', 'admin');
INSERT INTO `sys_user` VALUES (6, 'reader', 'reader123', 'reader');

SET FOREIGN_KEY_CHECKS = 1;
