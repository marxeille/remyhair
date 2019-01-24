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

 Date: 20/11/2018 12:42:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hair_style
-- ----------------------------
DROP TABLE IF EXISTS `hair_style`;
CREATE TABLE `hair_style`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `id_color` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `export` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_style
-- ----------------------------
INSERT INTO `hair_style` VALUES (3, 'STRAIGHT', '2018-11-09 15:15:10', '2018-11-09 15:15:10', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', 1);
INSERT INTO `hair_style` VALUES (4, 'NATURAL WAVY', '2018-11-09 15:15:17', '2018-11-09 15:15:17', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', 1);
INSERT INTO `hair_style` VALUES (5, 'NW1', '2018-11-09 15:15:24', '2018-11-09 15:15:24', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', 1);
INSERT INTO `hair_style` VALUES (6, 'NW3', '2018-11-09 15:15:32', '2018-11-09 15:15:32', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', 1);
INSERT INTO `hair_style` VALUES (7, 'BG8NK', '2018-11-09 15:15:37', '2018-11-09 15:15:37', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', 1);
INSERT INTO `hair_style` VALUES (8, 'SC1', '2018-11-09 15:15:42', '2018-11-09 15:15:42', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (9, 'SC2', '2018-11-09 15:15:47', '2018-11-09 15:15:47', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (10, 'SC3', '2018-11-09 15:15:55', '2018-11-09 15:15:55', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (11, 'SC4', '2018-11-09 15:16:01', '2018-11-09 15:16:01', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (12, 'SF1', '2018-11-09 15:16:15', '2018-11-09 15:16:15', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (13, 'SF2', '2018-11-09 15:16:21', '2018-11-09 15:16:21', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (14, 'SF3', '2018-11-09 15:16:26', '2018-11-09 15:16:26', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (15, 'SF4', '2018-11-09 15:16:31', '2018-11-09 15:16:31', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (16, 'SF5', '2018-11-09 15:16:38', '2018-11-09 15:16:38', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (17, 'SF6', '2018-11-09 15:16:47', '2018-11-09 15:16:47', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (18, 'SF7', '2018-11-09 15:16:54', '2018-11-09 15:16:54', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (19, 'SW1', '2018-11-09 15:17:08', '2018-11-09 15:17:08', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (20, 'SW2', '2018-11-09 15:17:12', '2018-11-09 15:17:12', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (21, 'SW3', '2018-11-09 15:20:15', '2018-11-09 15:20:15', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (22, 'SW4', '2018-11-09 15:20:24', '2018-11-09 15:20:24', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (23, 'SW5', '2018-11-09 15:20:29', '2018-11-09 15:20:29', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (24, 'SW6', '2018-11-09 15:20:35', '2018-11-09 15:20:35', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (25, 'SW7', '2018-11-09 15:20:40', '2018-11-09 15:20:40', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);
INSERT INTO `hair_style` VALUES (26, 'OTHER STEAM', '2018-11-09 15:20:52', '2018-11-09 15:20:52', '[\"3\",\"4\",\"5\",\"6\",\"7\"]', NULL);

SET FOREIGN_KEY_CHECKS = 1;
