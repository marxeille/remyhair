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

 Date: 24/11/2018 20:41:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for work_profile
-- ----------------------------
DROP TABLE IF EXISTS `work_profile`;
CREATE TABLE `work_profile`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `id_leader` int(10) UNSIGNED NOT NULL,
  `id_work_category` int(10) UNSIGNED NOT NULL,
  `id_procedure` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `case` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `experience` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `hard` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `need_change` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `leader_suggesstion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `leader_edited_at` date NULL DEFAULT NULL,
  `id_status` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `date_reslove` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_profile_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `work_profile_id_leader_index`(`id_leader`) USING BTREE,
  INDEX `work_profile_id_work_category_index`(`id_work_category`) USING BTREE,
  INDEX `work_profile_id_procedure_index`(`id_procedure`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of work_profile
-- ----------------------------
INSERT INTO `work_profile` VALUES (1, 1, 1, 1, 1, 'aaa', 'gfdg', 'gfdg', 'gfdg', 'gfdgf', 'fdgfdgf', NULL, '2018-09-25', 1, '2018-09-25 17:29:02', '2018-09-25 17:29:51', NULL);
INSERT INTO `work_profile` VALUES (2, 1, 1, 1, 6, 'Work profile 1', NULL, NULL, NULL, NULL, NULL, NULL, '2018-09-27', 18, '2018-09-26 21:01:42', '2018-09-27 22:50:21', NULL);
INSERT INTO `work_profile` VALUES (3, 1, 1, 1, 6, 'Work profile 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, '2018-09-26 21:01:57', '2018-09-30 08:50:46', NULL);
INSERT INTO `work_profile` VALUES (4, 1, 1, 1, 6, 'Work profile 3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '2018-09-26 21:02:09', '2018-09-27 22:50:15', NULL);
INSERT INTO `work_profile` VALUES (5, 1, 1, 1, 6, 'gfdgfdg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, '2018-09-26 22:40:48', '2018-09-27 22:46:01', NULL);
INSERT INTO `work_profile` VALUES (6, 3, 3, 1, 6, 'Work Profile 01', 'Test case 01', 'good', 'very much', 'Hard', 'More', NULL, NULL, 18, '2018-09-30 20:44:07', '2018-11-20 14:18:36', NULL);
INSERT INTO `work_profile` VALUES (7, 3, 4, 1, 6, 'Work profile 2', 'Work profile 2', 'result 1', NULL, NULL, NULL, NULL, NULL, 10, '2018-10-29 09:38:57', '2018-11-21 05:35:36', NULL);
INSERT INTO `work_profile` VALUES (8, 3, 3, 1, 6, 'A7CF-T18-delivery-note-2', 'test', 'test', 'test', 'test', 'test', 'Huyen Trang', NULL, 9, '2018-11-06 02:29:56', '2018-11-24 20:38:47', NULL);
INSERT INTO `work_profile` VALUES (9, 3, 3, 1, 6, 'test work profile', 'test', 'test', 'test', 'test', 'test', NULL, NULL, 20, '2018-11-06 02:31:35', '2018-11-06 02:44:38', NULL);
INSERT INTO `work_profile` VALUES (10, 3, 7, 1, 6, 'EM MUỐN...', 'Cảm thấy vô dụng...', NULL, 'Thế em muốn như thế nào ?', 'Muốn lắm nhưng éo làm gì được...', 'Cháy hết mình', NULL, NULL, 18, '2018-11-09 15:18:57', '2018-11-10 08:34:37', NULL);
INSERT INTO `work_profile` VALUES (11, 9, 7, 1, 6, 'van-complaint', 'hair tangle - Củ chuối - US', 'ok con ga den', 'fffffffffff', NULL, NULL, NULL, NULL, 9, '2018-11-15 09:01:37', '2018-11-20 14:18:29', NULL);
INSERT INTO `work_profile` VALUES (12, 6, 6, 1, 6, 'doing something', 'doing something', 'doing something', 'doing something', 'doing something', 'doing something', NULL, NULL, 10, '2018-11-21 05:08:54', '2018-11-21 08:39:16', NULL);
INSERT INTO `work_profile` VALUES (13, 3, 20, 3, 6, 'Test Workcategories 01', 'dfd', NULL, NULL, NULL, NULL, 'remy hisdhlkfgfkdja', NULL, 8, '2018-11-23 18:20:00', '2018-11-23 21:42:06', NULL);

SET FOREIGN_KEY_CHECKS = 1;
