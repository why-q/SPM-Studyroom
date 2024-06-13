SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_id` varchar(32) NOT NULL COMMENT '管理员编号',
  `admin_name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='管理员';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES ('admin', 'mango', 'admin');
COMMIT;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `a_id` varchar(32) NOT NULL COMMENT '公告编号',
  `a_content` varchar(900) DEFAULT NULL COMMENT '公告内容',
  `a_state` int DEFAULT NULL COMMENT '公告状态',
  `a_begin_time` datetime DEFAULT NULL COMMENT '公告开始时间',
  `a_end_time` datetime DEFAULT NULL COMMENT '公告结束时间',
  `s_id` varchar(255) DEFAULT NULL COMMENT '发布者编号',
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='公告';

-- ----------------------------
-- Records of announcement
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `s_id` varchar(32) NOT NULL COMMENT '学号',
  `date_begin` date DEFAULT NULL COMMENT '开始时间',
  `date_end` date DEFAULT NULL COMMENT '结束时间',
  `state` varchar(32) DEFAULT NULL COMMENT '状态',
  `blacker_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设置者编号',
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='黑名单';

-- ----------------------------
-- Records of blacklist
-- ----------------------------
BEGIN;
INSERT INTO `blacklist` VALUES ('23210240261', '2022-09-01', '2022-09-16', '拉黑', 'admin');
COMMIT;

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom` (
  `room_id` varchar(32) NOT NULL COMMENT '教室编号',
  `room_name` varchar(255) DEFAULT NULL COMMENT '教室名称',
  `building_id` varchar(255) NOT NULL COMMENT '所属教学楼编号',
  `room_floor` varchar(32) DEFAULT NULL COMMENT '楼层',
  `available_seat` varchar(32) DEFAULT NULL COMMENT '可用座位数',
  `is_multimedia_room` varchar(32) DEFAULT NULL COMMENT '多媒体教室',
  PRIMARY KEY (`room_id`,`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='教室';

-- ----------------------------
-- Records of classroom
-- ----------------------------
BEGIN;
INSERT INTO `classroom` VALUES ('01', 'A-305', '1', '3', '10', '否');
INSERT INTO `classroom` VALUES ('02', 'A-103', '2', '1', '20', '是');
INSERT INTO `classroom` VALUES ('03', 'B-204', '3', '2', '30', '是');
INSERT INTO `classroom` VALUES ('04', 'B-508', '2', '5', '40', '否');
INSERT INTO `classroom` VALUES ('05', 'E-5006', '2', '5', '200', '否');
COMMIT;

-- ----------------------------
-- Table structure for room_available_time_info
-- ----------------------------
DROP TABLE IF EXISTS `room_available_time_info`;
CREATE TABLE `room_available_time_info` (
  `time_id` varchar(32) NOT NULL COMMENT '时段编号',
  `room_id` varchar(32) NOT NULL COMMENT '教室编号',
  `building_id` varchar(32) NOT NULL COMMENT '楼编号',
  `available_date` date NOT NULL COMMENT '日期',
  `reservation_num` varchar(32) DEFAULT NULL COMMENT '已预约人数',
  `available_num` varchar(32) DEFAULT NULL COMMENT '可预约人数',
  PRIMARY KEY (`time_id`,`room_id`,`building_id`,`available_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='教室可用时段';

-- ----------------------------
-- Records of room_available_time_info
-- ----------------------------
BEGIN;
INSERT INTO `room_available_time_info` VALUES ('1', '01', '1', '2024-06-13', '4', '86');
INSERT INTO `room_available_time_info` VALUES ('1', '01', '1', '2024-09-12', '0', '90');
INSERT INTO `room_available_time_info` VALUES ('1', '02', '2', '2024-06-13', '3', '17');
INSERT INTO `room_available_time_info` VALUES ('10', '02', '2', '2024-06-13', '2', '18');
INSERT INTO `room_available_time_info` VALUES ('11', '02', '2', '2024-06-13', '0', '20');
INSERT INTO `room_available_time_info` VALUES ('12', '02', '2', '2024-06-13', '1', '19');
INSERT INTO `room_available_time_info` VALUES ('2', '01', '1', '2024-06-13', '0', '90');
INSERT INTO `room_available_time_info` VALUES ('3', '01', '1', '2024-06-13', '1', '89');
INSERT INTO `room_available_time_info` VALUES ('4', '02', '2', '2024-06-13', '1', '19');
INSERT INTO `room_available_time_info` VALUES ('5', '02', '2', '2024-06-13', '1', '19');
INSERT INTO `room_available_time_info` VALUES ('6', '02', '2', '2024-06-13', '0', '20');
INSERT INTO `room_available_time_info` VALUES ('7', '01', '1', '2024-06-13', '1', '89');
INSERT INTO `room_available_time_info` VALUES ('8', '01', '1', '2024-06-13', '0', '90');
INSERT INTO `room_available_time_info` VALUES ('9', '01', '1', '2024-06-13', '0', '90');
COMMIT;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_id` varchar(32) NOT NULL COMMENT '学号',
  `s_name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `s_class` varchar(255) DEFAULT NULL COMMENT '班级',
  `s_year` varchar(32) DEFAULT NULL COMMENT '年级',
  `s_major` varchar(255) DEFAULT NULL COMMENT '专业',
  `s_phone_number` varchar(255) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='学生';

-- ----------------------------
-- Records of student
-- ----------------------------
BEGIN;
INSERT INTO `student` VALUES ('23210240114', '陈小夜', '111', '2024', '2', '电子信息工程', '110');
INSERT INTO `student` VALUES ('23210240041', '凌天青', '111', '2023', '3', '电子信息工程', '110');
INSERT INTO `student` VALUES ('23210240120', '姚和暄', '111', '2023', '3', '马克思', '110');
INSERT INTO `student` VALUES ('23210240137', '丘程', '111', '2024', '4', '数学', '110');
INSERT INTO `student` VALUES ('23210240173', '卫黎', '111', '2024', '1', '数学', '110');
INSERT INTO `student` VALUES ('23210240199', '以曦之', '111', '2023', '1', '马克思', '110');
INSERT INTO `student` VALUES ('23210240257', '诸思成', '111', '2023', '2', '马克思', '110');
INSERT INTO `student` VALUES ('23210240261', '楚涵柳', '111', '2023', '4', '马克思', '110');
INSERT INTO `student` VALUES ('23210240272', '师梦竹', '3837', '2022', '3', '电子信息工程', '110');
INSERT INTO `student` VALUES ('23210240280', '本心诺', '111', '2023', '4', '文学', '110');
INSERT INTO `student` VALUES ('23210240286', '荆山菡', '111', '2023', '1', '文学', '110');
INSERT INTO `student` VALUES ('admin', '管理员', '111', '', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for student_reservation
-- ----------------------------
DROP TABLE IF EXISTS `student_reservation`;
CREATE TABLE `student_reservation` (
  `s_id` varchar(32) NOT NULL COMMENT '学号',
  `time_id` varchar(32) NOT NULL COMMENT '时段编号',
  `room_id` varchar(32) NOT NULL COMMENT '教室编号',
  `building_id` varchar(32) NOT NULL COMMENT '楼编号',
  `reservation_date` date NOT NULL COMMENT '预约日期',
  `state` varchar(32) DEFAULT NULL COMMENT '状态',
  `room_name` varchar(32) DEFAULT NULL COMMENT '教室名称',
  PRIMARY KEY (`s_id`,`time_id`,`room_id`,`building_id`,`reservation_date`),
  CONSTRAINT `f01` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='自习预约信息';

-- ----------------------------
-- Records of student_reservation
-- ----------------------------
BEGIN;
INSERT INTO `student_reservation` VALUES ('23210240114', '1', '01', '1', '2024-06-13', '预约取消', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '1', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240114', '10', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240114', '3', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '8', '01', '1', '2024-06-13', '预约取消', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '2', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '1', '01', '1', '2024-06-12', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '1', '02', '2', '2024-06-12', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240114', '10', '02', '2', '2024-06-12', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240114', '3', '01', '1', '2024-06-12', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '8', '01', '1', '2024-06-12', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240114', '2', '01', '1', '2024-06-12', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240041', '11', '02', '2', '2024-06-13', '预约取消', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240041', '2', '01', '1', '2024-06-13', '预约取消', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240041', '4', '02', '2', '2024-06-13', '预约取消', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240042', '7', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240137', '1', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240137', '1', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240137', '10', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210240272', '1', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210240272', '1', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210249081', '1', '01', '1', '2024-06-13', '预约成功', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210249081', '12', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210249081', '2', '01', '1', '2024-06-13', '预约取消', 'A-305');
INSERT INTO `student_reservation` VALUES ('23210249081', '4', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210249081', '5', '02', '2', '2024-06-13', '预约成功', 'A-103');
INSERT INTO `student_reservation` VALUES ('23210249081', '6', '02', '2', '2024-06-13', '预约取消', 'A-103');
COMMIT;

-- ----------------------------
-- Table structure for t_building
-- ----------------------------
DROP TABLE IF EXISTS `t_building`;
CREATE TABLE `t_building` (
  `building_id` varchar(32) NOT NULL COMMENT '楼编号',
  `building_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '楼名称',
  `building_phone_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话',
  `building_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所在校区',
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='教学楼';

-- ----------------------------
-- Records of t_building
-- ----------------------------
BEGIN;
INSERT INTO `t_building` VALUES ('1', '逸夫楼', '110', '邯郸校区');
INSERT INTO `t_building` VALUES ('2', '逸夫科技楼', '110', '邯郸校区');
INSERT INTO `t_building` VALUES ('3', '智华楼', '110', '江湾校区');
INSERT INTO `t_building` VALUES ('4', '计算机交叉信息楼', '110', '江湾校区');
COMMIT;

-- ----------------------------
-- Table structure for time_table
-- ----------------------------
DROP TABLE IF EXISTS `time_table`;
CREATE TABLE `time_table` (
  `time_id` varchar(32) NOT NULL COMMENT '时段编号',
  `time_name` varchar(255) DEFAULT NULL COMMENT '时段名称',
  `time_begin` time DEFAULT NULL COMMENT '开始时间',
  `time_end` time DEFAULT NULL COMMENT '结束时间',
  `room_id` varchar(32) NOT NULL COMMENT '教室编号',
  `building_id` varchar(32) NOT NULL COMMENT '教学楼',
  PRIMARY KEY (`time_id`,`room_id`,`building_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='时段表';

-- ----------------------------
-- Records of time_table
-- ----------------------------
BEGIN;
INSERT INTO `time_table` VALUES ('1', '早七', '07:00:00', '08:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('1', '早七', '07:00:00', '08:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('1', '早七', '07:00:00', '08:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('10', '午四', '16:00:00', '17:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('10', '午四', '16:00:00', '17:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('10', '午四', '16:00:00', '17:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('11', '午五', '17:00:00', '18:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('11', '午五', '17:00:00', '18:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('11', '午五', '17:00:00', '18:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('12', '午六', '18:00:00', '19:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('12', '午六', '18:00:00', '19:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('12', '午六', '18:00:00', '19:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('2', '早八', '08:00:00', '09:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('2', '早八', '08:00:00', '09:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('2', '早八', '08:00:00', '09:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('3', '早九', '09:00:00', '10:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('3', '早九', '09:00:00', '10:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('3', '早九', '09:00:00', '10:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('4', '早十', '10:00:00', '11:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('4', '早十', '10:00:00', '11:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('4', '早十', '10:00:00', '11:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('5', '早十一', '11:00:00', '12:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('5', '早十一', '11:00:00', '12:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('5', '早十一', '11:00:00', '12:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('6', '午〇', '12:00:00', '13:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('6', '午〇', '12:00:00', '13:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('6', '午〇', '12:00:00', '13:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('7', '午一', '13:00:00', '14:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('7', '午一', '13:00:00', '14:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('7', '午一', '13:00:00', '14:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('8', '午二', '14:00:00', '15:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('8', '午二', '14:00:00', '15:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('8', '午二', '14:00:00', '15:00:00', '03', '3');
INSERT INTO `time_table` VALUES ('9', '午三', '15:00:00', '16:00:00', '01', '1');
INSERT INTO `time_table` VALUES ('9', '午三', '15:00:00', '16:00:00', '02', '2');
INSERT INTO `time_table` VALUES ('9', '午三', '15:00:00', '16:00:00', '03', '3');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
