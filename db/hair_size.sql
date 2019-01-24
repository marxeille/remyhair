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

 Date: 20/11/2018 12:42:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hair_size
-- ----------------------------
DROP TABLE IF EXISTS `hair_size`;
CREATE TABLE `hair_size`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_size
-- ----------------------------
INSERT INTO `hair_size` VALUES (3, '4\" (10cm)', '2018-11-09 15:05:53', '2018-11-09 15:05:53');
INSERT INTO `hair_size` VALUES (4, '6\" (15cm)', '2018-11-09 15:06:04', '2018-11-09 15:06:04');
INSERT INTO `hair_size` VALUES (5, '8\" (20cm)', '2018-11-09 15:06:10', '2018-11-09 15:06:10');
INSERT INTO `hair_size` VALUES (6, '10\" (25cm)', '2018-11-09 15:06:16', '2018-11-09 15:06:16');
INSERT INTO `hair_size` VALUES (7, '12\" (30cm)', '2018-11-09 15:06:47', '2018-11-09 15:06:47');
INSERT INTO `hair_size` VALUES (8, '14\" (35cm)', '2018-11-09 15:06:52', '2018-11-09 15:06:52');
INSERT INTO `hair_size` VALUES (9, '16\" (40cm)', '2018-11-09 15:07:00', '2018-11-09 15:07:00');
INSERT INTO `hair_size` VALUES (10, '18\" (45cm)', '2018-11-09 15:07:07', '2018-11-09 15:07:07');
INSERT INTO `hair_size` VALUES (11, '20\" (50cm)', '2018-11-09 15:07:13', '2018-11-09 15:07:13');
INSERT INTO `hair_size` VALUES (12, '22\" (55cm)', '2018-11-09 15:07:20', '2018-11-09 15:07:20');
INSERT INTO `hair_size` VALUES (13, '24\" (60cm)', '2018-11-09 15:07:26', '2018-11-09 15:07:26');
INSERT INTO `hair_size` VALUES (14, '26\" (65cm)', '2018-11-09 15:07:31', '2018-11-09 15:07:31');
INSERT INTO `hair_size` VALUES (15, '28\" (70cm)', '2018-11-09 15:07:41', '2018-11-09 15:07:41');
INSERT INTO `hair_size` VALUES (16, '30\" (75cm)', '2018-11-09 15:07:51', '2018-11-09 15:07:51');
INSERT INTO `hair_size` VALUES (17, '32\" (80cm)', '2018-11-09 15:07:58', '2018-11-09 15:07:58');
INSERT INTO `hair_size` VALUES (18, '34\" (85cm)', '2018-11-09 15:08:04', '2018-11-09 15:08:04');
INSERT INTO `hair_size` VALUES (19, '36\" (90cm)', '2018-11-09 15:14:32', '2018-11-09 15:14:32');
INSERT INTO `hair_size` VALUES (20, '38\" (95cm)', '2018-11-09 15:14:37', '2018-11-09 15:14:37');
INSERT INTO `hair_size` VALUES (21, '40\" (100cm)', '2018-11-09 15:14:42', '2018-11-09 15:14:42');

SET FOREIGN_KEY_CHECKS = 1;
