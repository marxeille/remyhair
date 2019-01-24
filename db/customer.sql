/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 100135
 Source Host           : localhost:3306
 Source Schema         : remy_hair_live

 Target Server Type    : MySQL
 Target Server Version : 100135
 File Encoding         : 65001

 Date: 21/11/2018 20:12:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_special_customer` tinyint(4) NOT NULL DEFAULT 0,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Normal',
  `customer_balance` double(8, 2) NOT NULL DEFAULT 0.00,
  `status` enum('Ordered','Supporting','New') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'New',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id_employee_index`(`id_employee`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (132, 3, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 31.94, 'New', '2018-11-05 23:03:46', '2018-11-10 10:21:16', NULL);
INSERT INTO `customer` VALUES (133, 3, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-06 08:51:56', '2018-11-06 08:51:56', NULL);
INSERT INTO `customer` VALUES (134, 4, 'laura', '+1234556789', 0, 'a@gmail.com', 'good', 2.00, 'Ordered', '2018-11-09 10:52:03', '2018-11-12 12:08:53', NULL);
INSERT INTO `customer` VALUES (135, 4, 'Renisha Usa 7150', '+1 (901) 652-7150', 0, 'Jack@gmail.com', 'Good', 0.00, 'Ordered', '2018-11-09 11:08:09', '2018-11-09 11:08:09', NULL);
INSERT INTO `customer` VALUES (136, 4, 'Shay Ray Usa7998', '+1 (901) 496-7998', 0, 'Jack@gmail.com', 'Good', 0.00, 'Ordered', '2018-11-09 11:08:09', '2018-11-09 11:08:09', NULL);
INSERT INTO `customer` VALUES (137, 4, 'Nicole Usa 4965', '+1 (817) 448-4965', 0, 'Jack@gmail.com', 'Good', 25.00, 'Ordered', '2018-11-09 11:08:09', '2018-11-10 10:31:02', NULL);
INSERT INTO `customer` VALUES (138, 4, 'Netherland_David', '+31 6 31688258', 0, 'Patterntexture@gmail.com', 'best', 0.00, 'Ordered', '2018-11-10 09:57:45', '2018-11-10 09:57:45', NULL);
INSERT INTO `customer` VALUES (139, 4, 'CHINH TEST', '+19016527150', 0, 'Jack@gmail.com', 'Best', 0.00, 'Ordered', '2018-11-12 08:30:15', '2018-11-12 08:30:15', NULL);
INSERT INTO `customer` VALUES (140, 4, 'CHINH TEST', '+19016527153', 0, 'Jack@gmail.com', 'Best', 0.00, 'Supporting', '2018-11-12 08:30:15', '2018-11-12 08:30:15', NULL);
INSERT INTO `customer` VALUES (141, 4, 'a', '12345678911', 0, 'a@gmail.com', 'Best', 0.00, 'Ordered', '2018-11-12 09:08:36', '2018-11-12 09:08:36', NULL);
INSERT INTO `customer` VALUES (142, 4, 'b', '12345678922', 0, 'Jack@gmail.com', 'Good', 0.00, 'Ordered', '2018-11-12 09:08:36', '2018-11-12 09:08:36', NULL);
INSERT INTO `customer` VALUES (143, 4, 'c', '12345678933', 0, '', 'Normal', 0.00, 'Supporting', '2018-11-12 09:08:36', '2018-11-12 09:08:36', NULL);
INSERT INTO `customer` VALUES (144, 4, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-13 15:37:06', '2018-11-13 15:37:06', NULL);
INSERT INTO `customer` VALUES (145, 4, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-13 15:38:07', '2018-11-13 15:38:07', NULL);
INSERT INTO `customer` VALUES (146, 4, 'cuongnp', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-13 15:38:49', '2018-11-13 15:38:49', NULL);
INSERT INTO `customer` VALUES (147, 18, 'anh son', '112312312', 0, '12312@gmail.com', 'normal', 0.00, 'New', '2018-11-13 15:38:49', '2018-11-13 15:38:49', NULL);
INSERT INTO `customer` VALUES (148, 3, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-13 15:44:43', '2018-11-13 15:44:43', NULL);
INSERT INTO `customer` VALUES (149, 3, 'nguyen van a', '123456789', 0, 'dfgfg@fd.com', 'normal', 0.00, 'New', '2018-11-13 15:44:55', '2018-11-13 15:44:55', NULL);
INSERT INTO `customer` VALUES (150, 7, 'test 1', '+1 (347) 884-5740', 0, '', 'Best', 0.00, 'Ordered', '2018-11-14 09:32:13', '2018-11-14 09:32:13', NULL);
INSERT INTO `customer` VALUES (151, 7, 'test 2', '2348030978907', 0, '', 'Good', 0.00, 'New', '2018-11-14 09:32:13', '2018-11-14 09:32:13', NULL);
INSERT INTO `customer` VALUES (152, 7, 'test 3', '+1Â (213)Â 263-7272', 0, '', 'Normal', 0.00, 'Supporting', '2018-11-14 09:32:13', '2018-11-14 09:32:13', NULL);
INSERT INTO `customer` VALUES (153, 12, 'R_21.1.18_Mr.H_UK_Whitney', '+44 7446 165147', 0, 'vnremyhair9@gmail.com', 'normal', 0.00, 'Supporting', '2018-11-14 10:50:22', '2018-11-17 10:21:37', NULL);
INSERT INTO `customer` VALUES (154, 3, 'fsdf', '23432543543', 0, 'sfdsf@dsfs.com', 'normal', 0.00, 'Ordered', '2018-11-15 23:14:18', '2018-11-15 23:14:18', NULL);

SET FOREIGN_KEY_CHECKS = 1;
