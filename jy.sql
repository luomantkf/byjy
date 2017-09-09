/*
Navicat MySQL Data Transfer

Source Server         : cloud
Source Server Version : 50552
Source Host           : localhost:3306
Source Database       : jy

Target Server Type    : MYSQL
Target Server Version : 50552
File Encoding         : 65001

Date: 2017-05-07 23:03:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `applyresume`
-- ----------------------------
DROP TABLE IF EXISTS `applyresume`;
CREATE TABLE `applyresume` (
  `applyResume_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `applyTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`applyResume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of applyresume
-- ----------------------------
INSERT INTO `applyresume` VALUES ('22', '12', '121', '1', '2017-05-07 20:44:33');
INSERT INTO `applyresume` VALUES ('23', '7', '121', '2', '2017-05-07 21:06:17');
INSERT INTO `applyresume` VALUES ('24', '11', '109', '2', '2017-05-07 22:59:53');
INSERT INTO `applyresume` VALUES ('25', '10', '109', '1', '2017-05-07 22:59:32');

-- ----------------------------
-- Table structure for `enterprise`
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise` (
  `enterprise_id` int(11) NOT NULL AUTO_INCREMENT,
  `enterpriseName` varchar(40) NOT NULL,
  `address` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `contactMan` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `website` varchar(20) NOT NULL,
  `evidence` varchar(40) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:未审核；1审核',
  PRIMARY KEY (`enterprise_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES ('1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `enterprise` VALUES ('4', '张', '1', '1', '1', '1', '1', '/static/word/1487688812595.xls', '0');
INSERT INTO `enterprise` VALUES ('8', '张', '1', '1', '1', '1', '1', '/static/word/1487690349478.xls', '1');
INSERT INTO `enterprise` VALUES ('9', '国泰', '重庆', '1321', '王看看', '415222', '416563', '/static/word/1487698348634.docx', '1');
INSERT INTO `enterprise` VALUES ('10', '国泰123', '123', '123', '123', '123', '123', '/static/word/1487699223579.docx', '1');
INSERT INTO `enterprise` VALUES ('11', '淘宝', '重庆', '13110123181', '张收费', '750498853@qq.com', 'www.cqupt.com', '/static/word/1487775940121.docx', '1');
INSERT INTO `enterprise` VALUES ('12', '国美企业', '北京', '11598268836', '王集', '750498853@qq.com', 'www.baidu.com', '/static/word/1488093458762.docx', '1');
INSERT INTO `enterprise` VALUES ('13', '腾讯', '北京', '13110123333', '五五', '7777777@qq.com', 'www.cqupt.com', '/static/word/1488336368259.docx', '1');
INSERT INTO `enterprise` VALUES ('14', '腾讯', '北京', '1311011111', '城房产', '753423423', 'www.baidu.com', '/static/word/1488351583638.docx', '1');

-- ----------------------------
-- Table structure for `job`
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_id` int(11) NOT NULL,
  `jobName` varchar(20) NOT NULL,
  `jobNeed` varchar(20) NOT NULL,
  `jobAddress` varchar(20) NOT NULL,
  `jobAmount` varchar(10) NOT NULL,
  `jobSalary` varchar(10) NOT NULL,
  `jobEndTime` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES ('5', '11', '啧啧啧', '1', '1', '1', '1', '2017-02-28 00:00:00', '1', '111');
INSERT INTO `job` VALUES ('7', '12', '前端', '请看看', '北京', '5', '1500/月', '2017-02-13 00:00:00', '1', '吾问无为谓无无无无无无无无无无无无无');
INSERT INTO `job` VALUES ('8', '11', 'ui设计', '会说话', '北京', '5人', '3000/月', '2017-02-14 00:00:00', '1', '吾问无为谓无无无无无无无无无无无');
INSERT INTO `job` VALUES ('10', '12', '后台', '踏实', '北京', '5', '2001', '2017-07-28 00:00:00', '1', '对对对');
INSERT INTO `job` VALUES ('11', '12', 'p图', '调试', '重庆', '3', '1000', '2017-02-23 00:00:00', '1', '的点点滴滴多');
INSERT INTO `job` VALUES ('12', '12', '前端工程师', '情况', '重庆', '3', '3000/月', '2017-02-28 00:00:00', '1', '设定的佛挡杀佛');

-- ----------------------------
-- Table structure for `manager`
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `manager_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(40) NOT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('1', '11111111');
INSERT INTO `manager` VALUES ('5', '11');
INSERT INTO `manager` VALUES ('6', '11');
INSERT INTO `manager` VALUES ('7', '11');
INSERT INTO `manager` VALUES ('9', '11');
INSERT INTO `manager` VALUES ('10', '123');
INSERT INTO `manager` VALUES ('11', '13110123111');

-- ----------------------------
-- Table structure for `resume`
-- ----------------------------
DROP TABLE IF EXISTS `resume`;
CREATE TABLE `resume` (
  `resume_id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) NOT NULL,
  `address` varchar(20) NOT NULL,
  `university` varchar(20) NOT NULL,
  `tongue` varchar(200) DEFAULT NULL,
  `skill` varchar(200) DEFAULT NULL,
  `introduce` varchar(200) DEFAULT NULL,
  `picture` varchar(50) NOT NULL,
  `resumeFile` varchar(50) DEFAULT NULL,
  `workExperience` varchar(200) DEFAULT NULL,
  `schoolExperience` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`resume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resume
-- ----------------------------
INSERT INTO `resume` VALUES ('2', '20', '重庆', '重邮', '重中之重', '重中之重', '重中之重', '/static/images/stuImg/1494163792475.png', '/static/images/stuImg/1494163792476.png', '重中之重1', '重中之重1');
INSERT INTO `resume` VALUES ('3', '20', '重庆', '重邮', '请求请求群', '请求请求群', '请求请求群', '/static/images/stuImg/1494169022242.png', '/static/images/stuImg/1494169066411.jpg', '请求请求群', '请求请求群');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_uid` int(11) NOT NULL AUTO_INCREMENT,
  `resume_id` int(11) DEFAULT NULL,
  `stuName` varchar(20) NOT NULL,
  `academy` varchar(20) NOT NULL,
  `stuID` varchar(20) NOT NULL,
  `sex` tinyint(4) NOT NULL,
  `idCard` varchar(40) NOT NULL,
  `education` varchar(20) NOT NULL,
  `workWhere` varchar(40) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `profession` varchar(20) DEFAULT NULL,
  `intention` varchar(20) DEFAULT NULL,
  `positionName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`stu_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('62', null, '李冰冰', '理学院', '2013212038', '0', '500108199505185545', '本科', '腾讯', '18883856295', '信息与计算科学', '产品经理', '产品经理');
INSERT INTO `student` VALUES ('63', null, '李强', '理学院', '2013210098', '1', '500109272823377002', '本科', '网易', '13309876524', '信息与计算科学', '运营经理', '运营经理');
INSERT INTO `student` VALUES ('64', null, '张峰', '理学院', '2013211023', '1', '500108277365266003', '本科', '百度', '15029283765', '信息与计算科学', '后台开发工程师', '后台开发工程师');
INSERT INTO `student` VALUES ('65', null, '王少', '理学院', '2013212345', '1', '500108277365293004', '本科', null, '13509837468', '信息与计算科学', '后台开发工程师', null);
INSERT INTO `student` VALUES ('66', null, '张三', '理学院', '2013212284', '1', '500108736520300005', '本科', null, '18262538212', '信息与计算科学', '后台开发工程师', null);
INSERT INTO `student` VALUES ('67', null, '王五', '理学院', '2013212836', '1', '500108277360283006', '研究生', '阿里', '13538263528', '应用数学', '后台开发工程师', '后台开发工程师');
INSERT INTO `student` VALUES ('68', null, '李克力', '理学院', '2013212363', '1', '500108128353700007', '研究生', '京东', '18373645272', '应用数学', '产品经理', '产品经理');
INSERT INTO `student` VALUES ('69', '3', '冯小封', '理学院', '2013212625', '0', '500108277360392008', '研究生', '蘑菇街', '18373649362', '应用数学', '产品经理', '产品经理');
INSERT INTO `student` VALUES ('70', null, '王大力', '理学院', '2013212843', '1', '500108277365202009', '本科', null, '13746282642', '应用数学', '运营经理', null);
INSERT INTO `student` VALUES ('71', null, '王娜', '理学院', '2013213022', '0', '500108277352020010', '本科', '顺丰', '18276352823', '应用数学', '运营经理', '运营经理');
INSERT INTO `student` VALUES ('72', null, '张利', '光电工程学院', '2013112930', '0', '500108277365267011', '本科', '腾讯', '18827258361', '集电', '运营经理', '运营经理');
INSERT INTO `student` VALUES ('73', null, '徐强', '光电工程学院', '2013112836', '1', '500108277365267012', '本科', '网易', '13526253733', '集电', '测试工程师', '测试工程师');
INSERT INTO `student` VALUES ('74', null, '钟涛', '光电工程学院', '2013110283', '1', '500108277365267013', '本科', '百度', '13922736251', '半导体', '测试工程师', '测试工程师');
INSERT INTO `student` VALUES ('75', null, '王杰', '光电工程学院', '2013112736', '1', '500108277365267014', '本科', null, '13847292634', '半导体', '测试工程师', null);
INSERT INTO `student` VALUES ('76', null, '王丽', '光电工程学院', '2013119376', '0', '500108277365267015', '本科', '腾讯', '18636752513', '半导体', '测试工程师', '测试工程师');
INSERT INTO `student` VALUES ('77', null, '张小龙', '传媒学院', '2013226364', '1', '500108277365267016', '本科', '网易', '13635274892', '编导', '产品经理', '产品经理');
INSERT INTO `student` VALUES ('78', null, '徐丽', '传媒学院', '2013234625', '0', '500108277365267017', '本科', '百度', '18763527293', '编导', '产品经理', '产品经理');
INSERT INTO `student` VALUES ('79', null, '刘婷', '传媒学院', '2013252537', '0', '500108277365267018', '本科', null, '17363562725', '编导', '平面设计', null);
INSERT INTO `student` VALUES ('80', null, '牟思思', '传媒学院', '2013228363', '0', '500108277365267019', '本科', '唯品会', '13847628239', '动画', '平面设计', '平面设计');
INSERT INTO `student` VALUES ('81', '2', '马俊', '传媒学院', '2013223725', '0', '500108277365267020', '本科', '网龙', '18373526253', '动画', '平面设计', '平面设计');

-- ----------------------------
-- Table structure for `userbase`
-- ----------------------------
DROP TABLE IF EXISTS `userbase`;
CREATE TABLE `userbase` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `userType` tinyint(4) NOT NULL COMMENT '1:毕业生；2：企业；3：管理员',
  `detail` int(11) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userbase
-- ----------------------------
INSERT INTO `userbase` VALUES ('43', 'zsf', 'ICy5YqxZB1uWSwcVLSNLcA==', '3', '10', '2017-02-18 21:28:41');
INSERT INTO `userbase` VALUES ('58', 'zhang', 'ICy5YqxZB1uWSwcVLSNLcA==', '2', '11', '2017-02-22 23:05:40');
INSERT INTO `userbase` VALUES ('61', '2015214273', 'qJ2x71fQhMtHBbQNhR4XOA==', '1', '27', '2017-02-25 17:00:45');
INSERT INTO `userbase` VALUES ('62', 'yjj', 'aY1RoZ2KEhzlgUmde3AWaA==', '2', '12', '2017-02-26 15:17:38');
INSERT INTO `userbase` VALUES ('63', 'aaa', 'aY1RoZ2KEhzlgUmde3AWaA==', '2', '0', '2017-02-28 01:57:58');
INSERT INTO `userbase` VALUES ('64', 'wsk', 'ICy5YqxZB1uWSwcVLSNLcA==', '3', '11', '2017-03-01 00:49:36');
INSERT INTO `userbase` VALUES ('70', 'wjh', 'ICy5YqxZB1uWSwcVLSNLcA==', '2', '13', '2017-03-01 10:46:08');
INSERT INTO `userbase` VALUES ('83', '2015214222', 'uPKBwS9pvH3pqvO/P9tgpw==', '1', '45', '2017-03-01 11:16:13');
INSERT INTO `userbase` VALUES ('84', '2015214223', 'TbmANBp6cf2Y350lqgf/7g==', '1', '46', '2017-03-01 11:16:13');
INSERT INTO `userbase` VALUES ('85', 'cy', 'ICy5YqxZB1uWSwcVLSNLcA==', '2', '14', '2017-03-01 14:59:43');
INSERT INTO `userbase` VALUES ('86', '1234', 'gdyb21LQTcIANtvYMT7QVQ==', '2', '0', '2017-03-01 19:07:29');
INSERT INTO `userbase` VALUES ('87', '2015214222', 'uPKBwS9pvH3pqvO/P9tgpw==', '1', '47', '2017-05-03 22:56:07');
INSERT INTO `userbase` VALUES ('89', '2015214222', 'TbmANBp6cf2Y350lqgf/7g==', '1', '49', '2017-05-03 22:56:07');
INSERT INTO `userbase` VALUES ('96', '2015214222', 'uPKBwS9pvH3pqvO/P9tgpw==', '1', '56', '2017-05-03 23:08:04');
INSERT INTO `userbase` VALUES ('97', '2015214223', 'TbmANBp6cf2Y350lqgf/7g==', '1', '57', '2017-05-03 23:08:04');
INSERT INTO `userbase` VALUES ('98', '2015214222', 'TbmANBp6cf2Y350lqgf/7g==', '1', '58', '2017-05-03 23:08:04');
INSERT INTO `userbase` VALUES ('99', '2015214222', 'uPKBwS9pvH3pqvO/P9tgpw==', '1', '59', '2017-05-04 11:29:45');
INSERT INTO `userbase` VALUES ('100', '2015214223', 'TbmANBp6cf2Y350lqgf/7g==', '1', '60', '2017-05-04 11:29:45');
INSERT INTO `userbase` VALUES ('101', '2015214222', 'TbmANBp6cf2Y350lqgf/7g==', '1', '61', '2017-05-04 11:29:45');
INSERT INTO `userbase` VALUES ('102', '2013212038', 'vN2d3kxLvs7YiKpCq9mFMw==', '1', '62', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('103', '2013210098', 'A5mu7CiVK1WwMMectIbz/A==', '1', '63', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('104', '2013211023', 't3X/RN2oq2JNLBzVDp4cKA==', '1', '64', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('105', '2013212345', '7k6Feyc1FCaHyUPyLBxd7A==', '1', '65', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('106', '2013212284', 'HOrStFAv1jM39De3EM7eYQ==', '1', '66', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('107', '2013212836', '3101OipUXT2tbdsMwmt2Yw==', '1', '67', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('108', '2013212363', 'aJDntDrG+kHri57cDN8R8w==', '1', '68', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('109', '2013212625', 'fzxAoxunSC35o3GAc+8JjA==', '1', '69', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('110', '2013212843', 'wRHiIJ3NJ1/5rEGBGBVWRw==', '1', '70', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('111', '2013213022', 'JqVVJF5oLr0rvC7d7efCxA==', '1', '71', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('112', '2013112930', 'ZBO7TU9hmHwIyxSa/SO1SQ==', '1', '72', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('113', '2013112836', 'kYoPMJXeRkyI7j0vg9J7NA==', '1', '73', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('114', '2013110283', 'AQgJm2fjlJiYFeIafom+Nw==', '1', '74', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('115', '2013112736', 'e6DLlZHzdAKkzAjNkIusHA==', '1', '75', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('116', '2013119376', '2AsDzMmzsGYgDSbney3NpQ==', '1', '76', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('117', '2013226364', 'EYlhWGHKoVlqYso/8IOXCg==', '1', '77', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('118', '2013234625', 'Ykh+p09vvn8JhivfvKMQcQ==', '1', '78', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('119', '2013252537', 'hyIyriJAB4HOmMH7h12ugw==', '1', '79', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('120', '2013228363', 'fggxEG65Xz/d2wZUXy4Ufw==', '1', '80', '2017-05-05 14:28:18');
INSERT INTO `userbase` VALUES ('121', '2013223725', 'mp9Y0Aiii5nYWSr91w96UA==', '1', '81', '2017-05-05 14:28:18');
