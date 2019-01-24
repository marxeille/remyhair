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

 Date: 16/01/2019 09:52:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) UNSIGNED NOT NULL,
  `id_country` int(10) UNSIGNED NOT NULL,
  `id_state` int(10) UNSIGNED NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `address_id_customer_index`(`id_customer`) USING BTREE,
  INDEX `address_id_country_index`(`id_country`) USING BTREE,
  INDEX `address_id_state_index`(`id_state`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for carrier
-- ----------------------------
DROP TABLE IF EXISTS `carrier`;
CREATE TABLE `carrier`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of carrier
-- ----------------------------
INSERT INTO `carrier` VALUES (1, 'UPS', NULL, NULL);
INSERT INTO `carrier` VALUES (2, 'DHL', NULL, NULL);
INSERT INTO `carrier` VALUES (3, 'BANGDA', NULL, NULL);
INSERT INTO `carrier` VALUES (4, 'EMS', NULL, NULL);
INSERT INTO `carrier` VALUES (5, 'FEDEX', NULL, NULL);
INSERT INTO `carrier` VALUES (6, 'CARGO', NULL, NULL);
INSERT INTO `carrier` VALUES (7, 'OTHER', NULL, NULL);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_carrier` int(11) NULL DEFAULT NULL,
  `id_customer` int(11) NULL DEFAULT NULL,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `id_address` int(11) NULL DEFAULT NULL,
  `shipping_cost` decimal(8, 2) NULL DEFAULT NULL,
  `discount` decimal(8, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `payment_fee` decimal(8, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_id_carrier_index`(`id_carrier`) USING BTREE,
  INDEX `cart_id_customer_index`(`id_customer`) USING BTREE,
  INDEX `cart_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `cart_id_address_index`(`id_address`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, NULL, NULL, 0, NULL, NULL, NULL, '2019-01-16 09:39:55', '2019-01-16 09:39:55', NULL);
INSERT INTO `cart` VALUES (2, NULL, NULL, 0, NULL, NULL, NULL, '2019-01-16 09:39:55', '2019-01-16 09:39:55', NULL);
INSERT INTO `cart` VALUES (3, 1, NULL, 3, NULL, NULL, NULL, '2019-01-16 09:39:55', '2019-01-16 09:39:55', NULL);
INSERT INTO `cart` VALUES (4, 1, NULL, 3, NULL, NULL, NULL, '2019-01-16 09:51:55', '2019-01-16 09:51:55', NULL);

-- ----------------------------
-- Table structure for cart_product
-- ----------------------------
DROP TABLE IF EXISTS `cart_product`;
CREATE TABLE `cart_product`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) UNSIGNED NOT NULL,
  `kg` decimal(8, 2) NOT NULL,
  `price` double(8, 2) NOT NULL,
  `id_hair_size` int(10) UNSIGNED NOT NULL,
  `id_hair_type` int(10) UNSIGNED NOT NULL,
  `id_hair_color` int(10) UNSIGNED NOT NULL,
  `id_hair_draw` int(10) UNSIGNED NOT NULL,
  `id_hair_style` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `total_price` decimal(20, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_product_id_cart_index`(`id_cart`) USING BTREE,
  INDEX `cart_product_id_hair_size_index`(`id_hair_size`) USING BTREE,
  INDEX `cart_product_id_hair_type_index`(`id_hair_type`) USING BTREE,
  INDEX `cart_product_id_hair_color_index`(`id_hair_color`) USING BTREE,
  INDEX `cart_product_id_hair_draw_index`(`id_hair_draw`) USING BTREE,
  INDEX `cart_product_id_hair_style_index`(`id_hair_style`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for cart_product_image
-- ----------------------------
DROP TABLE IF EXISTS `cart_product_image`;
CREATE TABLE `cart_product_image`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cart_product` int(10) UNSIGNED NOT NULL,
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_product_image_id_cart_product_index`(`id_cart_product`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for complain
-- ----------------------------
DROP TABLE IF EXISTS `complain`;
CREATE TABLE `complain`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `id_support` int(255) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `phonecode` int(11) NULL DEFAULT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 247 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO `country` VALUES (1, 'Afghanistan', NULL, NULL, 93, 'AF');
INSERT INTO `country` VALUES (2, 'Albania', NULL, NULL, 355, 'AL');
INSERT INTO `country` VALUES (3, 'Algeria', NULL, NULL, 213, 'DZ');
INSERT INTO `country` VALUES (4, 'American Samoa', NULL, NULL, 1684, 'AS');
INSERT INTO `country` VALUES (5, 'Andorra', NULL, NULL, 376, 'AD');
INSERT INTO `country` VALUES (6, 'Angola', NULL, NULL, 244, 'AO');
INSERT INTO `country` VALUES (7, 'Anguilla', NULL, NULL, 1264, 'AI');
INSERT INTO `country` VALUES (8, 'Antarctica', NULL, NULL, 0, 'AQ');
INSERT INTO `country` VALUES (9, 'Antigua And Barbuda', NULL, NULL, 1268, 'AG');
INSERT INTO `country` VALUES (10, 'Argentina', NULL, NULL, 54, 'AR');
INSERT INTO `country` VALUES (11, 'Armenia', NULL, NULL, 374, 'AM');
INSERT INTO `country` VALUES (12, 'Aruba', NULL, NULL, 297, 'AW');
INSERT INTO `country` VALUES (13, 'Australia', NULL, NULL, 61, 'AU');
INSERT INTO `country` VALUES (14, 'Austria', NULL, NULL, 43, 'AT');
INSERT INTO `country` VALUES (15, 'Azerbaijan', NULL, NULL, 994, 'AZ');
INSERT INTO `country` VALUES (16, 'Bahamas The', NULL, NULL, 1242, 'BS');
INSERT INTO `country` VALUES (17, 'Bahrain', NULL, NULL, 973, 'BH');
INSERT INTO `country` VALUES (18, 'Bangladesh', NULL, NULL, 880, 'BD');
INSERT INTO `country` VALUES (19, 'Barbados', NULL, NULL, 1246, 'BB');
INSERT INTO `country` VALUES (20, 'Belarus', NULL, NULL, 375, 'BY');
INSERT INTO `country` VALUES (21, 'Belgium', NULL, NULL, 32, 'BE');
INSERT INTO `country` VALUES (22, 'Belize', NULL, NULL, 501, 'BZ');
INSERT INTO `country` VALUES (23, 'Benin', NULL, NULL, 229, 'BJ');
INSERT INTO `country` VALUES (24, 'Bermuda', NULL, NULL, 1441, 'BM');
INSERT INTO `country` VALUES (25, 'Bhutan', NULL, NULL, 975, 'BT');
INSERT INTO `country` VALUES (26, 'Bolivia', NULL, NULL, 591, 'BO');
INSERT INTO `country` VALUES (27, 'Bosnia and Herzegovina', NULL, NULL, 387, 'BA');
INSERT INTO `country` VALUES (28, 'Botswana', NULL, NULL, 267, 'BW');
INSERT INTO `country` VALUES (29, 'Bouvet Island', NULL, NULL, 0, 'BV');
INSERT INTO `country` VALUES (30, 'Brazil', NULL, NULL, 55, 'BR');
INSERT INTO `country` VALUES (31, 'British Indian Ocean Territory', NULL, NULL, 246, 'IO');
INSERT INTO `country` VALUES (32, 'Brunei', NULL, NULL, 673, 'BN');
INSERT INTO `country` VALUES (33, 'Bulgaria', NULL, NULL, 359, 'BG');
INSERT INTO `country` VALUES (34, 'Burkina Faso', NULL, NULL, 226, 'BF');
INSERT INTO `country` VALUES (35, 'Burundi', NULL, NULL, 257, 'BI');
INSERT INTO `country` VALUES (36, 'Cambodia', NULL, NULL, 855, 'KH');
INSERT INTO `country` VALUES (37, 'Cameroon', NULL, NULL, 237, 'CM');
INSERT INTO `country` VALUES (38, 'Canada', NULL, NULL, 1, 'CA');
INSERT INTO `country` VALUES (39, 'Cape Verde', NULL, NULL, 238, 'CV');
INSERT INTO `country` VALUES (40, 'Cayman Islands', NULL, NULL, 1345, 'KY');
INSERT INTO `country` VALUES (41, 'Central African Republic', NULL, NULL, 236, 'CF');
INSERT INTO `country` VALUES (42, 'Chad', NULL, NULL, 235, 'TD');
INSERT INTO `country` VALUES (43, 'Chile', NULL, NULL, 56, 'CL');
INSERT INTO `country` VALUES (44, 'China', NULL, NULL, 86, 'CN');
INSERT INTO `country` VALUES (45, 'Christmas Island', NULL, NULL, 61, 'CX');
INSERT INTO `country` VALUES (46, 'Cocos (Keeling) Islands', NULL, NULL, 672, 'CC');
INSERT INTO `country` VALUES (47, 'Colombia', NULL, NULL, 57, 'CO');
INSERT INTO `country` VALUES (48, 'Comoros', NULL, NULL, 269, 'KM');
INSERT INTO `country` VALUES (49, 'Congo', NULL, NULL, 242, 'CG');
INSERT INTO `country` VALUES (50, 'Congo The Democratic Republic Of The', NULL, NULL, 242, 'CD');
INSERT INTO `country` VALUES (51, 'Cook Islands', NULL, NULL, 682, 'CK');
INSERT INTO `country` VALUES (52, 'Costa Rica', NULL, NULL, 506, 'CR');
INSERT INTO `country` VALUES (53, 'Cote D Ivoire (Ivory Coast)', NULL, NULL, 225, 'CI');
INSERT INTO `country` VALUES (54, 'Croatia (Hrvatska)', NULL, NULL, 385, 'HR');
INSERT INTO `country` VALUES (55, 'Cuba', NULL, NULL, 53, 'CU');
INSERT INTO `country` VALUES (56, 'Cyprus', NULL, NULL, 357, 'CY');
INSERT INTO `country` VALUES (57, 'Czech Republic', NULL, NULL, 420, 'CZ');
INSERT INTO `country` VALUES (58, 'Denmark', NULL, NULL, 45, 'DK');
INSERT INTO `country` VALUES (59, 'Djibouti', NULL, NULL, 253, 'DJ');
INSERT INTO `country` VALUES (60, 'Dominica', NULL, NULL, 1767, 'DM');
INSERT INTO `country` VALUES (61, 'Dominican Republic', NULL, NULL, 1809, 'DO');
INSERT INTO `country` VALUES (62, 'East Timor', NULL, NULL, 670, 'TP');
INSERT INTO `country` VALUES (63, 'Ecuador', NULL, NULL, 593, 'EC');
INSERT INTO `country` VALUES (64, 'Egypt', NULL, NULL, 20, 'EG');
INSERT INTO `country` VALUES (65, 'El Salvador', NULL, NULL, 503, 'SV');
INSERT INTO `country` VALUES (66, 'Equatorial Guinea', NULL, NULL, 240, 'GQ');
INSERT INTO `country` VALUES (67, 'Eritrea', NULL, NULL, 291, 'ER');
INSERT INTO `country` VALUES (68, 'Estonia', NULL, NULL, 372, 'EE');
INSERT INTO `country` VALUES (69, 'Ethiopia', NULL, NULL, 251, 'ET');
INSERT INTO `country` VALUES (70, 'External Territories of Australia', NULL, NULL, 61, 'XA');
INSERT INTO `country` VALUES (71, 'Falkland Islands', NULL, NULL, 500, 'FK');
INSERT INTO `country` VALUES (72, 'Faroe Islands', NULL, NULL, 298, 'FO');
INSERT INTO `country` VALUES (73, 'Fiji Islands', NULL, NULL, 679, 'FJ');
INSERT INTO `country` VALUES (74, 'Finland', NULL, NULL, 358, 'FI');
INSERT INTO `country` VALUES (75, 'France', NULL, NULL, 33, 'FR');
INSERT INTO `country` VALUES (76, 'French Guiana', NULL, NULL, 594, 'GF');
INSERT INTO `country` VALUES (77, 'French Polynesia', NULL, NULL, 689, 'PF');
INSERT INTO `country` VALUES (78, 'French Southern Territories', NULL, NULL, 0, 'TF');
INSERT INTO `country` VALUES (79, 'Gabon', NULL, NULL, 241, 'GA');
INSERT INTO `country` VALUES (80, 'Gambia The', NULL, NULL, 220, 'GM');
INSERT INTO `country` VALUES (81, 'Georgia', NULL, NULL, 995, 'GE');
INSERT INTO `country` VALUES (82, 'Germany', NULL, NULL, 49, 'DE');
INSERT INTO `country` VALUES (83, 'Ghana', NULL, NULL, 233, 'GH');
INSERT INTO `country` VALUES (84, 'Gibraltar', NULL, NULL, 350, 'GI');
INSERT INTO `country` VALUES (85, 'Greece', NULL, NULL, 30, 'GR');
INSERT INTO `country` VALUES (86, 'Greenland', NULL, NULL, 299, 'GL');
INSERT INTO `country` VALUES (87, 'Grenada', NULL, NULL, 1473, 'GD');
INSERT INTO `country` VALUES (88, 'Guadeloupe', NULL, NULL, 590, 'GP');
INSERT INTO `country` VALUES (89, 'Guam', NULL, NULL, 1671, 'GU');
INSERT INTO `country` VALUES (90, 'Guatemala', NULL, NULL, 502, 'GT');
INSERT INTO `country` VALUES (91, 'Guernsey and Alderney', NULL, NULL, 44, 'XU');
INSERT INTO `country` VALUES (92, 'Guinea', NULL, NULL, 224, 'GN');
INSERT INTO `country` VALUES (93, 'Guinea-Bissau', NULL, NULL, 245, 'GW');
INSERT INTO `country` VALUES (94, 'Guyana', NULL, NULL, 592, 'GY');
INSERT INTO `country` VALUES (95, 'Haiti', NULL, NULL, 509, 'HT');
INSERT INTO `country` VALUES (96, 'Heard and McDonald Islands', NULL, NULL, 0, 'HM');
INSERT INTO `country` VALUES (97, 'Honduras', NULL, NULL, 504, 'HN');
INSERT INTO `country` VALUES (98, 'Hong Kong S.A.R.', NULL, NULL, 852, 'HK');
INSERT INTO `country` VALUES (99, 'Hungary', NULL, NULL, 36, 'HU');
INSERT INTO `country` VALUES (100, 'Iceland', NULL, NULL, 354, 'IS');
INSERT INTO `country` VALUES (101, 'India', NULL, NULL, 91, 'IN');
INSERT INTO `country` VALUES (102, 'Indonesia', NULL, NULL, 62, 'ID');
INSERT INTO `country` VALUES (103, 'Iran', NULL, NULL, 98, 'IR');
INSERT INTO `country` VALUES (104, 'Iraq', NULL, NULL, 964, 'IQ');
INSERT INTO `country` VALUES (105, 'Ireland', NULL, NULL, 353, 'IE');
INSERT INTO `country` VALUES (106, 'Israel', NULL, NULL, 972, 'IL');
INSERT INTO `country` VALUES (107, 'Italy', NULL, NULL, 39, 'IT');
INSERT INTO `country` VALUES (108, 'Jamaica', NULL, NULL, 1876, 'JM');
INSERT INTO `country` VALUES (109, 'Japan', NULL, NULL, 81, 'JP');
INSERT INTO `country` VALUES (110, 'Jersey', NULL, NULL, 44, 'XJ');
INSERT INTO `country` VALUES (111, 'Jordan', NULL, NULL, 962, 'JO');
INSERT INTO `country` VALUES (112, 'Kazakhstan', NULL, NULL, 7, 'KZ');
INSERT INTO `country` VALUES (113, 'Kenya', NULL, NULL, 254, 'KE');
INSERT INTO `country` VALUES (114, 'Kiribati', NULL, NULL, 686, 'KI');
INSERT INTO `country` VALUES (115, 'Korea North', NULL, NULL, 850, 'KP');
INSERT INTO `country` VALUES (116, 'Korea South', NULL, NULL, 82, 'KR');
INSERT INTO `country` VALUES (117, 'Kuwait', NULL, NULL, 965, 'KW');
INSERT INTO `country` VALUES (118, 'Kyrgyzstan', NULL, NULL, 996, 'KG');
INSERT INTO `country` VALUES (119, 'Laos', NULL, NULL, 856, 'LA');
INSERT INTO `country` VALUES (120, 'Latvia', NULL, NULL, 371, 'LV');
INSERT INTO `country` VALUES (121, 'Lebanon', NULL, NULL, 961, 'LB');
INSERT INTO `country` VALUES (122, 'Lesotho', NULL, NULL, 266, 'LS');
INSERT INTO `country` VALUES (123, 'Liberia', NULL, NULL, 231, 'LR');
INSERT INTO `country` VALUES (124, 'Libya', NULL, NULL, 218, 'LY');
INSERT INTO `country` VALUES (125, 'Liechtenstein', NULL, NULL, 423, 'LI');
INSERT INTO `country` VALUES (126, 'Lithuania', NULL, NULL, 370, 'LT');
INSERT INTO `country` VALUES (127, 'Luxembourg', NULL, NULL, 352, 'LU');
INSERT INTO `country` VALUES (128, 'Macau S.A.R.', NULL, NULL, 853, 'MO');
INSERT INTO `country` VALUES (129, 'Macedonia', NULL, NULL, 389, 'MK');
INSERT INTO `country` VALUES (130, 'Madagascar', NULL, NULL, 261, 'MG');
INSERT INTO `country` VALUES (131, 'Malawi', NULL, NULL, 265, 'MW');
INSERT INTO `country` VALUES (132, 'Malaysia', NULL, NULL, 60, 'MY');
INSERT INTO `country` VALUES (133, 'Maldives', NULL, NULL, 960, 'MV');
INSERT INTO `country` VALUES (134, 'Mali', NULL, NULL, 223, 'ML');
INSERT INTO `country` VALUES (135, 'Malta', NULL, NULL, 356, 'MT');
INSERT INTO `country` VALUES (136, 'Man (Isle of)', NULL, NULL, 44, 'XM');
INSERT INTO `country` VALUES (137, 'Marshall Islands', NULL, NULL, 692, 'MH');
INSERT INTO `country` VALUES (138, 'Martinique', NULL, NULL, 596, 'MQ');
INSERT INTO `country` VALUES (139, 'Mauritania', NULL, NULL, 222, 'MR');
INSERT INTO `country` VALUES (140, 'Mauritius', NULL, NULL, 230, 'MU');
INSERT INTO `country` VALUES (141, 'Mayotte', NULL, NULL, 269, 'YT');
INSERT INTO `country` VALUES (142, 'Mexico', NULL, NULL, 52, 'MX');
INSERT INTO `country` VALUES (143, 'Micronesia', NULL, NULL, 691, 'FM');
INSERT INTO `country` VALUES (144, 'Moldova', NULL, NULL, 373, 'MD');
INSERT INTO `country` VALUES (145, 'Monaco', NULL, NULL, 377, 'MC');
INSERT INTO `country` VALUES (146, 'Mongolia', NULL, NULL, 976, 'MN');
INSERT INTO `country` VALUES (147, 'Montserrat', NULL, NULL, 1664, 'MS');
INSERT INTO `country` VALUES (148, 'Morocco', NULL, NULL, 212, 'MA');
INSERT INTO `country` VALUES (149, 'Mozambique', NULL, NULL, 258, 'MZ');
INSERT INTO `country` VALUES (150, 'Myanmar', NULL, NULL, 95, 'MM');
INSERT INTO `country` VALUES (151, 'Namibia', NULL, NULL, 264, 'NA');
INSERT INTO `country` VALUES (152, 'Nauru', NULL, NULL, 674, 'NR');
INSERT INTO `country` VALUES (153, 'Nepal', NULL, NULL, 977, 'NP');
INSERT INTO `country` VALUES (154, 'Netherlands Antilles', NULL, NULL, 599, 'AN');
INSERT INTO `country` VALUES (155, 'Netherlands The', NULL, NULL, 31, 'NL');
INSERT INTO `country` VALUES (156, 'New Caledonia', NULL, NULL, 687, 'NC');
INSERT INTO `country` VALUES (157, 'New Zealand', NULL, NULL, 64, 'NZ');
INSERT INTO `country` VALUES (158, 'Nicaragua', NULL, NULL, 505, 'NI');
INSERT INTO `country` VALUES (159, 'Niger', NULL, NULL, 227, 'NE');
INSERT INTO `country` VALUES (160, 'Nigeria', NULL, NULL, 234, 'NG');
INSERT INTO `country` VALUES (161, 'Niue', NULL, NULL, 683, 'NU');
INSERT INTO `country` VALUES (162, 'Norfolk Island', NULL, NULL, 672, 'NF');
INSERT INTO `country` VALUES (163, 'Northern Mariana Islands', NULL, NULL, 1670, 'MP');
INSERT INTO `country` VALUES (164, 'Norway', NULL, NULL, 47, 'NO');
INSERT INTO `country` VALUES (165, 'Oman', NULL, NULL, 968, 'OM');
INSERT INTO `country` VALUES (166, 'Pakistan', NULL, NULL, 92, 'PK');
INSERT INTO `country` VALUES (167, 'Palau', NULL, NULL, 680, 'PW');
INSERT INTO `country` VALUES (168, 'Palestinian Territory Occupied', NULL, NULL, 970, 'PS');
INSERT INTO `country` VALUES (169, 'Panama', NULL, NULL, 507, 'PA');
INSERT INTO `country` VALUES (170, 'Papua new Guinea', NULL, NULL, 675, 'PG');
INSERT INTO `country` VALUES (171, 'Paraguay', NULL, NULL, 595, 'PY');
INSERT INTO `country` VALUES (172, 'Peru', NULL, NULL, 51, 'PE');
INSERT INTO `country` VALUES (173, 'Philippines', NULL, NULL, 63, 'PH');
INSERT INTO `country` VALUES (174, 'Pitcairn Island', NULL, NULL, 0, 'PN');
INSERT INTO `country` VALUES (175, 'Poland', NULL, NULL, 48, 'PL');
INSERT INTO `country` VALUES (176, 'Portugal', NULL, NULL, 351, 'PT');
INSERT INTO `country` VALUES (177, 'Puerto Rico', NULL, NULL, 1787, 'PR');
INSERT INTO `country` VALUES (178, 'Qatar', NULL, NULL, 974, 'QA');
INSERT INTO `country` VALUES (179, 'Reunion', NULL, NULL, 262, 'RE');
INSERT INTO `country` VALUES (180, 'Romania', NULL, NULL, 40, 'RO');
INSERT INTO `country` VALUES (181, 'Russia', NULL, NULL, 70, 'RU');
INSERT INTO `country` VALUES (182, 'Rwanda', NULL, NULL, 250, 'RW');
INSERT INTO `country` VALUES (183, 'Saint Helena', NULL, NULL, 290, 'SH');
INSERT INTO `country` VALUES (184, 'Saint Kitts And Nevis', NULL, NULL, 1869, 'KN');
INSERT INTO `country` VALUES (185, 'Saint Lucia', NULL, NULL, 1758, 'LC');
INSERT INTO `country` VALUES (186, 'Saint Pierre and Miquelon', NULL, NULL, 508, 'PM');
INSERT INTO `country` VALUES (187, 'Saint Vincent And The Grenadines', NULL, NULL, 1784, 'VC');
INSERT INTO `country` VALUES (188, 'Samoa', NULL, NULL, 684, 'WS');
INSERT INTO `country` VALUES (189, 'San Marino', NULL, NULL, 378, 'SM');
INSERT INTO `country` VALUES (190, 'Sao Tome and Principe', NULL, NULL, 239, 'ST');
INSERT INTO `country` VALUES (191, 'Saudi Arabia', NULL, NULL, 966, 'SA');
INSERT INTO `country` VALUES (192, 'Senegal', NULL, NULL, 221, 'SN');
INSERT INTO `country` VALUES (193, 'Serbia', NULL, NULL, 381, 'RS');
INSERT INTO `country` VALUES (194, 'Seychelles', NULL, NULL, 248, 'SC');
INSERT INTO `country` VALUES (195, 'Sierra Leone', NULL, NULL, 232, 'SL');
INSERT INTO `country` VALUES (196, 'Singapore', NULL, NULL, 65, 'SG');
INSERT INTO `country` VALUES (197, 'Slovakia', NULL, NULL, 421, 'SK');
INSERT INTO `country` VALUES (198, 'Slovenia', NULL, NULL, 386, 'SI');
INSERT INTO `country` VALUES (199, 'Smaller Territories of the UK', NULL, NULL, 44, 'XG');
INSERT INTO `country` VALUES (200, 'Solomon Islands', NULL, NULL, 677, 'SB');
INSERT INTO `country` VALUES (201, 'Somalia', NULL, NULL, 252, 'SO');
INSERT INTO `country` VALUES (202, 'South Africa', NULL, NULL, 27, 'ZA');
INSERT INTO `country` VALUES (203, 'South Georgia', NULL, NULL, 0, 'GS');
INSERT INTO `country` VALUES (204, 'South Sudan', NULL, NULL, 211, 'SS');
INSERT INTO `country` VALUES (205, 'Spain', NULL, NULL, 34, 'ES');
INSERT INTO `country` VALUES (206, 'Sri Lanka', NULL, NULL, 94, 'LK');
INSERT INTO `country` VALUES (207, 'Sudan', NULL, NULL, 249, 'SD');
INSERT INTO `country` VALUES (208, 'Suriname', NULL, NULL, 597, 'SR');
INSERT INTO `country` VALUES (209, 'Svalbard And Jan Mayen Islands', NULL, NULL, 47, 'SJ');
INSERT INTO `country` VALUES (210, 'Swaziland', NULL, NULL, 268, 'SZ');
INSERT INTO `country` VALUES (211, 'Sweden', NULL, NULL, 46, 'SE');
INSERT INTO `country` VALUES (212, 'Switzerland', NULL, NULL, 41, 'CH');
INSERT INTO `country` VALUES (213, 'Syria', NULL, NULL, 963, 'SY');
INSERT INTO `country` VALUES (214, 'Taiwan', NULL, NULL, 886, 'TW');
INSERT INTO `country` VALUES (215, 'Tajikistan', NULL, NULL, 992, 'TJ');
INSERT INTO `country` VALUES (216, 'Tanzania', NULL, NULL, 255, 'TZ');
INSERT INTO `country` VALUES (217, 'Thailand', NULL, NULL, 66, 'TH');
INSERT INTO `country` VALUES (218, 'Togo', NULL, NULL, 228, 'TG');
INSERT INTO `country` VALUES (219, 'Tokelau', NULL, NULL, 690, 'TK');
INSERT INTO `country` VALUES (220, 'Tonga', NULL, NULL, 676, 'TO');
INSERT INTO `country` VALUES (221, 'Trinidad And Tobago', NULL, NULL, 1868, 'TT');
INSERT INTO `country` VALUES (222, 'Tunisia', NULL, NULL, 216, 'TN');
INSERT INTO `country` VALUES (223, 'Turkey', NULL, NULL, 90, 'TR');
INSERT INTO `country` VALUES (224, 'Turkmenistan', NULL, NULL, 7370, 'TM');
INSERT INTO `country` VALUES (225, 'Turks And Caicos Islands', NULL, NULL, 1649, 'TC');
INSERT INTO `country` VALUES (226, 'Tuvalu', NULL, NULL, 688, 'TV');
INSERT INTO `country` VALUES (227, 'Uganda', NULL, NULL, 256, 'UG');
INSERT INTO `country` VALUES (228, 'Ukraine', NULL, NULL, 380, 'UA');
INSERT INTO `country` VALUES (229, 'United Arab Emirates', NULL, NULL, 971, 'AE');
INSERT INTO `country` VALUES (230, 'United Kingdom', NULL, NULL, 44, 'GB');
INSERT INTO `country` VALUES (231, 'United States', NULL, NULL, 1, 'US');
INSERT INTO `country` VALUES (232, 'United States Minor Outlying Islands', NULL, NULL, 1, 'UM');
INSERT INTO `country` VALUES (233, 'Uruguay', NULL, NULL, 598, 'UY');
INSERT INTO `country` VALUES (234, 'Uzbekistan', NULL, NULL, 998, 'UZ');
INSERT INTO `country` VALUES (235, 'Vanuatu', NULL, NULL, 678, 'VU');
INSERT INTO `country` VALUES (236, 'Vatican City State (Holy See)', NULL, NULL, 39, 'VA');
INSERT INTO `country` VALUES (237, 'Venezuela', NULL, NULL, 58, 'VE');
INSERT INTO `country` VALUES (238, 'Vietnam', NULL, NULL, 84, 'VN');
INSERT INTO `country` VALUES (239, 'Virgin Islands (British)', NULL, NULL, 1284, 'VG');
INSERT INTO `country` VALUES (240, 'Virgin Islands (US)', NULL, NULL, 1340, 'VI');
INSERT INTO `country` VALUES (241, 'Wallis And Futuna Islands', NULL, NULL, 681, 'WF');
INSERT INTO `country` VALUES (242, 'Western Sahara', NULL, NULL, 212, 'EH');
INSERT INTO `country` VALUES (243, 'Yemen', NULL, NULL, 967, 'YE');
INSERT INTO `country` VALUES (244, 'Yugoslavia', NULL, NULL, 38, 'YU');
INSERT INTO `country` VALUES (245, 'Zambia', NULL, NULL, 260, 'ZM');
INSERT INTO `country` VALUES (246, 'Zimbabwe', NULL, NULL, 263, 'ZW');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_group` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `join_date` date NOT NULL,
  `date_of_contract` date NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `facebook` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `education` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `school` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `major` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `active` int(11) NULL DEFAULT 1,
  `date_of_graduation` date NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `employee_phone_unique`(`phone`) USING BTREE,
  UNIQUE INDEX `employee_email_unique`(`email`) USING BTREE,
  INDEX `employee_id_group_index`(`id_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (3, 1, 'admin', '2000-01-01', '2000-01-01', '2000-01-01', 'Vietnam', '093295693', 'admin@remyhair.vn', '$2y$10$UG2VVxGQEwupP87wW0WkgeftLOMETSgCYwUuJDQeZHcZ1/7YUjm0i', '', '', '', '', 1, '2000-01-01', '2018-10-20 10:54:24', NULL, NULL);
INSERT INTO `employee` VALUES (4, 3, 'Minh Tan', '2018-10-20', '2018-10-20', '2018-10-20', 'Ha Noi', '0123456789', 'tannm@hamsa.com', '$2y$10$xL4BDNaab2KCOqMulrS1neb/B2Bqn4T84naYgciDV8mVmukM/dN2K', NULL, NULL, NULL, NULL, 1, '2018-10-20', '2018-10-20 10:54:24', '2018-11-26 00:02:38', NULL);
INSERT INTO `employee` VALUES (5, 1, 'phuong nam', '2018-11-06', '2018-11-06', '2018-11-06', 'Ha Noi, Ha noi', '0962406525', 'namdv32@gmail.com', '$2y$10$vGV0.aPdehKX8hBkadzfEeJ3qs9fuTU7AiU64Y6SQhp9rCSoS37Sy', NULL, NULL, NULL, NULL, 1, '2018-11-06', '2018-11-06 02:28:58', '2018-11-25 10:45:34', '2018-11-25 10:45:34');
INSERT INTO `employee` VALUES (6, 1, 'cuongnp', '2018-11-08', '2018-11-08', '2018-11-08', 'Hanoi Vietnam', '098765432', 'cuongnp@hblab.vn', '$2y$10$tKjlkMZhCsl52yhC0qanfeV3z1n5LrvpL5PQ./1MHO4FvrLK917Uq', NULL, NULL, NULL, NULL, 1, '2018-11-08', '2018-11-08 05:27:54', '2018-11-08 05:28:14', NULL);
INSERT INTO `employee` VALUES (7, 1, 'MR. JACK', '2018-11-09', '2018-11-09', '2018-11-09', 'NO.4 - HAI BOI VILLAGE - HAI BOI COMMUNE - DONG ANH DISTRICT', '0985686450', 'vnremyhair12@gmail.com', '$2y$10$w1.0FS3y1An4.myC.geGyO4mGCmkmVfb.xO/kvPW/yqdLiAHDzTMK', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 10:40:16', '2018-11-12 08:49:12', NULL);
INSERT INTO `employee` VALUES (8, 2, 'Mr.Mars', '2018-11-09', '2018-11-09', '2018-11-09', 'VILLAGE 4 , SOCIALHẢI BỐI, DISTRICTĐÔNG ANH, CAP', '0968589091', 'vnremyhair5@gmail.com', '$2y$10$.tSgEfXJoN4ICTugVqIkI.c/KAsehjrKGQYH6xg6T0dqXqLEzjnzC', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 11:12:26', '2018-11-13 09:24:37', NULL);
INSERT INTO `employee` VALUES (9, 3, 'Mr.John', '2018-11-09', '2018-11-09', '2018-11-09', 'Ha Noi', '0964981383', 'hoang.hair68@gmail.com', '$2y$10$3SDq./1/v19hE294BVw/IOe1PETUzkFFiqEoUT0pyAC1JUNTHxGAK', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 14:23:44', '2018-11-09 16:05:32', NULL);
INSERT INTO `employee` VALUES (10, 3, 'Mr. Kane', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0968589093', 'cong.hair68@gmail.com', '$2y$10$1P0H8tEE2D38tajKReQCqeEX4E8TD36RHDxlramvUs5mFAoVV0KYe', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 14:55:14', '2018-11-12 08:59:51', NULL);
INSERT INTO `employee` VALUES (11, 3, 'Ms.Mia', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0962853451', 'nhung.hair68@gmail.com', '$2y$10$ELMrzGOqD0RpCz/bINe9QervrktOf0SG0LulYUhCis1xF2mFdxgS.', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 14:56:26', '2018-11-25 12:13:17', NULL);
INSERT INTO `employee` VALUES (12, 3, 'Ms.Lani', '2018-11-09', '2018-11-09', '2018-11-09', 'hanoi', '0904501092', 'vnremyhair9@gmail.com', '$2y$10$4Z6Y0OLj0jAF48DA0cHCLuvd9EvUGGM58R6aWfOhwkmPP.C5Wpfla', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 14:57:23', '2018-11-09 16:09:38', NULL);
INSERT INTO `employee` VALUES (13, 3, 'Ms.Lily', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0961081428', 'thuy.hair68@gmail.com', '$2y$10$UJsTz2cQtdEsgWL95IQF4eY34tItt7K0b68MFGH3hxNRpKHoTSgve', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 14:59:13', '2018-11-09 16:10:00', NULL);
INSERT INTO `employee` VALUES (14, 3, 'Ms.Sunny', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0983466324', 'van.hair68@gmail.com', '$2y$10$60QgvGSEYxadSg0lnwTlguq.s5.aQWT3wRwPNJOYbjxhOij39gfxK', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 15:00:11', '2018-11-09 16:10:18', NULL);
INSERT INTO `employee` VALUES (15, 3, 'Ms.Rain', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0963959246', 'phuong.hair68@gmail.com', '$2y$10$PYfFotRuobWqtj.0MQcXrerjx5t6KkfbI3DAP.kR5aeQJm/l1SqEW', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 15:00:57', '2018-11-25 12:13:16', NULL);
INSERT INTO `employee` VALUES (16, 3, 'Ms.Tara', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0983370758', 'huyen.hair68@gmail.com', '$2y$10$kGLwSwBrIUq7AU5qh9ztUeZfeHtsy9E/NeiUH09kOMlSfeDDK5qES', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 15:01:48', '2018-11-09 16:10:47', NULL);
INSERT INTO `employee` VALUES (17, 3, 'Ms.Moon', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '0969836652', 'vnremyhair10@gmail.com', '$2y$10$N3m9FpH1jcJTOOpwRKXXyucPOnBDheT8fag2qsLkk2BSE7eIaSXTu', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 15:02:27', '2018-11-09 16:11:02', NULL);
INSERT INTO `employee` VALUES (18, 3, 'Ms.River', '2018-11-09', '2018-11-09', '2018-11-09', 'ha noi', '01652117091', 'ha.hair68@gmail.com', '$2y$10$l48zs1/cSCvhGi1MoB2aresql52UGvkYWxBnoNQecqQLvrGidhfc6', NULL, NULL, NULL, NULL, 1, '2018-11-09', '2018-11-09 15:03:27', '2018-11-09 16:11:15', NULL);
INSERT INTO `employee` VALUES (19, 1, 'cham', '2018-11-20', '2018-11-20', '2018-11-20', 'hanoi', '09876543', 'chamltn@hamsa.vn', '$2y$10$MJHOLT3FtdBuFy7KHVz3tu4gMQN0iuBvKLHiavpaMpCSxDsYCJmPO', NULL, NULL, NULL, NULL, 1, '2018-11-20', '2018-11-20 15:11:14', '2018-11-25 11:48:32', NULL);
INSERT INTO `employee` VALUES (20, 1, 'Mr. Hien', '1990-08-22', '2018-11-21', '2018-11-21', 'Cao Dinh, Xuan Dinh, Tu Liem', '0908811666', 'asap6886@gmail.com', '$2y$10$xk5VGwPcQIGDblRhbO3mYOgvAqW7WFEY0j7vVFS/4XFrDSuwQ3QIG', NULL, NULL, NULL, NULL, 1, '2018-11-21', '2018-11-21 08:31:51', '2018-11-25 12:13:15', NULL);
INSERT INTO `employee` VALUES (22, 3, 'tannm', '2018-11-26', '2018-11-26', '2018-11-26', 'ha noi', '0214234324', 'tannm@hamsa.vn', '$2y$10$ksHS/fwtyjSF3zKquvQYpuDfz0B/7FCdqtEz3ElVphbULC/peDb8y', NULL, NULL, NULL, NULL, 1, '2018-11-26', '2018-11-26 00:00:52', '2018-11-26 00:00:53', NULL);
INSERT INTO `employee` VALUES (23, 3, 'testere', '2018-12-15', '2018-12-15', '2018-12-15', 'dfdsf', '344545656464', 'tester@remyhair.vn', '$2y$10$/0XQj3JzhXkmQspl44LY8eiIAoUJ375smTJh7eh4bnS14sKtJ/6r2', NULL, NULL, NULL, NULL, 1, '2018-12-15', '2018-12-15 16:09:12', '2018-12-15 16:09:12', NULL);
INSERT INTO `employee` VALUES (24, 3, 'aaaaaa', '2018-12-15', '2018-12-15', '2018-12-15', 'dfdsf', '235354654654', 'aaaa@remyhair.vn', '$2y$10$XoIyZokbtKqm3uhmnruV6uBV4W8P4Uw.CdITshAPqguykr4oRtlZy', NULL, NULL, NULL, NULL, 1, '2018-12-15', '2018-12-15 16:13:14', '2018-12-15 16:13:14', NULL);

-- ----------------------------
-- Table structure for employee_family
-- ----------------------------
DROP TABLE IF EXISTS `employee_family`;
CREATE TABLE `employee_family`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `current_job` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_family_id_employee_index`(`id_employee`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee_family
-- ----------------------------
INSERT INTO `employee_family` VALUES (1, 3, 'df', '2018-12-12', 'gdfg', 'gdfgf', '2018-10-20 10:32:29', '2018-10-20 10:32:29');
INSERT INTO `employee_family` VALUES (2, 3, 'gdfg', '2018-12-12', 'fgdfgfdgf', 'gfdgf', '2018-10-20 10:32:38', '2018-10-20 10:32:38');

-- ----------------------------
-- Table structure for employee_group
-- ----------------------------
DROP TABLE IF EXISTS `employee_group`;
CREATE TABLE `employee_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of group
-- ----------------------------
INSERT INTO `group` VALUES (1, 'Admin', NULL, NULL);
INSERT INTO `group` VALUES (2, 'Leader', NULL, NULL);
INSERT INTO `group` VALUES (3, 'Normal', NULL, NULL);

-- ----------------------------
-- Table structure for group_permission
-- ----------------------------
DROP TABLE IF EXISTS `group_permission`;
CREATE TABLE `group_permission`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_group` int(11) NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6462 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of group_permission
-- ----------------------------
INSERT INTO `group_permission` VALUES (5752, 2, 'add-customer', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5753, 2, 'edit-customer', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5754, 2, 'list-customer', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5755, 2, 'detail-customer', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5756, 2, 'list-group', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5757, 2, 'edit-group', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5758, 2, 'get-group', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5759, 2, 'add-support', '2018-11-28 00:04:37', '2018-11-28 00:04:37');
INSERT INTO `group_permission` VALUES (5760, 2, 'edit-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5761, 2, 'remove-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5762, 2, 'get-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5763, 2, 'send-email-when-add', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5764, 2, 'send-email-when-change-status', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5765, 2, 'list-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5766, 2, 'get-customer', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5767, 2, 'edit-address', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5768, 2, 'list-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5769, 2, 'add-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5770, 2, 'edit-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5771, 2, 'remove-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5772, 2, 'get-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5773, 2, 'detail-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5774, 2, 'customer-list-by-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5775, 2, 'supports-list-by-employee', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5776, 2, 'list-leader', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5777, 2, 'report', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5778, 2, 'list-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5779, 2, 'get-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5780, 2, 'add-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5781, 2, 'edit-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5782, 2, 'add-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5783, 2, 'edit-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5784, 2, 'detail-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5785, 2, 'list-support', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5786, 2, 'list-procedure', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5787, 2, 'add-procedure', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5788, 2, 'get-procedure', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5789, 2, 'edit-procedure', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5790, 2, 'remove-procedure', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5791, 2, 'kanban-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5792, 2, 'edit-state-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5793, 2, 'list-order', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5794, 2, 'get-order', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5795, 2, 'change-state-order', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5796, 2, 'add-payment-order', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5797, 2, 'list-hair-color', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5798, 2, 'list-hair-size', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5799, 2, 'list-hair-style', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5800, 2, 'list-hair-draw', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5801, 2, 'list-hair-type', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5802, 2, 'add-hair-color', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5803, 2, 'add-hair-size', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5804, 2, 'add-hair-style', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5805, 2, 'add-hair-draw', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5806, 2, 'add-hair-type', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5807, 2, 'edit-hair-color', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5808, 2, 'edit-hair-size', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5809, 2, 'edit-hair-style', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5810, 2, 'edit-hair-draw', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5811, 2, 'edit-hair-type', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5812, 2, 'delete-hair-color', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5813, 2, 'delete-hair-size', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5814, 2, 'delete-hair-style', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5815, 2, 'delete-hair-draw', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5816, 2, 'delete-hair-type', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5817, 2, 'order-kanban', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5818, 2, 'order-change-states', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5819, 2, 'remove-procedure-steo', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5820, 2, 'remove-order-state', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5821, 2, 'update-order-state', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5822, 2, 'report-order-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5823, 2, 'export-order-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5824, 2, 'dashboard', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5825, 2, 'sale-commission-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5826, 2, 'sale-commission-detail', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5827, 2, 'report-order-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5828, 2, 'export-order-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5829, 2, 'payment-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5830, 2, 'payment-get', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5831, 2, 'payment-edit', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5832, 2, 'payment-delete', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5833, 2, 'invoice-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5834, 2, 'invoice-get', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5835, 2, 'history-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5836, 2, 'invoice-edit', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5837, 2, 'invoice-delete', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5838, 2, 'export-order-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5839, 2, 'un-support-list', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5840, 2, 'payment-add', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5841, 2, 'invoice-add', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5842, 2, 'add-leader-suggesstion', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5843, 2, 'update-order', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5844, 2, 'comment-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5845, 2, 'archive-workprofile', '2018-11-28 00:04:38', '2018-11-28 00:04:38');
INSERT INTO `group_permission` VALUES (5846, 3, 'add-customer', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5847, 3, 'edit-customer', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5848, 3, 'list-customer', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5849, 3, 'detail-customer', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5850, 3, 'list-group', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5851, 3, 'edit-group', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5852, 3, 'get-group', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5853, 3, 'add-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5854, 3, 'edit-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5855, 3, 'remove-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5856, 3, 'get-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5857, 3, 'send-email-when-add', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5858, 3, 'send-email-when-change-status', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5859, 3, 'list-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5860, 3, 'get-customer', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5861, 3, 'edit-address', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5862, 3, 'list-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5863, 3, 'add-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5864, 3, 'edit-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5865, 3, 'remove-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5866, 3, 'get-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5867, 3, 'detail-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5868, 3, 'customer-list-by-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5869, 3, 'supports-list-by-employee', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5870, 3, 'list-leader', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5871, 3, 'report', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5872, 3, 'list-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5873, 3, 'get-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5874, 3, 'add-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5875, 3, 'edit-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5876, 3, 'add-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5877, 3, 'edit-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5878, 3, 'detail-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5879, 3, 'list-support', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5880, 3, 'list-procedure', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5881, 3, 'add-procedure', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5882, 3, 'get-procedure', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5883, 3, 'edit-procedure', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5884, 3, 'remove-procedure', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5885, 3, 'kanban-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5886, 3, 'edit-state-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5887, 3, 'list-order', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5888, 3, 'get-order', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5889, 3, 'change-state-order', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5890, 3, 'add-payment-order', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5891, 3, 'list-hair-color', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5892, 3, 'list-hair-size', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5893, 3, 'list-hair-style', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5894, 3, 'list-hair-draw', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5895, 3, 'list-hair-type', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5896, 3, 'add-hair-color', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5897, 3, 'add-hair-size', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5898, 3, 'add-hair-style', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5899, 3, 'add-hair-draw', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5900, 3, 'add-hair-type', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5901, 3, 'edit-hair-color', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5902, 3, 'order-kanban', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5903, 3, 'order-change-states', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5904, 3, 'remove-procedure-steo', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5905, 3, 'remove-order-state', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5906, 3, 'update-order-state', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5907, 3, 'report-order-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5908, 3, 'export-order-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5909, 3, 'dashboard', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5910, 3, 'sale-commission-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5911, 3, 'sale-commission-detail', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5912, 3, 'report-order-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5913, 3, 'export-order-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5914, 3, 'payment-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5915, 3, 'payment-get', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5916, 3, 'payment-edit', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5917, 3, 'payment-delete', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5918, 3, 'invoice-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5919, 3, 'invoice-get', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5920, 3, 'invoice-edit', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5921, 3, 'invoice-delete', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5922, 3, 'export-order-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5923, 3, 'un-support-list', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5924, 3, 'payment-add', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5925, 3, 'invoice-add', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5926, 3, 'update-order', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5927, 3, 'comment-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (5928, 3, 'archive-workprofile', '2018-11-28 00:05:06', '2018-11-28 00:05:06');
INSERT INTO `group_permission` VALUES (6355, 1, 'add-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6356, 1, 'edit-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6357, 1, 'list-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6358, 1, 'detail-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6359, 1, 'list-group', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6360, 1, 'edit-group', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6361, 1, 'get-group', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6362, 1, 'add-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6363, 1, 'edit-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6364, 1, 'remove-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6365, 1, 'get-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6366, 1, 'send-email-when-add', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6367, 1, 'send-email-when-change-status', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6368, 1, 'list-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6369, 1, 'get-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6370, 1, 'edit-address', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6371, 1, 'list-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6372, 1, 'add-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6373, 1, 'edit-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6374, 1, 'remove-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6375, 1, 'get-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6376, 1, 'detail-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6377, 1, 'customer-list-by-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6378, 1, 'supports-list-by-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6379, 1, 'change-status-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6380, 1, 'list-leader', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6381, 1, 'report', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6382, 1, 'list-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6383, 1, 'get-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6384, 1, 'add-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6385, 1, 'edit-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6386, 1, 'add-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6387, 1, 'edit-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6388, 1, 'detail-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6389, 1, 'list-support', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6390, 1, 'list-procedure', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6391, 1, 'add-procedure', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6392, 1, 'get-procedure', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6393, 1, 'edit-procedure', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6394, 1, 'remove-procedure', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6395, 1, 'kanban-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6396, 1, 'edit-state-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6397, 1, 'list-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6398, 1, 'get-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6399, 1, 'change-state-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6400, 1, 'add-payment-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6401, 1, 'list-hair-color', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6402, 1, 'list-hair-size', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6403, 1, 'list-hair-style', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6404, 1, 'list-hair-draw', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6405, 1, 'list-hair-type', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6406, 1, 'add-hair-color', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6407, 1, 'add-hair-size', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6408, 1, 'add-hair-style', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6409, 1, 'add-hair-draw', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6410, 1, 'delete-employee', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6411, 1, 'add-hair-type', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6412, 1, 'edit-hair-color', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6413, 1, 'edit-hair-size', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6414, 1, 'edit-hair-style', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6415, 1, 'edit-hair-draw', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6416, 1, 'edit-hair-type', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6417, 1, 'delete-hair-color', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6418, 1, 'delete-hair-size', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6419, 1, 'delete-hair-style', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6420, 1, 'delete-hair-draw', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6421, 1, 'delete-hair-type', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6422, 1, 'order-kanban', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6423, 1, 'order-change-states', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6424, 1, 'remove-procedure-steo', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6425, 1, 'remove-order-state', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6426, 1, 'update-order-state', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6427, 1, 'report-order-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6428, 1, 'export-order-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6429, 1, 'dashboard', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6430, 1, 'sale-commission-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6431, 1, 'sale-commission-detail', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6432, 1, 'report-order-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6433, 1, 'export-order-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6434, 1, 'payment-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6435, 1, 'payment-get', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6436, 1, 'payment-edit', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6437, 1, 'payment-delete', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6438, 1, 'job-title-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6439, 1, 'job-title-get', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6440, 1, 'job-title-edit', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6441, 1, 'job-title-delete', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6442, 1, 'invoice-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6443, 1, 'invoice-get', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6444, 1, 'history-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6445, 1, 'invoice-edit', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6446, 1, 'invoice-delete', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6447, 1, 'export-order-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6448, 1, 'un-support-list', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6449, 1, 'payment-add', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6450, 1, 'job-title-add', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6451, 1, 'invoice-add', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6452, 1, 'add-employee-family', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6453, 1, 'delete-customer', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6454, 1, 'render-customer-export', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6455, 1, 'add-leader-suggesstion', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6456, 1, 'update-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6457, 1, 'comment-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6458, 1, 'remove-comment-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6459, 1, 'update-comment-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6460, 1, 'archive-workprofile', '2018-12-15 16:42:36', '2018-12-15 16:42:36');
INSERT INTO `group_permission` VALUES (6461, 1, 'archive-order', '2018-12-15 16:42:36', '2018-12-15 16:42:36');

-- ----------------------------
-- Table structure for hair_color
-- ----------------------------
DROP TABLE IF EXISTS `hair_color`;
CREATE TABLE `hair_color`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_color
-- ----------------------------
INSERT INTO `hair_color` VALUES (4, 'NATURAL', '2018-11-09 14:37:19', '2018-11-09 14:37:19');
INSERT INTO `hair_color` VALUES (5, '#1', '2018-11-09 14:37:25', '2018-11-09 14:37:25');
INSERT INTO `hair_color` VALUES (7, '#1B', '2018-11-09 14:37:41', '2018-11-09 14:37:41');
INSERT INTO `hair_color` VALUES (8, '#2', '2018-11-09 14:51:55', '2018-11-09 14:51:55');
INSERT INTO `hair_color` VALUES (9, '#2B', '2018-11-09 14:52:03', '2018-11-09 14:52:03');
INSERT INTO `hair_color` VALUES (10, '#4', '2018-11-09 14:52:09', '2018-11-09 14:52:09');
INSERT INTO `hair_color` VALUES (11, '#6', '2018-11-09 14:52:56', '2018-11-09 14:52:56');
INSERT INTO `hair_color` VALUES (12, '#8', '2018-11-09 14:53:00', '2018-11-09 14:53:00');
INSERT INTO `hair_color` VALUES (13, '#10', '2018-11-09 14:53:08', '2018-11-09 14:53:08');
INSERT INTO `hair_color` VALUES (14, '#613', '2018-11-09 14:53:13', '2018-11-09 14:53:13');
INSERT INTO `hair_color` VALUES (15, '#60', '2018-11-09 14:53:20', '2018-11-09 14:53:20');
INSERT INTO `hair_color` VALUES (16, '#43', '2018-11-09 14:53:29', '2018-11-09 14:53:29');
INSERT INTO `hair_color` VALUES (17, '#32', '2018-11-09 14:53:35', '2018-11-09 14:53:35');
INSERT INTO `hair_color` VALUES (18, '#27', '2018-11-09 14:53:40', '2018-11-09 14:53:40');
INSERT INTO `hair_color` VALUES (19, 'LIGHT END', '2018-11-09 14:53:58', '2018-11-09 14:53:58');
INSERT INTO `hair_color` VALUES (20, 'DARK BROWN', '2018-11-09 14:54:07', '2018-11-09 14:54:07');
INSERT INTO `hair_color` VALUES (21, 'LIGHT BROWN', '2018-11-09 14:58:27', '2018-11-09 14:58:27');
INSERT INTO `hair_color` VALUES (22, 'LIGHTEST BROWN', '2018-11-09 14:58:45', '2018-11-09 14:58:45');
INSERT INTO `hair_color` VALUES (23, 'BROWN', '2018-11-09 14:58:55', '2018-11-09 14:58:55');
INSERT INTO `hair_color` VALUES (24, 'GREY', '2018-11-09 14:59:00', '2018-11-09 14:59:00');
INSERT INTO `hair_color` VALUES (25, 'OMBRE 2 COLOR', '2018-11-09 15:02:59', '2018-11-09 15:02:59');
INSERT INTO `hair_color` VALUES (26, 'OMBRE 3 COLOR', '2018-11-09 15:03:36', '2018-11-09 15:03:36');
INSERT INTO `hair_color` VALUES (27, 'RED', '2018-11-09 15:03:52', '2018-11-09 15:03:52');
INSERT INTO `hair_color` VALUES (28, 'HIGH LIGHT', '2018-11-09 15:04:03', '2018-11-09 15:04:03');
INSERT INTO `hair_color` VALUES (29, 'ASH', '2018-11-09 15:04:12', '2018-11-09 15:04:12');
INSERT INTO `hair_color` VALUES (30, 'JET BLACK', '2018-11-09 15:04:25', '2018-11-09 15:04:25');
INSERT INTO `hair_color` VALUES (31, 'BLONDE', '2018-11-09 15:04:44', '2018-11-09 15:04:44');
INSERT INTO `hair_color` VALUES (32, 'NATURAL BLACK', '2018-11-09 15:04:55', '2018-11-09 15:04:55');
INSERT INTO `hair_color` VALUES (33, 'OTHER COLOR', '2018-11-09 15:05:07', '2018-11-09 15:05:07');

-- ----------------------------
-- Table structure for hair_draw
-- ----------------------------
DROP TABLE IF EXISTS `hair_draw`;
CREATE TABLE `hair_draw`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_draw
-- ----------------------------
INSERT INTO `hair_draw` VALUES (3, 'SINGLE', '2018-11-09 15:21:07', '2018-11-09 15:21:07');
INSERT INTO `hair_draw` VALUES (4, 'DOUBLE', '2018-11-09 15:21:13', '2018-11-09 15:21:13');
INSERT INTO `hair_draw` VALUES (5, 'SUPER DOUBLE', '2018-11-09 15:21:19', '2018-11-09 15:21:19');
INSERT INTO `hair_draw` VALUES (6, 'SINGLE 1', '2018-11-09 15:21:34', '2018-11-09 15:21:34');
INSERT INTO `hair_draw` VALUES (7, 'SINGLE 2', '2018-11-09 15:21:39', '2018-11-09 15:21:39');
INSERT INTO `hair_draw` VALUES (8, 'FREE PART', '2018-11-09 15:21:50', '2018-11-09 15:21:50');
INSERT INTO `hair_draw` VALUES (9, 'MIDDLE PART', '2018-11-09 15:22:26', '2018-11-09 15:22:26');
INSERT INTO `hair_draw` VALUES (10, 'THREE PART', '2018-11-09 15:22:39', '2018-11-09 15:22:39');
INSERT INTO `hair_draw` VALUES (11, 'OTHER DRAWN', '2018-11-09 15:22:48', '2018-11-09 15:22:48');

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

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
INSERT INTO `hair_style` VALUES (27, 'Steam', '2018-12-23 23:39:41', '2018-12-24 00:02:06', '[\"4\",\"5\",\"7\",\"8\",\"9\",\"10\",\"33\",\"32\",\"13\",\"17\",\"21\",\"25\",\"29\",\"14\",\"18\",\"22\",\"26\",\"30\",\"11\",\"15\",\"19\"]', 1);

-- ----------------------------
-- Table structure for hair_type
-- ----------------------------
DROP TABLE IF EXISTS `hair_type`;
CREATE TABLE `hair_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `export_type` enum('WEFT','CLOSURE','BULK','DEFAULT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hair_type
-- ----------------------------
INSERT INTO `hair_type` VALUES (3, 'WEFT', '2018-11-09 15:23:06', '2018-11-09 15:23:06', 'WEFT');
INSERT INTO `hair_type` VALUES (4, 'WEFT REMY', '2018-11-09 15:23:11', '2018-11-09 15:23:11', 'WEFT');
INSERT INTO `hair_type` VALUES (5, 'BULK', '2018-11-09 15:23:16', '2018-11-09 15:23:16', 'BULK');
INSERT INTO `hair_type` VALUES (6, 'BULK REMY', '2018-11-09 15:23:21', '2018-11-09 15:23:21', 'DEFAULT');
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
INSERT INTO `hair_type` VALUES (25, 'test2', '2019-01-16 09:43:24', '2019-01-16 09:43:24', NULL);
INSERT INTO `hair_type` VALUES (26, 'sdfsdf', '2019-01-16 09:43:55', '2019-01-16 09:43:55', NULL);
INSERT INTO `hair_type` VALUES (27, 'dgfg', '2019-01-16 09:44:57', '2019-01-16 09:44:57', 'CLOSURE');
INSERT INTO `hair_type` VALUES (28, 'fdsfsd', '2019-01-16 09:45:52', '2019-01-16 09:45:52', NULL);
INSERT INTO `hair_type` VALUES (29, 'fsdfsd', '2019-01-16 09:46:19', '2019-01-16 09:46:19', 'WEFT');

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_item` int(10) NULL DEFAULT NULL,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `history_id_item_index`(`id_item`) USING BTREE,
  INDEX `history_id_employee_index`(`id_employee`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 345 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES (1, 3, 1, 'edit', '2018-09-25 17:21:16', '2018-09-25 17:21:16', 'customer', '');
INSERT INTO `history` VALUES (2, 33, 1, 'edit', '2018-09-26 22:07:07', '2018-09-26 22:07:07', 'customer', '');
INSERT INTO `history` VALUES (3, 33, 1, 'edit', '2018-09-26 22:07:22', '2018-09-26 22:07:22', 'customer', '');
INSERT INTO `history` VALUES (4, 4, 1, 'edit', '2018-09-26 22:38:09', '2018-09-26 22:38:09', 'customer', '');
INSERT INTO `history` VALUES (30, 132, 1, 'edit', '2018-11-15 14:04:55', '2018-11-15 14:04:55', 'customer', '');
INSERT INTO `history` VALUES (31, 132, 1, 'edit', '2018-11-15 14:09:16', '2018-11-15 14:09:16', 'customer', '');
INSERT INTO `history` VALUES (32, 132, 3, 'api/customer/edit', '2018-11-15 14:09:16', '2018-11-15 14:09:16', 'a:16:{s:2:\"id\";i:132;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:12:\"nguyen van a\";s:5:\"phone\";s:10:\"1234567891\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:14:\"dfgfge1@fd.com\";s:4:\"type\";s:6:\"normal\";s:16:\"customer_balance\";d:31.94;s:6:\"status\";s:3:\"New\";s', 'admin');
INSERT INTO `history` VALUES (33, 0, 3, 'api/customer/add', '2018-11-15 14:10:12', '2018-11-15 14:10:12', 'a:11:{s:11:\"id_employee\";i:3;s:7:\"address\";a:4:{s:2:\"id\";i:1;s:10:\"id_country\";s:3:\"238\";s:8:\"id_state\";i:4045;s:7:\"address\";s:9:\"Hai duong\";}s:5:\"email\";s:20:\"lhas111307@gmail.com\";s:5:\"phone\";s:10:\"9847569993\";s:9:\"full_name\";s:9:\"Son Lai a\";s:4:\"type\";', 'admin');
INSERT INTO `history` VALUES (34, 0, 3, 'api/customer/add', '2018-11-15 14:10:15', '2018-11-15 14:10:15', 'a:11:{s:11:\"id_employee\";i:3;s:7:\"address\";a:4:{s:2:\"id\";i:1;s:10:\"id_country\";s:3:\"238\";s:8:\"id_state\";i:4045;s:7:\"address\";s:9:\"Hai duong\";}s:5:\"email\";s:20:\"lhas111307@gmail.com\";s:5:\"phone\";s:11:\"98475699933\";s:9:\"full_name\";s:9:\"Son Lai a\";s:4:\"type\"', 'admin');
INSERT INTO `history` VALUES (35, 163, 3, 'api/customer/add', '2018-11-15 22:18:49', '2018-11-15 22:18:49', 'a:11:{s:11:\"id_employee\";i:3;s:7:\"address\";a:4:{s:2:\"id\";i:1;s:10:\"id_country\";s:3:\"238\";s:8:\"id_state\";i:4045;s:7:\"address\";s:9:\"Hai duong\";}s:5:\"email\";s:20:\"lhas1ee307@gmail.com\";s:5:\"phone\";s:10:\"9184756999\";s:9:\"full_name\";s:7:\"Son Lai\";s:4:\"type\";s:', 'admin');
INSERT INTO `history` VALUES (36, 24, 3, 'api/employee/add', '2018-11-15 22:29:42', '2018-11-15 22:29:42', 'a:17:{s:8:\"id_group\";s:1:\"2\";s:7:\"address\";s:9:\"Hai duong\";s:5:\"email\";s:20:\"admi112n@remyhair.vn\";s:5:\"phone\";s:12:\"984756999321\";s:4:\"name\";s:7:\"Son Lai\";s:13:\"date_of_birth\";s:10:\"2018-11-15\";s:9:\"join_date\";s:10:\"2018-11-15\";s:16:\"date_of_contract\";s:', 'admin');
INSERT INTO `history` VALUES (37, 23, 3, 'api/add/hair/size', '2018-11-15 22:32:45', '2018-11-15 22:32:45', 'a:4:{s:4:\"name\";s:5:\"4.44\"\";s:7:\"filters\";a:0:{}s:7:\"id_cart\";s:4:\"1002\";s:4:\"user\";O:19:\"App\\Models\\Employee\":28:{s:8:\"\0*\0table\";s:8:\"employee\";s:8:\"\0*\0dates\";a:1:{i:0;s:10:\"deleted_at\";}s:11:\"\0*\0fillable\";a:18:{i:0;s:2:\"id\";i:1;s:4:\"name\";i:2;s:8:\"id_gr', 'admin');
INSERT INTO `history` VALUES (38, 12, 3, 'api/invoice/add', '2018-11-15 22:34:10', '2018-11-15 22:34:10', 'a:5:{s:4:\"name\";s:21:\"Lại Hoàng Anh Sơn\";s:7:\"filters\";a:2:{s:2:\"id\";a:3:{s:14:\"relation_table\";N;s:5:\"value\";N;s:7:\"sort_by\";N;}s:4:\"name\";a:3:{s:14:\"relation_table\";N;s:5:\"value\";N;s:7:\"sort_by\";N;}}s:11:\"page_number\";i:1;s:7:\"id_cart\";s:4:\"1002\";s:4:\"u', 'admin');
INSERT INTO `history` VALUES (39, 0, 3, 'api/customer/import', '2018-11-15 23:06:42', '2018-11-15 23:06:42', 'a:2:{s:9:\"customers\";a:3:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:3;i:1;s:12:\"nguyen van a\";i:2;i:123456789;i:3', 'admin');
INSERT INTO `history` VALUES (40, 0, 8, 'api/customer/import', '2018-11-16 11:06:38', '2018-11-16 11:06:38', 'a:2:{s:9:\"customers\";a:47:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:8;i:1;s:6:\"Safari\";i:2;s:15:\"+61 415 631 777', 'Mr.Mars');
INSERT INTO `history` VALUES (41, 0, 8, 'api/customer/import', '2018-11-16 11:12:15', '2018-11-16 11:12:15', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Mr.Mars');
INSERT INTO `history` VALUES (42, 0, 8, 'api/customer/import', '2018-11-16 11:12:33', '2018-11-16 11:12:33', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Mr.Mars');
INSERT INTO `history` VALUES (43, 0, 8, 'api/customer/import', '2018-11-16 11:13:11', '2018-11-16 11:13:11', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Mr.Mars');
INSERT INTO `history` VALUES (44, 0, 8, 'api/customer/import', '2018-11-16 11:13:59', '2018-11-16 11:13:59', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Mr.Mars');
INSERT INTO `history` VALUES (45, 0, 8, 'api/customer/import', '2018-11-16 11:15:07', '2018-11-16 11:15:07', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:8:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Mr.Mars');
INSERT INTO `history` VALUES (46, 0, 8, 'api/customer/import', '2018-11-16 11:15:48', '2018-11-16 11:15:48', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:8:{i:0;i:12;i:1;s:1:\"a\";i:2;s:17:\"+234 701 380 0084\";i', 'Mr.Mars');
INSERT INTO `history` VALUES (47, 0, 8, 'api/customer/import', '2018-11-16 11:16:24', '2018-11-16 11:16:24', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:1:\"a\";i:2;s:17:\"+234 701 380 0084\";i', 'Mr.Mars');
INSERT INTO `history` VALUES (48, 0, 12, 'api/customer/import', '2018-11-16 11:21:32', '2018-11-16 11:21:32', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Ms.Lani');
INSERT INTO `history` VALUES (49, 0, 12, 'api/customer/import', '2018-11-16 11:23:30', '2018-11-16 11:23:30', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:20:\"R_12.1.18_Ni_Chinedu\";i:2;s:17:\"', 'Ms.Lani');
INSERT INTO `history` VALUES (50, 0, 12, 'api/customer/import', '2018-11-16 11:24:34', '2018-11-16 11:24:34', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:10:\"Ni_Chinedu\";i:2;s:17:\"+234 701 3', 'Ms.Lani');
INSERT INTO `history` VALUES (51, 0, 12, 'api/customer/import', '2018-11-16 11:25:32', '2018-11-16 11:25:32', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:12;i:1;s:10:\"Ni_Chinedu\";i:2;s:17:\"+234 701 3', 'Ms.Lani');
INSERT INTO `history` VALUES (52, 0, 15, 'api/customer/import', '2018-11-16 11:30:14', '2018-11-16 11:30:14', 'a:2:{s:9:\"customers\";a:5:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:8:{i:0;i:15;i:1;s:7:\"MONIQUE\";i:2;s:17:\"+1 (678) 791-6', 'Ms.Rain');
INSERT INTO `history` VALUES (53, 0, 15, 'api/customer/import', '2018-11-16 11:31:22', '2018-11-16 11:31:22', 'a:2:{s:9:\"customers\";a:5:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:8:{i:0;i:15;i:1;s:7:\"MONIQUE\";i:2;s:17:\"+1 (678) 791-6', 'Ms.Rain');
INSERT INTO `history` VALUES (54, 0, 15, 'api/customer/import', '2018-11-16 11:32:10', '2018-11-16 11:32:10', 'a:2:{s:9:\"customers\";a:5:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:15;i:1;s:7:\"MONIQUE\";i:2;s:17:\"+1 (678) 791-6', 'Ms.Rain');
INSERT INTO `history` VALUES (55, 0, 18, 'api/customer/import', '2018-11-16 11:35:43', '2018-11-16 11:35:43', 'a:2:{s:9:\"customers\";a:6:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:18;i:1;s:23:\"Bongi_South Africa_9736\";i:2;s:1', 'Ms.River');
INSERT INTO `history` VALUES (56, 0, 18, 'api/customer/import', '2018-11-16 11:41:05', '2018-11-16 11:41:05', 'a:2:{s:9:\"customers\";a:5:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:18;i:1;s:15:\"Dimond_USA_9552\";i:2;s:17:\"+1 (3', 'Ms.River');
INSERT INTO `history` VALUES (57, 0, 18, 'api/customer/import', '2018-11-16 11:42:50', '2018-11-16 11:42:50', 'a:2:{s:9:\"customers\";a:3:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:18;i:1;s:16:\"Switzerland_1154\";i:2;s:16:\"+41 ', 'Ms.River');
INSERT INTO `history` VALUES (58, 0, 18, 'api/customer/import', '2018-11-16 11:44:53', '2018-11-16 11:44:53', 'a:2:{s:9:\"customers\";a:3:{i:0;a:9:{i:0;s:11:\"ID employee\";i:1;s:9:\"full name\";i:2;s:5:\"phone\";i:3;s:5:\"email\";i:4;s:4:\"type\";i:5;s:6:\"status\";i:6;s:7:\"country\";i:7;s:5:\"state\";i:8;s:7:\"address\";}i:1;a:9:{i:0;i:18;i:1;s:22:\"Nigeria a Hien fw_1071\";i:2;s:17', 'Ms.River');
INSERT INTO `history` VALUES (59, 134, 3, 'api/customer/edit', '2018-11-17 10:05:15', '2018-11-17 10:05:15', 'a:16:{s:2:\"id\";i:134;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:5:\"laura\";s:5:\"phone\";s:11:\"+1234556789\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:11:\"a@gmail.com\";s:4:\"type\";s:4:\"good\";s:16:\"customer_balance\";i:2;s:6:\"status\";s:10:\"Supporting\";s:10:\"cre', 'admin');
INSERT INTO `history` VALUES (60, 134, 3, 'api/customer/edit', '2018-11-17 10:05:27', '2018-11-17 10:05:27', 'a:16:{s:2:\"id\";i:134;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:5:\"laura\";s:5:\"phone\";s:11:\"+1234556789\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:11:\"a@gmail.com\";s:4:\"type\";s:4:\"good\";s:16:\"customer_balance\";i:2;s:6:\"status\";s:3:\"New\";s:10:\"created_at\"', 'admin');
INSERT INTO `history` VALUES (61, 134, 3, 'api/customer/edit', '2018-11-17 10:05:31', '2018-11-17 10:05:31', 'a:16:{s:2:\"id\";i:134;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:5:\"laura\";s:5:\"phone\";s:11:\"+1234556789\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:11:\"a@gmail.com\";s:4:\"type\";s:4:\"good\";s:16:\"customer_balance\";i:2;s:6:\"status\";s:7:\"Ordered\";s:10:\"created', 'admin');
INSERT INTO `history` VALUES (62, 133, 3, 'api/customer/edit', '2018-11-17 10:13:08', '2018-11-17 10:13:08', 'a:16:{s:2:\"id\";i:133;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:12:\"nguyen van a\";s:5:\"phone\";s:9:\"123456789\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:10:\"daa@fd.com\";s:4:\"type\";s:6:\"normal\";s:16:\"customer_balance\";i:0;s:6:\"status\";s:3:\"New\";s:10:\"creat', 'admin');
INSERT INTO `history` VALUES (63, 133, 3, 'api/customer/edit', '2018-11-17 10:13:13', '2018-11-17 10:13:13', 'a:16:{s:2:\"id\";i:133;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:12:\"nguyen van a\";s:5:\"phone\";s:9:\"123456789\";s:19:\"is_special_customer\";i:0;s:5:\"email\";s:10:\"daa@fd.com\";s:4:\"type\";s:6:\"normal\";s:16:\"customer_balance\";i:0;s:6:\"status\";s:3:\"New\";s:10:\"creat', 'admin');
INSERT INTO `history` VALUES (64, 134, 3, 'api/customer/edit', '2018-11-17 10:15:03', '2018-11-17 10:15:03', 'a:16:{s:2:\"id\";i:134;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:5:\"laura\";s:5:\"phone\";s:11:\"+1234556789\";s:19:\"is_special_customer\";b:1;s:5:\"email\";s:11:\"a@gmail.com\";s:4:\"type\";s:4:\"good\";s:16:\"customer_balance\";i:2;s:6:\"status\";s:7:\"Ordered\";s:10:\"created', 'admin');
INSERT INTO `history` VALUES (65, 133, 3, 'api/customer/edit', '2018-11-17 10:25:27', '2018-11-17 10:25:27', 'a:16:{s:2:\"id\";i:133;s:11:\"id_employee\";i:3;s:9:\"full_name\";s:12:\"nguyen van a\";s:5:\"phone\";s:9:\"123456789\";s:19:\"is_special_customer\";b:1;s:5:\"email\";s:12:\"dfgfg@fd.com\";s:4:\"type\";s:6:\"normal\";s:16:\"customer_balance\";i:0;s:6:\"status\";s:3:\"New\";s:10:\"cre', 'admin');
INSERT INTO `history` VALUES (66, 133, 3, 'api/customer/edit', '2018-11-17 10:28:13', '2018-11-17 10:28:13', 'customer - edit', 'admin');
INSERT INTO `history` VALUES (67, 0, 6, 'api/customer/import', '2018-11-17 10:29:46', '2018-11-17 10:29:46', 'customer - import', 'cuongnp');
INSERT INTO `history` VALUES (68, 121, 3, 'api/support/add', '2018-11-17 10:37:13', '2018-11-17 10:37:13', 'support - add', 'admin');
INSERT INTO `history` VALUES (69, 122, 3, 'api/support/add', '2018-11-17 10:37:28', '2018-11-17 10:37:28', 'support - add', 'admin');
INSERT INTO `history` VALUES (70, 111, 3, 'api/support/edit', '2018-11-17 11:09:30', '2018-11-17 11:09:30', 'support - edit', 'admin');
INSERT INTO `history` VALUES (71, 111, 3, 'api/support/edit', '2018-11-17 11:10:22', '2018-11-17 11:10:22', 'support - edit', 'admin');
INSERT INTO `history` VALUES (72, 111, 3, 'api/support/edit', '2018-11-17 11:14:16', '2018-11-17 11:14:16', 'support - edit', 'admin');
INSERT INTO `history` VALUES (73, 109, 3, 'api/support/edit', '2018-11-17 11:48:29', '2018-11-17 11:48:29', 'support - edit', 'admin');
INSERT INTO `history` VALUES (74, 109, 3, 'api/support/edit', '2018-11-17 11:49:03', '2018-11-17 11:49:03', 'support - edit', 'admin');
INSERT INTO `history` VALUES (75, 123, 3, 'api/support/add', '2018-11-17 12:03:42', '2018-11-17 12:03:42', 'support - add', 'admin');
INSERT INTO `history` VALUES (76, 124, 3, 'api/support/add', '2018-11-17 12:04:06', '2018-11-17 12:04:06', 'support - add', 'admin');
INSERT INTO `history` VALUES (77, 110, 3, 'api/support/edit', '2018-11-17 12:04:43', '2018-11-17 12:04:43', 'support - edit', 'admin');
INSERT INTO `history` VALUES (78, 116, 3, 'api/support/edit', '2018-11-17 14:23:33', '2018-11-17 14:23:33', 'support - edit', 'admin');
INSERT INTO `history` VALUES (79, 116, 3, 'api/support/edit', '2018-11-17 14:24:03', '2018-11-17 14:24:03', 'support - edit', 'admin');
INSERT INTO `history` VALUES (80, 116, 3, 'api/support/edit', '2018-11-17 14:24:18', '2018-11-17 14:24:18', 'support - edit', 'admin');
INSERT INTO `history` VALUES (81, 112, 3, 'api/support/edit', '2018-11-17 14:24:58', '2018-11-17 14:24:58', 'support - edit', 'admin');
INSERT INTO `history` VALUES (82, 0, 3, 'api/order/states/update', '2018-11-17 14:27:59', '2018-11-17 14:27:59', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (83, 0, 3, 'api/order/states/update', '2018-11-17 14:28:01', '2018-11-17 14:28:01', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (84, 0, 3, 'api/order/states/update', '2018-11-17 14:28:37', '2018-11-17 14:28:37', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (85, 0, 3, 'api/order/states/update', '2018-11-17 14:28:39', '2018-11-17 14:28:39', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (86, 0, 3, 'api/order/states/update', '2018-11-17 14:28:42', '2018-11-17 14:28:42', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (87, 0, 3, 'api/order/states/update', '2018-11-17 14:28:43', '2018-11-17 14:28:43', 'order - states - update', 'admin');
INSERT INTO `history` VALUES (88, 109, 6, 'api/support/edit', '2018-11-19 06:26:06', '2018-11-19 06:26:06', 'support - edit', 'cuongnp');
INSERT INTO `history` VALUES (89, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (90, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (91, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (92, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (93, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (94, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (95, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:04', '2018-11-20 14:24:04', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (96, 1, 6, 'api/invoice/delete', '2018-11-20 14:24:30', '2018-11-20 14:24:30', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (97, 1, 6, 'api/invoice/delete', '2018-11-20 14:27:55', '2018-11-20 14:27:55', 'invoice - delete', 'cuongnp');
INSERT INTO `history` VALUES (98, 1, 6, 'api/invoice/edit', '2018-11-20 14:28:07', '2018-11-20 14:28:07', 'invoice - edit', 'cuongnp');
INSERT INTO `history` VALUES (99, 21, 6, 'api/payment/delete', '2018-11-20 14:28:21', '2018-11-20 14:28:21', 'payment - delete', 'cuongnp');
INSERT INTO `history` VALUES (100, 22, 6, 'api/payment/edit', '2018-11-20 14:28:27', '2018-11-20 14:28:27', 'payment - edit', 'cuongnp');
INSERT INTO `history` VALUES (101, 22, 6, 'api/payment/edit', '2018-11-20 14:28:34', '2018-11-20 14:28:34', 'payment - edit', 'cuongnp');
INSERT INTO `history` VALUES (102, 0, 6, 'api/order/state/update', '2018-11-20 14:28:48', '2018-11-20 14:28:48', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (103, 0, 6, 'api/order/state/update', '2018-11-20 14:28:52', '2018-11-20 14:28:52', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (104, 0, 6, 'api/order/state/update', '2018-11-20 14:28:56', '2018-11-20 14:28:56', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (105, 12, 6, 'api/order/state/delete', '2018-11-20 14:29:01', '2018-11-20 14:29:01', 'order - state - delete', 'cuongnp');
INSERT INTO `history` VALUES (106, 11, 6, 'api/order/state/delete', '2018-11-20 14:29:03', '2018-11-20 14:29:03', 'order - state - delete', 'cuongnp');
INSERT INTO `history` VALUES (107, 10, 6, 'api/order/state/delete', '2018-11-20 14:29:12', '2018-11-20 14:29:12', 'order - state - delete', 'cuongnp');
INSERT INTO `history` VALUES (108, 0, 6, 'api/order/state/update', '2018-11-20 14:29:13', '2018-11-20 14:29:13', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (109, 0, 6, 'api/order/state/update', '2018-11-20 14:29:15', '2018-11-20 14:29:15', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (110, 0, 6, 'api/order/state/update', '2018-11-20 14:29:16', '2018-11-20 14:29:16', 'order - state - update', 'cuongnp');
INSERT INTO `history` VALUES (111, 10, 6, 'api/order/state/delete', '2018-11-20 14:29:17', '2018-11-20 14:29:17', 'order - state - delete', 'cuongnp');
INSERT INTO `history` VALUES (112, 24, 6, 'api/add/hair/type', '2018-11-20 14:30:09', '2018-11-20 14:30:09', 'add - hair - type', 'cuongnp');
INSERT INTO `history` VALUES (113, 0, 6, 'api/hair/delete/type/24', '2018-11-20 14:30:14', '2018-11-20 14:30:14', 'hair - delete - type - 24', 'cuongnp');
INSERT INTO `history` VALUES (114, 12, 6, 'api/add/hair/draw', '2018-11-20 14:30:35', '2018-11-20 14:30:35', 'add - hair - draw', 'cuongnp');
INSERT INTO `history` VALUES (115, 0, 6, 'api/hair/delete/draw/12', '2018-11-20 14:30:39', '2018-11-20 14:30:39', 'hair - delete - draw - 12', 'cuongnp');
INSERT INTO `history` VALUES (116, 1, 3, 'api/group/edit', '2018-11-20 14:40:41', '2018-11-20 14:40:41', 'group - edit', 'admin');
INSERT INTO `history` VALUES (117, 19, 6, 'api/employee/add', '2018-11-20 15:11:14', '2018-11-20 15:11:14', 'employee - add', 'cuongnp');
INSERT INTO `history` VALUES (118, 145, 3, 'api/customer/edit', '2018-11-20 15:46:33', '2018-11-20 15:46:33', 'customer - edit', 'admin');
INSERT INTO `history` VALUES (119, 145, 3, 'api/customer/delete', '2018-11-20 15:46:49', '2018-11-20 15:46:49', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (120, 146, 3, 'api/customer/delete', '2018-11-20 15:46:53', '2018-11-20 15:46:53', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (121, 148, 3, 'api/customer/delete', '2018-11-20 15:46:57', '2018-11-20 15:46:57', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (122, 149, 3, 'api/customer/delete', '2018-11-20 15:46:58', '2018-11-20 15:46:58', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (123, 151, 3, 'api/customer/edit', '2018-11-20 15:47:20', '2018-11-20 15:47:20', 'customer - edit', 'admin');
INSERT INTO `history` VALUES (124, 143, 3, 'api/customer/delete', '2018-11-20 15:48:44', '2018-11-20 15:48:44', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (125, 144, 3, 'api/customer/delete', '2018-11-20 15:48:47', '2018-11-20 15:48:47', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (126, 133, 3, 'api/customer/delete', '2018-11-20 15:48:49', '2018-11-20 15:48:49', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (127, 132, 3, 'api/customer/delete', '2018-11-20 15:48:51', '2018-11-20 15:48:51', 'customer - delete', 'admin');
INSERT INTO `history` VALUES (128, 0, 19, 'api/customer/import', '2018-11-20 17:02:23', '2018-11-20 17:02:23', 'customer - import', 'cham');
INSERT INTO `history` VALUES (129, 0, 19, 'api/customer/import', '2018-11-20 17:03:39', '2018-11-20 17:03:39', 'customer - import', 'cham');
INSERT INTO `history` VALUES (130, 113, 3, 'api/support/edit', '2018-11-20 17:20:33', '2018-11-20 17:20:33', 'support - edit', 'admin');
INSERT INTO `history` VALUES (131, 110, 3, 'api/support/edit', '2018-11-20 17:26:25', '2018-11-20 17:26:25', 'support - edit', 'admin');
INSERT INTO `history` VALUES (132, 110, 3, 'api/support/edit', '2018-11-20 17:27:35', '2018-11-20 17:27:35', 'support - edit', 'admin');
INSERT INTO `history` VALUES (133, 113, 3, 'api/support/edit', '2018-11-20 17:27:54', '2018-11-20 17:27:54', 'support - edit', 'admin');
INSERT INTO `history` VALUES (134, 109, 6, 'api/support/edit', '2018-11-21 04:43:50', '2018-11-21 04:43:50', 'support - edit', 'cuongnp');
INSERT INTO `history` VALUES (135, 134, 6, 'api/customer/edit', '2018-11-21 04:51:44', '2018-11-21 04:51:44', 'customer - edit', 'cuongnp');
INSERT INTO `history` VALUES (136, 134, 6, 'api/customer/edit', '2018-11-21 04:52:07', '2018-11-21 04:52:07', 'customer - edit', 'cuongnp');
INSERT INTO `history` VALUES (137, 227, 6, 'api/customer/delete', '2018-11-21 04:54:23', '2018-11-21 04:54:23', 'customer - delete', 'cuongnp');
INSERT INTO `history` VALUES (138, 2, 6, 'api/job-title/add', '2018-11-21 05:07:25', '2018-11-21 05:07:25', 'job-title - add', 'cuongnp');
INSERT INTO `history` VALUES (139, 12, 6, 'api/workprofile/add', '2018-11-21 05:08:54', '2018-11-21 05:08:54', 'workprofile - add', 'cuongnp');
INSERT INTO `history` VALUES (140, 0, 6, 'api/order/state/change', '2018-11-21 05:24:49', '2018-11-21 05:24:49', 'order - state - change', 'cuongnp');
INSERT INTO `history` VALUES (141, 0, 6, 'api/order/state/change', '2018-11-21 05:52:21', '2018-11-21 05:52:21', 'order - state - change', 'cuongnp');
INSERT INTO `history` VALUES (142, 109, 3, 'api/support/edit', '2018-11-21 08:21:57', '2018-11-21 08:21:57', 'support - edit', 'admin');
INSERT INTO `history` VALUES (143, 113, 3, 'api/support/edit', '2018-11-21 08:23:04', '2018-11-21 08:23:04', 'support - edit', 'admin');
INSERT INTO `history` VALUES (144, 1, 3, 'api/job-title/edit', '2018-11-21 08:25:32', '2018-11-21 08:25:32', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (145, 2, 3, 'api/job-title/edit', '2018-11-21 08:25:45', '2018-11-21 08:25:45', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (146, 3, 3, 'api/job-title/add', '2018-11-21 08:26:00', '2018-11-21 08:26:00', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (147, 4, 3, 'api/job-title/add', '2018-11-21 08:26:10', '2018-11-21 08:26:10', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (148, 5, 3, 'api/job-title/add', '2018-11-21 08:26:20', '2018-11-21 08:26:20', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (149, 6, 3, 'api/job-title/add', '2018-11-21 08:26:27', '2018-11-21 08:26:27', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (150, 7, 3, 'api/job-title/add', '2018-11-21 08:26:34', '2018-11-21 08:26:34', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (151, 2, 3, 'api/job-title/edit', '2018-11-21 08:26:48', '2018-11-21 08:26:48', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (152, 2, 3, 'api/job-title/edit', '2018-11-21 08:27:03', '2018-11-21 08:27:03', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (153, 2, 3, 'api/job-title/edit', '2018-11-21 08:27:12', '2018-11-21 08:27:12', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (154, 1, 3, 'api/job-title/edit', '2018-11-21 08:27:40', '2018-11-21 08:27:40', 'job-title - edit', 'admin');
INSERT INTO `history` VALUES (155, 8, 3, 'api/job-title/add', '2018-11-21 08:28:12', '2018-11-21 08:28:12', 'job-title - add', 'admin');
INSERT INTO `history` VALUES (156, 20, 3, 'api/employee/add', '2018-11-21 08:31:52', '2018-11-21 08:31:52', 'employee - add', 'admin');
INSERT INTO `history` VALUES (157, 20, 3, 'api/employee/edit', '2018-11-21 08:32:25', '2018-11-21 08:32:25', 'employee - edit', 'admin');
INSERT INTO `history` VALUES (158, 20, 3, 'api/employee/edit', '2018-11-21 08:33:07', '2018-11-21 08:33:07', 'employee - edit', 'admin');
INSERT INTO `history` VALUES (159, 21, 3, 'api/employee/add', '2018-11-21 09:47:34', '2018-11-21 09:47:34', 'employee - add', 'admin');
INSERT INTO `history` VALUES (160, 21, 3, 'api/employee/delete', '2018-11-21 09:47:40', '2018-11-21 09:47:40', 'employee - delete', 'admin');
INSERT INTO `history` VALUES (161, 13, 3, 'api/workprofile/add', '2018-11-23 18:20:00', '2018-11-23 18:20:00', 'workprofile - add', 'admin');
INSERT INTO `history` VALUES (162, 13, 3, 'api/workprofile/edit', '2018-11-23 21:42:06', '2018-11-23 21:42:06', 'workprofile - edit', 'admin');
INSERT INTO `history` VALUES (163, 1, 3, 'api/group/edit', '2018-11-24 20:26:43', '2018-11-24 20:26:43', 'group - edit', '');
INSERT INTO `history` VALUES (164, 1, 3, 'api/group/edit', '2018-11-24 20:28:55', '2018-11-24 20:28:55', 'group - edit', '');
INSERT INTO `history` VALUES (165, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:33:18', '2018-11-24 20:33:18', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (166, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:33:35', '2018-11-24 20:33:35', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (167, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:34:04', '2018-11-24 20:34:04', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (168, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:34:59', '2018-11-24 20:34:59', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (169, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:35:42', '2018-11-24 20:35:42', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (170, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:36:57', '2018-11-24 20:36:57', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (171, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:37:37', '2018-11-24 20:37:37', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (172, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:38:41', '2018-11-24 20:38:41', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (173, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-24 20:38:47', '2018-11-24 20:38:47', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (174, 1, 3, 'api/group/edit', '2018-11-25 18:10:14', '2018-11-25 18:10:14', 'group - edit', '');
INSERT INTO `history` VALUES (175, 8, 3, 'api/workprofile/suggesstion/update', '2018-11-25 23:31:13', '2018-11-25 23:31:13', 'workprofile - suggesstion - update', '');
INSERT INTO `history` VALUES (176, 14, 3, 'api/workprofile/add', '2018-11-25 23:37:18', '2018-11-25 23:37:18', 'workprofile - add', 'admin');
INSERT INTO `history` VALUES (177, 14, 3, 'api/workprofile/edit', '2018-11-25 23:38:14', '2018-11-25 23:38:14', 'workprofile - edit', '');
INSERT INTO `history` VALUES (178, 14, 3, 'api/workprofile/edit', '2018-11-25 23:38:46', '2018-11-25 23:38:46', 'workprofile - edit', '');
INSERT INTO `history` VALUES (179, 14, 3, 'api/workprofile/edit', '2018-11-25 23:39:46', '2018-11-25 23:39:46', 'workprofile - edit', '');
INSERT INTO `history` VALUES (180, 14, 3, 'api/workprofile/edit', '2018-11-25 23:39:55', '2018-11-25 23:39:55', 'workprofile - edit', '');
INSERT INTO `history` VALUES (181, 15, 3, 'api/workprofile/add', '2018-11-25 23:43:00', '2018-11-25 23:43:00', 'workprofile - add', 'admin');
INSERT INTO `history` VALUES (182, 16, 3, 'api/workprofile/add', '2018-11-25 23:44:32', '2018-11-25 23:44:32', 'workprofile - add', 'admin');
INSERT INTO `history` VALUES (183, 15, 3, 'api/workprofile/edit', '2018-11-25 23:45:01', '2018-11-25 23:45:01', 'workprofile - edit', '');
INSERT INTO `history` VALUES (184, 15, 3, 'api/workprofile/edit', '2018-11-25 23:45:06', '2018-11-25 23:45:06', 'workprofile - edit', '');
INSERT INTO `history` VALUES (185, 15, 3, 'api/workprofile/edit', '2018-11-25 23:47:11', '2018-11-25 23:47:11', 'workprofile - edit', '');
INSERT INTO `history` VALUES (186, 15, 3, 'api/workprofile/edit', '2018-11-25 23:47:50', '2018-11-25 23:47:50', 'workprofile - edit', '');
INSERT INTO `history` VALUES (187, 22, 3, 'api/employee/add', '2018-11-26 00:00:53', '2018-11-26 00:00:53', 'employee - add', 'admin');
INSERT INTO `history` VALUES (188, 4, 3, 'api/employee/edit', '2018-11-26 00:02:38', '2018-11-26 00:02:38', 'employee - edit', '');
INSERT INTO `history` VALUES (189, 3, 3, 'api/group/edit', '2018-11-26 00:11:10', '2018-11-26 00:11:10', 'group - edit', '');
INSERT INTO `history` VALUES (190, 1, 3, 'api/group/edit', '2018-11-26 16:19:47', '2018-11-26 16:19:47', 'group - edit', '');
INSERT INTO `history` VALUES (191, 0, 3, 'api/order/update', '2018-11-26 16:30:01', '2018-11-26 16:30:01', 'order - update', '');
INSERT INTO `history` VALUES (192, 0, 3, 'api/order/update', '2018-11-26 16:30:26', '2018-11-26 16:30:26', 'order - update', '');
INSERT INTO `history` VALUES (193, 0, 3, 'api/order/update', '2018-11-26 16:30:41', '2018-11-26 16:30:41', 'order - update', '');
INSERT INTO `history` VALUES (194, 0, 3, 'api/order/update', '2018-11-26 16:31:36', '2018-11-26 16:31:36', 'order - update', '');
INSERT INTO `history` VALUES (195, 0, 3, 'api/order/update', '2018-11-26 16:34:13', '2018-11-26 16:34:13', 'order - update', '');
INSERT INTO `history` VALUES (196, 0, 3, 'api/order/update', '2018-11-26 16:34:56', '2018-11-26 16:34:56', 'order - update', '');
INSERT INTO `history` VALUES (197, 0, 3, 'api/order/update', '2018-11-26 16:35:51', '2018-11-26 16:35:51', 'order - update', '');
INSERT INTO `history` VALUES (198, 0, 3, 'api/order/update', '2018-11-26 16:36:38', '2018-11-26 16:36:38', 'order - update', '');
INSERT INTO `history` VALUES (199, 0, 3, 'api/order/update', '2018-11-26 16:36:47', '2018-11-26 16:36:47', 'order - update', '');
INSERT INTO `history` VALUES (200, 0, 3, 'api/order/update', '2018-11-26 16:37:00', '2018-11-26 16:37:00', 'order - update', '');
INSERT INTO `history` VALUES (201, 0, 3, 'api/order/update', '2018-11-26 16:37:46', '2018-11-26 16:37:46', 'order - update', '');
INSERT INTO `history` VALUES (202, 0, 3, 'api/order/update', '2018-11-26 16:38:38', '2018-11-26 16:38:38', 'order - update', '');
INSERT INTO `history` VALUES (203, 0, 3, 'api/order/update', '2018-11-26 16:38:52', '2018-11-26 16:38:52', 'order - update', '');
INSERT INTO `history` VALUES (204, 0, 3, 'api/order/update', '2018-11-26 16:40:32', '2018-11-26 16:40:32', 'order - update', '');
INSERT INTO `history` VALUES (205, 0, 3, 'api/order/update', '2018-11-26 16:40:53', '2018-11-26 16:40:53', 'order - update', '');
INSERT INTO `history` VALUES (206, 0, 3, 'api/order/update', '2018-11-26 16:43:13', '2018-11-26 16:43:13', 'order - update', '');
INSERT INTO `history` VALUES (207, 0, 3, 'api/order/update', '2018-11-26 16:43:16', '2018-11-26 16:43:16', 'order - update', '');
INSERT INTO `history` VALUES (208, 0, 3, 'api/order/update', '2018-11-26 16:45:04', '2018-11-26 16:45:04', 'order - update', '');
INSERT INTO `history` VALUES (209, 0, 3, 'api/order/update', '2018-11-26 16:45:18', '2018-11-26 16:45:18', 'order - update', '');
INSERT INTO `history` VALUES (210, 0, 3, 'api/order/update', '2018-11-26 16:45:28', '2018-11-26 16:45:28', 'order - update', '');
INSERT INTO `history` VALUES (211, 0, 3, 'api/order/states/update', '2018-11-26 16:55:59', '2018-11-26 16:55:59', 'order - states - update', '');
INSERT INTO `history` VALUES (212, 0, 3, 'api/order/update', '2018-11-26 16:56:12', '2018-11-26 16:56:12', 'order - update', '');
INSERT INTO `history` VALUES (213, 0, 3, 'api/order/update', '2018-11-26 16:57:08', '2018-11-26 16:57:08', 'order - update', '');
INSERT INTO `history` VALUES (214, 0, 3, 'api/order/update', '2018-11-26 16:58:59', '2018-11-26 16:58:59', 'order - update', '');
INSERT INTO `history` VALUES (215, 125, 4, 'api/support/add', '2018-11-26 18:39:19', '2018-11-26 18:39:19', 'support - add', 'Minh Tan');
INSERT INTO `history` VALUES (216, 17, 4, 'api/workprofile/add', '2018-11-26 18:47:58', '2018-11-26 18:47:58', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (217, 4, 4, 'api/employee/edit', '2018-11-26 18:55:53', '2018-11-26 18:55:53', 'employee - edit', '');
INSERT INTO `history` VALUES (218, 18, 4, 'api/workprofile/add', '2018-11-26 18:56:12', '2018-11-26 18:56:12', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (219, 19, 4, 'api/workprofile/add', '2018-11-26 18:56:43', '2018-11-26 18:56:43', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (220, 20, 4, 'api/workprofile/add', '2018-11-26 18:57:31', '2018-11-26 18:57:31', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (221, 21, 4, 'api/workprofile/add', '2018-11-26 19:01:25', '2018-11-26 19:01:25', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (222, 22, 4, 'api/workprofile/add', '2018-11-26 19:01:51', '2018-11-26 19:01:51', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (223, 0, 4, 'api/order/states/update', '2018-11-26 19:28:43', '2018-11-26 19:28:43', 'order - states - update', '');
INSERT INTO `history` VALUES (224, 0, 4, 'api/order/states/update', '2018-11-26 19:28:44', '2018-11-26 19:28:44', 'order - states - update', '');
INSERT INTO `history` VALUES (225, 0, 4, 'api/order/states/update', '2018-11-26 19:29:32', '2018-11-26 19:29:32', 'order - states - update', '');
INSERT INTO `history` VALUES (226, 0, 4, 'api/order/states/update', '2018-11-26 19:29:48', '2018-11-26 19:29:48', 'order - states - update', '');
INSERT INTO `history` VALUES (227, 3, 3, 'api/group/edit', '2018-11-27 21:44:17', '2018-11-27 21:44:17', 'group - edit', '');
INSERT INTO `history` VALUES (228, 23, 4, 'api/workprofile/add', '2018-11-27 21:49:07', '2018-11-27 21:49:07', 'workprofile - add', 'Minh Tan');
INSERT INTO `history` VALUES (229, 3, 3, 'api/group/edit', '2018-11-27 21:56:11', '2018-11-27 21:56:11', 'group - edit', '');
INSERT INTO `history` VALUES (230, 2, 3, 'api/group/edit', '2018-11-27 21:56:16', '2018-11-27 21:56:16', 'group - edit', '');
INSERT INTO `history` VALUES (231, 1, 3, 'api/group/edit', '2018-11-27 22:07:12', '2018-11-27 22:07:12', 'group - edit', '');
INSERT INTO `history` VALUES (232, 2, 3, 'api/group/edit', '2018-11-27 22:22:54', '2018-11-27 22:22:54', 'group - edit', '');
INSERT INTO `history` VALUES (233, 1, 3, 'api/group/edit', '2018-11-27 22:42:13', '2018-11-27 22:42:13', 'group - edit', '');
INSERT INTO `history` VALUES (234, 2, 3, 'api/group/edit', '2018-11-27 22:42:17', '2018-11-27 22:42:17', 'group - edit', '');
INSERT INTO `history` VALUES (235, 3, 3, 'api/group/edit', '2018-11-27 22:42:20', '2018-11-27 22:42:20', 'group - edit', '');
INSERT INTO `history` VALUES (236, 0, 4, 'api/order/states/update', '2018-11-27 23:26:35', '2018-11-27 23:26:35', 'order - states - update', '');
INSERT INTO `history` VALUES (237, 0, 4, 'api/order/states/update', '2018-11-27 23:26:35', '2018-11-27 23:26:35', 'order - states - update', '');
INSERT INTO `history` VALUES (238, 0, 4, 'api/order/states/update', '2018-11-27 23:27:28', '2018-11-27 23:27:28', 'order - states - update', '');
INSERT INTO `history` VALUES (239, 0, 4, 'api/order/states/update', '2018-11-27 23:27:28', '2018-11-27 23:27:28', 'order - states - update', '');
INSERT INTO `history` VALUES (240, 0, 4, 'api/order/states/update', '2018-11-27 23:27:31', '2018-11-27 23:27:31', 'order - states - update', '');
INSERT INTO `history` VALUES (241, 0, 4, 'api/order/states/update', '2018-11-27 23:27:31', '2018-11-27 23:27:31', 'order - states - update', '');
INSERT INTO `history` VALUES (242, 2, 3, 'api/group/edit', '2018-11-28 00:04:38', '2018-11-28 00:04:38', 'group - edit', '');
INSERT INTO `history` VALUES (243, 3, 3, 'api/group/edit', '2018-11-28 00:05:06', '2018-11-28 00:05:06', 'group - edit', '');
INSERT INTO `history` VALUES (244, 0, 4, 'api/order/update', '2018-11-28 00:05:22', '2018-11-28 00:05:22', 'order - update', '');
INSERT INTO `history` VALUES (245, 0, 4, 'api/order/update', '2018-11-28 00:07:14', '2018-11-28 00:07:14', 'order - update', '');
INSERT INTO `history` VALUES (246, 0, 4, 'api/order/update', '2018-11-28 00:08:11', '2018-11-28 00:08:11', 'order - update', '');
INSERT INTO `history` VALUES (247, 1, 3, 'api/group/edit', '2018-11-28 00:12:32', '2018-11-28 00:12:32', 'group - edit', '');
INSERT INTO `history` VALUES (248, 0, 3, 'api/order/update', '2018-11-28 00:12:43', '2018-11-28 00:12:43', 'order - update', '');
INSERT INTO `history` VALUES (249, 0, 3, 'api/order/update', '2018-11-28 00:13:54', '2018-11-28 00:13:54', 'order - update', '');
INSERT INTO `history` VALUES (250, 1, 3, 'api/group/edit', '2018-11-28 00:23:18', '2018-11-28 00:23:18', 'group - edit', '');
INSERT INTO `history` VALUES (251, 0, 3, 'api/order/states/update', '2018-11-28 18:47:36', '2018-11-28 18:47:36', 'order - states - update', '');
INSERT INTO `history` VALUES (252, 0, 3, 'api/order/states/update', '2018-11-28 18:47:36', '2018-11-28 18:47:36', 'order - states - update', '');
INSERT INTO `history` VALUES (253, 8, 3, 'api/workprofile/edit', '2018-12-01 14:42:01', '2018-12-01 14:42:01', 'workprofile - edit', '');
INSERT INTO `history` VALUES (254, 8, 3, 'api/workprofile/edit', '2018-12-01 14:42:28', '2018-12-01 14:42:28', 'workprofile - edit', '');
INSERT INTO `history` VALUES (255, 8, 3, 'api/workprofile/edit', '2018-12-01 14:44:00', '2018-12-01 14:44:00', 'workprofile - edit', '');
INSERT INTO `history` VALUES (256, 8, 3, 'api/workprofile/edit', '2018-12-01 14:44:06', '2018-12-01 14:44:06', 'workprofile - edit', '');
INSERT INTO `history` VALUES (257, 8, 3, 'api/workprofile/edit', '2018-12-01 15:01:36', '2018-12-01 15:01:36', 'workprofile - edit', '');
INSERT INTO `history` VALUES (258, 1, 3, 'api/group/edit', '2018-12-01 15:47:16', '2018-12-01 15:47:16', 'group - edit', '');
INSERT INTO `history` VALUES (259, 1, 3, 'api/group/edit', '2018-12-01 15:59:48', '2018-12-01 15:59:48', 'group - edit', '');
INSERT INTO `history` VALUES (260, 0, 3, 'api/order/update', '2018-12-02 15:35:15', '2018-12-02 15:35:15', 'order - update', '');
INSERT INTO `history` VALUES (261, 0, 3, 'api/order/update', '2018-12-02 15:36:07', '2018-12-02 15:36:07', 'order - update', '');
INSERT INTO `history` VALUES (262, 0, 3, 'api/order/update', '2018-12-02 15:36:37', '2018-12-02 15:36:37', 'order - update', '');
INSERT INTO `history` VALUES (263, 0, 3, 'api/order/update', '2018-12-02 15:36:49', '2018-12-02 15:36:49', 'order - update', '');
INSERT INTO `history` VALUES (264, 0, 3, 'api/order/update', '2018-12-02 15:37:11', '2018-12-02 15:37:11', 'order - update', '');
INSERT INTO `history` VALUES (265, 0, 3, 'api/order/update', '2018-12-02 15:37:29', '2018-12-02 15:37:29', 'order - update', '');
INSERT INTO `history` VALUES (266, 0, 3, 'api/order/update', '2018-12-02 15:37:36', '2018-12-02 15:37:36', 'order - update', '');
INSERT INTO `history` VALUES (267, 0, 3, 'api/order/update', '2018-12-02 15:37:50', '2018-12-02 15:37:50', 'order - update', '');
INSERT INTO `history` VALUES (268, 0, 3, 'api/order/update', '2018-12-02 15:38:02', '2018-12-02 15:38:02', 'order - update', '');
INSERT INTO `history` VALUES (269, 0, 3, 'api/order/update', '2018-12-02 15:38:13', '2018-12-02 15:38:13', 'order - update', '');
INSERT INTO `history` VALUES (270, 0, 3, 'api/order/states/update', '2018-12-02 15:42:24', '2018-12-02 15:42:24', 'order - states - update', '');
INSERT INTO `history` VALUES (271, 0, 3, 'api/order/states/update', '2018-12-02 15:45:13', '2018-12-02 15:45:13', 'order - states - update', '');
INSERT INTO `history` VALUES (272, 0, 3, 'api/order/states/update', '2018-12-02 15:45:23', '2018-12-02 15:45:23', 'order - states - update', '');
INSERT INTO `history` VALUES (273, 0, 3, 'api/order/states/update', '2018-12-02 15:45:27', '2018-12-02 15:45:27', 'order - states - update', '');
INSERT INTO `history` VALUES (274, 0, 3, 'api/order/states/update', '2018-12-02 16:08:55', '2018-12-02 16:08:55', 'order - states - update', '');
INSERT INTO `history` VALUES (275, 0, 3, 'api/order/states/update', '2018-12-02 16:09:02', '2018-12-02 16:09:02', 'order - states - update', '');
INSERT INTO `history` VALUES (276, 0, 3, 'api/order/states/update', '2018-12-02 16:09:08', '2018-12-02 16:09:08', 'order - states - update', '');
INSERT INTO `history` VALUES (277, 0, 3, 'api/order/states/update', '2018-12-02 16:09:14', '2018-12-02 16:09:14', 'order - states - update', '');
INSERT INTO `history` VALUES (278, 0, 3, 'api/order/states/update', '2018-12-02 16:52:15', '2018-12-02 16:52:15', 'order - states - update', '');
INSERT INTO `history` VALUES (279, 7, 3, 'api/workprofile/edit', '2018-12-02 17:13:06', '2018-12-02 17:13:06', 'workprofile - edit', '');
INSERT INTO `history` VALUES (280, 0, 3, 'api/order/states/update', '2018-12-02 17:46:22', '2018-12-02 17:46:22', 'order - states - update', '');
INSERT INTO `history` VALUES (281, 0, 3, 'api/order/states/update', '2018-12-02 17:46:24', '2018-12-02 17:46:24', 'order - states - update', '');
INSERT INTO `history` VALUES (282, 0, 3, 'api/order/states/update', '2018-12-02 17:46:59', '2018-12-02 17:46:59', 'order - states - update', '');
INSERT INTO `history` VALUES (283, 0, 3, 'api/order/states/update', '2018-12-02 17:47:05', '2018-12-02 17:47:05', 'order - states - update', '');
INSERT INTO `history` VALUES (284, 0, 3, 'api/order/states/update', '2018-12-02 17:47:28', '2018-12-02 17:47:28', 'order - states - update', '');
INSERT INTO `history` VALUES (285, 0, 3, 'api/order/states/update', '2018-12-02 17:50:28', '2018-12-02 17:50:28', 'order - states - update', '');
INSERT INTO `history` VALUES (286, 0, 3, 'api/order/states/update', '2018-12-02 17:50:49', '2018-12-02 17:50:49', 'order - states - update', '');
INSERT INTO `history` VALUES (287, 0, 3, 'api/order/states/update', '2018-12-02 17:51:23', '2018-12-02 17:51:23', 'order - states - update', '');
INSERT INTO `history` VALUES (288, 0, 3, 'api/order/states/update', '2018-12-02 17:51:31', '2018-12-02 17:51:31', 'order - states - update', '');
INSERT INTO `history` VALUES (289, 0, 3, 'api/order/states/update', '2018-12-02 17:51:33', '2018-12-02 17:51:33', 'order - states - update', '');
INSERT INTO `history` VALUES (290, 0, 3, 'api/order/states/update', '2018-12-02 17:51:34', '2018-12-02 17:51:34', 'order - states - update', '');
INSERT INTO `history` VALUES (291, 0, 3, 'api/order/states/update', '2018-12-02 17:51:42', '2018-12-02 17:51:42', 'order - states - update', '');
INSERT INTO `history` VALUES (292, 0, 3, 'api/order/states/update', '2018-12-02 17:52:48', '2018-12-02 17:52:48', 'order - states - update', '');
INSERT INTO `history` VALUES (293, 0, 3, 'api/order/states/update', '2018-12-02 17:53:46', '2018-12-02 17:53:46', 'order - states - update', '');
INSERT INTO `history` VALUES (294, 0, 3, 'api/order/states/update', '2018-12-02 17:53:53', '2018-12-02 17:53:53', 'order - states - update', '');
INSERT INTO `history` VALUES (295, 0, 3, 'api/order/states/update', '2018-12-02 17:54:08', '2018-12-02 17:54:08', 'order - states - update', '');
INSERT INTO `history` VALUES (296, 0, 3, 'api/order/states/update', '2018-12-02 17:56:02', '2018-12-02 17:56:02', 'order - states - update', '');
INSERT INTO `history` VALUES (297, 0, 3, 'api/order/states/update', '2018-12-02 17:56:35', '2018-12-02 17:56:35', 'order - states - update', '');
INSERT INTO `history` VALUES (298, 0, 3, 'api/order/states/update', '2018-12-02 18:21:14', '2018-12-02 18:21:14', 'order - states - update', '');
INSERT INTO `history` VALUES (299, 0, 3, 'api/order/states/update', '2018-12-02 18:48:06', '2018-12-02 18:48:06', 'order - states - update', '');
INSERT INTO `history` VALUES (300, 0, 3, 'api/order/states/update', '2018-12-02 18:48:11', '2018-12-02 18:48:11', 'order - states - update', '');
INSERT INTO `history` VALUES (301, 0, 3, 'api/order/states/update', '2018-12-02 18:48:13', '2018-12-02 18:48:13', 'order - states - update', '');
INSERT INTO `history` VALUES (302, 0, 3, 'api/order/states/update', '2018-12-02 18:48:17', '2018-12-02 18:48:17', 'order - states - update', '');
INSERT INTO `history` VALUES (303, 0, 3, 'api/order/states/update', '2018-12-02 18:48:20', '2018-12-02 18:48:20', 'order - states - update', '');
INSERT INTO `history` VALUES (304, 0, 3, 'api/order/states/update', '2018-12-02 18:48:23', '2018-12-02 18:48:23', 'order - states - update', '');
INSERT INTO `history` VALUES (305, 0, 3, 'api/order/states/update', '2018-12-02 20:15:14', '2018-12-02 20:15:14', 'order - states - update', '');
INSERT INTO `history` VALUES (306, 0, 3, 'api/order/states/update', '2018-12-02 20:15:16', '2018-12-02 20:15:16', 'order - states - update', '');
INSERT INTO `history` VALUES (307, 0, 3, 'api/order/states/update', '2018-12-02 20:15:21', '2018-12-02 20:15:21', 'order - states - update', '');
INSERT INTO `history` VALUES (308, 0, 3, 'api/order/states/update', '2018-12-02 20:15:26', '2018-12-02 20:15:26', 'order - states - update', '');
INSERT INTO `history` VALUES (309, 0, 3, 'api/order/states/update', '2018-12-02 20:15:27', '2018-12-02 20:15:27', 'order - states - update', '');
INSERT INTO `history` VALUES (310, 0, 3, 'api/order/states/update', '2018-12-07 09:53:22', '2018-12-07 09:53:22', 'order - states - update', '');
INSERT INTO `history` VALUES (311, 0, 3, 'api/order/states/update', '2018-12-07 09:53:23', '2018-12-07 09:53:23', 'order - states - update', '');
INSERT INTO `history` VALUES (312, 0, 3, 'api/order/states/update', '2018-12-07 09:53:27', '2018-12-07 09:53:27', 'order - states - update', '');
INSERT INTO `history` VALUES (313, 0, 3, 'api/order/states/update', '2018-12-07 09:53:29', '2018-12-07 09:53:29', 'order - states - update', '');
INSERT INTO `history` VALUES (314, 0, 3, 'api/order/states/update', '2018-12-07 09:53:31', '2018-12-07 09:53:31', 'order - states - update', '');
INSERT INTO `history` VALUES (315, 0, 3, 'api/order/states/update', '2018-12-07 09:53:48', '2018-12-07 09:53:48', 'order - states - update', '');
INSERT INTO `history` VALUES (316, 0, 3, 'api/order/states/update', '2018-12-07 09:56:24', '2018-12-07 09:56:24', 'order - states - update', '');
INSERT INTO `history` VALUES (317, 0, 3, 'api/order/states/update', '2018-12-07 09:56:26', '2018-12-07 09:56:26', 'order - states - update', '');
INSERT INTO `history` VALUES (318, 0, 3, 'api/order/states/update', '2018-12-07 09:56:28', '2018-12-07 09:56:28', 'order - states - update', '');
INSERT INTO `history` VALUES (319, 0, 3, 'api/order/states/update', '2018-12-07 09:56:29', '2018-12-07 09:56:29', 'order - states - update', '');
INSERT INTO `history` VALUES (320, 0, 3, 'api/order/states/update', '2018-12-07 09:56:31', '2018-12-07 09:56:31', 'order - states - update', '');
INSERT INTO `history` VALUES (321, 0, 3, 'api/order/states/update', '2018-12-07 09:56:33', '2018-12-07 09:56:33', 'order - states - update', '');
INSERT INTO `history` VALUES (322, 0, 3, 'api/order/states/update', '2018-12-07 09:56:33', '2018-12-07 09:56:33', 'order - states - update', '');
INSERT INTO `history` VALUES (323, 23, 3, 'api/employee/add', '2018-12-15 16:09:13', '2018-12-15 16:09:13', 'employee - add', 'admin');
INSERT INTO `history` VALUES (324, 24, 3, 'api/employee/add', '2018-12-15 16:13:14', '2018-12-15 16:13:14', 'employee - add', 'admin');
INSERT INTO `history` VALUES (325, 1, 3, 'api/group/edit', '2018-12-15 16:42:36', '2018-12-15 16:42:36', 'group - edit', '');
INSERT INTO `history` VALUES (326, 24, 3, 'api/workprofile/add', '2018-12-22 09:19:03', '2018-12-22 09:19:03', 'workprofile - add', 'admin');
INSERT INTO `history` VALUES (327, 0, 3, 'api/procedure/edit', '2018-12-22 20:18:17', '2018-12-22 20:18:17', 'procedure - edit', '');
INSERT INTO `history` VALUES (328, 23, 3, 'api/workprofile/step/delete', '2018-12-22 20:21:21', '2018-12-22 20:21:21', 'workprofile - step - delete', '');
INSERT INTO `history` VALUES (329, 21, 3, 'api/workprofile/step/delete', '2018-12-22 20:21:32', '2018-12-22 20:21:32', 'workprofile - step - delete', '');
INSERT INTO `history` VALUES (330, 27, 3, 'api/add/hair/style', '2018-12-23 23:39:41', '2018-12-23 23:39:41', 'add - hair - style', 'admin');
INSERT INTO `history` VALUES (331, 1, 3, 'api/customer/add', '2018-12-24 08:57:30', '2018-12-24 08:57:30', 'customer - add', 'admin');
INSERT INTO `history` VALUES (332, 2, 3, 'api/customer/add', '2019-01-05 16:30:34', '2019-01-05 16:30:34', 'customer - add', 'admin');
INSERT INTO `history` VALUES (333, 3, 3, 'api/customer/add', '2019-01-05 16:31:33', '2019-01-05 16:31:33', 'customer - add', 'admin');
INSERT INTO `history` VALUES (334, 4, 3, 'api/customer/add', '2019-01-05 16:33:31', '2019-01-05 16:33:31', 'customer - add', 'admin');
INSERT INTO `history` VALUES (335, 5, 3, 'api/customer/add', '2019-01-05 16:34:36', '2019-01-05 16:34:36', 'customer - add', 'admin');
INSERT INTO `history` VALUES (336, 6, 3, 'api/customer/add', '2019-01-05 16:35:13', '2019-01-05 16:35:13', 'customer - add', 'admin');
INSERT INTO `history` VALUES (337, 7, 3, 'api/customer/add', '2019-01-05 16:36:32', '2019-01-05 16:36:32', 'customer - add', 'admin');
INSERT INTO `history` VALUES (338, 8, 3, 'api/customer/add', '2019-01-05 16:37:31', '2019-01-05 16:37:31', 'customer - add', 'admin');
INSERT INTO `history` VALUES (339, 24, 3, 'api/add/hair/type', '2019-01-16 09:40:36', '2019-01-16 09:40:36', 'add - hair - type', 'admin');
INSERT INTO `history` VALUES (340, 25, 3, 'api/add/hair/type', '2019-01-16 09:43:24', '2019-01-16 09:43:24', 'add - hair - type', 'admin');
INSERT INTO `history` VALUES (341, 26, 3, 'api/add/hair/type', '2019-01-16 09:43:55', '2019-01-16 09:43:55', 'add - hair - type', 'admin');
INSERT INTO `history` VALUES (342, 27, 3, 'api/add/hair/type', '2019-01-16 09:44:57', '2019-01-16 09:44:57', 'add - hair - type', 'admin');
INSERT INTO `history` VALUES (343, 28, 3, 'api/add/hair/type', '2019-01-16 09:45:52', '2019-01-16 09:45:52', 'add - hair - type', 'admin');
INSERT INTO `history` VALUES (344, 29, 3, 'api/add/hair/type', '2019-01-16 09:46:19', '2019-01-16 09:46:19', 'add - hair - type', 'admin');

-- ----------------------------
-- Table structure for invoice_status
-- ----------------------------
DROP TABLE IF EXISTS `invoice_status`;
CREATE TABLE `invoice_status`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of invoice_status
-- ----------------------------
INSERT INTO `invoice_status` VALUES (1, 'Bailey Falls1', NULL, '2018-11-20 14:28:07');
INSERT INTO `invoice_status` VALUES (2, 'Anika Lodge', NULL, NULL);
INSERT INTO `invoice_status` VALUES (3, 'Meagan Tunnel', NULL, NULL);
INSERT INTO `invoice_status` VALUES (4, 'Joey Junctions', NULL, NULL);
INSERT INTO `invoice_status` VALUES (5, 'Hermann Ports', NULL, NULL);
INSERT INTO `invoice_status` VALUES (6, 'Herzog Motorway', NULL, NULL);
INSERT INTO `invoice_status` VALUES (7, 'Tess Mill', NULL, NULL);
INSERT INTO `invoice_status` VALUES (8, 'Cronin Crescent', NULL, NULL);
INSERT INTO `invoice_status` VALUES (9, 'Bechtelar Knolls', NULL, NULL);
INSERT INTO `invoice_status` VALUES (10, 'Collier Forge', NULL, NULL);
INSERT INTO `invoice_status` VALUES (11, 'Keebler Course', NULL, NULL);

-- ----------------------------
-- Table structure for leader_role
-- ----------------------------
DROP TABLE IF EXISTS `leader_role`;
CREATE TABLE `leader_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_role` int(10) UNSIGNED NOT NULL,
  `id_employee_group` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `leader_role_id_role_index`(`id_role`) USING BTREE,
  INDEX `leader_role_id_employee_group_index`(`id_employee_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2018_07_25_145958_create_address_table', 1);
INSERT INTO `migrations` VALUES (4, '2018_07_25_145958_create_carrier_table', 1);
INSERT INTO `migrations` VALUES (5, '2018_07_25_145958_create_cart_product_image_table', 1);
INSERT INTO `migrations` VALUES (6, '2018_07_25_145958_create_cart_product_table', 1);
INSERT INTO `migrations` VALUES (7, '2018_07_25_145958_create_cart_table', 1);
INSERT INTO `migrations` VALUES (8, '2018_07_25_145958_create_country_table', 1);
INSERT INTO `migrations` VALUES (9, '2018_07_25_145958_create_customer_table', 1);
INSERT INTO `migrations` VALUES (10, '2018_07_25_145958_create_employee_family_table', 1);
INSERT INTO `migrations` VALUES (11, '2018_07_25_145958_create_employee_group_table', 1);
INSERT INTO `migrations` VALUES (12, '2018_07_25_145958_create_employee_table', 1);
INSERT INTO `migrations` VALUES (13, '2018_07_25_145958_create_hair_color_table', 1);
INSERT INTO `migrations` VALUES (14, '2018_07_25_145958_create_hair_draw_table', 1);
INSERT INTO `migrations` VALUES (15, '2018_07_25_145958_create_hair_size_table', 1);
INSERT INTO `migrations` VALUES (16, '2018_07_25_145958_create_hair_style_table', 1);
INSERT INTO `migrations` VALUES (17, '2018_07_25_145958_create_hair_type_table', 1);
INSERT INTO `migrations` VALUES (18, '2018_07_25_145958_create_history_table', 1);
INSERT INTO `migrations` VALUES (19, '2018_07_25_145958_create_invoice_status_table', 1);
INSERT INTO `migrations` VALUES (20, '2018_07_25_145958_create_leader_role_table', 1);
INSERT INTO `migrations` VALUES (21, '2018_07_25_145958_create_note_table', 1);
INSERT INTO `migrations` VALUES (22, '2018_07_25_145958_create_order_detail_table', 1);
INSERT INTO `migrations` VALUES (23, '2018_07_25_145958_create_order_history_table', 1);
INSERT INTO `migrations` VALUES (24, '2018_07_25_145958_create_order_payment_table', 1);
INSERT INTO `migrations` VALUES (25, '2018_07_25_145958_create_order_state_table', 1);
INSERT INTO `migrations` VALUES (26, '2018_07_25_145958_create_order_status_table', 1);
INSERT INTO `migrations` VALUES (27, '2018_07_25_145958_create_order_table', 1);
INSERT INTO `migrations` VALUES (28, '2018_07_25_145958_create_payment_table', 1);
INSERT INTO `migrations` VALUES (29, '2018_07_25_145958_create_procedure_step_table', 1);
INSERT INTO `migrations` VALUES (30, '2018_07_25_145958_create_procedure_table', 1);
INSERT INTO `migrations` VALUES (31, '2018_07_25_145958_create_state_table', 1);
INSERT INTO `migrations` VALUES (32, '2018_07_25_145958_create_support_table', 1);
INSERT INTO `migrations` VALUES (33, '2018_07_25_145958_create_work_category_table', 1);
INSERT INTO `migrations` VALUES (34, '2018_07_25_145958_create_work_profile_table', 1);
INSERT INTO `migrations` VALUES (35, '2018_07_30_060719_add_relaitonship_customer_table', 1);
INSERT INTO `migrations` VALUES (36, '2018_07_30_155221_change_customer_columns', 1);
INSERT INTO `migrations` VALUES (37, '2018_08_02_145937_edit_support_time', 1);
INSERT INTO `migrations` VALUES (38, '2018_08_04_030333_create_table_group', 1);
INSERT INTO `migrations` VALUES (39, '2018_08_04_030423_create_table_group_permisison', 1);
INSERT INTO `migrations` VALUES (40, '2018_08_07_023728_edit_employee_nullable_columns', 1);
INSERT INTO `migrations` VALUES (41, '2018_08_07_151357_create_update_support_table', 1);
INSERT INTO `migrations` VALUES (42, '2018_08_08_103224_change_suppport_time', 1);
INSERT INTO `migrations` VALUES (43, '2018_08_11_145958_add_coumn_to_country', 1);
INSERT INTO `migrations` VALUES (44, '2018_08_12_024004_change_status_on_customer', 1);
INSERT INTO `migrations` VALUES (45, '2018_08_15_143644_change_work_profile_columns', 1);
INSERT INTO `migrations` VALUES (46, '2018_08_16_013232_add_type_to_employee', 1);
INSERT INTO `migrations` VALUES (47, '2018_08_18_090244_create_update_employee_table', 1);
INSERT INTO `migrations` VALUES (48, '2018_08_21_100205_change_table_product', 1);
INSERT INTO `migrations` VALUES (49, '2018_08_21_103200_change_cart_column', 1);
INSERT INTO `migrations` VALUES (50, '2018_08_22_023507_remove_idleader_employee', 1);
INSERT INTO `migrations` VALUES (51, '2018_09_04_145153_add_model_column_to_history_table', 1);
INSERT INTO `migrations` VALUES (52, '2018_09_06_142435_change_column_on_order_table', 1);
INSERT INTO `migrations` VALUES (53, '2018_09_06_145939_add_order_status_step', 1);
INSERT INTO `migrations` VALUES (54, '2018_09_06_150456_add_id_order_to_order_detail', 1);
INSERT INTO `migrations` VALUES (55, '2018_09_22_150812_change_cart_table', 2);
INSERT INTO `migrations` VALUES (56, '2018_09_24_211001_change_order_table', 3);
INSERT INTO `migrations` VALUES (57, '2018_09_24_212130_change_orde_r_table', 4);
INSERT INTO `migrations` VALUES (58, '2018_09_24_213047_change_order__table', 5);
INSERT INTO `migrations` VALUES (59, '2018_09_24_215354_add_sale_commision_table', 6);
INSERT INTO `migrations` VALUES (60, '2018_09_24_215611_add_sale_commision_employee_table', 7);
INSERT INTO `migrations` VALUES (61, '2018_09_26_111405_change_number_column', 8);
INSERT INTO `migrations` VALUES (62, '2018_09_26_232118_change_note-nullable', 9);
INSERT INTO `migrations` VALUES (63, '2018_09_27_180133_cahnge_order', 10);
INSERT INTO `migrations` VALUES (64, '2018_09_27_180419_cahnge_order_detail', 11);
INSERT INTO `migrations` VALUES (65, '2018_09_30_105011_change_reston', 12);
INSERT INTO `migrations` VALUES (66, '2018_09_30_121214_add_paid_order', 13);
INSERT INTO `migrations` VALUES (67, '2018_09_30_130808_add_payment_to_paid', 14);
INSERT INTO `migrations` VALUES (68, '2018_09_30_135107_change_all_currency_column', 15);
INSERT INTO `migrations` VALUES (69, '2018_11_27_210416_create_work_profile_comment', 16);
INSERT INTO `migrations` VALUES (70, '2018_11_27_223434_add_archive_to_work_profile', 17);
INSERT INTO `migrations` VALUES (71, '2018_11_28_001532_add_archive_to_order', 18);
INSERT INTO `migrations` VALUES (72, '2018_11_30_161157_add_position_order_table', 19);
INSERT INTO `migrations` VALUES (73, '2018_12_02_161627_add_position_to_work_profile_kanban', 20);
INSERT INTO `migrations` VALUES (74, '2018_12_15_161037_change_default_value_employee', 21);
INSERT INTO `migrations` VALUES (75, '2018_12_22_112440_add_report_hair_type_style_table', 22);
INSERT INTO `migrations` VALUES (76, '2018_10_27_111924_create_product_table', 23);
INSERT INTO `migrations` VALUES (77, '2018_10_27_111943_create_stock_mvt_table', 23);
INSERT INTO `migrations` VALUES (78, '2019_01_12_235414_add_cancel_and_refund_to_order_table', 23);

-- ----------------------------
-- Table structure for note
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_support` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `note_id_support_index`(`id_support`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of note
-- ----------------------------
INSERT INTO `note` VALUES (1, 'Qui et aut rerum magnam beatae cum aut. Consequatur sed assumenda ipsam consequatur consectetur. Veniam sint tenetur neque maiores. Voluptate cumque rem est aspernatur veniam consequuntur aut.', 32, NULL, NULL);
INSERT INTO `note` VALUES (2, 'Ea ut sit natus et. Nulla laudantium distinctio aut aut. Voluptatum iure aliquid ut laudantium. Non fugiat sed harum iure voluptatem et in. Sequi molestias qui quia. Illum dicta sapiente porro dolore ut eveniet. Aut aliquam fugit quod dolorem non.', 27, NULL, NULL);
INSERT INTO `note` VALUES (3, 'Eligendi ut autem dolore voluptas in nulla quis. Consectetur voluptates quisquam temporibus architecto vitae. Laudantium doloremque quia vel vel aut. Ipsum quo qui id animi similique et officiis.', 101, NULL, NULL);
INSERT INTO `note` VALUES (4, 'Quia aut sunt voluptas laboriosam. Nemo aspernatur in ullam possimus. Iusto expedita quia temporibus natus error reprehenderit. Dolor unde vitae deserunt voluptates esse. Et ad quidem facilis quaerat ipsum nam. Culpa officia nulla sed tempora ex nam.', 48, NULL, NULL);
INSERT INTO `note` VALUES (5, 'A veritatis mollitia ut iure ullam illum aut id. Soluta fugiat architecto inventore consectetur delectus eaque aut. Nesciunt ipsa perspiciatis molestiae qui.', 33, NULL, NULL);
INSERT INTO `note` VALUES (6, 'Veritatis nam distinctio hic quia enim. Odit odit vel perspiciatis. Mollitia sed quod non deserunt ullam sed commodi.', 5, NULL, NULL);
INSERT INTO `note` VALUES (7, 'Qui voluptatem qui et nihil et. Dolor ut amet blanditiis vero eos rerum. Porro enim voluptatem pariatur cumque et et. Dolores autem odit sed cupiditate laborum vel adipisci. Veniam nemo ut aliquid harum dolore occaecati omnis. Ut qui in perferendis est.', 77, NULL, NULL);
INSERT INTO `note` VALUES (8, 'Qui labore iusto explicabo asperiores excepturi esse consectetur asperiores. Non omnis explicabo consequatur magnam ut aut. Velit tempore adipisci iste sequi. Consequatur explicabo unde esse laudantium ex est.', 98, NULL, NULL);
INSERT INTO `note` VALUES (9, 'Vitae enim tempora similique quia. Fuga id et asperiores aliquam. Dignissimos aut rerum laudantium vero ab.', 17, NULL, NULL);
INSERT INTO `note` VALUES (10, 'Recusandae fugit qui dolorum repellat quia. Molestiae placeat et iusto est dignissimos eos. Dolore quo sunt doloremque architecto et corrupti facere. Culpa qui ut ut enim sequi laboriosam adipisci repudiandae.', 33, NULL, NULL);
INSERT INTO `note` VALUES (11, 'Nam natus cumque illum. Labore alias ullam eos magnam enim ut quis quam. Non nihil eos sapiente quo. Et iure veniam sequi.', 95, NULL, NULL);
INSERT INTO `note` VALUES (12, 'Aliquam natus amet ipsum quos. Corporis voluptatibus deserunt quo eum iure sunt eos. Facilis a nulla aliquid aperiam fugit expedita. Tenetur sunt fugit sed voluptas explicabo deleniti.', 70, NULL, NULL);
INSERT INTO `note` VALUES (13, 'Et dolor vel totam facere quasi sit dolorem. Omnis impedit nihil perferendis. Iure aut qui ad voluptate id repudiandae.', 84, NULL, NULL);
INSERT INTO `note` VALUES (14, 'Et eos ea magni sint autem veritatis. Repellendus sit et quibusdam est nisi a provident. Vero vel natus qui nobis. Corrupti provident voluptatum enim ut.', 38, NULL, NULL);
INSERT INTO `note` VALUES (15, 'Qui inventore praesentium optio totam dolore et. Est et aperiam beatae voluptatibus.', 88, NULL, NULL);
INSERT INTO `note` VALUES (16, 'Pariatur sit et blanditiis sit dolores quidem ea voluptatem. Ullam repudiandae beatae optio id sed praesentium consequatur. Dolores eum natus recusandae quo voluptatibus. Est quo corporis et molestiae cum nisi officia quis.', 25, NULL, NULL);
INSERT INTO `note` VALUES (17, 'Et ea et eius est commodi suscipit. Id laboriosam est voluptatem et inventore. Consequuntur blanditiis ut tempore corrupti aut id veniam. Ipsa aut repellat vitae fugit. Atque dignissimos dolores inventore consequuntur. Ipsa non fugit praesentium et non.', 40, NULL, NULL);
INSERT INTO `note` VALUES (18, 'Incidunt nam incidunt aperiam et. Culpa quos eligendi alias possimus labore eos. Nihil quos laboriosam aut molestiae.', 79, NULL, NULL);
INSERT INTO `note` VALUES (19, 'Magnam quis accusamus illum quo est amet ut ut. Porro nam enim aut quo quia eaque. Aspernatur animi dolor cum facilis beatae fugiat. Aliquam omnis atque aut vel et et voluptatem debitis. Eveniet architecto quis sit quae aut quas iure.', 92, NULL, NULL);
INSERT INTO `note` VALUES (20, 'Quis ducimus sint facilis doloribus. Blanditiis dolor eaque repellendus aut delectus minus. Sed at fuga ut unde magnam corporis et. Molestias quasi facere autem itaque aut cupiditate non rerum. Mollitia excepturi nobis dicta odio molestias.', 75, NULL, NULL);
INSERT INTO `note` VALUES (21, 'Qui delectus consectetur aliquid est iste dolor voluptas. Quidem nam veritatis quia consequatur aut nihil odit. Corrupti dolor qui saepe soluta dicta.', 83, NULL, NULL);
INSERT INTO `note` VALUES (22, 'Beatae voluptatum rerum dicta omnis repellendus. Dolore et assumenda et. Error non occaecati qui. Minima voluptas rerum ut inventore iste. Soluta quidem consequatur ad culpa. Ut vero voluptate ut nihil rerum. Eligendi molestiae aut quae quisquam alias.', 37, NULL, NULL);
INSERT INTO `note` VALUES (23, 'Error nemo non nihil laboriosam rerum voluptatibus incidunt ipsam. Et eos recusandae id ea et minus. Assumenda officiis et reprehenderit voluptatum dicta.', 35, NULL, NULL);
INSERT INTO `note` VALUES (24, 'Aliquid quas qui rem qui. Illo enim adipisci illum id est libero quae. Cum aperiam voluptatem quod et soluta. Ut id numquam assumenda aliquid et magnam voluptatem. Ut et delectus magni dicta dolores.', 65, NULL, NULL);
INSERT INTO `note` VALUES (25, 'Facere veniam qui dolor dolor omnis. Atque enim aliquid atque non. Iure distinctio inventore sit id et iusto consequatur quo. Odio culpa corrupti et deleniti accusantium quia repellendus asperiores.', 77, NULL, NULL);
INSERT INTO `note` VALUES (26, 'Officiis laudantium et fuga suscipit quia. A mollitia molestiae voluptatum similique sit maxime incidunt. Dolores quos est sed facilis quaerat totam. Voluptatem eveniet eum architecto praesentium architecto deleniti quis.', 60, NULL, NULL);
INSERT INTO `note` VALUES (27, 'Veniam odit qui asperiores animi perspiciatis omnis consequatur possimus. Aut expedita harum enim qui. Perferendis a ea consequuntur quis cupiditate error. Porro eos excepturi porro veritatis laboriosam qui.', 21, NULL, NULL);
INSERT INTO `note` VALUES (28, 'Similique dolor aut accusamus. Est id assumenda sequi assumenda eos tempore. Incidunt rerum explicabo maiores rerum id. Pariatur quae iste soluta.', 71, NULL, NULL);
INSERT INTO `note` VALUES (29, 'Laudantium ipsa sit reiciendis minus. Blanditiis consectetur aut ut repellat ut. Eos accusantium est fugit tempore molestias vero. In architecto rerum non ullam.', 101, NULL, NULL);
INSERT INTO `note` VALUES (30, 'Vero adipisci maiores corporis qui debitis. Est aut sed voluptate inventore libero sequi. Sit facilis omnis minus natus quae praesentium sed temporibus. Ipsum similique blanditiis magni.', 73, NULL, NULL);
INSERT INTO `note` VALUES (31, 'Quia autem vitae non consequuntur nostrum esse rerum. Laboriosam incidunt illum et ipsam. Tempora aut molestiae perspiciatis iure quo earum sequi similique.', 55, NULL, NULL);
INSERT INTO `note` VALUES (32, 'In quis quia commodi maxime sit. Quaerat aliquam similique autem et sed. Eos rerum voluptatem dolorem voluptate. Commodi eaque est sed.', 91, NULL, NULL);
INSERT INTO `note` VALUES (33, 'Nobis ut nemo et qui. Laudantium eveniet id autem blanditiis sed. Eos vitae odio laboriosam. Voluptatem voluptatem dicta maiores dolor reiciendis est non. Vel est reiciendis necessitatibus fugit.', 46, NULL, NULL);
INSERT INTO `note` VALUES (34, 'Doloremque consectetur ipsa sint quibusdam facilis qui. Quasi ut quisquam sed quis sed vero nihil. Eligendi deleniti voluptatem reiciendis qui.', 31, NULL, NULL);
INSERT INTO `note` VALUES (35, 'Et eum sint aut. Ipsum ipsam in et est quo ratione. Facere dolore et velit numquam. In eum molestiae quasi consequatur cumque. Sed quia voluptate consequatur voluptas et. Nisi soluta est iure iure commodi provident et doloremque.', 28, NULL, NULL);
INSERT INTO `note` VALUES (36, 'Aspernatur natus quos molestiae nihil autem quis in. Suscipit ipsam quibusdam officiis beatae. Vel tempore recusandae molestias cum iure et omnis. Impedit blanditiis est qui quasi officiis voluptatibus.', 71, NULL, NULL);
INSERT INTO `note` VALUES (37, 'Sit voluptate odio consectetur est. Amet dolores animi sed dolorem sed. Beatae odio praesentium nobis rem et quod quos. Possimus qui reiciendis omnis in sunt.', 82, NULL, NULL);
INSERT INTO `note` VALUES (38, 'Ratione eos sed eveniet sint iure eum omnis. Recusandae aut illum dolore dolorum tenetur commodi quos. Officia molestias dolore aspernatur harum.', 66, NULL, NULL);
INSERT INTO `note` VALUES (39, 'Ex ipsum cum possimus. Quaerat sed cupiditate sed numquam dignissimos odio. Omnis beatae deserunt et molestiae.', 23, NULL, NULL);
INSERT INTO `note` VALUES (40, 'Provident temporibus sed molestiae assumenda amet dolorum aut. Blanditiis sapiente a exercitationem explicabo id molestias velit. Sed minus ea itaque autem.', 81, NULL, NULL);
INSERT INTO `note` VALUES (41, 'Minus inventore ut distinctio illo in nesciunt nesciunt rerum. Et impedit et unde iure quisquam nihil mollitia. Est earum eius eos ipsa saepe nesciunt nihil. Qui ut non dolore commodi.', 33, NULL, NULL);
INSERT INTO `note` VALUES (42, 'Rerum explicabo aliquam sit voluptas tempora eveniet dolorem omnis. Sit eligendi dolor dolor ut aut. Dignissimos quod labore non sit deleniti blanditiis est. Deleniti aliquam omnis error a quo possimus similique.', 88, NULL, NULL);
INSERT INTO `note` VALUES (43, 'Sunt hic nisi tenetur. Sit ad voluptatum ducimus nulla officia a et. Quaerat veniam suscipit eos voluptatum unde beatae dolores.', 59, NULL, NULL);
INSERT INTO `note` VALUES (44, 'Veniam voluptatem ut quia nemo atque et. Error aliquam perferendis et in id consequatur. Est rerum dicta modi ipsa. Libero eos fuga vel minus suscipit excepturi et.', 64, NULL, NULL);
INSERT INTO `note` VALUES (45, 'Iusto at et deleniti quam. Repellat explicabo voluptatem inventore quos aperiam est consequatur. Sint aut occaecati dolorum voluptas exercitationem eius. Et aut ducimus et officia eum.', 46, NULL, NULL);
INSERT INTO `note` VALUES (46, 'Sint quia magnam suscipit molestias fuga sed id. Enim explicabo hic possimus doloremque dolorum. Temporibus cupiditate consequatur rerum. Magni voluptas quos accusamus deleniti perferendis modi. Est iusto quae quis non voluptas consectetur rem expedita.', 78, NULL, NULL);
INSERT INTO `note` VALUES (47, 'Possimus et asperiores debitis. Fugiat ullam est quis qui impedit ipsum voluptas. Et in et eaque possimus iure. Veritatis eveniet aspernatur soluta repudiandae voluptate. Beatae animi commodi sit non laborum.', 3, NULL, NULL);
INSERT INTO `note` VALUES (48, 'Sit repellat non quia veniam. Laudantium debitis rem aut veritatis. Quisquam qui nesciunt et voluptas quibusdam quae aliquam. Odit pariatur tempore culpa dolorem iure soluta.', 60, NULL, NULL);
INSERT INTO `note` VALUES (49, 'Illum laboriosam aut quidem sequi amet iure. Optio voluptatem eveniet qui amet reprehenderit eaque voluptatum. Molestiae asperiores aut officiis hic nihil quas quos soluta. Mollitia perspiciatis sint optio aut.', 66, NULL, NULL);
INSERT INTO `note` VALUES (50, 'Ipsam rerum tempora itaque aut. Nihil consequatur molestias reprehenderit possimus quis maiores omnis. Voluptates totam non eius et vitae repellat rem dolor. Numquam voluptate et animi explicabo sapiente vel.', 97, NULL, NULL);
INSERT INTO `note` VALUES (51, 'Quaerat impedit quibusdam corporis itaque aliquam nostrum alias. Ut velit odit rerum eaque eos. Debitis aut error iusto quis alias. Id voluptatum qui quia voluptate beatae quasi quibusdam.', 35, NULL, NULL);
INSERT INTO `note` VALUES (52, 'Blanditiis minus amet hic itaque qui. Enim quia quis laborum praesentium. Harum quia soluta ratione sint omnis molestiae neque. Aperiam recusandae non quia.', 35, NULL, NULL);
INSERT INTO `note` VALUES (53, 'Nobis qui excepturi harum qui vel. Facere pariatur deserunt provident modi libero voluptas veniam. Omnis fuga aliquam laborum numquam explicabo. Sunt ratione aut qui consequatur. Aliquid voluptates alias et possimus voluptatem aut. Sunt ea aut et.', 33, NULL, NULL);
INSERT INTO `note` VALUES (54, 'Et autem delectus repellendus adipisci enim amet beatae. Ex corrupti minima quidem fugit consequatur non. Dolorem vero tempora numquam quos consequatur aut sed. Sit accusantium vel in qui.', 87, NULL, NULL);
INSERT INTO `note` VALUES (55, 'Occaecati magnam porro laboriosam nemo est maiores tempora. Velit eum rem voluptates illo sapiente. Ex neque omnis enim dolorem. Rerum harum earum minima beatae qui.', 94, NULL, NULL);
INSERT INTO `note` VALUES (56, 'Ex aliquid rerum deserunt atque enim. Nihil veritatis dignissimos soluta dolor totam quod ea.', 53, NULL, NULL);
INSERT INTO `note` VALUES (57, 'Velit et autem magni architecto voluptatum culpa. Excepturi consequuntur iusto dignissimos eligendi. At porro quos atque. Dolor dolor tempora natus magni pariatur voluptatum doloribus.', 34, NULL, NULL);
INSERT INTO `note` VALUES (58, 'Tempora quo rerum doloribus. Est unde qui laboriosam et enim atque et hic. Qui atque sed sed ut totam inventore quidem mollitia. Numquam atque ea culpa voluptatibus.', 63, NULL, NULL);
INSERT INTO `note` VALUES (59, 'Distinctio doloribus dicta eaque dolorum. Autem amet amet rem nihil qui. Distinctio est exercitationem ut. Et ab maiores quisquam dolore. Non maxime cumque laudantium ea blanditiis.', 63, NULL, NULL);
INSERT INTO `note` VALUES (60, 'Sit sapiente possimus occaecati maiores. Est aut exercitationem numquam distinctio deserunt sunt. Modi molestiae quia et earum.', 46, NULL, NULL);
INSERT INTO `note` VALUES (61, 'Totam occaecati excepturi voluptas consequuntur illo et. Sequi perferendis aperiam magnam commodi omnis. Veniam est nisi dignissimos quasi. Laboriosam qui corporis molestiae rerum.', 6, NULL, NULL);
INSERT INTO `note` VALUES (62, 'Placeat quasi ut ut accusantium. Voluptatum optio nam illum illo ipsa voluptas. Voluptatibus quo quam delectus aut itaque ea rerum. Necessitatibus assumenda aut odit est ut consequatur. Vitae quis magni accusamus qui corporis aliquid consequatur.', 72, NULL, NULL);
INSERT INTO `note` VALUES (63, 'Ut nesciunt suscipit rerum. Quos explicabo aliquam soluta alias expedita ut voluptatum. Illo voluptate itaque ipsum. Repellat porro dolorem delectus ullam temporibus dolorem voluptates unde.', 6, NULL, NULL);
INSERT INTO `note` VALUES (64, 'Id sint id magnam nesciunt quo. Ex unde molestiae ea quo dolorem quaerat sed nesciunt. Animi voluptatem vel dolores. Omnis necessitatibus nisi molestiae eligendi.', 52, NULL, NULL);
INSERT INTO `note` VALUES (65, 'Quod aut quasi aut omnis totam aliquam. Et dignissimos labore iure vel omnis corporis. Dicta natus aut distinctio error alias voluptatum voluptatem.', 40, NULL, NULL);
INSERT INTO `note` VALUES (66, 'Blanditiis enim eius ut dignissimos cupiditate maxime natus. Ratione est distinctio labore at non. Dolore dolorem iure explicabo incidunt cum natus. Qui ipsa dolorem voluptatem recusandae adipisci laudantium cupiditate.', 8, NULL, NULL);
INSERT INTO `note` VALUES (67, 'Ut aut officia molestiae voluptatibus. Accusantium exercitationem nulla qui aperiam modi repellendus. Eum dicta saepe voluptas commodi quod.', 22, NULL, NULL);
INSERT INTO `note` VALUES (68, 'Accusantium qui rem eum nam. Ut et consectetur aspernatur ut doloribus omnis odit. Eos vel dolor et sapiente. Veniam quam dolorem ex quo aliquid id aut. Id fuga id magnam consequuntur optio facere. Libero id reprehenderit eius non error.', 11, NULL, NULL);
INSERT INTO `note` VALUES (69, 'Sunt cumque ut voluptate eaque dolorem. Sed ut eum doloribus voluptatem. Ut vero in voluptatem vero magnam eius. Nisi fuga itaque at. Voluptatibus architecto quo non sunt nulla alias. Omnis omnis vero et ut. Velit non quasi suscipit ut et qui.', 36, NULL, NULL);
INSERT INTO `note` VALUES (70, 'Et veritatis ut nostrum ut. Ea repellendus non minus sit esse. Labore est perferendis accusantium qui praesentium. Sunt pariatur omnis dolore temporibus perferendis assumenda tenetur.', 72, NULL, NULL);
INSERT INTO `note` VALUES (71, 'Ab non nesciunt non occaecati omnis maiores voluptate. Iure ad et quaerat necessitatibus. Quis praesentium repudiandae occaecati deleniti ut delectus odio aut.', 88, NULL, NULL);
INSERT INTO `note` VALUES (72, 'Alias voluptas odio eum facere quo consectetur. Illo quia enim ratione deleniti. Nisi est odit quo accusamus. Ipsam et rem sequi non eos rem. Et est et eum eius. Vel natus et accusamus velit molestiae. Hic iste laborum voluptatibus odit nam.', 83, NULL, NULL);
INSERT INTO `note` VALUES (73, 'Assumenda dolor cum dolore iure consectetur. Architecto nisi et maxime id necessitatibus velit.', 96, NULL, NULL);
INSERT INTO `note` VALUES (74, 'Eligendi et animi nam dolor maiores natus. Assumenda sapiente incidunt dolores ut fugiat ut laboriosam. Autem quia beatae error repellendus. Fugit quo cumque natus qui aliquam.', 31, NULL, NULL);
INSERT INTO `note` VALUES (75, 'Rerum et atque tempora qui pariatur. Et cumque molestiae atque veritatis laboriosam. Praesentium omnis ipsam corporis aut eligendi.', 97, NULL, NULL);
INSERT INTO `note` VALUES (76, 'Ea fugit voluptatum rerum dolores pariatur. Voluptas temporibus corporis commodi inventore deserunt. Mollitia suscipit et laudantium ad et delectus perferendis. Cupiditate ipsam odit fugiat inventore similique.', 47, NULL, NULL);
INSERT INTO `note` VALUES (77, 'Expedita a quidem voluptatibus. Aut quidem voluptas recusandae inventore eos. Sed quia itaque nobis ut saepe. Ipsa in quos tempora sint. Molestiae deleniti placeat at ea aut repellat.', 56, NULL, NULL);
INSERT INTO `note` VALUES (78, 'Nobis magni sapiente enim voluptas corporis nesciunt eum voluptas. Totam distinctio necessitatibus cum ab voluptatem aut eos. Totam fugiat cupiditate velit.', 66, NULL, NULL);
INSERT INTO `note` VALUES (79, 'Nobis non cumque qui. Hic commodi quae et eius et necessitatibus. Et magnam est rerum omnis atque. Rerum facere consectetur distinctio vel et. Id doloremque sint quidem delectus. Suscipit unde dolor quasi sequi officia et consequatur voluptas.', 91, NULL, NULL);
INSERT INTO `note` VALUES (80, 'Dicta sequi non sint mollitia sed et et. Voluptas tempora quia nobis non placeat. Mollitia vel et commodi qui voluptatibus qui.', 6, NULL, NULL);
INSERT INTO `note` VALUES (81, 'Omnis est quia fuga dolor similique. Itaque enim debitis perspiciatis reprehenderit quod in aspernatur. Velit blanditiis minima id corrupti aut.', 100, NULL, NULL);
INSERT INTO `note` VALUES (82, 'Odio ad et quos molestias qui aspernatur voluptatum placeat. Voluptatem repellendus accusamus voluptatem rerum quam. Exercitationem fuga non veniam voluptatem ab rerum.', 11, NULL, NULL);
INSERT INTO `note` VALUES (83, 'Veritatis possimus culpa rerum aut in. Occaecati veniam et quas sint et quos aut. Vero deserunt natus natus ut sed. Voluptate vitae similique nihil provident quia dignissimos recusandae. Voluptates nihil quo et facilis animi consectetur maxime numquam.', 32, NULL, NULL);
INSERT INTO `note` VALUES (84, 'Facilis sint rerum maiores quis libero omnis. Sunt aliquid tenetur exercitationem praesentium non excepturi. Eligendi architecto dignissimos ab sint ex perferendis quia. Officia omnis hic et omnis quisquam.', 42, NULL, NULL);
INSERT INTO `note` VALUES (85, 'Voluptate odio cupiditate quas dolore dignissimos quia. Omnis exercitationem sit fuga iure ut est dolorem. Quisquam placeat consequuntur eum. Quo nemo qui consectetur maxime. Officia nam modi temporibus dolorem voluptatibus et totam laudantium.', 79, NULL, NULL);
INSERT INTO `note` VALUES (86, 'Harum nostrum earum sunt dolor. Rerum qui nulla a non quisquam nihil. Recusandae molestias blanditiis occaecati aliquid natus perferendis.', 89, NULL, NULL);
INSERT INTO `note` VALUES (87, 'Ab et et nihil. Aperiam ut corrupti quae et ex. Tempora temporibus quae accusantium ducimus ex. Delectus eius veritatis inventore.', 52, NULL, NULL);
INSERT INTO `note` VALUES (88, 'Qui omnis nihil assumenda. Similique maiores officiis hic error. Iusto deleniti officiis nobis ullam soluta vel natus. Exercitationem saepe qui repellat quia debitis ad in.', 74, NULL, NULL);
INSERT INTO `note` VALUES (89, 'Aut doloribus harum et est quia sed necessitatibus. Vitae quod voluptas suscipit fuga reprehenderit. Aperiam harum eum sint dolorem. Ut quasi nobis iusto aut et. Sequi blanditiis unde repudiandae laudantium architecto facilis.', 37, NULL, NULL);
INSERT INTO `note` VALUES (90, 'Aliquid omnis explicabo pariatur iste natus consequatur. Nisi qui vel corrupti est est harum nulla.', 19, NULL, NULL);
INSERT INTO `note` VALUES (91, 'Quisquam omnis minus qui dolorem possimus repellat nostrum. Libero voluptatibus voluptatem accusantium aut dolorem quos. Qui non et qui perferendis et et quia. Nihil aut voluptatibus omnis ut ipsum qui. Doloribus aut facilis ipsa.', 21, NULL, NULL);
INSERT INTO `note` VALUES (92, 'Commodi illum repudiandae enim quasi placeat sit architecto. Fuga deleniti sit quidem quod et. In pariatur accusamus excepturi molestias. Esse voluptatem magnam qui earum optio culpa delectus.', 43, NULL, NULL);
INSERT INTO `note` VALUES (93, 'Sunt dicta facilis beatae placeat et sequi reprehenderit. Voluptates optio doloremque facilis aliquid minus harum modi. Tenetur nostrum aut et nobis aliquam.', 66, NULL, NULL);
INSERT INTO `note` VALUES (94, 'Et id et inventore nostrum voluptatem aut. Ab nostrum enim esse fugiat. Beatae ut sunt recusandae nulla voluptas distinctio omnis.', 39, NULL, NULL);
INSERT INTO `note` VALUES (95, 'Non totam qui qui voluptatum maiores et. Et quis quibusdam et amet dolores suscipit. Aut quia qui sunt alias ipsam cumque nobis.', 54, NULL, NULL);
INSERT INTO `note` VALUES (96, 'Et quas quis hic rem sint. Ducimus dolore et et animi molestiae. Sapiente cumque voluptas rerum eius quae quia vel. Facilis asperiores amet et qui. Culpa et aspernatur corporis tempore numquam quam. Voluptatibus aut facilis odio qui quis.', 39, NULL, NULL);
INSERT INTO `note` VALUES (97, 'Sint fugiat sit est asperiores. Unde velit earum quia sed. Deserunt mollitia in sit. Quibusdam voluptatem exercitationem nesciunt quia et. Iste asperiores aut quo labore omnis. Ut unde labore quis corrupti expedita iure.', 58, NULL, NULL);
INSERT INTO `note` VALUES (98, 'Consequatur deserunt facilis sunt. Inventore molestiae expedita optio eligendi. Error modi molestiae modi quo itaque. Dolorem et et nesciunt non dolorem aut id illum. Quidem aut sint inventore omnis magnam. Libero sunt praesentium distinctio qui.', 84, NULL, NULL);
INSERT INTO `note` VALUES (99, 'Velit ut corporis voluptatem ut eos autem repudiandae. Facilis dolore optio officia sed omnis esse et. Magnam voluptas delectus similique distinctio. Occaecati vel inventore dolorum quo qui magnam voluptatem numquam. Et fugit est deleniti totam id.', 29, NULL, NULL);
INSERT INTO `note` VALUES (100, 'Id omnis doloribus saepe corporis nihil illum non. Eum molestiae voluptatibus voluptatem debitis nostrum eligendi quae neque.', 68, NULL, NULL);
INSERT INTO `note` VALUES (101, 'Cupiditate quibusdam dolorum incidunt aut qui. Rerum accusamus sequi in aut voluptatem. Nemo cumque id quo enim quasi. Non voluptatem atque est animi nostrum tenetur.', 36, NULL, NULL);
INSERT INTO `note` VALUES (102, 'fgfd', 103, '2018-09-28 16:22:10', '2018-09-28 16:22:10');
INSERT INTO `note` VALUES (103, 'dfdsfd', 105, '2018-10-22 11:09:23', '2018-10-22 11:09:23');
INSERT INTO `note` VALUES (104, 'note 1', 107, '2018-10-29 08:47:34', '2018-10-29 08:47:34');
INSERT INTO `note` VALUES (105, 'fsdf', 108, '2018-10-29 09:10:53', '2018-10-29 09:10:53');
INSERT INTO `note` VALUES (106, 'fsdf', 108, '2018-10-29 09:10:53', '2018-10-29 09:10:53');
INSERT INTO `note` VALUES (107, 'fsdfds', 108, '2018-10-29 09:10:53', '2018-10-29 09:10:53');
INSERT INTO `note` VALUES (108, 'note 1', 109, '2018-11-06 02:17:53', '2018-11-06 02:17:53');
INSERT INTO `note` VALUES (109, 'note 2', 109, '2018-11-06 02:18:10', '2018-11-06 02:18:10');
INSERT INTO `note` VALUES (110, 'note 3', 109, '2018-11-06 02:18:10', '2018-11-06 02:18:10');
INSERT INTO `note` VALUES (111, 'note 1 ok today', 110, '2018-11-06 02:18:59', '2018-11-15 10:31:03');
INSERT INTO `note` VALUES (112, 'note 2', 110, '2018-11-06 02:18:59', '2018-11-06 02:18:59');
INSERT INTO `note` VALUES (113, '112', 111, '2018-11-09 10:56:36', '2018-11-17 11:14:16');
INSERT INTO `note` VALUES (114, 'ĐÃ THANH TOÁN', 114, '2018-11-10 09:51:42', '2018-11-10 09:51:42');
INSERT INTO `note` VALUES (115, 'đang đợi ship', 115, '2018-11-10 10:00:07', '2018-11-10 10:00:07');
INSERT INTO `note` VALUES (116, 'sdgdgdfh', 115, '2018-11-10 10:02:09', '2018-11-10 10:02:09');
INSERT INTO `note` VALUES (117, 'aaaaaaaaaa', 116, '2018-11-10 10:11:29', '2018-11-10 10:11:29');
INSERT INTO `note` VALUES (118, 'chinh test', 117, '2018-11-10 10:15:18', '2018-11-10 10:15:18');
INSERT INTO `note` VALUES (119, 'test', 118, '2018-11-12 08:25:53', '2018-11-12 08:25:53');
INSERT INTO `note` VALUES (120, 'how are you', 119, '2018-11-12 09:12:43', '2018-11-12 09:12:43');
INSERT INTO `note` VALUES (121, 'sss', 120, '2018-11-12 09:45:49', '2018-11-12 09:45:49');
INSERT INTO `note` VALUES (122, '00', 109, '2018-11-17 11:48:29', '2018-11-17 11:48:29');
INSERT INTO `note` VALUES (123, '123', 123, '2018-11-17 12:03:42', '2018-11-17 12:03:42');
INSERT INTO `note` VALUES (124, '123', 123, '2018-11-17 12:03:42', '2018-11-17 12:03:42');
INSERT INTO `note` VALUES (125, '123', 110, '2018-11-17 12:04:43', '2018-11-17 12:04:43');
INSERT INTO `note` VALUES (126, '112', 116, '2018-11-17 14:24:03', '2018-11-17 14:24:03');
INSERT INTO `note` VALUES (127, '123', 112, '2018-11-17 14:24:58', '2018-11-17 14:24:58');
INSERT INTO `note` VALUES (128, 'củ chuối.com', 113, '2018-11-20 17:20:33', '2018-11-20 17:20:33');
INSERT INTO `note` VALUES (129, NULL, 127, '2018-11-25 09:20:37', '2018-11-25 09:20:37');
INSERT INTO `note` VALUES (130, NULL, 127, '2018-11-25 09:32:31', '2018-11-25 09:32:31');
INSERT INTO `note` VALUES (131, NULL, 127, '2018-11-25 09:32:58', '2018-11-25 09:32:58');
INSERT INTO `note` VALUES (132, NULL, 127, '2018-11-25 09:32:58', '2018-11-25 09:32:58');
INSERT INTO `note` VALUES (133, 'ádfasdfasdf', 126, '2018-11-25 09:57:48', '2018-11-25 09:57:48');
INSERT INTO `note` VALUES (134, '12', 128, '2018-11-25 12:20:41', '2018-11-25 12:20:41');
INSERT INTO `note` VALUES (135, 'Note #1', 125, '2018-11-26 18:39:19', '2018-11-26 18:39:19');
INSERT INTO `note` VALUES (136, 'Note #2', 125, '2018-11-26 18:39:19', '2018-11-26 18:39:19');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cart` int(10) UNSIGNED NOT NULL,
  `id_customer` int(10) UNSIGNED NOT NULL,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `id_address` int(10) UNSIGNED NOT NULL,
  `id_carrier` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_status` tinyint(4) NOT NULL,
  `payment` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_ship` date NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `total_discount` decimal(12, 2) NULL DEFAULT NULL,
  `total_shipping` decimal(12, 2) NULL DEFAULT NULL,
  `total_product` decimal(12, 2) NULL DEFAULT NULL,
  `total_paid` decimal(12, 2) NULL DEFAULT NULL,
  `total_unpaid` decimal(12, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_payment_fee` decimal(8, 2) NULL DEFAULT NULL,
  `archive` int(11) NOT NULL DEFAULT 0,
  `position` tinyint(4) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_cart_index`(`id_cart`) USING BTREE,
  INDEX `order_id_customer_index`(`id_customer`) USING BTREE,
  INDEX `order_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `order_id_address_index`(`id_address`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kg` decimal(8, 2) NOT NULL,
  `price` decimal(12, 2) NULL DEFAULT NULL,
  `id_hair_size` int(10) UNSIGNED NOT NULL,
  `id_cart_product` int(10) UNSIGNED NOT NULL,
  `id_hair_type` int(10) UNSIGNED NOT NULL,
  `id_hair_color` int(10) UNSIGNED NOT NULL,
  `id_hair_draw` int(10) UNSIGNED NOT NULL,
  `id_hair_style` int(10) UNSIGNED NOT NULL,
  `total` decimal(12, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `id_order` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_detail_id_hair_size_index`(`id_hair_size`) USING BTREE,
  INDEX `order_detail_id_cart_product_index`(`id_cart_product`) USING BTREE,
  INDEX `order_detail_id_hair_type_index`(`id_hair_type`) USING BTREE,
  INDEX `order_detail_id_hair_color_index`(`id_hair_color`) USING BTREE,
  INDEX `order_detail_id_hair_draw_index`(`id_hair_draw`) USING BTREE,
  INDEX `order_detail_id_hair_style_index`(`id_hair_style`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for order_history
-- ----------------------------
DROP TABLE IF EXISTS `order_history`;
CREATE TABLE `order_history`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `id_order` int(10) UNSIGNED NOT NULL,
  `id_order_state` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_history_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `order_history_id_order_index`(`id_order`) USING BTREE,
  INDEX `order_history_id_order_state_index`(`id_order_state`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for order_payment
-- ----------------------------
DROP TABLE IF EXISTS `order_payment`;
CREATE TABLE `order_payment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_payment` int(10) UNSIGNED NOT NULL,
  `id_order` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_payment_id_payment_index`(`id_payment`) USING BTREE,
  INDEX `order_payment_id_order_index`(`id_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for order_state
-- ----------------------------
DROP TABLE IF EXISTS `order_state`;
CREATE TABLE `order_state`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for order_status
-- ----------------------------
DROP TABLE IF EXISTS `order_status`;
CREATE TABLE `order_status`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for paid_order
-- ----------------------------
DROP TABLE IF EXISTS `paid_order`;
CREATE TABLE `paid_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_order` int(11) NOT NULL,
  `paid` decimal(12, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `id_payment` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `payment_fee` float(3, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES (22, 'PP(FAMILY)', '2018-11-09 15:47:27', '2018-11-20 14:28:34', 0);
INSERT INTO `payment` VALUES (23, 'WU', '2018-11-09 16:11:18', '2018-11-09 16:11:18', 0);
INSERT INTO `payment` VALUES (24, 'MG', '2018-11-09 16:11:28', '2018-11-09 16:11:28', 0);
INSERT INTO `payment` VALUES (25, 'World Remit', '2018-11-09 16:11:44', '2018-11-09 16:11:44', 0);
INSERT INTO `payment` VALUES (26, 'BANK', '2018-11-09 16:11:59', '2018-11-09 16:11:59', 0);
INSERT INTO `payment` VALUES (27, 'RIA', '2018-11-09 16:12:08', '2018-11-09 16:12:08', 0);
INSERT INTO `payment` VALUES (28, 'LEADER', '2018-11-09 16:12:20', '2018-11-09 16:12:20', 0);

-- ----------------------------
-- Table structure for procedure
-- ----------------------------
DROP TABLE IF EXISTS `procedure`;
CREATE TABLE `procedure`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of procedure
-- ----------------------------
INSERT INTO `procedure` VALUES (6, 'OFFICE', '6', '2018-09-25 23:07:46', '2018-12-22 20:18:17');
INSERT INTO `procedure` VALUES (7, 'FACTORY', '2', '2018-11-10 09:38:56', '2018-11-10 09:38:56');

-- ----------------------------
-- Table structure for procedure_step
-- ----------------------------
DROP TABLE IF EXISTS `procedure_step`;
CREATE TABLE `procedure_step`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_procedure` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `procedure_step_id_procedure_index`(`id_procedure`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of procedure_step
-- ----------------------------
INSERT INTO `procedure_step` VALUES (1, 1, 'step 1', 1, NULL, NULL);
INSERT INTO `procedure_step` VALUES (2, 2, 'step 2', 2, NULL, NULL);
INSERT INTO `procedure_step` VALUES (3, 4, 'fsdfd', 0, '2018-09-25 23:05:05', '2018-09-25 23:05:05');
INSERT INTO `procedure_step` VALUES (4, 4, 'fsdfds', 1, '2018-09-25 23:05:05', '2018-09-25 23:05:05');
INSERT INTO `procedure_step` VALUES (5, 4, 'fsdfd', 2, '2018-09-25 23:05:05', '2018-09-25 23:05:05');
INSERT INTO `procedure_step` VALUES (6, 5, 'fdsf', 0, '2018-09-25 23:06:58', '2018-09-25 23:06:58');
INSERT INTO `procedure_step` VALUES (7, 5, 'fsdfd', 1, '2018-09-25 23:06:58', '2018-09-25 23:06:58');
INSERT INTO `procedure_step` VALUES (8, 6, 'CHECKED BY LEADER', 0, '2018-09-25 23:07:46', '2018-11-10 09:38:21');
INSERT INTO `procedure_step` VALUES (9, 6, 'PROBLEMS', 1, '2018-09-25 23:07:46', '2018-11-10 09:38:21');
INSERT INTO `procedure_step` VALUES (10, 6, 'SOLUTIONS', 2, '2018-09-25 23:07:46', '2018-11-09 15:15:19');
INSERT INTO `procedure_step` VALUES (15, 8, 'a', 0, '2018-09-26 11:22:06', '2018-09-26 11:22:06');
INSERT INTO `procedure_step` VALUES (16, 8, 'dsa', 1, '2018-09-26 11:22:06', '2018-09-26 11:22:06');
INSERT INTO `procedure_step` VALUES (17, 8, 'dsadsad', 2, '2018-09-26 11:22:06', '2018-09-26 11:22:06');
INSERT INTO `procedure_step` VALUES (18, 6, 'SOLVING', 3, '2018-09-26 21:02:40', '2018-11-09 15:15:19');
INSERT INTO `procedure_step` VALUES (20, 6, 'FINISHED', 4, '2018-10-02 22:41:10', '2018-11-09 15:15:19');
INSERT INTO `procedure_step` VALUES (22, 7, '2', 1, '2018-11-10 09:38:56', '2018-11-10 09:38:56');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NULL DEFAULT NULL,
  `hair_size_id` int(11) NULL DEFAULT NULL,
  `hair_style_id` int(11) NULL DEFAULT NULL,
  `hair_type_id` int(11) NULL DEFAULT NULL,
  `hair_color_id` int(11) NULL DEFAULT NULL,
  `quantity` double(8, 2) NULL DEFAULT NULL,
  `classtify` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `standard` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `barcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for report_hair_style_type
-- ----------------------------
DROP TABLE IF EXISTS `report_hair_style_type`;
CREATE TABLE `report_hair_style_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_hair_type` int(11) NOT NULL,
  `id_hair_style` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of report_hair_style_type
-- ----------------------------
INSERT INTO `report_hair_style_type` VALUES (1, 3, 3, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (2, 4, 3, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (3, 3, 4, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (4, 4, 4, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (5, 4, 27, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (6, 3, 27, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (7, 28, 3, NULL, NULL);
INSERT INTO `report_hair_style_type` VALUES (8, 28, 7, NULL, NULL);

-- ----------------------------
-- Table structure for sale_commision
-- ----------------------------
DROP TABLE IF EXISTS `sale_commision`;
CREATE TABLE `sale_commision`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_kg` float(255, 0) NULL DEFAULT NULL,
  `condition` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `commission` float(255, 0) NULL DEFAULT NULL,
  `commission_per_kg` float(255, 0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `max_kg` float(255, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sale_commission_employee
-- ----------------------------
DROP TABLE IF EXISTS `sale_commission_employee`;
CREATE TABLE `sale_commission_employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_employee` int(255) NULL DEFAULT NULL,
  `id_order` int(255) NULL DEFAULT NULL,
  `sale_commission` float(255, 0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS `state`;
CREATE TABLE `state`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_country` int(11) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of state
-- ----------------------------
INSERT INTO `state` VALUES (1, 101, 'Andaman and Nicobar Islands', NULL, NULL);
INSERT INTO `state` VALUES (2, 101, 'Andhra Pradesh', NULL, NULL);
INSERT INTO `state` VALUES (3, 101, 'Arunachal Pradesh', NULL, NULL);
INSERT INTO `state` VALUES (4, 101, 'Assam', NULL, NULL);
INSERT INTO `state` VALUES (5, 101, 'Bihar', NULL, NULL);
INSERT INTO `state` VALUES (6, 101, 'Chandigarh', NULL, NULL);
INSERT INTO `state` VALUES (7, 101, 'Chhattisgarh', NULL, NULL);
INSERT INTO `state` VALUES (8, 101, 'Dadra and Nagar Haveli', NULL, NULL);
INSERT INTO `state` VALUES (9, 101, 'Daman and Diu', NULL, NULL);
INSERT INTO `state` VALUES (10, 101, 'Delhi', NULL, NULL);
INSERT INTO `state` VALUES (11, 101, 'Goa', NULL, NULL);
INSERT INTO `state` VALUES (12, 101, 'Gujarat', NULL, NULL);
INSERT INTO `state` VALUES (13, 101, 'Haryana', NULL, NULL);
INSERT INTO `state` VALUES (14, 101, 'Himachal Pradesh', NULL, NULL);
INSERT INTO `state` VALUES (15, 101, 'Jammu and Kashmir', NULL, NULL);
INSERT INTO `state` VALUES (16, 101, 'Jharkhand', NULL, NULL);
INSERT INTO `state` VALUES (17, 101, 'Karnataka', NULL, NULL);
INSERT INTO `state` VALUES (18, 101, 'Kenmore', NULL, NULL);
INSERT INTO `state` VALUES (19, 101, 'Kerala', NULL, NULL);
INSERT INTO `state` VALUES (20, 101, 'Lakshadweep', NULL, NULL);
INSERT INTO `state` VALUES (21, 101, 'Madhya Pradesh', NULL, NULL);
INSERT INTO `state` VALUES (22, 101, 'Maharashtra', NULL, NULL);
INSERT INTO `state` VALUES (23, 101, 'Manipur', NULL, NULL);
INSERT INTO `state` VALUES (24, 101, 'Meghalaya', NULL, NULL);
INSERT INTO `state` VALUES (25, 101, 'Mizoram', NULL, NULL);
INSERT INTO `state` VALUES (26, 101, 'Nagaland', NULL, NULL);
INSERT INTO `state` VALUES (27, 101, 'Narora', NULL, NULL);
INSERT INTO `state` VALUES (28, 101, 'Natwar', NULL, NULL);
INSERT INTO `state` VALUES (29, 101, 'Odisha', NULL, NULL);
INSERT INTO `state` VALUES (30, 101, 'Paschim Medinipur', NULL, NULL);
INSERT INTO `state` VALUES (31, 101, 'Pondicherry', NULL, NULL);
INSERT INTO `state` VALUES (32, 101, 'Punjab', NULL, NULL);
INSERT INTO `state` VALUES (33, 101, 'Rajasthan', NULL, NULL);
INSERT INTO `state` VALUES (34, 101, 'Sikkim', NULL, NULL);
INSERT INTO `state` VALUES (35, 101, 'Tamil Nadu', NULL, NULL);
INSERT INTO `state` VALUES (36, 101, 'Telangana', NULL, NULL);
INSERT INTO `state` VALUES (37, 101, 'Tripura', NULL, NULL);
INSERT INTO `state` VALUES (38, 101, 'Uttar Pradesh', NULL, NULL);
INSERT INTO `state` VALUES (39, 101, 'Uttarakhand', NULL, NULL);
INSERT INTO `state` VALUES (40, 101, 'Vaishali', NULL, NULL);
INSERT INTO `state` VALUES (41, 101, 'West Bengal', NULL, NULL);
INSERT INTO `state` VALUES (42, 1, 'Badakhshan', NULL, NULL);
INSERT INTO `state` VALUES (43, 1, 'Badgis', NULL, NULL);
INSERT INTO `state` VALUES (44, 1, 'Baglan', NULL, NULL);
INSERT INTO `state` VALUES (45, 1, 'Balkh', NULL, NULL);
INSERT INTO `state` VALUES (46, 1, 'Bamiyan', NULL, NULL);
INSERT INTO `state` VALUES (47, 1, 'Farah', NULL, NULL);
INSERT INTO `state` VALUES (48, 1, 'Faryab', NULL, NULL);
INSERT INTO `state` VALUES (49, 1, 'Gawr', NULL, NULL);
INSERT INTO `state` VALUES (50, 1, 'Gazni', NULL, NULL);
INSERT INTO `state` VALUES (51, 1, 'Herat', NULL, NULL);
INSERT INTO `state` VALUES (52, 1, 'Hilmand', NULL, NULL);
INSERT INTO `state` VALUES (53, 1, 'Jawzjan', NULL, NULL);
INSERT INTO `state` VALUES (54, 1, 'Kabul', NULL, NULL);
INSERT INTO `state` VALUES (55, 1, 'Kapisa', NULL, NULL);
INSERT INTO `state` VALUES (56, 1, 'Khawst', NULL, NULL);
INSERT INTO `state` VALUES (57, 1, 'Kunar', NULL, NULL);
INSERT INTO `state` VALUES (58, 1, 'Lagman', NULL, NULL);
INSERT INTO `state` VALUES (59, 1, 'Lawghar', NULL, NULL);
INSERT INTO `state` VALUES (60, 1, 'Nangarhar', NULL, NULL);
INSERT INTO `state` VALUES (61, 1, 'Nimruz', NULL, NULL);
INSERT INTO `state` VALUES (62, 1, 'Nuristan', NULL, NULL);
INSERT INTO `state` VALUES (63, 1, 'Paktika', NULL, NULL);
INSERT INTO `state` VALUES (64, 1, 'Paktiya', NULL, NULL);
INSERT INTO `state` VALUES (65, 1, 'Parwan', NULL, NULL);
INSERT INTO `state` VALUES (66, 1, 'Qandahar', NULL, NULL);
INSERT INTO `state` VALUES (67, 1, 'Qunduz', NULL, NULL);
INSERT INTO `state` VALUES (68, 1, 'Samangan', NULL, NULL);
INSERT INTO `state` VALUES (69, 1, 'Sar-e Pul', NULL, NULL);
INSERT INTO `state` VALUES (70, 1, 'Takhar', NULL, NULL);
INSERT INTO `state` VALUES (71, 1, 'Uruzgan', NULL, NULL);
INSERT INTO `state` VALUES (72, 1, 'Wardak', NULL, NULL);
INSERT INTO `state` VALUES (73, 1, 'Zabul', NULL, NULL);
INSERT INTO `state` VALUES (74, 2, 'Berat', NULL, NULL);
INSERT INTO `state` VALUES (75, 2, 'Bulqize', NULL, NULL);
INSERT INTO `state` VALUES (76, 2, 'Delvine', NULL, NULL);
INSERT INTO `state` VALUES (77, 2, 'Devoll', NULL, NULL);
INSERT INTO `state` VALUES (78, 2, 'Dibre', NULL, NULL);
INSERT INTO `state` VALUES (79, 2, 'Durres', NULL, NULL);
INSERT INTO `state` VALUES (80, 2, 'Elbasan', NULL, NULL);
INSERT INTO `state` VALUES (81, 2, 'Fier', NULL, NULL);
INSERT INTO `state` VALUES (82, 2, 'Gjirokaster', NULL, NULL);
INSERT INTO `state` VALUES (83, 2, 'Gramsh', NULL, NULL);
INSERT INTO `state` VALUES (84, 2, 'Has', NULL, NULL);
INSERT INTO `state` VALUES (85, 2, 'Kavaje', NULL, NULL);
INSERT INTO `state` VALUES (86, 2, 'Kolonje', NULL, NULL);
INSERT INTO `state` VALUES (87, 2, 'Korce', NULL, NULL);
INSERT INTO `state` VALUES (88, 2, 'Kruje', NULL, NULL);
INSERT INTO `state` VALUES (89, 2, 'Kucove', NULL, NULL);
INSERT INTO `state` VALUES (90, 2, 'Kukes', NULL, NULL);
INSERT INTO `state` VALUES (91, 2, 'Kurbin', NULL, NULL);
INSERT INTO `state` VALUES (92, 2, 'Lezhe', NULL, NULL);
INSERT INTO `state` VALUES (93, 2, 'Librazhd', NULL, NULL);
INSERT INTO `state` VALUES (94, 2, 'Lushnje', NULL, NULL);
INSERT INTO `state` VALUES (95, 2, 'Mallakaster', NULL, NULL);
INSERT INTO `state` VALUES (96, 2, 'Malsi e Madhe', NULL, NULL);
INSERT INTO `state` VALUES (97, 2, 'Mat', NULL, NULL);
INSERT INTO `state` VALUES (98, 2, 'Mirdite', NULL, NULL);
INSERT INTO `state` VALUES (99, 2, 'Peqin', NULL, NULL);
INSERT INTO `state` VALUES (100, 2, 'Permet', NULL, NULL);
INSERT INTO `state` VALUES (101, 2, 'Pogradec', NULL, NULL);
INSERT INTO `state` VALUES (102, 2, 'Puke', NULL, NULL);
INSERT INTO `state` VALUES (103, 2, 'Sarande', NULL, NULL);
INSERT INTO `state` VALUES (104, 2, 'Shkoder', NULL, NULL);
INSERT INTO `state` VALUES (105, 2, 'Skrapar', NULL, NULL);
INSERT INTO `state` VALUES (106, 2, 'Tepelene', NULL, NULL);
INSERT INTO `state` VALUES (107, 2, 'Tirane', NULL, NULL);
INSERT INTO `state` VALUES (108, 2, 'Tropoje', NULL, NULL);
INSERT INTO `state` VALUES (109, 2, 'Vlore', NULL, NULL);
INSERT INTO `state` VALUES (110, 3, '\'Ayn Daflah', NULL, NULL);
INSERT INTO `state` VALUES (111, 3, '\'Ayn Tamushanat', NULL, NULL);
INSERT INTO `state` VALUES (112, 3, 'Adrar', NULL, NULL);
INSERT INTO `state` VALUES (113, 3, 'Algiers', NULL, NULL);
INSERT INTO `state` VALUES (114, 3, 'Annabah', NULL, NULL);
INSERT INTO `state` VALUES (115, 3, 'Bashshar', NULL, NULL);
INSERT INTO `state` VALUES (116, 3, 'Batnah', NULL, NULL);
INSERT INTO `state` VALUES (117, 3, 'Bijayah', NULL, NULL);
INSERT INTO `state` VALUES (118, 3, 'Biskrah', NULL, NULL);
INSERT INTO `state` VALUES (119, 3, 'Blidah', NULL, NULL);
INSERT INTO `state` VALUES (120, 3, 'Buirah', NULL, NULL);
INSERT INTO `state` VALUES (121, 3, 'Bumardas', NULL, NULL);
INSERT INTO `state` VALUES (122, 3, 'Burj Bu Arririj', NULL, NULL);
INSERT INTO `state` VALUES (123, 3, 'Ghalizan', NULL, NULL);
INSERT INTO `state` VALUES (124, 3, 'Ghardayah', NULL, NULL);
INSERT INTO `state` VALUES (125, 3, 'Ilizi', NULL, NULL);
INSERT INTO `state` VALUES (126, 3, 'Jijili', NULL, NULL);
INSERT INTO `state` VALUES (127, 3, 'Jilfah', NULL, NULL);
INSERT INTO `state` VALUES (128, 3, 'Khanshalah', NULL, NULL);
INSERT INTO `state` VALUES (129, 3, 'Masilah', NULL, NULL);
INSERT INTO `state` VALUES (130, 3, 'Midyah', NULL, NULL);
INSERT INTO `state` VALUES (131, 3, 'Milah', NULL, NULL);
INSERT INTO `state` VALUES (132, 3, 'Muaskar', NULL, NULL);
INSERT INTO `state` VALUES (133, 3, 'Mustaghanam', NULL, NULL);
INSERT INTO `state` VALUES (134, 3, 'Naama', NULL, NULL);
INSERT INTO `state` VALUES (135, 3, 'Oran', NULL, NULL);
INSERT INTO `state` VALUES (136, 3, 'Ouargla', NULL, NULL);
INSERT INTO `state` VALUES (137, 3, 'Qalmah', NULL, NULL);
INSERT INTO `state` VALUES (138, 3, 'Qustantinah', NULL, NULL);
INSERT INTO `state` VALUES (139, 3, 'Sakikdah', NULL, NULL);
INSERT INTO `state` VALUES (140, 3, 'Satif', NULL, NULL);
INSERT INTO `state` VALUES (141, 3, 'Sayda\'', NULL, NULL);
INSERT INTO `state` VALUES (142, 3, 'Sidi ban-al-\'Abbas', NULL, NULL);
INSERT INTO `state` VALUES (143, 3, 'Suq Ahras', NULL, NULL);
INSERT INTO `state` VALUES (144, 3, 'Tamanghasat', NULL, NULL);
INSERT INTO `state` VALUES (145, 3, 'Tibazah', NULL, NULL);
INSERT INTO `state` VALUES (146, 3, 'Tibissah', NULL, NULL);
INSERT INTO `state` VALUES (147, 3, 'Tilimsan', NULL, NULL);
INSERT INTO `state` VALUES (148, 3, 'Tinduf', NULL, NULL);
INSERT INTO `state` VALUES (149, 3, 'Tisamsilt', NULL, NULL);
INSERT INTO `state` VALUES (150, 3, 'Tiyarat', NULL, NULL);
INSERT INTO `state` VALUES (151, 3, 'Tizi Wazu', NULL, NULL);
INSERT INTO `state` VALUES (152, 3, 'Umm-al-Bawaghi', NULL, NULL);
INSERT INTO `state` VALUES (153, 3, 'Wahran', NULL, NULL);
INSERT INTO `state` VALUES (154, 3, 'Warqla', NULL, NULL);
INSERT INTO `state` VALUES (155, 3, 'Wilaya d Alger', NULL, NULL);
INSERT INTO `state` VALUES (156, 3, 'Wilaya de Bejaia', NULL, NULL);
INSERT INTO `state` VALUES (157, 3, 'Wilaya de Constantine', NULL, NULL);
INSERT INTO `state` VALUES (158, 3, 'al-Aghwat', NULL, NULL);
INSERT INTO `state` VALUES (159, 3, 'al-Bayadh', NULL, NULL);
INSERT INTO `state` VALUES (160, 3, 'al-Jaza\'ir', NULL, NULL);
INSERT INTO `state` VALUES (161, 3, 'al-Wad', NULL, NULL);
INSERT INTO `state` VALUES (162, 3, 'ash-Shalif', NULL, NULL);
INSERT INTO `state` VALUES (163, 3, 'at-Tarif', NULL, NULL);
INSERT INTO `state` VALUES (164, 4, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (165, 4, 'Manu\'a', NULL, NULL);
INSERT INTO `state` VALUES (166, 4, 'Swains Island', NULL, NULL);
INSERT INTO `state` VALUES (167, 4, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (168, 5, 'Andorra la Vella', NULL, NULL);
INSERT INTO `state` VALUES (169, 5, 'Canillo', NULL, NULL);
INSERT INTO `state` VALUES (170, 5, 'Encamp', NULL, NULL);
INSERT INTO `state` VALUES (171, 5, 'La Massana', NULL, NULL);
INSERT INTO `state` VALUES (172, 5, 'Les Escaldes', NULL, NULL);
INSERT INTO `state` VALUES (173, 5, 'Ordino', NULL, NULL);
INSERT INTO `state` VALUES (174, 5, 'Sant Julia de Loria', NULL, NULL);
INSERT INTO `state` VALUES (175, 6, 'Bengo', NULL, NULL);
INSERT INTO `state` VALUES (176, 6, 'Benguela', NULL, NULL);
INSERT INTO `state` VALUES (177, 6, 'Bie', NULL, NULL);
INSERT INTO `state` VALUES (178, 6, 'Cabinda', NULL, NULL);
INSERT INTO `state` VALUES (179, 6, 'Cunene', NULL, NULL);
INSERT INTO `state` VALUES (180, 6, 'Huambo', NULL, NULL);
INSERT INTO `state` VALUES (181, 6, 'Huila', NULL, NULL);
INSERT INTO `state` VALUES (182, 6, 'Kuando-Kubango', NULL, NULL);
INSERT INTO `state` VALUES (183, 6, 'Kwanza Norte', NULL, NULL);
INSERT INTO `state` VALUES (184, 6, 'Kwanza Sul', NULL, NULL);
INSERT INTO `state` VALUES (185, 6, 'Luanda', NULL, NULL);
INSERT INTO `state` VALUES (186, 6, 'Lunda Norte', NULL, NULL);
INSERT INTO `state` VALUES (187, 6, 'Lunda Sul', NULL, NULL);
INSERT INTO `state` VALUES (188, 6, 'Malanje', NULL, NULL);
INSERT INTO `state` VALUES (189, 6, 'Moxico', NULL, NULL);
INSERT INTO `state` VALUES (190, 6, 'Namibe', NULL, NULL);
INSERT INTO `state` VALUES (191, 6, 'Uige', NULL, NULL);
INSERT INTO `state` VALUES (192, 6, 'Zaire', NULL, NULL);
INSERT INTO `state` VALUES (193, 7, 'Other Provinces', NULL, NULL);
INSERT INTO `state` VALUES (194, 8, 'Sector claimed by Argentina/Ch', NULL, NULL);
INSERT INTO `state` VALUES (195, 8, 'Sector claimed by Argentina/UK', NULL, NULL);
INSERT INTO `state` VALUES (196, 8, 'Sector claimed by Australia', NULL, NULL);
INSERT INTO `state` VALUES (197, 8, 'Sector claimed by France', NULL, NULL);
INSERT INTO `state` VALUES (198, 8, 'Sector claimed by New Zealand', NULL, NULL);
INSERT INTO `state` VALUES (199, 8, 'Sector claimed by Norway', NULL, NULL);
INSERT INTO `state` VALUES (200, 8, 'Unclaimed Sector', NULL, NULL);
INSERT INTO `state` VALUES (201, 9, 'Barbuda', NULL, NULL);
INSERT INTO `state` VALUES (202, 9, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (203, 9, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (204, 9, 'Saint Mary', NULL, NULL);
INSERT INTO `state` VALUES (205, 9, 'Saint Paul', NULL, NULL);
INSERT INTO `state` VALUES (206, 9, 'Saint Peter', NULL, NULL);
INSERT INTO `state` VALUES (207, 9, 'Saint Philip', NULL, NULL);
INSERT INTO `state` VALUES (208, 10, 'Buenos Aires', NULL, NULL);
INSERT INTO `state` VALUES (209, 10, 'Catamarca', NULL, NULL);
INSERT INTO `state` VALUES (210, 10, 'Chaco', NULL, NULL);
INSERT INTO `state` VALUES (211, 10, 'Chubut', NULL, NULL);
INSERT INTO `state` VALUES (212, 10, 'Cordoba', NULL, NULL);
INSERT INTO `state` VALUES (213, 10, 'Corrientes', NULL, NULL);
INSERT INTO `state` VALUES (214, 10, 'Distrito Federal', NULL, NULL);
INSERT INTO `state` VALUES (215, 10, 'Entre Rios', NULL, NULL);
INSERT INTO `state` VALUES (216, 10, 'Formosa', NULL, NULL);
INSERT INTO `state` VALUES (217, 10, 'Jujuy', NULL, NULL);
INSERT INTO `state` VALUES (218, 10, 'La Pampa', NULL, NULL);
INSERT INTO `state` VALUES (219, 10, 'La Rioja', NULL, NULL);
INSERT INTO `state` VALUES (220, 10, 'Mendoza', NULL, NULL);
INSERT INTO `state` VALUES (221, 10, 'Misiones', NULL, NULL);
INSERT INTO `state` VALUES (222, 10, 'Neuquen', NULL, NULL);
INSERT INTO `state` VALUES (223, 10, 'Rio Negro', NULL, NULL);
INSERT INTO `state` VALUES (224, 10, 'Salta', NULL, NULL);
INSERT INTO `state` VALUES (225, 10, 'San Juan', NULL, NULL);
INSERT INTO `state` VALUES (226, 10, 'San Luis', NULL, NULL);
INSERT INTO `state` VALUES (227, 10, 'Santa Cruz', NULL, NULL);
INSERT INTO `state` VALUES (228, 10, 'Santa Fe', NULL, NULL);
INSERT INTO `state` VALUES (229, 10, 'Santiago del Estero', NULL, NULL);
INSERT INTO `state` VALUES (230, 10, 'Tierra del Fuego', NULL, NULL);
INSERT INTO `state` VALUES (231, 10, 'Tucuman', NULL, NULL);
INSERT INTO `state` VALUES (232, 11, 'Aragatsotn', NULL, NULL);
INSERT INTO `state` VALUES (233, 11, 'Ararat', NULL, NULL);
INSERT INTO `state` VALUES (234, 11, 'Armavir', NULL, NULL);
INSERT INTO `state` VALUES (235, 11, 'Gegharkunik', NULL, NULL);
INSERT INTO `state` VALUES (236, 11, 'Kotaik', NULL, NULL);
INSERT INTO `state` VALUES (237, 11, 'Lori', NULL, NULL);
INSERT INTO `state` VALUES (238, 11, 'Shirak', NULL, NULL);
INSERT INTO `state` VALUES (239, 11, 'Stepanakert', NULL, NULL);
INSERT INTO `state` VALUES (240, 11, 'Syunik', NULL, NULL);
INSERT INTO `state` VALUES (241, 11, 'Tavush', NULL, NULL);
INSERT INTO `state` VALUES (242, 11, 'Vayots Dzor', NULL, NULL);
INSERT INTO `state` VALUES (243, 11, 'Yerevan', NULL, NULL);
INSERT INTO `state` VALUES (244, 12, 'Aruba', NULL, NULL);
INSERT INTO `state` VALUES (245, 13, 'Auckland', NULL, NULL);
INSERT INTO `state` VALUES (246, 13, 'Australian Capital Territory', NULL, NULL);
INSERT INTO `state` VALUES (247, 13, 'Balgowlah', NULL, NULL);
INSERT INTO `state` VALUES (248, 13, 'Balmain', NULL, NULL);
INSERT INTO `state` VALUES (249, 13, 'Bankstown', NULL, NULL);
INSERT INTO `state` VALUES (250, 13, 'Baulkham Hills', NULL, NULL);
INSERT INTO `state` VALUES (251, 13, 'Bonnet Bay', NULL, NULL);
INSERT INTO `state` VALUES (252, 13, 'Camberwell', NULL, NULL);
INSERT INTO `state` VALUES (253, 13, 'Carole Park', NULL, NULL);
INSERT INTO `state` VALUES (254, 13, 'Castle Hill', NULL, NULL);
INSERT INTO `state` VALUES (255, 13, 'Caulfield', NULL, NULL);
INSERT INTO `state` VALUES (256, 13, 'Chatswood', NULL, NULL);
INSERT INTO `state` VALUES (257, 13, 'Cheltenham', NULL, NULL);
INSERT INTO `state` VALUES (258, 13, 'Cherrybrook', NULL, NULL);
INSERT INTO `state` VALUES (259, 13, 'Clayton', NULL, NULL);
INSERT INTO `state` VALUES (260, 13, 'Collingwood', NULL, NULL);
INSERT INTO `state` VALUES (261, 13, 'Frenchs Forest', NULL, NULL);
INSERT INTO `state` VALUES (262, 13, 'Hawthorn', NULL, NULL);
INSERT INTO `state` VALUES (263, 13, 'Jannnali', NULL, NULL);
INSERT INTO `state` VALUES (264, 13, 'Knoxfield', NULL, NULL);
INSERT INTO `state` VALUES (265, 13, 'Melbourne', NULL, NULL);
INSERT INTO `state` VALUES (266, 13, 'New South Wales', NULL, NULL);
INSERT INTO `state` VALUES (267, 13, 'Northern Territory', NULL, NULL);
INSERT INTO `state` VALUES (268, 13, 'Perth', NULL, NULL);
INSERT INTO `state` VALUES (269, 13, 'Queensland', NULL, NULL);
INSERT INTO `state` VALUES (270, 13, 'South Australia', NULL, NULL);
INSERT INTO `state` VALUES (271, 13, 'Tasmania', NULL, NULL);
INSERT INTO `state` VALUES (272, 13, 'Templestowe', NULL, NULL);
INSERT INTO `state` VALUES (273, 13, 'Victoria', NULL, NULL);
INSERT INTO `state` VALUES (274, 13, 'Werribee south', NULL, NULL);
INSERT INTO `state` VALUES (275, 13, 'Western Australia', NULL, NULL);
INSERT INTO `state` VALUES (276, 13, 'Wheeler', NULL, NULL);
INSERT INTO `state` VALUES (277, 14, 'Bundesland Salzburg', NULL, NULL);
INSERT INTO `state` VALUES (278, 14, 'Bundesland Steiermark', NULL, NULL);
INSERT INTO `state` VALUES (279, 14, 'Bundesland Tirol', NULL, NULL);
INSERT INTO `state` VALUES (280, 14, 'Burgenland', NULL, NULL);
INSERT INTO `state` VALUES (281, 14, 'Carinthia', NULL, NULL);
INSERT INTO `state` VALUES (282, 14, 'Karnten', NULL, NULL);
INSERT INTO `state` VALUES (283, 14, 'Liezen', NULL, NULL);
INSERT INTO `state` VALUES (284, 14, 'Lower Austria', NULL, NULL);
INSERT INTO `state` VALUES (285, 14, 'Niederosterreich', NULL, NULL);
INSERT INTO `state` VALUES (286, 14, 'Oberosterreich', NULL, NULL);
INSERT INTO `state` VALUES (287, 14, 'Salzburg', NULL, NULL);
INSERT INTO `state` VALUES (288, 14, 'Schleswig-Holstein', NULL, NULL);
INSERT INTO `state` VALUES (289, 14, 'Steiermark', NULL, NULL);
INSERT INTO `state` VALUES (290, 14, 'Styria', NULL, NULL);
INSERT INTO `state` VALUES (291, 14, 'Tirol', NULL, NULL);
INSERT INTO `state` VALUES (292, 14, 'Upper Austria', NULL, NULL);
INSERT INTO `state` VALUES (293, 14, 'Vorarlberg', NULL, NULL);
INSERT INTO `state` VALUES (294, 14, 'Wien', NULL, NULL);
INSERT INTO `state` VALUES (295, 15, 'Abseron', NULL, NULL);
INSERT INTO `state` VALUES (296, 15, 'Baki Sahari', NULL, NULL);
INSERT INTO `state` VALUES (297, 15, 'Ganca', NULL, NULL);
INSERT INTO `state` VALUES (298, 15, 'Ganja', NULL, NULL);
INSERT INTO `state` VALUES (299, 15, 'Kalbacar', NULL, NULL);
INSERT INTO `state` VALUES (300, 15, 'Lankaran', NULL, NULL);
INSERT INTO `state` VALUES (301, 15, 'Mil-Qarabax', NULL, NULL);
INSERT INTO `state` VALUES (302, 15, 'Mugan-Salyan', NULL, NULL);
INSERT INTO `state` VALUES (303, 15, 'Nagorni-Qarabax', NULL, NULL);
INSERT INTO `state` VALUES (304, 15, 'Naxcivan', NULL, NULL);
INSERT INTO `state` VALUES (305, 15, 'Priaraks', NULL, NULL);
INSERT INTO `state` VALUES (306, 15, 'Qazax', NULL, NULL);
INSERT INTO `state` VALUES (307, 15, 'Saki', NULL, NULL);
INSERT INTO `state` VALUES (308, 15, 'Sirvan', NULL, NULL);
INSERT INTO `state` VALUES (309, 15, 'Xacmaz', NULL, NULL);
INSERT INTO `state` VALUES (310, 16, 'Abaco', NULL, NULL);
INSERT INTO `state` VALUES (311, 16, 'Acklins Island', NULL, NULL);
INSERT INTO `state` VALUES (312, 16, 'Andros', NULL, NULL);
INSERT INTO `state` VALUES (313, 16, 'Berry Islands', NULL, NULL);
INSERT INTO `state` VALUES (314, 16, 'Biminis', NULL, NULL);
INSERT INTO `state` VALUES (315, 16, 'Cat Island', NULL, NULL);
INSERT INTO `state` VALUES (316, 16, 'Crooked Island', NULL, NULL);
INSERT INTO `state` VALUES (317, 16, 'Eleuthera', NULL, NULL);
INSERT INTO `state` VALUES (318, 16, 'Exuma and Cays', NULL, NULL);
INSERT INTO `state` VALUES (319, 16, 'Grand Bahama', NULL, NULL);
INSERT INTO `state` VALUES (320, 16, 'Inagua Islands', NULL, NULL);
INSERT INTO `state` VALUES (321, 16, 'Long Island', NULL, NULL);
INSERT INTO `state` VALUES (322, 16, 'Mayaguana', NULL, NULL);
INSERT INTO `state` VALUES (323, 16, 'New Providence', NULL, NULL);
INSERT INTO `state` VALUES (324, 16, 'Ragged Island', NULL, NULL);
INSERT INTO `state` VALUES (325, 16, 'Rum Cay', NULL, NULL);
INSERT INTO `state` VALUES (326, 16, 'San Salvador', NULL, NULL);
INSERT INTO `state` VALUES (327, 17, '\'Isa', NULL, NULL);
INSERT INTO `state` VALUES (328, 17, 'Badiyah', NULL, NULL);
INSERT INTO `state` VALUES (329, 17, 'Hidd', NULL, NULL);
INSERT INTO `state` VALUES (330, 17, 'Jidd Hafs', NULL, NULL);
INSERT INTO `state` VALUES (331, 17, 'Mahama', NULL, NULL);
INSERT INTO `state` VALUES (332, 17, 'Manama', NULL, NULL);
INSERT INTO `state` VALUES (333, 17, 'Sitrah', NULL, NULL);
INSERT INTO `state` VALUES (334, 17, 'al-Manamah', NULL, NULL);
INSERT INTO `state` VALUES (335, 17, 'al-Muharraq', NULL, NULL);
INSERT INTO `state` VALUES (336, 17, 'ar-Rifa\'a', NULL, NULL);
INSERT INTO `state` VALUES (337, 18, 'Bagar Hat', NULL, NULL);
INSERT INTO `state` VALUES (338, 18, 'Bandarban', NULL, NULL);
INSERT INTO `state` VALUES (339, 18, 'Barguna', NULL, NULL);
INSERT INTO `state` VALUES (340, 18, 'Barisal', NULL, NULL);
INSERT INTO `state` VALUES (341, 18, 'Bhola', NULL, NULL);
INSERT INTO `state` VALUES (342, 18, 'Bogora', NULL, NULL);
INSERT INTO `state` VALUES (343, 18, 'Brahman Bariya', NULL, NULL);
INSERT INTO `state` VALUES (344, 18, 'Chandpur', NULL, NULL);
INSERT INTO `state` VALUES (345, 18, 'Chattagam', NULL, NULL);
INSERT INTO `state` VALUES (346, 18, 'Chittagong Division', NULL, NULL);
INSERT INTO `state` VALUES (347, 18, 'Chuadanga', NULL, NULL);
INSERT INTO `state` VALUES (348, 18, 'Dhaka', NULL, NULL);
INSERT INTO `state` VALUES (349, 18, 'Dinajpur', NULL, NULL);
INSERT INTO `state` VALUES (350, 18, 'Faridpur', NULL, NULL);
INSERT INTO `state` VALUES (351, 18, 'Feni', NULL, NULL);
INSERT INTO `state` VALUES (352, 18, 'Gaybanda', NULL, NULL);
INSERT INTO `state` VALUES (353, 18, 'Gazipur', NULL, NULL);
INSERT INTO `state` VALUES (354, 18, 'Gopalganj', NULL, NULL);
INSERT INTO `state` VALUES (355, 18, 'Habiganj', NULL, NULL);
INSERT INTO `state` VALUES (356, 18, 'Jaipur Hat', NULL, NULL);
INSERT INTO `state` VALUES (357, 18, 'Jamalpur', NULL, NULL);
INSERT INTO `state` VALUES (358, 18, 'Jessor', NULL, NULL);
INSERT INTO `state` VALUES (359, 18, 'Jhalakati', NULL, NULL);
INSERT INTO `state` VALUES (360, 18, 'Jhanaydah', NULL, NULL);
INSERT INTO `state` VALUES (361, 18, 'Khagrachhari', NULL, NULL);
INSERT INTO `state` VALUES (362, 18, 'Khulna', NULL, NULL);
INSERT INTO `state` VALUES (363, 18, 'Kishorganj', NULL, NULL);
INSERT INTO `state` VALUES (364, 18, 'Koks Bazar', NULL, NULL);
INSERT INTO `state` VALUES (365, 18, 'Komilla', NULL, NULL);
INSERT INTO `state` VALUES (366, 18, 'Kurigram', NULL, NULL);
INSERT INTO `state` VALUES (367, 18, 'Kushtiya', NULL, NULL);
INSERT INTO `state` VALUES (368, 18, 'Lakshmipur', NULL, NULL);
INSERT INTO `state` VALUES (369, 18, 'Lalmanir Hat', NULL, NULL);
INSERT INTO `state` VALUES (370, 18, 'Madaripur', NULL, NULL);
INSERT INTO `state` VALUES (371, 18, 'Magura', NULL, NULL);
INSERT INTO `state` VALUES (372, 18, 'Maimansingh', NULL, NULL);
INSERT INTO `state` VALUES (373, 18, 'Manikganj', NULL, NULL);
INSERT INTO `state` VALUES (374, 18, 'Maulvi Bazar', NULL, NULL);
INSERT INTO `state` VALUES (375, 18, 'Meherpur', NULL, NULL);
INSERT INTO `state` VALUES (376, 18, 'Munshiganj', NULL, NULL);
INSERT INTO `state` VALUES (377, 18, 'Naral', NULL, NULL);
INSERT INTO `state` VALUES (378, 18, 'Narayanganj', NULL, NULL);
INSERT INTO `state` VALUES (379, 18, 'Narsingdi', NULL, NULL);
INSERT INTO `state` VALUES (380, 18, 'Nator', NULL, NULL);
INSERT INTO `state` VALUES (381, 18, 'Naugaon', NULL, NULL);
INSERT INTO `state` VALUES (382, 18, 'Nawabganj', NULL, NULL);
INSERT INTO `state` VALUES (383, 18, 'Netrakona', NULL, NULL);
INSERT INTO `state` VALUES (384, 18, 'Nilphamari', NULL, NULL);
INSERT INTO `state` VALUES (385, 18, 'Noakhali', NULL, NULL);
INSERT INTO `state` VALUES (386, 18, 'Pabna', NULL, NULL);
INSERT INTO `state` VALUES (387, 18, 'Panchagarh', NULL, NULL);
INSERT INTO `state` VALUES (388, 18, 'Patuakhali', NULL, NULL);
INSERT INTO `state` VALUES (389, 18, 'Pirojpur', NULL, NULL);
INSERT INTO `state` VALUES (390, 18, 'Rajbari', NULL, NULL);
INSERT INTO `state` VALUES (391, 18, 'Rajshahi', NULL, NULL);
INSERT INTO `state` VALUES (392, 18, 'Rangamati', NULL, NULL);
INSERT INTO `state` VALUES (393, 18, 'Rangpur', NULL, NULL);
INSERT INTO `state` VALUES (394, 18, 'Satkhira', NULL, NULL);
INSERT INTO `state` VALUES (395, 18, 'Shariatpur', NULL, NULL);
INSERT INTO `state` VALUES (396, 18, 'Sherpur', NULL, NULL);
INSERT INTO `state` VALUES (397, 18, 'Silhat', NULL, NULL);
INSERT INTO `state` VALUES (398, 18, 'Sirajganj', NULL, NULL);
INSERT INTO `state` VALUES (399, 18, 'Sunamganj', NULL, NULL);
INSERT INTO `state` VALUES (400, 18, 'Tangayal', NULL, NULL);
INSERT INTO `state` VALUES (401, 18, 'Thakurgaon', NULL, NULL);
INSERT INTO `state` VALUES (402, 19, 'Christ Church', NULL, NULL);
INSERT INTO `state` VALUES (403, 19, 'Saint Andrew', NULL, NULL);
INSERT INTO `state` VALUES (404, 19, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (405, 19, 'Saint James', NULL, NULL);
INSERT INTO `state` VALUES (406, 19, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (407, 19, 'Saint Joseph', NULL, NULL);
INSERT INTO `state` VALUES (408, 19, 'Saint Lucy', NULL, NULL);
INSERT INTO `state` VALUES (409, 19, 'Saint Michael', NULL, NULL);
INSERT INTO `state` VALUES (410, 19, 'Saint Peter', NULL, NULL);
INSERT INTO `state` VALUES (411, 19, 'Saint Philip', NULL, NULL);
INSERT INTO `state` VALUES (412, 19, 'Saint Thomas', NULL, NULL);
INSERT INTO `state` VALUES (413, 20, 'Brest', NULL, NULL);
INSERT INTO `state` VALUES (414, 20, 'Homjel\'', NULL, NULL);
INSERT INTO `state` VALUES (415, 20, 'Hrodna', NULL, NULL);
INSERT INTO `state` VALUES (416, 20, 'Mahiljow', NULL, NULL);
INSERT INTO `state` VALUES (417, 20, 'Mahilyowskaya Voblasts', NULL, NULL);
INSERT INTO `state` VALUES (418, 20, 'Minsk', NULL, NULL);
INSERT INTO `state` VALUES (419, 20, 'Minskaja Voblasts\'', NULL, NULL);
INSERT INTO `state` VALUES (420, 20, 'Petrik', NULL, NULL);
INSERT INTO `state` VALUES (421, 20, 'Vicebsk', NULL, NULL);
INSERT INTO `state` VALUES (422, 21, 'Antwerpen', NULL, NULL);
INSERT INTO `state` VALUES (423, 21, 'Berchem', NULL, NULL);
INSERT INTO `state` VALUES (424, 21, 'Brabant', NULL, NULL);
INSERT INTO `state` VALUES (425, 21, 'Brabant Wallon', NULL, NULL);
INSERT INTO `state` VALUES (426, 21, 'Brussel', NULL, NULL);
INSERT INTO `state` VALUES (427, 21, 'East Flanders', NULL, NULL);
INSERT INTO `state` VALUES (428, 21, 'Hainaut', NULL, NULL);
INSERT INTO `state` VALUES (429, 21, 'Liege', NULL, NULL);
INSERT INTO `state` VALUES (430, 21, 'Limburg', NULL, NULL);
INSERT INTO `state` VALUES (431, 21, 'Luxembourg', NULL, NULL);
INSERT INTO `state` VALUES (432, 21, 'Namur', NULL, NULL);
INSERT INTO `state` VALUES (433, 21, 'Ontario', NULL, NULL);
INSERT INTO `state` VALUES (434, 21, 'Oost-Vlaanderen', NULL, NULL);
INSERT INTO `state` VALUES (435, 21, 'Provincie Brabant', NULL, NULL);
INSERT INTO `state` VALUES (436, 21, 'Vlaams-Brabant', NULL, NULL);
INSERT INTO `state` VALUES (437, 21, 'Wallonne', NULL, NULL);
INSERT INTO `state` VALUES (438, 21, 'West-Vlaanderen', NULL, NULL);
INSERT INTO `state` VALUES (439, 22, 'Belize', NULL, NULL);
INSERT INTO `state` VALUES (440, 22, 'Cayo', NULL, NULL);
INSERT INTO `state` VALUES (441, 22, 'Corozal', NULL, NULL);
INSERT INTO `state` VALUES (442, 22, 'Orange Walk', NULL, NULL);
INSERT INTO `state` VALUES (443, 22, 'Stann Creek', NULL, NULL);
INSERT INTO `state` VALUES (444, 22, 'Toledo', NULL, NULL);
INSERT INTO `state` VALUES (445, 23, 'Alibori', NULL, NULL);
INSERT INTO `state` VALUES (446, 23, 'Atacora', NULL, NULL);
INSERT INTO `state` VALUES (447, 23, 'Atlantique', NULL, NULL);
INSERT INTO `state` VALUES (448, 23, 'Borgou', NULL, NULL);
INSERT INTO `state` VALUES (449, 23, 'Collines', NULL, NULL);
INSERT INTO `state` VALUES (450, 23, 'Couffo', NULL, NULL);
INSERT INTO `state` VALUES (451, 23, 'Donga', NULL, NULL);
INSERT INTO `state` VALUES (452, 23, 'Littoral', NULL, NULL);
INSERT INTO `state` VALUES (453, 23, 'Mono', NULL, NULL);
INSERT INTO `state` VALUES (454, 23, 'Oueme', NULL, NULL);
INSERT INTO `state` VALUES (455, 23, 'Plateau', NULL, NULL);
INSERT INTO `state` VALUES (456, 23, 'Zou', NULL, NULL);
INSERT INTO `state` VALUES (457, 24, 'Hamilton', NULL, NULL);
INSERT INTO `state` VALUES (458, 24, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (459, 25, 'Bumthang', NULL, NULL);
INSERT INTO `state` VALUES (460, 25, 'Chhukha', NULL, NULL);
INSERT INTO `state` VALUES (461, 25, 'Chirang', NULL, NULL);
INSERT INTO `state` VALUES (462, 25, 'Daga', NULL, NULL);
INSERT INTO `state` VALUES (463, 25, 'Geylegphug', NULL, NULL);
INSERT INTO `state` VALUES (464, 25, 'Ha', NULL, NULL);
INSERT INTO `state` VALUES (465, 25, 'Lhuntshi', NULL, NULL);
INSERT INTO `state` VALUES (466, 25, 'Mongar', NULL, NULL);
INSERT INTO `state` VALUES (467, 25, 'Pemagatsel', NULL, NULL);
INSERT INTO `state` VALUES (468, 25, 'Punakha', NULL, NULL);
INSERT INTO `state` VALUES (469, 25, 'Rinpung', NULL, NULL);
INSERT INTO `state` VALUES (470, 25, 'Samchi', NULL, NULL);
INSERT INTO `state` VALUES (471, 25, 'Samdrup Jongkhar', NULL, NULL);
INSERT INTO `state` VALUES (472, 25, 'Shemgang', NULL, NULL);
INSERT INTO `state` VALUES (473, 25, 'Tashigang', NULL, NULL);
INSERT INTO `state` VALUES (474, 25, 'Timphu', NULL, NULL);
INSERT INTO `state` VALUES (475, 25, 'Tongsa', NULL, NULL);
INSERT INTO `state` VALUES (476, 25, 'Wangdiphodrang', NULL, NULL);
INSERT INTO `state` VALUES (477, 26, 'Beni', NULL, NULL);
INSERT INTO `state` VALUES (478, 26, 'Chuquisaca', NULL, NULL);
INSERT INTO `state` VALUES (479, 26, 'Cochabamba', NULL, NULL);
INSERT INTO `state` VALUES (480, 26, 'La Paz', NULL, NULL);
INSERT INTO `state` VALUES (481, 26, 'Oruro', NULL, NULL);
INSERT INTO `state` VALUES (482, 26, 'Pando', NULL, NULL);
INSERT INTO `state` VALUES (483, 26, 'Potosi', NULL, NULL);
INSERT INTO `state` VALUES (484, 26, 'Santa Cruz', NULL, NULL);
INSERT INTO `state` VALUES (485, 26, 'Tarija', NULL, NULL);
INSERT INTO `state` VALUES (486, 27, 'Federacija Bosna i Hercegovina', NULL, NULL);
INSERT INTO `state` VALUES (487, 27, 'Republika Srpska', NULL, NULL);
INSERT INTO `state` VALUES (488, 28, 'Central Bobonong', NULL, NULL);
INSERT INTO `state` VALUES (489, 28, 'Central Boteti', NULL, NULL);
INSERT INTO `state` VALUES (490, 28, 'Central Mahalapye', NULL, NULL);
INSERT INTO `state` VALUES (491, 28, 'Central Serowe-Palapye', NULL, NULL);
INSERT INTO `state` VALUES (492, 28, 'Central Tutume', NULL, NULL);
INSERT INTO `state` VALUES (493, 28, 'Chobe', NULL, NULL);
INSERT INTO `state` VALUES (494, 28, 'Francistown', NULL, NULL);
INSERT INTO `state` VALUES (495, 28, 'Gaborone', NULL, NULL);
INSERT INTO `state` VALUES (496, 28, 'Ghanzi', NULL, NULL);
INSERT INTO `state` VALUES (497, 28, 'Jwaneng', NULL, NULL);
INSERT INTO `state` VALUES (498, 28, 'Kgalagadi North', NULL, NULL);
INSERT INTO `state` VALUES (499, 28, 'Kgalagadi South', NULL, NULL);
INSERT INTO `state` VALUES (500, 28, 'Kgatleng', NULL, NULL);
INSERT INTO `state` VALUES (501, 28, 'Kweneng', NULL, NULL);
INSERT INTO `state` VALUES (502, 28, 'Lobatse', NULL, NULL);
INSERT INTO `state` VALUES (503, 28, 'Ngamiland', NULL, NULL);
INSERT INTO `state` VALUES (504, 28, 'Ngwaketse', NULL, NULL);
INSERT INTO `state` VALUES (505, 28, 'North East', NULL, NULL);
INSERT INTO `state` VALUES (506, 28, 'Okavango', NULL, NULL);
INSERT INTO `state` VALUES (507, 28, 'Orapa', NULL, NULL);
INSERT INTO `state` VALUES (508, 28, 'Selibe Phikwe', NULL, NULL);
INSERT INTO `state` VALUES (509, 28, 'South East', NULL, NULL);
INSERT INTO `state` VALUES (510, 28, 'Sowa', NULL, NULL);
INSERT INTO `state` VALUES (511, 29, 'Bouvet Island', NULL, NULL);
INSERT INTO `state` VALUES (512, 30, 'Acre', NULL, NULL);
INSERT INTO `state` VALUES (513, 30, 'Alagoas', NULL, NULL);
INSERT INTO `state` VALUES (514, 30, 'Amapa', NULL, NULL);
INSERT INTO `state` VALUES (515, 30, 'Amazonas', NULL, NULL);
INSERT INTO `state` VALUES (516, 30, 'Bahia', NULL, NULL);
INSERT INTO `state` VALUES (517, 30, 'Ceara', NULL, NULL);
INSERT INTO `state` VALUES (518, 30, 'Distrito Federal', NULL, NULL);
INSERT INTO `state` VALUES (519, 30, 'Espirito Santo', NULL, NULL);
INSERT INTO `state` VALUES (520, 30, 'Estado de Sao Paulo', NULL, NULL);
INSERT INTO `state` VALUES (521, 30, 'Goias', NULL, NULL);
INSERT INTO `state` VALUES (522, 30, 'Maranhao', NULL, NULL);
INSERT INTO `state` VALUES (523, 30, 'Mato Grosso', NULL, NULL);
INSERT INTO `state` VALUES (524, 30, 'Mato Grosso do Sul', NULL, NULL);
INSERT INTO `state` VALUES (525, 30, 'Minas Gerais', NULL, NULL);
INSERT INTO `state` VALUES (526, 30, 'Para', NULL, NULL);
INSERT INTO `state` VALUES (527, 30, 'Paraiba', NULL, NULL);
INSERT INTO `state` VALUES (528, 30, 'Parana', NULL, NULL);
INSERT INTO `state` VALUES (529, 30, 'Pernambuco', NULL, NULL);
INSERT INTO `state` VALUES (530, 30, 'Piaui', NULL, NULL);
INSERT INTO `state` VALUES (531, 30, 'Rio Grande do Norte', NULL, NULL);
INSERT INTO `state` VALUES (532, 30, 'Rio Grande do Sul', NULL, NULL);
INSERT INTO `state` VALUES (533, 30, 'Rio de Janeiro', NULL, NULL);
INSERT INTO `state` VALUES (534, 30, 'Rondonia', NULL, NULL);
INSERT INTO `state` VALUES (535, 30, 'Roraima', NULL, NULL);
INSERT INTO `state` VALUES (536, 30, 'Santa Catarina', NULL, NULL);
INSERT INTO `state` VALUES (537, 30, 'Sao Paulo', NULL, NULL);
INSERT INTO `state` VALUES (538, 30, 'Sergipe', NULL, NULL);
INSERT INTO `state` VALUES (539, 30, 'Tocantins', NULL, NULL);
INSERT INTO `state` VALUES (540, 31, 'British Indian Ocean Territory', NULL, NULL);
INSERT INTO `state` VALUES (541, 32, 'Belait', NULL, NULL);
INSERT INTO `state` VALUES (542, 32, 'Brunei-Muara', NULL, NULL);
INSERT INTO `state` VALUES (543, 32, 'Temburong', NULL, NULL);
INSERT INTO `state` VALUES (544, 32, 'Tutong', NULL, NULL);
INSERT INTO `state` VALUES (545, 33, 'Blagoevgrad', NULL, NULL);
INSERT INTO `state` VALUES (546, 33, 'Burgas', NULL, NULL);
INSERT INTO `state` VALUES (547, 33, 'Dobrich', NULL, NULL);
INSERT INTO `state` VALUES (548, 33, 'Gabrovo', NULL, NULL);
INSERT INTO `state` VALUES (549, 33, 'Haskovo', NULL, NULL);
INSERT INTO `state` VALUES (550, 33, 'Jambol', NULL, NULL);
INSERT INTO `state` VALUES (551, 33, 'Kardzhali', NULL, NULL);
INSERT INTO `state` VALUES (552, 33, 'Kjustendil', NULL, NULL);
INSERT INTO `state` VALUES (553, 33, 'Lovech', NULL, NULL);
INSERT INTO `state` VALUES (554, 33, 'Montana', NULL, NULL);
INSERT INTO `state` VALUES (555, 33, 'Oblast Sofiya-Grad', NULL, NULL);
INSERT INTO `state` VALUES (556, 33, 'Pazardzhik', NULL, NULL);
INSERT INTO `state` VALUES (557, 33, 'Pernik', NULL, NULL);
INSERT INTO `state` VALUES (558, 33, 'Pleven', NULL, NULL);
INSERT INTO `state` VALUES (559, 33, 'Plovdiv', NULL, NULL);
INSERT INTO `state` VALUES (560, 33, 'Razgrad', NULL, NULL);
INSERT INTO `state` VALUES (561, 33, 'Ruse', NULL, NULL);
INSERT INTO `state` VALUES (562, 33, 'Shumen', NULL, NULL);
INSERT INTO `state` VALUES (563, 33, 'Silistra', NULL, NULL);
INSERT INTO `state` VALUES (564, 33, 'Sliven', NULL, NULL);
INSERT INTO `state` VALUES (565, 33, 'Smoljan', NULL, NULL);
INSERT INTO `state` VALUES (566, 33, 'Sofija grad', NULL, NULL);
INSERT INTO `state` VALUES (567, 33, 'Sofijska oblast', NULL, NULL);
INSERT INTO `state` VALUES (568, 33, 'Stara Zagora', NULL, NULL);
INSERT INTO `state` VALUES (569, 33, 'Targovishte', NULL, NULL);
INSERT INTO `state` VALUES (570, 33, 'Varna', NULL, NULL);
INSERT INTO `state` VALUES (571, 33, 'Veliko Tarnovo', NULL, NULL);
INSERT INTO `state` VALUES (572, 33, 'Vidin', NULL, NULL);
INSERT INTO `state` VALUES (573, 33, 'Vraca', NULL, NULL);
INSERT INTO `state` VALUES (574, 33, 'Yablaniza', NULL, NULL);
INSERT INTO `state` VALUES (575, 34, 'Bale', NULL, NULL);
INSERT INTO `state` VALUES (576, 34, 'Bam', NULL, NULL);
INSERT INTO `state` VALUES (577, 34, 'Bazega', NULL, NULL);
INSERT INTO `state` VALUES (578, 34, 'Bougouriba', NULL, NULL);
INSERT INTO `state` VALUES (579, 34, 'Boulgou', NULL, NULL);
INSERT INTO `state` VALUES (580, 34, 'Boulkiemde', NULL, NULL);
INSERT INTO `state` VALUES (581, 34, 'Comoe', NULL, NULL);
INSERT INTO `state` VALUES (582, 34, 'Ganzourgou', NULL, NULL);
INSERT INTO `state` VALUES (583, 34, 'Gnagna', NULL, NULL);
INSERT INTO `state` VALUES (584, 34, 'Gourma', NULL, NULL);
INSERT INTO `state` VALUES (585, 34, 'Houet', NULL, NULL);
INSERT INTO `state` VALUES (586, 34, 'Ioba', NULL, NULL);
INSERT INTO `state` VALUES (587, 34, 'Kadiogo', NULL, NULL);
INSERT INTO `state` VALUES (588, 34, 'Kenedougou', NULL, NULL);
INSERT INTO `state` VALUES (589, 34, 'Komandjari', NULL, NULL);
INSERT INTO `state` VALUES (590, 34, 'Kompienga', NULL, NULL);
INSERT INTO `state` VALUES (591, 34, 'Kossi', NULL, NULL);
INSERT INTO `state` VALUES (592, 34, 'Kouritenga', NULL, NULL);
INSERT INTO `state` VALUES (593, 34, 'Kourweogo', NULL, NULL);
INSERT INTO `state` VALUES (594, 34, 'Leraba', NULL, NULL);
INSERT INTO `state` VALUES (595, 34, 'Mouhoun', NULL, NULL);
INSERT INTO `state` VALUES (596, 34, 'Nahouri', NULL, NULL);
INSERT INTO `state` VALUES (597, 34, 'Namentenga', NULL, NULL);
INSERT INTO `state` VALUES (598, 34, 'Noumbiel', NULL, NULL);
INSERT INTO `state` VALUES (599, 34, 'Oubritenga', NULL, NULL);
INSERT INTO `state` VALUES (600, 34, 'Oudalan', NULL, NULL);
INSERT INTO `state` VALUES (601, 34, 'Passore', NULL, NULL);
INSERT INTO `state` VALUES (602, 34, 'Poni', NULL, NULL);
INSERT INTO `state` VALUES (603, 34, 'Sanguie', NULL, NULL);
INSERT INTO `state` VALUES (604, 34, 'Sanmatenga', NULL, NULL);
INSERT INTO `state` VALUES (605, 34, 'Seno', NULL, NULL);
INSERT INTO `state` VALUES (606, 34, 'Sissili', NULL, NULL);
INSERT INTO `state` VALUES (607, 34, 'Soum', NULL, NULL);
INSERT INTO `state` VALUES (608, 34, 'Sourou', NULL, NULL);
INSERT INTO `state` VALUES (609, 34, 'Tapoa', NULL, NULL);
INSERT INTO `state` VALUES (610, 34, 'Tuy', NULL, NULL);
INSERT INTO `state` VALUES (611, 34, 'Yatenga', NULL, NULL);
INSERT INTO `state` VALUES (612, 34, 'Zondoma', NULL, NULL);
INSERT INTO `state` VALUES (613, 34, 'Zoundweogo', NULL, NULL);
INSERT INTO `state` VALUES (614, 35, 'Bubanza', NULL, NULL);
INSERT INTO `state` VALUES (615, 35, 'Bujumbura', NULL, NULL);
INSERT INTO `state` VALUES (616, 35, 'Bururi', NULL, NULL);
INSERT INTO `state` VALUES (617, 35, 'Cankuzo', NULL, NULL);
INSERT INTO `state` VALUES (618, 35, 'Cibitoke', NULL, NULL);
INSERT INTO `state` VALUES (619, 35, 'Gitega', NULL, NULL);
INSERT INTO `state` VALUES (620, 35, 'Karuzi', NULL, NULL);
INSERT INTO `state` VALUES (621, 35, 'Kayanza', NULL, NULL);
INSERT INTO `state` VALUES (622, 35, 'Kirundo', NULL, NULL);
INSERT INTO `state` VALUES (623, 35, 'Makamba', NULL, NULL);
INSERT INTO `state` VALUES (624, 35, 'Muramvya', NULL, NULL);
INSERT INTO `state` VALUES (625, 35, 'Muyinga', NULL, NULL);
INSERT INTO `state` VALUES (626, 35, 'Ngozi', NULL, NULL);
INSERT INTO `state` VALUES (627, 35, 'Rutana', NULL, NULL);
INSERT INTO `state` VALUES (628, 35, 'Ruyigi', NULL, NULL);
INSERT INTO `state` VALUES (629, 36, 'Banteay Mean Chey', NULL, NULL);
INSERT INTO `state` VALUES (630, 36, 'Bat Dambang', NULL, NULL);
INSERT INTO `state` VALUES (631, 36, 'Kampong Cham', NULL, NULL);
INSERT INTO `state` VALUES (632, 36, 'Kampong Chhnang', NULL, NULL);
INSERT INTO `state` VALUES (633, 36, 'Kampong Spoeu', NULL, NULL);
INSERT INTO `state` VALUES (634, 36, 'Kampong Thum', NULL, NULL);
INSERT INTO `state` VALUES (635, 36, 'Kampot', NULL, NULL);
INSERT INTO `state` VALUES (636, 36, 'Kandal', NULL, NULL);
INSERT INTO `state` VALUES (637, 36, 'Kaoh Kong', NULL, NULL);
INSERT INTO `state` VALUES (638, 36, 'Kracheh', NULL, NULL);
INSERT INTO `state` VALUES (639, 36, 'Krong Kaeb', NULL, NULL);
INSERT INTO `state` VALUES (640, 36, 'Krong Pailin', NULL, NULL);
INSERT INTO `state` VALUES (641, 36, 'Krong Preah Sihanouk', NULL, NULL);
INSERT INTO `state` VALUES (642, 36, 'Mondol Kiri', NULL, NULL);
INSERT INTO `state` VALUES (643, 36, 'Otdar Mean Chey', NULL, NULL);
INSERT INTO `state` VALUES (644, 36, 'Phnum Penh', NULL, NULL);
INSERT INTO `state` VALUES (645, 36, 'Pousat', NULL, NULL);
INSERT INTO `state` VALUES (646, 36, 'Preah Vihear', NULL, NULL);
INSERT INTO `state` VALUES (647, 36, 'Prey Veaeng', NULL, NULL);
INSERT INTO `state` VALUES (648, 36, 'Rotanak Kiri', NULL, NULL);
INSERT INTO `state` VALUES (649, 36, 'Siem Reab', NULL, NULL);
INSERT INTO `state` VALUES (650, 36, 'Stueng Traeng', NULL, NULL);
INSERT INTO `state` VALUES (651, 36, 'Svay Rieng', NULL, NULL);
INSERT INTO `state` VALUES (652, 36, 'Takaev', NULL, NULL);
INSERT INTO `state` VALUES (653, 37, 'Adamaoua', NULL, NULL);
INSERT INTO `state` VALUES (654, 37, 'Centre', NULL, NULL);
INSERT INTO `state` VALUES (655, 37, 'Est', NULL, NULL);
INSERT INTO `state` VALUES (656, 37, 'Littoral', NULL, NULL);
INSERT INTO `state` VALUES (657, 37, 'Nord', NULL, NULL);
INSERT INTO `state` VALUES (658, 37, 'Nord Extreme', NULL, NULL);
INSERT INTO `state` VALUES (659, 37, 'Nordouest', NULL, NULL);
INSERT INTO `state` VALUES (660, 37, 'Ouest', NULL, NULL);
INSERT INTO `state` VALUES (661, 37, 'Sud', NULL, NULL);
INSERT INTO `state` VALUES (662, 37, 'Sudouest', NULL, NULL);
INSERT INTO `state` VALUES (663, 38, 'Alberta', NULL, NULL);
INSERT INTO `state` VALUES (664, 38, 'British Columbia', NULL, NULL);
INSERT INTO `state` VALUES (665, 38, 'Manitoba', NULL, NULL);
INSERT INTO `state` VALUES (666, 38, 'New Brunswick', NULL, NULL);
INSERT INTO `state` VALUES (667, 38, 'Newfoundland and Labrador', NULL, NULL);
INSERT INTO `state` VALUES (668, 38, 'Northwest Territories', NULL, NULL);
INSERT INTO `state` VALUES (669, 38, 'Nova Scotia', NULL, NULL);
INSERT INTO `state` VALUES (670, 38, 'Nunavut', NULL, NULL);
INSERT INTO `state` VALUES (671, 38, 'Ontario', NULL, NULL);
INSERT INTO `state` VALUES (672, 38, 'Prince Edward Island', NULL, NULL);
INSERT INTO `state` VALUES (673, 38, 'Quebec', NULL, NULL);
INSERT INTO `state` VALUES (674, 38, 'Saskatchewan', NULL, NULL);
INSERT INTO `state` VALUES (675, 38, 'Yukon', NULL, NULL);
INSERT INTO `state` VALUES (676, 39, 'Boavista', NULL, NULL);
INSERT INTO `state` VALUES (677, 39, 'Brava', NULL, NULL);
INSERT INTO `state` VALUES (678, 39, 'Fogo', NULL, NULL);
INSERT INTO `state` VALUES (679, 39, 'Maio', NULL, NULL);
INSERT INTO `state` VALUES (680, 39, 'Sal', NULL, NULL);
INSERT INTO `state` VALUES (681, 39, 'Santo Antao', NULL, NULL);
INSERT INTO `state` VALUES (682, 39, 'Sao Nicolau', NULL, NULL);
INSERT INTO `state` VALUES (683, 39, 'Sao Tiago', NULL, NULL);
INSERT INTO `state` VALUES (684, 39, 'Sao Vicente', NULL, NULL);
INSERT INTO `state` VALUES (685, 40, 'Grand Cayman', NULL, NULL);
INSERT INTO `state` VALUES (686, 41, 'Bamingui-Bangoran', NULL, NULL);
INSERT INTO `state` VALUES (687, 41, 'Bangui', NULL, NULL);
INSERT INTO `state` VALUES (688, 41, 'Basse-Kotto', NULL, NULL);
INSERT INTO `state` VALUES (689, 41, 'Haut-Mbomou', NULL, NULL);
INSERT INTO `state` VALUES (690, 41, 'Haute-Kotto', NULL, NULL);
INSERT INTO `state` VALUES (691, 41, 'Kemo', NULL, NULL);
INSERT INTO `state` VALUES (692, 41, 'Lobaye', NULL, NULL);
INSERT INTO `state` VALUES (693, 41, 'Mambere-Kadei', NULL, NULL);
INSERT INTO `state` VALUES (694, 41, 'Mbomou', NULL, NULL);
INSERT INTO `state` VALUES (695, 41, 'Nana-Gribizi', NULL, NULL);
INSERT INTO `state` VALUES (696, 41, 'Nana-Mambere', NULL, NULL);
INSERT INTO `state` VALUES (697, 41, 'Ombella Mpoko', NULL, NULL);
INSERT INTO `state` VALUES (698, 41, 'Ouaka', NULL, NULL);
INSERT INTO `state` VALUES (699, 41, 'Ouham', NULL, NULL);
INSERT INTO `state` VALUES (700, 41, 'Ouham-Pende', NULL, NULL);
INSERT INTO `state` VALUES (701, 41, 'Sangha-Mbaere', NULL, NULL);
INSERT INTO `state` VALUES (702, 41, 'Vakaga', NULL, NULL);
INSERT INTO `state` VALUES (703, 42, 'Batha', NULL, NULL);
INSERT INTO `state` VALUES (704, 42, 'Biltine', NULL, NULL);
INSERT INTO `state` VALUES (705, 42, 'Bourkou-Ennedi-Tibesti', NULL, NULL);
INSERT INTO `state` VALUES (706, 42, 'Chari-Baguirmi', NULL, NULL);
INSERT INTO `state` VALUES (707, 42, 'Guera', NULL, NULL);
INSERT INTO `state` VALUES (708, 42, 'Kanem', NULL, NULL);
INSERT INTO `state` VALUES (709, 42, 'Lac', NULL, NULL);
INSERT INTO `state` VALUES (710, 42, 'Logone Occidental', NULL, NULL);
INSERT INTO `state` VALUES (711, 42, 'Logone Oriental', NULL, NULL);
INSERT INTO `state` VALUES (712, 42, 'Mayo-Kebbi', NULL, NULL);
INSERT INTO `state` VALUES (713, 42, 'Moyen-Chari', NULL, NULL);
INSERT INTO `state` VALUES (714, 42, 'Ouaddai', NULL, NULL);
INSERT INTO `state` VALUES (715, 42, 'Salamat', NULL, NULL);
INSERT INTO `state` VALUES (716, 42, 'Tandjile', NULL, NULL);
INSERT INTO `state` VALUES (717, 43, 'Aisen', NULL, NULL);
INSERT INTO `state` VALUES (718, 43, 'Antofagasta', NULL, NULL);
INSERT INTO `state` VALUES (719, 43, 'Araucania', NULL, NULL);
INSERT INTO `state` VALUES (720, 43, 'Atacama', NULL, NULL);
INSERT INTO `state` VALUES (721, 43, 'Bio Bio', NULL, NULL);
INSERT INTO `state` VALUES (722, 43, 'Coquimbo', NULL, NULL);
INSERT INTO `state` VALUES (723, 43, 'Libertador General Bernardo O\'', NULL, NULL);
INSERT INTO `state` VALUES (724, 43, 'Los Lagos', NULL, NULL);
INSERT INTO `state` VALUES (725, 43, 'Magellanes', NULL, NULL);
INSERT INTO `state` VALUES (726, 43, 'Maule', NULL, NULL);
INSERT INTO `state` VALUES (727, 43, 'Metropolitana', NULL, NULL);
INSERT INTO `state` VALUES (728, 43, 'Metropolitana de Santiago', NULL, NULL);
INSERT INTO `state` VALUES (729, 43, 'Tarapaca', NULL, NULL);
INSERT INTO `state` VALUES (730, 43, 'Valparaiso', NULL, NULL);
INSERT INTO `state` VALUES (731, 44, 'Anhui', NULL, NULL);
INSERT INTO `state` VALUES (732, 44, 'Anhui Province', NULL, NULL);
INSERT INTO `state` VALUES (733, 44, 'Anhui Sheng', NULL, NULL);
INSERT INTO `state` VALUES (734, 44, 'Aomen', NULL, NULL);
INSERT INTO `state` VALUES (735, 44, 'Beijing', NULL, NULL);
INSERT INTO `state` VALUES (736, 44, 'Beijing Shi', NULL, NULL);
INSERT INTO `state` VALUES (737, 44, 'Chongqing', NULL, NULL);
INSERT INTO `state` VALUES (738, 44, 'Fujian', NULL, NULL);
INSERT INTO `state` VALUES (739, 44, 'Fujian Sheng', NULL, NULL);
INSERT INTO `state` VALUES (740, 44, 'Gansu', NULL, NULL);
INSERT INTO `state` VALUES (741, 44, 'Guangdong', NULL, NULL);
INSERT INTO `state` VALUES (742, 44, 'Guangdong Sheng', NULL, NULL);
INSERT INTO `state` VALUES (743, 44, 'Guangxi', NULL, NULL);
INSERT INTO `state` VALUES (744, 44, 'Guizhou', NULL, NULL);
INSERT INTO `state` VALUES (745, 44, 'Hainan', NULL, NULL);
INSERT INTO `state` VALUES (746, 44, 'Hebei', NULL, NULL);
INSERT INTO `state` VALUES (747, 44, 'Heilongjiang', NULL, NULL);
INSERT INTO `state` VALUES (748, 44, 'Henan', NULL, NULL);
INSERT INTO `state` VALUES (749, 44, 'Hubei', NULL, NULL);
INSERT INTO `state` VALUES (750, 44, 'Hunan', NULL, NULL);
INSERT INTO `state` VALUES (751, 44, 'Jiangsu', NULL, NULL);
INSERT INTO `state` VALUES (752, 44, 'Jiangsu Sheng', NULL, NULL);
INSERT INTO `state` VALUES (753, 44, 'Jiangxi', NULL, NULL);
INSERT INTO `state` VALUES (754, 44, 'Jilin', NULL, NULL);
INSERT INTO `state` VALUES (755, 44, 'Liaoning', NULL, NULL);
INSERT INTO `state` VALUES (756, 44, 'Liaoning Sheng', NULL, NULL);
INSERT INTO `state` VALUES (757, 44, 'Nei Monggol', NULL, NULL);
INSERT INTO `state` VALUES (758, 44, 'Ningxia Hui', NULL, NULL);
INSERT INTO `state` VALUES (759, 44, 'Qinghai', NULL, NULL);
INSERT INTO `state` VALUES (760, 44, 'Shaanxi', NULL, NULL);
INSERT INTO `state` VALUES (761, 44, 'Shandong', NULL, NULL);
INSERT INTO `state` VALUES (762, 44, 'Shandong Sheng', NULL, NULL);
INSERT INTO `state` VALUES (763, 44, 'Shanghai', NULL, NULL);
INSERT INTO `state` VALUES (764, 44, 'Shanxi', NULL, NULL);
INSERT INTO `state` VALUES (765, 44, 'Sichuan', NULL, NULL);
INSERT INTO `state` VALUES (766, 44, 'Tianjin', NULL, NULL);
INSERT INTO `state` VALUES (767, 44, 'Xianggang', NULL, NULL);
INSERT INTO `state` VALUES (768, 44, 'Xinjiang', NULL, NULL);
INSERT INTO `state` VALUES (769, 44, 'Xizang', NULL, NULL);
INSERT INTO `state` VALUES (770, 44, 'Yunnan', NULL, NULL);
INSERT INTO `state` VALUES (771, 44, 'Zhejiang', NULL, NULL);
INSERT INTO `state` VALUES (772, 44, 'Zhejiang Sheng', NULL, NULL);
INSERT INTO `state` VALUES (773, 45, 'Christmas Island', NULL, NULL);
INSERT INTO `state` VALUES (774, 46, 'Cocos (Keeling) Islands', NULL, NULL);
INSERT INTO `state` VALUES (775, 47, 'Amazonas', NULL, NULL);
INSERT INTO `state` VALUES (776, 47, 'Antioquia', NULL, NULL);
INSERT INTO `state` VALUES (777, 47, 'Arauca', NULL, NULL);
INSERT INTO `state` VALUES (778, 47, 'Atlantico', NULL, NULL);
INSERT INTO `state` VALUES (779, 47, 'Bogota', NULL, NULL);
INSERT INTO `state` VALUES (780, 47, 'Bolivar', NULL, NULL);
INSERT INTO `state` VALUES (781, 47, 'Boyaca', NULL, NULL);
INSERT INTO `state` VALUES (782, 47, 'Caldas', NULL, NULL);
INSERT INTO `state` VALUES (783, 47, 'Caqueta', NULL, NULL);
INSERT INTO `state` VALUES (784, 47, 'Casanare', NULL, NULL);
INSERT INTO `state` VALUES (785, 47, 'Cauca', NULL, NULL);
INSERT INTO `state` VALUES (786, 47, 'Cesar', NULL, NULL);
INSERT INTO `state` VALUES (787, 47, 'Choco', NULL, NULL);
INSERT INTO `state` VALUES (788, 47, 'Cordoba', NULL, NULL);
INSERT INTO `state` VALUES (789, 47, 'Cundinamarca', NULL, NULL);
INSERT INTO `state` VALUES (790, 47, 'Guainia', NULL, NULL);
INSERT INTO `state` VALUES (791, 47, 'Guaviare', NULL, NULL);
INSERT INTO `state` VALUES (792, 47, 'Huila', NULL, NULL);
INSERT INTO `state` VALUES (793, 47, 'La Guajira', NULL, NULL);
INSERT INTO `state` VALUES (794, 47, 'Magdalena', NULL, NULL);
INSERT INTO `state` VALUES (795, 47, 'Meta', NULL, NULL);
INSERT INTO `state` VALUES (796, 47, 'Narino', NULL, NULL);
INSERT INTO `state` VALUES (797, 47, 'Norte de Santander', NULL, NULL);
INSERT INTO `state` VALUES (798, 47, 'Putumayo', NULL, NULL);
INSERT INTO `state` VALUES (799, 47, 'Quindio', NULL, NULL);
INSERT INTO `state` VALUES (800, 47, 'Risaralda', NULL, NULL);
INSERT INTO `state` VALUES (801, 47, 'San Andres y Providencia', NULL, NULL);
INSERT INTO `state` VALUES (802, 47, 'Santander', NULL, NULL);
INSERT INTO `state` VALUES (803, 47, 'Sucre', NULL, NULL);
INSERT INTO `state` VALUES (804, 47, 'Tolima', NULL, NULL);
INSERT INTO `state` VALUES (805, 47, 'Valle del Cauca', NULL, NULL);
INSERT INTO `state` VALUES (806, 47, 'Vaupes', NULL, NULL);
INSERT INTO `state` VALUES (807, 47, 'Vichada', NULL, NULL);
INSERT INTO `state` VALUES (808, 48, 'Mwali', NULL, NULL);
INSERT INTO `state` VALUES (809, 48, 'Njazidja', NULL, NULL);
INSERT INTO `state` VALUES (810, 48, 'Nzwani', NULL, NULL);
INSERT INTO `state` VALUES (811, 49, 'Bouenza', NULL, NULL);
INSERT INTO `state` VALUES (812, 49, 'Brazzaville', NULL, NULL);
INSERT INTO `state` VALUES (813, 49, 'Cuvette', NULL, NULL);
INSERT INTO `state` VALUES (814, 49, 'Kouilou', NULL, NULL);
INSERT INTO `state` VALUES (815, 49, 'Lekoumou', NULL, NULL);
INSERT INTO `state` VALUES (816, 49, 'Likouala', NULL, NULL);
INSERT INTO `state` VALUES (817, 49, 'Niari', NULL, NULL);
INSERT INTO `state` VALUES (818, 49, 'Plateaux', NULL, NULL);
INSERT INTO `state` VALUES (819, 49, 'Pool', NULL, NULL);
INSERT INTO `state` VALUES (820, 49, 'Sangha', NULL, NULL);
INSERT INTO `state` VALUES (821, 50, 'Bandundu', NULL, NULL);
INSERT INTO `state` VALUES (822, 50, 'Bas-Congo', NULL, NULL);
INSERT INTO `state` VALUES (823, 50, 'Equateur', NULL, NULL);
INSERT INTO `state` VALUES (824, 50, 'Haut-Congo', NULL, NULL);
INSERT INTO `state` VALUES (825, 50, 'Kasai-Occidental', NULL, NULL);
INSERT INTO `state` VALUES (826, 50, 'Kasai-Oriental', NULL, NULL);
INSERT INTO `state` VALUES (827, 50, 'Katanga', NULL, NULL);
INSERT INTO `state` VALUES (828, 50, 'Kinshasa', NULL, NULL);
INSERT INTO `state` VALUES (829, 50, 'Maniema', NULL, NULL);
INSERT INTO `state` VALUES (830, 50, 'Nord-Kivu', NULL, NULL);
INSERT INTO `state` VALUES (831, 50, 'Sud-Kivu', NULL, NULL);
INSERT INTO `state` VALUES (832, 51, 'Aitutaki', NULL, NULL);
INSERT INTO `state` VALUES (833, 51, 'Atiu', NULL, NULL);
INSERT INTO `state` VALUES (834, 51, 'Mangaia', NULL, NULL);
INSERT INTO `state` VALUES (835, 51, 'Manihiki', NULL, NULL);
INSERT INTO `state` VALUES (836, 51, 'Mauke', NULL, NULL);
INSERT INTO `state` VALUES (837, 51, 'Mitiaro', NULL, NULL);
INSERT INTO `state` VALUES (838, 51, 'Nassau', NULL, NULL);
INSERT INTO `state` VALUES (839, 51, 'Pukapuka', NULL, NULL);
INSERT INTO `state` VALUES (840, 51, 'Rakahanga', NULL, NULL);
INSERT INTO `state` VALUES (841, 51, 'Rarotonga', NULL, NULL);
INSERT INTO `state` VALUES (842, 51, 'Tongareva', NULL, NULL);
INSERT INTO `state` VALUES (843, 52, 'Alajuela', NULL, NULL);
INSERT INTO `state` VALUES (844, 52, 'Cartago', NULL, NULL);
INSERT INTO `state` VALUES (845, 52, 'Guanacaste', NULL, NULL);
INSERT INTO `state` VALUES (846, 52, 'Heredia', NULL, NULL);
INSERT INTO `state` VALUES (847, 52, 'Limon', NULL, NULL);
INSERT INTO `state` VALUES (848, 52, 'Puntarenas', NULL, NULL);
INSERT INTO `state` VALUES (849, 52, 'San Jose', NULL, NULL);
INSERT INTO `state` VALUES (850, 53, 'Abidjan', NULL, NULL);
INSERT INTO `state` VALUES (851, 53, 'Agneby', NULL, NULL);
INSERT INTO `state` VALUES (852, 53, 'Bafing', NULL, NULL);
INSERT INTO `state` VALUES (853, 53, 'Denguele', NULL, NULL);
INSERT INTO `state` VALUES (854, 53, 'Dix-huit Montagnes', NULL, NULL);
INSERT INTO `state` VALUES (855, 53, 'Fromager', NULL, NULL);
INSERT INTO `state` VALUES (856, 53, 'Haut-Sassandra', NULL, NULL);
INSERT INTO `state` VALUES (857, 53, 'Lacs', NULL, NULL);
INSERT INTO `state` VALUES (858, 53, 'Lagunes', NULL, NULL);
INSERT INTO `state` VALUES (859, 53, 'Marahoue', NULL, NULL);
INSERT INTO `state` VALUES (860, 53, 'Moyen-Cavally', NULL, NULL);
INSERT INTO `state` VALUES (861, 53, 'Moyen-Comoe', NULL, NULL);
INSERT INTO `state` VALUES (862, 53, 'N\'zi-Comoe', NULL, NULL);
INSERT INTO `state` VALUES (863, 53, 'Sassandra', NULL, NULL);
INSERT INTO `state` VALUES (864, 53, 'Savanes', NULL, NULL);
INSERT INTO `state` VALUES (865, 53, 'Sud-Bandama', NULL, NULL);
INSERT INTO `state` VALUES (866, 53, 'Sud-Comoe', NULL, NULL);
INSERT INTO `state` VALUES (867, 53, 'Vallee du Bandama', NULL, NULL);
INSERT INTO `state` VALUES (868, 53, 'Worodougou', NULL, NULL);
INSERT INTO `state` VALUES (869, 53, 'Zanzan', NULL, NULL);
INSERT INTO `state` VALUES (870, 54, 'Bjelovar-Bilogora', NULL, NULL);
INSERT INTO `state` VALUES (871, 54, 'Dubrovnik-Neretva', NULL, NULL);
INSERT INTO `state` VALUES (872, 54, 'Grad Zagreb', NULL, NULL);
INSERT INTO `state` VALUES (873, 54, 'Istra', NULL, NULL);
INSERT INTO `state` VALUES (874, 54, 'Karlovac', NULL, NULL);
INSERT INTO `state` VALUES (875, 54, 'Koprivnica-Krizhevci', NULL, NULL);
INSERT INTO `state` VALUES (876, 54, 'Krapina-Zagorje', NULL, NULL);
INSERT INTO `state` VALUES (877, 54, 'Lika-Senj', NULL, NULL);
INSERT INTO `state` VALUES (878, 54, 'Medhimurje', NULL, NULL);
INSERT INTO `state` VALUES (879, 54, 'Medimurska Zupanija', NULL, NULL);
INSERT INTO `state` VALUES (880, 54, 'Osijek-Baranja', NULL, NULL);
INSERT INTO `state` VALUES (881, 54, 'Osjecko-Baranjska Zupanija', NULL, NULL);
INSERT INTO `state` VALUES (882, 54, 'Pozhega-Slavonija', NULL, NULL);
INSERT INTO `state` VALUES (883, 54, 'Primorje-Gorski Kotar', NULL, NULL);
INSERT INTO `state` VALUES (884, 54, 'Shibenik-Knin', NULL, NULL);
INSERT INTO `state` VALUES (885, 54, 'Sisak-Moslavina', NULL, NULL);
INSERT INTO `state` VALUES (886, 54, 'Slavonski Brod-Posavina', NULL, NULL);
INSERT INTO `state` VALUES (887, 54, 'Split-Dalmacija', NULL, NULL);
INSERT INTO `state` VALUES (888, 54, 'Varazhdin', NULL, NULL);
INSERT INTO `state` VALUES (889, 54, 'Virovitica-Podravina', NULL, NULL);
INSERT INTO `state` VALUES (890, 54, 'Vukovar-Srijem', NULL, NULL);
INSERT INTO `state` VALUES (891, 54, 'Zadar', NULL, NULL);
INSERT INTO `state` VALUES (892, 54, 'Zagreb', NULL, NULL);
INSERT INTO `state` VALUES (893, 55, 'Camaguey', NULL, NULL);
INSERT INTO `state` VALUES (894, 55, 'Ciego de Avila', NULL, NULL);
INSERT INTO `state` VALUES (895, 55, 'Cienfuegos', NULL, NULL);
INSERT INTO `state` VALUES (896, 55, 'Ciudad de la Habana', NULL, NULL);
INSERT INTO `state` VALUES (897, 55, 'Granma', NULL, NULL);
INSERT INTO `state` VALUES (898, 55, 'Guantanamo', NULL, NULL);
INSERT INTO `state` VALUES (899, 55, 'Habana', NULL, NULL);
INSERT INTO `state` VALUES (900, 55, 'Holguin', NULL, NULL);
INSERT INTO `state` VALUES (901, 55, 'Isla de la Juventud', NULL, NULL);
INSERT INTO `state` VALUES (902, 55, 'La Habana', NULL, NULL);
INSERT INTO `state` VALUES (903, 55, 'Las Tunas', NULL, NULL);
INSERT INTO `state` VALUES (904, 55, 'Matanzas', NULL, NULL);
INSERT INTO `state` VALUES (905, 55, 'Pinar del Rio', NULL, NULL);
INSERT INTO `state` VALUES (906, 55, 'Sancti Spiritus', NULL, NULL);
INSERT INTO `state` VALUES (907, 55, 'Santiago de Cuba', NULL, NULL);
INSERT INTO `state` VALUES (908, 55, 'Villa Clara', NULL, NULL);
INSERT INTO `state` VALUES (909, 56, 'Government controlled area', NULL, NULL);
INSERT INTO `state` VALUES (910, 56, 'Limassol', NULL, NULL);
INSERT INTO `state` VALUES (911, 56, 'Nicosia District', NULL, NULL);
INSERT INTO `state` VALUES (912, 56, 'Paphos', NULL, NULL);
INSERT INTO `state` VALUES (913, 56, 'Turkish controlled area', NULL, NULL);
INSERT INTO `state` VALUES (914, 57, 'Central Bohemian', NULL, NULL);
INSERT INTO `state` VALUES (915, 57, 'Frycovice', NULL, NULL);
INSERT INTO `state` VALUES (916, 57, 'Jihocesky Kraj', NULL, NULL);
INSERT INTO `state` VALUES (917, 57, 'Jihochesky', NULL, NULL);
INSERT INTO `state` VALUES (918, 57, 'Jihomoravsky', NULL, NULL);
INSERT INTO `state` VALUES (919, 57, 'Karlovarsky', NULL, NULL);
INSERT INTO `state` VALUES (920, 57, 'Klecany', NULL, NULL);
INSERT INTO `state` VALUES (921, 57, 'Kralovehradecky', NULL, NULL);
INSERT INTO `state` VALUES (922, 57, 'Liberecky', NULL, NULL);
INSERT INTO `state` VALUES (923, 57, 'Lipov', NULL, NULL);
INSERT INTO `state` VALUES (924, 57, 'Moravskoslezsky', NULL, NULL);
INSERT INTO `state` VALUES (925, 57, 'Olomoucky', NULL, NULL);
INSERT INTO `state` VALUES (926, 57, 'Olomoucky Kraj', NULL, NULL);
INSERT INTO `state` VALUES (927, 57, 'Pardubicky', NULL, NULL);
INSERT INTO `state` VALUES (928, 57, 'Plzensky', NULL, NULL);
INSERT INTO `state` VALUES (929, 57, 'Praha', NULL, NULL);
INSERT INTO `state` VALUES (930, 57, 'Rajhrad', NULL, NULL);
INSERT INTO `state` VALUES (931, 57, 'Smirice', NULL, NULL);
INSERT INTO `state` VALUES (932, 57, 'South Moravian', NULL, NULL);
INSERT INTO `state` VALUES (933, 57, 'Straz nad Nisou', NULL, NULL);
INSERT INTO `state` VALUES (934, 57, 'Stredochesky', NULL, NULL);
INSERT INTO `state` VALUES (935, 57, 'Unicov', NULL, NULL);
INSERT INTO `state` VALUES (936, 57, 'Ustecky', NULL, NULL);
INSERT INTO `state` VALUES (937, 57, 'Valletta', NULL, NULL);
INSERT INTO `state` VALUES (938, 57, 'Velesin', NULL, NULL);
INSERT INTO `state` VALUES (939, 57, 'Vysochina', NULL, NULL);
INSERT INTO `state` VALUES (940, 57, 'Zlinsky', NULL, NULL);
INSERT INTO `state` VALUES (941, 58, 'Arhus', NULL, NULL);
INSERT INTO `state` VALUES (942, 58, 'Bornholm', NULL, NULL);
INSERT INTO `state` VALUES (943, 58, 'Frederiksborg', NULL, NULL);
INSERT INTO `state` VALUES (944, 58, 'Fyn', NULL, NULL);
INSERT INTO `state` VALUES (945, 58, 'Hovedstaden', NULL, NULL);
INSERT INTO `state` VALUES (946, 58, 'Kobenhavn', NULL, NULL);
INSERT INTO `state` VALUES (947, 58, 'Kobenhavns Amt', NULL, NULL);
INSERT INTO `state` VALUES (948, 58, 'Kobenhavns Kommune', NULL, NULL);
INSERT INTO `state` VALUES (949, 58, 'Nordjylland', NULL, NULL);
INSERT INTO `state` VALUES (950, 58, 'Ribe', NULL, NULL);
INSERT INTO `state` VALUES (951, 58, 'Ringkobing', NULL, NULL);
INSERT INTO `state` VALUES (952, 58, 'Roervig', NULL, NULL);
INSERT INTO `state` VALUES (953, 58, 'Roskilde', NULL, NULL);
INSERT INTO `state` VALUES (954, 58, 'Roslev', NULL, NULL);
INSERT INTO `state` VALUES (955, 58, 'Sjaelland', NULL, NULL);
INSERT INTO `state` VALUES (956, 58, 'Soeborg', NULL, NULL);
INSERT INTO `state` VALUES (957, 58, 'Sonderjylland', NULL, NULL);
INSERT INTO `state` VALUES (958, 58, 'Storstrom', NULL, NULL);
INSERT INTO `state` VALUES (959, 58, 'Syddanmark', NULL, NULL);
INSERT INTO `state` VALUES (960, 58, 'Toelloese', NULL, NULL);
INSERT INTO `state` VALUES (961, 58, 'Vejle', NULL, NULL);
INSERT INTO `state` VALUES (962, 58, 'Vestsjalland', NULL, NULL);
INSERT INTO `state` VALUES (963, 58, 'Viborg', NULL, NULL);
INSERT INTO `state` VALUES (964, 59, '\'Ali Sabih', NULL, NULL);
INSERT INTO `state` VALUES (965, 59, 'Dikhil', NULL, NULL);
INSERT INTO `state` VALUES (966, 59, 'Jibuti', NULL, NULL);
INSERT INTO `state` VALUES (967, 59, 'Tajurah', NULL, NULL);
INSERT INTO `state` VALUES (968, 59, 'Ubuk', NULL, NULL);
INSERT INTO `state` VALUES (969, 60, 'Saint Andrew', NULL, NULL);
INSERT INTO `state` VALUES (970, 60, 'Saint David', NULL, NULL);
INSERT INTO `state` VALUES (971, 60, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (972, 60, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (973, 60, 'Saint Joseph', NULL, NULL);
INSERT INTO `state` VALUES (974, 60, 'Saint Luke', NULL, NULL);
INSERT INTO `state` VALUES (975, 60, 'Saint Mark', NULL, NULL);
INSERT INTO `state` VALUES (976, 60, 'Saint Patrick', NULL, NULL);
INSERT INTO `state` VALUES (977, 60, 'Saint Paul', NULL, NULL);
INSERT INTO `state` VALUES (978, 60, 'Saint Peter', NULL, NULL);
INSERT INTO `state` VALUES (979, 61, 'Azua', NULL, NULL);
INSERT INTO `state` VALUES (980, 61, 'Bahoruco', NULL, NULL);
INSERT INTO `state` VALUES (981, 61, 'Barahona', NULL, NULL);
INSERT INTO `state` VALUES (982, 61, 'Dajabon', NULL, NULL);
INSERT INTO `state` VALUES (983, 61, 'Distrito Nacional', NULL, NULL);
INSERT INTO `state` VALUES (984, 61, 'Duarte', NULL, NULL);
INSERT INTO `state` VALUES (985, 61, 'El Seybo', NULL, NULL);
INSERT INTO `state` VALUES (986, 61, 'Elias Pina', NULL, NULL);
INSERT INTO `state` VALUES (987, 61, 'Espaillat', NULL, NULL);
INSERT INTO `state` VALUES (988, 61, 'Hato Mayor', NULL, NULL);
INSERT INTO `state` VALUES (989, 61, 'Independencia', NULL, NULL);
INSERT INTO `state` VALUES (990, 61, 'La Altagracia', NULL, NULL);
INSERT INTO `state` VALUES (991, 61, 'La Romana', NULL, NULL);
INSERT INTO `state` VALUES (992, 61, 'La Vega', NULL, NULL);
INSERT INTO `state` VALUES (993, 61, 'Maria Trinidad Sanchez', NULL, NULL);
INSERT INTO `state` VALUES (994, 61, 'Monsenor Nouel', NULL, NULL);
INSERT INTO `state` VALUES (995, 61, 'Monte Cristi', NULL, NULL);
INSERT INTO `state` VALUES (996, 61, 'Monte Plata', NULL, NULL);
INSERT INTO `state` VALUES (997, 61, 'Pedernales', NULL, NULL);
INSERT INTO `state` VALUES (998, 61, 'Peravia', NULL, NULL);
INSERT INTO `state` VALUES (999, 61, 'Puerto Plata', NULL, NULL);
INSERT INTO `state` VALUES (1000, 61, 'Salcedo', NULL, NULL);
INSERT INTO `state` VALUES (1001, 61, 'Samana', NULL, NULL);
INSERT INTO `state` VALUES (1002, 61, 'San Cristobal', NULL, NULL);
INSERT INTO `state` VALUES (1003, 61, 'San Juan', NULL, NULL);
INSERT INTO `state` VALUES (1004, 61, 'San Pedro de Macoris', NULL, NULL);
INSERT INTO `state` VALUES (1005, 61, 'Sanchez Ramirez', NULL, NULL);
INSERT INTO `state` VALUES (1006, 61, 'Santiago', NULL, NULL);
INSERT INTO `state` VALUES (1007, 61, 'Santiago Rodriguez', NULL, NULL);
INSERT INTO `state` VALUES (1008, 61, 'Valverde', NULL, NULL);
INSERT INTO `state` VALUES (1009, 62, 'Aileu', NULL, NULL);
INSERT INTO `state` VALUES (1010, 62, 'Ainaro', NULL, NULL);
INSERT INTO `state` VALUES (1011, 62, 'Ambeno', NULL, NULL);
INSERT INTO `state` VALUES (1012, 62, 'Baucau', NULL, NULL);
INSERT INTO `state` VALUES (1013, 62, 'Bobonaro', NULL, NULL);
INSERT INTO `state` VALUES (1014, 62, 'Cova Lima', NULL, NULL);
INSERT INTO `state` VALUES (1015, 62, 'Dili', NULL, NULL);
INSERT INTO `state` VALUES (1016, 62, 'Ermera', NULL, NULL);
INSERT INTO `state` VALUES (1017, 62, 'Lautem', NULL, NULL);
INSERT INTO `state` VALUES (1018, 62, 'Liquica', NULL, NULL);
INSERT INTO `state` VALUES (1019, 62, 'Manatuto', NULL, NULL);
INSERT INTO `state` VALUES (1020, 62, 'Manufahi', NULL, NULL);
INSERT INTO `state` VALUES (1021, 62, 'Viqueque', NULL, NULL);
INSERT INTO `state` VALUES (1022, 63, 'Azuay', NULL, NULL);
INSERT INTO `state` VALUES (1023, 63, 'Bolivar', NULL, NULL);
INSERT INTO `state` VALUES (1024, 63, 'Canar', NULL, NULL);
INSERT INTO `state` VALUES (1025, 63, 'Carchi', NULL, NULL);
INSERT INTO `state` VALUES (1026, 63, 'Chimborazo', NULL, NULL);
INSERT INTO `state` VALUES (1027, 63, 'Cotopaxi', NULL, NULL);
INSERT INTO `state` VALUES (1028, 63, 'El Oro', NULL, NULL);
INSERT INTO `state` VALUES (1029, 63, 'Esmeraldas', NULL, NULL);
INSERT INTO `state` VALUES (1030, 63, 'Galapagos', NULL, NULL);
INSERT INTO `state` VALUES (1031, 63, 'Guayas', NULL, NULL);
INSERT INTO `state` VALUES (1032, 63, 'Imbabura', NULL, NULL);
INSERT INTO `state` VALUES (1033, 63, 'Loja', NULL, NULL);
INSERT INTO `state` VALUES (1034, 63, 'Los Rios', NULL, NULL);
INSERT INTO `state` VALUES (1035, 63, 'Manabi', NULL, NULL);
INSERT INTO `state` VALUES (1036, 63, 'Morona Santiago', NULL, NULL);
INSERT INTO `state` VALUES (1037, 63, 'Napo', NULL, NULL);
INSERT INTO `state` VALUES (1038, 63, 'Orellana', NULL, NULL);
INSERT INTO `state` VALUES (1039, 63, 'Pastaza', NULL, NULL);
INSERT INTO `state` VALUES (1040, 63, 'Pichincha', NULL, NULL);
INSERT INTO `state` VALUES (1041, 63, 'Sucumbios', NULL, NULL);
INSERT INTO `state` VALUES (1042, 63, 'Tungurahua', NULL, NULL);
INSERT INTO `state` VALUES (1043, 63, 'Zamora Chinchipe', NULL, NULL);
INSERT INTO `state` VALUES (1044, 64, 'Aswan', NULL, NULL);
INSERT INTO `state` VALUES (1045, 64, 'Asyut', NULL, NULL);
INSERT INTO `state` VALUES (1046, 64, 'Bani Suwayf', NULL, NULL);
INSERT INTO `state` VALUES (1047, 64, 'Bur Sa\'id', NULL, NULL);
INSERT INTO `state` VALUES (1048, 64, 'Cairo', NULL, NULL);
INSERT INTO `state` VALUES (1049, 64, 'Dumyat', NULL, NULL);
INSERT INTO `state` VALUES (1050, 64, 'Kafr-ash-Shaykh', NULL, NULL);
INSERT INTO `state` VALUES (1051, 64, 'Matruh', NULL, NULL);
INSERT INTO `state` VALUES (1052, 64, 'Muhafazat ad Daqahliyah', NULL, NULL);
INSERT INTO `state` VALUES (1053, 64, 'Muhafazat al Fayyum', NULL, NULL);
INSERT INTO `state` VALUES (1054, 64, 'Muhafazat al Gharbiyah', NULL, NULL);
INSERT INTO `state` VALUES (1055, 64, 'Muhafazat al Iskandariyah', NULL, NULL);
INSERT INTO `state` VALUES (1056, 64, 'Muhafazat al Qahirah', NULL, NULL);
INSERT INTO `state` VALUES (1057, 64, 'Qina', NULL, NULL);
INSERT INTO `state` VALUES (1058, 64, 'Sawhaj', NULL, NULL);
INSERT INTO `state` VALUES (1059, 64, 'Sina al-Janubiyah', NULL, NULL);
INSERT INTO `state` VALUES (1060, 64, 'Sina ash-Shamaliyah', NULL, NULL);
INSERT INTO `state` VALUES (1061, 64, 'ad-Daqahliyah', NULL, NULL);
INSERT INTO `state` VALUES (1062, 64, 'al-Bahr-al-Ahmar', NULL, NULL);
INSERT INTO `state` VALUES (1063, 64, 'al-Buhayrah', NULL, NULL);
INSERT INTO `state` VALUES (1064, 64, 'al-Fayyum', NULL, NULL);
INSERT INTO `state` VALUES (1065, 64, 'al-Gharbiyah', NULL, NULL);
INSERT INTO `state` VALUES (1066, 64, 'al-Iskandariyah', NULL, NULL);
INSERT INTO `state` VALUES (1067, 64, 'al-Ismailiyah', NULL, NULL);
INSERT INTO `state` VALUES (1068, 64, 'al-Jizah', NULL, NULL);
INSERT INTO `state` VALUES (1069, 64, 'al-Minufiyah', NULL, NULL);
INSERT INTO `state` VALUES (1070, 64, 'al-Minya', NULL, NULL);
INSERT INTO `state` VALUES (1071, 64, 'al-Qahira', NULL, NULL);
INSERT INTO `state` VALUES (1072, 64, 'al-Qalyubiyah', NULL, NULL);
INSERT INTO `state` VALUES (1073, 64, 'al-Uqsur', NULL, NULL);
INSERT INTO `state` VALUES (1074, 64, 'al-Wadi al-Jadid', NULL, NULL);
INSERT INTO `state` VALUES (1075, 64, 'as-Suways', NULL, NULL);
INSERT INTO `state` VALUES (1076, 64, 'ash-Sharqiyah', NULL, NULL);
INSERT INTO `state` VALUES (1077, 65, 'Ahuachapan', NULL, NULL);
INSERT INTO `state` VALUES (1078, 65, 'Cabanas', NULL, NULL);
INSERT INTO `state` VALUES (1079, 65, 'Chalatenango', NULL, NULL);
INSERT INTO `state` VALUES (1080, 65, 'Cuscatlan', NULL, NULL);
INSERT INTO `state` VALUES (1081, 65, 'La Libertad', NULL, NULL);
INSERT INTO `state` VALUES (1082, 65, 'La Paz', NULL, NULL);
INSERT INTO `state` VALUES (1083, 65, 'La Union', NULL, NULL);
INSERT INTO `state` VALUES (1084, 65, 'Morazan', NULL, NULL);
INSERT INTO `state` VALUES (1085, 65, 'San Miguel', NULL, NULL);
INSERT INTO `state` VALUES (1086, 65, 'San Salvador', NULL, NULL);
INSERT INTO `state` VALUES (1087, 65, 'San Vicente', NULL, NULL);
INSERT INTO `state` VALUES (1088, 65, 'Santa Ana', NULL, NULL);
INSERT INTO `state` VALUES (1089, 65, 'Sonsonate', NULL, NULL);
INSERT INTO `state` VALUES (1090, 65, 'Usulutan', NULL, NULL);
INSERT INTO `state` VALUES (1091, 66, 'Annobon', NULL, NULL);
INSERT INTO `state` VALUES (1092, 66, 'Bioko Norte', NULL, NULL);
INSERT INTO `state` VALUES (1093, 66, 'Bioko Sur', NULL, NULL);
INSERT INTO `state` VALUES (1094, 66, 'Centro Sur', NULL, NULL);
INSERT INTO `state` VALUES (1095, 66, 'Kie-Ntem', NULL, NULL);
INSERT INTO `state` VALUES (1096, 66, 'Litoral', NULL, NULL);
INSERT INTO `state` VALUES (1097, 66, 'Wele-Nzas', NULL, NULL);
INSERT INTO `state` VALUES (1098, 67, 'Anseba', NULL, NULL);
INSERT INTO `state` VALUES (1099, 67, 'Debub', NULL, NULL);
INSERT INTO `state` VALUES (1100, 67, 'Debub-Keih-Bahri', NULL, NULL);
INSERT INTO `state` VALUES (1101, 67, 'Gash-Barka', NULL, NULL);
INSERT INTO `state` VALUES (1102, 67, 'Maekel', NULL, NULL);
INSERT INTO `state` VALUES (1103, 67, 'Semien-Keih-Bahri', NULL, NULL);
INSERT INTO `state` VALUES (1104, 68, 'Harju', NULL, NULL);
INSERT INTO `state` VALUES (1105, 68, 'Hiiu', NULL, NULL);
INSERT INTO `state` VALUES (1106, 68, 'Ida-Viru', NULL, NULL);
INSERT INTO `state` VALUES (1107, 68, 'Jarva', NULL, NULL);
INSERT INTO `state` VALUES (1108, 68, 'Jogeva', NULL, NULL);
INSERT INTO `state` VALUES (1109, 68, 'Laane', NULL, NULL);
INSERT INTO `state` VALUES (1110, 68, 'Laane-Viru', NULL, NULL);
INSERT INTO `state` VALUES (1111, 68, 'Parnu', NULL, NULL);
INSERT INTO `state` VALUES (1112, 68, 'Polva', NULL, NULL);
INSERT INTO `state` VALUES (1113, 68, 'Rapla', NULL, NULL);
INSERT INTO `state` VALUES (1114, 68, 'Saare', NULL, NULL);
INSERT INTO `state` VALUES (1115, 68, 'Tartu', NULL, NULL);
INSERT INTO `state` VALUES (1116, 68, 'Valga', NULL, NULL);
INSERT INTO `state` VALUES (1117, 68, 'Viljandi', NULL, NULL);
INSERT INTO `state` VALUES (1118, 68, 'Voru', NULL, NULL);
INSERT INTO `state` VALUES (1119, 69, 'Addis Abeba', NULL, NULL);
INSERT INTO `state` VALUES (1120, 69, 'Afar', NULL, NULL);
INSERT INTO `state` VALUES (1121, 69, 'Amhara', NULL, NULL);
INSERT INTO `state` VALUES (1122, 69, 'Benishangul', NULL, NULL);
INSERT INTO `state` VALUES (1123, 69, 'Diredawa', NULL, NULL);
INSERT INTO `state` VALUES (1124, 69, 'Gambella', NULL, NULL);
INSERT INTO `state` VALUES (1125, 69, 'Harar', NULL, NULL);
INSERT INTO `state` VALUES (1126, 69, 'Jigjiga', NULL, NULL);
INSERT INTO `state` VALUES (1127, 69, 'Mekele', NULL, NULL);
INSERT INTO `state` VALUES (1128, 69, 'Oromia', NULL, NULL);
INSERT INTO `state` VALUES (1129, 69, 'Somali', NULL, NULL);
INSERT INTO `state` VALUES (1130, 69, 'Southern', NULL, NULL);
INSERT INTO `state` VALUES (1131, 69, 'Tigray', NULL, NULL);
INSERT INTO `state` VALUES (1132, 70, 'Christmas Island', NULL, NULL);
INSERT INTO `state` VALUES (1133, 70, 'Cocos Islands', NULL, NULL);
INSERT INTO `state` VALUES (1134, 70, 'Coral Sea Islands', NULL, NULL);
INSERT INTO `state` VALUES (1135, 71, 'Falkland Islands', NULL, NULL);
INSERT INTO `state` VALUES (1136, 71, 'South Georgia', NULL, NULL);
INSERT INTO `state` VALUES (1137, 72, 'Klaksvik', NULL, NULL);
INSERT INTO `state` VALUES (1138, 72, 'Nor ara Eysturoy', NULL, NULL);
INSERT INTO `state` VALUES (1139, 72, 'Nor oy', NULL, NULL);
INSERT INTO `state` VALUES (1140, 72, 'Sandoy', NULL, NULL);
INSERT INTO `state` VALUES (1141, 72, 'Streymoy', NULL, NULL);
INSERT INTO `state` VALUES (1142, 72, 'Su uroy', NULL, NULL);
INSERT INTO `state` VALUES (1143, 72, 'Sy ra Eysturoy', NULL, NULL);
INSERT INTO `state` VALUES (1144, 72, 'Torshavn', NULL, NULL);
INSERT INTO `state` VALUES (1145, 72, 'Vaga', NULL, NULL);
INSERT INTO `state` VALUES (1146, 73, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (1147, 73, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (1148, 73, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (1149, 73, 'South Pacific', NULL, NULL);
INSERT INTO `state` VALUES (1150, 73, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (1151, 74, 'Ahvenanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1152, 74, 'Etela-Karjala', NULL, NULL);
INSERT INTO `state` VALUES (1153, 74, 'Etela-Pohjanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1154, 74, 'Etela-Savo', NULL, NULL);
INSERT INTO `state` VALUES (1155, 74, 'Etela-Suomen Laani', NULL, NULL);
INSERT INTO `state` VALUES (1156, 74, 'Ita-Suomen Laani', NULL, NULL);
INSERT INTO `state` VALUES (1157, 74, 'Ita-Uusimaa', NULL, NULL);
INSERT INTO `state` VALUES (1158, 74, 'Kainuu', NULL, NULL);
INSERT INTO `state` VALUES (1159, 74, 'Kanta-Hame', NULL, NULL);
INSERT INTO `state` VALUES (1160, 74, 'Keski-Pohjanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1161, 74, 'Keski-Suomi', NULL, NULL);
INSERT INTO `state` VALUES (1162, 74, 'Kymenlaakso', NULL, NULL);
INSERT INTO `state` VALUES (1163, 74, 'Lansi-Suomen Laani', NULL, NULL);
INSERT INTO `state` VALUES (1164, 74, 'Lappi', NULL, NULL);
INSERT INTO `state` VALUES (1165, 74, 'Northern Savonia', NULL, NULL);
INSERT INTO `state` VALUES (1166, 74, 'Ostrobothnia', NULL, NULL);
INSERT INTO `state` VALUES (1167, 74, 'Oulun Laani', NULL, NULL);
INSERT INTO `state` VALUES (1168, 74, 'Paijat-Hame', NULL, NULL);
INSERT INTO `state` VALUES (1169, 74, 'Pirkanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1170, 74, 'Pohjanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1171, 74, 'Pohjois-Karjala', NULL, NULL);
INSERT INTO `state` VALUES (1172, 74, 'Pohjois-Pohjanmaa', NULL, NULL);
INSERT INTO `state` VALUES (1173, 74, 'Pohjois-Savo', NULL, NULL);
INSERT INTO `state` VALUES (1174, 74, 'Saarijarvi', NULL, NULL);
INSERT INTO `state` VALUES (1175, 74, 'Satakunta', NULL, NULL);
INSERT INTO `state` VALUES (1176, 74, 'Southern Savonia', NULL, NULL);
INSERT INTO `state` VALUES (1177, 74, 'Tavastia Proper', NULL, NULL);
INSERT INTO `state` VALUES (1178, 74, 'Uleaborgs Lan', NULL, NULL);
INSERT INTO `state` VALUES (1179, 74, 'Uusimaa', NULL, NULL);
INSERT INTO `state` VALUES (1180, 74, 'Varsinais-Suomi', NULL, NULL);
INSERT INTO `state` VALUES (1181, 75, 'Ain', NULL, NULL);
INSERT INTO `state` VALUES (1182, 75, 'Aisne', NULL, NULL);
INSERT INTO `state` VALUES (1183, 75, 'Albi Le Sequestre', NULL, NULL);
INSERT INTO `state` VALUES (1184, 75, 'Allier', NULL, NULL);
INSERT INTO `state` VALUES (1185, 75, 'Alpes-Cote dAzur', NULL, NULL);
INSERT INTO `state` VALUES (1186, 75, 'Alpes-Maritimes', NULL, NULL);
INSERT INTO `state` VALUES (1187, 75, 'Alpes-de-Haute-Provence', NULL, NULL);
INSERT INTO `state` VALUES (1188, 75, 'Alsace', NULL, NULL);
INSERT INTO `state` VALUES (1189, 75, 'Aquitaine', NULL, NULL);
INSERT INTO `state` VALUES (1190, 75, 'Ardeche', NULL, NULL);
INSERT INTO `state` VALUES (1191, 75, 'Ardennes', NULL, NULL);
INSERT INTO `state` VALUES (1192, 75, 'Ariege', NULL, NULL);
INSERT INTO `state` VALUES (1193, 75, 'Aube', NULL, NULL);
INSERT INTO `state` VALUES (1194, 75, 'Aude', NULL, NULL);
INSERT INTO `state` VALUES (1195, 75, 'Auvergne', NULL, NULL);
INSERT INTO `state` VALUES (1196, 75, 'Aveyron', NULL, NULL);
INSERT INTO `state` VALUES (1197, 75, 'Bas-Rhin', NULL, NULL);
INSERT INTO `state` VALUES (1198, 75, 'Basse-Normandie', NULL, NULL);
INSERT INTO `state` VALUES (1199, 75, 'Bouches-du-Rhone', NULL, NULL);
INSERT INTO `state` VALUES (1200, 75, 'Bourgogne', NULL, NULL);
INSERT INTO `state` VALUES (1201, 75, 'Bretagne', NULL, NULL);
INSERT INTO `state` VALUES (1202, 75, 'Brittany', NULL, NULL);
INSERT INTO `state` VALUES (1203, 75, 'Burgundy', NULL, NULL);
INSERT INTO `state` VALUES (1204, 75, 'Calvados', NULL, NULL);
INSERT INTO `state` VALUES (1205, 75, 'Cantal', NULL, NULL);
INSERT INTO `state` VALUES (1206, 75, 'Cedex', NULL, NULL);
INSERT INTO `state` VALUES (1207, 75, 'Centre', NULL, NULL);
INSERT INTO `state` VALUES (1208, 75, 'Charente', NULL, NULL);
INSERT INTO `state` VALUES (1209, 75, 'Charente-Maritime', NULL, NULL);
INSERT INTO `state` VALUES (1210, 75, 'Cher', NULL, NULL);
INSERT INTO `state` VALUES (1211, 75, 'Correze', NULL, NULL);
INSERT INTO `state` VALUES (1212, 75, 'Corse-du-Sud', NULL, NULL);
INSERT INTO `state` VALUES (1213, 75, 'Cote-d\'Or', NULL, NULL);
INSERT INTO `state` VALUES (1214, 75, 'Cotes-d\'Armor', NULL, NULL);
INSERT INTO `state` VALUES (1215, 75, 'Creuse', NULL, NULL);
INSERT INTO `state` VALUES (1216, 75, 'Crolles', NULL, NULL);
INSERT INTO `state` VALUES (1217, 75, 'Deux-Sevres', NULL, NULL);
INSERT INTO `state` VALUES (1218, 75, 'Dordogne', NULL, NULL);
INSERT INTO `state` VALUES (1219, 75, 'Doubs', NULL, NULL);
INSERT INTO `state` VALUES (1220, 75, 'Drome', NULL, NULL);
INSERT INTO `state` VALUES (1221, 75, 'Essonne', NULL, NULL);
INSERT INTO `state` VALUES (1222, 75, 'Eure', NULL, NULL);
INSERT INTO `state` VALUES (1223, 75, 'Eure-et-Loir', NULL, NULL);
INSERT INTO `state` VALUES (1224, 75, 'Feucherolles', NULL, NULL);
INSERT INTO `state` VALUES (1225, 75, 'Finistere', NULL, NULL);
INSERT INTO `state` VALUES (1226, 75, 'Franche-Comte', NULL, NULL);
INSERT INTO `state` VALUES (1227, 75, 'Gard', NULL, NULL);
INSERT INTO `state` VALUES (1228, 75, 'Gers', NULL, NULL);
INSERT INTO `state` VALUES (1229, 75, 'Gironde', NULL, NULL);
INSERT INTO `state` VALUES (1230, 75, 'Haut-Rhin', NULL, NULL);
INSERT INTO `state` VALUES (1231, 75, 'Haute-Corse', NULL, NULL);
INSERT INTO `state` VALUES (1232, 75, 'Haute-Garonne', NULL, NULL);
INSERT INTO `state` VALUES (1233, 75, 'Haute-Loire', NULL, NULL);
INSERT INTO `state` VALUES (1234, 75, 'Haute-Marne', NULL, NULL);
INSERT INTO `state` VALUES (1235, 75, 'Haute-Saone', NULL, NULL);
INSERT INTO `state` VALUES (1236, 75, 'Haute-Savoie', NULL, NULL);
INSERT INTO `state` VALUES (1237, 75, 'Haute-Vienne', NULL, NULL);
INSERT INTO `state` VALUES (1238, 75, 'Hautes-Alpes', NULL, NULL);
INSERT INTO `state` VALUES (1239, 75, 'Hautes-Pyrenees', NULL, NULL);
INSERT INTO `state` VALUES (1240, 75, 'Hauts-de-Seine', NULL, NULL);
INSERT INTO `state` VALUES (1241, 75, 'Herault', NULL, NULL);
INSERT INTO `state` VALUES (1242, 75, 'Ile-de-France', NULL, NULL);
INSERT INTO `state` VALUES (1243, 75, 'Ille-et-Vilaine', NULL, NULL);
INSERT INTO `state` VALUES (1244, 75, 'Indre', NULL, NULL);
INSERT INTO `state` VALUES (1245, 75, 'Indre-et-Loire', NULL, NULL);
INSERT INTO `state` VALUES (1246, 75, 'Isere', NULL, NULL);
INSERT INTO `state` VALUES (1247, 75, 'Jura', NULL, NULL);
INSERT INTO `state` VALUES (1248, 75, 'Klagenfurt', NULL, NULL);
INSERT INTO `state` VALUES (1249, 75, 'Landes', NULL, NULL);
INSERT INTO `state` VALUES (1250, 75, 'Languedoc-Roussillon', NULL, NULL);
INSERT INTO `state` VALUES (1251, 75, 'Larcay', NULL, NULL);
INSERT INTO `state` VALUES (1252, 75, 'Le Castellet', NULL, NULL);
INSERT INTO `state` VALUES (1253, 75, 'Le Creusot', NULL, NULL);
INSERT INTO `state` VALUES (1254, 75, 'Limousin', NULL, NULL);
INSERT INTO `state` VALUES (1255, 75, 'Loir-et-Cher', NULL, NULL);
INSERT INTO `state` VALUES (1256, 75, 'Loire', NULL, NULL);
INSERT INTO `state` VALUES (1257, 75, 'Loire-Atlantique', NULL, NULL);
INSERT INTO `state` VALUES (1258, 75, 'Loiret', NULL, NULL);
INSERT INTO `state` VALUES (1259, 75, 'Lorraine', NULL, NULL);
INSERT INTO `state` VALUES (1260, 75, 'Lot', NULL, NULL);
INSERT INTO `state` VALUES (1261, 75, 'Lot-et-Garonne', NULL, NULL);
INSERT INTO `state` VALUES (1262, 75, 'Lower Normandy', NULL, NULL);
INSERT INTO `state` VALUES (1263, 75, 'Lozere', NULL, NULL);
INSERT INTO `state` VALUES (1264, 75, 'Maine-et-Loire', NULL, NULL);
INSERT INTO `state` VALUES (1265, 75, 'Manche', NULL, NULL);
INSERT INTO `state` VALUES (1266, 75, 'Marne', NULL, NULL);
INSERT INTO `state` VALUES (1267, 75, 'Mayenne', NULL, NULL);
INSERT INTO `state` VALUES (1268, 75, 'Meurthe-et-Moselle', NULL, NULL);
INSERT INTO `state` VALUES (1269, 75, 'Meuse', NULL, NULL);
INSERT INTO `state` VALUES (1270, 75, 'Midi-Pyrenees', NULL, NULL);
INSERT INTO `state` VALUES (1271, 75, 'Morbihan', NULL, NULL);
INSERT INTO `state` VALUES (1272, 75, 'Moselle', NULL, NULL);
INSERT INTO `state` VALUES (1273, 75, 'Nievre', NULL, NULL);
INSERT INTO `state` VALUES (1274, 75, 'Nord', NULL, NULL);
INSERT INTO `state` VALUES (1275, 75, 'Nord-Pas-de-Calais', NULL, NULL);
INSERT INTO `state` VALUES (1276, 75, 'Oise', NULL, NULL);
INSERT INTO `state` VALUES (1277, 75, 'Orne', NULL, NULL);
INSERT INTO `state` VALUES (1278, 75, 'Paris', NULL, NULL);
INSERT INTO `state` VALUES (1279, 75, 'Pas-de-Calais', NULL, NULL);
INSERT INTO `state` VALUES (1280, 75, 'Pays de la Loire', NULL, NULL);
INSERT INTO `state` VALUES (1281, 75, 'Pays-de-la-Loire', NULL, NULL);
INSERT INTO `state` VALUES (1282, 75, 'Picardy', NULL, NULL);
INSERT INTO `state` VALUES (1283, 75, 'Puy-de-Dome', NULL, NULL);
INSERT INTO `state` VALUES (1284, 75, 'Pyrenees-Atlantiques', NULL, NULL);
INSERT INTO `state` VALUES (1285, 75, 'Pyrenees-Orientales', NULL, NULL);
INSERT INTO `state` VALUES (1286, 75, 'Quelmes', NULL, NULL);
INSERT INTO `state` VALUES (1287, 75, 'Rhone', NULL, NULL);
INSERT INTO `state` VALUES (1288, 75, 'Rhone-Alpes', NULL, NULL);
INSERT INTO `state` VALUES (1289, 75, 'Saint Ouen', NULL, NULL);
INSERT INTO `state` VALUES (1290, 75, 'Saint Viatre', NULL, NULL);
INSERT INTO `state` VALUES (1291, 75, 'Saone-et-Loire', NULL, NULL);
INSERT INTO `state` VALUES (1292, 75, 'Sarthe', NULL, NULL);
INSERT INTO `state` VALUES (1293, 75, 'Savoie', NULL, NULL);
INSERT INTO `state` VALUES (1294, 75, 'Seine-Maritime', NULL, NULL);
INSERT INTO `state` VALUES (1295, 75, 'Seine-Saint-Denis', NULL, NULL);
INSERT INTO `state` VALUES (1296, 75, 'Seine-et-Marne', NULL, NULL);
INSERT INTO `state` VALUES (1297, 75, 'Somme', NULL, NULL);
INSERT INTO `state` VALUES (1298, 75, 'Sophia Antipolis', NULL, NULL);
INSERT INTO `state` VALUES (1299, 75, 'Souvans', NULL, NULL);
INSERT INTO `state` VALUES (1300, 75, 'Tarn', NULL, NULL);
INSERT INTO `state` VALUES (1301, 75, 'Tarn-et-Garonne', NULL, NULL);
INSERT INTO `state` VALUES (1302, 75, 'Territoire de Belfort', NULL, NULL);
INSERT INTO `state` VALUES (1303, 75, 'Treignac', NULL, NULL);
INSERT INTO `state` VALUES (1304, 75, 'Upper Normandy', NULL, NULL);
INSERT INTO `state` VALUES (1305, 75, 'Val-d\'Oise', NULL, NULL);
INSERT INTO `state` VALUES (1306, 75, 'Val-de-Marne', NULL, NULL);
INSERT INTO `state` VALUES (1307, 75, 'Var', NULL, NULL);
INSERT INTO `state` VALUES (1308, 75, 'Vaucluse', NULL, NULL);
INSERT INTO `state` VALUES (1309, 75, 'Vellise', NULL, NULL);
INSERT INTO `state` VALUES (1310, 75, 'Vendee', NULL, NULL);
INSERT INTO `state` VALUES (1311, 75, 'Vienne', NULL, NULL);
INSERT INTO `state` VALUES (1312, 75, 'Vosges', NULL, NULL);
INSERT INTO `state` VALUES (1313, 75, 'Yonne', NULL, NULL);
INSERT INTO `state` VALUES (1314, 75, 'Yvelines', NULL, NULL);
INSERT INTO `state` VALUES (1315, 76, 'Cayenne', NULL, NULL);
INSERT INTO `state` VALUES (1316, 76, 'Saint-Laurent-du-Maroni', NULL, NULL);
INSERT INTO `state` VALUES (1317, 77, 'Iles du Vent', NULL, NULL);
INSERT INTO `state` VALUES (1318, 77, 'Iles sous le Vent', NULL, NULL);
INSERT INTO `state` VALUES (1319, 77, 'Marquesas', NULL, NULL);
INSERT INTO `state` VALUES (1320, 77, 'Tuamotu', NULL, NULL);
INSERT INTO `state` VALUES (1321, 77, 'Tubuai', NULL, NULL);
INSERT INTO `state` VALUES (1322, 78, 'Amsterdam', NULL, NULL);
INSERT INTO `state` VALUES (1323, 78, 'Crozet Islands', NULL, NULL);
INSERT INTO `state` VALUES (1324, 78, 'Kerguelen', NULL, NULL);
INSERT INTO `state` VALUES (1325, 79, 'Estuaire', NULL, NULL);
INSERT INTO `state` VALUES (1326, 79, 'Haut-Ogooue', NULL, NULL);
INSERT INTO `state` VALUES (1327, 79, 'Moyen-Ogooue', NULL, NULL);
INSERT INTO `state` VALUES (1328, 79, 'Ngounie', NULL, NULL);
INSERT INTO `state` VALUES (1329, 79, 'Nyanga', NULL, NULL);
INSERT INTO `state` VALUES (1330, 79, 'Ogooue-Ivindo', NULL, NULL);
INSERT INTO `state` VALUES (1331, 79, 'Ogooue-Lolo', NULL, NULL);
INSERT INTO `state` VALUES (1332, 79, 'Ogooue-Maritime', NULL, NULL);
INSERT INTO `state` VALUES (1333, 79, 'Woleu-Ntem', NULL, NULL);
INSERT INTO `state` VALUES (1334, 80, 'Banjul', NULL, NULL);
INSERT INTO `state` VALUES (1335, 80, 'Basse', NULL, NULL);
INSERT INTO `state` VALUES (1336, 80, 'Brikama', NULL, NULL);
INSERT INTO `state` VALUES (1337, 80, 'Janjanbureh', NULL, NULL);
INSERT INTO `state` VALUES (1338, 80, 'Kanifing', NULL, NULL);
INSERT INTO `state` VALUES (1339, 80, 'Kerewan', NULL, NULL);
INSERT INTO `state` VALUES (1340, 80, 'Kuntaur', NULL, NULL);
INSERT INTO `state` VALUES (1341, 80, 'Mansakonko', NULL, NULL);
INSERT INTO `state` VALUES (1342, 81, 'Abhasia', NULL, NULL);
INSERT INTO `state` VALUES (1343, 81, 'Ajaria', NULL, NULL);
INSERT INTO `state` VALUES (1344, 81, 'Guria', NULL, NULL);
INSERT INTO `state` VALUES (1345, 81, 'Imereti', NULL, NULL);
INSERT INTO `state` VALUES (1346, 81, 'Kaheti', NULL, NULL);
INSERT INTO `state` VALUES (1347, 81, 'Kvemo Kartli', NULL, NULL);
INSERT INTO `state` VALUES (1348, 81, 'Mcheta-Mtianeti', NULL, NULL);
INSERT INTO `state` VALUES (1349, 81, 'Racha', NULL, NULL);
INSERT INTO `state` VALUES (1350, 81, 'Samagrelo-Zemo Svaneti', NULL, NULL);
INSERT INTO `state` VALUES (1351, 81, 'Samche-Zhavaheti', NULL, NULL);
INSERT INTO `state` VALUES (1352, 81, 'Shida Kartli', NULL, NULL);
INSERT INTO `state` VALUES (1353, 81, 'Tbilisi', NULL, NULL);
INSERT INTO `state` VALUES (1354, 82, 'Auvergne', NULL, NULL);
INSERT INTO `state` VALUES (1355, 82, 'Baden-Wurttemberg', NULL, NULL);
INSERT INTO `state` VALUES (1356, 82, 'Bavaria', NULL, NULL);
INSERT INTO `state` VALUES (1357, 82, 'Bayern', NULL, NULL);
INSERT INTO `state` VALUES (1358, 82, 'Beilstein Wurtt', NULL, NULL);
INSERT INTO `state` VALUES (1359, 82, 'Berlin', NULL, NULL);
INSERT INTO `state` VALUES (1360, 82, 'Brandenburg', NULL, NULL);
INSERT INTO `state` VALUES (1361, 82, 'Bremen', NULL, NULL);
INSERT INTO `state` VALUES (1362, 82, 'Dreisbach', NULL, NULL);
INSERT INTO `state` VALUES (1363, 82, 'Freistaat Bayern', NULL, NULL);
INSERT INTO `state` VALUES (1364, 82, 'Hamburg', NULL, NULL);
INSERT INTO `state` VALUES (1365, 82, 'Hannover', NULL, NULL);
INSERT INTO `state` VALUES (1366, 82, 'Heroldstatt', NULL, NULL);
INSERT INTO `state` VALUES (1367, 82, 'Hessen', NULL, NULL);
INSERT INTO `state` VALUES (1368, 82, 'Kortenberg', NULL, NULL);
INSERT INTO `state` VALUES (1369, 82, 'Laasdorf', NULL, NULL);
INSERT INTO `state` VALUES (1370, 82, 'Land Baden-Wurttemberg', NULL, NULL);
INSERT INTO `state` VALUES (1371, 82, 'Land Bayern', NULL, NULL);
INSERT INTO `state` VALUES (1372, 82, 'Land Brandenburg', NULL, NULL);
INSERT INTO `state` VALUES (1373, 82, 'Land Hessen', NULL, NULL);
INSERT INTO `state` VALUES (1374, 82, 'Land Mecklenburg-Vorpommern', NULL, NULL);
INSERT INTO `state` VALUES (1375, 82, 'Land Nordrhein-Westfalen', NULL, NULL);
INSERT INTO `state` VALUES (1376, 82, 'Land Rheinland-Pfalz', NULL, NULL);
INSERT INTO `state` VALUES (1377, 82, 'Land Sachsen', NULL, NULL);
INSERT INTO `state` VALUES (1378, 82, 'Land Sachsen-Anhalt', NULL, NULL);
INSERT INTO `state` VALUES (1379, 82, 'Land Thuringen', NULL, NULL);
INSERT INTO `state` VALUES (1380, 82, 'Lower Saxony', NULL, NULL);
INSERT INTO `state` VALUES (1381, 82, 'Mecklenburg-Vorpommern', NULL, NULL);
INSERT INTO `state` VALUES (1382, 82, 'Mulfingen', NULL, NULL);
INSERT INTO `state` VALUES (1383, 82, 'Munich', NULL, NULL);
INSERT INTO `state` VALUES (1384, 82, 'Neubeuern', NULL, NULL);
INSERT INTO `state` VALUES (1385, 82, 'Niedersachsen', NULL, NULL);
INSERT INTO `state` VALUES (1386, 82, 'Noord-Holland', NULL, NULL);
INSERT INTO `state` VALUES (1387, 82, 'Nordrhein-Westfalen', NULL, NULL);
INSERT INTO `state` VALUES (1388, 82, 'North Rhine-Westphalia', NULL, NULL);
INSERT INTO `state` VALUES (1389, 82, 'Osterode', NULL, NULL);
INSERT INTO `state` VALUES (1390, 82, 'Rheinland-Pfalz', NULL, NULL);
INSERT INTO `state` VALUES (1391, 82, 'Rhineland-Palatinate', NULL, NULL);
INSERT INTO `state` VALUES (1392, 82, 'Saarland', NULL, NULL);
INSERT INTO `state` VALUES (1393, 82, 'Sachsen', NULL, NULL);
INSERT INTO `state` VALUES (1394, 82, 'Sachsen-Anhalt', NULL, NULL);
INSERT INTO `state` VALUES (1395, 82, 'Saxony', NULL, NULL);
INSERT INTO `state` VALUES (1396, 82, 'Schleswig-Holstein', NULL, NULL);
INSERT INTO `state` VALUES (1397, 82, 'Thuringia', NULL, NULL);
INSERT INTO `state` VALUES (1398, 82, 'Webling', NULL, NULL);
INSERT INTO `state` VALUES (1399, 82, 'Weinstrabe', NULL, NULL);
INSERT INTO `state` VALUES (1400, 82, 'schlobborn', NULL, NULL);
INSERT INTO `state` VALUES (1401, 83, 'Ashanti', NULL, NULL);
INSERT INTO `state` VALUES (1402, 83, 'Brong-Ahafo', NULL, NULL);
INSERT INTO `state` VALUES (1403, 83, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (1404, 83, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (1405, 83, 'Greater Accra', NULL, NULL);
INSERT INTO `state` VALUES (1406, 83, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (1407, 83, 'Upper East', NULL, NULL);
INSERT INTO `state` VALUES (1408, 83, 'Upper West', NULL, NULL);
INSERT INTO `state` VALUES (1409, 83, 'Volta', NULL, NULL);
INSERT INTO `state` VALUES (1410, 83, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (1411, 84, 'Gibraltar', NULL, NULL);
INSERT INTO `state` VALUES (1412, 85, 'Acharnes', NULL, NULL);
INSERT INTO `state` VALUES (1413, 85, 'Ahaia', NULL, NULL);
INSERT INTO `state` VALUES (1414, 85, 'Aitolia kai Akarnania', NULL, NULL);
INSERT INTO `state` VALUES (1415, 85, 'Argolis', NULL, NULL);
INSERT INTO `state` VALUES (1416, 85, 'Arkadia', NULL, NULL);
INSERT INTO `state` VALUES (1417, 85, 'Arta', NULL, NULL);
INSERT INTO `state` VALUES (1418, 85, 'Attica', NULL, NULL);
INSERT INTO `state` VALUES (1419, 85, 'Attiki', NULL, NULL);
INSERT INTO `state` VALUES (1420, 85, 'Ayion Oros', NULL, NULL);
INSERT INTO `state` VALUES (1421, 85, 'Crete', NULL, NULL);
INSERT INTO `state` VALUES (1422, 85, 'Dodekanisos', NULL, NULL);
INSERT INTO `state` VALUES (1423, 85, 'Drama', NULL, NULL);
INSERT INTO `state` VALUES (1424, 85, 'Evia', NULL, NULL);
INSERT INTO `state` VALUES (1425, 85, 'Evritania', NULL, NULL);
INSERT INTO `state` VALUES (1426, 85, 'Evros', NULL, NULL);
INSERT INTO `state` VALUES (1427, 85, 'Evvoia', NULL, NULL);
INSERT INTO `state` VALUES (1428, 85, 'Florina', NULL, NULL);
INSERT INTO `state` VALUES (1429, 85, 'Fokis', NULL, NULL);
INSERT INTO `state` VALUES (1430, 85, 'Fthiotis', NULL, NULL);
INSERT INTO `state` VALUES (1431, 85, 'Grevena', NULL, NULL);
INSERT INTO `state` VALUES (1432, 85, 'Halandri', NULL, NULL);
INSERT INTO `state` VALUES (1433, 85, 'Halkidiki', NULL, NULL);
INSERT INTO `state` VALUES (1434, 85, 'Hania', NULL, NULL);
INSERT INTO `state` VALUES (1435, 85, 'Heraklion', NULL, NULL);
INSERT INTO `state` VALUES (1436, 85, 'Hios', NULL, NULL);
INSERT INTO `state` VALUES (1437, 85, 'Ilia', NULL, NULL);
INSERT INTO `state` VALUES (1438, 85, 'Imathia', NULL, NULL);
INSERT INTO `state` VALUES (1439, 85, 'Ioannina', NULL, NULL);
INSERT INTO `state` VALUES (1440, 85, 'Iraklion', NULL, NULL);
INSERT INTO `state` VALUES (1441, 85, 'Karditsa', NULL, NULL);
INSERT INTO `state` VALUES (1442, 85, 'Kastoria', NULL, NULL);
INSERT INTO `state` VALUES (1443, 85, 'Kavala', NULL, NULL);
INSERT INTO `state` VALUES (1444, 85, 'Kefallinia', NULL, NULL);
INSERT INTO `state` VALUES (1445, 85, 'Kerkira', NULL, NULL);
INSERT INTO `state` VALUES (1446, 85, 'Kiklades', NULL, NULL);
INSERT INTO `state` VALUES (1447, 85, 'Kilkis', NULL, NULL);
INSERT INTO `state` VALUES (1448, 85, 'Korinthia', NULL, NULL);
INSERT INTO `state` VALUES (1449, 85, 'Kozani', NULL, NULL);
INSERT INTO `state` VALUES (1450, 85, 'Lakonia', NULL, NULL);
INSERT INTO `state` VALUES (1451, 85, 'Larisa', NULL, NULL);
INSERT INTO `state` VALUES (1452, 85, 'Lasithi', NULL, NULL);
INSERT INTO `state` VALUES (1453, 85, 'Lesvos', NULL, NULL);
INSERT INTO `state` VALUES (1454, 85, 'Levkas', NULL, NULL);
INSERT INTO `state` VALUES (1455, 85, 'Magnisia', NULL, NULL);
INSERT INTO `state` VALUES (1456, 85, 'Messinia', NULL, NULL);
INSERT INTO `state` VALUES (1457, 85, 'Nomos Attikis', NULL, NULL);
INSERT INTO `state` VALUES (1458, 85, 'Nomos Zakynthou', NULL, NULL);
INSERT INTO `state` VALUES (1459, 85, 'Pella', NULL, NULL);
INSERT INTO `state` VALUES (1460, 85, 'Pieria', NULL, NULL);
INSERT INTO `state` VALUES (1461, 85, 'Piraios', NULL, NULL);
INSERT INTO `state` VALUES (1462, 85, 'Preveza', NULL, NULL);
INSERT INTO `state` VALUES (1463, 85, 'Rethimni', NULL, NULL);
INSERT INTO `state` VALUES (1464, 85, 'Rodopi', NULL, NULL);
INSERT INTO `state` VALUES (1465, 85, 'Samos', NULL, NULL);
INSERT INTO `state` VALUES (1466, 85, 'Serrai', NULL, NULL);
INSERT INTO `state` VALUES (1467, 85, 'Thesprotia', NULL, NULL);
INSERT INTO `state` VALUES (1468, 85, 'Thessaloniki', NULL, NULL);
INSERT INTO `state` VALUES (1469, 85, 'Trikala', NULL, NULL);
INSERT INTO `state` VALUES (1470, 85, 'Voiotia', NULL, NULL);
INSERT INTO `state` VALUES (1471, 85, 'West Greece', NULL, NULL);
INSERT INTO `state` VALUES (1472, 85, 'Xanthi', NULL, NULL);
INSERT INTO `state` VALUES (1473, 85, 'Zakinthos', NULL, NULL);
INSERT INTO `state` VALUES (1474, 86, 'Aasiaat', NULL, NULL);
INSERT INTO `state` VALUES (1475, 86, 'Ammassalik', NULL, NULL);
INSERT INTO `state` VALUES (1476, 86, 'Illoqqortoormiut', NULL, NULL);
INSERT INTO `state` VALUES (1477, 86, 'Ilulissat', NULL, NULL);
INSERT INTO `state` VALUES (1478, 86, 'Ivittuut', NULL, NULL);
INSERT INTO `state` VALUES (1479, 86, 'Kangaatsiaq', NULL, NULL);
INSERT INTO `state` VALUES (1480, 86, 'Maniitsoq', NULL, NULL);
INSERT INTO `state` VALUES (1481, 86, 'Nanortalik', NULL, NULL);
INSERT INTO `state` VALUES (1482, 86, 'Narsaq', NULL, NULL);
INSERT INTO `state` VALUES (1483, 86, 'Nuuk', NULL, NULL);
INSERT INTO `state` VALUES (1484, 86, 'Paamiut', NULL, NULL);
INSERT INTO `state` VALUES (1485, 86, 'Qaanaaq', NULL, NULL);
INSERT INTO `state` VALUES (1486, 86, 'Qaqortoq', NULL, NULL);
INSERT INTO `state` VALUES (1487, 86, 'Qasigiannguit', NULL, NULL);
INSERT INTO `state` VALUES (1488, 86, 'Qeqertarsuaq', NULL, NULL);
INSERT INTO `state` VALUES (1489, 86, 'Sisimiut', NULL, NULL);
INSERT INTO `state` VALUES (1490, 86, 'Udenfor kommunal inddeling', NULL, NULL);
INSERT INTO `state` VALUES (1491, 86, 'Upernavik', NULL, NULL);
INSERT INTO `state` VALUES (1492, 86, 'Uummannaq', NULL, NULL);
INSERT INTO `state` VALUES (1493, 87, 'Carriacou-Petite Martinique', NULL, NULL);
INSERT INTO `state` VALUES (1494, 87, 'Saint Andrew', NULL, NULL);
INSERT INTO `state` VALUES (1495, 87, 'Saint Davids', NULL, NULL);
INSERT INTO `state` VALUES (1496, 87, 'Saint George\'s', NULL, NULL);
INSERT INTO `state` VALUES (1497, 87, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (1498, 87, 'Saint Mark', NULL, NULL);
INSERT INTO `state` VALUES (1499, 87, 'Saint Patrick', NULL, NULL);
INSERT INTO `state` VALUES (1500, 88, 'Basse-Terre', NULL, NULL);
INSERT INTO `state` VALUES (1501, 88, 'Grande-Terre', NULL, NULL);
INSERT INTO `state` VALUES (1502, 88, 'Iles des Saintes', NULL, NULL);
INSERT INTO `state` VALUES (1503, 88, 'La Desirade', NULL, NULL);
INSERT INTO `state` VALUES (1504, 88, 'Marie-Galante', NULL, NULL);
INSERT INTO `state` VALUES (1505, 88, 'Saint Barthelemy', NULL, NULL);
INSERT INTO `state` VALUES (1506, 88, 'Saint Martin', NULL, NULL);
INSERT INTO `state` VALUES (1507, 89, 'Agana Heights', NULL, NULL);
INSERT INTO `state` VALUES (1508, 89, 'Agat', NULL, NULL);
INSERT INTO `state` VALUES (1509, 89, 'Barrigada', NULL, NULL);
INSERT INTO `state` VALUES (1510, 89, 'Chalan-Pago-Ordot', NULL, NULL);
INSERT INTO `state` VALUES (1511, 89, 'Dededo', NULL, NULL);
INSERT INTO `state` VALUES (1512, 89, 'Hagatna', NULL, NULL);
INSERT INTO `state` VALUES (1513, 89, 'Inarajan', NULL, NULL);
INSERT INTO `state` VALUES (1514, 89, 'Mangilao', NULL, NULL);
INSERT INTO `state` VALUES (1515, 89, 'Merizo', NULL, NULL);
INSERT INTO `state` VALUES (1516, 89, 'Mongmong-Toto-Maite', NULL, NULL);
INSERT INTO `state` VALUES (1517, 89, 'Santa Rita', NULL, NULL);
INSERT INTO `state` VALUES (1518, 89, 'Sinajana', NULL, NULL);
INSERT INTO `state` VALUES (1519, 89, 'Talofofo', NULL, NULL);
INSERT INTO `state` VALUES (1520, 89, 'Tamuning', NULL, NULL);
INSERT INTO `state` VALUES (1521, 89, 'Yigo', NULL, NULL);
INSERT INTO `state` VALUES (1522, 89, 'Yona', NULL, NULL);
INSERT INTO `state` VALUES (1523, 90, 'Alta Verapaz', NULL, NULL);
INSERT INTO `state` VALUES (1524, 90, 'Baja Verapaz', NULL, NULL);
INSERT INTO `state` VALUES (1525, 90, 'Chimaltenango', NULL, NULL);
INSERT INTO `state` VALUES (1526, 90, 'Chiquimula', NULL, NULL);
INSERT INTO `state` VALUES (1527, 90, 'El Progreso', NULL, NULL);
INSERT INTO `state` VALUES (1528, 90, 'Escuintla', NULL, NULL);
INSERT INTO `state` VALUES (1529, 90, 'Guatemala', NULL, NULL);
INSERT INTO `state` VALUES (1530, 90, 'Huehuetenango', NULL, NULL);
INSERT INTO `state` VALUES (1531, 90, 'Izabal', NULL, NULL);
INSERT INTO `state` VALUES (1532, 90, 'Jalapa', NULL, NULL);
INSERT INTO `state` VALUES (1533, 90, 'Jutiapa', NULL, NULL);
INSERT INTO `state` VALUES (1534, 90, 'Peten', NULL, NULL);
INSERT INTO `state` VALUES (1535, 90, 'Quezaltenango', NULL, NULL);
INSERT INTO `state` VALUES (1536, 90, 'Quiche', NULL, NULL);
INSERT INTO `state` VALUES (1537, 90, 'Retalhuleu', NULL, NULL);
INSERT INTO `state` VALUES (1538, 90, 'Sacatepequez', NULL, NULL);
INSERT INTO `state` VALUES (1539, 90, 'San Marcos', NULL, NULL);
INSERT INTO `state` VALUES (1540, 90, 'Santa Rosa', NULL, NULL);
INSERT INTO `state` VALUES (1541, 90, 'Solola', NULL, NULL);
INSERT INTO `state` VALUES (1542, 90, 'Suchitepequez', NULL, NULL);
INSERT INTO `state` VALUES (1543, 90, 'Totonicapan', NULL, NULL);
INSERT INTO `state` VALUES (1544, 90, 'Zacapa', NULL, NULL);
INSERT INTO `state` VALUES (1545, 91, 'Alderney', NULL, NULL);
INSERT INTO `state` VALUES (1546, 91, 'Castel', NULL, NULL);
INSERT INTO `state` VALUES (1547, 91, 'Forest', NULL, NULL);
INSERT INTO `state` VALUES (1548, 91, 'Saint Andrew', NULL, NULL);
INSERT INTO `state` VALUES (1549, 91, 'Saint Martin', NULL, NULL);
INSERT INTO `state` VALUES (1550, 91, 'Saint Peter Port', NULL, NULL);
INSERT INTO `state` VALUES (1551, 91, 'Saint Pierre du Bois', NULL, NULL);
INSERT INTO `state` VALUES (1552, 91, 'Saint Sampson', NULL, NULL);
INSERT INTO `state` VALUES (1553, 91, 'Saint Saviour', NULL, NULL);
INSERT INTO `state` VALUES (1554, 91, 'Sark', NULL, NULL);
INSERT INTO `state` VALUES (1555, 91, 'Torteval', NULL, NULL);
INSERT INTO `state` VALUES (1556, 91, 'Vale', NULL, NULL);
INSERT INTO `state` VALUES (1557, 92, 'Beyla', NULL, NULL);
INSERT INTO `state` VALUES (1558, 92, 'Boffa', NULL, NULL);
INSERT INTO `state` VALUES (1559, 92, 'Boke', NULL, NULL);
INSERT INTO `state` VALUES (1560, 92, 'Conakry', NULL, NULL);
INSERT INTO `state` VALUES (1561, 92, 'Coyah', NULL, NULL);
INSERT INTO `state` VALUES (1562, 92, 'Dabola', NULL, NULL);
INSERT INTO `state` VALUES (1563, 92, 'Dalaba', NULL, NULL);
INSERT INTO `state` VALUES (1564, 92, 'Dinguiraye', NULL, NULL);
INSERT INTO `state` VALUES (1565, 92, 'Faranah', NULL, NULL);
INSERT INTO `state` VALUES (1566, 92, 'Forecariah', NULL, NULL);
INSERT INTO `state` VALUES (1567, 92, 'Fria', NULL, NULL);
INSERT INTO `state` VALUES (1568, 92, 'Gaoual', NULL, NULL);
INSERT INTO `state` VALUES (1569, 92, 'Gueckedou', NULL, NULL);
INSERT INTO `state` VALUES (1570, 92, 'Kankan', NULL, NULL);
INSERT INTO `state` VALUES (1571, 92, 'Kerouane', NULL, NULL);
INSERT INTO `state` VALUES (1572, 92, 'Kindia', NULL, NULL);
INSERT INTO `state` VALUES (1573, 92, 'Kissidougou', NULL, NULL);
INSERT INTO `state` VALUES (1574, 92, 'Koubia', NULL, NULL);
INSERT INTO `state` VALUES (1575, 92, 'Koundara', NULL, NULL);
INSERT INTO `state` VALUES (1576, 92, 'Kouroussa', NULL, NULL);
INSERT INTO `state` VALUES (1577, 92, 'Labe', NULL, NULL);
INSERT INTO `state` VALUES (1578, 92, 'Lola', NULL, NULL);
INSERT INTO `state` VALUES (1579, 92, 'Macenta', NULL, NULL);
INSERT INTO `state` VALUES (1580, 92, 'Mali', NULL, NULL);
INSERT INTO `state` VALUES (1581, 92, 'Mamou', NULL, NULL);
INSERT INTO `state` VALUES (1582, 92, 'Mandiana', NULL, NULL);
INSERT INTO `state` VALUES (1583, 92, 'Nzerekore', NULL, NULL);
INSERT INTO `state` VALUES (1584, 92, 'Pita', NULL, NULL);
INSERT INTO `state` VALUES (1585, 92, 'Siguiri', NULL, NULL);
INSERT INTO `state` VALUES (1586, 92, 'Telimele', NULL, NULL);
INSERT INTO `state` VALUES (1587, 92, 'Tougue', NULL, NULL);
INSERT INTO `state` VALUES (1588, 92, 'Yomou', NULL, NULL);
INSERT INTO `state` VALUES (1589, 93, 'Bafata', NULL, NULL);
INSERT INTO `state` VALUES (1590, 93, 'Bissau', NULL, NULL);
INSERT INTO `state` VALUES (1591, 93, 'Bolama', NULL, NULL);
INSERT INTO `state` VALUES (1592, 93, 'Cacheu', NULL, NULL);
INSERT INTO `state` VALUES (1593, 93, 'Gabu', NULL, NULL);
INSERT INTO `state` VALUES (1594, 93, 'Oio', NULL, NULL);
INSERT INTO `state` VALUES (1595, 93, 'Quinara', NULL, NULL);
INSERT INTO `state` VALUES (1596, 93, 'Tombali', NULL, NULL);
INSERT INTO `state` VALUES (1597, 94, 'Barima-Waini', NULL, NULL);
INSERT INTO `state` VALUES (1598, 94, 'Cuyuni-Mazaruni', NULL, NULL);
INSERT INTO `state` VALUES (1599, 94, 'Demerara-Mahaica', NULL, NULL);
INSERT INTO `state` VALUES (1600, 94, 'East Berbice-Corentyne', NULL, NULL);
INSERT INTO `state` VALUES (1601, 94, 'Essequibo Islands-West Demerar', NULL, NULL);
INSERT INTO `state` VALUES (1602, 94, 'Mahaica-Berbice', NULL, NULL);
INSERT INTO `state` VALUES (1603, 94, 'Pomeroon-Supenaam', NULL, NULL);
INSERT INTO `state` VALUES (1604, 94, 'Potaro-Siparuni', NULL, NULL);
INSERT INTO `state` VALUES (1605, 94, 'Upper Demerara-Berbice', NULL, NULL);
INSERT INTO `state` VALUES (1606, 94, 'Upper Takutu-Upper Essequibo', NULL, NULL);
INSERT INTO `state` VALUES (1607, 95, 'Artibonite', NULL, NULL);
INSERT INTO `state` VALUES (1608, 95, 'Centre', NULL, NULL);
INSERT INTO `state` VALUES (1609, 95, 'Grand\'Anse', NULL, NULL);
INSERT INTO `state` VALUES (1610, 95, 'Nord', NULL, NULL);
INSERT INTO `state` VALUES (1611, 95, 'Nord-Est', NULL, NULL);
INSERT INTO `state` VALUES (1612, 95, 'Nord-Ouest', NULL, NULL);
INSERT INTO `state` VALUES (1613, 95, 'Ouest', NULL, NULL);
INSERT INTO `state` VALUES (1614, 95, 'Sud', NULL, NULL);
INSERT INTO `state` VALUES (1615, 95, 'Sud-Est', NULL, NULL);
INSERT INTO `state` VALUES (1616, 96, 'Heard and McDonald Islands', NULL, NULL);
INSERT INTO `state` VALUES (1617, 97, 'Atlantida', NULL, NULL);
INSERT INTO `state` VALUES (1618, 97, 'Choluteca', NULL, NULL);
INSERT INTO `state` VALUES (1619, 97, 'Colon', NULL, NULL);
INSERT INTO `state` VALUES (1620, 97, 'Comayagua', NULL, NULL);
INSERT INTO `state` VALUES (1621, 97, 'Copan', NULL, NULL);
INSERT INTO `state` VALUES (1622, 97, 'Cortes', NULL, NULL);
INSERT INTO `state` VALUES (1623, 97, 'Distrito Central', NULL, NULL);
INSERT INTO `state` VALUES (1624, 97, 'El Paraiso', NULL, NULL);
INSERT INTO `state` VALUES (1625, 97, 'Francisco Morazan', NULL, NULL);
INSERT INTO `state` VALUES (1626, 97, 'Gracias a Dios', NULL, NULL);
INSERT INTO `state` VALUES (1627, 97, 'Intibuca', NULL, NULL);
INSERT INTO `state` VALUES (1628, 97, 'Islas de la Bahia', NULL, NULL);
INSERT INTO `state` VALUES (1629, 97, 'La Paz', NULL, NULL);
INSERT INTO `state` VALUES (1630, 97, 'Lempira', NULL, NULL);
INSERT INTO `state` VALUES (1631, 97, 'Ocotepeque', NULL, NULL);
INSERT INTO `state` VALUES (1632, 97, 'Olancho', NULL, NULL);
INSERT INTO `state` VALUES (1633, 97, 'Santa Barbara', NULL, NULL);
INSERT INTO `state` VALUES (1634, 97, 'Valle', NULL, NULL);
INSERT INTO `state` VALUES (1635, 97, 'Yoro', NULL, NULL);
INSERT INTO `state` VALUES (1636, 98, 'Hong Kong', NULL, NULL);
INSERT INTO `state` VALUES (1637, 99, 'Bacs-Kiskun', NULL, NULL);
INSERT INTO `state` VALUES (1638, 99, 'Baranya', NULL, NULL);
INSERT INTO `state` VALUES (1639, 99, 'Bekes', NULL, NULL);
INSERT INTO `state` VALUES (1640, 99, 'Borsod-Abauj-Zemplen', NULL, NULL);
INSERT INTO `state` VALUES (1641, 99, 'Budapest', NULL, NULL);
INSERT INTO `state` VALUES (1642, 99, 'Csongrad', NULL, NULL);
INSERT INTO `state` VALUES (1643, 99, 'Fejer', NULL, NULL);
INSERT INTO `state` VALUES (1644, 99, 'Gyor-Moson-Sopron', NULL, NULL);
INSERT INTO `state` VALUES (1645, 99, 'Hajdu-Bihar', NULL, NULL);
INSERT INTO `state` VALUES (1646, 99, 'Heves', NULL, NULL);
INSERT INTO `state` VALUES (1647, 99, 'Jasz-Nagykun-Szolnok', NULL, NULL);
INSERT INTO `state` VALUES (1648, 99, 'Komarom-Esztergom', NULL, NULL);
INSERT INTO `state` VALUES (1649, 99, 'Nograd', NULL, NULL);
INSERT INTO `state` VALUES (1650, 99, 'Pest', NULL, NULL);
INSERT INTO `state` VALUES (1651, 99, 'Somogy', NULL, NULL);
INSERT INTO `state` VALUES (1652, 99, 'Szabolcs-Szatmar-Bereg', NULL, NULL);
INSERT INTO `state` VALUES (1653, 99, 'Tolna', NULL, NULL);
INSERT INTO `state` VALUES (1654, 99, 'Vas', NULL, NULL);
INSERT INTO `state` VALUES (1655, 99, 'Veszprem', NULL, NULL);
INSERT INTO `state` VALUES (1656, 99, 'Zala', NULL, NULL);
INSERT INTO `state` VALUES (1657, 100, 'Austurland', NULL, NULL);
INSERT INTO `state` VALUES (1658, 100, 'Gullbringusysla', NULL, NULL);
INSERT INTO `state` VALUES (1659, 100, 'Hofu borgarsva i', NULL, NULL);
INSERT INTO `state` VALUES (1660, 100, 'Nor urland eystra', NULL, NULL);
INSERT INTO `state` VALUES (1661, 100, 'Nor urland vestra', NULL, NULL);
INSERT INTO `state` VALUES (1662, 100, 'Su urland', NULL, NULL);
INSERT INTO `state` VALUES (1663, 100, 'Su urnes', NULL, NULL);
INSERT INTO `state` VALUES (1664, 100, 'Vestfir ir', NULL, NULL);
INSERT INTO `state` VALUES (1665, 100, 'Vesturland', NULL, NULL);
INSERT INTO `state` VALUES (1666, 102, 'Aceh', NULL, NULL);
INSERT INTO `state` VALUES (1667, 102, 'Bali', NULL, NULL);
INSERT INTO `state` VALUES (1668, 102, 'Bangka-Belitung', NULL, NULL);
INSERT INTO `state` VALUES (1669, 102, 'Banten', NULL, NULL);
INSERT INTO `state` VALUES (1670, 102, 'Bengkulu', NULL, NULL);
INSERT INTO `state` VALUES (1671, 102, 'Gandaria', NULL, NULL);
INSERT INTO `state` VALUES (1672, 102, 'Gorontalo', NULL, NULL);
INSERT INTO `state` VALUES (1673, 102, 'Jakarta', NULL, NULL);
INSERT INTO `state` VALUES (1674, 102, 'Jambi', NULL, NULL);
INSERT INTO `state` VALUES (1675, 102, 'Jawa Barat', NULL, NULL);
INSERT INTO `state` VALUES (1676, 102, 'Jawa Tengah', NULL, NULL);
INSERT INTO `state` VALUES (1677, 102, 'Jawa Timur', NULL, NULL);
INSERT INTO `state` VALUES (1678, 102, 'Kalimantan Barat', NULL, NULL);
INSERT INTO `state` VALUES (1679, 102, 'Kalimantan Selatan', NULL, NULL);
INSERT INTO `state` VALUES (1680, 102, 'Kalimantan Tengah', NULL, NULL);
INSERT INTO `state` VALUES (1681, 102, 'Kalimantan Timur', NULL, NULL);
INSERT INTO `state` VALUES (1682, 102, 'Kendal', NULL, NULL);
INSERT INTO `state` VALUES (1683, 102, 'Lampung', NULL, NULL);
INSERT INTO `state` VALUES (1684, 102, 'Maluku', NULL, NULL);
INSERT INTO `state` VALUES (1685, 102, 'Maluku Utara', NULL, NULL);
INSERT INTO `state` VALUES (1686, 102, 'Nusa Tenggara Barat', NULL, NULL);
INSERT INTO `state` VALUES (1687, 102, 'Nusa Tenggara Timur', NULL, NULL);
INSERT INTO `state` VALUES (1688, 102, 'Papua', NULL, NULL);
INSERT INTO `state` VALUES (1689, 102, 'Riau', NULL, NULL);
INSERT INTO `state` VALUES (1690, 102, 'Riau Kepulauan', NULL, NULL);
INSERT INTO `state` VALUES (1691, 102, 'Solo', NULL, NULL);
INSERT INTO `state` VALUES (1692, 102, 'Sulawesi Selatan', NULL, NULL);
INSERT INTO `state` VALUES (1693, 102, 'Sulawesi Tengah', NULL, NULL);
INSERT INTO `state` VALUES (1694, 102, 'Sulawesi Tenggara', NULL, NULL);
INSERT INTO `state` VALUES (1695, 102, 'Sulawesi Utara', NULL, NULL);
INSERT INTO `state` VALUES (1696, 102, 'Sumatera Barat', NULL, NULL);
INSERT INTO `state` VALUES (1697, 102, 'Sumatera Selatan', NULL, NULL);
INSERT INTO `state` VALUES (1698, 102, 'Sumatera Utara', NULL, NULL);
INSERT INTO `state` VALUES (1699, 102, 'Yogyakarta', NULL, NULL);
INSERT INTO `state` VALUES (1700, 103, 'Ardabil', NULL, NULL);
INSERT INTO `state` VALUES (1701, 103, 'Azarbayjan-e Bakhtari', NULL, NULL);
INSERT INTO `state` VALUES (1702, 103, 'Azarbayjan-e Khavari', NULL, NULL);
INSERT INTO `state` VALUES (1703, 103, 'Bushehr', NULL, NULL);
INSERT INTO `state` VALUES (1704, 103, 'Chahar Mahal-e Bakhtiari', NULL, NULL);
INSERT INTO `state` VALUES (1705, 103, 'Esfahan', NULL, NULL);
INSERT INTO `state` VALUES (1706, 103, 'Fars', NULL, NULL);
INSERT INTO `state` VALUES (1707, 103, 'Gilan', NULL, NULL);
INSERT INTO `state` VALUES (1708, 103, 'Golestan', NULL, NULL);
INSERT INTO `state` VALUES (1709, 103, 'Hamadan', NULL, NULL);
INSERT INTO `state` VALUES (1710, 103, 'Hormozgan', NULL, NULL);
INSERT INTO `state` VALUES (1711, 103, 'Ilam', NULL, NULL);
INSERT INTO `state` VALUES (1712, 103, 'Kerman', NULL, NULL);
INSERT INTO `state` VALUES (1713, 103, 'Kermanshah', NULL, NULL);
INSERT INTO `state` VALUES (1714, 103, 'Khorasan', NULL, NULL);
INSERT INTO `state` VALUES (1715, 103, 'Khuzestan', NULL, NULL);
INSERT INTO `state` VALUES (1716, 103, 'Kohgiluyeh-e Boyerahmad', NULL, NULL);
INSERT INTO `state` VALUES (1717, 103, 'Kordestan', NULL, NULL);
INSERT INTO `state` VALUES (1718, 103, 'Lorestan', NULL, NULL);
INSERT INTO `state` VALUES (1719, 103, 'Markazi', NULL, NULL);
INSERT INTO `state` VALUES (1720, 103, 'Mazandaran', NULL, NULL);
INSERT INTO `state` VALUES (1721, 103, 'Ostan-e Esfahan', NULL, NULL);
INSERT INTO `state` VALUES (1722, 103, 'Qazvin', NULL, NULL);
INSERT INTO `state` VALUES (1723, 103, 'Qom', NULL, NULL);
INSERT INTO `state` VALUES (1724, 103, 'Semnan', NULL, NULL);
INSERT INTO `state` VALUES (1725, 103, 'Sistan-e Baluchestan', NULL, NULL);
INSERT INTO `state` VALUES (1726, 103, 'Tehran', NULL, NULL);
INSERT INTO `state` VALUES (1727, 103, 'Yazd', NULL, NULL);
INSERT INTO `state` VALUES (1728, 103, 'Zanjan', NULL, NULL);
INSERT INTO `state` VALUES (1729, 104, 'Babil', NULL, NULL);
INSERT INTO `state` VALUES (1730, 104, 'Baghdad', NULL, NULL);
INSERT INTO `state` VALUES (1731, 104, 'Dahuk', NULL, NULL);
INSERT INTO `state` VALUES (1732, 104, 'Dhi Qar', NULL, NULL);
INSERT INTO `state` VALUES (1733, 104, 'Diyala', NULL, NULL);
INSERT INTO `state` VALUES (1734, 104, 'Erbil', NULL, NULL);
INSERT INTO `state` VALUES (1735, 104, 'Irbil', NULL, NULL);
INSERT INTO `state` VALUES (1736, 104, 'Karbala', NULL, NULL);
INSERT INTO `state` VALUES (1737, 104, 'Kurdistan', NULL, NULL);
INSERT INTO `state` VALUES (1738, 104, 'Maysan', NULL, NULL);
INSERT INTO `state` VALUES (1739, 104, 'Ninawa', NULL, NULL);
INSERT INTO `state` VALUES (1740, 104, 'Salah-ad-Din', NULL, NULL);
INSERT INTO `state` VALUES (1741, 104, 'Wasit', NULL, NULL);
INSERT INTO `state` VALUES (1742, 104, 'al-Anbar', NULL, NULL);
INSERT INTO `state` VALUES (1743, 104, 'al-Basrah', NULL, NULL);
INSERT INTO `state` VALUES (1744, 104, 'al-Muthanna', NULL, NULL);
INSERT INTO `state` VALUES (1745, 104, 'al-Qadisiyah', NULL, NULL);
INSERT INTO `state` VALUES (1746, 104, 'an-Najaf', NULL, NULL);
INSERT INTO `state` VALUES (1747, 104, 'as-Sulaymaniyah', NULL, NULL);
INSERT INTO `state` VALUES (1748, 104, 'at-Ta\'mim', NULL, NULL);
INSERT INTO `state` VALUES (1749, 105, 'Armagh', NULL, NULL);
INSERT INTO `state` VALUES (1750, 105, 'Carlow', NULL, NULL);
INSERT INTO `state` VALUES (1751, 105, 'Cavan', NULL, NULL);
INSERT INTO `state` VALUES (1752, 105, 'Clare', NULL, NULL);
INSERT INTO `state` VALUES (1753, 105, 'Cork', NULL, NULL);
INSERT INTO `state` VALUES (1754, 105, 'Donegal', NULL, NULL);
INSERT INTO `state` VALUES (1755, 105, 'Dublin', NULL, NULL);
INSERT INTO `state` VALUES (1756, 105, 'Galway', NULL, NULL);
INSERT INTO `state` VALUES (1757, 105, 'Kerry', NULL, NULL);
INSERT INTO `state` VALUES (1758, 105, 'Kildare', NULL, NULL);
INSERT INTO `state` VALUES (1759, 105, 'Kilkenny', NULL, NULL);
INSERT INTO `state` VALUES (1760, 105, 'Laois', NULL, NULL);
INSERT INTO `state` VALUES (1761, 105, 'Leinster', NULL, NULL);
INSERT INTO `state` VALUES (1762, 105, 'Leitrim', NULL, NULL);
INSERT INTO `state` VALUES (1763, 105, 'Limerick', NULL, NULL);
INSERT INTO `state` VALUES (1764, 105, 'Loch Garman', NULL, NULL);
INSERT INTO `state` VALUES (1765, 105, 'Longford', NULL, NULL);
INSERT INTO `state` VALUES (1766, 105, 'Louth', NULL, NULL);
INSERT INTO `state` VALUES (1767, 105, 'Mayo', NULL, NULL);
INSERT INTO `state` VALUES (1768, 105, 'Meath', NULL, NULL);
INSERT INTO `state` VALUES (1769, 105, 'Monaghan', NULL, NULL);
INSERT INTO `state` VALUES (1770, 105, 'Offaly', NULL, NULL);
INSERT INTO `state` VALUES (1771, 105, 'Roscommon', NULL, NULL);
INSERT INTO `state` VALUES (1772, 105, 'Sligo', NULL, NULL);
INSERT INTO `state` VALUES (1773, 105, 'Tipperary North Riding', NULL, NULL);
INSERT INTO `state` VALUES (1774, 105, 'Tipperary South Riding', NULL, NULL);
INSERT INTO `state` VALUES (1775, 105, 'Ulster', NULL, NULL);
INSERT INTO `state` VALUES (1776, 105, 'Waterford', NULL, NULL);
INSERT INTO `state` VALUES (1777, 105, 'Westmeath', NULL, NULL);
INSERT INTO `state` VALUES (1778, 105, 'Wexford', NULL, NULL);
INSERT INTO `state` VALUES (1779, 105, 'Wicklow', NULL, NULL);
INSERT INTO `state` VALUES (1780, 106, 'Beit Hanania', NULL, NULL);
INSERT INTO `state` VALUES (1781, 106, 'Ben Gurion Airport', NULL, NULL);
INSERT INTO `state` VALUES (1782, 106, 'Bethlehem', NULL, NULL);
INSERT INTO `state` VALUES (1783, 106, 'Caesarea', NULL, NULL);
INSERT INTO `state` VALUES (1784, 106, 'Centre', NULL, NULL);
INSERT INTO `state` VALUES (1785, 106, 'Gaza', NULL, NULL);
INSERT INTO `state` VALUES (1786, 106, 'Hadaron', NULL, NULL);
INSERT INTO `state` VALUES (1787, 106, 'Haifa District', NULL, NULL);
INSERT INTO `state` VALUES (1788, 106, 'Hamerkaz', NULL, NULL);
INSERT INTO `state` VALUES (1789, 106, 'Hazafon', NULL, NULL);
INSERT INTO `state` VALUES (1790, 106, 'Hebron', NULL, NULL);
INSERT INTO `state` VALUES (1791, 106, 'Jaffa', NULL, NULL);
INSERT INTO `state` VALUES (1792, 106, 'Jerusalem', NULL, NULL);
INSERT INTO `state` VALUES (1793, 106, 'Khefa', NULL, NULL);
INSERT INTO `state` VALUES (1794, 106, 'Kiryat Yam', NULL, NULL);
INSERT INTO `state` VALUES (1795, 106, 'Lower Galilee', NULL, NULL);
INSERT INTO `state` VALUES (1796, 106, 'Qalqilya', NULL, NULL);
INSERT INTO `state` VALUES (1797, 106, 'Talme Elazar', NULL, NULL);
INSERT INTO `state` VALUES (1798, 106, 'Tel Aviv', NULL, NULL);
INSERT INTO `state` VALUES (1799, 106, 'Tsafon', NULL, NULL);
INSERT INTO `state` VALUES (1800, 106, 'Umm El Fahem', NULL, NULL);
INSERT INTO `state` VALUES (1801, 106, 'Yerushalayim', NULL, NULL);
INSERT INTO `state` VALUES (1802, 107, 'Abruzzi', NULL, NULL);
INSERT INTO `state` VALUES (1803, 107, 'Abruzzo', NULL, NULL);
INSERT INTO `state` VALUES (1804, 107, 'Agrigento', NULL, NULL);
INSERT INTO `state` VALUES (1805, 107, 'Alessandria', NULL, NULL);
INSERT INTO `state` VALUES (1806, 107, 'Ancona', NULL, NULL);
INSERT INTO `state` VALUES (1807, 107, 'Arezzo', NULL, NULL);
INSERT INTO `state` VALUES (1808, 107, 'Ascoli Piceno', NULL, NULL);
INSERT INTO `state` VALUES (1809, 107, 'Asti', NULL, NULL);
INSERT INTO `state` VALUES (1810, 107, 'Avellino', NULL, NULL);
INSERT INTO `state` VALUES (1811, 107, 'Bari', NULL, NULL);
INSERT INTO `state` VALUES (1812, 107, 'Basilicata', NULL, NULL);
INSERT INTO `state` VALUES (1813, 107, 'Belluno', NULL, NULL);
INSERT INTO `state` VALUES (1814, 107, 'Benevento', NULL, NULL);
INSERT INTO `state` VALUES (1815, 107, 'Bergamo', NULL, NULL);
INSERT INTO `state` VALUES (1816, 107, 'Biella', NULL, NULL);
INSERT INTO `state` VALUES (1817, 107, 'Bologna', NULL, NULL);
INSERT INTO `state` VALUES (1818, 107, 'Bolzano', NULL, NULL);
INSERT INTO `state` VALUES (1819, 107, 'Brescia', NULL, NULL);
INSERT INTO `state` VALUES (1820, 107, 'Brindisi', NULL, NULL);
INSERT INTO `state` VALUES (1821, 107, 'Calabria', NULL, NULL);
INSERT INTO `state` VALUES (1822, 107, 'Campania', NULL, NULL);
INSERT INTO `state` VALUES (1823, 107, 'Cartoceto', NULL, NULL);
INSERT INTO `state` VALUES (1824, 107, 'Caserta', NULL, NULL);
INSERT INTO `state` VALUES (1825, 107, 'Catania', NULL, NULL);
INSERT INTO `state` VALUES (1826, 107, 'Chieti', NULL, NULL);
INSERT INTO `state` VALUES (1827, 107, 'Como', NULL, NULL);
INSERT INTO `state` VALUES (1828, 107, 'Cosenza', NULL, NULL);
INSERT INTO `state` VALUES (1829, 107, 'Cremona', NULL, NULL);
INSERT INTO `state` VALUES (1830, 107, 'Cuneo', NULL, NULL);
INSERT INTO `state` VALUES (1831, 107, 'Emilia-Romagna', NULL, NULL);
INSERT INTO `state` VALUES (1832, 107, 'Ferrara', NULL, NULL);
INSERT INTO `state` VALUES (1833, 107, 'Firenze', NULL, NULL);
INSERT INTO `state` VALUES (1834, 107, 'Florence', NULL, NULL);
INSERT INTO `state` VALUES (1835, 107, 'Forli-Cesena ', NULL, NULL);
INSERT INTO `state` VALUES (1836, 107, 'Friuli-Venezia Giulia', NULL, NULL);
INSERT INTO `state` VALUES (1837, 107, 'Frosinone', NULL, NULL);
INSERT INTO `state` VALUES (1838, 107, 'Genoa', NULL, NULL);
INSERT INTO `state` VALUES (1839, 107, 'Gorizia', NULL, NULL);
INSERT INTO `state` VALUES (1840, 107, 'L\'Aquila', NULL, NULL);
INSERT INTO `state` VALUES (1841, 107, 'Lazio', NULL, NULL);
INSERT INTO `state` VALUES (1842, 107, 'Lecce', NULL, NULL);
INSERT INTO `state` VALUES (1843, 107, 'Lecco', NULL, NULL);
INSERT INTO `state` VALUES (1844, 107, 'Lecco Province', NULL, NULL);
INSERT INTO `state` VALUES (1845, 107, 'Liguria', NULL, NULL);
INSERT INTO `state` VALUES (1846, 107, 'Lodi', NULL, NULL);
INSERT INTO `state` VALUES (1847, 107, 'Lombardia', NULL, NULL);
INSERT INTO `state` VALUES (1848, 107, 'Lombardy', NULL, NULL);
INSERT INTO `state` VALUES (1849, 107, 'Macerata', NULL, NULL);
INSERT INTO `state` VALUES (1850, 107, 'Mantova', NULL, NULL);
INSERT INTO `state` VALUES (1851, 107, 'Marche', NULL, NULL);
INSERT INTO `state` VALUES (1852, 107, 'Messina', NULL, NULL);
INSERT INTO `state` VALUES (1853, 107, 'Milan', NULL, NULL);
INSERT INTO `state` VALUES (1854, 107, 'Modena', NULL, NULL);
INSERT INTO `state` VALUES (1855, 107, 'Molise', NULL, NULL);
INSERT INTO `state` VALUES (1856, 107, 'Molteno', NULL, NULL);
INSERT INTO `state` VALUES (1857, 107, 'Montenegro', NULL, NULL);
INSERT INTO `state` VALUES (1858, 107, 'Monza and Brianza', NULL, NULL);
INSERT INTO `state` VALUES (1859, 107, 'Naples', NULL, NULL);
INSERT INTO `state` VALUES (1860, 107, 'Novara', NULL, NULL);
INSERT INTO `state` VALUES (1861, 107, 'Padova', NULL, NULL);
INSERT INTO `state` VALUES (1862, 107, 'Parma', NULL, NULL);
INSERT INTO `state` VALUES (1863, 107, 'Pavia', NULL, NULL);
INSERT INTO `state` VALUES (1864, 107, 'Perugia', NULL, NULL);
INSERT INTO `state` VALUES (1865, 107, 'Pesaro-Urbino', NULL, NULL);
INSERT INTO `state` VALUES (1866, 107, 'Piacenza', NULL, NULL);
INSERT INTO `state` VALUES (1867, 107, 'Piedmont', NULL, NULL);
INSERT INTO `state` VALUES (1868, 107, 'Piemonte', NULL, NULL);
INSERT INTO `state` VALUES (1869, 107, 'Pisa', NULL, NULL);
INSERT INTO `state` VALUES (1870, 107, 'Pordenone', NULL, NULL);
INSERT INTO `state` VALUES (1871, 107, 'Potenza', NULL, NULL);
INSERT INTO `state` VALUES (1872, 107, 'Puglia', NULL, NULL);
INSERT INTO `state` VALUES (1873, 107, 'Reggio Emilia', NULL, NULL);
INSERT INTO `state` VALUES (1874, 107, 'Rimini', NULL, NULL);
INSERT INTO `state` VALUES (1875, 107, 'Roma', NULL, NULL);
INSERT INTO `state` VALUES (1876, 107, 'Salerno', NULL, NULL);
INSERT INTO `state` VALUES (1877, 107, 'Sardegna', NULL, NULL);
INSERT INTO `state` VALUES (1878, 107, 'Sassari', NULL, NULL);
INSERT INTO `state` VALUES (1879, 107, 'Savona', NULL, NULL);
INSERT INTO `state` VALUES (1880, 107, 'Sicilia', NULL, NULL);
INSERT INTO `state` VALUES (1881, 107, 'Siena', NULL, NULL);
INSERT INTO `state` VALUES (1882, 107, 'Sondrio', NULL, NULL);
INSERT INTO `state` VALUES (1883, 107, 'South Tyrol', NULL, NULL);
INSERT INTO `state` VALUES (1884, 107, 'Taranto', NULL, NULL);
INSERT INTO `state` VALUES (1885, 107, 'Teramo', NULL, NULL);
INSERT INTO `state` VALUES (1886, 107, 'Torino', NULL, NULL);
INSERT INTO `state` VALUES (1887, 107, 'Toscana', NULL, NULL);
INSERT INTO `state` VALUES (1888, 107, 'Trapani', NULL, NULL);
INSERT INTO `state` VALUES (1889, 107, 'Trentino-Alto Adige', NULL, NULL);
INSERT INTO `state` VALUES (1890, 107, 'Trento', NULL, NULL);
INSERT INTO `state` VALUES (1891, 107, 'Treviso', NULL, NULL);
INSERT INTO `state` VALUES (1892, 107, 'Udine', NULL, NULL);
INSERT INTO `state` VALUES (1893, 107, 'Umbria', NULL, NULL);
INSERT INTO `state` VALUES (1894, 107, 'Valle d\'Aosta', NULL, NULL);
INSERT INTO `state` VALUES (1895, 107, 'Varese', NULL, NULL);
INSERT INTO `state` VALUES (1896, 107, 'Veneto', NULL, NULL);
INSERT INTO `state` VALUES (1897, 107, 'Venezia', NULL, NULL);
INSERT INTO `state` VALUES (1898, 107, 'Verbano-Cusio-Ossola', NULL, NULL);
INSERT INTO `state` VALUES (1899, 107, 'Vercelli', NULL, NULL);
INSERT INTO `state` VALUES (1900, 107, 'Verona', NULL, NULL);
INSERT INTO `state` VALUES (1901, 107, 'Vicenza', NULL, NULL);
INSERT INTO `state` VALUES (1902, 107, 'Viterbo', NULL, NULL);
INSERT INTO `state` VALUES (1903, 108, 'Buxoro Viloyati', NULL, NULL);
INSERT INTO `state` VALUES (1904, 108, 'Clarendon', NULL, NULL);
INSERT INTO `state` VALUES (1905, 108, 'Hanover', NULL, NULL);
INSERT INTO `state` VALUES (1906, 108, 'Kingston', NULL, NULL);
INSERT INTO `state` VALUES (1907, 108, 'Manchester', NULL, NULL);
INSERT INTO `state` VALUES (1908, 108, 'Portland', NULL, NULL);
INSERT INTO `state` VALUES (1909, 108, 'Saint Andrews', NULL, NULL);
INSERT INTO `state` VALUES (1910, 108, 'Saint Ann', NULL, NULL);
INSERT INTO `state` VALUES (1911, 108, 'Saint Catherine', NULL, NULL);
INSERT INTO `state` VALUES (1912, 108, 'Saint Elizabeth', NULL, NULL);
INSERT INTO `state` VALUES (1913, 108, 'Saint James', NULL, NULL);
INSERT INTO `state` VALUES (1914, 108, 'Saint Mary', NULL, NULL);
INSERT INTO `state` VALUES (1915, 108, 'Saint Thomas', NULL, NULL);
INSERT INTO `state` VALUES (1916, 108, 'Trelawney', NULL, NULL);
INSERT INTO `state` VALUES (1917, 108, 'Westmoreland', NULL, NULL);
INSERT INTO `state` VALUES (1918, 109, 'Aichi', NULL, NULL);
INSERT INTO `state` VALUES (1919, 109, 'Akita', NULL, NULL);
INSERT INTO `state` VALUES (1920, 109, 'Aomori', NULL, NULL);
INSERT INTO `state` VALUES (1921, 109, 'Chiba', NULL, NULL);
INSERT INTO `state` VALUES (1922, 109, 'Ehime', NULL, NULL);
INSERT INTO `state` VALUES (1923, 109, 'Fukui', NULL, NULL);
INSERT INTO `state` VALUES (1924, 109, 'Fukuoka', NULL, NULL);
INSERT INTO `state` VALUES (1925, 109, 'Fukushima', NULL, NULL);
INSERT INTO `state` VALUES (1926, 109, 'Gifu', NULL, NULL);
INSERT INTO `state` VALUES (1927, 109, 'Gumma', NULL, NULL);
INSERT INTO `state` VALUES (1928, 109, 'Hiroshima', NULL, NULL);
INSERT INTO `state` VALUES (1929, 109, 'Hokkaido', NULL, NULL);
INSERT INTO `state` VALUES (1930, 109, 'Hyogo', NULL, NULL);
INSERT INTO `state` VALUES (1931, 109, 'Ibaraki', NULL, NULL);
INSERT INTO `state` VALUES (1932, 109, 'Ishikawa', NULL, NULL);
INSERT INTO `state` VALUES (1933, 109, 'Iwate', NULL, NULL);
INSERT INTO `state` VALUES (1934, 109, 'Kagawa', NULL, NULL);
INSERT INTO `state` VALUES (1935, 109, 'Kagoshima', NULL, NULL);
INSERT INTO `state` VALUES (1936, 109, 'Kanagawa', NULL, NULL);
INSERT INTO `state` VALUES (1937, 109, 'Kanto', NULL, NULL);
INSERT INTO `state` VALUES (1938, 109, 'Kochi', NULL, NULL);
INSERT INTO `state` VALUES (1939, 109, 'Kumamoto', NULL, NULL);
INSERT INTO `state` VALUES (1940, 109, 'Kyoto', NULL, NULL);
INSERT INTO `state` VALUES (1941, 109, 'Mie', NULL, NULL);
INSERT INTO `state` VALUES (1942, 109, 'Miyagi', NULL, NULL);
INSERT INTO `state` VALUES (1943, 109, 'Miyazaki', NULL, NULL);
INSERT INTO `state` VALUES (1944, 109, 'Nagano', NULL, NULL);
INSERT INTO `state` VALUES (1945, 109, 'Nagasaki', NULL, NULL);
INSERT INTO `state` VALUES (1946, 109, 'Nara', NULL, NULL);
INSERT INTO `state` VALUES (1947, 109, 'Niigata', NULL, NULL);
INSERT INTO `state` VALUES (1948, 109, 'Oita', NULL, NULL);
INSERT INTO `state` VALUES (1949, 109, 'Okayama', NULL, NULL);
INSERT INTO `state` VALUES (1950, 109, 'Okinawa', NULL, NULL);
INSERT INTO `state` VALUES (1951, 109, 'Osaka', NULL, NULL);
INSERT INTO `state` VALUES (1952, 109, 'Saga', NULL, NULL);
INSERT INTO `state` VALUES (1953, 109, 'Saitama', NULL, NULL);
INSERT INTO `state` VALUES (1954, 109, 'Shiga', NULL, NULL);
INSERT INTO `state` VALUES (1955, 109, 'Shimane', NULL, NULL);
INSERT INTO `state` VALUES (1956, 109, 'Shizuoka', NULL, NULL);
INSERT INTO `state` VALUES (1957, 109, 'Tochigi', NULL, NULL);
INSERT INTO `state` VALUES (1958, 109, 'Tokushima', NULL, NULL);
INSERT INTO `state` VALUES (1959, 109, 'Tokyo', NULL, NULL);
INSERT INTO `state` VALUES (1960, 109, 'Tottori', NULL, NULL);
INSERT INTO `state` VALUES (1961, 109, 'Toyama', NULL, NULL);
INSERT INTO `state` VALUES (1962, 109, 'Wakayama', NULL, NULL);
INSERT INTO `state` VALUES (1963, 109, 'Yamagata', NULL, NULL);
INSERT INTO `state` VALUES (1964, 109, 'Yamaguchi', NULL, NULL);
INSERT INTO `state` VALUES (1965, 109, 'Yamanashi', NULL, NULL);
INSERT INTO `state` VALUES (1966, 110, 'Grouville', NULL, NULL);
INSERT INTO `state` VALUES (1967, 110, 'Saint Brelade', NULL, NULL);
INSERT INTO `state` VALUES (1968, 110, 'Saint Clement', NULL, NULL);
INSERT INTO `state` VALUES (1969, 110, 'Saint Helier', NULL, NULL);
INSERT INTO `state` VALUES (1970, 110, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (1971, 110, 'Saint Lawrence', NULL, NULL);
INSERT INTO `state` VALUES (1972, 110, 'Saint Martin', NULL, NULL);
INSERT INTO `state` VALUES (1973, 110, 'Saint Mary', NULL, NULL);
INSERT INTO `state` VALUES (1974, 110, 'Saint Peter', NULL, NULL);
INSERT INTO `state` VALUES (1975, 110, 'Saint Saviour', NULL, NULL);
INSERT INTO `state` VALUES (1976, 110, 'Trinity', NULL, NULL);
INSERT INTO `state` VALUES (1977, 111, '\'Ajlun', NULL, NULL);
INSERT INTO `state` VALUES (1978, 111, 'Amman', NULL, NULL);
INSERT INTO `state` VALUES (1979, 111, 'Irbid', NULL, NULL);
INSERT INTO `state` VALUES (1980, 111, 'Jarash', NULL, NULL);
INSERT INTO `state` VALUES (1981, 111, 'Ma\'an', NULL, NULL);
INSERT INTO `state` VALUES (1982, 111, 'Madaba', NULL, NULL);
INSERT INTO `state` VALUES (1983, 111, 'al-\'Aqabah', NULL, NULL);
INSERT INTO `state` VALUES (1984, 111, 'al-Balqa\'', NULL, NULL);
INSERT INTO `state` VALUES (1985, 111, 'al-Karak', NULL, NULL);
INSERT INTO `state` VALUES (1986, 111, 'al-Mafraq', NULL, NULL);
INSERT INTO `state` VALUES (1987, 111, 'at-Tafilah', NULL, NULL);
INSERT INTO `state` VALUES (1988, 111, 'az-Zarqa\'', NULL, NULL);
INSERT INTO `state` VALUES (1989, 112, 'Akmecet', NULL, NULL);
INSERT INTO `state` VALUES (1990, 112, 'Akmola', NULL, NULL);
INSERT INTO `state` VALUES (1991, 112, 'Aktobe', NULL, NULL);
INSERT INTO `state` VALUES (1992, 112, 'Almati', NULL, NULL);
INSERT INTO `state` VALUES (1993, 112, 'Atirau', NULL, NULL);
INSERT INTO `state` VALUES (1994, 112, 'Batis Kazakstan', NULL, NULL);
INSERT INTO `state` VALUES (1995, 112, 'Burlinsky Region', NULL, NULL);
INSERT INTO `state` VALUES (1996, 112, 'Karagandi', NULL, NULL);
INSERT INTO `state` VALUES (1997, 112, 'Kostanay', NULL, NULL);
INSERT INTO `state` VALUES (1998, 112, 'Mankistau', NULL, NULL);
INSERT INTO `state` VALUES (1999, 112, 'Ontustik Kazakstan', NULL, NULL);
INSERT INTO `state` VALUES (2000, 112, 'Pavlodar', NULL, NULL);
INSERT INTO `state` VALUES (2001, 112, 'Sigis Kazakstan', NULL, NULL);
INSERT INTO `state` VALUES (2002, 112, 'Soltustik Kazakstan', NULL, NULL);
INSERT INTO `state` VALUES (2003, 112, 'Taraz', NULL, NULL);
INSERT INTO `state` VALUES (2004, 113, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (2005, 113, 'Coast', NULL, NULL);
INSERT INTO `state` VALUES (2006, 113, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (2007, 113, 'Nairobi', NULL, NULL);
INSERT INTO `state` VALUES (2008, 113, 'North Eastern', NULL, NULL);
INSERT INTO `state` VALUES (2009, 113, 'Nyanza', NULL, NULL);
INSERT INTO `state` VALUES (2010, 113, 'Rift Valley', NULL, NULL);
INSERT INTO `state` VALUES (2011, 113, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (2012, 114, 'Abaiang', NULL, NULL);
INSERT INTO `state` VALUES (2013, 114, 'Abemana', NULL, NULL);
INSERT INTO `state` VALUES (2014, 114, 'Aranuka', NULL, NULL);
INSERT INTO `state` VALUES (2015, 114, 'Arorae', NULL, NULL);
INSERT INTO `state` VALUES (2016, 114, 'Banaba', NULL, NULL);
INSERT INTO `state` VALUES (2017, 114, 'Beru', NULL, NULL);
INSERT INTO `state` VALUES (2018, 114, 'Butaritari', NULL, NULL);
INSERT INTO `state` VALUES (2019, 114, 'Kiritimati', NULL, NULL);
INSERT INTO `state` VALUES (2020, 114, 'Kuria', NULL, NULL);
INSERT INTO `state` VALUES (2021, 114, 'Maiana', NULL, NULL);
INSERT INTO `state` VALUES (2022, 114, 'Makin', NULL, NULL);
INSERT INTO `state` VALUES (2023, 114, 'Marakei', NULL, NULL);
INSERT INTO `state` VALUES (2024, 114, 'Nikunau', NULL, NULL);
INSERT INTO `state` VALUES (2025, 114, 'Nonouti', NULL, NULL);
INSERT INTO `state` VALUES (2026, 114, 'Onotoa', NULL, NULL);
INSERT INTO `state` VALUES (2027, 114, 'Phoenix Islands', NULL, NULL);
INSERT INTO `state` VALUES (2028, 114, 'Tabiteuea North', NULL, NULL);
INSERT INTO `state` VALUES (2029, 114, 'Tabiteuea South', NULL, NULL);
INSERT INTO `state` VALUES (2030, 114, 'Tabuaeran', NULL, NULL);
INSERT INTO `state` VALUES (2031, 114, 'Tamana', NULL, NULL);
INSERT INTO `state` VALUES (2032, 114, 'Tarawa North', NULL, NULL);
INSERT INTO `state` VALUES (2033, 114, 'Tarawa South', NULL, NULL);
INSERT INTO `state` VALUES (2034, 114, 'Teraina', NULL, NULL);
INSERT INTO `state` VALUES (2035, 115, 'Chagangdo', NULL, NULL);
INSERT INTO `state` VALUES (2036, 115, 'Hamgyeongbukto', NULL, NULL);
INSERT INTO `state` VALUES (2037, 115, 'Hamgyeongnamdo', NULL, NULL);
INSERT INTO `state` VALUES (2038, 115, 'Hwanghaebukto', NULL, NULL);
INSERT INTO `state` VALUES (2039, 115, 'Hwanghaenamdo', NULL, NULL);
INSERT INTO `state` VALUES (2040, 115, 'Kaeseong', NULL, NULL);
INSERT INTO `state` VALUES (2041, 115, 'Kangweon', NULL, NULL);
INSERT INTO `state` VALUES (2042, 115, 'Nampo', NULL, NULL);
INSERT INTO `state` VALUES (2043, 115, 'Pyeonganbukto', NULL, NULL);
INSERT INTO `state` VALUES (2044, 115, 'Pyeongannamdo', NULL, NULL);
INSERT INTO `state` VALUES (2045, 115, 'Pyeongyang', NULL, NULL);
INSERT INTO `state` VALUES (2046, 115, 'Yanggang', NULL, NULL);
INSERT INTO `state` VALUES (2047, 116, 'Busan', NULL, NULL);
INSERT INTO `state` VALUES (2048, 116, 'Cheju', NULL, NULL);
INSERT INTO `state` VALUES (2049, 116, 'Chollabuk', NULL, NULL);
INSERT INTO `state` VALUES (2050, 116, 'Chollanam', NULL, NULL);
INSERT INTO `state` VALUES (2051, 116, 'Chungbuk', NULL, NULL);
INSERT INTO `state` VALUES (2052, 116, 'Chungcheongbuk', NULL, NULL);
INSERT INTO `state` VALUES (2053, 116, 'Chungcheongnam', NULL, NULL);
INSERT INTO `state` VALUES (2054, 116, 'Chungnam', NULL, NULL);
INSERT INTO `state` VALUES (2055, 116, 'Daegu', NULL, NULL);
INSERT INTO `state` VALUES (2056, 116, 'Gangwon-do', NULL, NULL);
INSERT INTO `state` VALUES (2057, 116, 'Goyang-si', NULL, NULL);
INSERT INTO `state` VALUES (2058, 116, 'Gyeonggi-do', NULL, NULL);
INSERT INTO `state` VALUES (2059, 116, 'Gyeongsang ', NULL, NULL);
INSERT INTO `state` VALUES (2060, 116, 'Gyeongsangnam-do', NULL, NULL);
INSERT INTO `state` VALUES (2061, 116, 'Incheon', NULL, NULL);
INSERT INTO `state` VALUES (2062, 116, 'Jeju-Si', NULL, NULL);
INSERT INTO `state` VALUES (2063, 116, 'Jeonbuk', NULL, NULL);
INSERT INTO `state` VALUES (2064, 116, 'Kangweon', NULL, NULL);
INSERT INTO `state` VALUES (2065, 116, 'Kwangju', NULL, NULL);
INSERT INTO `state` VALUES (2066, 116, 'Kyeonggi', NULL, NULL);
INSERT INTO `state` VALUES (2067, 116, 'Kyeongsangbuk', NULL, NULL);
INSERT INTO `state` VALUES (2068, 116, 'Kyeongsangnam', NULL, NULL);
INSERT INTO `state` VALUES (2069, 116, 'Kyonggi-do', NULL, NULL);
INSERT INTO `state` VALUES (2070, 116, 'Kyungbuk-Do', NULL, NULL);
INSERT INTO `state` VALUES (2071, 116, 'Kyunggi-Do', NULL, NULL);
INSERT INTO `state` VALUES (2072, 116, 'Kyunggi-do', NULL, NULL);
INSERT INTO `state` VALUES (2073, 116, 'Pusan', NULL, NULL);
INSERT INTO `state` VALUES (2074, 116, 'Seoul', NULL, NULL);
INSERT INTO `state` VALUES (2075, 116, 'Sudogwon', NULL, NULL);
INSERT INTO `state` VALUES (2076, 116, 'Taegu', NULL, NULL);
INSERT INTO `state` VALUES (2077, 116, 'Taejeon', NULL, NULL);
INSERT INTO `state` VALUES (2078, 116, 'Taejon-gwangyoksi', NULL, NULL);
INSERT INTO `state` VALUES (2079, 116, 'Ulsan', NULL, NULL);
INSERT INTO `state` VALUES (2080, 116, 'Wonju', NULL, NULL);
INSERT INTO `state` VALUES (2081, 116, 'gwangyoksi', NULL, NULL);
INSERT INTO `state` VALUES (2082, 117, 'Al Asimah', NULL, NULL);
INSERT INTO `state` VALUES (2083, 117, 'Hawalli', NULL, NULL);
INSERT INTO `state` VALUES (2084, 117, 'Mishref', NULL, NULL);
INSERT INTO `state` VALUES (2085, 117, 'Qadesiya', NULL, NULL);
INSERT INTO `state` VALUES (2086, 117, 'Safat', NULL, NULL);
INSERT INTO `state` VALUES (2087, 117, 'Salmiya', NULL, NULL);
INSERT INTO `state` VALUES (2088, 117, 'al-Ahmadi', NULL, NULL);
INSERT INTO `state` VALUES (2089, 117, 'al-Farwaniyah', NULL, NULL);
INSERT INTO `state` VALUES (2090, 117, 'al-Jahra', NULL, NULL);
INSERT INTO `state` VALUES (2091, 117, 'al-Kuwayt', NULL, NULL);
INSERT INTO `state` VALUES (2092, 118, 'Batken', NULL, NULL);
INSERT INTO `state` VALUES (2093, 118, 'Bishkek', NULL, NULL);
INSERT INTO `state` VALUES (2094, 118, 'Chui', NULL, NULL);
INSERT INTO `state` VALUES (2095, 118, 'Issyk-Kul', NULL, NULL);
INSERT INTO `state` VALUES (2096, 118, 'Jalal-Abad', NULL, NULL);
INSERT INTO `state` VALUES (2097, 118, 'Naryn', NULL, NULL);
INSERT INTO `state` VALUES (2098, 118, 'Osh', NULL, NULL);
INSERT INTO `state` VALUES (2099, 118, 'Talas', NULL, NULL);
INSERT INTO `state` VALUES (2100, 119, 'Attopu', NULL, NULL);
INSERT INTO `state` VALUES (2101, 119, 'Bokeo', NULL, NULL);
INSERT INTO `state` VALUES (2102, 119, 'Bolikhamsay', NULL, NULL);
INSERT INTO `state` VALUES (2103, 119, 'Champasak', NULL, NULL);
INSERT INTO `state` VALUES (2104, 119, 'Houaphanh', NULL, NULL);
INSERT INTO `state` VALUES (2105, 119, 'Khammouane', NULL, NULL);
INSERT INTO `state` VALUES (2106, 119, 'Luang Nam Tha', NULL, NULL);
INSERT INTO `state` VALUES (2107, 119, 'Luang Prabang', NULL, NULL);
INSERT INTO `state` VALUES (2108, 119, 'Oudomxay', NULL, NULL);
INSERT INTO `state` VALUES (2109, 119, 'Phongsaly', NULL, NULL);
INSERT INTO `state` VALUES (2110, 119, 'Saravan', NULL, NULL);
INSERT INTO `state` VALUES (2111, 119, 'Savannakhet', NULL, NULL);
INSERT INTO `state` VALUES (2112, 119, 'Sekong', NULL, NULL);
INSERT INTO `state` VALUES (2113, 119, 'Viangchan Prefecture', NULL, NULL);
INSERT INTO `state` VALUES (2114, 119, 'Viangchan Province', NULL, NULL);
INSERT INTO `state` VALUES (2115, 119, 'Xaignabury', NULL, NULL);
INSERT INTO `state` VALUES (2116, 119, 'Xiang Khuang', NULL, NULL);
INSERT INTO `state` VALUES (2117, 120, 'Aizkraukles', NULL, NULL);
INSERT INTO `state` VALUES (2118, 120, 'Aluksnes', NULL, NULL);
INSERT INTO `state` VALUES (2119, 120, 'Balvu', NULL, NULL);
INSERT INTO `state` VALUES (2120, 120, 'Bauskas', NULL, NULL);
INSERT INTO `state` VALUES (2121, 120, 'Cesu', NULL, NULL);
INSERT INTO `state` VALUES (2122, 120, 'Daugavpils', NULL, NULL);
INSERT INTO `state` VALUES (2123, 120, 'Daugavpils City', NULL, NULL);
INSERT INTO `state` VALUES (2124, 120, 'Dobeles', NULL, NULL);
INSERT INTO `state` VALUES (2125, 120, 'Gulbenes', NULL, NULL);
INSERT INTO `state` VALUES (2126, 120, 'Jekabspils', NULL, NULL);
INSERT INTO `state` VALUES (2127, 120, 'Jelgava', NULL, NULL);
INSERT INTO `state` VALUES (2128, 120, 'Jelgavas', NULL, NULL);
INSERT INTO `state` VALUES (2129, 120, 'Jurmala City', NULL, NULL);
INSERT INTO `state` VALUES (2130, 120, 'Kraslavas', NULL, NULL);
INSERT INTO `state` VALUES (2131, 120, 'Kuldigas', NULL, NULL);
INSERT INTO `state` VALUES (2132, 120, 'Liepaja', NULL, NULL);
INSERT INTO `state` VALUES (2133, 120, 'Liepajas', NULL, NULL);
INSERT INTO `state` VALUES (2134, 120, 'Limbazhu', NULL, NULL);
INSERT INTO `state` VALUES (2135, 120, 'Ludzas', NULL, NULL);
INSERT INTO `state` VALUES (2136, 120, 'Madonas', NULL, NULL);
INSERT INTO `state` VALUES (2137, 120, 'Ogres', NULL, NULL);
INSERT INTO `state` VALUES (2138, 120, 'Preilu', NULL, NULL);
INSERT INTO `state` VALUES (2139, 120, 'Rezekne', NULL, NULL);
INSERT INTO `state` VALUES (2140, 120, 'Rezeknes', NULL, NULL);
INSERT INTO `state` VALUES (2141, 120, 'Riga', NULL, NULL);
INSERT INTO `state` VALUES (2142, 120, 'Rigas', NULL, NULL);
INSERT INTO `state` VALUES (2143, 120, 'Saldus', NULL, NULL);
INSERT INTO `state` VALUES (2144, 120, 'Talsu', NULL, NULL);
INSERT INTO `state` VALUES (2145, 120, 'Tukuma', NULL, NULL);
INSERT INTO `state` VALUES (2146, 120, 'Valkas', NULL, NULL);
INSERT INTO `state` VALUES (2147, 120, 'Valmieras', NULL, NULL);
INSERT INTO `state` VALUES (2148, 120, 'Ventspils', NULL, NULL);
INSERT INTO `state` VALUES (2149, 120, 'Ventspils City', NULL, NULL);
INSERT INTO `state` VALUES (2150, 121, 'Beirut', NULL, NULL);
INSERT INTO `state` VALUES (2151, 121, 'Jabal Lubnan', NULL, NULL);
INSERT INTO `state` VALUES (2152, 121, 'Mohafazat Liban-Nord', NULL, NULL);
INSERT INTO `state` VALUES (2153, 121, 'Mohafazat Mont-Liban', NULL, NULL);
INSERT INTO `state` VALUES (2154, 121, 'Sidon', NULL, NULL);
INSERT INTO `state` VALUES (2155, 121, 'al-Biqa', NULL, NULL);
INSERT INTO `state` VALUES (2156, 121, 'al-Janub', NULL, NULL);
INSERT INTO `state` VALUES (2157, 121, 'an-Nabatiyah', NULL, NULL);
INSERT INTO `state` VALUES (2158, 121, 'ash-Shamal', NULL, NULL);
INSERT INTO `state` VALUES (2159, 122, 'Berea', NULL, NULL);
INSERT INTO `state` VALUES (2160, 122, 'Butha-Buthe', NULL, NULL);
INSERT INTO `state` VALUES (2161, 122, 'Leribe', NULL, NULL);
INSERT INTO `state` VALUES (2162, 122, 'Mafeteng', NULL, NULL);
INSERT INTO `state` VALUES (2163, 122, 'Maseru', NULL, NULL);
INSERT INTO `state` VALUES (2164, 122, 'Mohale\'s Hoek', NULL, NULL);
INSERT INTO `state` VALUES (2165, 122, 'Mokhotlong', NULL, NULL);
INSERT INTO `state` VALUES (2166, 122, 'Qacha\'s Nek', NULL, NULL);
INSERT INTO `state` VALUES (2167, 122, 'Quthing', NULL, NULL);
INSERT INTO `state` VALUES (2168, 122, 'Thaba-Tseka', NULL, NULL);
INSERT INTO `state` VALUES (2169, 123, 'Bomi', NULL, NULL);
INSERT INTO `state` VALUES (2170, 123, 'Bong', NULL, NULL);
INSERT INTO `state` VALUES (2171, 123, 'Grand Bassa', NULL, NULL);
INSERT INTO `state` VALUES (2172, 123, 'Grand Cape Mount', NULL, NULL);
INSERT INTO `state` VALUES (2173, 123, 'Grand Gedeh', NULL, NULL);
INSERT INTO `state` VALUES (2174, 123, 'Loffa', NULL, NULL);
INSERT INTO `state` VALUES (2175, 123, 'Margibi', NULL, NULL);
INSERT INTO `state` VALUES (2176, 123, 'Maryland and Grand Kru', NULL, NULL);
INSERT INTO `state` VALUES (2177, 123, 'Montserrado', NULL, NULL);
INSERT INTO `state` VALUES (2178, 123, 'Nimba', NULL, NULL);
INSERT INTO `state` VALUES (2179, 123, 'Rivercess', NULL, NULL);
INSERT INTO `state` VALUES (2180, 123, 'Sinoe', NULL, NULL);
INSERT INTO `state` VALUES (2181, 124, 'Ajdabiya', NULL, NULL);
INSERT INTO `state` VALUES (2182, 124, 'Fezzan', NULL, NULL);
INSERT INTO `state` VALUES (2183, 124, 'Banghazi', NULL, NULL);
INSERT INTO `state` VALUES (2184, 124, 'Darnah', NULL, NULL);
INSERT INTO `state` VALUES (2185, 124, 'Ghadamis', NULL, NULL);
INSERT INTO `state` VALUES (2186, 124, 'Gharyan', NULL, NULL);
INSERT INTO `state` VALUES (2187, 124, 'Misratah', NULL, NULL);
INSERT INTO `state` VALUES (2188, 124, 'Murzuq', NULL, NULL);
INSERT INTO `state` VALUES (2189, 124, 'Sabha', NULL, NULL);
INSERT INTO `state` VALUES (2190, 124, 'Sawfajjin', NULL, NULL);
INSERT INTO `state` VALUES (2191, 124, 'Surt', NULL, NULL);
INSERT INTO `state` VALUES (2192, 124, 'Tarabulus', NULL, NULL);
INSERT INTO `state` VALUES (2193, 124, 'Tarhunah', NULL, NULL);
INSERT INTO `state` VALUES (2194, 124, 'Tripolitania', NULL, NULL);
INSERT INTO `state` VALUES (2195, 124, 'Tubruq', NULL, NULL);
INSERT INTO `state` VALUES (2196, 124, 'Yafran', NULL, NULL);
INSERT INTO `state` VALUES (2197, 124, 'Zlitan', NULL, NULL);
INSERT INTO `state` VALUES (2198, 124, 'al-\'Aziziyah', NULL, NULL);
INSERT INTO `state` VALUES (2199, 124, 'al-Fatih', NULL, NULL);
INSERT INTO `state` VALUES (2200, 124, 'al-Jabal al Akhdar', NULL, NULL);
INSERT INTO `state` VALUES (2201, 124, 'al-Jufrah', NULL, NULL);
INSERT INTO `state` VALUES (2202, 124, 'al-Khums', NULL, NULL);
INSERT INTO `state` VALUES (2203, 124, 'al-Kufrah', NULL, NULL);
INSERT INTO `state` VALUES (2204, 124, 'an-Nuqat al-Khams', NULL, NULL);
INSERT INTO `state` VALUES (2205, 124, 'ash-Shati\'', NULL, NULL);
INSERT INTO `state` VALUES (2206, 124, 'az-Zawiyah', NULL, NULL);
INSERT INTO `state` VALUES (2207, 125, 'Balzers', NULL, NULL);
INSERT INTO `state` VALUES (2208, 125, 'Eschen', NULL, NULL);
INSERT INTO `state` VALUES (2209, 125, 'Gamprin', NULL, NULL);
INSERT INTO `state` VALUES (2210, 125, 'Mauren', NULL, NULL);
INSERT INTO `state` VALUES (2211, 125, 'Planken', NULL, NULL);
INSERT INTO `state` VALUES (2212, 125, 'Ruggell', NULL, NULL);
INSERT INTO `state` VALUES (2213, 125, 'Schaan', NULL, NULL);
INSERT INTO `state` VALUES (2214, 125, 'Schellenberg', NULL, NULL);
INSERT INTO `state` VALUES (2215, 125, 'Triesen', NULL, NULL);
INSERT INTO `state` VALUES (2216, 125, 'Triesenberg', NULL, NULL);
INSERT INTO `state` VALUES (2217, 125, 'Vaduz', NULL, NULL);
INSERT INTO `state` VALUES (2218, 126, 'Alytaus', NULL, NULL);
INSERT INTO `state` VALUES (2219, 126, 'Anyksciai', NULL, NULL);
INSERT INTO `state` VALUES (2220, 126, 'Kauno', NULL, NULL);
INSERT INTO `state` VALUES (2221, 126, 'Klaipedos', NULL, NULL);
INSERT INTO `state` VALUES (2222, 126, 'Marijampoles', NULL, NULL);
INSERT INTO `state` VALUES (2223, 126, 'Panevezhio', NULL, NULL);
INSERT INTO `state` VALUES (2224, 126, 'Panevezys', NULL, NULL);
INSERT INTO `state` VALUES (2225, 126, 'Shiauliu', NULL, NULL);
INSERT INTO `state` VALUES (2226, 126, 'Taurages', NULL, NULL);
INSERT INTO `state` VALUES (2227, 126, 'Telshiu', NULL, NULL);
INSERT INTO `state` VALUES (2228, 126, 'Telsiai', NULL, NULL);
INSERT INTO `state` VALUES (2229, 126, 'Utenos', NULL, NULL);
INSERT INTO `state` VALUES (2230, 126, 'Vilniaus', NULL, NULL);
INSERT INTO `state` VALUES (2231, 127, 'Capellen', NULL, NULL);
INSERT INTO `state` VALUES (2232, 127, 'Clervaux', NULL, NULL);
INSERT INTO `state` VALUES (2233, 127, 'Diekirch', NULL, NULL);
INSERT INTO `state` VALUES (2234, 127, 'Echternach', NULL, NULL);
INSERT INTO `state` VALUES (2235, 127, 'Esch-sur-Alzette', NULL, NULL);
INSERT INTO `state` VALUES (2236, 127, 'Grevenmacher', NULL, NULL);
INSERT INTO `state` VALUES (2237, 127, 'Luxembourg', NULL, NULL);
INSERT INTO `state` VALUES (2238, 127, 'Mersch', NULL, NULL);
INSERT INTO `state` VALUES (2239, 127, 'Redange', NULL, NULL);
INSERT INTO `state` VALUES (2240, 127, 'Remich', NULL, NULL);
INSERT INTO `state` VALUES (2241, 127, 'Vianden', NULL, NULL);
INSERT INTO `state` VALUES (2242, 127, 'Wiltz', NULL, NULL);
INSERT INTO `state` VALUES (2243, 128, 'Macau', NULL, NULL);
INSERT INTO `state` VALUES (2244, 129, 'Berovo', NULL, NULL);
INSERT INTO `state` VALUES (2245, 129, 'Bitola', NULL, NULL);
INSERT INTO `state` VALUES (2246, 129, 'Brod', NULL, NULL);
INSERT INTO `state` VALUES (2247, 129, 'Debar', NULL, NULL);
INSERT INTO `state` VALUES (2248, 129, 'Delchevo', NULL, NULL);
INSERT INTO `state` VALUES (2249, 129, 'Demir Hisar', NULL, NULL);
INSERT INTO `state` VALUES (2250, 129, 'Gevgelija', NULL, NULL);
INSERT INTO `state` VALUES (2251, 129, 'Gostivar', NULL, NULL);
INSERT INTO `state` VALUES (2252, 129, 'Kavadarci', NULL, NULL);
INSERT INTO `state` VALUES (2253, 129, 'Kichevo', NULL, NULL);
INSERT INTO `state` VALUES (2254, 129, 'Kochani', NULL, NULL);
INSERT INTO `state` VALUES (2255, 129, 'Kratovo', NULL, NULL);
INSERT INTO `state` VALUES (2256, 129, 'Kriva Palanka', NULL, NULL);
INSERT INTO `state` VALUES (2257, 129, 'Krushevo', NULL, NULL);
INSERT INTO `state` VALUES (2258, 129, 'Kumanovo', NULL, NULL);
INSERT INTO `state` VALUES (2259, 129, 'Negotino', NULL, NULL);
INSERT INTO `state` VALUES (2260, 129, 'Ohrid', NULL, NULL);
INSERT INTO `state` VALUES (2261, 129, 'Prilep', NULL, NULL);
INSERT INTO `state` VALUES (2262, 129, 'Probishtip', NULL, NULL);
INSERT INTO `state` VALUES (2263, 129, 'Radovish', NULL, NULL);
INSERT INTO `state` VALUES (2264, 129, 'Resen', NULL, NULL);
INSERT INTO `state` VALUES (2265, 129, 'Shtip', NULL, NULL);
INSERT INTO `state` VALUES (2266, 129, 'Skopje', NULL, NULL);
INSERT INTO `state` VALUES (2267, 129, 'Struga', NULL, NULL);
INSERT INTO `state` VALUES (2268, 129, 'Strumica', NULL, NULL);
INSERT INTO `state` VALUES (2269, 129, 'Sveti Nikole', NULL, NULL);
INSERT INTO `state` VALUES (2270, 129, 'Tetovo', NULL, NULL);
INSERT INTO `state` VALUES (2271, 129, 'Valandovo', NULL, NULL);
INSERT INTO `state` VALUES (2272, 129, 'Veles', NULL, NULL);
INSERT INTO `state` VALUES (2273, 129, 'Vinica', NULL, NULL);
INSERT INTO `state` VALUES (2274, 130, 'Antananarivo', NULL, NULL);
INSERT INTO `state` VALUES (2275, 130, 'Antsiranana', NULL, NULL);
INSERT INTO `state` VALUES (2276, 130, 'Fianarantsoa', NULL, NULL);
INSERT INTO `state` VALUES (2277, 130, 'Mahajanga', NULL, NULL);
INSERT INTO `state` VALUES (2278, 130, 'Toamasina', NULL, NULL);
INSERT INTO `state` VALUES (2279, 130, 'Toliary', NULL, NULL);
INSERT INTO `state` VALUES (2280, 131, 'Balaka', NULL, NULL);
INSERT INTO `state` VALUES (2281, 131, 'Blantyre City', NULL, NULL);
INSERT INTO `state` VALUES (2282, 131, 'Chikwawa', NULL, NULL);
INSERT INTO `state` VALUES (2283, 131, 'Chiradzulu', NULL, NULL);
INSERT INTO `state` VALUES (2284, 131, 'Chitipa', NULL, NULL);
INSERT INTO `state` VALUES (2285, 131, 'Dedza', NULL, NULL);
INSERT INTO `state` VALUES (2286, 131, 'Dowa', NULL, NULL);
INSERT INTO `state` VALUES (2287, 131, 'Karonga', NULL, NULL);
INSERT INTO `state` VALUES (2288, 131, 'Kasungu', NULL, NULL);
INSERT INTO `state` VALUES (2289, 131, 'Lilongwe City', NULL, NULL);
INSERT INTO `state` VALUES (2290, 131, 'Machinga', NULL, NULL);
INSERT INTO `state` VALUES (2291, 131, 'Mangochi', NULL, NULL);
INSERT INTO `state` VALUES (2292, 131, 'Mchinji', NULL, NULL);
INSERT INTO `state` VALUES (2293, 131, 'Mulanje', NULL, NULL);
INSERT INTO `state` VALUES (2294, 131, 'Mwanza', NULL, NULL);
INSERT INTO `state` VALUES (2295, 131, 'Mzimba', NULL, NULL);
INSERT INTO `state` VALUES (2296, 131, 'Mzuzu City', NULL, NULL);
INSERT INTO `state` VALUES (2297, 131, 'Nkhata Bay', NULL, NULL);
INSERT INTO `state` VALUES (2298, 131, 'Nkhotakota', NULL, NULL);
INSERT INTO `state` VALUES (2299, 131, 'Nsanje', NULL, NULL);
INSERT INTO `state` VALUES (2300, 131, 'Ntcheu', NULL, NULL);
INSERT INTO `state` VALUES (2301, 131, 'Ntchisi', NULL, NULL);
INSERT INTO `state` VALUES (2302, 131, 'Phalombe', NULL, NULL);
INSERT INTO `state` VALUES (2303, 131, 'Rumphi', NULL, NULL);
INSERT INTO `state` VALUES (2304, 131, 'Salima', NULL, NULL);
INSERT INTO `state` VALUES (2305, 131, 'Thyolo', NULL, NULL);
INSERT INTO `state` VALUES (2306, 131, 'Zomba Municipality', NULL, NULL);
INSERT INTO `state` VALUES (2307, 132, 'Johor', NULL, NULL);
INSERT INTO `state` VALUES (2308, 132, 'Kedah', NULL, NULL);
INSERT INTO `state` VALUES (2309, 132, 'Kelantan', NULL, NULL);
INSERT INTO `state` VALUES (2310, 132, 'Kuala Lumpur', NULL, NULL);
INSERT INTO `state` VALUES (2311, 132, 'Labuan', NULL, NULL);
INSERT INTO `state` VALUES (2312, 132, 'Melaka', NULL, NULL);
INSERT INTO `state` VALUES (2313, 132, 'Negeri Johor', NULL, NULL);
INSERT INTO `state` VALUES (2314, 132, 'Negeri Sembilan', NULL, NULL);
INSERT INTO `state` VALUES (2315, 132, 'Pahang', NULL, NULL);
INSERT INTO `state` VALUES (2316, 132, 'Penang', NULL, NULL);
INSERT INTO `state` VALUES (2317, 132, 'Perak', NULL, NULL);
INSERT INTO `state` VALUES (2318, 132, 'Perlis', NULL, NULL);
INSERT INTO `state` VALUES (2319, 132, 'Pulau Pinang', NULL, NULL);
INSERT INTO `state` VALUES (2320, 132, 'Sabah', NULL, NULL);
INSERT INTO `state` VALUES (2321, 132, 'Sarawak', NULL, NULL);
INSERT INTO `state` VALUES (2322, 132, 'Selangor', NULL, NULL);
INSERT INTO `state` VALUES (2323, 132, 'Sembilan', NULL, NULL);
INSERT INTO `state` VALUES (2324, 132, 'Terengganu', NULL, NULL);
INSERT INTO `state` VALUES (2325, 133, 'Alif Alif', NULL, NULL);
INSERT INTO `state` VALUES (2326, 133, 'Alif Dhaal', NULL, NULL);
INSERT INTO `state` VALUES (2327, 133, 'Baa', NULL, NULL);
INSERT INTO `state` VALUES (2328, 133, 'Dhaal', NULL, NULL);
INSERT INTO `state` VALUES (2329, 133, 'Faaf', NULL, NULL);
INSERT INTO `state` VALUES (2330, 133, 'Gaaf Alif', NULL, NULL);
INSERT INTO `state` VALUES (2331, 133, 'Gaaf Dhaal', NULL, NULL);
INSERT INTO `state` VALUES (2332, 133, 'Ghaviyani', NULL, NULL);
INSERT INTO `state` VALUES (2333, 133, 'Haa Alif', NULL, NULL);
INSERT INTO `state` VALUES (2334, 133, 'Haa Dhaal', NULL, NULL);
INSERT INTO `state` VALUES (2335, 133, 'Kaaf', NULL, NULL);
INSERT INTO `state` VALUES (2336, 133, 'Laam', NULL, NULL);
INSERT INTO `state` VALUES (2337, 133, 'Lhaviyani', NULL, NULL);
INSERT INTO `state` VALUES (2338, 133, 'Male', NULL, NULL);
INSERT INTO `state` VALUES (2339, 133, 'Miim', NULL, NULL);
INSERT INTO `state` VALUES (2340, 133, 'Nuun', NULL, NULL);
INSERT INTO `state` VALUES (2341, 133, 'Raa', NULL, NULL);
INSERT INTO `state` VALUES (2342, 133, 'Shaviyani', NULL, NULL);
INSERT INTO `state` VALUES (2343, 133, 'Siin', NULL, NULL);
INSERT INTO `state` VALUES (2344, 133, 'Thaa', NULL, NULL);
INSERT INTO `state` VALUES (2345, 133, 'Vaav', NULL, NULL);
INSERT INTO `state` VALUES (2346, 134, 'Bamako', NULL, NULL);
INSERT INTO `state` VALUES (2347, 134, 'Gao', NULL, NULL);
INSERT INTO `state` VALUES (2348, 134, 'Kayes', NULL, NULL);
INSERT INTO `state` VALUES (2349, 134, 'Kidal', NULL, NULL);
INSERT INTO `state` VALUES (2350, 134, 'Koulikoro', NULL, NULL);
INSERT INTO `state` VALUES (2351, 134, 'Mopti', NULL, NULL);
INSERT INTO `state` VALUES (2352, 134, 'Segou', NULL, NULL);
INSERT INTO `state` VALUES (2353, 134, 'Sikasso', NULL, NULL);
INSERT INTO `state` VALUES (2354, 134, 'Tombouctou', NULL, NULL);
INSERT INTO `state` VALUES (2355, 135, 'Gozo and Comino', NULL, NULL);
INSERT INTO `state` VALUES (2356, 135, 'Inner Harbour', NULL, NULL);
INSERT INTO `state` VALUES (2357, 135, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (2358, 135, 'Outer Harbour', NULL, NULL);
INSERT INTO `state` VALUES (2359, 135, 'South Eastern', NULL, NULL);
INSERT INTO `state` VALUES (2360, 135, 'Valletta', NULL, NULL);
INSERT INTO `state` VALUES (2361, 135, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (2362, 136, 'Castletown', NULL, NULL);
INSERT INTO `state` VALUES (2363, 136, 'Douglas', NULL, NULL);
INSERT INTO `state` VALUES (2364, 136, 'Laxey', NULL, NULL);
INSERT INTO `state` VALUES (2365, 136, 'Onchan', NULL, NULL);
INSERT INTO `state` VALUES (2366, 136, 'Peel', NULL, NULL);
INSERT INTO `state` VALUES (2367, 136, 'Port Erin', NULL, NULL);
INSERT INTO `state` VALUES (2368, 136, 'Port Saint Mary', NULL, NULL);
INSERT INTO `state` VALUES (2369, 136, 'Ramsey', NULL, NULL);
INSERT INTO `state` VALUES (2370, 137, 'Ailinlaplap', NULL, NULL);
INSERT INTO `state` VALUES (2371, 137, 'Ailuk', NULL, NULL);
INSERT INTO `state` VALUES (2372, 137, 'Arno', NULL, NULL);
INSERT INTO `state` VALUES (2373, 137, 'Aur', NULL, NULL);
INSERT INTO `state` VALUES (2374, 137, 'Bikini', NULL, NULL);
INSERT INTO `state` VALUES (2375, 137, 'Ebon', NULL, NULL);
INSERT INTO `state` VALUES (2376, 137, 'Enewetak', NULL, NULL);
INSERT INTO `state` VALUES (2377, 137, 'Jabat', NULL, NULL);
INSERT INTO `state` VALUES (2378, 137, 'Jaluit', NULL, NULL);
INSERT INTO `state` VALUES (2379, 137, 'Kili', NULL, NULL);
INSERT INTO `state` VALUES (2380, 137, 'Kwajalein', NULL, NULL);
INSERT INTO `state` VALUES (2381, 137, 'Lae', NULL, NULL);
INSERT INTO `state` VALUES (2382, 137, 'Lib', NULL, NULL);
INSERT INTO `state` VALUES (2383, 137, 'Likiep', NULL, NULL);
INSERT INTO `state` VALUES (2384, 137, 'Majuro', NULL, NULL);
INSERT INTO `state` VALUES (2385, 137, 'Maloelap', NULL, NULL);
INSERT INTO `state` VALUES (2386, 137, 'Mejit', NULL, NULL);
INSERT INTO `state` VALUES (2387, 137, 'Mili', NULL, NULL);
INSERT INTO `state` VALUES (2388, 137, 'Namorik', NULL, NULL);
INSERT INTO `state` VALUES (2389, 137, 'Namu', NULL, NULL);
INSERT INTO `state` VALUES (2390, 137, 'Rongelap', NULL, NULL);
INSERT INTO `state` VALUES (2391, 137, 'Ujae', NULL, NULL);
INSERT INTO `state` VALUES (2392, 137, 'Utrik', NULL, NULL);
INSERT INTO `state` VALUES (2393, 137, 'Wotho', NULL, NULL);
INSERT INTO `state` VALUES (2394, 137, 'Wotje', NULL, NULL);
INSERT INTO `state` VALUES (2395, 138, 'Fort-de-France', NULL, NULL);
INSERT INTO `state` VALUES (2396, 138, 'La Trinite', NULL, NULL);
INSERT INTO `state` VALUES (2397, 138, 'Le Marin', NULL, NULL);
INSERT INTO `state` VALUES (2398, 138, 'Saint-Pierre', NULL, NULL);
INSERT INTO `state` VALUES (2399, 139, 'Adrar', NULL, NULL);
INSERT INTO `state` VALUES (2400, 139, 'Assaba', NULL, NULL);
INSERT INTO `state` VALUES (2401, 139, 'Brakna', NULL, NULL);
INSERT INTO `state` VALUES (2402, 139, 'Dhakhlat Nawadibu', NULL, NULL);
INSERT INTO `state` VALUES (2403, 139, 'Hudh-al-Gharbi', NULL, NULL);
INSERT INTO `state` VALUES (2404, 139, 'Hudh-ash-Sharqi', NULL, NULL);
INSERT INTO `state` VALUES (2405, 139, 'Inshiri', NULL, NULL);
INSERT INTO `state` VALUES (2406, 139, 'Nawakshut', NULL, NULL);
INSERT INTO `state` VALUES (2407, 139, 'Qidimagha', NULL, NULL);
INSERT INTO `state` VALUES (2408, 139, 'Qurqul', NULL, NULL);
INSERT INTO `state` VALUES (2409, 139, 'Taqant', NULL, NULL);
INSERT INTO `state` VALUES (2410, 139, 'Tiris Zammur', NULL, NULL);
INSERT INTO `state` VALUES (2411, 139, 'Trarza', NULL, NULL);
INSERT INTO `state` VALUES (2412, 140, 'Black River', NULL, NULL);
INSERT INTO `state` VALUES (2413, 140, 'Eau Coulee', NULL, NULL);
INSERT INTO `state` VALUES (2414, 140, 'Flacq', NULL, NULL);
INSERT INTO `state` VALUES (2415, 140, 'Floreal', NULL, NULL);
INSERT INTO `state` VALUES (2416, 140, 'Grand Port', NULL, NULL);
INSERT INTO `state` VALUES (2417, 140, 'Moka', NULL, NULL);
INSERT INTO `state` VALUES (2418, 140, 'Pamplempousses', NULL, NULL);
INSERT INTO `state` VALUES (2419, 140, 'Plaines Wilhelm', NULL, NULL);
INSERT INTO `state` VALUES (2420, 140, 'Port Louis', NULL, NULL);
INSERT INTO `state` VALUES (2421, 140, 'Riviere du Rempart', NULL, NULL);
INSERT INTO `state` VALUES (2422, 140, 'Rodrigues', NULL, NULL);
INSERT INTO `state` VALUES (2423, 140, 'Rose Hill', NULL, NULL);
INSERT INTO `state` VALUES (2424, 140, 'Savanne', NULL, NULL);
INSERT INTO `state` VALUES (2425, 141, 'Mayotte', NULL, NULL);
INSERT INTO `state` VALUES (2426, 141, 'Pamanzi', NULL, NULL);
INSERT INTO `state` VALUES (2427, 142, 'Aguascalientes', NULL, NULL);
INSERT INTO `state` VALUES (2428, 142, 'Baja California', NULL, NULL);
INSERT INTO `state` VALUES (2429, 142, 'Baja California Sur', NULL, NULL);
INSERT INTO `state` VALUES (2430, 142, 'Campeche', NULL, NULL);
INSERT INTO `state` VALUES (2431, 142, 'Chiapas', NULL, NULL);
INSERT INTO `state` VALUES (2432, 142, 'Chihuahua', NULL, NULL);
INSERT INTO `state` VALUES (2433, 142, 'Coahuila', NULL, NULL);
INSERT INTO `state` VALUES (2434, 142, 'Colima', NULL, NULL);
INSERT INTO `state` VALUES (2435, 142, 'Distrito Federal', NULL, NULL);
INSERT INTO `state` VALUES (2436, 142, 'Durango', NULL, NULL);
INSERT INTO `state` VALUES (2437, 142, 'Estado de Mexico', NULL, NULL);
INSERT INTO `state` VALUES (2438, 142, 'Guanajuato', NULL, NULL);
INSERT INTO `state` VALUES (2439, 142, 'Guerrero', NULL, NULL);
INSERT INTO `state` VALUES (2440, 142, 'Hidalgo', NULL, NULL);
INSERT INTO `state` VALUES (2441, 142, 'Jalisco', NULL, NULL);
INSERT INTO `state` VALUES (2442, 142, 'Mexico', NULL, NULL);
INSERT INTO `state` VALUES (2443, 142, 'Michoacan', NULL, NULL);
INSERT INTO `state` VALUES (2444, 142, 'Morelos', NULL, NULL);
INSERT INTO `state` VALUES (2445, 142, 'Nayarit', NULL, NULL);
INSERT INTO `state` VALUES (2446, 142, 'Nuevo Leon', NULL, NULL);
INSERT INTO `state` VALUES (2447, 142, 'Oaxaca', NULL, NULL);
INSERT INTO `state` VALUES (2448, 142, 'Puebla', NULL, NULL);
INSERT INTO `state` VALUES (2449, 142, 'Queretaro', NULL, NULL);
INSERT INTO `state` VALUES (2450, 142, 'Quintana Roo', NULL, NULL);
INSERT INTO `state` VALUES (2451, 142, 'San Luis Potosi', NULL, NULL);
INSERT INTO `state` VALUES (2452, 142, 'Sinaloa', NULL, NULL);
INSERT INTO `state` VALUES (2453, 142, 'Sonora', NULL, NULL);
INSERT INTO `state` VALUES (2454, 142, 'Tabasco', NULL, NULL);
INSERT INTO `state` VALUES (2455, 142, 'Tamaulipas', NULL, NULL);
INSERT INTO `state` VALUES (2456, 142, 'Tlaxcala', NULL, NULL);
INSERT INTO `state` VALUES (2457, 142, 'Veracruz', NULL, NULL);
INSERT INTO `state` VALUES (2458, 142, 'Yucatan', NULL, NULL);
INSERT INTO `state` VALUES (2459, 142, 'Zacatecas', NULL, NULL);
INSERT INTO `state` VALUES (2460, 143, 'Chuuk', NULL, NULL);
INSERT INTO `state` VALUES (2461, 143, 'Kusaie', NULL, NULL);
INSERT INTO `state` VALUES (2462, 143, 'Pohnpei', NULL, NULL);
INSERT INTO `state` VALUES (2463, 143, 'Yap', NULL, NULL);
INSERT INTO `state` VALUES (2464, 144, 'Balti', NULL, NULL);
INSERT INTO `state` VALUES (2465, 144, 'Cahul', NULL, NULL);
INSERT INTO `state` VALUES (2466, 144, 'Chisinau', NULL, NULL);
INSERT INTO `state` VALUES (2467, 144, 'Chisinau Oras', NULL, NULL);
INSERT INTO `state` VALUES (2468, 144, 'Edinet', NULL, NULL);
INSERT INTO `state` VALUES (2469, 144, 'Gagauzia', NULL, NULL);
INSERT INTO `state` VALUES (2470, 144, 'Lapusna', NULL, NULL);
INSERT INTO `state` VALUES (2471, 144, 'Orhei', NULL, NULL);
INSERT INTO `state` VALUES (2472, 144, 'Soroca', NULL, NULL);
INSERT INTO `state` VALUES (2473, 144, 'Taraclia', NULL, NULL);
INSERT INTO `state` VALUES (2474, 144, 'Tighina', NULL, NULL);
INSERT INTO `state` VALUES (2475, 144, 'Transnistria', NULL, NULL);
INSERT INTO `state` VALUES (2476, 144, 'Ungheni', NULL, NULL);
INSERT INTO `state` VALUES (2477, 145, 'Fontvieille', NULL, NULL);
INSERT INTO `state` VALUES (2478, 145, 'La Condamine', NULL, NULL);
INSERT INTO `state` VALUES (2479, 145, 'Monaco-Ville', NULL, NULL);
INSERT INTO `state` VALUES (2480, 145, 'Monte Carlo', NULL, NULL);
INSERT INTO `state` VALUES (2481, 146, 'Arhangaj', NULL, NULL);
INSERT INTO `state` VALUES (2482, 146, 'Bajan-Olgij', NULL, NULL);
INSERT INTO `state` VALUES (2483, 146, 'Bajanhongor', NULL, NULL);
INSERT INTO `state` VALUES (2484, 146, 'Bulgan', NULL, NULL);
INSERT INTO `state` VALUES (2485, 146, 'Darhan-Uul', NULL, NULL);
INSERT INTO `state` VALUES (2486, 146, 'Dornod', NULL, NULL);
INSERT INTO `state` VALUES (2487, 146, 'Dornogovi', NULL, NULL);
INSERT INTO `state` VALUES (2488, 146, 'Dundgovi', NULL, NULL);
INSERT INTO `state` VALUES (2489, 146, 'Govi-Altaj', NULL, NULL);
INSERT INTO `state` VALUES (2490, 146, 'Govisumber', NULL, NULL);
INSERT INTO `state` VALUES (2491, 146, 'Hentij', NULL, NULL);
INSERT INTO `state` VALUES (2492, 146, 'Hovd', NULL, NULL);
INSERT INTO `state` VALUES (2493, 146, 'Hovsgol', NULL, NULL);
INSERT INTO `state` VALUES (2494, 146, 'Omnogovi', NULL, NULL);
INSERT INTO `state` VALUES (2495, 146, 'Orhon', NULL, NULL);
INSERT INTO `state` VALUES (2496, 146, 'Ovorhangaj', NULL, NULL);
INSERT INTO `state` VALUES (2497, 146, 'Selenge', NULL, NULL);
INSERT INTO `state` VALUES (2498, 146, 'Suhbaatar', NULL, NULL);
INSERT INTO `state` VALUES (2499, 146, 'Tov', NULL, NULL);
INSERT INTO `state` VALUES (2500, 146, 'Ulaanbaatar', NULL, NULL);
INSERT INTO `state` VALUES (2501, 146, 'Uvs', NULL, NULL);
INSERT INTO `state` VALUES (2502, 146, 'Zavhan', NULL, NULL);
INSERT INTO `state` VALUES (2503, 147, 'Montserrat', NULL, NULL);
INSERT INTO `state` VALUES (2504, 148, 'Agadir', NULL, NULL);
INSERT INTO `state` VALUES (2505, 148, 'Casablanca', NULL, NULL);
INSERT INTO `state` VALUES (2506, 148, 'Chaouia-Ouardigha', NULL, NULL);
INSERT INTO `state` VALUES (2507, 148, 'Doukkala-Abda', NULL, NULL);
INSERT INTO `state` VALUES (2508, 148, 'Fes-Boulemane', NULL, NULL);
INSERT INTO `state` VALUES (2509, 148, 'Gharb-Chrarda-Beni Hssen', NULL, NULL);
INSERT INTO `state` VALUES (2510, 148, 'Guelmim', NULL, NULL);
INSERT INTO `state` VALUES (2511, 148, 'Kenitra', NULL, NULL);
INSERT INTO `state` VALUES (2512, 148, 'Marrakech-Tensift-Al Haouz', NULL, NULL);
INSERT INTO `state` VALUES (2513, 148, 'Meknes-Tafilalet', NULL, NULL);
INSERT INTO `state` VALUES (2514, 148, 'Oriental', NULL, NULL);
INSERT INTO `state` VALUES (2515, 148, 'Oujda', NULL, NULL);
INSERT INTO `state` VALUES (2516, 148, 'Province de Tanger', NULL, NULL);
INSERT INTO `state` VALUES (2517, 148, 'Rabat-Sale-Zammour-Zaer', NULL, NULL);
INSERT INTO `state` VALUES (2518, 148, 'Sala Al Jadida', NULL, NULL);
INSERT INTO `state` VALUES (2519, 148, 'Settat', NULL, NULL);
INSERT INTO `state` VALUES (2520, 148, 'Souss Massa-Draa', NULL, NULL);
INSERT INTO `state` VALUES (2521, 148, 'Tadla-Azilal', NULL, NULL);
INSERT INTO `state` VALUES (2522, 148, 'Tangier-Tetouan', NULL, NULL);
INSERT INTO `state` VALUES (2523, 148, 'Taza-Al Hoceima-Taounate', NULL, NULL);
INSERT INTO `state` VALUES (2524, 148, 'Wilaya de Casablanca', NULL, NULL);
INSERT INTO `state` VALUES (2525, 148, 'Wilaya de Rabat-Sale', NULL, NULL);
INSERT INTO `state` VALUES (2526, 149, 'Cabo Delgado', NULL, NULL);
INSERT INTO `state` VALUES (2527, 149, 'Gaza', NULL, NULL);
INSERT INTO `state` VALUES (2528, 149, 'Inhambane', NULL, NULL);
INSERT INTO `state` VALUES (2529, 149, 'Manica', NULL, NULL);
INSERT INTO `state` VALUES (2530, 149, 'Maputo', NULL, NULL);
INSERT INTO `state` VALUES (2531, 149, 'Maputo Provincia', NULL, NULL);
INSERT INTO `state` VALUES (2532, 149, 'Nampula', NULL, NULL);
INSERT INTO `state` VALUES (2533, 149, 'Niassa', NULL, NULL);
INSERT INTO `state` VALUES (2534, 149, 'Sofala', NULL, NULL);
INSERT INTO `state` VALUES (2535, 149, 'Tete', NULL, NULL);
INSERT INTO `state` VALUES (2536, 149, 'Zambezia', NULL, NULL);
INSERT INTO `state` VALUES (2537, 150, 'Ayeyarwady', NULL, NULL);
INSERT INTO `state` VALUES (2538, 150, 'Bago', NULL, NULL);
INSERT INTO `state` VALUES (2539, 150, 'Chin', NULL, NULL);
INSERT INTO `state` VALUES (2540, 150, 'Kachin', NULL, NULL);
INSERT INTO `state` VALUES (2541, 150, 'Kayah', NULL, NULL);
INSERT INTO `state` VALUES (2542, 150, 'Kayin', NULL, NULL);
INSERT INTO `state` VALUES (2543, 150, 'Magway', NULL, NULL);
INSERT INTO `state` VALUES (2544, 150, 'Mandalay', NULL, NULL);
INSERT INTO `state` VALUES (2545, 150, 'Mon', NULL, NULL);
INSERT INTO `state` VALUES (2546, 150, 'Nay Pyi Taw', NULL, NULL);
INSERT INTO `state` VALUES (2547, 150, 'Rakhine', NULL, NULL);
INSERT INTO `state` VALUES (2548, 150, 'Sagaing', NULL, NULL);
INSERT INTO `state` VALUES (2549, 150, 'Shan', NULL, NULL);
INSERT INTO `state` VALUES (2550, 150, 'Tanintharyi', NULL, NULL);
INSERT INTO `state` VALUES (2551, 150, 'Yangon', NULL, NULL);
INSERT INTO `state` VALUES (2552, 151, 'Caprivi', NULL, NULL);
INSERT INTO `state` VALUES (2553, 151, 'Erongo', NULL, NULL);
INSERT INTO `state` VALUES (2554, 151, 'Hardap', NULL, NULL);
INSERT INTO `state` VALUES (2555, 151, 'Karas', NULL, NULL);
INSERT INTO `state` VALUES (2556, 151, 'Kavango', NULL, NULL);
INSERT INTO `state` VALUES (2557, 151, 'Khomas', NULL, NULL);
INSERT INTO `state` VALUES (2558, 151, 'Kunene', NULL, NULL);
INSERT INTO `state` VALUES (2559, 151, 'Ohangwena', NULL, NULL);
INSERT INTO `state` VALUES (2560, 151, 'Omaheke', NULL, NULL);
INSERT INTO `state` VALUES (2561, 151, 'Omusati', NULL, NULL);
INSERT INTO `state` VALUES (2562, 151, 'Oshana', NULL, NULL);
INSERT INTO `state` VALUES (2563, 151, 'Oshikoto', NULL, NULL);
INSERT INTO `state` VALUES (2564, 151, 'Otjozondjupa', NULL, NULL);
INSERT INTO `state` VALUES (2565, 152, 'Yaren', NULL, NULL);
INSERT INTO `state` VALUES (2566, 153, 'Bagmati', NULL, NULL);
INSERT INTO `state` VALUES (2567, 153, 'Bheri', NULL, NULL);
INSERT INTO `state` VALUES (2568, 153, 'Dhawalagiri', NULL, NULL);
INSERT INTO `state` VALUES (2569, 153, 'Gandaki', NULL, NULL);
INSERT INTO `state` VALUES (2570, 153, 'Janakpur', NULL, NULL);
INSERT INTO `state` VALUES (2571, 153, 'Karnali', NULL, NULL);
INSERT INTO `state` VALUES (2572, 153, 'Koshi', NULL, NULL);
INSERT INTO `state` VALUES (2573, 153, 'Lumbini', NULL, NULL);
INSERT INTO `state` VALUES (2574, 153, 'Mahakali', NULL, NULL);
INSERT INTO `state` VALUES (2575, 153, 'Mechi', NULL, NULL);
INSERT INTO `state` VALUES (2576, 153, 'Narayani', NULL, NULL);
INSERT INTO `state` VALUES (2577, 153, 'Rapti', NULL, NULL);
INSERT INTO `state` VALUES (2578, 153, 'Sagarmatha', NULL, NULL);
INSERT INTO `state` VALUES (2579, 153, 'Seti', NULL, NULL);
INSERT INTO `state` VALUES (2580, 154, 'Bonaire', NULL, NULL);
INSERT INTO `state` VALUES (2581, 154, 'Curacao', NULL, NULL);
INSERT INTO `state` VALUES (2582, 154, 'Saba', NULL, NULL);
INSERT INTO `state` VALUES (2583, 154, 'Sint Eustatius', NULL, NULL);
INSERT INTO `state` VALUES (2584, 154, 'Sint Maarten', NULL, NULL);
INSERT INTO `state` VALUES (2585, 155, 'Amsterdam', NULL, NULL);
INSERT INTO `state` VALUES (2586, 155, 'Benelux', NULL, NULL);
INSERT INTO `state` VALUES (2587, 155, 'Drenthe', NULL, NULL);
INSERT INTO `state` VALUES (2588, 155, 'Flevoland', NULL, NULL);
INSERT INTO `state` VALUES (2589, 155, 'Friesland', NULL, NULL);
INSERT INTO `state` VALUES (2590, 155, 'Gelderland', NULL, NULL);
INSERT INTO `state` VALUES (2591, 155, 'Groningen', NULL, NULL);
INSERT INTO `state` VALUES (2592, 155, 'Limburg', NULL, NULL);
INSERT INTO `state` VALUES (2593, 155, 'Noord-Brabant', NULL, NULL);
INSERT INTO `state` VALUES (2594, 155, 'Noord-Holland', NULL, NULL);
INSERT INTO `state` VALUES (2595, 155, 'Overijssel', NULL, NULL);
INSERT INTO `state` VALUES (2596, 155, 'South Holland', NULL, NULL);
INSERT INTO `state` VALUES (2597, 155, 'Utrecht', NULL, NULL);
INSERT INTO `state` VALUES (2598, 155, 'Zeeland', NULL, NULL);
INSERT INTO `state` VALUES (2599, 155, 'Zuid-Holland', NULL, NULL);
INSERT INTO `state` VALUES (2600, 156, 'Iles', NULL, NULL);
INSERT INTO `state` VALUES (2601, 156, 'Nord', NULL, NULL);
INSERT INTO `state` VALUES (2602, 156, 'Sud', NULL, NULL);
INSERT INTO `state` VALUES (2603, 157, 'Area Outside Region', NULL, NULL);
INSERT INTO `state` VALUES (2604, 157, 'Auckland', NULL, NULL);
INSERT INTO `state` VALUES (2605, 157, 'Bay of Plenty', NULL, NULL);
INSERT INTO `state` VALUES (2606, 157, 'Canterbury', NULL, NULL);
INSERT INTO `state` VALUES (2607, 157, 'Christchurch', NULL, NULL);
INSERT INTO `state` VALUES (2608, 157, 'Gisborne', NULL, NULL);
INSERT INTO `state` VALUES (2609, 157, 'Hawke\'s Bay', NULL, NULL);
INSERT INTO `state` VALUES (2610, 157, 'Manawatu-Wanganui', NULL, NULL);
INSERT INTO `state` VALUES (2611, 157, 'Marlborough', NULL, NULL);
INSERT INTO `state` VALUES (2612, 157, 'Nelson', NULL, NULL);
INSERT INTO `state` VALUES (2613, 157, 'Northland', NULL, NULL);
INSERT INTO `state` VALUES (2614, 157, 'Otago', NULL, NULL);
INSERT INTO `state` VALUES (2615, 157, 'Rodney', NULL, NULL);
INSERT INTO `state` VALUES (2616, 157, 'Southland', NULL, NULL);
INSERT INTO `state` VALUES (2617, 157, 'Taranaki', NULL, NULL);
INSERT INTO `state` VALUES (2618, 157, 'Tasman', NULL, NULL);
INSERT INTO `state` VALUES (2619, 157, 'Waikato', NULL, NULL);
INSERT INTO `state` VALUES (2620, 157, 'Wellington', NULL, NULL);
INSERT INTO `state` VALUES (2621, 157, 'West Coast', NULL, NULL);
INSERT INTO `state` VALUES (2622, 158, 'Atlantico Norte', NULL, NULL);
INSERT INTO `state` VALUES (2623, 158, 'Atlantico Sur', NULL, NULL);
INSERT INTO `state` VALUES (2624, 158, 'Boaco', NULL, NULL);
INSERT INTO `state` VALUES (2625, 158, 'Carazo', NULL, NULL);
INSERT INTO `state` VALUES (2626, 158, 'Chinandega', NULL, NULL);
INSERT INTO `state` VALUES (2627, 158, 'Chontales', NULL, NULL);
INSERT INTO `state` VALUES (2628, 158, 'Esteli', NULL, NULL);
INSERT INTO `state` VALUES (2629, 158, 'Granada', NULL, NULL);
INSERT INTO `state` VALUES (2630, 158, 'Jinotega', NULL, NULL);
INSERT INTO `state` VALUES (2631, 158, 'Leon', NULL, NULL);
INSERT INTO `state` VALUES (2632, 158, 'Madriz', NULL, NULL);
INSERT INTO `state` VALUES (2633, 158, 'Managua', NULL, NULL);
INSERT INTO `state` VALUES (2634, 158, 'Masaya', NULL, NULL);
INSERT INTO `state` VALUES (2635, 158, 'Matagalpa', NULL, NULL);
INSERT INTO `state` VALUES (2636, 158, 'Nueva Segovia', NULL, NULL);
INSERT INTO `state` VALUES (2637, 158, 'Rio San Juan', NULL, NULL);
INSERT INTO `state` VALUES (2638, 158, 'Rivas', NULL, NULL);
INSERT INTO `state` VALUES (2639, 159, 'Agadez', NULL, NULL);
INSERT INTO `state` VALUES (2640, 159, 'Diffa', NULL, NULL);
INSERT INTO `state` VALUES (2641, 159, 'Dosso', NULL, NULL);
INSERT INTO `state` VALUES (2642, 159, 'Maradi', NULL, NULL);
INSERT INTO `state` VALUES (2643, 159, 'Niamey', NULL, NULL);
INSERT INTO `state` VALUES (2644, 159, 'Tahoua', NULL, NULL);
INSERT INTO `state` VALUES (2645, 159, 'Tillabery', NULL, NULL);
INSERT INTO `state` VALUES (2646, 159, 'Zinder', NULL, NULL);
INSERT INTO `state` VALUES (2647, 160, 'Abia', NULL, NULL);
INSERT INTO `state` VALUES (2648, 160, 'Abuja Federal Capital Territor', NULL, NULL);
INSERT INTO `state` VALUES (2649, 160, 'Adamawa', NULL, NULL);
INSERT INTO `state` VALUES (2650, 160, 'Akwa Ibom', NULL, NULL);
INSERT INTO `state` VALUES (2651, 160, 'Anambra', NULL, NULL);
INSERT INTO `state` VALUES (2652, 160, 'Bauchi', NULL, NULL);
INSERT INTO `state` VALUES (2653, 160, 'Bayelsa', NULL, NULL);
INSERT INTO `state` VALUES (2654, 160, 'Benue', NULL, NULL);
INSERT INTO `state` VALUES (2655, 160, 'Borno', NULL, NULL);
INSERT INTO `state` VALUES (2656, 160, 'Cross River', NULL, NULL);
INSERT INTO `state` VALUES (2657, 160, 'Delta', NULL, NULL);
INSERT INTO `state` VALUES (2658, 160, 'Ebonyi', NULL, NULL);
INSERT INTO `state` VALUES (2659, 160, 'Edo', NULL, NULL);
INSERT INTO `state` VALUES (2660, 160, 'Ekiti', NULL, NULL);
INSERT INTO `state` VALUES (2661, 160, 'Enugu', NULL, NULL);
INSERT INTO `state` VALUES (2662, 160, 'Gombe', NULL, NULL);
INSERT INTO `state` VALUES (2663, 160, 'Imo', NULL, NULL);
INSERT INTO `state` VALUES (2664, 160, 'Jigawa', NULL, NULL);
INSERT INTO `state` VALUES (2665, 160, 'Kaduna', NULL, NULL);
INSERT INTO `state` VALUES (2666, 160, 'Kano', NULL, NULL);
INSERT INTO `state` VALUES (2667, 160, 'Katsina', NULL, NULL);
INSERT INTO `state` VALUES (2668, 160, 'Kebbi', NULL, NULL);
INSERT INTO `state` VALUES (2669, 160, 'Kogi', NULL, NULL);
INSERT INTO `state` VALUES (2670, 160, 'Kwara', NULL, NULL);
INSERT INTO `state` VALUES (2671, 160, 'Lagos', NULL, NULL);
INSERT INTO `state` VALUES (2672, 160, 'Nassarawa', NULL, NULL);
INSERT INTO `state` VALUES (2673, 160, 'Niger', NULL, NULL);
INSERT INTO `state` VALUES (2674, 160, 'Ogun', NULL, NULL);
INSERT INTO `state` VALUES (2675, 160, 'Ondo', NULL, NULL);
INSERT INTO `state` VALUES (2676, 160, 'Osun', NULL, NULL);
INSERT INTO `state` VALUES (2677, 160, 'Oyo', NULL, NULL);
INSERT INTO `state` VALUES (2678, 160, 'Plateau', NULL, NULL);
INSERT INTO `state` VALUES (2679, 160, 'Rivers', NULL, NULL);
INSERT INTO `state` VALUES (2680, 160, 'Sokoto', NULL, NULL);
INSERT INTO `state` VALUES (2681, 160, 'Taraba', NULL, NULL);
INSERT INTO `state` VALUES (2682, 160, 'Yobe', NULL, NULL);
INSERT INTO `state` VALUES (2683, 160, 'Zamfara', NULL, NULL);
INSERT INTO `state` VALUES (2684, 161, 'Niue', NULL, NULL);
INSERT INTO `state` VALUES (2685, 162, 'Norfolk Island', NULL, NULL);
INSERT INTO `state` VALUES (2686, 163, 'Northern Islands', NULL, NULL);
INSERT INTO `state` VALUES (2687, 163, 'Rota', NULL, NULL);
INSERT INTO `state` VALUES (2688, 163, 'Saipan', NULL, NULL);
INSERT INTO `state` VALUES (2689, 163, 'Tinian', NULL, NULL);
INSERT INTO `state` VALUES (2690, 164, 'Akershus', NULL, NULL);
INSERT INTO `state` VALUES (2691, 164, 'Aust Agder', NULL, NULL);
INSERT INTO `state` VALUES (2692, 164, 'Bergen', NULL, NULL);
INSERT INTO `state` VALUES (2693, 164, 'Buskerud', NULL, NULL);
INSERT INTO `state` VALUES (2694, 164, 'Finnmark', NULL, NULL);
INSERT INTO `state` VALUES (2695, 164, 'Hedmark', NULL, NULL);
INSERT INTO `state` VALUES (2696, 164, 'Hordaland', NULL, NULL);
INSERT INTO `state` VALUES (2697, 164, 'Moere og Romsdal', NULL, NULL);
INSERT INTO `state` VALUES (2698, 164, 'Nord Trondelag', NULL, NULL);
INSERT INTO `state` VALUES (2699, 164, 'Nordland', NULL, NULL);
INSERT INTO `state` VALUES (2700, 164, 'Oestfold', NULL, NULL);
INSERT INTO `state` VALUES (2701, 164, 'Oppland', NULL, NULL);
INSERT INTO `state` VALUES (2702, 164, 'Oslo', NULL, NULL);
INSERT INTO `state` VALUES (2703, 164, 'Rogaland', NULL, NULL);
INSERT INTO `state` VALUES (2704, 164, 'Soer Troendelag', NULL, NULL);
INSERT INTO `state` VALUES (2705, 164, 'Sogn og Fjordane', NULL, NULL);
INSERT INTO `state` VALUES (2706, 164, 'Stavern', NULL, NULL);
INSERT INTO `state` VALUES (2707, 164, 'Sykkylven', NULL, NULL);
INSERT INTO `state` VALUES (2708, 164, 'Telemark', NULL, NULL);
INSERT INTO `state` VALUES (2709, 164, 'Troms', NULL, NULL);
INSERT INTO `state` VALUES (2710, 164, 'Vest Agder', NULL, NULL);
INSERT INTO `state` VALUES (2711, 164, 'Vestfold', NULL, NULL);
INSERT INTO `state` VALUES (2712, 164, 'ÃƒÂ˜stfold', NULL, NULL);
INSERT INTO `state` VALUES (2713, 165, 'Al Buraimi', NULL, NULL);
INSERT INTO `state` VALUES (2714, 165, 'Dhufar', NULL, NULL);
INSERT INTO `state` VALUES (2715, 165, 'Masqat', NULL, NULL);
INSERT INTO `state` VALUES (2716, 165, 'Musandam', NULL, NULL);
INSERT INTO `state` VALUES (2717, 165, 'Rusayl', NULL, NULL);
INSERT INTO `state` VALUES (2718, 165, 'Wadi Kabir', NULL, NULL);
INSERT INTO `state` VALUES (2719, 165, 'ad-Dakhiliyah', NULL, NULL);
INSERT INTO `state` VALUES (2720, 165, 'adh-Dhahirah', NULL, NULL);
INSERT INTO `state` VALUES (2721, 165, 'al-Batinah', NULL, NULL);
INSERT INTO `state` VALUES (2722, 165, 'ash-Sharqiyah', NULL, NULL);
INSERT INTO `state` VALUES (2723, 166, 'Azad kashmir', NULL, NULL);
INSERT INTO `state` VALUES (2724, 166, 'Balochistan', NULL, NULL);
INSERT INTO `state` VALUES (2725, 166, 'Fata', NULL, NULL);
INSERT INTO `state` VALUES (2726, 166, 'Gilgit–baltistan', NULL, NULL);
INSERT INTO `state` VALUES (2727, 166, 'Islamabad capital territory', NULL, NULL);
INSERT INTO `state` VALUES (2728, 166, 'Khyber Pakhtunkhwa', NULL, NULL);
INSERT INTO `state` VALUES (2729, 166, 'Punjab', NULL, NULL);
INSERT INTO `state` VALUES (2730, 166, 'Sindh', NULL, NULL);
INSERT INTO `state` VALUES (2731, 167, 'Aimeliik', NULL, NULL);
INSERT INTO `state` VALUES (2732, 167, 'Airai', NULL, NULL);
INSERT INTO `state` VALUES (2733, 167, 'Angaur', NULL, NULL);
INSERT INTO `state` VALUES (2734, 167, 'Hatobohei', NULL, NULL);
INSERT INTO `state` VALUES (2735, 167, 'Kayangel', NULL, NULL);
INSERT INTO `state` VALUES (2736, 167, 'Koror', NULL, NULL);
INSERT INTO `state` VALUES (2737, 167, 'Melekeok', NULL, NULL);
INSERT INTO `state` VALUES (2738, 167, 'Ngaraard', NULL, NULL);
INSERT INTO `state` VALUES (2739, 167, 'Ngardmau', NULL, NULL);
INSERT INTO `state` VALUES (2740, 167, 'Ngaremlengui', NULL, NULL);
INSERT INTO `state` VALUES (2741, 167, 'Ngatpang', NULL, NULL);
INSERT INTO `state` VALUES (2742, 167, 'Ngchesar', NULL, NULL);
INSERT INTO `state` VALUES (2743, 167, 'Ngerchelong', NULL, NULL);
INSERT INTO `state` VALUES (2744, 167, 'Ngiwal', NULL, NULL);
INSERT INTO `state` VALUES (2745, 167, 'Peleliu', NULL, NULL);
INSERT INTO `state` VALUES (2746, 167, 'Sonsorol', NULL, NULL);
INSERT INTO `state` VALUES (2747, 168, 'Ariha', NULL, NULL);
INSERT INTO `state` VALUES (2748, 168, 'Bayt Lahm', NULL, NULL);
INSERT INTO `state` VALUES (2749, 168, 'Bethlehem', NULL, NULL);
INSERT INTO `state` VALUES (2750, 168, 'Dayr-al-Balah', NULL, NULL);
INSERT INTO `state` VALUES (2751, 168, 'Ghazzah', NULL, NULL);
INSERT INTO `state` VALUES (2752, 168, 'Ghazzah ash-Shamaliyah', NULL, NULL);
INSERT INTO `state` VALUES (2753, 168, 'Janin', NULL, NULL);
INSERT INTO `state` VALUES (2754, 168, 'Khan Yunis', NULL, NULL);
INSERT INTO `state` VALUES (2755, 168, 'Nabulus', NULL, NULL);
INSERT INTO `state` VALUES (2756, 168, 'Qalqilyah', NULL, NULL);
INSERT INTO `state` VALUES (2757, 168, 'Rafah', NULL, NULL);
INSERT INTO `state` VALUES (2758, 168, 'Ram Allah wal-Birah', NULL, NULL);
INSERT INTO `state` VALUES (2759, 168, 'Salfit', NULL, NULL);
INSERT INTO `state` VALUES (2760, 168, 'Tubas', NULL, NULL);
INSERT INTO `state` VALUES (2761, 168, 'Tulkarm', NULL, NULL);
INSERT INTO `state` VALUES (2762, 168, 'al-Khalil', NULL, NULL);
INSERT INTO `state` VALUES (2763, 168, 'al-Quds', NULL, NULL);
INSERT INTO `state` VALUES (2764, 169, 'Bocas del Toro', NULL, NULL);
INSERT INTO `state` VALUES (2765, 169, 'Chiriqui', NULL, NULL);
INSERT INTO `state` VALUES (2766, 169, 'Cocle', NULL, NULL);
INSERT INTO `state` VALUES (2767, 169, 'Colon', NULL, NULL);
INSERT INTO `state` VALUES (2768, 169, 'Darien', NULL, NULL);
INSERT INTO `state` VALUES (2769, 169, 'Embera', NULL, NULL);
INSERT INTO `state` VALUES (2770, 169, 'Herrera', NULL, NULL);
INSERT INTO `state` VALUES (2771, 169, 'Kuna Yala', NULL, NULL);
INSERT INTO `state` VALUES (2772, 169, 'Los Santos', NULL, NULL);
INSERT INTO `state` VALUES (2773, 169, 'Ngobe Bugle', NULL, NULL);
INSERT INTO `state` VALUES (2774, 169, 'Panama', NULL, NULL);
INSERT INTO `state` VALUES (2775, 169, 'Veraguas', NULL, NULL);
INSERT INTO `state` VALUES (2776, 170, 'East New Britain', NULL, NULL);
INSERT INTO `state` VALUES (2777, 170, 'East Sepik', NULL, NULL);
INSERT INTO `state` VALUES (2778, 170, 'Eastern Highlands', NULL, NULL);
INSERT INTO `state` VALUES (2779, 170, 'Enga', NULL, NULL);
INSERT INTO `state` VALUES (2780, 170, 'Fly River', NULL, NULL);
INSERT INTO `state` VALUES (2781, 170, 'Gulf', NULL, NULL);
INSERT INTO `state` VALUES (2782, 170, 'Madang', NULL, NULL);
INSERT INTO `state` VALUES (2783, 170, 'Manus', NULL, NULL);
INSERT INTO `state` VALUES (2784, 170, 'Milne Bay', NULL, NULL);
INSERT INTO `state` VALUES (2785, 170, 'Morobe', NULL, NULL);
INSERT INTO `state` VALUES (2786, 170, 'National Capital District', NULL, NULL);
INSERT INTO `state` VALUES (2787, 170, 'New Ireland', NULL, NULL);
INSERT INTO `state` VALUES (2788, 170, 'North Solomons', NULL, NULL);
INSERT INTO `state` VALUES (2789, 170, 'Oro', NULL, NULL);
INSERT INTO `state` VALUES (2790, 170, 'Sandaun', NULL, NULL);
INSERT INTO `state` VALUES (2791, 170, 'Simbu', NULL, NULL);
INSERT INTO `state` VALUES (2792, 170, 'Southern Highlands', NULL, NULL);
INSERT INTO `state` VALUES (2793, 170, 'West New Britain', NULL, NULL);
INSERT INTO `state` VALUES (2794, 170, 'Western Highlands', NULL, NULL);
INSERT INTO `state` VALUES (2795, 171, 'Alto Paraguay', NULL, NULL);
INSERT INTO `state` VALUES (2796, 171, 'Alto Parana', NULL, NULL);
INSERT INTO `state` VALUES (2797, 171, 'Amambay', NULL, NULL);
INSERT INTO `state` VALUES (2798, 171, 'Asuncion', NULL, NULL);
INSERT INTO `state` VALUES (2799, 171, 'Boqueron', NULL, NULL);
INSERT INTO `state` VALUES (2800, 171, 'Caaguazu', NULL, NULL);
INSERT INTO `state` VALUES (2801, 171, 'Caazapa', NULL, NULL);
INSERT INTO `state` VALUES (2802, 171, 'Canendiyu', NULL, NULL);
INSERT INTO `state` VALUES (2803, 171, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (2804, 171, 'Concepcion', NULL, NULL);
INSERT INTO `state` VALUES (2805, 171, 'Cordillera', NULL, NULL);
INSERT INTO `state` VALUES (2806, 171, 'Guaira', NULL, NULL);
INSERT INTO `state` VALUES (2807, 171, 'Itapua', NULL, NULL);
INSERT INTO `state` VALUES (2808, 171, 'Misiones', NULL, NULL);
INSERT INTO `state` VALUES (2809, 171, 'Neembucu', NULL, NULL);
INSERT INTO `state` VALUES (2810, 171, 'Paraguari', NULL, NULL);
INSERT INTO `state` VALUES (2811, 171, 'Presidente Hayes', NULL, NULL);
INSERT INTO `state` VALUES (2812, 171, 'San Pedro', NULL, NULL);
INSERT INTO `state` VALUES (2813, 172, 'Amazonas', NULL, NULL);
INSERT INTO `state` VALUES (2814, 172, 'Ancash', NULL, NULL);
INSERT INTO `state` VALUES (2815, 172, 'Apurimac', NULL, NULL);
INSERT INTO `state` VALUES (2816, 172, 'Arequipa', NULL, NULL);
INSERT INTO `state` VALUES (2817, 172, 'Ayacucho', NULL, NULL);
INSERT INTO `state` VALUES (2818, 172, 'Cajamarca', NULL, NULL);
INSERT INTO `state` VALUES (2819, 172, 'Cusco', NULL, NULL);
INSERT INTO `state` VALUES (2820, 172, 'Huancavelica', NULL, NULL);
INSERT INTO `state` VALUES (2821, 172, 'Huanuco', NULL, NULL);
INSERT INTO `state` VALUES (2822, 172, 'Ica', NULL, NULL);
INSERT INTO `state` VALUES (2823, 172, 'Junin', NULL, NULL);
INSERT INTO `state` VALUES (2824, 172, 'La Libertad', NULL, NULL);
INSERT INTO `state` VALUES (2825, 172, 'Lambayeque', NULL, NULL);
INSERT INTO `state` VALUES (2826, 172, 'Lima y Callao', NULL, NULL);
INSERT INTO `state` VALUES (2827, 172, 'Loreto', NULL, NULL);
INSERT INTO `state` VALUES (2828, 172, 'Madre de Dios', NULL, NULL);
INSERT INTO `state` VALUES (2829, 172, 'Moquegua', NULL, NULL);
INSERT INTO `state` VALUES (2830, 172, 'Pasco', NULL, NULL);
INSERT INTO `state` VALUES (2831, 172, 'Piura', NULL, NULL);
INSERT INTO `state` VALUES (2832, 172, 'Puno', NULL, NULL);
INSERT INTO `state` VALUES (2833, 172, 'San Martin', NULL, NULL);
INSERT INTO `state` VALUES (2834, 172, 'Tacna', NULL, NULL);
INSERT INTO `state` VALUES (2835, 172, 'Tumbes', NULL, NULL);
INSERT INTO `state` VALUES (2836, 172, 'Ucayali', NULL, NULL);
INSERT INTO `state` VALUES (2837, 173, 'Batangas', NULL, NULL);
INSERT INTO `state` VALUES (2838, 173, 'Bicol', NULL, NULL);
INSERT INTO `state` VALUES (2839, 173, 'Bulacan', NULL, NULL);
INSERT INTO `state` VALUES (2840, 173, 'Cagayan', NULL, NULL);
INSERT INTO `state` VALUES (2841, 173, 'Caraga', NULL, NULL);
INSERT INTO `state` VALUES (2842, 173, 'Central Luzon', NULL, NULL);
INSERT INTO `state` VALUES (2843, 173, 'Central Mindanao', NULL, NULL);
INSERT INTO `state` VALUES (2844, 173, 'Central Visayas', NULL, NULL);
INSERT INTO `state` VALUES (2845, 173, 'Cordillera', NULL, NULL);
INSERT INTO `state` VALUES (2846, 173, 'Davao', NULL, NULL);
INSERT INTO `state` VALUES (2847, 173, 'Eastern Visayas', NULL, NULL);
INSERT INTO `state` VALUES (2848, 173, 'Greater Metropolitan Area', NULL, NULL);
INSERT INTO `state` VALUES (2849, 173, 'Ilocos', NULL, NULL);
INSERT INTO `state` VALUES (2850, 173, 'Laguna', NULL, NULL);
INSERT INTO `state` VALUES (2851, 173, 'Luzon', NULL, NULL);
INSERT INTO `state` VALUES (2852, 173, 'Mactan', NULL, NULL);
INSERT INTO `state` VALUES (2853, 173, 'Metropolitan Manila Area', NULL, NULL);
INSERT INTO `state` VALUES (2854, 173, 'Muslim Mindanao', NULL, NULL);
INSERT INTO `state` VALUES (2855, 173, 'Northern Mindanao', NULL, NULL);
INSERT INTO `state` VALUES (2856, 173, 'Southern Mindanao', NULL, NULL);
INSERT INTO `state` VALUES (2857, 173, 'Southern Tagalog', NULL, NULL);
INSERT INTO `state` VALUES (2858, 173, 'Western Mindanao', NULL, NULL);
INSERT INTO `state` VALUES (2859, 173, 'Western Visayas', NULL, NULL);
INSERT INTO `state` VALUES (2860, 174, 'Pitcairn Island', NULL, NULL);
INSERT INTO `state` VALUES (2861, 175, 'Biale Blota', NULL, NULL);
INSERT INTO `state` VALUES (2862, 175, 'Dobroszyce', NULL, NULL);
INSERT INTO `state` VALUES (2863, 175, 'Dolnoslaskie', NULL, NULL);
INSERT INTO `state` VALUES (2864, 175, 'Dziekanow Lesny', NULL, NULL);
INSERT INTO `state` VALUES (2865, 175, 'Hopowo', NULL, NULL);
INSERT INTO `state` VALUES (2866, 175, 'Kartuzy', NULL, NULL);
INSERT INTO `state` VALUES (2867, 175, 'Koscian', NULL, NULL);
INSERT INTO `state` VALUES (2868, 175, 'Krakow', NULL, NULL);
INSERT INTO `state` VALUES (2869, 175, 'Kujawsko-Pomorskie', NULL, NULL);
INSERT INTO `state` VALUES (2870, 175, 'Lodzkie', NULL, NULL);
INSERT INTO `state` VALUES (2871, 175, 'Lubelskie', NULL, NULL);
INSERT INTO `state` VALUES (2872, 175, 'Lubuskie', NULL, NULL);
INSERT INTO `state` VALUES (2873, 175, 'Malomice', NULL, NULL);
INSERT INTO `state` VALUES (2874, 175, 'Malopolskie', NULL, NULL);
INSERT INTO `state` VALUES (2875, 175, 'Mazowieckie', NULL, NULL);
INSERT INTO `state` VALUES (2876, 175, 'Mirkow', NULL, NULL);
INSERT INTO `state` VALUES (2877, 175, 'Opolskie', NULL, NULL);
INSERT INTO `state` VALUES (2878, 175, 'Ostrowiec', NULL, NULL);
INSERT INTO `state` VALUES (2879, 175, 'Podkarpackie', NULL, NULL);
INSERT INTO `state` VALUES (2880, 175, 'Podlaskie', NULL, NULL);
INSERT INTO `state` VALUES (2881, 175, 'Polska', NULL, NULL);
INSERT INTO `state` VALUES (2882, 175, 'Pomorskie', NULL, NULL);
INSERT INTO `state` VALUES (2883, 175, 'Poznan', NULL, NULL);
INSERT INTO `state` VALUES (2884, 175, 'Pruszkow', NULL, NULL);
INSERT INTO `state` VALUES (2885, 175, 'Rymanowska', NULL, NULL);
INSERT INTO `state` VALUES (2886, 175, 'Rzeszow', NULL, NULL);
INSERT INTO `state` VALUES (2887, 175, 'Slaskie', NULL, NULL);
INSERT INTO `state` VALUES (2888, 175, 'Stare Pole', NULL, NULL);
INSERT INTO `state` VALUES (2889, 175, 'Swietokrzyskie', NULL, NULL);
INSERT INTO `state` VALUES (2890, 175, 'Warminsko-Mazurskie', NULL, NULL);
INSERT INTO `state` VALUES (2891, 175, 'Warsaw', NULL, NULL);
INSERT INTO `state` VALUES (2892, 175, 'Wejherowo', NULL, NULL);
INSERT INTO `state` VALUES (2893, 175, 'Wielkopolskie', NULL, NULL);
INSERT INTO `state` VALUES (2894, 175, 'Wroclaw', NULL, NULL);
INSERT INTO `state` VALUES (2895, 175, 'Zachodnio-Pomorskie', NULL, NULL);
INSERT INTO `state` VALUES (2896, 175, 'Zukowo', NULL, NULL);
INSERT INTO `state` VALUES (2897, 176, 'Abrantes', NULL, NULL);
INSERT INTO `state` VALUES (2898, 176, 'Acores', NULL, NULL);
INSERT INTO `state` VALUES (2899, 176, 'Alentejo', NULL, NULL);
INSERT INTO `state` VALUES (2900, 176, 'Algarve', NULL, NULL);
INSERT INTO `state` VALUES (2901, 176, 'Braga', NULL, NULL);
INSERT INTO `state` VALUES (2902, 176, 'Centro', NULL, NULL);
INSERT INTO `state` VALUES (2903, 176, 'Distrito de Leiria', NULL, NULL);
INSERT INTO `state` VALUES (2904, 176, 'Distrito de Viana do Castelo', NULL, NULL);
INSERT INTO `state` VALUES (2905, 176, 'Distrito de Vila Real', NULL, NULL);
INSERT INTO `state` VALUES (2906, 176, 'Distrito do Porto', NULL, NULL);
INSERT INTO `state` VALUES (2907, 176, 'Lisboa e Vale do Tejo', NULL, NULL);
INSERT INTO `state` VALUES (2908, 176, 'Madeira', NULL, NULL);
INSERT INTO `state` VALUES (2909, 176, 'Norte', NULL, NULL);
INSERT INTO `state` VALUES (2910, 176, 'Paivas', NULL, NULL);
INSERT INTO `state` VALUES (2911, 177, 'Arecibo', NULL, NULL);
INSERT INTO `state` VALUES (2912, 177, 'Bayamon', NULL, NULL);
INSERT INTO `state` VALUES (2913, 177, 'Carolina', NULL, NULL);
INSERT INTO `state` VALUES (2914, 177, 'Florida', NULL, NULL);
INSERT INTO `state` VALUES (2915, 177, 'Guayama', NULL, NULL);
INSERT INTO `state` VALUES (2916, 177, 'Humacao', NULL, NULL);
INSERT INTO `state` VALUES (2917, 177, 'Mayaguez-Aguadilla', NULL, NULL);
INSERT INTO `state` VALUES (2918, 177, 'Ponce', NULL, NULL);
INSERT INTO `state` VALUES (2919, 177, 'Salinas', NULL, NULL);
INSERT INTO `state` VALUES (2920, 177, 'San Juan', NULL, NULL);
INSERT INTO `state` VALUES (2921, 178, 'Doha', NULL, NULL);
INSERT INTO `state` VALUES (2922, 178, 'Jarian-al-Batnah', NULL, NULL);
INSERT INTO `state` VALUES (2923, 178, 'Umm Salal', NULL, NULL);
INSERT INTO `state` VALUES (2924, 178, 'ad-Dawhah', NULL, NULL);
INSERT INTO `state` VALUES (2925, 178, 'al-Ghuwayriyah', NULL, NULL);
INSERT INTO `state` VALUES (2926, 178, 'al-Jumayliyah', NULL, NULL);
INSERT INTO `state` VALUES (2927, 178, 'al-Khawr', NULL, NULL);
INSERT INTO `state` VALUES (2928, 178, 'al-Wakrah', NULL, NULL);
INSERT INTO `state` VALUES (2929, 178, 'ar-Rayyan', NULL, NULL);
INSERT INTO `state` VALUES (2930, 178, 'ash-Shamal', NULL, NULL);
INSERT INTO `state` VALUES (2931, 179, 'Saint-Benoit', NULL, NULL);
INSERT INTO `state` VALUES (2932, 179, 'Saint-Denis', NULL, NULL);
INSERT INTO `state` VALUES (2933, 179, 'Saint-Paul', NULL, NULL);
INSERT INTO `state` VALUES (2934, 179, 'Saint-Pierre', NULL, NULL);
INSERT INTO `state` VALUES (2935, 180, 'Alba', NULL, NULL);
INSERT INTO `state` VALUES (2936, 180, 'Arad', NULL, NULL);
INSERT INTO `state` VALUES (2937, 180, 'Arges', NULL, NULL);
INSERT INTO `state` VALUES (2938, 180, 'Bacau', NULL, NULL);
INSERT INTO `state` VALUES (2939, 180, 'Bihor', NULL, NULL);
INSERT INTO `state` VALUES (2940, 180, 'Bistrita-Nasaud', NULL, NULL);
INSERT INTO `state` VALUES (2941, 180, 'Botosani', NULL, NULL);
INSERT INTO `state` VALUES (2942, 180, 'Braila', NULL, NULL);
INSERT INTO `state` VALUES (2943, 180, 'Brasov', NULL, NULL);
INSERT INTO `state` VALUES (2944, 180, 'Bucuresti', NULL, NULL);
INSERT INTO `state` VALUES (2945, 180, 'Buzau', NULL, NULL);
INSERT INTO `state` VALUES (2946, 180, 'Calarasi', NULL, NULL);
INSERT INTO `state` VALUES (2947, 180, 'Caras-Severin', NULL, NULL);
INSERT INTO `state` VALUES (2948, 180, 'Cluj', NULL, NULL);
INSERT INTO `state` VALUES (2949, 180, 'Constanta', NULL, NULL);
INSERT INTO `state` VALUES (2950, 180, 'Covasna', NULL, NULL);
INSERT INTO `state` VALUES (2951, 180, 'Dambovita', NULL, NULL);
INSERT INTO `state` VALUES (2952, 180, 'Dolj', NULL, NULL);
INSERT INTO `state` VALUES (2953, 180, 'Galati', NULL, NULL);
INSERT INTO `state` VALUES (2954, 180, 'Giurgiu', NULL, NULL);
INSERT INTO `state` VALUES (2955, 180, 'Gorj', NULL, NULL);
INSERT INTO `state` VALUES (2956, 180, 'Harghita', NULL, NULL);
INSERT INTO `state` VALUES (2957, 180, 'Hunedoara', NULL, NULL);
INSERT INTO `state` VALUES (2958, 180, 'Ialomita', NULL, NULL);
INSERT INTO `state` VALUES (2959, 180, 'Iasi', NULL, NULL);
INSERT INTO `state` VALUES (2960, 180, 'Ilfov', NULL, NULL);
INSERT INTO `state` VALUES (2961, 180, 'Maramures', NULL, NULL);
INSERT INTO `state` VALUES (2962, 180, 'Mehedinti', NULL, NULL);
INSERT INTO `state` VALUES (2963, 180, 'Mures', NULL, NULL);
INSERT INTO `state` VALUES (2964, 180, 'Neamt', NULL, NULL);
INSERT INTO `state` VALUES (2965, 180, 'Olt', NULL, NULL);
INSERT INTO `state` VALUES (2966, 180, 'Prahova', NULL, NULL);
INSERT INTO `state` VALUES (2967, 180, 'Salaj', NULL, NULL);
INSERT INTO `state` VALUES (2968, 180, 'Satu Mare', NULL, NULL);
INSERT INTO `state` VALUES (2969, 180, 'Sibiu', NULL, NULL);
INSERT INTO `state` VALUES (2970, 180, 'Sondelor', NULL, NULL);
INSERT INTO `state` VALUES (2971, 180, 'Suceava', NULL, NULL);
INSERT INTO `state` VALUES (2972, 180, 'Teleorman', NULL, NULL);
INSERT INTO `state` VALUES (2973, 180, 'Timis', NULL, NULL);
INSERT INTO `state` VALUES (2974, 180, 'Tulcea', NULL, NULL);
INSERT INTO `state` VALUES (2975, 180, 'Valcea', NULL, NULL);
INSERT INTO `state` VALUES (2976, 180, 'Vaslui', NULL, NULL);
INSERT INTO `state` VALUES (2977, 180, 'Vrancea', NULL, NULL);
INSERT INTO `state` VALUES (2978, 181, 'Adygeja', NULL, NULL);
INSERT INTO `state` VALUES (2979, 181, 'Aga', NULL, NULL);
INSERT INTO `state` VALUES (2980, 181, 'Alanija', NULL, NULL);
INSERT INTO `state` VALUES (2981, 181, 'Altaj', NULL, NULL);
INSERT INTO `state` VALUES (2982, 181, 'Amur', NULL, NULL);
INSERT INTO `state` VALUES (2983, 181, 'Arhangelsk', NULL, NULL);
INSERT INTO `state` VALUES (2984, 181, 'Astrahan', NULL, NULL);
INSERT INTO `state` VALUES (2985, 181, 'Bashkortostan', NULL, NULL);
INSERT INTO `state` VALUES (2986, 181, 'Belgorod', NULL, NULL);
INSERT INTO `state` VALUES (2987, 181, 'Brjansk', NULL, NULL);
INSERT INTO `state` VALUES (2988, 181, 'Burjatija', NULL, NULL);
INSERT INTO `state` VALUES (2989, 181, 'Chechenija', NULL, NULL);
INSERT INTO `state` VALUES (2990, 181, 'Cheljabinsk', NULL, NULL);
INSERT INTO `state` VALUES (2991, 181, 'Chita', NULL, NULL);
INSERT INTO `state` VALUES (2992, 181, 'Chukotka', NULL, NULL);
INSERT INTO `state` VALUES (2993, 181, 'Chuvashija', NULL, NULL);
INSERT INTO `state` VALUES (2994, 181, 'Dagestan', NULL, NULL);
INSERT INTO `state` VALUES (2995, 181, 'Evenkija', NULL, NULL);
INSERT INTO `state` VALUES (2996, 181, 'Gorno-Altaj', NULL, NULL);
INSERT INTO `state` VALUES (2997, 181, 'Habarovsk', NULL, NULL);
INSERT INTO `state` VALUES (2998, 181, 'Hakasija', NULL, NULL);
INSERT INTO `state` VALUES (2999, 181, 'Hanty-Mansija', NULL, NULL);
INSERT INTO `state` VALUES (3000, 181, 'Ingusetija', NULL, NULL);
INSERT INTO `state` VALUES (3001, 181, 'Irkutsk', NULL, NULL);
INSERT INTO `state` VALUES (3002, 181, 'Ivanovo', NULL, NULL);
INSERT INTO `state` VALUES (3003, 181, 'Jamalo-Nenets', NULL, NULL);
INSERT INTO `state` VALUES (3004, 181, 'Jaroslavl', NULL, NULL);
INSERT INTO `state` VALUES (3005, 181, 'Jevrej', NULL, NULL);
INSERT INTO `state` VALUES (3006, 181, 'Kabardino-Balkarija', NULL, NULL);
INSERT INTO `state` VALUES (3007, 181, 'Kaliningrad', NULL, NULL);
INSERT INTO `state` VALUES (3008, 181, 'Kalmykija', NULL, NULL);
INSERT INTO `state` VALUES (3009, 181, 'Kaluga', NULL, NULL);
INSERT INTO `state` VALUES (3010, 181, 'Kamchatka', NULL, NULL);
INSERT INTO `state` VALUES (3011, 181, 'Karachaj-Cherkessija', NULL, NULL);
INSERT INTO `state` VALUES (3012, 181, 'Karelija', NULL, NULL);
INSERT INTO `state` VALUES (3013, 181, 'Kemerovo', NULL, NULL);
INSERT INTO `state` VALUES (3014, 181, 'Khabarovskiy Kray', NULL, NULL);
INSERT INTO `state` VALUES (3015, 181, 'Kirov', NULL, NULL);
INSERT INTO `state` VALUES (3016, 181, 'Komi', NULL, NULL);
INSERT INTO `state` VALUES (3017, 181, 'Komi-Permjakija', NULL, NULL);
INSERT INTO `state` VALUES (3018, 181, 'Korjakija', NULL, NULL);
INSERT INTO `state` VALUES (3019, 181, 'Kostroma', NULL, NULL);
INSERT INTO `state` VALUES (3020, 181, 'Krasnodar', NULL, NULL);
INSERT INTO `state` VALUES (3021, 181, 'Krasnojarsk', NULL, NULL);
INSERT INTO `state` VALUES (3022, 181, 'Krasnoyarskiy Kray', NULL, NULL);
INSERT INTO `state` VALUES (3023, 181, 'Kurgan', NULL, NULL);
INSERT INTO `state` VALUES (3024, 181, 'Kursk', NULL, NULL);
INSERT INTO `state` VALUES (3025, 181, 'Leningrad', NULL, NULL);
INSERT INTO `state` VALUES (3026, 181, 'Lipeck', NULL, NULL);
INSERT INTO `state` VALUES (3027, 181, 'Magadan', NULL, NULL);
INSERT INTO `state` VALUES (3028, 181, 'Marij El', NULL, NULL);
INSERT INTO `state` VALUES (3029, 181, 'Mordovija', NULL, NULL);
INSERT INTO `state` VALUES (3030, 181, 'Moscow', NULL, NULL);
INSERT INTO `state` VALUES (3031, 181, 'Moskovskaja Oblast', NULL, NULL);
INSERT INTO `state` VALUES (3032, 181, 'Moskovskaya Oblast', NULL, NULL);
INSERT INTO `state` VALUES (3033, 181, 'Moskva', NULL, NULL);
INSERT INTO `state` VALUES (3034, 181, 'Murmansk', NULL, NULL);
INSERT INTO `state` VALUES (3035, 181, 'Nenets', NULL, NULL);
INSERT INTO `state` VALUES (3036, 181, 'Nizhnij Novgorod', NULL, NULL);
INSERT INTO `state` VALUES (3037, 181, 'Novgorod', NULL, NULL);
INSERT INTO `state` VALUES (3038, 181, 'Novokusnezk', NULL, NULL);
INSERT INTO `state` VALUES (3039, 181, 'Novosibirsk', NULL, NULL);
INSERT INTO `state` VALUES (3040, 181, 'Omsk', NULL, NULL);
INSERT INTO `state` VALUES (3041, 181, 'Orenburg', NULL, NULL);
INSERT INTO `state` VALUES (3042, 181, 'Orjol', NULL, NULL);
INSERT INTO `state` VALUES (3043, 181, 'Penza', NULL, NULL);
INSERT INTO `state` VALUES (3044, 181, 'Perm', NULL, NULL);
INSERT INTO `state` VALUES (3045, 181, 'Primorje', NULL, NULL);
INSERT INTO `state` VALUES (3046, 181, 'Pskov', NULL, NULL);
INSERT INTO `state` VALUES (3047, 181, 'Pskovskaya Oblast', NULL, NULL);
INSERT INTO `state` VALUES (3048, 181, 'Rjazan', NULL, NULL);
INSERT INTO `state` VALUES (3049, 181, 'Rostov', NULL, NULL);
INSERT INTO `state` VALUES (3050, 181, 'Saha', NULL, NULL);
INSERT INTO `state` VALUES (3051, 181, 'Sahalin', NULL, NULL);
INSERT INTO `state` VALUES (3052, 181, 'Samara', NULL, NULL);
INSERT INTO `state` VALUES (3053, 181, 'Samarskaya', NULL, NULL);
INSERT INTO `state` VALUES (3054, 181, 'Sankt-Peterburg', NULL, NULL);
INSERT INTO `state` VALUES (3055, 181, 'Saratov', NULL, NULL);
INSERT INTO `state` VALUES (3056, 181, 'Smolensk', NULL, NULL);
INSERT INTO `state` VALUES (3057, 181, 'Stavropol', NULL, NULL);
INSERT INTO `state` VALUES (3058, 181, 'Sverdlovsk', NULL, NULL);
INSERT INTO `state` VALUES (3059, 181, 'Tajmyrija', NULL, NULL);
INSERT INTO `state` VALUES (3060, 181, 'Tambov', NULL, NULL);
INSERT INTO `state` VALUES (3061, 181, 'Tatarstan', NULL, NULL);
INSERT INTO `state` VALUES (3062, 181, 'Tjumen', NULL, NULL);
INSERT INTO `state` VALUES (3063, 181, 'Tomsk', NULL, NULL);
INSERT INTO `state` VALUES (3064, 181, 'Tula', NULL, NULL);
INSERT INTO `state` VALUES (3065, 181, 'Tver', NULL, NULL);
INSERT INTO `state` VALUES (3066, 181, 'Tyva', NULL, NULL);
INSERT INTO `state` VALUES (3067, 181, 'Udmurtija', NULL, NULL);
INSERT INTO `state` VALUES (3068, 181, 'Uljanovsk', NULL, NULL);
INSERT INTO `state` VALUES (3069, 181, 'Ulyanovskaya Oblast', NULL, NULL);
INSERT INTO `state` VALUES (3070, 181, 'Ust-Orda', NULL, NULL);
INSERT INTO `state` VALUES (3071, 181, 'Vladimir', NULL, NULL);
INSERT INTO `state` VALUES (3072, 181, 'Volgograd', NULL, NULL);
INSERT INTO `state` VALUES (3073, 181, 'Vologda', NULL, NULL);
INSERT INTO `state` VALUES (3074, 181, 'Voronezh', NULL, NULL);
INSERT INTO `state` VALUES (3075, 182, 'Butare', NULL, NULL);
INSERT INTO `state` VALUES (3076, 182, 'Byumba', NULL, NULL);
INSERT INTO `state` VALUES (3077, 182, 'Cyangugu', NULL, NULL);
INSERT INTO `state` VALUES (3078, 182, 'Gikongoro', NULL, NULL);
INSERT INTO `state` VALUES (3079, 182, 'Gisenyi', NULL, NULL);
INSERT INTO `state` VALUES (3080, 182, 'Gitarama', NULL, NULL);
INSERT INTO `state` VALUES (3081, 182, 'Kibungo', NULL, NULL);
INSERT INTO `state` VALUES (3082, 182, 'Kibuye', NULL, NULL);
INSERT INTO `state` VALUES (3083, 182, 'Kigali-ngali', NULL, NULL);
INSERT INTO `state` VALUES (3084, 182, 'Ruhengeri', NULL, NULL);
INSERT INTO `state` VALUES (3085, 183, 'Ascension', NULL, NULL);
INSERT INTO `state` VALUES (3086, 183, 'Gough Island', NULL, NULL);
INSERT INTO `state` VALUES (3087, 183, 'Saint Helena', NULL, NULL);
INSERT INTO `state` VALUES (3088, 183, 'Tristan da Cunha', NULL, NULL);
INSERT INTO `state` VALUES (3089, 184, 'Christ Church Nichola Town', NULL, NULL);
INSERT INTO `state` VALUES (3090, 184, 'Saint Anne Sandy Point', NULL, NULL);
INSERT INTO `state` VALUES (3091, 184, 'Saint George Basseterre', NULL, NULL);
INSERT INTO `state` VALUES (3092, 184, 'Saint George Gingerland', NULL, NULL);
INSERT INTO `state` VALUES (3093, 184, 'Saint James Windward', NULL, NULL);
INSERT INTO `state` VALUES (3094, 184, 'Saint John Capesterre', NULL, NULL);
INSERT INTO `state` VALUES (3095, 184, 'Saint John Figtree', NULL, NULL);
INSERT INTO `state` VALUES (3096, 184, 'Saint Mary Cayon', NULL, NULL);
INSERT INTO `state` VALUES (3097, 184, 'Saint Paul Capesterre', NULL, NULL);
INSERT INTO `state` VALUES (3098, 184, 'Saint Paul Charlestown', NULL, NULL);
INSERT INTO `state` VALUES (3099, 184, 'Saint Peter Basseterre', NULL, NULL);
INSERT INTO `state` VALUES (3100, 184, 'Saint Thomas Lowland', NULL, NULL);
INSERT INTO `state` VALUES (3101, 184, 'Saint Thomas Middle Island', NULL, NULL);
INSERT INTO `state` VALUES (3102, 184, 'Trinity Palmetto Point', NULL, NULL);
INSERT INTO `state` VALUES (3103, 185, 'Anse-la-Raye', NULL, NULL);
INSERT INTO `state` VALUES (3104, 185, 'Canaries', NULL, NULL);
INSERT INTO `state` VALUES (3105, 185, 'Castries', NULL, NULL);
INSERT INTO `state` VALUES (3106, 185, 'Choiseul', NULL, NULL);
INSERT INTO `state` VALUES (3107, 185, 'Dennery', NULL, NULL);
INSERT INTO `state` VALUES (3108, 185, 'Gros Inlet', NULL, NULL);
INSERT INTO `state` VALUES (3109, 185, 'Laborie', NULL, NULL);
INSERT INTO `state` VALUES (3110, 185, 'Micoud', NULL, NULL);
INSERT INTO `state` VALUES (3111, 185, 'Soufriere', NULL, NULL);
INSERT INTO `state` VALUES (3112, 185, 'Vieux Fort', NULL, NULL);
INSERT INTO `state` VALUES (3113, 186, 'Miquelon-Langlade', NULL, NULL);
INSERT INTO `state` VALUES (3114, 186, 'Saint-Pierre', NULL, NULL);
INSERT INTO `state` VALUES (3115, 187, 'Charlotte', NULL, NULL);
INSERT INTO `state` VALUES (3116, 187, 'Grenadines', NULL, NULL);
INSERT INTO `state` VALUES (3117, 187, 'Saint Andrew', NULL, NULL);
INSERT INTO `state` VALUES (3118, 187, 'Saint David', NULL, NULL);
INSERT INTO `state` VALUES (3119, 187, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (3120, 187, 'Saint Patrick', NULL, NULL);
INSERT INTO `state` VALUES (3121, 188, 'A\'ana', NULL, NULL);
INSERT INTO `state` VALUES (3122, 188, 'Aiga-i-le-Tai', NULL, NULL);
INSERT INTO `state` VALUES (3123, 188, 'Atua', NULL, NULL);
INSERT INTO `state` VALUES (3124, 188, 'Fa\'asaleleaga', NULL, NULL);
INSERT INTO `state` VALUES (3125, 188, 'Gaga\'emauga', NULL, NULL);
INSERT INTO `state` VALUES (3126, 188, 'Gagaifomauga', NULL, NULL);
INSERT INTO `state` VALUES (3127, 188, 'Palauli', NULL, NULL);
INSERT INTO `state` VALUES (3128, 188, 'Satupa\'itea', NULL, NULL);
INSERT INTO `state` VALUES (3129, 188, 'Tuamasaga', NULL, NULL);
INSERT INTO `state` VALUES (3130, 188, 'Va\'a-o-Fonoti', NULL, NULL);
INSERT INTO `state` VALUES (3131, 188, 'Vaisigano', NULL, NULL);
INSERT INTO `state` VALUES (3132, 189, 'Acquaviva', NULL, NULL);
INSERT INTO `state` VALUES (3133, 189, 'Borgo Maggiore', NULL, NULL);
INSERT INTO `state` VALUES (3134, 189, 'Chiesanuova', NULL, NULL);
INSERT INTO `state` VALUES (3135, 189, 'Domagnano', NULL, NULL);
INSERT INTO `state` VALUES (3136, 189, 'Faetano', NULL, NULL);
INSERT INTO `state` VALUES (3137, 189, 'Fiorentino', NULL, NULL);
INSERT INTO `state` VALUES (3138, 189, 'Montegiardino', NULL, NULL);
INSERT INTO `state` VALUES (3139, 189, 'San Marino', NULL, NULL);
INSERT INTO `state` VALUES (3140, 189, 'Serravalle', NULL, NULL);
INSERT INTO `state` VALUES (3141, 190, 'Agua Grande', NULL, NULL);
INSERT INTO `state` VALUES (3142, 190, 'Cantagalo', NULL, NULL);
INSERT INTO `state` VALUES (3143, 190, 'Lemba', NULL, NULL);
INSERT INTO `state` VALUES (3144, 190, 'Lobata', NULL, NULL);
INSERT INTO `state` VALUES (3145, 190, 'Me-Zochi', NULL, NULL);
INSERT INTO `state` VALUES (3146, 190, 'Pague', NULL, NULL);
INSERT INTO `state` VALUES (3147, 191, 'Al Khobar', NULL, NULL);
INSERT INTO `state` VALUES (3148, 191, 'Aseer', NULL, NULL);
INSERT INTO `state` VALUES (3149, 191, 'Ash Sharqiyah', NULL, NULL);
INSERT INTO `state` VALUES (3150, 191, 'Asir', NULL, NULL);
INSERT INTO `state` VALUES (3151, 191, 'Central Province', NULL, NULL);
INSERT INTO `state` VALUES (3152, 191, 'Eastern Province', NULL, NULL);
INSERT INTO `state` VALUES (3153, 191, 'Ha\'il', NULL, NULL);
INSERT INTO `state` VALUES (3154, 191, 'Jawf', NULL, NULL);
INSERT INTO `state` VALUES (3155, 191, 'Jizan', NULL, NULL);
INSERT INTO `state` VALUES (3156, 191, 'Makkah', NULL, NULL);
INSERT INTO `state` VALUES (3157, 191, 'Najran', NULL, NULL);
INSERT INTO `state` VALUES (3158, 191, 'Qasim', NULL, NULL);
INSERT INTO `state` VALUES (3159, 191, 'Tabuk', NULL, NULL);
INSERT INTO `state` VALUES (3160, 191, 'Western Province', NULL, NULL);
INSERT INTO `state` VALUES (3161, 191, 'al-Bahah', NULL, NULL);
INSERT INTO `state` VALUES (3162, 191, 'al-Hudud-ash-Shamaliyah', NULL, NULL);
INSERT INTO `state` VALUES (3163, 191, 'al-Madinah', NULL, NULL);
INSERT INTO `state` VALUES (3164, 191, 'ar-Riyad', NULL, NULL);
INSERT INTO `state` VALUES (3165, 192, 'Dakar', NULL, NULL);
INSERT INTO `state` VALUES (3166, 192, 'Diourbel', NULL, NULL);
INSERT INTO `state` VALUES (3167, 192, 'Fatick', NULL, NULL);
INSERT INTO `state` VALUES (3168, 192, 'Kaolack', NULL, NULL);
INSERT INTO `state` VALUES (3169, 192, 'Kolda', NULL, NULL);
INSERT INTO `state` VALUES (3170, 192, 'Louga', NULL, NULL);
INSERT INTO `state` VALUES (3171, 192, 'Saint-Louis', NULL, NULL);
INSERT INTO `state` VALUES (3172, 192, 'Tambacounda', NULL, NULL);
INSERT INTO `state` VALUES (3173, 192, 'Thies', NULL, NULL);
INSERT INTO `state` VALUES (3174, 192, 'Ziguinchor', NULL, NULL);
INSERT INTO `state` VALUES (3175, 193, 'Central Serbia', NULL, NULL);
INSERT INTO `state` VALUES (3176, 193, 'Kosovo and Metohija', NULL, NULL);
INSERT INTO `state` VALUES (3177, 193, 'Vojvodina', NULL, NULL);
INSERT INTO `state` VALUES (3178, 194, 'Anse Boileau', NULL, NULL);
INSERT INTO `state` VALUES (3179, 194, 'Anse Royale', NULL, NULL);
INSERT INTO `state` VALUES (3180, 194, 'Cascade', NULL, NULL);
INSERT INTO `state` VALUES (3181, 194, 'Takamaka', NULL, NULL);
INSERT INTO `state` VALUES (3182, 194, 'Victoria', NULL, NULL);
INSERT INTO `state` VALUES (3183, 195, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (3184, 195, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (3185, 195, 'Southern', NULL, NULL);
INSERT INTO `state` VALUES (3186, 195, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (3187, 196, 'Singapore', NULL, NULL);
INSERT INTO `state` VALUES (3188, 197, 'Banskobystricky', NULL, NULL);
INSERT INTO `state` VALUES (3189, 197, 'Bratislavsky', NULL, NULL);
INSERT INTO `state` VALUES (3190, 197, 'Kosicky', NULL, NULL);
INSERT INTO `state` VALUES (3191, 197, 'Nitriansky', NULL, NULL);
INSERT INTO `state` VALUES (3192, 197, 'Presovsky', NULL, NULL);
INSERT INTO `state` VALUES (3193, 197, 'Trenciansky', NULL, NULL);
INSERT INTO `state` VALUES (3194, 197, 'Trnavsky', NULL, NULL);
INSERT INTO `state` VALUES (3195, 197, 'Zilinsky', NULL, NULL);
INSERT INTO `state` VALUES (3196, 198, 'Benedikt', NULL, NULL);
INSERT INTO `state` VALUES (3197, 198, 'Gorenjska', NULL, NULL);
INSERT INTO `state` VALUES (3198, 198, 'Gorishka', NULL, NULL);
INSERT INTO `state` VALUES (3199, 198, 'Jugovzhodna Slovenija', NULL, NULL);
INSERT INTO `state` VALUES (3200, 198, 'Koroshka', NULL, NULL);
INSERT INTO `state` VALUES (3201, 198, 'Notranjsko-krashka', NULL, NULL);
INSERT INTO `state` VALUES (3202, 198, 'Obalno-krashka', NULL, NULL);
INSERT INTO `state` VALUES (3203, 198, 'Obcina Domzale', NULL, NULL);
INSERT INTO `state` VALUES (3204, 198, 'Obcina Vitanje', NULL, NULL);
INSERT INTO `state` VALUES (3205, 198, 'Osrednjeslovenska', NULL, NULL);
INSERT INTO `state` VALUES (3206, 198, 'Podravska', NULL, NULL);
INSERT INTO `state` VALUES (3207, 198, 'Pomurska', NULL, NULL);
INSERT INTO `state` VALUES (3208, 198, 'Savinjska', NULL, NULL);
INSERT INTO `state` VALUES (3209, 198, 'Slovenian Littoral', NULL, NULL);
INSERT INTO `state` VALUES (3210, 198, 'Spodnjeposavska', NULL, NULL);
INSERT INTO `state` VALUES (3211, 198, 'Zasavska', NULL, NULL);
INSERT INTO `state` VALUES (3212, 199, 'Pitcairn', NULL, NULL);
INSERT INTO `state` VALUES (3213, 200, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (3214, 200, 'Choiseul', NULL, NULL);
INSERT INTO `state` VALUES (3215, 200, 'Guadalcanal', NULL, NULL);
INSERT INTO `state` VALUES (3216, 200, 'Isabel', NULL, NULL);
INSERT INTO `state` VALUES (3217, 200, 'Makira and Ulawa', NULL, NULL);
INSERT INTO `state` VALUES (3218, 200, 'Malaita', NULL, NULL);
INSERT INTO `state` VALUES (3219, 200, 'Rennell and Bellona', NULL, NULL);
INSERT INTO `state` VALUES (3220, 200, 'Temotu', NULL, NULL);
INSERT INTO `state` VALUES (3221, 200, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (3222, 201, 'Awdal', NULL, NULL);
INSERT INTO `state` VALUES (3223, 201, 'Bakol', NULL, NULL);
INSERT INTO `state` VALUES (3224, 201, 'Banadir', NULL, NULL);
INSERT INTO `state` VALUES (3225, 201, 'Bari', NULL, NULL);
INSERT INTO `state` VALUES (3226, 201, 'Bay', NULL, NULL);
INSERT INTO `state` VALUES (3227, 201, 'Galgudug', NULL, NULL);
INSERT INTO `state` VALUES (3228, 201, 'Gedo', NULL, NULL);
INSERT INTO `state` VALUES (3229, 201, 'Hiran', NULL, NULL);
INSERT INTO `state` VALUES (3230, 201, 'Jubbada Hose', NULL, NULL);
INSERT INTO `state` VALUES (3231, 201, 'Jubbadha Dexe', NULL, NULL);
INSERT INTO `state` VALUES (3232, 201, 'Mudug', NULL, NULL);
INSERT INTO `state` VALUES (3233, 201, 'Nugal', NULL, NULL);
INSERT INTO `state` VALUES (3234, 201, 'Sanag', NULL, NULL);
INSERT INTO `state` VALUES (3235, 201, 'Shabellaha Dhexe', NULL, NULL);
INSERT INTO `state` VALUES (3236, 201, 'Shabellaha Hose', NULL, NULL);
INSERT INTO `state` VALUES (3237, 201, 'Togdher', NULL, NULL);
INSERT INTO `state` VALUES (3238, 201, 'Woqoyi Galbed', NULL, NULL);
INSERT INTO `state` VALUES (3239, 202, 'Eastern Cape', NULL, NULL);
INSERT INTO `state` VALUES (3240, 202, 'Free State', NULL, NULL);
INSERT INTO `state` VALUES (3241, 202, 'Gauteng', NULL, NULL);
INSERT INTO `state` VALUES (3242, 202, 'Kempton Park', NULL, NULL);
INSERT INTO `state` VALUES (3243, 202, 'Kramerville', NULL, NULL);
INSERT INTO `state` VALUES (3244, 202, 'KwaZulu Natal', NULL, NULL);
INSERT INTO `state` VALUES (3245, 202, 'Limpopo', NULL, NULL);
INSERT INTO `state` VALUES (3246, 202, 'Mpumalanga', NULL, NULL);
INSERT INTO `state` VALUES (3247, 202, 'North West', NULL, NULL);
INSERT INTO `state` VALUES (3248, 202, 'Northern Cape', NULL, NULL);
INSERT INTO `state` VALUES (3249, 202, 'Parow', NULL, NULL);
INSERT INTO `state` VALUES (3250, 202, 'Table View', NULL, NULL);
INSERT INTO `state` VALUES (3251, 202, 'Umtentweni', NULL, NULL);
INSERT INTO `state` VALUES (3252, 202, 'Western Cape', NULL, NULL);
INSERT INTO `state` VALUES (3253, 203, 'South Georgia', NULL, NULL);
INSERT INTO `state` VALUES (3254, 204, 'Central Equatoria', NULL, NULL);
INSERT INTO `state` VALUES (3255, 205, 'A Coruna', NULL, NULL);
INSERT INTO `state` VALUES (3256, 205, 'Alacant', NULL, NULL);
INSERT INTO `state` VALUES (3257, 205, 'Alava', NULL, NULL);
INSERT INTO `state` VALUES (3258, 205, 'Albacete', NULL, NULL);
INSERT INTO `state` VALUES (3259, 205, 'Almeria', NULL, NULL);
INSERT INTO `state` VALUES (3260, 205, 'Andalucia', NULL, NULL);
INSERT INTO `state` VALUES (3261, 205, 'Asturias', NULL, NULL);
INSERT INTO `state` VALUES (3262, 205, 'Avila', NULL, NULL);
INSERT INTO `state` VALUES (3263, 205, 'Badajoz', NULL, NULL);
INSERT INTO `state` VALUES (3264, 205, 'Balears', NULL, NULL);
INSERT INTO `state` VALUES (3265, 205, 'Barcelona', NULL, NULL);
INSERT INTO `state` VALUES (3266, 205, 'Bertamirans', NULL, NULL);
INSERT INTO `state` VALUES (3267, 205, 'Biscay', NULL, NULL);
INSERT INTO `state` VALUES (3268, 205, 'Burgos', NULL, NULL);
INSERT INTO `state` VALUES (3269, 205, 'Caceres', NULL, NULL);
INSERT INTO `state` VALUES (3270, 205, 'Cadiz', NULL, NULL);
INSERT INTO `state` VALUES (3271, 205, 'Cantabria', NULL, NULL);
INSERT INTO `state` VALUES (3272, 205, 'Castello', NULL, NULL);
INSERT INTO `state` VALUES (3273, 205, 'Catalunya', NULL, NULL);
INSERT INTO `state` VALUES (3274, 205, 'Ceuta', NULL, NULL);
INSERT INTO `state` VALUES (3275, 205, 'Ciudad Real', NULL, NULL);
INSERT INTO `state` VALUES (3276, 205, 'Comunidad Autonoma de Canarias', NULL, NULL);
INSERT INTO `state` VALUES (3277, 205, 'Comunidad Autonoma de Cataluna', NULL, NULL);
INSERT INTO `state` VALUES (3278, 205, 'Comunidad Autonoma de Galicia', NULL, NULL);
INSERT INTO `state` VALUES (3279, 205, 'Comunidad Autonoma de las Isla', NULL, NULL);
INSERT INTO `state` VALUES (3280, 205, 'Comunidad Autonoma del Princip', NULL, NULL);
INSERT INTO `state` VALUES (3281, 205, 'Comunidad Valenciana', NULL, NULL);
INSERT INTO `state` VALUES (3282, 205, 'Cordoba', NULL, NULL);
INSERT INTO `state` VALUES (3283, 205, 'Cuenca', NULL, NULL);
INSERT INTO `state` VALUES (3284, 205, 'Gipuzkoa', NULL, NULL);
INSERT INTO `state` VALUES (3285, 205, 'Girona', NULL, NULL);
INSERT INTO `state` VALUES (3286, 205, 'Granada', NULL, NULL);
INSERT INTO `state` VALUES (3287, 205, 'Guadalajara', NULL, NULL);
INSERT INTO `state` VALUES (3288, 205, 'Guipuzcoa', NULL, NULL);
INSERT INTO `state` VALUES (3289, 205, 'Huelva', NULL, NULL);
INSERT INTO `state` VALUES (3290, 205, 'Huesca', NULL, NULL);
INSERT INTO `state` VALUES (3291, 205, 'Jaen', NULL, NULL);
INSERT INTO `state` VALUES (3292, 205, 'La Rioja', NULL, NULL);
INSERT INTO `state` VALUES (3293, 205, 'Las Palmas', NULL, NULL);
INSERT INTO `state` VALUES (3294, 205, 'Leon', NULL, NULL);
INSERT INTO `state` VALUES (3295, 205, 'Lerida', NULL, NULL);
INSERT INTO `state` VALUES (3296, 205, 'Lleida', NULL, NULL);
INSERT INTO `state` VALUES (3297, 205, 'Lugo', NULL, NULL);
INSERT INTO `state` VALUES (3298, 205, 'Madrid', NULL, NULL);
INSERT INTO `state` VALUES (3299, 205, 'Malaga', NULL, NULL);
INSERT INTO `state` VALUES (3300, 205, 'Melilla', NULL, NULL);
INSERT INTO `state` VALUES (3301, 205, 'Murcia', NULL, NULL);
INSERT INTO `state` VALUES (3302, 205, 'Navarra', NULL, NULL);
INSERT INTO `state` VALUES (3303, 205, 'Ourense', NULL, NULL);
INSERT INTO `state` VALUES (3304, 205, 'Pais Vasco', NULL, NULL);
INSERT INTO `state` VALUES (3305, 205, 'Palencia', NULL, NULL);
INSERT INTO `state` VALUES (3306, 205, 'Pontevedra', NULL, NULL);
INSERT INTO `state` VALUES (3307, 205, 'Salamanca', NULL, NULL);
INSERT INTO `state` VALUES (3308, 205, 'Santa Cruz de Tenerife', NULL, NULL);
INSERT INTO `state` VALUES (3309, 205, 'Segovia', NULL, NULL);
INSERT INTO `state` VALUES (3310, 205, 'Sevilla', NULL, NULL);
INSERT INTO `state` VALUES (3311, 205, 'Soria', NULL, NULL);
INSERT INTO `state` VALUES (3312, 205, 'Tarragona', NULL, NULL);
INSERT INTO `state` VALUES (3313, 205, 'Tenerife', NULL, NULL);
INSERT INTO `state` VALUES (3314, 205, 'Teruel', NULL, NULL);
INSERT INTO `state` VALUES (3315, 205, 'Toledo', NULL, NULL);
INSERT INTO `state` VALUES (3316, 205, 'Valencia', NULL, NULL);
INSERT INTO `state` VALUES (3317, 205, 'Valladolid', NULL, NULL);
INSERT INTO `state` VALUES (3318, 205, 'Vizcaya', NULL, NULL);
INSERT INTO `state` VALUES (3319, 205, 'Zamora', NULL, NULL);
INSERT INTO `state` VALUES (3320, 205, 'Zaragoza', NULL, NULL);
INSERT INTO `state` VALUES (3321, 206, 'Amparai', NULL, NULL);
INSERT INTO `state` VALUES (3322, 206, 'Anuradhapuraya', NULL, NULL);
INSERT INTO `state` VALUES (3323, 206, 'Badulla', NULL, NULL);
INSERT INTO `state` VALUES (3324, 206, 'Boralesgamuwa', NULL, NULL);
INSERT INTO `state` VALUES (3325, 206, 'Colombo', NULL, NULL);
INSERT INTO `state` VALUES (3326, 206, 'Galla', NULL, NULL);
INSERT INTO `state` VALUES (3327, 206, 'Gampaha', NULL, NULL);
INSERT INTO `state` VALUES (3328, 206, 'Hambantota', NULL, NULL);
INSERT INTO `state` VALUES (3329, 206, 'Kalatura', NULL, NULL);
INSERT INTO `state` VALUES (3330, 206, 'Kegalla', NULL, NULL);
INSERT INTO `state` VALUES (3331, 206, 'Kilinochchi', NULL, NULL);
INSERT INTO `state` VALUES (3332, 206, 'Kurunegala', NULL, NULL);
INSERT INTO `state` VALUES (3333, 206, 'Madakalpuwa', NULL, NULL);
INSERT INTO `state` VALUES (3334, 206, 'Maha Nuwara', NULL, NULL);
INSERT INTO `state` VALUES (3335, 206, 'Malwana', NULL, NULL);
INSERT INTO `state` VALUES (3336, 206, 'Mannarama', NULL, NULL);
INSERT INTO `state` VALUES (3337, 206, 'Matale', NULL, NULL);
INSERT INTO `state` VALUES (3338, 206, 'Matara', NULL, NULL);
INSERT INTO `state` VALUES (3339, 206, 'Monaragala', NULL, NULL);
INSERT INTO `state` VALUES (3340, 206, 'Mullaitivu', NULL, NULL);
INSERT INTO `state` VALUES (3341, 206, 'North Eastern Province', NULL, NULL);
INSERT INTO `state` VALUES (3342, 206, 'North Western Province', NULL, NULL);
INSERT INTO `state` VALUES (3343, 206, 'Nuwara Eliya', NULL, NULL);
INSERT INTO `state` VALUES (3344, 206, 'Polonnaruwa', NULL, NULL);
INSERT INTO `state` VALUES (3345, 206, 'Puttalama', NULL, NULL);
INSERT INTO `state` VALUES (3346, 206, 'Ratnapuraya', NULL, NULL);
INSERT INTO `state` VALUES (3347, 206, 'Southern Province', NULL, NULL);
INSERT INTO `state` VALUES (3348, 206, 'Tirikunamalaya', NULL, NULL);
INSERT INTO `state` VALUES (3349, 206, 'Tuscany', NULL, NULL);
INSERT INTO `state` VALUES (3350, 206, 'Vavuniyawa', NULL, NULL);
INSERT INTO `state` VALUES (3351, 206, 'Western Province', NULL, NULL);
INSERT INTO `state` VALUES (3352, 206, 'Yapanaya', NULL, NULL);
INSERT INTO `state` VALUES (3353, 206, 'kadawatha', NULL, NULL);
INSERT INTO `state` VALUES (3354, 207, 'A\'ali-an-Nil', NULL, NULL);
INSERT INTO `state` VALUES (3355, 207, 'Bahr-al-Jabal', NULL, NULL);
INSERT INTO `state` VALUES (3356, 207, 'Central Equatoria', NULL, NULL);
INSERT INTO `state` VALUES (3357, 207, 'Gharb Bahr-al-Ghazal', NULL, NULL);
INSERT INTO `state` VALUES (3358, 207, 'Gharb Darfur', NULL, NULL);
INSERT INTO `state` VALUES (3359, 207, 'Gharb Kurdufan', NULL, NULL);
INSERT INTO `state` VALUES (3360, 207, 'Gharb-al-Istiwa\'iyah', NULL, NULL);
INSERT INTO `state` VALUES (3361, 207, 'Janub Darfur', NULL, NULL);
INSERT INTO `state` VALUES (3362, 207, 'Janub Kurdufan', NULL, NULL);
INSERT INTO `state` VALUES (3363, 207, 'Junqali', NULL, NULL);
INSERT INTO `state` VALUES (3364, 207, 'Kassala', NULL, NULL);
INSERT INTO `state` VALUES (3365, 207, 'Nahr-an-Nil', NULL, NULL);
INSERT INTO `state` VALUES (3366, 207, 'Shamal Bahr-al-Ghazal', NULL, NULL);
INSERT INTO `state` VALUES (3367, 207, 'Shamal Darfur', NULL, NULL);
INSERT INTO `state` VALUES (3368, 207, 'Shamal Kurdufan', NULL, NULL);
INSERT INTO `state` VALUES (3369, 207, 'Sharq-al-Istiwa\'iyah', NULL, NULL);
INSERT INTO `state` VALUES (3370, 207, 'Sinnar', NULL, NULL);
INSERT INTO `state` VALUES (3371, 207, 'Warab', NULL, NULL);
INSERT INTO `state` VALUES (3372, 207, 'Wilayat al Khartum', NULL, NULL);
INSERT INTO `state` VALUES (3373, 207, 'al-Bahr-al-Ahmar', NULL, NULL);
INSERT INTO `state` VALUES (3374, 207, 'al-Buhayrat', NULL, NULL);
INSERT INTO `state` VALUES (3375, 207, 'al-Jazirah', NULL, NULL);
INSERT INTO `state` VALUES (3376, 207, 'al-Khartum', NULL, NULL);
INSERT INTO `state` VALUES (3377, 207, 'al-Qadarif', NULL, NULL);
INSERT INTO `state` VALUES (3378, 207, 'al-Wahdah', NULL, NULL);
INSERT INTO `state` VALUES (3379, 207, 'an-Nil-al-Abyad', NULL, NULL);
INSERT INTO `state` VALUES (3380, 207, 'an-Nil-al-Azraq', NULL, NULL);
INSERT INTO `state` VALUES (3381, 207, 'ash-Shamaliyah', NULL, NULL);
INSERT INTO `state` VALUES (3382, 208, 'Brokopondo', NULL, NULL);
INSERT INTO `state` VALUES (3383, 208, 'Commewijne', NULL, NULL);
INSERT INTO `state` VALUES (3384, 208, 'Coronie', NULL, NULL);
INSERT INTO `state` VALUES (3385, 208, 'Marowijne', NULL, NULL);
INSERT INTO `state` VALUES (3386, 208, 'Nickerie', NULL, NULL);
INSERT INTO `state` VALUES (3387, 208, 'Para', NULL, NULL);
INSERT INTO `state` VALUES (3388, 208, 'Paramaribo', NULL, NULL);
INSERT INTO `state` VALUES (3389, 208, 'Saramacca', NULL, NULL);
INSERT INTO `state` VALUES (3390, 208, 'Wanica', NULL, NULL);
INSERT INTO `state` VALUES (3391, 209, 'Svalbard', NULL, NULL);
INSERT INTO `state` VALUES (3392, 210, 'Hhohho', NULL, NULL);
INSERT INTO `state` VALUES (3393, 210, 'Lubombo', NULL, NULL);
INSERT INTO `state` VALUES (3394, 210, 'Manzini', NULL, NULL);
INSERT INTO `state` VALUES (3395, 210, 'Shiselweni', NULL, NULL);
INSERT INTO `state` VALUES (3396, 211, 'Alvsborgs Lan', NULL, NULL);
INSERT INTO `state` VALUES (3397, 211, 'Angermanland', NULL, NULL);
INSERT INTO `state` VALUES (3398, 211, 'Blekinge', NULL, NULL);
INSERT INTO `state` VALUES (3399, 211, 'Bohuslan', NULL, NULL);
INSERT INTO `state` VALUES (3400, 211, 'Dalarna', NULL, NULL);
INSERT INTO `state` VALUES (3401, 211, 'Gavleborg', NULL, NULL);
INSERT INTO `state` VALUES (3402, 211, 'Gaza', NULL, NULL);
INSERT INTO `state` VALUES (3403, 211, 'Gotland', NULL, NULL);
INSERT INTO `state` VALUES (3404, 211, 'Halland', NULL, NULL);
INSERT INTO `state` VALUES (3405, 211, 'Jamtland', NULL, NULL);
INSERT INTO `state` VALUES (3406, 211, 'Jonkoping', NULL, NULL);
INSERT INTO `state` VALUES (3407, 211, 'Kalmar', NULL, NULL);
INSERT INTO `state` VALUES (3408, 211, 'Kristianstads', NULL, NULL);
INSERT INTO `state` VALUES (3409, 211, 'Kronoberg', NULL, NULL);
INSERT INTO `state` VALUES (3410, 211, 'Norrbotten', NULL, NULL);
INSERT INTO `state` VALUES (3411, 211, 'Orebro', NULL, NULL);
INSERT INTO `state` VALUES (3412, 211, 'Ostergotland', NULL, NULL);
INSERT INTO `state` VALUES (3413, 211, 'Saltsjo-Boo', NULL, NULL);
INSERT INTO `state` VALUES (3414, 211, 'Skane', NULL, NULL);
INSERT INTO `state` VALUES (3415, 211, 'Smaland', NULL, NULL);
INSERT INTO `state` VALUES (3416, 211, 'Sodermanland', NULL, NULL);
INSERT INTO `state` VALUES (3417, 211, 'Stockholm', NULL, NULL);
INSERT INTO `state` VALUES (3418, 211, 'Uppsala', NULL, NULL);
INSERT INTO `state` VALUES (3419, 211, 'Varmland', NULL, NULL);
INSERT INTO `state` VALUES (3420, 211, 'Vasterbotten', NULL, NULL);
INSERT INTO `state` VALUES (3421, 211, 'Vastergotland', NULL, NULL);
INSERT INTO `state` VALUES (3422, 211, 'Vasternorrland', NULL, NULL);
INSERT INTO `state` VALUES (3423, 211, 'Vastmanland', NULL, NULL);
INSERT INTO `state` VALUES (3424, 211, 'Vastra Gotaland', NULL, NULL);
INSERT INTO `state` VALUES (3425, 212, 'Aargau', NULL, NULL);
INSERT INTO `state` VALUES (3426, 212, 'Appenzell Inner-Rhoden', NULL, NULL);
INSERT INTO `state` VALUES (3427, 212, 'Appenzell-Ausser Rhoden', NULL, NULL);
INSERT INTO `state` VALUES (3428, 212, 'Basel-Landschaft', NULL, NULL);
INSERT INTO `state` VALUES (3429, 212, 'Basel-Stadt', NULL, NULL);
INSERT INTO `state` VALUES (3430, 212, 'Bern', NULL, NULL);
INSERT INTO `state` VALUES (3431, 212, 'Canton Ticino', NULL, NULL);
INSERT INTO `state` VALUES (3432, 212, 'Fribourg', NULL, NULL);
INSERT INTO `state` VALUES (3433, 212, 'Geneve', NULL, NULL);
INSERT INTO `state` VALUES (3434, 212, 'Glarus', NULL, NULL);
INSERT INTO `state` VALUES (3435, 212, 'Graubunden', NULL, NULL);
INSERT INTO `state` VALUES (3436, 212, 'Heerbrugg', NULL, NULL);
INSERT INTO `state` VALUES (3437, 212, 'Jura', NULL, NULL);
INSERT INTO `state` VALUES (3438, 212, 'Kanton Aargau', NULL, NULL);
INSERT INTO `state` VALUES (3439, 212, 'Luzern', NULL, NULL);
INSERT INTO `state` VALUES (3440, 212, 'Morbio Inferiore', NULL, NULL);
INSERT INTO `state` VALUES (3441, 212, 'Muhen', NULL, NULL);
INSERT INTO `state` VALUES (3442, 212, 'Neuchatel', NULL, NULL);
INSERT INTO `state` VALUES (3443, 212, 'Nidwalden', NULL, NULL);
INSERT INTO `state` VALUES (3444, 212, 'Obwalden', NULL, NULL);
INSERT INTO `state` VALUES (3445, 212, 'Sankt Gallen', NULL, NULL);
INSERT INTO `state` VALUES (3446, 212, 'Schaffhausen', NULL, NULL);
INSERT INTO `state` VALUES (3447, 212, 'Schwyz', NULL, NULL);
INSERT INTO `state` VALUES (3448, 212, 'Solothurn', NULL, NULL);
INSERT INTO `state` VALUES (3449, 212, 'Thurgau', NULL, NULL);
INSERT INTO `state` VALUES (3450, 212, 'Ticino', NULL, NULL);
INSERT INTO `state` VALUES (3451, 212, 'Uri', NULL, NULL);
INSERT INTO `state` VALUES (3452, 212, 'Valais', NULL, NULL);
INSERT INTO `state` VALUES (3453, 212, 'Vaud', NULL, NULL);
INSERT INTO `state` VALUES (3454, 212, 'Vauffelin', NULL, NULL);
INSERT INTO `state` VALUES (3455, 212, 'Zug', NULL, NULL);
INSERT INTO `state` VALUES (3456, 212, 'Zurich', NULL, NULL);
INSERT INTO `state` VALUES (3457, 213, 'Aleppo', NULL, NULL);
INSERT INTO `state` VALUES (3458, 213, 'Dar\'a', NULL, NULL);
INSERT INTO `state` VALUES (3459, 213, 'Dayr-az-Zawr', NULL, NULL);
INSERT INTO `state` VALUES (3460, 213, 'Dimashq', NULL, NULL);
INSERT INTO `state` VALUES (3461, 213, 'Halab', NULL, NULL);
INSERT INTO `state` VALUES (3462, 213, 'Hamah', NULL, NULL);
INSERT INTO `state` VALUES (3463, 213, 'Hims', NULL, NULL);
INSERT INTO `state` VALUES (3464, 213, 'Idlib', NULL, NULL);
INSERT INTO `state` VALUES (3465, 213, 'Madinat Dimashq', NULL, NULL);
INSERT INTO `state` VALUES (3466, 213, 'Tartus', NULL, NULL);
INSERT INTO `state` VALUES (3467, 213, 'al-Hasakah', NULL, NULL);
INSERT INTO `state` VALUES (3468, 213, 'al-Ladhiqiyah', NULL, NULL);
INSERT INTO `state` VALUES (3469, 213, 'al-Qunaytirah', NULL, NULL);
INSERT INTO `state` VALUES (3470, 213, 'ar-Raqqah', NULL, NULL);
INSERT INTO `state` VALUES (3471, 213, 'as-Suwayda', NULL, NULL);
INSERT INTO `state` VALUES (3472, 214, 'Changhwa', NULL, NULL);
INSERT INTO `state` VALUES (3473, 214, 'Chiayi Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3474, 214, 'Chiayi Shih', NULL, NULL);
INSERT INTO `state` VALUES (3475, 214, 'Eastern Taipei', NULL, NULL);
INSERT INTO `state` VALUES (3476, 214, 'Hsinchu Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3477, 214, 'Hsinchu Shih', NULL, NULL);
INSERT INTO `state` VALUES (3478, 214, 'Hualien', NULL, NULL);
INSERT INTO `state` VALUES (3479, 214, 'Ilan', NULL, NULL);
INSERT INTO `state` VALUES (3480, 214, 'Kaohsiung Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3481, 214, 'Kaohsiung Shih', NULL, NULL);
INSERT INTO `state` VALUES (3482, 214, 'Keelung Shih', NULL, NULL);
INSERT INTO `state` VALUES (3483, 214, 'Kinmen', NULL, NULL);
INSERT INTO `state` VALUES (3484, 214, 'Miaoli', NULL, NULL);
INSERT INTO `state` VALUES (3485, 214, 'Nantou', NULL, NULL);
INSERT INTO `state` VALUES (3486, 214, 'Northern Taiwan', NULL, NULL);
INSERT INTO `state` VALUES (3487, 214, 'Penghu', NULL, NULL);
INSERT INTO `state` VALUES (3488, 214, 'Pingtung', NULL, NULL);
INSERT INTO `state` VALUES (3489, 214, 'Taichung', NULL, NULL);
INSERT INTO `state` VALUES (3490, 214, 'Taichung Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3491, 214, 'Taichung Shih', NULL, NULL);
INSERT INTO `state` VALUES (3492, 214, 'Tainan Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3493, 214, 'Tainan Shih', NULL, NULL);
INSERT INTO `state` VALUES (3494, 214, 'Taipei Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3495, 214, 'Taipei Shih / Taipei Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3496, 214, 'Taitung', NULL, NULL);
INSERT INTO `state` VALUES (3497, 214, 'Taoyuan', NULL, NULL);
INSERT INTO `state` VALUES (3498, 214, 'Yilan', NULL, NULL);
INSERT INTO `state` VALUES (3499, 214, 'Yun-Lin Hsien', NULL, NULL);
INSERT INTO `state` VALUES (3500, 214, 'Yunlin', NULL, NULL);
INSERT INTO `state` VALUES (3501, 215, 'Dushanbe', NULL, NULL);
INSERT INTO `state` VALUES (3502, 215, 'Gorno-Badakhshan', NULL, NULL);
INSERT INTO `state` VALUES (3503, 215, 'Karotegin', NULL, NULL);
INSERT INTO `state` VALUES (3504, 215, 'Khatlon', NULL, NULL);
INSERT INTO `state` VALUES (3505, 215, 'Sughd', NULL, NULL);
INSERT INTO `state` VALUES (3506, 216, 'Arusha', NULL, NULL);
INSERT INTO `state` VALUES (3507, 216, 'Dar es Salaam', NULL, NULL);
INSERT INTO `state` VALUES (3508, 216, 'Dodoma', NULL, NULL);
INSERT INTO `state` VALUES (3509, 216, 'Iringa', NULL, NULL);
INSERT INTO `state` VALUES (3510, 216, 'Kagera', NULL, NULL);
INSERT INTO `state` VALUES (3511, 216, 'Kigoma', NULL, NULL);
INSERT INTO `state` VALUES (3512, 216, 'Kilimanjaro', NULL, NULL);
INSERT INTO `state` VALUES (3513, 216, 'Lindi', NULL, NULL);
INSERT INTO `state` VALUES (3514, 216, 'Mara', NULL, NULL);
INSERT INTO `state` VALUES (3515, 216, 'Mbeya', NULL, NULL);
INSERT INTO `state` VALUES (3516, 216, 'Morogoro', NULL, NULL);
INSERT INTO `state` VALUES (3517, 216, 'Mtwara', NULL, NULL);
INSERT INTO `state` VALUES (3518, 216, 'Mwanza', NULL, NULL);
INSERT INTO `state` VALUES (3519, 216, 'Pwani', NULL, NULL);
INSERT INTO `state` VALUES (3520, 216, 'Rukwa', NULL, NULL);
INSERT INTO `state` VALUES (3521, 216, 'Ruvuma', NULL, NULL);
INSERT INTO `state` VALUES (3522, 216, 'Shinyanga', NULL, NULL);
INSERT INTO `state` VALUES (3523, 216, 'Singida', NULL, NULL);
INSERT INTO `state` VALUES (3524, 216, 'Tabora', NULL, NULL);
INSERT INTO `state` VALUES (3525, 216, 'Tanga', NULL, NULL);
INSERT INTO `state` VALUES (3526, 216, 'Zanzibar and Pemba', NULL, NULL);
INSERT INTO `state` VALUES (3527, 217, 'Amnat Charoen', NULL, NULL);
INSERT INTO `state` VALUES (3528, 217, 'Ang Thong', NULL, NULL);
INSERT INTO `state` VALUES (3529, 217, 'Bangkok', NULL, NULL);
INSERT INTO `state` VALUES (3530, 217, 'Buri Ram', NULL, NULL);
INSERT INTO `state` VALUES (3531, 217, 'Chachoengsao', NULL, NULL);
INSERT INTO `state` VALUES (3532, 217, 'Chai Nat', NULL, NULL);
INSERT INTO `state` VALUES (3533, 217, 'Chaiyaphum', NULL, NULL);
INSERT INTO `state` VALUES (3534, 217, 'Changwat Chaiyaphum', NULL, NULL);
INSERT INTO `state` VALUES (3535, 217, 'Chanthaburi', NULL, NULL);
INSERT INTO `state` VALUES (3536, 217, 'Chiang Mai', NULL, NULL);
INSERT INTO `state` VALUES (3537, 217, 'Chiang Rai', NULL, NULL);
INSERT INTO `state` VALUES (3538, 217, 'Chon Buri', NULL, NULL);
INSERT INTO `state` VALUES (3539, 217, 'Chumphon', NULL, NULL);
INSERT INTO `state` VALUES (3540, 217, 'Kalasin', NULL, NULL);
INSERT INTO `state` VALUES (3541, 217, 'Kamphaeng Phet', NULL, NULL);
INSERT INTO `state` VALUES (3542, 217, 'Kanchanaburi', NULL, NULL);
INSERT INTO `state` VALUES (3543, 217, 'Khon Kaen', NULL, NULL);
INSERT INTO `state` VALUES (3544, 217, 'Krabi', NULL, NULL);
INSERT INTO `state` VALUES (3545, 217, 'Krung Thep', NULL, NULL);
INSERT INTO `state` VALUES (3546, 217, 'Lampang', NULL, NULL);
INSERT INTO `state` VALUES (3547, 217, 'Lamphun', NULL, NULL);
INSERT INTO `state` VALUES (3548, 217, 'Loei', NULL, NULL);
INSERT INTO `state` VALUES (3549, 217, 'Lop Buri', NULL, NULL);
INSERT INTO `state` VALUES (3550, 217, 'Mae Hong Son', NULL, NULL);
INSERT INTO `state` VALUES (3551, 217, 'Maha Sarakham', NULL, NULL);
INSERT INTO `state` VALUES (3552, 217, 'Mukdahan', NULL, NULL);
INSERT INTO `state` VALUES (3553, 217, 'Nakhon Nayok', NULL, NULL);
INSERT INTO `state` VALUES (3554, 217, 'Nakhon Pathom', NULL, NULL);
INSERT INTO `state` VALUES (3555, 217, 'Nakhon Phanom', NULL, NULL);
INSERT INTO `state` VALUES (3556, 217, 'Nakhon Ratchasima', NULL, NULL);
INSERT INTO `state` VALUES (3557, 217, 'Nakhon Sawan', NULL, NULL);
INSERT INTO `state` VALUES (3558, 217, 'Nakhon Si Thammarat', NULL, NULL);
INSERT INTO `state` VALUES (3559, 217, 'Nan', NULL, NULL);
INSERT INTO `state` VALUES (3560, 217, 'Narathiwat', NULL, NULL);
INSERT INTO `state` VALUES (3561, 217, 'Nong Bua Lam Phu', NULL, NULL);
INSERT INTO `state` VALUES (3562, 217, 'Nong Khai', NULL, NULL);
INSERT INTO `state` VALUES (3563, 217, 'Nonthaburi', NULL, NULL);
INSERT INTO `state` VALUES (3564, 217, 'Pathum Thani', NULL, NULL);
INSERT INTO `state` VALUES (3565, 217, 'Pattani', NULL, NULL);
INSERT INTO `state` VALUES (3566, 217, 'Phangnga', NULL, NULL);
INSERT INTO `state` VALUES (3567, 217, 'Phatthalung', NULL, NULL);
INSERT INTO `state` VALUES (3568, 217, 'Phayao', NULL, NULL);
INSERT INTO `state` VALUES (3569, 217, 'Phetchabun', NULL, NULL);
INSERT INTO `state` VALUES (3570, 217, 'Phetchaburi', NULL, NULL);
INSERT INTO `state` VALUES (3571, 217, 'Phichit', NULL, NULL);
INSERT INTO `state` VALUES (3572, 217, 'Phitsanulok', NULL, NULL);
INSERT INTO `state` VALUES (3573, 217, 'Phra Nakhon Si Ayutthaya', NULL, NULL);
INSERT INTO `state` VALUES (3574, 217, 'Phrae', NULL, NULL);
INSERT INTO `state` VALUES (3575, 217, 'Phuket', NULL, NULL);
INSERT INTO `state` VALUES (3576, 217, 'Prachin Buri', NULL, NULL);
INSERT INTO `state` VALUES (3577, 217, 'Prachuap Khiri Khan', NULL, NULL);
INSERT INTO `state` VALUES (3578, 217, 'Ranong', NULL, NULL);
INSERT INTO `state` VALUES (3579, 217, 'Ratchaburi', NULL, NULL);
INSERT INTO `state` VALUES (3580, 217, 'Rayong', NULL, NULL);
INSERT INTO `state` VALUES (3581, 217, 'Roi Et', NULL, NULL);
INSERT INTO `state` VALUES (3582, 217, 'Sa Kaeo', NULL, NULL);
INSERT INTO `state` VALUES (3583, 217, 'Sakon Nakhon', NULL, NULL);
INSERT INTO `state` VALUES (3584, 217, 'Samut Prakan', NULL, NULL);
INSERT INTO `state` VALUES (3585, 217, 'Samut Sakhon', NULL, NULL);
INSERT INTO `state` VALUES (3586, 217, 'Samut Songkhran', NULL, NULL);
INSERT INTO `state` VALUES (3587, 217, 'Saraburi', NULL, NULL);
INSERT INTO `state` VALUES (3588, 217, 'Satun', NULL, NULL);
INSERT INTO `state` VALUES (3589, 217, 'Si Sa Ket', NULL, NULL);
INSERT INTO `state` VALUES (3590, 217, 'Sing Buri', NULL, NULL);
INSERT INTO `state` VALUES (3591, 217, 'Songkhla', NULL, NULL);
INSERT INTO `state` VALUES (3592, 217, 'Sukhothai', NULL, NULL);
INSERT INTO `state` VALUES (3593, 217, 'Suphan Buri', NULL, NULL);
INSERT INTO `state` VALUES (3594, 217, 'Surat Thani', NULL, NULL);
INSERT INTO `state` VALUES (3595, 217, 'Surin', NULL, NULL);
INSERT INTO `state` VALUES (3596, 217, 'Tak', NULL, NULL);
INSERT INTO `state` VALUES (3597, 217, 'Trang', NULL, NULL);
INSERT INTO `state` VALUES (3598, 217, 'Trat', NULL, NULL);
INSERT INTO `state` VALUES (3599, 217, 'Ubon Ratchathani', NULL, NULL);
INSERT INTO `state` VALUES (3600, 217, 'Udon Thani', NULL, NULL);
INSERT INTO `state` VALUES (3601, 217, 'Uthai Thani', NULL, NULL);
INSERT INTO `state` VALUES (3602, 217, 'Uttaradit', NULL, NULL);
INSERT INTO `state` VALUES (3603, 217, 'Yala', NULL, NULL);
INSERT INTO `state` VALUES (3604, 217, 'Yasothon', NULL, NULL);
INSERT INTO `state` VALUES (3605, 218, 'Centre', NULL, NULL);
INSERT INTO `state` VALUES (3606, 218, 'Kara', NULL, NULL);
INSERT INTO `state` VALUES (3607, 218, 'Maritime', NULL, NULL);
INSERT INTO `state` VALUES (3608, 218, 'Plateaux', NULL, NULL);
INSERT INTO `state` VALUES (3609, 218, 'Savanes', NULL, NULL);
INSERT INTO `state` VALUES (3610, 219, 'Atafu', NULL, NULL);
INSERT INTO `state` VALUES (3611, 219, 'Fakaofo', NULL, NULL);
INSERT INTO `state` VALUES (3612, 219, 'Nukunonu', NULL, NULL);
INSERT INTO `state` VALUES (3613, 220, 'Eua', NULL, NULL);
INSERT INTO `state` VALUES (3614, 220, 'Ha\'apai', NULL, NULL);
INSERT INTO `state` VALUES (3615, 220, 'Niuas', NULL, NULL);
INSERT INTO `state` VALUES (3616, 220, 'Tongatapu', NULL, NULL);
INSERT INTO `state` VALUES (3617, 220, 'Vava\'u', NULL, NULL);
INSERT INTO `state` VALUES (3618, 221, 'Arima-Tunapuna-Piarco', NULL, NULL);
INSERT INTO `state` VALUES (3619, 221, 'Caroni', NULL, NULL);
INSERT INTO `state` VALUES (3620, 221, 'Chaguanas', NULL, NULL);
INSERT INTO `state` VALUES (3621, 221, 'Couva-Tabaquite-Talparo', NULL, NULL);
INSERT INTO `state` VALUES (3622, 221, 'Diego Martin', NULL, NULL);
INSERT INTO `state` VALUES (3623, 221, 'Glencoe', NULL, NULL);
INSERT INTO `state` VALUES (3624, 221, 'Penal Debe', NULL, NULL);
INSERT INTO `state` VALUES (3625, 221, 'Point Fortin', NULL, NULL);
INSERT INTO `state` VALUES (3626, 221, 'Port of Spain', NULL, NULL);
INSERT INTO `state` VALUES (3627, 221, 'Princes Town', NULL, NULL);
INSERT INTO `state` VALUES (3628, 221, 'Saint George', NULL, NULL);
INSERT INTO `state` VALUES (3629, 221, 'San Fernando', NULL, NULL);
INSERT INTO `state` VALUES (3630, 221, 'San Juan', NULL, NULL);
INSERT INTO `state` VALUES (3631, 221, 'Sangre Grande', NULL, NULL);
INSERT INTO `state` VALUES (3632, 221, 'Siparia', NULL, NULL);
INSERT INTO `state` VALUES (3633, 221, 'Tobago', NULL, NULL);
INSERT INTO `state` VALUES (3634, 222, 'Aryanah', NULL, NULL);
INSERT INTO `state` VALUES (3635, 222, 'Bajah', NULL, NULL);
INSERT INTO `state` VALUES (3636, 222, 'Bin \'Arus', NULL, NULL);
INSERT INTO `state` VALUES (3637, 222, 'Binzart', NULL, NULL);
INSERT INTO `state` VALUES (3638, 222, 'Gouvernorat de Ariana', NULL, NULL);
INSERT INTO `state` VALUES (3639, 222, 'Gouvernorat de Nabeul', NULL, NULL);
INSERT INTO `state` VALUES (3640, 222, 'Gouvernorat de Sousse', NULL, NULL);
INSERT INTO `state` VALUES (3641, 222, 'Hammamet Yasmine', NULL, NULL);
INSERT INTO `state` VALUES (3642, 222, 'Jundubah', NULL, NULL);
INSERT INTO `state` VALUES (3643, 222, 'Madaniyin', NULL, NULL);
INSERT INTO `state` VALUES (3644, 222, 'Manubah', NULL, NULL);
INSERT INTO `state` VALUES (3645, 222, 'Monastir', NULL, NULL);
INSERT INTO `state` VALUES (3646, 222, 'Nabul', NULL, NULL);
INSERT INTO `state` VALUES (3647, 222, 'Qabis', NULL, NULL);
INSERT INTO `state` VALUES (3648, 222, 'Qafsah', NULL, NULL);
INSERT INTO `state` VALUES (3649, 222, 'Qibili', NULL, NULL);
INSERT INTO `state` VALUES (3650, 222, 'Safaqis', NULL, NULL);
INSERT INTO `state` VALUES (3651, 222, 'Sfax', NULL, NULL);
INSERT INTO `state` VALUES (3652, 222, 'Sidi Bu Zayd', NULL, NULL);
INSERT INTO `state` VALUES (3653, 222, 'Silyanah', NULL, NULL);
INSERT INTO `state` VALUES (3654, 222, 'Susah', NULL, NULL);
INSERT INTO `state` VALUES (3655, 222, 'Tatawin', NULL, NULL);
INSERT INTO `state` VALUES (3656, 222, 'Tawzar', NULL, NULL);
INSERT INTO `state` VALUES (3657, 222, 'Tunis', NULL, NULL);
INSERT INTO `state` VALUES (3658, 222, 'Zaghwan', NULL, NULL);
INSERT INTO `state` VALUES (3659, 222, 'al-Kaf', NULL, NULL);
INSERT INTO `state` VALUES (3660, 222, 'al-Mahdiyah', NULL, NULL);
INSERT INTO `state` VALUES (3661, 222, 'al-Munastir', NULL, NULL);
INSERT INTO `state` VALUES (3662, 222, 'al-Qasrayn', NULL, NULL);
INSERT INTO `state` VALUES (3663, 222, 'al-Qayrawan', NULL, NULL);
INSERT INTO `state` VALUES (3664, 223, 'Adana', NULL, NULL);
INSERT INTO `state` VALUES (3665, 223, 'Adiyaman', NULL, NULL);
INSERT INTO `state` VALUES (3666, 223, 'Afyon', NULL, NULL);
INSERT INTO `state` VALUES (3667, 223, 'Agri', NULL, NULL);
INSERT INTO `state` VALUES (3668, 223, 'Aksaray', NULL, NULL);
INSERT INTO `state` VALUES (3669, 223, 'Amasya', NULL, NULL);
INSERT INTO `state` VALUES (3670, 223, 'Ankara', NULL, NULL);
INSERT INTO `state` VALUES (3671, 223, 'Antalya', NULL, NULL);
INSERT INTO `state` VALUES (3672, 223, 'Ardahan', NULL, NULL);
INSERT INTO `state` VALUES (3673, 223, 'Artvin', NULL, NULL);
INSERT INTO `state` VALUES (3674, 223, 'Aydin', NULL, NULL);
INSERT INTO `state` VALUES (3675, 223, 'Balikesir', NULL, NULL);
INSERT INTO `state` VALUES (3676, 223, 'Bartin', NULL, NULL);
INSERT INTO `state` VALUES (3677, 223, 'Batman', NULL, NULL);
INSERT INTO `state` VALUES (3678, 223, 'Bayburt', NULL, NULL);
INSERT INTO `state` VALUES (3679, 223, 'Bilecik', NULL, NULL);
INSERT INTO `state` VALUES (3680, 223, 'Bingol', NULL, NULL);
INSERT INTO `state` VALUES (3681, 223, 'Bitlis', NULL, NULL);
INSERT INTO `state` VALUES (3682, 223, 'Bolu', NULL, NULL);
INSERT INTO `state` VALUES (3683, 223, 'Burdur', NULL, NULL);
INSERT INTO `state` VALUES (3684, 223, 'Bursa', NULL, NULL);
INSERT INTO `state` VALUES (3685, 223, 'Canakkale', NULL, NULL);
INSERT INTO `state` VALUES (3686, 223, 'Cankiri', NULL, NULL);
INSERT INTO `state` VALUES (3687, 223, 'Corum', NULL, NULL);
INSERT INTO `state` VALUES (3688, 223, 'Denizli', NULL, NULL);
INSERT INTO `state` VALUES (3689, 223, 'Diyarbakir', NULL, NULL);
INSERT INTO `state` VALUES (3690, 223, 'Duzce', NULL, NULL);
INSERT INTO `state` VALUES (3691, 223, 'Edirne', NULL, NULL);
INSERT INTO `state` VALUES (3692, 223, 'Elazig', NULL, NULL);
INSERT INTO `state` VALUES (3693, 223, 'Erzincan', NULL, NULL);
INSERT INTO `state` VALUES (3694, 223, 'Erzurum', NULL, NULL);
INSERT INTO `state` VALUES (3695, 223, 'Eskisehir', NULL, NULL);
INSERT INTO `state` VALUES (3696, 223, 'Gaziantep', NULL, NULL);
INSERT INTO `state` VALUES (3697, 223, 'Giresun', NULL, NULL);
INSERT INTO `state` VALUES (3698, 223, 'Gumushane', NULL, NULL);
INSERT INTO `state` VALUES (3699, 223, 'Hakkari', NULL, NULL);
INSERT INTO `state` VALUES (3700, 223, 'Hatay', NULL, NULL);
INSERT INTO `state` VALUES (3701, 223, 'Icel', NULL, NULL);
INSERT INTO `state` VALUES (3702, 223, 'Igdir', NULL, NULL);
INSERT INTO `state` VALUES (3703, 223, 'Isparta', NULL, NULL);
INSERT INTO `state` VALUES (3704, 223, 'Istanbul', NULL, NULL);
INSERT INTO `state` VALUES (3705, 223, 'Izmir', NULL, NULL);
INSERT INTO `state` VALUES (3706, 223, 'Kahramanmaras', NULL, NULL);
INSERT INTO `state` VALUES (3707, 223, 'Karabuk', NULL, NULL);
INSERT INTO `state` VALUES (3708, 223, 'Karaman', NULL, NULL);
INSERT INTO `state` VALUES (3709, 223, 'Kars', NULL, NULL);
INSERT INTO `state` VALUES (3710, 223, 'Karsiyaka', NULL, NULL);
INSERT INTO `state` VALUES (3711, 223, 'Kastamonu', NULL, NULL);
INSERT INTO `state` VALUES (3712, 223, 'Kayseri', NULL, NULL);
INSERT INTO `state` VALUES (3713, 223, 'Kilis', NULL, NULL);
INSERT INTO `state` VALUES (3714, 223, 'Kirikkale', NULL, NULL);
INSERT INTO `state` VALUES (3715, 223, 'Kirklareli', NULL, NULL);
INSERT INTO `state` VALUES (3716, 223, 'Kirsehir', NULL, NULL);
INSERT INTO `state` VALUES (3717, 223, 'Kocaeli', NULL, NULL);
INSERT INTO `state` VALUES (3718, 223, 'Konya', NULL, NULL);
INSERT INTO `state` VALUES (3719, 223, 'Kutahya', NULL, NULL);
INSERT INTO `state` VALUES (3720, 223, 'Lefkosa', NULL, NULL);
INSERT INTO `state` VALUES (3721, 223, 'Malatya', NULL, NULL);
INSERT INTO `state` VALUES (3722, 223, 'Manisa', NULL, NULL);
INSERT INTO `state` VALUES (3723, 223, 'Mardin', NULL, NULL);
INSERT INTO `state` VALUES (3724, 223, 'Mugla', NULL, NULL);
INSERT INTO `state` VALUES (3725, 223, 'Mus', NULL, NULL);
INSERT INTO `state` VALUES (3726, 223, 'Nevsehir', NULL, NULL);
INSERT INTO `state` VALUES (3727, 223, 'Nigde', NULL, NULL);
INSERT INTO `state` VALUES (3728, 223, 'Ordu', NULL, NULL);
INSERT INTO `state` VALUES (3729, 223, 'Osmaniye', NULL, NULL);
INSERT INTO `state` VALUES (3730, 223, 'Rize', NULL, NULL);
INSERT INTO `state` VALUES (3731, 223, 'Sakarya', NULL, NULL);
INSERT INTO `state` VALUES (3732, 223, 'Samsun', NULL, NULL);
INSERT INTO `state` VALUES (3733, 223, 'Sanliurfa', NULL, NULL);
INSERT INTO `state` VALUES (3734, 223, 'Siirt', NULL, NULL);
INSERT INTO `state` VALUES (3735, 223, 'Sinop', NULL, NULL);
INSERT INTO `state` VALUES (3736, 223, 'Sirnak', NULL, NULL);
INSERT INTO `state` VALUES (3737, 223, 'Sivas', NULL, NULL);
INSERT INTO `state` VALUES (3738, 223, 'Tekirdag', NULL, NULL);
INSERT INTO `state` VALUES (3739, 223, 'Tokat', NULL, NULL);
INSERT INTO `state` VALUES (3740, 223, 'Trabzon', NULL, NULL);
INSERT INTO `state` VALUES (3741, 223, 'Tunceli', NULL, NULL);
INSERT INTO `state` VALUES (3742, 223, 'Usak', NULL, NULL);
INSERT INTO `state` VALUES (3743, 223, 'Van', NULL, NULL);
INSERT INTO `state` VALUES (3744, 223, 'Yalova', NULL, NULL);
INSERT INTO `state` VALUES (3745, 223, 'Yozgat', NULL, NULL);
INSERT INTO `state` VALUES (3746, 223, 'Zonguldak', NULL, NULL);
INSERT INTO `state` VALUES (3747, 224, 'Ahal', NULL, NULL);
INSERT INTO `state` VALUES (3748, 224, 'Asgabat', NULL, NULL);
INSERT INTO `state` VALUES (3749, 224, 'Balkan', NULL, NULL);
INSERT INTO `state` VALUES (3750, 224, 'Dasoguz', NULL, NULL);
INSERT INTO `state` VALUES (3751, 224, 'Lebap', NULL, NULL);
INSERT INTO `state` VALUES (3752, 224, 'Mari', NULL, NULL);
INSERT INTO `state` VALUES (3753, 225, 'Grand Turk', NULL, NULL);
INSERT INTO `state` VALUES (3754, 225, 'South Caicos and East Caicos', NULL, NULL);
INSERT INTO `state` VALUES (3755, 226, 'Funafuti', NULL, NULL);
INSERT INTO `state` VALUES (3756, 226, 'Nanumanga', NULL, NULL);
INSERT INTO `state` VALUES (3757, 226, 'Nanumea', NULL, NULL);
INSERT INTO `state` VALUES (3758, 226, 'Niutao', NULL, NULL);
INSERT INTO `state` VALUES (3759, 226, 'Nui', NULL, NULL);
INSERT INTO `state` VALUES (3760, 226, 'Nukufetau', NULL, NULL);
INSERT INTO `state` VALUES (3761, 226, 'Nukulaelae', NULL, NULL);
INSERT INTO `state` VALUES (3762, 226, 'Vaitupu', NULL, NULL);
INSERT INTO `state` VALUES (3763, 227, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (3764, 227, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (3765, 227, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (3766, 227, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (3767, 228, 'Cherkas\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3768, 228, 'Chernihivs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3769, 228, 'Chernivets\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3770, 228, 'Crimea', NULL, NULL);
INSERT INTO `state` VALUES (3771, 228, 'Dnipropetrovska', NULL, NULL);
INSERT INTO `state` VALUES (3772, 228, 'Donets\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3773, 228, 'Ivano-Frankivs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3774, 228, 'Kharkiv', NULL, NULL);
INSERT INTO `state` VALUES (3775, 228, 'Kharkov', NULL, NULL);
INSERT INTO `state` VALUES (3776, 228, 'Khersonska', NULL, NULL);
INSERT INTO `state` VALUES (3777, 228, 'Khmel\'nyts\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3778, 228, 'Kirovohrad', NULL, NULL);
INSERT INTO `state` VALUES (3779, 228, 'Krym', NULL, NULL);
INSERT INTO `state` VALUES (3780, 228, 'Kyyiv', NULL, NULL);
INSERT INTO `state` VALUES (3781, 228, 'Kyyivs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3782, 228, 'L\'vivs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3783, 228, 'Luhans\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3784, 228, 'Mykolayivs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3785, 228, 'Odes\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3786, 228, 'Odessa', NULL, NULL);
INSERT INTO `state` VALUES (3787, 228, 'Poltavs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3788, 228, 'Rivnens\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3789, 228, 'Sevastopol\'', NULL, NULL);
INSERT INTO `state` VALUES (3790, 228, 'Sums\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3791, 228, 'Ternopil\'s\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3792, 228, 'Volyns\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3793, 228, 'Vynnyts\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3794, 228, 'Zakarpats\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3795, 228, 'Zaporizhia', NULL, NULL);
INSERT INTO `state` VALUES (3796, 228, 'Zhytomyrs\'ka', NULL, NULL);
INSERT INTO `state` VALUES (3797, 229, 'Abu Zabi', NULL, NULL);
INSERT INTO `state` VALUES (3798, 229, 'Ajman', NULL, NULL);
INSERT INTO `state` VALUES (3799, 229, 'Dubai', NULL, NULL);
INSERT INTO `state` VALUES (3800, 229, 'Ras al-Khaymah', NULL, NULL);
INSERT INTO `state` VALUES (3801, 229, 'Sharjah', NULL, NULL);
INSERT INTO `state` VALUES (3802, 229, 'Sharjha', NULL, NULL);
INSERT INTO `state` VALUES (3803, 229, 'Umm al Qaywayn', NULL, NULL);
INSERT INTO `state` VALUES (3804, 229, 'al-Fujayrah', NULL, NULL);
INSERT INTO `state` VALUES (3805, 229, 'ash-Shariqah', NULL, NULL);
INSERT INTO `state` VALUES (3806, 230, 'Aberdeen', NULL, NULL);
INSERT INTO `state` VALUES (3807, 230, 'Aberdeenshire', NULL, NULL);
INSERT INTO `state` VALUES (3808, 230, 'Argyll', NULL, NULL);
INSERT INTO `state` VALUES (3809, 230, 'Armagh', NULL, NULL);
INSERT INTO `state` VALUES (3810, 230, 'Bedfordshire', NULL, NULL);
INSERT INTO `state` VALUES (3811, 230, 'Belfast', NULL, NULL);
INSERT INTO `state` VALUES (3812, 230, 'Berkshire', NULL, NULL);
INSERT INTO `state` VALUES (3813, 230, 'Birmingham', NULL, NULL);
INSERT INTO `state` VALUES (3814, 230, 'Brechin', NULL, NULL);
INSERT INTO `state` VALUES (3815, 230, 'Bridgnorth', NULL, NULL);
INSERT INTO `state` VALUES (3816, 230, 'Bristol', NULL, NULL);
INSERT INTO `state` VALUES (3817, 230, 'Buckinghamshire', NULL, NULL);
INSERT INTO `state` VALUES (3818, 230, 'Cambridge', NULL, NULL);
INSERT INTO `state` VALUES (3819, 230, 'Cambridgeshire', NULL, NULL);
INSERT INTO `state` VALUES (3820, 230, 'Channel Islands', NULL, NULL);
INSERT INTO `state` VALUES (3821, 230, 'Cheshire', NULL, NULL);
INSERT INTO `state` VALUES (3822, 230, 'Cleveland', NULL, NULL);
INSERT INTO `state` VALUES (3823, 230, 'Co Fermanagh', NULL, NULL);
INSERT INTO `state` VALUES (3824, 230, 'Conwy', NULL, NULL);
INSERT INTO `state` VALUES (3825, 230, 'Cornwall', NULL, NULL);
INSERT INTO `state` VALUES (3826, 230, 'Coventry', NULL, NULL);
INSERT INTO `state` VALUES (3827, 230, 'Craven Arms', NULL, NULL);
INSERT INTO `state` VALUES (3828, 230, 'Cumbria', NULL, NULL);
INSERT INTO `state` VALUES (3829, 230, 'Denbighshire', NULL, NULL);
INSERT INTO `state` VALUES (3830, 230, 'Derby', NULL, NULL);
INSERT INTO `state` VALUES (3831, 230, 'Derbyshire', NULL, NULL);
INSERT INTO `state` VALUES (3832, 230, 'Devon', NULL, NULL);
INSERT INTO `state` VALUES (3833, 230, 'Dial Code Dungannon', NULL, NULL);
INSERT INTO `state` VALUES (3834, 230, 'Didcot', NULL, NULL);
INSERT INTO `state` VALUES (3835, 230, 'Dorset', NULL, NULL);
INSERT INTO `state` VALUES (3836, 230, 'Dunbartonshire', NULL, NULL);
INSERT INTO `state` VALUES (3837, 230, 'Durham', NULL, NULL);
INSERT INTO `state` VALUES (3838, 230, 'East Dunbartonshire', NULL, NULL);
INSERT INTO `state` VALUES (3839, 230, 'East Lothian', NULL, NULL);
INSERT INTO `state` VALUES (3840, 230, 'East Midlands', NULL, NULL);
INSERT INTO `state` VALUES (3841, 230, 'East Sussex', NULL, NULL);
INSERT INTO `state` VALUES (3842, 230, 'East Yorkshire', NULL, NULL);
INSERT INTO `state` VALUES (3843, 230, 'England', NULL, NULL);
INSERT INTO `state` VALUES (3844, 230, 'Essex', NULL, NULL);
INSERT INTO `state` VALUES (3845, 230, 'Fermanagh', NULL, NULL);
INSERT INTO `state` VALUES (3846, 230, 'Fife', NULL, NULL);
INSERT INTO `state` VALUES (3847, 230, 'Flintshire', NULL, NULL);
INSERT INTO `state` VALUES (3848, 230, 'Fulham', NULL, NULL);
INSERT INTO `state` VALUES (3849, 230, 'Gainsborough', NULL, NULL);
INSERT INTO `state` VALUES (3850, 230, 'Glocestershire', NULL, NULL);
INSERT INTO `state` VALUES (3851, 230, 'Gwent', NULL, NULL);
INSERT INTO `state` VALUES (3852, 230, 'Hampshire', NULL, NULL);
INSERT INTO `state` VALUES (3853, 230, 'Hants', NULL, NULL);
INSERT INTO `state` VALUES (3854, 230, 'Herefordshire', NULL, NULL);
INSERT INTO `state` VALUES (3855, 230, 'Hertfordshire', NULL, NULL);
INSERT INTO `state` VALUES (3856, 230, 'Ireland', NULL, NULL);
INSERT INTO `state` VALUES (3857, 230, 'Isle Of Man', NULL, NULL);
INSERT INTO `state` VALUES (3858, 230, 'Isle of Wight', NULL, NULL);
INSERT INTO `state` VALUES (3859, 230, 'Kenford', NULL, NULL);
INSERT INTO `state` VALUES (3860, 230, 'Kent', NULL, NULL);
INSERT INTO `state` VALUES (3861, 230, 'Kilmarnock', NULL, NULL);
INSERT INTO `state` VALUES (3862, 230, 'Lanarkshire', NULL, NULL);
INSERT INTO `state` VALUES (3863, 230, 'Lancashire', NULL, NULL);
INSERT INTO `state` VALUES (3864, 230, 'Leicestershire', NULL, NULL);
INSERT INTO `state` VALUES (3865, 230, 'Lincolnshire', NULL, NULL);
INSERT INTO `state` VALUES (3866, 230, 'Llanymynech', NULL, NULL);
INSERT INTO `state` VALUES (3867, 230, 'London', NULL, NULL);
INSERT INTO `state` VALUES (3868, 230, 'Ludlow', NULL, NULL);
INSERT INTO `state` VALUES (3869, 230, 'Manchester', NULL, NULL);
INSERT INTO `state` VALUES (3870, 230, 'Mayfair', NULL, NULL);
INSERT INTO `state` VALUES (3871, 230, 'Merseyside', NULL, NULL);
INSERT INTO `state` VALUES (3872, 230, 'Mid Glamorgan', NULL, NULL);
INSERT INTO `state` VALUES (3873, 230, 'Middlesex', NULL, NULL);
INSERT INTO `state` VALUES (3874, 230, 'Mildenhall', NULL, NULL);
INSERT INTO `state` VALUES (3875, 230, 'Monmouthshire', NULL, NULL);
INSERT INTO `state` VALUES (3876, 230, 'Newton Stewart', NULL, NULL);
INSERT INTO `state` VALUES (3877, 230, 'Norfolk', NULL, NULL);
INSERT INTO `state` VALUES (3878, 230, 'North Humberside', NULL, NULL);
INSERT INTO `state` VALUES (3879, 230, 'North Yorkshire', NULL, NULL);
INSERT INTO `state` VALUES (3880, 230, 'Northamptonshire', NULL, NULL);
INSERT INTO `state` VALUES (3881, 230, 'Northants', NULL, NULL);
INSERT INTO `state` VALUES (3882, 230, 'Northern Ireland', NULL, NULL);
INSERT INTO `state` VALUES (3883, 230, 'Northumberland', NULL, NULL);
INSERT INTO `state` VALUES (3884, 230, 'Nottinghamshire', NULL, NULL);
INSERT INTO `state` VALUES (3885, 230, 'Oxford', NULL, NULL);
INSERT INTO `state` VALUES (3886, 230, 'Powys', NULL, NULL);
INSERT INTO `state` VALUES (3887, 230, 'Roos-shire', NULL, NULL);
INSERT INTO `state` VALUES (3888, 230, 'SUSSEX', NULL, NULL);
INSERT INTO `state` VALUES (3889, 230, 'Sark', NULL, NULL);
INSERT INTO `state` VALUES (3890, 230, 'Scotland', NULL, NULL);
INSERT INTO `state` VALUES (3891, 230, 'Scottish Borders', NULL, NULL);
INSERT INTO `state` VALUES (3892, 230, 'Shropshire', NULL, NULL);
INSERT INTO `state` VALUES (3893, 230, 'Somerset', NULL, NULL);
INSERT INTO `state` VALUES (3894, 230, 'South Glamorgan', NULL, NULL);
INSERT INTO `state` VALUES (3895, 230, 'South Wales', NULL, NULL);
INSERT INTO `state` VALUES (3896, 230, 'South Yorkshire', NULL, NULL);
INSERT INTO `state` VALUES (3897, 230, 'Southwell', NULL, NULL);
INSERT INTO `state` VALUES (3898, 230, 'Staffordshire', NULL, NULL);
INSERT INTO `state` VALUES (3899, 230, 'Strabane', NULL, NULL);
INSERT INTO `state` VALUES (3900, 230, 'Suffolk', NULL, NULL);
INSERT INTO `state` VALUES (3901, 230, 'Surrey', NULL, NULL);
INSERT INTO `state` VALUES (3902, 230, 'Sussex', NULL, NULL);
INSERT INTO `state` VALUES (3903, 230, 'Twickenham', NULL, NULL);
INSERT INTO `state` VALUES (3904, 230, 'Tyne and Wear', NULL, NULL);
INSERT INTO `state` VALUES (3905, 230, 'Tyrone', NULL, NULL);
INSERT INTO `state` VALUES (3906, 230, 'Utah', NULL, NULL);
INSERT INTO `state` VALUES (3907, 230, 'Wales', NULL, NULL);
INSERT INTO `state` VALUES (3908, 230, 'Warwickshire', NULL, NULL);
INSERT INTO `state` VALUES (3909, 230, 'West Lothian', NULL, NULL);
INSERT INTO `state` VALUES (3910, 230, 'West Midlands', NULL, NULL);
INSERT INTO `state` VALUES (3911, 230, 'West Sussex', NULL, NULL);
INSERT INTO `state` VALUES (3912, 230, 'West Yorkshire', NULL, NULL);
INSERT INTO `state` VALUES (3913, 230, 'Whissendine', NULL, NULL);
INSERT INTO `state` VALUES (3914, 230, 'Wiltshire', NULL, NULL);
INSERT INTO `state` VALUES (3915, 230, 'Wokingham', NULL, NULL);
INSERT INTO `state` VALUES (3916, 230, 'Worcestershire', NULL, NULL);
INSERT INTO `state` VALUES (3917, 230, 'Wrexham', NULL, NULL);
INSERT INTO `state` VALUES (3918, 230, 'Wurttemberg', NULL, NULL);
INSERT INTO `state` VALUES (3919, 230, 'Yorkshire', NULL, NULL);
INSERT INTO `state` VALUES (3920, 231, 'Alabama', NULL, NULL);
INSERT INTO `state` VALUES (3921, 231, 'Alaska', NULL, NULL);
INSERT INTO `state` VALUES (3922, 231, 'Arizona', NULL, NULL);
INSERT INTO `state` VALUES (3923, 231, 'Arkansas', NULL, NULL);
INSERT INTO `state` VALUES (3924, 231, 'Byram', NULL, NULL);
INSERT INTO `state` VALUES (3925, 231, 'California', NULL, NULL);
INSERT INTO `state` VALUES (3926, 231, 'Cokato', NULL, NULL);
INSERT INTO `state` VALUES (3927, 231, 'Colorado', NULL, NULL);
INSERT INTO `state` VALUES (3928, 231, 'Connecticut', NULL, NULL);
INSERT INTO `state` VALUES (3929, 231, 'Delaware', NULL, NULL);
INSERT INTO `state` VALUES (3930, 231, 'District of Columbia', NULL, NULL);
INSERT INTO `state` VALUES (3931, 231, 'Florida', NULL, NULL);
INSERT INTO `state` VALUES (3932, 231, 'Georgia', NULL, NULL);
INSERT INTO `state` VALUES (3933, 231, 'Hawaii', NULL, NULL);
INSERT INTO `state` VALUES (3934, 231, 'Idaho', NULL, NULL);
INSERT INTO `state` VALUES (3935, 231, 'Illinois', NULL, NULL);
INSERT INTO `state` VALUES (3936, 231, 'Indiana', NULL, NULL);
INSERT INTO `state` VALUES (3937, 231, 'Iowa', NULL, NULL);
INSERT INTO `state` VALUES (3938, 231, 'Kansas', NULL, NULL);
INSERT INTO `state` VALUES (3939, 231, 'Kentucky', NULL, NULL);
INSERT INTO `state` VALUES (3940, 231, 'Louisiana', NULL, NULL);
INSERT INTO `state` VALUES (3941, 231, 'Lowa', NULL, NULL);
INSERT INTO `state` VALUES (3942, 231, 'Maine', NULL, NULL);
INSERT INTO `state` VALUES (3943, 231, 'Maryland', NULL, NULL);
INSERT INTO `state` VALUES (3944, 231, 'Massachusetts', NULL, NULL);
INSERT INTO `state` VALUES (3945, 231, 'Medfield', NULL, NULL);
INSERT INTO `state` VALUES (3946, 231, 'Michigan', NULL, NULL);
INSERT INTO `state` VALUES (3947, 231, 'Minnesota', NULL, NULL);
INSERT INTO `state` VALUES (3948, 231, 'Mississippi', NULL, NULL);
INSERT INTO `state` VALUES (3949, 231, 'Missouri', NULL, NULL);
INSERT INTO `state` VALUES (3950, 231, 'Montana', NULL, NULL);
INSERT INTO `state` VALUES (3951, 231, 'Nebraska', NULL, NULL);
INSERT INTO `state` VALUES (3952, 231, 'Nevada', NULL, NULL);
INSERT INTO `state` VALUES (3953, 231, 'New Hampshire', NULL, NULL);
INSERT INTO `state` VALUES (3954, 231, 'New Jersey', NULL, NULL);
INSERT INTO `state` VALUES (3955, 231, 'New Jersy', NULL, NULL);
INSERT INTO `state` VALUES (3956, 231, 'New Mexico', NULL, NULL);
INSERT INTO `state` VALUES (3957, 231, 'New York', NULL, NULL);
INSERT INTO `state` VALUES (3958, 231, 'North Carolina', NULL, NULL);
INSERT INTO `state` VALUES (3959, 231, 'North Dakota', NULL, NULL);
INSERT INTO `state` VALUES (3960, 231, 'Ohio', NULL, NULL);
INSERT INTO `state` VALUES (3961, 231, 'Oklahoma', NULL, NULL);
INSERT INTO `state` VALUES (3962, 231, 'Ontario', NULL, NULL);
INSERT INTO `state` VALUES (3963, 231, 'Oregon', NULL, NULL);
INSERT INTO `state` VALUES (3964, 231, 'Pennsylvania', NULL, NULL);
INSERT INTO `state` VALUES (3965, 231, 'Ramey', NULL, NULL);
INSERT INTO `state` VALUES (3966, 231, 'Rhode Island', NULL, NULL);
INSERT INTO `state` VALUES (3967, 231, 'South Carolina', NULL, NULL);
INSERT INTO `state` VALUES (3968, 231, 'South Dakota', NULL, NULL);
INSERT INTO `state` VALUES (3969, 231, 'Sublimity', NULL, NULL);
INSERT INTO `state` VALUES (3970, 231, 'Tennessee', NULL, NULL);
INSERT INTO `state` VALUES (3971, 231, 'Texas', NULL, NULL);
INSERT INTO `state` VALUES (3972, 231, 'Trimble', NULL, NULL);
INSERT INTO `state` VALUES (3973, 231, 'Utah', NULL, NULL);
INSERT INTO `state` VALUES (3974, 231, 'Vermont', NULL, NULL);
INSERT INTO `state` VALUES (3975, 231, 'Virginia', NULL, NULL);
INSERT INTO `state` VALUES (3976, 231, 'Washington', NULL, NULL);
INSERT INTO `state` VALUES (3977, 231, 'West Virginia', NULL, NULL);
INSERT INTO `state` VALUES (3978, 231, 'Wisconsin', NULL, NULL);
INSERT INTO `state` VALUES (3979, 231, 'Wyoming', NULL, NULL);
INSERT INTO `state` VALUES (3980, 232, 'United States Minor Outlying I', NULL, NULL);
INSERT INTO `state` VALUES (3981, 233, 'Artigas', NULL, NULL);
INSERT INTO `state` VALUES (3982, 233, 'Canelones', NULL, NULL);
INSERT INTO `state` VALUES (3983, 233, 'Cerro Largo', NULL, NULL);
INSERT INTO `state` VALUES (3984, 233, 'Colonia', NULL, NULL);
INSERT INTO `state` VALUES (3985, 233, 'Durazno', NULL, NULL);
INSERT INTO `state` VALUES (3986, 233, 'FLorida', NULL, NULL);
INSERT INTO `state` VALUES (3987, 233, 'Flores', NULL, NULL);
INSERT INTO `state` VALUES (3988, 233, 'Lavalleja', NULL, NULL);
INSERT INTO `state` VALUES (3989, 233, 'Maldonado', NULL, NULL);
INSERT INTO `state` VALUES (3990, 233, 'Montevideo', NULL, NULL);
INSERT INTO `state` VALUES (3991, 233, 'Paysandu', NULL, NULL);
INSERT INTO `state` VALUES (3992, 233, 'Rio Negro', NULL, NULL);
INSERT INTO `state` VALUES (3993, 233, 'Rivera', NULL, NULL);
INSERT INTO `state` VALUES (3994, 233, 'Rocha', NULL, NULL);
INSERT INTO `state` VALUES (3995, 233, 'Salto', NULL, NULL);
INSERT INTO `state` VALUES (3996, 233, 'San Jose', NULL, NULL);
INSERT INTO `state` VALUES (3997, 233, 'Soriano', NULL, NULL);
INSERT INTO `state` VALUES (3998, 233, 'Tacuarembo', NULL, NULL);
INSERT INTO `state` VALUES (3999, 233, 'Treinta y Tres', NULL, NULL);
INSERT INTO `state` VALUES (4000, 234, 'Andijon', NULL, NULL);
INSERT INTO `state` VALUES (4001, 234, 'Buhoro', NULL, NULL);
INSERT INTO `state` VALUES (4002, 234, 'Buxoro Viloyati', NULL, NULL);
INSERT INTO `state` VALUES (4003, 234, 'Cizah', NULL, NULL);
INSERT INTO `state` VALUES (4004, 234, 'Fargona', NULL, NULL);
INSERT INTO `state` VALUES (4005, 234, 'Horazm', NULL, NULL);
INSERT INTO `state` VALUES (4006, 234, 'Kaskadar', NULL, NULL);
INSERT INTO `state` VALUES (4007, 234, 'Korakalpogiston', NULL, NULL);
INSERT INTO `state` VALUES (4008, 234, 'Namangan', NULL, NULL);
INSERT INTO `state` VALUES (4009, 234, 'Navoi', NULL, NULL);
INSERT INTO `state` VALUES (4010, 234, 'Samarkand', NULL, NULL);
INSERT INTO `state` VALUES (4011, 234, 'Sirdare', NULL, NULL);
INSERT INTO `state` VALUES (4012, 234, 'Surhondar', NULL, NULL);
INSERT INTO `state` VALUES (4013, 234, 'Toskent', NULL, NULL);
INSERT INTO `state` VALUES (4014, 235, 'Malampa', NULL, NULL);
INSERT INTO `state` VALUES (4015, 235, 'Penama', NULL, NULL);
INSERT INTO `state` VALUES (4016, 235, 'Sanma', NULL, NULL);
INSERT INTO `state` VALUES (4017, 235, 'Shefa', NULL, NULL);
INSERT INTO `state` VALUES (4018, 235, 'Tafea', NULL, NULL);
INSERT INTO `state` VALUES (4019, 235, 'Torba', NULL, NULL);
INSERT INTO `state` VALUES (4020, 236, 'Vatican City State (Holy See)', NULL, NULL);
INSERT INTO `state` VALUES (4021, 237, 'Amazonas', NULL, NULL);
INSERT INTO `state` VALUES (4022, 237, 'Anzoategui', NULL, NULL);
INSERT INTO `state` VALUES (4023, 237, 'Apure', NULL, NULL);
INSERT INTO `state` VALUES (4024, 237, 'Aragua', NULL, NULL);
INSERT INTO `state` VALUES (4025, 237, 'Barinas', NULL, NULL);
INSERT INTO `state` VALUES (4026, 237, 'Bolivar', NULL, NULL);
INSERT INTO `state` VALUES (4027, 237, 'Carabobo', NULL, NULL);
INSERT INTO `state` VALUES (4028, 237, 'Cojedes', NULL, NULL);
INSERT INTO `state` VALUES (4029, 237, 'Delta Amacuro', NULL, NULL);
INSERT INTO `state` VALUES (4030, 237, 'Distrito Federal', NULL, NULL);
INSERT INTO `state` VALUES (4031, 237, 'Falcon', NULL, NULL);
INSERT INTO `state` VALUES (4032, 237, 'Guarico', NULL, NULL);
INSERT INTO `state` VALUES (4033, 237, 'Lara', NULL, NULL);
INSERT INTO `state` VALUES (4034, 237, 'Merida', NULL, NULL);
INSERT INTO `state` VALUES (4035, 237, 'Miranda', NULL, NULL);
INSERT INTO `state` VALUES (4036, 237, 'Monagas', NULL, NULL);
INSERT INTO `state` VALUES (4037, 237, 'Nueva Esparta', NULL, NULL);
INSERT INTO `state` VALUES (4038, 237, 'Portuguesa', NULL, NULL);
INSERT INTO `state` VALUES (4039, 237, 'Sucre', NULL, NULL);
INSERT INTO `state` VALUES (4040, 237, 'Tachira', NULL, NULL);
INSERT INTO `state` VALUES (4041, 237, 'Trujillo', NULL, NULL);
INSERT INTO `state` VALUES (4042, 237, 'Vargas', NULL, NULL);
INSERT INTO `state` VALUES (4043, 237, 'Yaracuy', NULL, NULL);
INSERT INTO `state` VALUES (4044, 237, 'Zulia', NULL, NULL);
INSERT INTO `state` VALUES (4045, 238, 'Bac Giang', NULL, NULL);
INSERT INTO `state` VALUES (4046, 238, 'Binh Dinh', NULL, NULL);
INSERT INTO `state` VALUES (4047, 238, 'Binh Duong', NULL, NULL);
INSERT INTO `state` VALUES (4048, 238, 'Da Nang', NULL, NULL);
INSERT INTO `state` VALUES (4049, 238, 'Dong Bang Song Cuu Long', NULL, NULL);
INSERT INTO `state` VALUES (4050, 238, 'Dong Bang Song Hong', NULL, NULL);
INSERT INTO `state` VALUES (4051, 238, 'Dong Nai', NULL, NULL);
INSERT INTO `state` VALUES (4052, 238, 'Dong Nam Bo', NULL, NULL);
INSERT INTO `state` VALUES (4053, 238, 'Duyen Hai Mien Trung', NULL, NULL);
INSERT INTO `state` VALUES (4054, 238, 'Hanoi', NULL, NULL);
INSERT INTO `state` VALUES (4055, 238, 'Hung Yen', NULL, NULL);
INSERT INTO `state` VALUES (4056, 238, 'Khu Bon Cu', NULL, NULL);
INSERT INTO `state` VALUES (4057, 238, 'Long An', NULL, NULL);
INSERT INTO `state` VALUES (4058, 238, 'Mien Nui Va Trung Du', NULL, NULL);
INSERT INTO `state` VALUES (4059, 238, 'Thai Nguyen', NULL, NULL);
INSERT INTO `state` VALUES (4060, 238, 'Thanh Pho Ho Chi Minh', NULL, NULL);
INSERT INTO `state` VALUES (4061, 238, 'Thu Do Ha Noi', NULL, NULL);
INSERT INTO `state` VALUES (4062, 238, 'Tinh Can Tho', NULL, NULL);
INSERT INTO `state` VALUES (4063, 238, 'Tinh Da Nang', NULL, NULL);
INSERT INTO `state` VALUES (4064, 238, 'Tinh Gia Lai', NULL, NULL);
INSERT INTO `state` VALUES (4065, 239, 'Anegada', NULL, NULL);
INSERT INTO `state` VALUES (4066, 239, 'Jost van Dyke', NULL, NULL);
INSERT INTO `state` VALUES (4067, 239, 'Tortola', NULL, NULL);
INSERT INTO `state` VALUES (4068, 240, 'Saint Croix', NULL, NULL);
INSERT INTO `state` VALUES (4069, 240, 'Saint John', NULL, NULL);
INSERT INTO `state` VALUES (4070, 240, 'Saint Thomas', NULL, NULL);
INSERT INTO `state` VALUES (4071, 241, 'Alo', NULL, NULL);
INSERT INTO `state` VALUES (4072, 241, 'Singave', NULL, NULL);
INSERT INTO `state` VALUES (4073, 241, 'Wallis', NULL, NULL);
INSERT INTO `state` VALUES (4074, 242, 'Bu Jaydur', NULL, NULL);
INSERT INTO `state` VALUES (4075, 242, 'Wad-adh-Dhahab', NULL, NULL);
INSERT INTO `state` VALUES (4076, 242, 'al-\'Ayun', NULL, NULL);
INSERT INTO `state` VALUES (4077, 242, 'as-Samarah', NULL, NULL);
INSERT INTO `state` VALUES (4078, 243, '\'Adan', NULL, NULL);
INSERT INTO `state` VALUES (4079, 243, 'Abyan', NULL, NULL);
INSERT INTO `state` VALUES (4080, 243, 'Dhamar', NULL, NULL);
INSERT INTO `state` VALUES (4081, 243, 'Hadramaut', NULL, NULL);
INSERT INTO `state` VALUES (4082, 243, 'Hajjah', NULL, NULL);
INSERT INTO `state` VALUES (4083, 243, 'Hudaydah', NULL, NULL);
INSERT INTO `state` VALUES (4084, 243, 'Ibb', NULL, NULL);
INSERT INTO `state` VALUES (4085, 243, 'Lahij', NULL, NULL);
INSERT INTO `state` VALUES (4086, 243, 'Ma\'rib', NULL, NULL);
INSERT INTO `state` VALUES (4087, 243, 'Madinat San\'a', NULL, NULL);
INSERT INTO `state` VALUES (4088, 243, 'Sa\'dah', NULL, NULL);
INSERT INTO `state` VALUES (4089, 243, 'Sana', NULL, NULL);
INSERT INTO `state` VALUES (4090, 243, 'Shabwah', NULL, NULL);
INSERT INTO `state` VALUES (4091, 243, 'Ta\'izz', NULL, NULL);
INSERT INTO `state` VALUES (4092, 243, 'al-Bayda', NULL, NULL);
INSERT INTO `state` VALUES (4093, 243, 'al-Hudaydah', NULL, NULL);
INSERT INTO `state` VALUES (4094, 243, 'al-Jawf', NULL, NULL);
INSERT INTO `state` VALUES (4095, 243, 'al-Mahrah', NULL, NULL);
INSERT INTO `state` VALUES (4096, 243, 'al-Mahwit', NULL, NULL);
INSERT INTO `state` VALUES (4097, 244, 'Central Serbia', NULL, NULL);
INSERT INTO `state` VALUES (4098, 244, 'Kosovo and Metohija', NULL, NULL);
INSERT INTO `state` VALUES (4099, 244, 'Montenegro', NULL, NULL);
INSERT INTO `state` VALUES (4100, 244, 'Republic of Serbia', NULL, NULL);
INSERT INTO `state` VALUES (4101, 244, 'Serbia', NULL, NULL);
INSERT INTO `state` VALUES (4102, 244, 'Vojvodina', NULL, NULL);
INSERT INTO `state` VALUES (4103, 245, 'Central', NULL, NULL);
INSERT INTO `state` VALUES (4104, 245, 'Copperbelt', NULL, NULL);
INSERT INTO `state` VALUES (4105, 245, 'Eastern', NULL, NULL);
INSERT INTO `state` VALUES (4106, 245, 'Luapala', NULL, NULL);
INSERT INTO `state` VALUES (4107, 245, 'Lusaka', NULL, NULL);
INSERT INTO `state` VALUES (4108, 245, 'North-Western', NULL, NULL);
INSERT INTO `state` VALUES (4109, 245, 'Northern', NULL, NULL);
INSERT INTO `state` VALUES (4110, 245, 'Southern', NULL, NULL);
INSERT INTO `state` VALUES (4111, 245, 'Western', NULL, NULL);
INSERT INTO `state` VALUES (4112, 246, 'Bulawayo', NULL, NULL);
INSERT INTO `state` VALUES (4113, 246, 'Harare', NULL, NULL);
INSERT INTO `state` VALUES (4114, 246, 'Manicaland', NULL, NULL);
INSERT INTO `state` VALUES (4115, 246, 'Mashonaland Central', NULL, NULL);
INSERT INTO `state` VALUES (4116, 246, 'Mashonaland East', NULL, NULL);
INSERT INTO `state` VALUES (4117, 246, 'Mashonaland West', NULL, NULL);
INSERT INTO `state` VALUES (4118, 246, 'Masvingo', NULL, NULL);
INSERT INTO `state` VALUES (4119, 246, 'Matabeleland North', NULL, NULL);
INSERT INTO `state` VALUES (4120, 246, 'Matabeleland South', NULL, NULL);
INSERT INTO `state` VALUES (4121, 246, 'Midlands', NULL, NULL);

-- ----------------------------
-- Table structure for stock_mvt
-- ----------------------------
DROP TABLE IF EXISTS `stock_mvt`;
CREATE TABLE `stock_mvt`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `sign` tinyint(4) NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for support
-- ----------------------------
DROP TABLE IF EXISTS `support`;
CREATE TABLE `support`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_customer` int(10) UNSIGNED NOT NULL,
  `id_employee` int(10) UNSIGNED NOT NULL,
  `id_invoice_status` int(11) NULL DEFAULT NULL,
  `invoice_number` int(11) NULL DEFAULT NULL,
  `complain` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_payment` int(11) NULL DEFAULT NULL,
  `total_kg` decimal(8, 2) NULL DEFAULT NULL,
  `source` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `support_time` int(11) NULL DEFAULT 1,
  `id_leader` int(255) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `support_id_customer_index`(`id_customer`) USING BTREE,
  INDEX `support_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `support_id_invoice_status_index`(`id_invoice_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for work_category
-- ----------------------------
DROP TABLE IF EXISTS `work_category`;
CREATE TABLE `work_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of work_category
-- ----------------------------
INSERT INTO `work_category` VALUES (1, 'Sale', NULL, '2018-11-21 08:27:40', NULL);
INSERT INTO `work_category` VALUES (2, 'Skill', '2018-11-21 05:07:24', '2018-11-21 08:27:12', NULL);
INSERT INTO `work_category` VALUES (3, 'Experience', '2018-11-21 08:25:59', '2018-11-21 08:25:59', NULL);
INSERT INTO `work_category` VALUES (4, 'Complaint', '2018-11-21 08:26:10', '2018-11-21 08:26:10', NULL);
INSERT INTO `work_category` VALUES (5, 'Shipping', '2018-11-21 08:26:20', '2018-11-21 08:26:20', NULL);
INSERT INTO `work_category` VALUES (6, 'Payment', '2018-11-21 08:26:27', '2018-11-21 08:26:27', NULL);
INSERT INTO `work_category` VALUES (7, 'Products', '2018-11-21 08:26:34', '2018-11-21 08:26:34', NULL);
INSERT INTO `work_category` VALUES (8, 'Others', '2018-11-21 08:28:12', '2018-11-21 08:28:12', NULL);

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
  `archive` int(11) NOT NULL DEFAULT 0,
  `position` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_profile_id_employee_index`(`id_employee`) USING BTREE,
  INDEX `work_profile_id_leader_index`(`id_leader`) USING BTREE,
  INDEX `work_profile_id_work_category_index`(`id_work_category`) USING BTREE,
  INDEX `work_profile_id_procedure_index`(`id_procedure`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for work_profile_comment
-- ----------------------------
DROP TABLE IF EXISTS `work_profile_comment`;
CREATE TABLE `work_profile_comment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_work_profile` int(11) NOT NULL,
  `id_employee` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
