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

 Date: 20/11/2018 12:42:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hair_type
-- ----------------------------
DROP TABLE IF EXISTS `hair_type`;
CREATE TABLE `hair_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `export_type` enum('WEFT','CLOSURE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_type
-- ----------------------------
INSERT INTO `hair_type` VALUES (3, 'WEFT', '2018-11-09 15:23:06', '2018-11-09 15:23:06', 'WEFT');
INSERT INTO `hair_type` VALUES (4, 'WEFT REMY', '2018-11-09 15:23:11', '2018-11-09 15:23:11', 'WEFT');
INSERT INTO `hair_type` VALUES (5, 'BULK', '2018-11-09 15:23:16', '2018-11-09 15:23:16', 'WEFT');
INSERT INTO `hair_type` VALUES (6, 'BULK REMY', '2018-11-09 15:23:21', '2018-11-09 15:23:21', 'WEFT');
INSERT INTO `hair_type` VALUES (7, 'CLOSURE 4X4', '2018-11-09 15:23:27', '2018-11-09 15:23:27', 'CLOSURE');
INSERT INTO `hair_type` VALUES (8, 'CLOSURE 5X5', '2018-11-09 15:23:32', '2018-11-09 15:23:32', 'CLOSURE');
INSERT INTO `hair_type` VALUES (9, 'CLOSURE 7X4', '2018-11-09 15:23:37', '2018-11-09 15:23:37', 'CLOSURE');
INSERT INTO `hair_type` VALUES (10, 'CLOSURE 2X6', '2018-11-09 15:23:42', '2018-11-09 15:23:42', 'CLOSURE');
INSERT INTO `hair_type` VALUES (11, 'CLOSURE 2X4', '2018-11-09 15:23:48', '2018-11-09 15:23:48', 'CLOSURE');
INSERT INTO `hair_type` VALUES (12, 'CLOSURE 6X6', '2018-11-09 15:23:53', '2018-11-09 15:23:53', 'CLOSURE');
INSERT INTO `hair_type` VALUES (13, 'CLOSURE 2X5', '2018-11-09 15:23:59', '2018-11-09 15:23:59', 'CLOSURE');
INSERT INTO `hair_type` VALUES (14, 'CLOSURE 4X6', '2018-11-09 15:24:04', '2018-11-09 15:24:04', 'CLOSURE');
INSERT INTO `hair_type` VALUES (15, 'CLOSURE 2X7', '2018-11-09 15:24:09', '2018-11-09 15:24:09', 'CLOSURE');
INSERT INTO `hair_type` VALUES (16, 'CLOSURE 3X6', '2018-11-09 15:24:15', '2018-11-09 15:24:15', 'CLOSURE');
INSERT INTO `hair_type` VALUES (17, 'CLOSURE 5X4', '2018-11-09 15:24:20', '2018-11-09 15:24:20', 'CLOSURE');
INSERT INTO `hair_type` VALUES (18, 'CLOSURE 10X5', '2018-11-09 15:24:25', '2018-11-09 15:24:25', 'CLOSURE');
INSERT INTO `hair_type` VALUES (19, 'CLOSURE 7X5', '2018-11-09 15:24:30', '2018-11-09 15:24:30', 'CLOSURE');
INSERT INTO `hair_type` VALUES (20, 'FRONTAL 13X4', '2018-11-09 15:24:34', '2018-11-09 15:24:34', 'CLOSURE');
INSERT INTO `hair_type` VALUES (21, 'FRONTAL 13X6', '2018-11-09 15:24:40', '2018-11-09 15:24:40', 'CLOSURE');
INSERT INTO `hair_type` VALUES (22, 'FRONTAL 13X2', '2018-11-09 15:24:45', '2018-11-09 15:24:45', 'CLOSURE');
INSERT INTO `hair_type` VALUES (23, 'CLOSURE 6X4', '2018-11-09 15:24:51', '2018-11-09 15:24:51', 'CLOSURE');

SET FOREIGN_KEY_CHECKS = 1;
