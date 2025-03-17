/*
 Navicat Premium Data Transfer

 Source Server         : yueshuDB
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 8.134.215.8:3306
 Source Schema         : smartdata

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 14/10/2024 11:48:42
*/
--
-- Current Database: `smartdata`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `smartdata` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `smartdata`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_audit_config
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_audit_config`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '安全策略ID',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略标题',
  `config_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略描述',
  `level` int(1) NULL DEFAULT NULL COMMENT '安全策略等级0低1中2高',
  `warn_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略告警方式',
  `status` int(1) NULL DEFAULT NULL COMMENT '安全策略状态0启用 1禁用',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_scope` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用范围',
  `oper_type` int(1) NULL DEFAULT NULL COMMENT '操作类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_audit_item
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_audit_item`;
CREATE TABLE IF NOT EXISTS `sys_audit_item`  (
  `id` int(4) NOT NULL COMMENT '策略ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '策略标题',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应组件名称',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0 有效 1失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_audit_item
-- ----------------------------
INSERT INTO `sys_audit_item` VALUES (1, '数据库用户', 'UserComp', 0);
INSERT INTO `sys_audit_item` VALUES (2, '源IP', 'SrcIpComp', 0);
INSERT INTO `sys_audit_item` VALUES (4, '数据库', 'DbTypeComp', 0);
INSERT INTO `sys_audit_item` VALUES (5, '操作', 'OperComp', 0);
INSERT INTO `sys_audit_item` VALUES (6, '对象', 'ObjComp', 0);
INSERT INTO `sys_audit_item` VALUES (7, 'SQL执行状态', 'StatComp', 0);
INSERT INTO `sys_audit_item` VALUES (8, '响应大小', 'RespSizeComp', 0);
INSERT INTO `sys_audit_item` VALUES (9, '响应时间', 'RespTimeComp', 0);
INSERT INTO `sys_audit_item` VALUES (10, '影响行数', 'EffectRowsComp', 0);
INSERT INTO `sys_audit_item` VALUES (11, '对象', 'FieldComp', 1);
INSERT INTO `sys_audit_item` VALUES (12, '时间', 'TimeComp', 0);
INSERT INTO `sys_audit_item` VALUES (13, '语句', 'SqlLangComp', 0);
INSERT INTO `sys_audit_item` VALUES (14, '时段', 'TimePartComp', 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE IF NOT EXISTS `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称2', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2023-11-22 07:31:34', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户登录-OIDC认证域名', 'sys.login.ssoUrl', 'http://sso.dataleapinfo.cn', 'Y', 'admin', '2023-12-06 16:51:34', '', NULL, '设置OIDC认证域名');
INSERT INTO `sys_config` VALUES (8, '用户登录-客户端ID', 'sys.login.clientId', '6548e1f8dff21aa6f65e159d', 'Y', 'admin', '2023-12-06 16:53:12', '', NULL, '设置OIDC客户端编号');
INSERT INTO `sys_config` VALUES (9, '用户登录-客户端密钥', 'sys.login.secret', '1f0b227643425d4a439379d927b66794', 'Y', 'admin', '2023-12-06 16:54:50', '', NULL, '设置OIDC客户端密钥');
INSERT INTO `sys_config` VALUES (100, '告警方式-邮箱告警', 'sys.warn.mail', '0', 'N', 'admin', '2024-06-04 19:31:07', '', '2024-07-15 16:04:22', NULL);
INSERT INTO `sys_config` VALUES (101, '告警方式-短信告警', 'sys.warn.sms', '1', 'N', 'admin', '2024-06-04 19:31:07', '', '2024-07-15 16:04:21', NULL);
INSERT INTO `sys_config` VALUES (102, '告警方式-微信公众号', 'sys.warn.wx', '1', 'N', 'admin', '2024-06-04 19:31:07', '', '2024-07-15 16:04:21', NULL);
INSERT INTO `sys_config` VALUES (103, '告警方式-钉钉', 'sys.warn.ding', '0', 'N', 'admin', '2024-06-04 19:31:07', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (104, '告警方式-企业微信', 'sys.warn.enp', '0', 'N', 'admin', '2024-06-04 19:31:07', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (105, '邮件服务器', 'sys.mail.host', 'smtp.qq.com', 'Y', '', NULL, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (106, '邮件服务器端口', 'sys.mail.port', '465', 'Y', '', NULL, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (107, '系统邮件发送人', 'sys.mail.userId', '979401667', 'Y', '', NULL, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (108, '系统邮件发送人密码', 'sys.mail.pwd', 'xavtexjzdfiubajb', 'Y', '', NULL, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (109, '系统邮件发送人邮箱', 'sys.mail.sendbox', '979401667@qq.com', 'Y', '', NULL, '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dataoper_authlog
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_dataoper_authlog`;
CREATE TABLE IF NOT EXISTS `sys_dataoper_authlog`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `config_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oper_time` datetime NULL DEFAULT NULL,
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tar_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `database_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oper_object` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sql_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conn_num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `response_size` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `response_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `affect_rows` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `affect_conts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sqllang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `db_id` int(10) NULL DEFAULT NULL,
  `trigger` int(10) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 219 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dataoper_authlog
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dataoper_log
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_dataoper_log`;
CREATE TABLE IF NOT EXISTS `sys_dataoper_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `oper_time` datetime NULL DEFAULT NULL,
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `src_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tar_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `database_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oper_object` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sql_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conn_num` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `response_size` int(10) NULL DEFAULT NULL,
  `response_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `affect_rows` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `affect_conts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sqllang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `trigger` int(1) NULL DEFAULT NULL COMMENT '触发来源0 编辑器1工单',
  `db_id` int(10) NULL DEFAULT NULL COMMENT '数据资产ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 490 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dataoper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE IF NOT EXISTS `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '默认', 0, '', '', '', '0', '0', 'admin', '2023-11-22 07:31:25', '', NULL);

-- ----------------------------
-- Table structure for sys_desen_config
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_desen_config`;
CREATE TABLE IF NOT EXISTS `sys_desen_config`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '脱敏配置编号',
  `desen_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏配置名称',
  `desen_reg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏表达式',
  `desen_type` int(1) NULL DEFAULT NULL COMMENT '脱敏策略0隐藏 1中间打码1位 2中间打码4位 3两边打码1位',
  `status` int(1) NULL DEFAULT NULL COMMENT '脱敏配置状态0启用 1禁用',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_desen_config
-- ----------------------------
INSERT INTO `sys_desen_config` VALUES (1, '用户手机', '^1[3-9]\\d{9}$', 4, 0, 'admin', '2024-05-29 22:39:05', 'admin', '2024-08-27 13:52:08');
INSERT INTO `sys_desen_config` VALUES (2, '身份证号', '^[1-9]\\d{5}(18|19|20)\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}(\\d|X|x)$', 4, 0, 'admin', '2024-05-29 22:56:15', 'admin', '2024-08-27 13:51:58');
INSERT INTO `sys_desen_config` VALUES (3, '电子邮箱', '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$', 4, 0, 'admin', '2024-05-29 22:58:12', 'admin', '2024-08-27 13:51:14');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE IF NOT EXISTS `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-11-22 07:31:34', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE IF NOT EXISTS `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-11-22 07:31:33', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE IF NOT EXISTS `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0 0/5 * * * ?', '3', '1', '0', 'admin', '2023-11-22 07:31:35', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2023-11-22 07:31:35', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2023-11-22 07:31:35', '', NULL, '');
INSERT INTO `sys_job` VALUES (4, '系统监控', 'DEFAULT', 'ryTask.ryMoniterServer', '0 0/2 * * * ?', '3', '1', '0', 'admin', '2023-11-22 07:31:35', '', NULL, '');
-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE IF NOT EXISTS `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81557 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE IF NOT EXISTS `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2697 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE IF NOT EXISTS `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址 必需唯一',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
	`valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '授权标记（0授权 1未授权）',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (2, '数据使用', 0, 3, 'dbquery', '', '', 1, 0, 'M', '0', '0', '', 'ri:menu-search-line', 'admin', '2023-11-22 07:31:26', 'admin', '2024-09-14 11:16:48', '系统监控目录','0');
INSERT INTO `sys_menu` VALUES (3, '安全策略', 0, 4, 'security', '', '', 1, 0, 'M', '0', '0', '', 'ep:key', 'admin', '2023-11-22 07:31:26', 'admin', '2024-06-10 14:47:12', '系统工具目录','0');
INSERT INTO `sys_menu` VALUES (109, '工作台', 2, 1, 'dashboard', 'dbmgt/dashboard/index', '', 1, 0, 'M', '1', '1', '', 'ri:dashboard-line', 'admin', '2023-11-22 07:31:27', 'admin', '2024-07-22 09:28:21', '在线用户菜单','0');
INSERT INTO `sys_menu` VALUES (110, '运维工作台', 2, 2, 'query', 'dbmgt/query/index', '', 1, 0, 'M', '0', '0', '', 'ri:menu-search-line', 'admin', '2023-11-22 07:31:27', 'admin', '2024-09-14 11:17:07', '定时任务菜单','0');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'acl:user:resetpwd', '#', 'admin', '2023-11-22 07:31:27', 'admin', '2024-07-17 10:54:41', '','0');
INSERT INTO `sys_menu` VALUES (2000, '资产管理', 0, 2, 'dbmgt', '', NULL, 1, 0, 'M', '0', '0', '', 'ep:coin', 'admin', '2023-12-03 11:17:03', 'admin', '2024-09-14 11:18:09', '','0');
INSERT INTO `sys_menu` VALUES (2001, '数据库资产', 2000, 2, 'db', 'system/db/index', NULL, 1, 0, 'M', '0', '0', 'system:databaseinfo:list', 'ri:database-2-line', 'admin', '2023-12-03 11:19:52', 'admin', '2024-09-14 11:18:36', '','0');
INSERT INTO `sys_menu` VALUES (2002, '数据统计', 2000, 1, 'dashboardstat', 'dbmgt/dashboard/index', NULL, 1, 0, 'M', '1', '1', '', 'ri:pie-chart-2-line', 'admin', '2023-12-03 12:53:14', 'admin', '2024-07-22 09:27:25', '','0');
INSERT INTO `sys_menu` VALUES (2004, '凭证管理', 2000, 4, 'credential', 'dbmgt/credential/index', NULL, 1, 0, 'M', '0', '0', '', 'ri:key-2-line', 'admin', '2024-06-10 14:40:59', 'admin', '2024-07-14 23:35:09', '','0');
INSERT INTO `sys_menu` VALUES (2006, '安全监控', 3, 1, 'monitorindex', 'security/monitorindex/index', NULL, 1, 0, 'M', '0', '0', 'system:monitorindex:list', 'ep:data-line', 'admin', '2024-06-10 14:48:35', 'admin', '2024-09-29 09:53:14', '','0');
INSERT INTO `sys_menu` VALUES (2008, '操作命令', 3, 4, 'command', 'security/command/index', NULL, 1, 0, 'M', '1', '1', '', 'ri:slash-commands', 'admin', '2024-06-10 14:50:47', 'admin', '2024-07-22 09:28:37', '','0');
INSERT INTO `sys_menu` VALUES (2010, '监控策略', 3, 6, 'monitor', 'security/monitor/index', NULL, 1, 0, 'M', '1', '1', '', 'ep:monitor', 'admin', '2024-06-10 14:52:26', 'admin', '2024-07-22 09:28:47', '','0');
INSERT INTO `sys_menu` VALUES (2011, '告警配置', 3, 7, 'alert', 'security/alert/index', NULL, 1, 0, 'M', '1', '1', 'system:warntype:list', 'ri:file-warning-line', 'admin', '2024-06-10 14:53:15', 'admin', '2024-07-22 09:29:37', '','0');
INSERT INTO `sys_menu` VALUES (2016, '数据日志', 0, 6, 'datalog', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'ri:archive-2-fill', 'admin', '2024-06-10 14:57:03', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2017, '系统日志', 2016, 1, 'systemlog', 'datalog/system/index', NULL, 1, 0, 'M', '0', '0', 'usermonitor:userlog:list', 'ri:archive-drawer-fill', 'admin', '2024-06-10 14:57:35', 'admin', '2024-07-15 16:15:36', '','0');
INSERT INTO `sys_menu` VALUES (2019, '数据日志', 2016, 3, 'data', 'datalog/data/index', NULL, 1, 0, 'M', '1', '0', 'data:operlog:list', 'ri:archive-stack-fill', 'admin', '2024-06-10 14:58:59', 'admin', '2024-07-27 18:02:17', '','0');
INSERT INTO `sys_menu` VALUES (2020, '审批日志', 2016, 4, 'approvallog', 'datalog/approvallog/index', NULL, 1, 0, 'M', '1', '0', 'data:worksheetlog:list', 'ri:archive-2-fill', 'admin', '2024-06-10 14:59:31', 'admin', '2024-07-25 16:13:00', '','0');
INSERT INTO `sys_menu` VALUES (2021, '系统管理', 0, 8, 'setting', '', NULL, 1, 0, 'M', '0', '0', '', 'ep:setting', 'admin', '2024-06-10 15:00:21', 'admin', '2024-09-26 11:00:31', '','0');
INSERT INTO `sys_menu` VALUES (2022, '系统概况', 2021, 1, 'info', 'setting/info/index', NULL, 1, 0, 'M', '0', '0', '', 'ri:folder-info-line', 'admin', '2024-06-10 15:00:56', 'admin', '2024-07-15 16:22:28', '','0');
INSERT INTO `sys_menu` VALUES (2023, '许可信息', 2021, 2, 'license', 'setting/license/index', NULL, 1, 0, 'M', '0', '0', '', 'ri:police-badge-line', 'admin', '2024-06-10 15:02:07', 'admin', '2024-07-15 16:22:56', '','0');
INSERT INTO `sys_menu` VALUES (2026, '系统升级', 2021, 4, 'upgrade', 'setting/upgrade/index', NULL, 1, 0, 'M', '0', '0', '', 'ri:upload-cloud-2-line', 'admin', '2024-06-10 15:04:52', 'admin', '2024-07-15 16:23:35', '','0');
INSERT INTO `sys_menu` VALUES (2029, '资产查询', 2001, 1, '', '', NULL, 1, 0, 'F', '0', '0', 'system:databaseinfo:query', '#', 'admin', '2024-07-14 23:37:48', 'admin', '2024-07-15 09:41:44', '','0');
INSERT INTO `sys_menu` VALUES (2030, '新增数据资产', 2001, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:databaseinfo:add', '#', 'admin', '2024-07-14 23:38:17', 'admin', '2024-07-15 14:44:16', '','0');
INSERT INTO `sys_menu` VALUES (2031, '修改数据资产', 2001, 3, '', '', NULL, 1, 0, 'F', '0', '0', 'system:databaseinfo:edit', '#', 'admin', '2024-07-14 23:38:40', 'admin', '2024-07-15 14:44:34', '','0');
INSERT INTO `sys_menu` VALUES (2032, '删除数据资产', 2001, 4, '', '', NULL, 1, 0, 'F', '0', '0', 'system:databaseinfo:remove', '#', 'admin', '2024-07-14 23:38:59', 'admin', '2024-07-15 14:44:44', '','0');
INSERT INTO `sys_menu` VALUES (2038, '新增', 2006, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:monitorindex:add', '#', 'admin', '2024-07-15 15:30:05', 'admin', '2024-07-15 15:31:52', '','0');
INSERT INTO `sys_menu` VALUES (2039, '修改', 2006, 3, '', '', NULL, 1, 0, 'F', '0', '0', 'system:monitorindex:edit', '#', 'admin', '2024-07-15 15:31:08', 'admin', '2024-07-15 15:32:00', '','0');
INSERT INTO `sys_menu` VALUES (2040, '查询', 2006, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:monitorindex:query', '#', 'admin', '2024-07-15 15:31:45', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2041, '删除', 2006, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:monitorindex:remove', '#', 'admin', '2024-07-15 15:32:33', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2042, '查询策略', 2007, 1, '', '', NULL, 1, 0, 'F', '0', '0', 'system:securityconfig:query', '#', 'admin', '2024-07-15 15:35:22', 'admin', '2024-07-17 11:20:19', '','0');
INSERT INTO `sys_menu` VALUES (2043, '新增策略', 2007, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:securityconfig:add', '#', 'admin', '2024-07-15 15:35:42', 'admin', '2024-07-17 11:19:33', '','0');
INSERT INTO `sys_menu` VALUES (2044, '修改策略', 2007, 3, '', '', NULL, 1, 0, 'F', '0', '0', 'system:securityconfig:edit', '#', 'admin', '2024-07-15 15:36:22', 'admin', '2024-07-17 11:19:41', '','0');
INSERT INTO `sys_menu` VALUES (2045, '删除策略', 2007, 4, '', '', NULL, 1, 0, 'F', '0', '0', 'system:securityconfig:remove', '#', 'admin', '2024-07-15 15:36:42', 'admin', '2024-07-17 11:19:49', '','0');
INSERT INTO `sys_menu` VALUES (2046, '查询策略', 2028, 1, '', '', NULL, 1, 0, 'F', '0', '0', 'system:auditconfig:query', '#', 'admin', '2024-07-15 15:41:08', 'admin', '2024-07-17 11:20:29', '','0');
INSERT INTO `sys_menu` VALUES (2047, '新增策略', 2028, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:auditconfig:add', '#', 'admin', '2024-07-15 15:41:30', 'admin', '2024-07-17 11:20:42', '','0');
INSERT INTO `sys_menu` VALUES (2048, '修改策略', 2028, 3, '', '', NULL, 1, 0, 'F', '0', '0', 'system:auditconfig:edit', '#', 'admin', '2024-07-15 15:41:43', 'admin', '2024-07-17 11:20:45', '','0');
INSERT INTO `sys_menu` VALUES (2049, '删除策略', 2028, 4, '', '', NULL, 1, 0, 'F', '0', '0', 'system:auditconfig:remove', '#', 'admin', '2024-07-15 15:41:55', 'admin', '2024-07-17 11:20:49', '','0');
INSERT INTO `sys_menu` VALUES (2056, '修改告警配置', 2011, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:warntype:edit', '#', 'admin', '2024-07-15 16:06:32', 'admin', '2024-07-17 11:34:53', '','0');
INSERT INTO `sys_menu` VALUES (2058, '审计日志', 2016, 5, 'auditlog', 'datalog/auditlog/index', NULL, 1, 0, 'M', '0', '0', 'data:auditlog:list', 'ri:archive-2-fill', 'admin', '2024-07-15 16:11:45', 'admin', '2024-07-17 07:12:11', '','0');
INSERT INTO `sys_menu` VALUES (2059, '连接测试', 2001, 5, '', NULL, NULL, 1, 0, 'F', '1', '0', 'system:databaseinfo:test', '#', 'admin', '2024-07-17 11:00:07', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2060, '禁用数据资产', 2001, 6, '', NULL, NULL, 1, 0, 'F', '1', '0', 'system:databaseinfo:disable', '#', 'admin', '2024-07-17 11:00:38', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2061, 'SNMP设置', 2001, 7, '', NULL, NULL, 1, 0, 'F', '1', '0', 'system:databaseinfo:snmp', '#', 'admin', '2024-07-17 11:00:57', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2062, '设置策略', 2007, 5, '', '', NULL, 1, 0, 'F', '1', '0', 'system:securityconfig:setting', '#', 'admin', '2024-07-17 11:18:32', 'admin', '2024-07-17 11:20:00', '','0');
INSERT INTO `sys_menu` VALUES (2063, '设置策略', 2028, 5, '', '', NULL, 1, 0, 'F', '1', '0', 'system:auditconfig:setting', '#', 'admin', '2024-07-17 11:21:15', 'admin', '2024-07-17 11:21:31', '','0');
INSERT INTO `sys_menu` VALUES (2064, '数据库巡检', 2, 3, 'inspect', 'dbmgt/inspect/index', NULL, 1, 0, 'M', '0', '0', '', 'ep:operation', 'admin', '2024-07-18 08:22:09', 'admin', '2024-09-14 11:17:42', '','0');
INSERT INTO `sys_menu` VALUES (2071, '新建巡检任务', 2064, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:task:add', '#', 'admin', '2024-07-29 09:00:32', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2072, '修改巡检任务', 2064, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:task:edit', '#', 'admin', '2024-07-29 09:01:36', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2073, '浏览巡检任务', 2064, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:task:list', '#', 'admin', '2024-07-29 09:02:19', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2074, '一键巡检', 2064, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:task:excuete', '#', 'admin', '2024-07-29 09:06:14', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2075, '执行语句', 2003, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:databaseexcute:verify', '#', 'admin', '2024-07-29 09:14:16', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2076, '内置策略开关', 2007, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:securityrule:add', '#', 'admin', '2024-08-06 08:50:11', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2077, '资产分组', 2000, 1, 'datagroup', 'system/group/index', NULL, 1, 0, 'M', '0', '0', '', 'ep:folder', 'admin', '2024-08-22 16:19:56', 'admin', '2024-08-22 23:25:11', '','0');
INSERT INTO `sys_menu` VALUES (2078, '资产组查询', 2077, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:datagroup:query', '#', 'admin', '2024-08-22 16:23:11', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2079, '新增资产组', 2077, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:datagroup:add', '#', 'admin', '2024-08-22 16:24:05', 'admin', '2024-08-22 16:24:15', '','0');
INSERT INTO `sys_menu` VALUES (2080, '修改资产组', 2077, 3, '', '', NULL, 1, 0, 'F', '0', '0', 'system:datagroup:edit', '#', 'admin', '2024-08-22 16:24:52', 'admin', '2024-08-22 16:25:01', '','0');
INSERT INTO `sys_menu` VALUES (2081, '删除资产组', 2077, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:datagroup:remove', '#', 'admin', '2024-08-22 16:26:05', '', NULL, '','0');
INSERT INTO `sys_menu` VALUES (2099, '巡检模版', 2, 4, 'template', 'dbmgt/template/index', NULL, 1, 0, 'M', '0', '0', '', 'ri:article-line', 'admin', '2024-10-08 13:39:52', 'admin', '2024-10-08 13:40:03', '','0');
INSERT INTO `sys_menu` VALUES (2100, '新建巡检模版', 2099, 1, '', '', NULL, 1, 0, 'F', '0', '0', 'system:chktempleitem:add', '#', 'admin', '2024-10-08 13:41:40', 'admin', '2024-10-09 14:34:05', '','0');
INSERT INTO `sys_menu` VALUES (2101, '修改巡检模版', 2099, 2, '', '', NULL, 1, 0, 'F', '0', '0', 'system:chktempleitem:edit', '#', 'admin', '2024-10-08 13:43:03', 'admin', '2024-10-09 14:34:14', '','0');
INSERT INTO `sys_menu` VALUES (2102, '终端资产', 2000, 3, 'terminal', 'dbmgt/terminal/index', NULL, 1, 0, 'M', '0', '0', NULL, 'ri:terminal-box-line', 'admin', '2025-01-20 12:00:00', '', NULL, '', '0');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE IF NOT EXISTS `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  `content` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci null COMMENT '日志内容',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6565 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE IF NOT EXISTS `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2023-11-22 07:31:26', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2023-11-22 07:31:26', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2023-11-22 07:31:26', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2023-11-22 07:31:26', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE IF NOT EXISTS `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `router` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色默认路由',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-11-22 07:31:26', '', NULL, '超级管理员', NULL);
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 0, 0, '0', '0', 'admin', '2023-11-22 07:31:26', 'admin', '2024-08-28 15:32:49', '普通角色', '/dbmgt/db');
INSERT INTO `sys_role` VALUES (104, '数据库使用者', 'dbuser', 4, '1', 0, 0, '0', '0', 'admin', '2024-05-23 21:39:51', 'admin', '2024-09-27 14:59:06', '可对指定数据进行查询和导出', '/dbquery/query');
INSERT INTO `sys_role` VALUES (108, '数据运维工程师', 'data', 3, '1', 0, 0, '0', '0', 'admin', '2024-07-27 15:22:28', 'admin', '2024-10-10 12:00:48', '服务器运维人员', '/welcome');
INSERT INTO `sys_role` VALUES (109, '数据库审计员', 'dbaudit', 5, '1', 0, 0, '0', '0', 'admin', '2024-07-29 10:18:00', 'admin', '2024-09-17 13:45:32', '负责审计数据服务器操作是否合规', '/datalog/auditlog');
INSERT INTO `sys_role` VALUES (110, '数据库管理员', 'dbmanage', 3, '1', 0, 0, '0', '0', 'admin', '2024-09-01 15:22:41', 'admin', '2024-10-04 09:22:36', '负责公司内部数据服务器的管理人员', '/welcome');
INSERT INTO `sys_role` VALUES (111, '数据库安全员', 'security', 99, '1', 0, 0, '0', '0', 'admin', '2024-09-11 17:08:26', 'admin', '2024-10-04 09:21:47', '负责公司内部安全事务', '/security/security');
INSERT INTO `sys_role` VALUES (112, '系统管理员', 'manager', 98, '1', 0, 0, '0', '0', 'admin', '2024-09-11 17:29:16', 'admin', '2024-09-11 17:30:36', '创建用户及分配权限', '/system/user');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE IF NOT EXISTS `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE IF NOT EXISTS `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2029);
INSERT INTO `sys_role_menu` VALUES (2, 2030);
INSERT INTO `sys_role_menu` VALUES (2, 2031);
INSERT INTO `sys_role_menu` VALUES (2, 2032);
INSERT INTO `sys_role_menu` VALUES (2, 2059);
INSERT INTO `sys_role_menu` VALUES (2, 2060);
INSERT INTO `sys_role_menu` VALUES (2, 2061);
INSERT INTO `sys_role_menu` VALUES (2, 2064);
INSERT INTO `sys_role_menu` VALUES (2, 2071);
INSERT INTO `sys_role_menu` VALUES (2, 2072);
INSERT INTO `sys_role_menu` VALUES (2, 2073);
INSERT INTO `sys_role_menu` VALUES (2, 2074);
INSERT INTO `sys_role_menu` VALUES (2, 2077);
INSERT INTO `sys_role_menu` VALUES (2, 2078);
INSERT INTO `sys_role_menu` VALUES (2, 2079);
INSERT INTO `sys_role_menu` VALUES (2, 2080);
INSERT INTO `sys_role_menu` VALUES (2, 2081);
INSERT INTO `sys_role_menu` VALUES (104, 2);
INSERT INTO `sys_role_menu` VALUES (104, 109);
INSERT INTO `sys_role_menu` VALUES (104, 110);
INSERT INTO `sys_role_menu` VALUES (104, 2012);
INSERT INTO `sys_role_menu` VALUES (104, 2013);
INSERT INTO `sys_role_menu` VALUES (104, 2014);
INSERT INTO `sys_role_menu` VALUES (104, 2064);
INSERT INTO `sys_role_menu` VALUES (104, 2067);
INSERT INTO `sys_role_menu` VALUES (104, 2068);
INSERT INTO `sys_role_menu` VALUES (104, 2071);
INSERT INTO `sys_role_menu` VALUES (104, 2072);
INSERT INTO `sys_role_menu` VALUES (104, 2073);
INSERT INTO `sys_role_menu` VALUES (104, 2074);
INSERT INTO `sys_role_menu` VALUES (104, 2088);
INSERT INTO `sys_role_menu` VALUES (108, 2);
INSERT INTO `sys_role_menu` VALUES (108, 109);
INSERT INTO `sys_role_menu` VALUES (108, 110);
INSERT INTO `sys_role_menu` VALUES (108, 2000);
INSERT INTO `sys_role_menu` VALUES (108, 2001);
INSERT INTO `sys_role_menu` VALUES (108, 2012);
INSERT INTO `sys_role_menu` VALUES (108, 2013);
INSERT INTO `sys_role_menu` VALUES (108, 2014);
INSERT INTO `sys_role_menu` VALUES (108, 2015);
INSERT INTO `sys_role_menu` VALUES (108, 2029);
INSERT INTO `sys_role_menu` VALUES (108, 2030);
INSERT INTO `sys_role_menu` VALUES (108, 2031);
INSERT INTO `sys_role_menu` VALUES (108, 2032);
INSERT INTO `sys_role_menu` VALUES (108, 2059);
INSERT INTO `sys_role_menu` VALUES (108, 2060);
INSERT INTO `sys_role_menu` VALUES (108, 2061);
INSERT INTO `sys_role_menu` VALUES (108, 2064);
INSERT INTO `sys_role_menu` VALUES (108, 2067);
INSERT INTO `sys_role_menu` VALUES (108, 2068);
INSERT INTO `sys_role_menu` VALUES (108, 2069);
INSERT INTO `sys_role_menu` VALUES (108, 2070);
INSERT INTO `sys_role_menu` VALUES (108, 2071);
INSERT INTO `sys_role_menu` VALUES (108, 2072);
INSERT INTO `sys_role_menu` VALUES (108, 2073);
INSERT INTO `sys_role_menu` VALUES (108, 2074);
INSERT INTO `sys_role_menu` VALUES (108, 2088);
INSERT INTO `sys_role_menu` VALUES (108, 2099);
INSERT INTO `sys_role_menu` VALUES (108, 2100);
INSERT INTO `sys_role_menu` VALUES (108, 2101);
INSERT INTO `sys_role_menu` VALUES (110, 3);
INSERT INTO `sys_role_menu` VALUES (110, 2000);
INSERT INTO `sys_role_menu` VALUES (110, 2001);
INSERT INTO `sys_role_menu` VALUES (110, 2002);
INSERT INTO `sys_role_menu` VALUES (110, 2003);
INSERT INTO `sys_role_menu` VALUES (110, 2004);
INSERT INTO `sys_role_menu` VALUES (110, 2005);
INSERT INTO `sys_role_menu` VALUES (110, 2006);
INSERT INTO `sys_role_menu` VALUES (110, 2012);
INSERT INTO `sys_role_menu` VALUES (110, 2013);
INSERT INTO `sys_role_menu` VALUES (110, 2014);
INSERT INTO `sys_role_menu` VALUES (110, 2015);
INSERT INTO `sys_role_menu` VALUES (110, 2021);
INSERT INTO `sys_role_menu` VALUES (110, 2022);
INSERT INTO `sys_role_menu` VALUES (110, 2023);
INSERT INTO `sys_role_menu` VALUES (110, 2026);
INSERT INTO `sys_role_menu` VALUES (110, 2029);
INSERT INTO `sys_role_menu` VALUES (110, 2030);
INSERT INTO `sys_role_menu` VALUES (110, 2031);
INSERT INTO `sys_role_menu` VALUES (110, 2032);
INSERT INTO `sys_role_menu` VALUES (110, 2033);
INSERT INTO `sys_role_menu` VALUES (110, 2034);
INSERT INTO `sys_role_menu` VALUES (110, 2035);
INSERT INTO `sys_role_menu` VALUES (110, 2036);
INSERT INTO `sys_role_menu` VALUES (110, 2037);
INSERT INTO `sys_role_menu` VALUES (110, 2038);
INSERT INTO `sys_role_menu` VALUES (110, 2039);
INSERT INTO `sys_role_menu` VALUES (110, 2040);
INSERT INTO `sys_role_menu` VALUES (110, 2041);
INSERT INTO `sys_role_menu` VALUES (110, 2059);
INSERT INTO `sys_role_menu` VALUES (110, 2060);
INSERT INTO `sys_role_menu` VALUES (110, 2061);
INSERT INTO `sys_role_menu` VALUES (110, 2067);
INSERT INTO `sys_role_menu` VALUES (110, 2068);
INSERT INTO `sys_role_menu` VALUES (110, 2069);
INSERT INTO `sys_role_menu` VALUES (110, 2070);
INSERT INTO `sys_role_menu` VALUES (110, 2075);
INSERT INTO `sys_role_menu` VALUES (110, 2077);
INSERT INTO `sys_role_menu` VALUES (110, 2078);
INSERT INTO `sys_role_menu` VALUES (110, 2079);
INSERT INTO `sys_role_menu` VALUES (110, 2080);
INSERT INTO `sys_role_menu` VALUES (110, 2081);
INSERT INTO `sys_role_menu` VALUES (110, 2088);
INSERT INTO `sys_role_menu` VALUES (111, 3);
INSERT INTO `sys_role_menu` VALUES (111, 2006);
INSERT INTO `sys_role_menu` VALUES (111, 2007);
INSERT INTO `sys_role_menu` VALUES (111, 2008);
INSERT INTO `sys_role_menu` VALUES (111, 2009);
INSERT INTO `sys_role_menu` VALUES (111, 2010);
INSERT INTO `sys_role_menu` VALUES (111, 2011);
INSERT INTO `sys_role_menu` VALUES (111, 2016);
INSERT INTO `sys_role_menu` VALUES (111, 2028);
INSERT INTO `sys_role_menu` VALUES (111, 2038);
INSERT INTO `sys_role_menu` VALUES (111, 2039);
INSERT INTO `sys_role_menu` VALUES (111, 2040);
INSERT INTO `sys_role_menu` VALUES (111, 2041);
INSERT INTO `sys_role_menu` VALUES (111, 2042);
INSERT INTO `sys_role_menu` VALUES (111, 2043);
INSERT INTO `sys_role_menu` VALUES (111, 2044);
INSERT INTO `sys_role_menu` VALUES (111, 2045);
INSERT INTO `sys_role_menu` VALUES (111, 2046);
INSERT INTO `sys_role_menu` VALUES (111, 2047);
INSERT INTO `sys_role_menu` VALUES (111, 2048);
INSERT INTO `sys_role_menu` VALUES (111, 2049);
INSERT INTO `sys_role_menu` VALUES (111, 2050);
INSERT INTO `sys_role_menu` VALUES (111, 2051);
INSERT INTO `sys_role_menu` VALUES (111, 2052);
INSERT INTO `sys_role_menu` VALUES (111, 2053);
INSERT INTO `sys_role_menu` VALUES (111, 2054);
INSERT INTO `sys_role_menu` VALUES (111, 2056);
INSERT INTO `sys_role_menu` VALUES (111, 2062);
INSERT INTO `sys_role_menu` VALUES (111, 2063);
INSERT INTO `sys_role_menu` VALUES (111, 2066);
INSERT INTO `sys_role_menu` VALUES (111, 2076);
INSERT INTO `sys_role_menu` VALUES (111, 2082);
INSERT INTO `sys_role_menu` VALUES (111, 2083);
INSERT INTO `sys_role_menu` VALUES (111, 2084);
INSERT INTO `sys_role_menu` VALUES (111, 2085);
INSERT INTO `sys_role_menu` VALUES (111, 2086);
INSERT INTO `sys_role_menu` VALUES (111, 2087);
INSERT INTO `sys_role_menu` VALUES (111, 2090);
INSERT INTO `sys_role_menu` VALUES (111, 2091);
INSERT INTO `sys_role_menu` VALUES (111, 2092);
INSERT INTO `sys_role_menu` VALUES (111, 2093);
INSERT INTO `sys_role_menu` VALUES (111, 2094);
INSERT INTO `sys_role_menu` VALUES (111, 2095);
INSERT INTO `sys_role_menu` VALUES (111, 2096);
INSERT INTO `sys_role_menu` VALUES (111, 2097);
INSERT INTO `sys_role_menu` VALUES (111, 2098);
INSERT INTO `sys_role_menu` VALUES (112, 1);
INSERT INTO `sys_role_menu` VALUES (112, 100);
INSERT INTO `sys_role_menu` VALUES (112, 101);
INSERT INTO `sys_role_menu` VALUES (112, 102);
INSERT INTO `sys_role_menu` VALUES (112, 103);
INSERT INTO `sys_role_menu` VALUES (112, 1000);
INSERT INTO `sys_role_menu` VALUES (112, 1001);
INSERT INTO `sys_role_menu` VALUES (112, 1002);
INSERT INTO `sys_role_menu` VALUES (112, 1003);
INSERT INTO `sys_role_menu` VALUES (112, 1004);
INSERT INTO `sys_role_menu` VALUES (112, 1005);
INSERT INTO `sys_role_menu` VALUES (112, 1006);
INSERT INTO `sys_role_menu` VALUES (112, 1007);
INSERT INTO `sys_role_menu` VALUES (112, 1008);
INSERT INTO `sys_role_menu` VALUES (112, 1009);
INSERT INTO `sys_role_menu` VALUES (112, 1010);
INSERT INTO `sys_role_menu` VALUES (112, 1011);
INSERT INTO `sys_role_menu` VALUES (112, 1012);
INSERT INTO `sys_role_menu` VALUES (112, 1013);
INSERT INTO `sys_role_menu` VALUES (112, 1014);
INSERT INTO `sys_role_menu` VALUES (112, 1015);
INSERT INTO `sys_role_menu` VALUES (112, 1016);
INSERT INTO `sys_role_menu` VALUES (112, 1017);
INSERT INTO `sys_role_menu` VALUES (112, 1018);
INSERT INTO `sys_role_menu` VALUES (112, 1019);
INSERT INTO `sys_role_menu` VALUES (112, 2016);
INSERT INTO `sys_role_menu` VALUES (112, 2017);

-- ----------------------------
-- Table structure for sys_security_config
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_security_config`;
CREATE TABLE IF NOT EXISTS `sys_security_config`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '安全策略ID',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略标题',
  `config_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略描述',
  `level` int(1) NULL DEFAULT NULL COMMENT '安全策略等级1低2中3高',
  `warn_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略告警方式',
  `status` int(1) NULL DEFAULT NULL COMMENT '安全策略状态0启用 1禁用',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_scope` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用范围',
  `oper_type` int(1) NULL DEFAULT NULL COMMENT '操作类型1拦截2不拦截',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_security_item
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_security_item`;
CREATE TABLE IF NOT EXISTS `sys_security_item`  (
  `id` int(4) NOT NULL COMMENT '策略ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '策略标题',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应组件名称',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0 有效 1失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_security_item
-- ----------------------------
INSERT INTO `sys_security_item` VALUES (1, '数据库用户', 'UserComp', 0);
INSERT INTO `sys_security_item` VALUES (2, '源IP', 'SrcIpComp', 0);
INSERT INTO `sys_security_item` VALUES (4, '数据库', 'DbTypeComp', 0);
INSERT INTO `sys_security_item` VALUES (5, '操作', 'OperComp', 0);
INSERT INTO `sys_security_item` VALUES (6, '对象', 'ObjComp', 0);
INSERT INTO `sys_security_item` VALUES (11, '对象', 'FieldComp', 1);
INSERT INTO `sys_security_item` VALUES (12, '时间', 'TimeComp', 0);
INSERT INTO `sys_security_item` VALUES (13, '语句', 'SqlLangComp', 0);
INSERT INTO `sys_security_item` VALUES (14, '时段', 'TimePartComp', 0);
-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE IF NOT EXISTS `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', '管理员', '00', '', '', '1', '', '$2a$10$wQDpcXJrstbs4hF90v.6UOC52apl6G8yDwQlpb0mZZizOq2I69Nty', '0', '0', '61.152.208.159', '2024-10-14 11:00:46', 'admin', '2023-11-22 07:31:26', '', '2024-10-14 11:00:46', '管理员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE IF NOT EXISTS `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE IF NOT EXISTS `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for tbl_audit_detail
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_audit_detail`;
CREATE TABLE IF NOT EXISTS `tbl_audit_detail`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `security_id` int(10) NULL DEFAULT NULL COMMENT '安全策略表头ID',
  `security_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全策略明细内容json格式',
  `security_name` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略明细ID',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `security_id`(`security_id`, `security_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_auth_mask
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_auth_mask`;
CREATE TABLE IF NOT EXISTS `tbl_auth_mask`  (
  `id` int(10) NOT NULL COMMENT '授权脱敏ID',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型0内置1自定义',
  `desen_id` int(2) NULL DEFAULT NULL COMMENT '内置脱敏规则id',
  `mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '替换hidden 打码mask',
  `hide_placeholder` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '替换文本',
  `mask_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打码方式 中间打码(middle)，两边打码(edge)',
  `mask_len` int(11) NULL DEFAULT NULL COMMENT '打码长度',
  `mask_start` int(11) NULL DEFAULT NULL COMMENT '打码开始位置',
  `mask_end` int(11) NULL DEFAULT NULL COMMENT '打码结束位置',
  `mask_replace` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打码符号默认*',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_auth_mask
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_auth_snap
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_auth_snap`;
CREATE TABLE IF NOT EXISTS `tbl_auth_snap`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '快照ID',
  `snap_time` datetime NULL DEFAULT NULL COMMENT '拍照时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0 拍照成功 1拍照失败',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_auth_snap
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_chktemple_head
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_chktemple_head`;
CREATE TABLE IF NOT EXISTS `tbl_chktemple_head`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '巡检模板ID',
  `temple_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板名称',
  `ver_scope` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '适用版本范围',
  `db_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库引擎',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0未审核1已审核',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_chktemple_head
-- ----------------------------
INSERT INTO `tbl_chktemple_head` VALUES (3, 'Mysql巡检模版', '5.7', 'mysql', 0, NULL, '2024-10-09 15:02:16', 'admin', '2024-10-12 10:01:07');
INSERT INTO `tbl_chktemple_head` VALUES (4, 'Oracle巡检模版', '23c', 'oracle', 0, NULL, '2024-10-10 22:54:45', 'admin', '2024-10-11 14:59:00');
INSERT INTO `tbl_chktemple_head` VALUES (5, 'Postgres巡检模版', '11,12,13,14,15', 'postgresql', 0, NULL, '2024-10-10 23:10:43', 'admin', '2024-10-12 10:32:46');
INSERT INTO `tbl_chktemple_head` VALUES (6, 'PolarDB_for_PG巡检模版', '', 'polardb', 0, NULL, '2024-10-12 10:52:16', 'admin', '2024-10-12 12:16:25');
INSERT INTO `tbl_chktemple_head` VALUES (7, 'TiDB巡检模版', '', 'tidb', 0, NULL, '2024-10-12 11:21:00', NULL, NULL);
INSERT INTO `tbl_chktemple_head` VALUES (8, 'OpenGauss巡检模版', '', 'opengauss', 0, NULL, '2024-10-12 11:40:27', NULL, NULL);
INSERT INTO `tbl_chktemple_head` VALUES (9, 'Kingbase巡检模版', '', 'kingbase', 0, NULL, '2024-10-12 12:13:45', NULL, NULL);
INSERT INTO `tbl_chktemple_head` VALUES (10, 'Gbase8a巡检模版', '', 'gbase', 0, NULL, '2024-10-12 12:28:08', NULL, NULL);
INSERT INTO `tbl_chktemple_head` VALUES (11, 'Oceanbase巡检模版', '', 'oceanbase', 0, NULL, '2024-10-12 13:50:44', 'admin', '2024-10-12 14:01:49');

-- ----------------------------
-- Table structure for tbl_chktemple_item
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_chktemple_item`;
CREATE TABLE IF NOT EXISTS `tbl_chktemple_item`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '巡检条目ID',
  `temple_id` int(10) NULL DEFAULT NULL COMMENT '巡检模板ID',
  `chkitem_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '巡检项编号',
  `chkitem_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '巡检项描述',
  `chk_script` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '巡检项脚本',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0有效1无效',
  `sort` int(3) NULL DEFAULT NULL COMMENT '排序码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1320 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_chktemple_item
-- ----------------------------
INSERT INTO `tbl_chktemple_item` VALUES (488, 4, '1.', '查看数据库版本和补丁信息', 'SELECT * FROM V$VERSION', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (489, 4, '2.', ' 查看数据库实例的启动时间', 'SELECT STARTUP_TIME FROM V$INSTANCE', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (490, 4, '3.', ' 查看数据库会话情况', 'SELECT \n    SID, \n    SERIAL#, \n    USERNAME, \n    STATUS, \n    OSUSER, \n    MACHINE, \n    PROGRAM \nFROM V$SESSION \nORDER BY SID', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (491, 4, '4.', '查看当前正在执行的SQL语句', 'SELECT \n    S.SID, \n    S.USERNAME, \n    Q.SQL_TEXT, \n    Q.EXECUTIONS \nFROM V$SESSION S \nJOIN V$SQLAREA Q \nON S.SQL_ID = Q.SQL_ID \nWHERE S.STATUS = \'ACTIVE\'', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (492, 4, '5.', '查看锁信息', 'SELECT \n    S1.SID AS WAITING_SESSION, \n    S1.USERNAME AS WAITING_USER, \n    S2.SID AS BLOCKING_SESSION, \n    S2.USERNAME AS BLOCKING_USER, \n    L1.LOCK_TYPE \nFROM V$LOCK L1 \nJOIN V$SESSION S1 ON L1.SID = S1.SID \nJOIN V$LOCK L2 ON L1.BLOCKING_SESSION = L2.SID \nJOIN V$SESSION S2 ON L2.SID = S2.SID \nWHERE L1.BLOCKING_SESSION IS NOT NULL', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (493, 4, '6.', '查看表空间使用情况', 'SELECT \n    TABLESPACE_NAME, \n    TOTAL_BLOCKS*BLOCK_SIZE/1024/1024 AS TOTAL_SIZE_MB, \n    FREE_BLOCKS*BLOCK_SIZE/1024/1024 AS FREE_SIZE_MB, \n    (TOTAL_BLOCKS - FREE_BLOCKS)*BLOCK_SIZE/1024/1024 AS USED_SIZE_MB, \n    ROUND((TOTAL_BLOCKS - FREE_BLOCKS) / TOTAL_BLOCKS * 100, 2) AS USED_PERCENT\nFROM DBA_TABLESPACE_USAGE_METRICS', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (494, 4, '7.', '查看数据文件的使用情况', 'SELECT \n    FILE_NAME, \n    TABLESPACE_NAME, \n    BYTES/1024/1024 AS SIZE_MB, \n    AUTOEXTENSIBLE \nFROM DBA_DATA_FILES', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (495, 4, '8.', '查看临时表空间使用情况', 'SELECT \n    TABLESPACE_NAME, \n    FILE_NAME, \n    BYTES/1024/1024 AS SIZE_MB, \n    AUTOEXTENSIBLE \nFROM DBA_TEMP_FILES', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (496, 4, '9.', '查看系统资源使用情况（CPU、内存等）', 'SELECT \n    SNAP_ID, \n    DBID, \n    INSTANCE_NUMBER, \n    BEGIN_INTERVAL_TIME, \n    END_INTERVAL_TIME, \n    PARSE_CALLS, \n    EXECUTIONS, \n    BUFFER_GETS, \n    CPU_TIME, \n    ELAPSED_TIME \nFROM DBA_HIST_SYS_TIME_MODEL \nORDER BY END_INTERVAL_TIME DESC', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (497, 4, '10.', '查看数据库等待事件', 'SELECT \n    EVENT, \n    TOTAL_WAITS, \n    TIME_WAITED, \n    AVERAGE_WAIT \nFROM V$SYSTEM_EVENT \nORDER BY TIME_WAITED DESC', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (498, 4, '11.', '查看缓冲区缓存命中率', 'SELECT \n    NAME, \n    ROUND((1 - (PHYSICAL_READS / (DB_BLOCK_GETS + CONSISTENT_GETS))) * 100, 2) AS HIT_RATIO \nFROM V$BUFFER_POOL_STATISTICS', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (499, 4, '12.', '查看归档日志的状态', 'SELECT \n    THREAD#, \n    SEQUENCE#, \n    FIRST_TIME, \n    NEXT_TIME, \n    ARCHIVED, \n    APPLIED \nFROM V$ARCHIVED_LOG \nORDER BY FIRST_TIME DESC', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (500, 4, '13.', '查看无效对象（无效视图、存储过程等）', 'SELECT OBJECT_NAME, OBJECT_TYPE, STATUS \nFROM DBA_OBJECTS \nWHERE STATUS = \'INVALID\'', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (501, 4, '14.', '查看失效的索引', 'SELECT \n    INDEX_NAME, \n    TABLE_NAME, \n    STATUS \nFROM DBA_INDEXES \nWHERE STATUS = \'UNUSABLE\'', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (502, 4, '15.', '查看死锁信息', 'SELECT * FROM DBA_DEADLOCKS', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (503, 4, '16.', '查看数据库会话数限制及使用情况', 'SELECT \n    RESOURCE_NAME, \n    CURRENT_UTILIZATION, \n    MAX_UTILIZATION, \n    LIMIT_VALUE \nFROM V$RESOURCE_LIMIT \nWHERE RESOURCE_NAME IN (\'sessions\', \'processes\')', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (504, 4, '17.', '查看未提交的事务', 'SELECT \n    S.SID, \n    S.SERIAL#, \n    T.XIDUSN, \n    T.XIDSLT, \n    T.XIDSQN, \n    T.STATUS \nFROM V$SESSION S \nJOIN V$TRANSACTION T \nON S.SADDR = T.SES_ADDR \nWHERE T.STATUS = \'ACTIVE\'', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (505, 4, '18.', '查看数据库的初始化参数', 'SELECT NAME, VALUE \nFROM V$PARAMETER \nWHERE ISDEFAULT = \'FALSE\'', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (506, 4, '19.', '查看ASM磁盘组的使用情况（如果使用ASM）', 'SELECT \n    NAME, \n    TOTAL_MB, \n    FREE_MB, \n    (TOTAL_MB - FREE_MB) AS USED_MB, \n    ROUND((TOTAL_MB - FREE_MB) / TOTAL_MB * 100, 2) AS USED_PERCENT \nFROM V$ASM_DISKGROUP', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (507, 4, '20.', '查看全表扫描情况', 'SELECT \n    OWNER, \n    OBJECT_NAME, \n    EXECUTIONS, \n    BUFFER_GETS, \n    DISK_READS \nFROM V$SQL \nWHERE COMMAND_TYPE = 3\nORDER BY DISK_READS DESC', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (508, 4, '21.', '查看AWR报告的快照信息', 'SELECT \n    SNAP_ID, \n    BEGIN_INTERVAL_TIME, \n    END_INTERVAL_TIME \nFROM DBA_HIST_SNAPSHOT \nORDER BY SNAP_ID DESC', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (509, 4, '22.', '查看最新的备份情况（适用于RMAN）', 'SELECT \n    SESSION_KEY, \n    INPUT_TYPE, \n    STATUS, \n    START_TIME, \n    END_TIME, \n    OUTPUT_BYTES/1024/1024 AS OUTPUT_MB \nFROM V$RMAN_BACKUP_JOB_DETAILS \nORDER BY START_TIME DESC', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (510, 4, '23.', '查看Redo日志的状态', 'SELECT \n    GROUP#, \n    THREAD#, \n    SEQUENCE#, \n    ARCHIVED, \n    STATUS \nFROM V$LOG \nORDER BY GROUP#', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (511, 4, '24.', '查看数据库中的大表（按大小排序）', 'SELECT \n    SEGMENT_NAME, \n    SEGMENT_TYPE, \n    BYTES/1024/1024 AS SIZE_MB \nFROM DBA_SEGMENTS \nWHERE SEGMENT_TYPE=\'TABLE\' \nORDER BY SIZE_MB DESC', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (512, 4, '25.', '查看SQL语句的执行计划', 'SELECT \n    PLAN_TABLE_OUTPUT \nFROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, \'ALLSTATS LAST\'))', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (513, 4, '26.', '查看当前数据库警告日志', 'SELECT \n    ORIGINATING_TIMESTAMP, \n    MESSAGE_TEXT \nFROM V$DIAG_ALERT_EXT \nORDER BY ORIGINATING_TIMESTAMP DESC', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (514, 4, '27.', '查看当前数据库的备份策略（适用于RMAN配置）', 'SHOW ALL', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (515, 4, '28.', '查看系统全局区（SGA）大小及组件信息', 'SELECT \n    POOL, \n    NAME, \n    BYTES/1024/1024 AS SIZE_MB \nFROM V$SGAINFO', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (516, 4, '29.', '查看PGA的使用情况', 'SELECT \n    NAME, \n    VALUE/1024/1024 AS SIZE_MB \nFROM V$PGASTAT', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (517, 4, '30.', '查看无效登录尝试', 'SELECT \n    USERNAME, \n    ACCOUNT_STATUS, \n    LOCK_DATE, \n    EXPIRY_DATE \nFROM DBA_USERS \nWHERE ACCOUNT_STATUS = \'LOCKED\'', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (518, 4, '31.', '查看数据库的当前性能指标', 'SELECT \n    STAT_NAME, \n    VALUE \nFROM V$SYSSTAT \nORDER BY VALUE DESC', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (519, 4, '32.', '查看长时间运行的会话', 'SELECT \n    SID, \n    SERIAL#, \n    USERNAME, \n    STATUS, \n    LOGON_TIME, \n    LAST_CALL_ET AS \"RUNNING_TIME (seconds)\" \nFROM V$SESSION \nWHERE STATUS = \'ACTIVE\' \nAND LAST_CALL_ET &gt; 3600 \nORDER BY LAST_CALL_ET DESC', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (520, 4, '33.', '查看长时间未提交的事务', 'SELECT \n    S.SID, \n    S.SERIAL#, \n    S.USERNAME, \n    T.START_TIME, \n    T.STATUS, \n    ROUND((SYSDATE - T.START_TIME) * 24 * 60, 2) AS \"TXN_DURATION_MINUTES\" \nFROM V$SESSION S \nJOIN V$TRANSACTION T \nON S.SADDR = T.SES_ADDR \nWHERE T.START_TIME  500 * 1024 * 1024 \nORDER BY SIZE_MB DESC', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (521, 4, '34. ', '查看当前锁等待的详细信息', 'SELECT \n    S1.SID AS WAITING_SESSION, \n    S1.USERNAME AS WAITING_USER, \n    S2.SID AS BLOCKING_SESSION, \n    S2.USERNAME AS BLOCKING_USER, \n    L1.TYPE AS LOCK_TYPE \nFROM V$LOCK L1 \nJOIN V$SESSION S1 ON L1.SID = S1.SID \nJOIN V$LOCK L2 ON L1.BLOCKING_SESSION = L2.SID \nJOIN V$SESSION S2 ON L2.SID = S2.SID \nWHERE L1.BLOCKING_SESSION IS NOT NULL', 0, 33);
INSERT INTO `tbl_chktemple_item` VALUES (522, 4, '35. ', '查看等待事件的详细分类', 'SELECT \n    EVENT, \n    WAIT_CLASS, \n    TOTAL_WAITS, \n    TIME_WAITED_MICRO, \n    AVERAGE_WAIT_MICRO \nFROM V$SYSTEM_EVENT \nORDER BY TIME_WAITED_MICRO DESC', 0, 34);
INSERT INTO `tbl_chktemple_item` VALUES (523, 4, '36. ', '查看SGA目标大小和当前使用情况', 'SELECT \n    NAME, \n    VALUE/1024/1024 AS SIZE_MB \nFROM V$SGA', 0, 35);
INSERT INTO `tbl_chktemple_item` VALUES (524, 4, '37.', ' 查看PGA目标大小和当前使用情况', 'SELECT \n    NAME, \n    VALUE/1024/1024 AS SIZE_MB \nFROM V$PGASTAT', 0, 36);
INSERT INTO `tbl_chktemple_item` VALUES (525, 4, '38. ', '查看数据库中当前活动的事务', 'SELECT \n    XIDUSN, \n    XIDSLT, \n    XIDSQN, \n    STATUS, \n    START_TIME \nFROM V$TRANSACTION', 0, 37);
INSERT INTO `tbl_chktemple_item` VALUES (526, 4, '39. ', '查看当前等待的会话', 'SELECT \n    SID, \n    EVENT, \n    WAIT_TIME, \n    SECONDS_IN_WAIT \nFROM V$SESSION_WAIT \nWHERE WAIT_TIME = 0', 0, 38);
INSERT INTO `tbl_chktemple_item` VALUES (527, 4, '49.', '查看数据库的Top 10大表', 'SELECT \n    OWNER, \n    SEGMENT_NAME, \n    SEGMENT_TYPE, \n    BYTES/1024/1024 AS SIZE_MB \nFROM DBA_SEGMENTS \nORDER BY BYTES DESC \nFETCH FIRST 10 ROWS ONLY', 0, 39);
INSERT INTO `tbl_chktemple_item` VALUES (528, 4, '50.', '查看ASM磁盘的性能（适用于使用ASM的数据库）', 'SELECT \n    DG.NAME AS DISKGROUP_NAME, \n    D.NAME AS DISK_NAME, \n    D.TOTAL_MB, \n    D.FREE_MB, \n    D.READS, \n    D.WRITES, \n    D.READ_ERRS, \n    D.WRITE_ERRS \nFROM V$ASM_DISK D \nJOIN V$ASM_DISKGROUP DG \nON D.GROUP_NUMBER = DG.GROUP_NUMBER', 0, 40);
INSERT INTO `tbl_chktemple_item` VALUES (529, 4, '51.', '查看Redo日志的切换频率', 'SELECT \n    THREAD#, \n    SEQUENCE#, \n    FIRST_CHANGE#, \n    NEXT_CHANGE#, \n    SWITCH_TIME \nFROM V$LOG_HISTORY \nORDER BY SWITCH_TIME DESC', 0, 41);
INSERT INTO `tbl_chktemple_item` VALUES (530, 4, '52.', '查看数据库的系统事件日志', 'SELECT \n    ORIGINATING_TIMESTAMP, \n    MESSAGE_TEXT \nFROM V$DIAG_ALERT_EXT \nORDER BY ORIGINATING_TIMESTAMP DESC', 0, 42);
INSERT INTO `tbl_chktemple_item` VALUES (531, 4, '53.', '查看自动工作负载信息 (AWR) 快照的生成情况', 'SELECT \n    SNAP_ID, \n    DBID, \n    INSTANCE_NUMBER, \n    BEGIN_INTERVAL_TIME, \n    END_INTERVAL_TIME \nFROM DBA_HIST_SNAPSHOT \nORDER BY SNAP_ID DESC', 0, 43);
INSERT INTO `tbl_chktemple_item` VALUES (532, 4, '54.', '查看自动工作负载信息 (AWR) 报告中常见的TOP SQL', 'SELECT \n    SQL_ID, \n    PLAN_HASH_VALUE, \n    EXECUTIONS, \n    DISK_READS, \n    BUFFER_GETS, \n    ELAPSED_TIME/1000000 AS ELAPSED_TIME_SEC \nFROM DBA_HIST_SQLSTAT \nORDER BY ELAPSED_TIME_SEC DESC', 0, 44);
INSERT INTO `tbl_chktemple_item` VALUES (533, 4, '55.', '查看自动内存管理（AMM）的调整历史', 'SELECT \n    COMPONENT, \n    OPER_TYPE, \n    OPER_MODE, \n    PARAMETER, \n    START_SIZE, \n    END_SIZE, \n    START_TIME \nFROM V$MEMORY_RESIZE_OPS \nORDER BY START_TIME DESC', 0, 45);
INSERT INTO `tbl_chktemple_item` VALUES (534, 4, '56.', '查看网络流量和监听器性能', 'SELECT \n    NETWORK_NAME, \n    BYTES_RECEIVED, \n    BYTES_SENT, \n    ROUND_TRIP_LATENCY, \n    CONNECTION_COUNT \nFROM V$SESSION_CONNECT_INFO \nWHERE NETWORK_NAME IS NOT NULL', 0, 46);
INSERT INTO `tbl_chktemple_item` VALUES (535, 4, '57.', '查看数据库重启后的警告或错误信息', 'SELECT \n    ORIGINATING_TIMESTAMP, \n    MESSAGE_TEXT \nFROM V$DIAG_ALERT_EXT \nWHERE MESSAGE_TEXT LIKE \'%error%\' \nORDER BY ORIGINATING_TIMESTAMP DESC', 0, 47);
INSERT INTO `tbl_chktemple_item` VALUES (536, 4, '58.', '查看表的行迁移和行链接信息', 'SELECT \n    TABLE_NAME, \n    NUM_ROWS, \n    CHAIN_CNT \nFROM DBA_TABLES \nWHERE CHAIN_CNT &gt; 0 \nORDER BY CHAIN_CNT DESC', 0, 48);
INSERT INTO `tbl_chktemple_item` VALUES (537, 4, '59.', '查看表空间的自动扩展配置', 'SELECT \n    TABLESPACE_NAME, \n    FILE_NAME, \n    AUTOEXTENSIBLE, \n    MAXBYTES/1024/1024 AS MAX_SIZE_MB \nFROM DBA_DATA_FILES', 0, 49);
INSERT INTO `tbl_chktemple_item` VALUES (538, 4, '60.', '查看Oracle数据库的统计信息收集策略', 'SELECT \n    OWNER, \n    TABLE_NAME, \n    STATTYPE_LOCKED \nFROM DBA_TAB_STATISTICS \nWHERE STATTYPE_LOCKED IS NOT NULL', 0, 50);
INSERT INTO `tbl_chktemple_item` VALUES (915, 3, '1', '数据库基本信息', 'SELECT  now() now_date,\n	USER() user, -- USER()、 SYSTEM_USER()、 SESSION_USER()、\n	CURRENT_USER() CURRENT_USER1,\n	CONNECTION_ID() CONNECTION_ID,\n	DATABASE() db_name, -- SCHEMA(),\n	version() Server_version,\n	( SELECT sum( TRUNCATE ( ( data_length + index_length ) / 1024 / 1024, 2 ) ) AS \'all_db_size(MB)\' FROM information_schema.TABLES b ) all_db_size_MB,\n	(select truncate(sum(total_extents*extent_size)/1024/1024,2) from  information_schema.FILES b) all_datafile_size_MB,\n	( SELECT @@datadir ) datadir,\n	( SELECT @@SOCKET ) SOCKET,\n	( SELECT @@log_error ) log_error,\n	( SELECT @@autocommit ) autocommit,\n	( SELECT @@log_bin ) log_bin,\n	( SELECT @@server_id ) server_id', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (916, 3, '2', '版本信息', 'select * from performance_schema.global_variables where  VARIABLE_NAME like \'version_%\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (917, 3, '3', '插件信息', 'SELECT * FROM INFORMATION_SCHEMA.PLUGINS', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (918, 3, '4', '当前数据库实例的所有数据库及其容量大小', 'select a.SCHEMA_NAME, a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME,\nsum(table_rows) as table_rows,\ntruncate(sum(data_length)/1024/1024, 2) as data_size_mb,\ntruncate(sum(index_length)/1024/1024, 2) as index_size_mb,\ntruncate(sum(data_length+index_length)/1024/1024, 2) as all_size_mb,\ntruncate(sum(max_data_length)/1024/1024, 2) as max_size_mb,\ntruncate(sum(data_free)/1024/1024, 2) as free_size_mb,\nmax(f.filesize_M)  as disk_size_mb\nfrom INFORMATION_SCHEMA.SCHEMATA a\nleft outer join information_schema.tables b\non a.SCHEMA_NAME=b.TABLE_SCHEMA\nleft outer join\n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,\n			truncate(sum(total_extents*extent_size)/1024/1024,2) filesize_M\n			from  information_schema.FILES b\n			group by substring(b.file_name,3,locate(\'/\',b.file_name,3)-3)) f\non ( a.SCHEMA_NAME= f.db_name)\ngroup by a.SCHEMA_NAME,  a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME\norder by sum(data_length) desc, sum(index_length) DESC', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (919, 3, '5', '数据库对象', 'select db as db_name ,type as ob_type,cnt as sums from\n(select \'TABLE\' type,table_schema db, count(*) cnt  from information_schema.`TABLES` a where table_type=\'BASE TABLE\' group by table_schema\nunion all\nselect \'EVENTS\' type,event_schema db,count(*) cnt from information_schema.`EVENTS` b group by event_schema\nunion all\nselect \'TRIGGERS\' type,trigger_schema db,count(*) cnt from information_schema.`TRIGGERS` c group by trigger_schema\nunion all\nselect \'PROCEDURE\' type,routine_schema db,count(*) cnt from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'PROCEDURE\' group by db\nunion all\nselect \'FUNCTION\' type,routine_schema db,count(*) cnt  from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'FUNCTION\' group by db\nunion all\nselect \'VIEWS\' type,TABLE_SCHEMA db,count(*) cnt  from information_schema.VIEWS f group by table_schema  ) t\norder by db,type', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (920, 3, '6', '占用空间最大的前10张大表', 'SELECT\n	table_schema AS db_name,\n	table_name AS table_name,\n	a.TABLE_TYPE,\n	a.`ENGINE`,\n	a.CREATE_TIME,\n	a.UPDATE_TIME,\n	a.TABLE_COLLATION,\n	table_rows AS table_rows,\n	TRUNCATE(a.DATA_LENGTH / 1024 / 1024, 2 ) AS tb_size_mb,\n	TRUNCATE( index_length / 1024 / 1024, 2 ) AS index_size_mb,\n	TRUNCATE( ( data_length + index_length ) / 1024 / 1024, 2 ) AS all_size_mb,\n  TRUNCATE( a.DATA_FREE / 1024 / 1024, 2 ) AS free_size_mb,\n  truncate(f.filesize_M,2) AS disk_size_mb\nFROM information_schema.TABLES a\nleft outer join\n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,\n			substring(b.file_name,locate(\'/\',b.file_name,3)+1,(LENGTH(b.file_name)-locate(\'/\',b.file_name,3)-4)) as tb_name,\n			b.file_name,\n			(total_extents*extent_size)/1024/1024 filesize_M\n			from  information_schema.FILES b\n			order by filesize_M desc limit 20 ) f\non ( a.TABLE_SCHEMA= f.db_name and a.TABLE_NAME=f.tb_name )\nORDER BY	( data_length + index_length ) DESC\nLIMIT 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (921, 3, '7', '占用空间最大的前10个索引', 'select\niis.database_name,\niis.table_name,\niis.index_name,\nround((iis.stat_value*@@innodb_page_size)/1024/1024, 2) SizeMB,\ns.NON_UNIQUE,\ns.INDEX_TYPE,\nGROUP_CONCAT(s.COLUMN_NAME order by SEQ_IN_INDEX) COLUMN_NAME\nfrom (select * from mysql.innodb_index_stats\n				WHERE index_name  not in (\'PRIMARY\',\'GEN_CLUST_INDEX\') and stat_name=\'size\'\n				order by (stat_value*@@innodb_page_size) desc limit 10\n			) iis\nleft join INFORMATION_SCHEMA.STATISTICS s\non (iis.database_name=s.TABLE_SCHEMA and iis.table_name=s.TABLE_NAME and iis.index_name=s.INDEX_NAME)\nGROUP BY iis.database_name,iis.TABLE_NAME,iis.INDEX_NAME,(iis.stat_value*@@innodb_page_size),s.NON_UNIQUE,s.INDEX_TYPE\norder by (stat_value*@@innodb_page_size) desc', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (922, 3, '8', '所有存储引擎列表', 'SELECT * from information_schema.`ENGINES`', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (923, 3, '9', '存储引擎和DB的数量关系', 'SELECT a.`ENGINE`,count( * ) counts\nFROM    information_schema.`TABLES` a\nGROUP BY a.`ENGINE`', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (924, 3, '', '', 'SELECT  a.TABLE_SCHEMA,\n	a.`ENGINE`,\n	count( * ) counts\nFROM    information_schema.`TABLES` a\nGROUP BY  a.TABLE_SCHEMA,a.`ENGINE`\nORDER BY a.TABLE_SCHEMA', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (925, 3, '10', 'InnoDB 系统表空间', 'SELECT * FROM INFORMATION_SCHEMA.FILES a WHERE FILE_TYPE  \'TABLESPACE\' or a.TABLESPACE_NAME in (\'innodb_system\',\'innodb_temporary\')', 1, 0);
INSERT INTO `tbl_chktemple_item` VALUES (926, 3, '11', '查询所有用户', 'select * from mysql.user', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (927, 3, '12', '查询MySQL支持的所有字符集', 'select * from information_schema.CHARACTER_SETS', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (928, 3, '13', '一些重要的参数', 'select * from performance_schema.global_variables where  VARIABLE_NAME  in ( \'datadir\',\'SQL_MODE\',\'socket\',\'TIME_ZONE\',\'tx_isolation\',\'transaction_isolation\',\'autocommit\',\'innodb_lock_wait_timeout\',\'max_connections\',\'max_user_connections\',\'slow_query_log\',\'log_output\',\'slow_query_log_file\',\'long_query_time\',\'log_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'pid_file\',\'log_error\',\'lower_case_table_names\',\'innodb_buffer_pool_size\',\'innodb_flush_log_at_trx_commit\',\'read_only\', \'log_slave_updates\',\'innodb_io_capacity\',\'query_cache_type\',\'query_cache_size\',\'max_connect_errors\',\'server_id\',\'innodb_file_per_table\')', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (929, 3, '14', '查看当前连接到数据库的用户和Host', 'SELECT DISTINCT USER,HOST FROM `information_schema`.`PROCESSLIST` P WHERE P.USER NOT in (\'repl\',\'system user\') limit 100', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (930, 3, '15', '查看每个host的当前连接数和总连接数', 'SELECT * FROM performance_schema.hosts', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (931, 3, '16', '按照登录用户+登录服务器查看登录信息', 'SELECT USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count\nFROM `information_schema`.`PROCESSLIST` P\nGROUP BY USER,LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 )', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (932, 3, '17', '按照登录用户+数据库+登录服务器查看登录信息', 'SELECT  DB AS database_name,\n	USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count\nFROM  `information_schema`.`PROCESSLIST` P\nGROUP BY DB,USER,LEFT(HOST, POSITION( \':\' IN HOST ) - 1 )', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (933, 3, '18', '查询所有线程（排除sleep线程）', 'select * from information_schema.`PROCESSLIST`  a where a.command\'Sleep\' and a.idCONNECTION_id()', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (934, 3, '', '', 'SELECT * FROM performance_schema.threads a where a.type!=\'BACKGROUND\' and a.PROCESSLIST_COMMAND\'Sleep\'  and a.PROCESSLIST_IDCONNECTION_id()', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (935, 3, '19', 'sleep线程TOP20', 'select * from information_schema.`PROCESSLIST`  a where a.command=\'Sleep\' order by time desc limit 20', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (936, 3, '', '', 'SELECT * FROM performance_schema.threads a where a.type!=\'BACKGROUND\' and a.PROCESSLIST_COMMAND=\'Sleep\'   order by a.PROCESSLIST_time desc limit 20', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (937, 3, '20', '有多少线程正在使用表', 'show open tables where in_use &gt; 0', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (938, 3, '21', '查询InnoDB存储引擎的运行时信息，包括死锁的详细信息', 'show engine innodb status;', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (939, 3, '22', '查看当前状态产生的InnoDB锁，仅在有锁等待时有结果输出', 'select * from information_schema.innodb_locks', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (940, 3, '21', '查看当前状态产生的InnoDB锁等待，仅在有锁等待时有结果输出', 'select * from information_schema.innodb_lock_waits', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (941, 3, '22', '当前Innodb内核中的当前活跃（active）事务', 'select * from information_schema.innodb_trx', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (942, 3, '23', '锁详情', 'select r.trx_isolation_level,\n       r.trx_id              waiting_trx_id,\n       r.trx_mysql_thread_id waiting_trx_thread,\n       r.trx_state           waiting_trx_state,\n       lr.lock_mode          waiting_trx_lock_mode,\n       lr.lock_type          waiting_trx_lock_type,\n       lr.lock_table         waiting_trx_lock_table,\n       lr.lock_index         waiting_trx_lock_index,\n       r.trx_query           waiting_trx_query,\n       b.trx_id              blocking_trx_id,\n       b.trx_mysql_thread_id blocking_trx_thread,\n       b.trx_state           blocking_trx_state,\n       lb.lock_mode          blocking_trx_lock_mode,\n       lb.lock_type          blocking_trx_lock_type,\n       lb.lock_table         blocking_trx_lock_table,\n       lb.lock_index         blocking_trx_lock_index,\n       b.trx_query           blocking_query\n  from information_schema.innodb_lock_waits w\n inner join information_schema.innodb_trx b\n    on b.trx_id = w.blocking_trx_id\n inner join information_schema.innodb_trx r\n    on r.trx_id = w.requesting_trx_id\n inner join information_schema.innodb_locks lb\n    on lb.lock_trx_id = w.blocking_trx_id\n inner join information_schema.innodb_locks lr\n    on lr.lock_trx_id = w.requesting_trx_id', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (943, 3, '24', '元数据锁的相关信息', 'select * from performance_schema.setup_instruments WHERE name=\'wait/lock/metadata/sql/mdl\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (944, 3, '', '', 'SELECT\n  locked_schema,\n  locked_table,\n  locked_type,\n  waiting_processlist_id,\n  waiting_age,\n  waiting_query,\n  waiting_state,\n  blocking_processlist_id,\n  blocking_age,\n  substring_index(sql_text, \'transaction_begin;\', -1) AS blocking_query,\n  sql_kill_blocking_connection\nFROM\n  (\n    SELECT\n      b.OWNER_THREAD_ID AS granted_thread_id,\n      a.OBJECT_SCHEMA AS locked_schema,\n      a.OBJECT_NAME AS locked_table,\n      \'Metadata Lock\' AS locked_type,\n      c.PROCESSLIST_ID AS waiting_processlist_id,\n      c.PROCESSLIST_TIME AS waiting_age,\n      c.PROCESSLIST_INFO AS waiting_query,\n      c.PROCESSLIST_STATE AS waiting_state,\n      d.PROCESSLIST_ID AS blocking_processlist_id,\n      d.PROCESSLIST_TIME AS blocking_age,\n      d.PROCESSLIST_INFO AS blocking_query,\n      concat(\'KILL \', d.PROCESSLIST_ID) AS sql_kill_blocking_connection\n    from\n      performance_schema.metadata_locks a\n      JOIN performance_schema.metadata_locks b ON a.OBJECT_SCHEMA = b.OBJECT_SCHEMA\n      AND a.OBJECT_NAME = b.OBJECT_NAME\n      AND a.lock_status = \'PENDING\'\n      AND b.lock_status = \'GRANTED\'\n      AND a.OWNER_THREAD_ID  b.OWNER_THREAD_ID\n      AND a.lock_type = \'EXCLUSIVE\'\n      JOIN performance_schema.threads c ON a.OWNER_THREAD_ID = c.THREAD_ID\n      JOIN performance_schema.threads d ON b.OWNER_THREAD_ID = d.THREAD_ID\n  ) t1,\n  (\n    SELECT\n      thread_id,\n      group_concat(\n        CASE\n          WHEN EVENT_NAME = \'statement/sql/begin\' THEN \'transaction_begin\'\n          ELSE sql_text\n        END\n        ORDER BY\n          event_id SEPARATOR \';\'\n      ) AS sql_text\n    FROM\n      performance_schema.events_statements_history\n    GROUP BY\n      thread_id\n  ) t2\nWHERE\n  t1.granted_thread_id = t2.thread_id', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (945, 3, '', '', 'SELECT\n    a.OBJECT_SCHEMA AS locked_schema,\n    a.OBJECT_NAME AS locked_table,\n    \"Metadata Lock\" AS locked_type,\n    c.PROCESSLIST_ID AS waiting_processlist_id,\n    c.PROCESSLIST_TIME AS waiting_age,\n    c.PROCESSLIST_INFO AS waiting_query,\n    c.PROCESSLIST_STATE AS waiting_state,\n    d.PROCESSLIST_ID AS blocking_processlist_id,\n    d.PROCESSLIST_TIME AS blocking_age,\n    d.PROCESSLIST_INFO AS blocking_query,\n    concat(\'KILL \', d.PROCESSLIST_ID) AS sql_kill_blocking_connection\nFROM\n    performance_schema.metadata_locks a\nJOIN performance_schema.metadata_locks b ON a.OBJECT_SCHEMA = b.OBJECT_SCHEMA\nAND a.OBJECT_NAME = b.OBJECT_NAME\nAND a.lock_status = \'PENDING\'\nAND b.lock_status = \'GRANTED\'\nAND a.OWNER_THREAD_ID  b.OWNER_THREAD_ID\nAND a.lock_type = \'EXCLUSIVE\'\nJOIN performance_schema.threads c ON a.OWNER_THREAD_ID = c.THREAD_ID\nJOIN performance_schema.threads d ON b.OWNER_THREAD_ID = d.THREAD_ID', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (946, 3, '', '', 'SELECT ps.*,  lock_summary.lock_summary  FROM sys.processlist ps  INNER JOIN (SELECT owner_thread_id,  GROUP_CONCAT(  DISTINCT CONCAT(mdl.LOCK_STATUS, \' \', mdl.lock_type, \' on \', IF(mdl.object_type=\'USER LEVEL LOCK\', CONCAT(mdl.object_name, \' (user lock)\'), CONCAT(mdl.OBJECT_SCHEMA, \'.\', mdl.OBJECT_NAME)))  ORDER BY mdl.object_type ASC, mdl.LOCK_STATUS ASC, mdl.lock_type ASC  SEPARATOR \'\\n\'  ) as lock_summary FROM performance_schema.metadata_locks mdl GROUP BY owner_thread_id) lock_summary ON (ps.thd_id=lock_summary.owner_thread_id)', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (947, 3, '', '', 'select * from sys.schema_table_lock_waits', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (948, 3, '25', '查看服务器的状态', 'select * from performance_schema.global_status where  VARIABLE_NAME  like \'%lock%\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (949, 3, '26', '跟踪长时间操作的进度', 'select * from performance_schema.events_stages_current', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (950, 3, '27', '查看平均执行时间值大于95%的平均执行时间的语句（可近似地认为是平均执行时间超长的语句），默认情况下按照语句平均延迟(执行时间)降序排序', 'SELECT sys.format_statement(DIGEST_TEXT) AS query,\n  SCHEMA_NAME as db,\n  IF(SUM_NO_GOOD_INDEX_USED &gt; 0 OR SUM_NO_INDEX_USED &gt; 0, \'*\', \'\') AS full_scan,\n  COUNT_STAR AS exec_count,\n  SUM_ERRORS AS err_count,\n  SUM_WARNINGS AS warn_count,\n  sys.format_time(SUM_TIMER_WAIT) AS total_latency,\n  sys.format_time(MAX_TIMER_WAIT) AS max_latency,\n  sys.format_time(AVG_TIMER_WAIT) AS avg_latency,\n  SUM_ROWS_SENT AS rows_sent,\n  ROUND(IFNULL(SUM_ROWS_SENT / NULLIF(COUNT_STAR, 0), 0)) AS rows_sent_avg,\n  SUM_ROWS_EXAMINED AS rows_examined,\n  ROUND(IFNULL(SUM_ROWS_EXAMINED / NULLIF(COUNT_STAR, 0), 0)) AS rows_examined_avg,\n  FIRST_SEEN AS first_seen,\n  LAST_SEEN AS last_seen,\n  DIGEST AS digest\nFROM performance_schema.events_statements_summary_by_digest stmts\nJOIN sys.x$ps_digest_95th_percentile_by_avg_us AS top_percentile\nON ROUND(stmts.avg_timer_wait/1000000) &gt;= top_percentile.avg_us\nORDER BY AVG_TIMER_WAIT DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (951, 3, '28', '查看当前正在执行的语句进度信息', 'select * from sys.session where conn_id!=connection_id() and trx_state=\'ACTIVE\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (952, 3, '29', '查看已经执行完的语句相关统计信息', 'select * from sys.session where conn_id!=connection_id() and trx_state=\'COMMITTED\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (953, 3, '30', '查看使用了临时表的语句，默认情况下按照磁盘临时表数量和内存临时表数量进行降序排序', 'SELECT sys.format_statement(DIGEST_TEXT) AS query,\n  SCHEMA_NAME as db,\n  COUNT_STAR AS exec_count,\n  sys.format_time(SUM_TIMER_WAIT) as total_latency,\n  SUM_CREATED_TMP_TABLES AS memory_tmp_tables,\n  SUM_CREATED_TMP_DISK_TABLES AS disk_tmp_tables,\n  ROUND(IFNULL(SUM_CREATED_TMP_TABLES / NULLIF(COUNT_STAR, 0), 0)) AS avg_tmp_tables_per_query,\n  ROUND(IFNULL(SUM_CREATED_TMP_DISK_TABLES / NULLIF(SUM_CREATED_TMP_TABLES, 0), 0) * 100) AS tmp_tables_to_disk_pct,\n  FIRST_SEEN as first_seen,\n  LAST_SEEN as last_seen,\n  DIGEST AS digest\nFROM performance_schema.events_statements_summary_by_digest\nWHERE SUM_CREATED_TMP_TABLES &gt; 0\nORDER BY SUM_CREATED_TMP_DISK_TABLES DESC, SUM_CREATED_TMP_TABLES DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (954, 3, '31', '有临时表的前10条SQL语句', 'SELECT * FROM sys.statement_analysis WHERE tmp_tables &gt; 0 ORDER BY tmp_tables DESC LIMIT 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (955, 3, '32', '查看执行了文件排序的语句，默认情况下按照语句总延迟时间（执行时间）降序排序', 'SELECT sys.format_statement(DIGEST_TEXT) AS query,\n  SCHEMA_NAME db,\n  COUNT_STAR AS exec_count,\n  sys.format_time(SUM_TIMER_WAIT) AS total_latency,\n  SUM_SORT_MERGE_PASSES AS sort_merge_passes,\n  ROUND(IFNULL(SUM_SORT_MERGE_PASSES / NULLIF(COUNT_STAR, 0), 0)) AS avg_sort_merges,\n  SUM_SORT_SCAN AS sorts_using_scans,\n  SUM_SORT_RANGE AS sort_using_range,\n  SUM_SORT_ROWS AS rows_sorted,\n  ROUND(IFNULL(SUM_SORT_ROWS / NULLIF(COUNT_STAR, 0), 0)) AS avg_rows_sorted,\n  FIRST_SEEN as first_seen,\n  LAST_SEEN as last_seen,\n  DIGEST AS digest\nFROM performance_schema.events_statements_summary_by_digest\nWHERE SUM_SORT_ROWS &gt; 0\nORDER BY SUM_TIMER_WAIT DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (956, 3, '33', '查询SQL的整体消耗百分比', 'select state,\n       sum(duration) as total_r,\n       round(100 * sum(duration) / (select sum(duration) from information_schema.profiling  where query_id = 1),2) as pct_r,\n       count(*) as calls,\n       sum(duration) / count(*) as \"r/call\"\n  from information_schema.profiling\n where query_id = 1\n group by state\n order by total_r desc', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (957, 3, '34', '执行次数Top10', 'SELECT * FROM sys.statement_analysis WHERE full_scan = \'*\' order by exec_count desc limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (958, 3, '35', '使用全表扫描的SQL语句', 'SELECT object_schema,\n  object_name,\n  count_read AS rows_full_scanned,\n  sys.format_time(sum_timer_wait) AS latency\nFROM performance_schema.table_io_waits_summary_by_index_usage\nWHERE index_name IS NULL\nAND count_read &gt; 0\nORDER BY count_read DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (959, 3, '36', '查看全表扫描或者没有使用到最优索引的语句（经过标准化转化的语句文本），默认情况下按照全表扫描次数与语句总次数百分比和语句总延迟时间(执行时间)降序排序', 'SELECT sys.format_statement(DIGEST_TEXT) AS query,\n  SCHEMA_NAME as db,\n  COUNT_STAR AS exec_count,\n  sys.format_time(SUM_TIMER_WAIT) AS total_latency,\n  SUM_NO_INDEX_USED AS no_index_used_count,\n  SUM_NO_GOOD_INDEX_USED AS no_good_index_used_count,\n  ROUND(IFNULL(SUM_NO_INDEX_USED / NULLIF(COUNT_STAR, 0), 0) * 100) AS no_index_used_pct,\n  SUM_ROWS_SENT AS rows_sent,\n  SUM_ROWS_EXAMINED AS rows_examined,\n  ROUND(SUM_ROWS_SENT/COUNT_STAR) AS rows_sent_avg,\n  ROUND(SUM_ROWS_EXAMINED/COUNT_STAR) AS rows_examined_avg,\n  FIRST_SEEN as first_seen,\n  LAST_SEEN as last_seen,\n  DIGEST AS digest\nFROM performance_schema.events_statements_summary_by_digest\nWHERE (SUM_NO_INDEX_USED &gt; 0\nOR SUM_NO_GOOD_INDEX_USED &gt; 0)\nAND DIGEST_TEXT NOT LIKE \'SHOW%\'\nORDER BY no_index_used_pct DESC, total_latency DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (960, 3, '37', '查看产生错误或警告的语句，默认情况下，按照错误数量和警告数量降序排序', 'SELECT sys.format_statement(DIGEST_TEXT) AS query,\n  SCHEMA_NAME as db,\n  COUNT_STAR AS exec_count,\n  SUM_ERRORS AS errors,\n  IFNULL(SUM_ERRORS / NULLIF(COUNT_STAR, 0), 0) * 100 as error_pct,\n  SUM_WARNINGS AS warnings,\n  IFNULL(SUM_WARNINGS / NULLIF(COUNT_STAR, 0), 0) * 100 as warning_pct,\n  FIRST_SEEN as first_seen,\n  LAST_SEEN as last_seen,\n  DIGEST AS digest\nFROM performance_schema.events_statements_summary_by_digest\nWHERE SUM_ERRORS &gt; 0\nOR SUM_WARNINGS &gt; 0\nORDER BY SUM_ERRORS DESC, SUM_WARNINGS DESC limit 10', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (961, 3, '38', '无效索引（从未使用过的索引）', 'select * from sys.schema_unused_indexes', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (962, 3, '39', ' 区分度越接近1，表示区分度越高；低于0.1，则说明区分度较差，开发者应该重新评估SQL语句涉及的字段，选择区分度高的多个字段创建索引', 'SELECT\ni.database_name ASdb,\ni.table_name AStable,\ni.index_name ASindex_name,\ni.stat_description AScols,\ni.stat_value ASdefferRows,\nt.n_rows ASROWS,\nROUND(((i.stat_value / IFNULL(IF(t.n_rows &lt; i.stat_value,i.stat_value,t.n_rows),0.01))),2) AS sel_persent\nFROM mysql.innodb_index_stats i\nINNER JOIN mysql.innodb_table_stats t\nON i.database_name = t.database_name AND i.table_name= t.table_name\nWHERE i.index_name != \'PRIMARY\' AND i.stat_name LIKE \'%n_diff_pfx%\'\nand ROUND(((i.stat_value / IFNULL(IF(t.n_rows &lt; i.stat_value,i.stat_value,t.n_rows),0.01))),2)&lt;0.1\nand t.n_rows !=0\nand i.stat_value !=0\nand i.database_name not in (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\nlimit 100', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (963, 3, '40', '主从复制涉及到的重要参数', 'select * from performance_schema.global_variables where  VARIABLE_NAME  in ( \'server_id\',\'server_uuid\',\'log_bin\',\'log_bin_basename\',\'sql_log_bin\',\'log_bin_index\',\'log_slave_updates\',\'read_only\',\'slave_skip_errors\',\'max_allowed_packet\',\'slave_max_allowed_packet\',\'auto_increment_increment\',\'auto_increment_offset\',\'sync_binlog\',\'binlog_format\',\'expire_logs_days\',\'max_binlog_size\',\'slave_skip_errors\',\'sql_slave_skip_counter\',\'slave_exec_mode\',\'rpl_semi_sync_master_enabled\',\'rpl_semi_sync_master_timeout\',\'rpl_semi_sync_master_trace_level\',\'rpl_semi_sync_master_wait_for_slave_count\',\'rpl_semi_sync_master_wait_no_slave\',\'rpl_semi_sync_master_wait_point\',\'rpl_semi_sync_slave_enabled\',\'rpl_semi_sync_slave_trace_level\')', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (964, 3, '41', '半同步参数统计', 'select * from performance_schema.global_status where  VARIABLE_NAME  like \'rpl_semi%\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (965, 3, '42', '主从库线程', 'SELECT *\nFROM performance_schema.threads a\nWHERE a.`NAME` IN ( \'thread/sql/slave_IO\', \'thread/sql/slave_sql\',\'thread/sql/slave_worker\'\n                   ,\'thread/sql/replica_io\',\'thread/sql/replica_sql\',\'thread/sql/replica_worker\' )\n or a.PROCESSLIST_COMMAND in (\'Binlog Dump\',\'Binlog Dump GTID\')', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (966, 3, '43', '主库端查看所有从库', 'show slave hosts;', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (967, 3, '44', 'MGR详情', 'SELECT * FROM performance_schema.replication_group_members', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (968, 3, '45', '主库状态监测', 'show master status;', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (969, 3, '46', '从库状态监测（需要在从库执行才有数据）', 'show slave status;', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (970, 3, '47', '从库状态查询', 'select rcc.CHANNEL_NAME,rcc.`HOST`,rcc.`PORT`,rcc.`USER`,rcc.CONNECTION_RETRY_COUNT,rcc.CONNECTION_RETRY_INTERVAL,\nrcs.SOURCE_UUID,rcs.THREAD_ID,rcs.SERVICE_STATE,rcs.COUNT_RECEIVED_HEARTBEATS,rcs.LAST_HEARTBEAT_TIMESTAMP,rcs.LAST_ERROR_NUMBER,rcs.LAST_ERROR_MESSAGE,rcs.LAST_ERROR_TIMESTAMP\nfrom performance_schema.replication_connection_configuration rcc,\n     performance_schema.replication_connection_status rcs\nwhere rcc.CHANNEL_NAME=rcs.CHANNEL_NAME', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (971, 3, '48', '克隆进度和状态', 'SELECT * FROM performance_schema.clone_status', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (972, 3, '49', '性能参数统计', 'select * from performance_schema.global_status where  VARIABLE_NAME  in ( \'connections\',\'uptime\',\'com_select\',\'com_insert\',\'com_delete\',\'slow_queries\',\'Created_tmp_tables\',\'Created_tmp_files\',\'Created_tmp_disk_tables\',\'table_cache\',\'Handler_read_rnd_next\',\'Table_locks_immediate\',\'Table_locks_waited\',\'Open_files\',\'Opened_tables\',\'Sort_merge_passes\',\'Sort_range\',\'Sort_rows\',\'Sort_scan\')', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (973, 3, '50', 'setup_consumers', 'SELECT * FROM performance_schema.setup_consumers', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (974, 3, '51', '自增ID的使用情况（前20条）', 'SELECT table_schema,table_name,engine, Auto_increment\n FROM information_schema.tables a\n where TABLE_SCHEMA not in (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\n and  a.Auto_increment\'\'\n order by a.AUTO_INCREMENT desc\nlimit 20 ', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (975, 3, '52', '无主键或唯一键的表（前100条）', 'select table_schema, table_name\n from information_schema.tables\nwhere table_type=\'BASE TABLE\'\n and  (table_schema, table_name) not in ( select /*+ subquery(materialization) */ a.TABLE_SCHEMA,a.TABLE_NAME\n           from information_schema.TABLE_CONSTRAINTS a\n		   where a.CONSTRAINT_TYPE in (\'PRIMARY KEY\',\'UNIQUE\')\n		   and table_schema not in    (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')	)\n AND table_schema not in  (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\nlimit 100 ', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (976, 3, '53', '自增ID的使用情况（前20条）', 'SELECT table_schema,table_name,engine, Auto_increment\n FROM information_schema.tables a\n where TABLE_SCHEMA not in (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\n and  a.Auto_increment\'\'\n order by a.AUTO_INCREMENT desc\nlimit 20', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (995, 5, '●', '实例信息', 'select pg_postmaster_start_time() pg_start_time ,\nextract(epoch from now() - pg_postmaster_start_time()) run_time,\npg_conf_load_time() config_file_load_time,\ninet_server_addr() server_IP,\ninet_server_port() server_port,\ninet_client_addr() client_ip,\ninet_client_port() client_port,\nversion() server_version,\n(case when pg_is_in_recovery()=\'f\' then \'primary\' else \'standby\' end ) as  primary_or_standby,\nnow() now_date,\n(SELECT trunc(sum(blks_hit)/(sum(blks_read)+sum(blks_hit))*100,2)||\'%\' hit from pg_stat_database) all_db_hit ', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (996, 5, '●', '服务器OS类型', 'select version();', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (997, 5, '', '', 'select * from pg_config d WHERE d.name=\'BINDIR\';', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (998, 5, '●', '数据库基本信息', 'SELECT d.datname as \"Name\",\n       pg_catalog.pg_get_userbyid(d.datdba) as \"Owner\",\n       pg_catalog.pg_encoding_to_char(d.encoding) as \"Encoding\",\n       d.datcollate as \"Collate\",\n       d.datctype as \"Ctype\",\n       pg_catalog.array_to_string(d.datacl, E\'\\n\') AS \"Access privileges\",\n       CASE WHEN pg_catalog.has_database_privilege(d.datname, \'CONNECT\')\n            THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))\n            ELSE \'No Access\'\n       END as \"Size\",\n       t.spcname as \"Tablespace\",\n       pg_catalog.shobj_description(d.oid, \'pg_database\') as \"Description\",\n       age(datfrozenxid) age\nFROM pg_catalog.pg_database d\n  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid\nORDER BY 1', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (999, 5, '●', '查看各数据库数据创建时间', 'SELECT\n	datname,\n	(\n	pg_stat_file (\n	format ( \'%s/%s/PG_VERSION\', CASE WHEN spcname = \'pg_default\' THEN \'base\' ELSE\'pg_tblspc/\' || t2.oid || \'/PG_11_201804061/\' END, t1.oid ))).* \nFROM\n	pg_database t1,\n	pg_tablespace t2 \nWHERE\n	t1.dattablespace = t2.oid;', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1000, 5, '●', '所有表空间', 'SELECT oid,spcname AS \"Name\",\n  pg_catalog.pg_get_userbyid(spcowner) AS \"Owner\",\n  pg_catalog.pg_tablespace_location(oid) AS \"Location\",\n  pg_catalog.array_to_string(spcacl, E\'\\n\') AS \"Access privileges\",\n  spcoptions AS \"Options\",\n  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS \"Size\",\n  pg_catalog.shobj_description(oid, \'pg_tablespace\') AS \"Description\"\nFROM pg_catalog.pg_tablespace\nORDER BY 1;', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1001, 5, '●', '当前客户端连接信息', 'select current_user,current_database(),pg_backend_pid();', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1002, 5, '●', '前几张大表', 'SELECT\n	t.table_catalog as db,\n	n.nspname AS schemaname,\n	c.relname,\n	c.reltuples::numeric as rowcount,\n	pg_size_pretty(pg_table_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS table_size,\n    pg_size_pretty(pg_indexes_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS indexes_size,\n	pg_size_pretty (pg_total_relation_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS total_size --,pg_relation_filepath(table_name) filepath\nFROM pg_class C \n	LEFT JOIN pg_namespace N ON ( N.oid = C.relnamespace ) \n	left join information_schema.tables t on (n.nspname= t.table_schema and c.relname=t.\"table_name\" )\nWHERE\n	nspname NOT IN ( \'information_schema\' ) \n	AND relkind in (\'r\',\'p\')  \nORDER BY\n	pg_total_relation_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' ) DESC \n	LIMIT 20;', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1003, 5, '●', '查询当前所有表的年龄', 'SELECT c.oid::regclass as table_name,\n     greatest(age(c.relfrozenxid),age(t.relfrozenxid)) as age\nFROM pg_class c\nLEFT JOIN pg_class t ON c.reltoastrelid = t.oid\nWHERE c.relkind IN (\'r\', \'m\')\norder by age desc \nlimit 20;', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1004, 5, '●', '当前库的所有数据库对象', 'select \n    nsp.nspname as SchemaName\n    ,case cls.relkind\n        when \'r\' then \'TABLE\'\n        when \'m\' then \'MATERIALIZED_VIEW\'\n        when \'i\' then \'INDEX\'\n        when \'S\' then \'SEQUENCE\'\n        when \'v\' then \'VIEW\'\n        when \'c\' then \'composite type\'\n        when \'t\' then \'TOAST\'\n        when \'f\' then \'foreign table\'\n        when \'p\' then \'partitioned_table\'\n        when \'I\' then \'partitioned_index\'\n        else cls.relkind::text\n    end as ObjectType,\n    COUNT(*) cnt\nfrom pg_class cls\njoin pg_namespace nsp \n on nsp.oid = cls.relnamespace\nwhere nsp.nspname not in (\'information_schema\', \'pg_catalog\')\n  and nsp.nspname not like \'pg_toast%\'\nGROUP BY nsp.nspname,cls.relkind;', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1005, 5, '', '', 'SELECT n.nspname as \"Schema\",\n CASE p.prokind\n  WHEN \'a\' THEN \'agg\'\n  WHEN \'w\' THEN \'window\'\n  WHEN \'p\' THEN \'proc\'\n  ELSE \'func\'\n END as \"Type\",\n COUNT(*) cnt\nFROM pg_catalog.pg_proc p\nLEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace\nWHERE pg_catalog.pg_function_is_visible(p.oid)\nAND n.nspname not in (\'information_schema\', \'pg_catalog\')\nGROUP BY n.nspname ,p.prokind;', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1006, 5, '●', '所有进程总计', 'SELECT\n	max_conn 最大连接数,\n	now_conn 当前连接数,\n	max_conn - now_conn 剩余连接数 \nFROM\n	( SELECT setting::int8  AS max_conn, ( SELECT COUNT ( * ) FROM pg_stat_activity ) AS now_conn FROM pg_settings WHERE NAME = \'max_connections\' ) T;', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1007, 5, '●', '所有进程用户统计', 'select a.usename ,COUNT(*) cnt   from pg_stat_activity  a  GROUP BY a.usename ORDER BY cnt;', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1008, 5, '●', '所有进程状态统计', 'select a.state,COUNT(*) cnt   from pg_stat_activity  a  GROUP BY a.state;', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1009, 5, '●', '所有进程详情', 'select a.*   from pg_stat_activity  a order by a.state,query_start  limit 100;', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1010, 5, '●', '锁', 'SELECT * FROM pg_locks;', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1011, 5, '●', '锁详情', 'SELECT pg_locks.pid as pid,  --进程ID\n      transactionid as transaction_id, --事务ID\n			 pd.datname db_name,\n      nspname as schemaname,  --schema名\n      relname as object_name,  --对象名\n      locktype as lock_type,  --锁类型\n      mode lock_mode, \n      CASE\n        WHEN granted = \'f\' THEN\n         \'get_lock\'\n        WHEN granted = \'t\' THEN\n         \'wait_lock\'\n      END lock_satus, \n      least(query_start, xact_start) AS query_start, \n      substr(query, 1, 25) AS query_text  \n FROM pg_locks\n	left join pg_database pd\n	on (pg_locks.database=pd.oid)\n LEFT OUTER JOIN pg_class\n   ON (pg_locks.relation = pg_class.oid)\n LEFT OUTER JOIN pg_namespace\n   ON (pg_namespace.oid = pg_class.relnamespace),  pg_stat_activity\nWHERE NOT pg_locks.pid = pg_backend_pid()\n  AND pg_locks.pid = pg_stat_activity.pid\nORDER BY query_start;', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1012, 5, '●', 'state_change字段长时间没有更新过的连接信息', 'SELECT * FROM pg_stat_activity where state=\'idle\' order by state_change limit  20;', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1013, 5, '●', '慢查询SQL', 'SELECT pgsa.pid,\n      pgsa.client_port,\n      pgsa.datname AS datname, \n      pgsa.usename AS usename, \n      pgsa.client_addr client_addr, \n      pgsa.application_name AS application_name, \n      pgsa.state AS state, \n      pgsa.backend_start AS backend_start, \n      pgsa.xact_start AS xact_start, \n      state_change,\n      pgsa.query_start AS query_start, \n      TRUNC(EXTRACT( epoch  FROM  (NOW() - pgsa.xact_start)  )) AS xact_stay, \n      trunc(EXTRACT( epoch  FROM  (NOW() - pgsa.query_start) )) AS query_stay, \n      REPLACE(pgsa.QUERY, chr(10),  \' \') AS QUERY,\n      pgsa.wait_event,pgsa.wait_event_type,pgsa.backend_type,\n      \'select pg_terminate_backend(\'||pgsa.pid||\');\' kill1,\n      \'select pg_cancel_backend(\'||pgsa.pid||\');\' kill2\n    FROM   pg_stat_activity AS pgsa\n	WHERE   pgsa.state not in ( \'idle\' ,\'idle in transaction (aborted)\' )\nORDER BY  query_stay DESC,xact_stay DESC\nLIMIT  100;', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1014, 5, '●', '总执行时间最长的SQL（需要配置插件）', 'SELECT query,\n      calls,\n      round(total_exec_time::numeric, 2) AS total_time,\n      round(mean_exec_time::numeric, 2) AS mean_time,\n      round((100 * total_exec_time / sum(total_exec_time) OVER ())::numeric, 2) AS percentage\nFROM pg_stat_statements\nORDER BY total_exec_time DESC\nLIMIT 10;', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1015, 5, '', '', 'SELECT query,\n      calls,\n      round(total_time::numeric, 2) AS total_time,\n      round(mean_time::numeric, 2) AS mean_time,\n      round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage\nFROM pg_stat_statements\nORDER BY total_time DESC\nLIMIT 10;', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1016, 5, '●', '最耗IO的SQL', '-- 如果要跟踪IO消耗的时间，还需要打开trace_io_timing参数\n\nSELECT query,\n      calls,\n      round(total_exec_time::numeric, 2) AS total_time,\n      round(blk_read_time::numeric, 2) AS io_read_time,\n      round(blk_write_time::numeric, 2) AS io_write_time,\n      round((100 * total_exec_time / sum(total_exec_time) OVER ())::numeric, 2) AS percentage\nFROM pg_stat_statements\nORDER BY blk_read_time + blk_write_time DESC\nLIMIT 10;', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1017, 5, '', '', 'SELECT query,\n      calls,\n      round(total_time::numeric, 2) AS total_time,\n      round(blk_read_time::numeric, 2) AS io_read_time,\n      round(blk_write_time::numeric, 2) AS io_write_time,\n      round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage\nFROM pg_stat_statements\nORDER BY blk_read_time + blk_write_time DESC\nLIMIT 10;', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1018, 5, '●', '最耗共享内存', 'select * from pg_stat_statements order by shared_blks_hit+shared_blks_read desc limit 5;', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1019, 5, '●', '从未使用过的索引统计', 'SELECT    \nschemaname || \'.\' || relname AS table,\nindexrelname AS index,\npg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,\nidx_scan as index_scans\nFROM pg_stat_user_indexes ui\nJOIN pg_index i ON ui.indexrelid = i.indexrelid\nWHERE NOT indisunique\nAND idx_scan  5 * 8192\nORDER BY pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,\npg_relation_size(i.indexrelid) DESC;', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1020, 5, '●', '占用空间最大的几个索引', 'SELECT\n    t.schemaname,\n    t.tablename,\n    c.reltuples::bigint                            AS num_rows,\n    pg_size_pretty(pg_relation_size(c.oid))        AS table_size,\n    psai.indexrelname                              AS index_name,\n    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,\n    CASE WHEN i.indisunique THEN \'Y\' ELSE \'N\' END  AS \"unique\",\n    psai.idx_scan                                  AS number_of_scans,\n    psai.idx_tup_read                              AS tuples_read,\n    psai.idx_tup_fetch                             AS tuples_fetched,\n    pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)   as  create_index\nFROM\n    pg_tables t\n    LEFT JOIN pg_class c ON t.tablename = c.relname\n    LEFT JOIN pg_index i ON c.oid = i.indrelid\n    LEFT JOIN pg_stat_all_indexes psai ON i.indexrelid = psai.indexrelid\nWHERE t.schemaname NOT IN (\'pg_catalog\', \'information_schema\')\nAND pg_relation_size(i.indexrelid) &gt; 0\nORDER BY pg_relation_size(i.indexrelid) DESC\nlimit 10;', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1021, 5, '●', '主库查看wal日志发送状态', 'select * from pg_stat_replication;', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1022, 5, '●', '从库查看wal日志接收状态', 'select * from pg_stat_wal_receiver;', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1023, 5, '●', '主从库延迟数据（单位MB）', 'select pg_wal_lsn_diff(A .c1, replay_lsn) /(1024 * 1024) AS slave_latency_MB\nfrom pg_stat_replication,\n     pg_current_wal_lsn() AS A(c1)\nORDER BY slave_latency_MB LIMIT 1;', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1024, 5, '●', '主从流复制冲突统计', 'select * from pg_stat_database_conflicts;', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1025, 5, '●', '逻辑复制查看发布', 'select * from pg_publication;', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (1026, 5, '●', '查看发布的表', 'select * from pg_publication_tables;', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (1027, 5, '●', '查看所有的订阅者', 'select * from pg_stat_replication;', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (1028, 5, '●', '复制进度', 'select * from pg_stat_subscription;', 0, 33);
INSERT INTO `tbl_chktemple_item` VALUES (1029, 5, '●', '查看订阅', 'select * from pg_subscription;', 0, 34);
INSERT INTO `tbl_chktemple_item` VALUES (1030, 5, '●', '查看订阅的表', 'select *,srrelid::regclass from pg_subscription_rel; ', 0, 35);
INSERT INTO `tbl_chktemple_item` VALUES (1031, 5, '●', '查看复制槽', 'select * from pg_replication_slots;', 0, 36);
INSERT INTO `tbl_chktemple_item` VALUES (1032, 5, '●', '参数文件记录的参数', 'select * from pg_file_settings;', 0, 37);
INSERT INTO `tbl_chktemple_item` VALUES (1033, 5, '●', '重要参数', 'SELECT *\nFROM   pg_settings a\nWHERE  a.name IN (\'data_directory\',\n                  \'port\',\n                  \'client_encoding\',\n                  \'config_file\',\n                  \'hba_file\',\n                  \'ident_file\',\n                  \'archive_mode\',\n                  \'logging_collector\',\n                  \'log_directory\',\n                  \'log_filename\',\n                  \'log_truncate_on_rotation\',\n                  \'log_statement\',\n                  \'log_min_duration_statement\',\n                  \'max_connections\',\'listen_addresses\')\nORDER  BY NAME;', 0, 38);
INSERT INTO `tbl_chktemple_item` VALUES (1034, 5, '●', 'pg_hba.conf配置文件信息（PG10新增）', 'select * from pg_hba_file_rules;', 0, 39);
INSERT INTO `tbl_chktemple_item` VALUES (1035, 5, '●', '后台写进程统计信息', 'select * from pg_stat_bgwriter;', 0, 40);
INSERT INTO `tbl_chktemple_item` VALUES (1036, 5, '●', 'WAL日志切换频率（需要手动修改脚本路径）', 'with tmp_file as (\n  select t1.file,\n      t1.file_ls,\n      (pg_stat_file(t1.file)).size as size,\n      (pg_stat_file(t1.file)).access as access,\n      (pg_stat_file(t1.file)).modification as last_update_time,\n      (pg_stat_file(t1.file)).change as change,\n      (pg_stat_file(t1.file)).creation as creation,\n      (pg_stat_file(t1.file)).isdir as isdir\n   from (select dir||\'/\'||pg_ls_dir(t0.dir) as file,\n          pg_ls_dir(t0.dir) as file_ls\n       from ( select \'/pg13/pgdata/pg_wal\'::text as dir  -- 需要修改这个物理路径\n          ) t0\n      ) t1 \n   where 1=1\n   order by (pg_stat_file(file)).modification desc\n) \nselect to_char(date_trunc(\'day\',tf0.last_update_time),\'yyyymmdd\') as day_id,\n    sum(case when date_part(\'hour\',tf0.last_update_time) &gt;=0 and date_part(\'hour\',tf0.last_update_time) =0 and date_part(\'hour\',tf0.last_update_time) =1 and date_part(\'hour\',tf0.last_update_time) =2 and date_part(\'hour\',tf0.last_update_time) =3 and date_part(\'hour\',tf0.last_update_time) =4 and date_part(\'hour\',tf0.last_update_time) =5 and date_part(\'hour\',tf0.last_update_time) =6 and date_part(\'hour\',tf0.last_update_time) =7 and date_part(\'hour\',tf0.last_update_time) =8 and date_part(\'hour\',tf0.last_update_time) =9 and date_part(\'hour\',tf0.last_update_time) =10 and date_part(\'hour\',tf0.last_update_time) =11 and date_part(\'hour\',tf0.last_update_time) =12 and date_part(\'hour\',tf0.last_update_time) =13 and date_part(\'hour\',tf0.last_update_time) =14 and date_part(\'hour\',tf0.last_update_time) =15 and date_part(\'hour\',tf0.last_update_time) =16 and date_part(\'hour\',tf0.last_update_time) =17 and date_part(\'hour\',tf0.last_update_time) =18 and date_part(\'hour\',tf0.last_update_time) =19 and date_part(\'hour\',tf0.last_update_time) =20 and date_part(\'hour\',tf0.last_update_time) =21 and date_part(\'hour\',tf0.last_update_time) =22 and date_part(\'hour\',tf0.last_update_time) =23 and date_part(\'hour\',tf0.last_update_time) = 1000\nand pg_table_size(schemaname||\'.\'||relname) &gt;=1*1024*1024*1024\nand round(n_dead_tup * 100 / (n_live_tup + n_dead_tup),2)  &gt; 10\nand pg_table_size(schemaname||\'.\'||relname) *  (n_dead_tup * 100 / (n_live_tup + n_dead_tup))/100 &gt; 1*1024*1024*1024\nORDER BY pg_table_size(schemaname||\'.\'||relname) *  (n_dead_tup * 100 / (n_live_tup + n_dead_tup))/100   desc,dead_tup_ratio DESC\nLIMIT 50;', 0, 44);
INSERT INTO `tbl_chktemple_item` VALUES (1037, 5, '●', '缓存命中率', 'SELECT * from (SELECT\ndatname,\nblks_read::text blks_read,\nblks_hit::text blks_hit,\nxact_commit::text,\nxact_rollback::text,\n trunc((blks_hit::numeric/(blks_read + blks_hit)) * 100,2)||\'%\'  cache_hit, \n trunc((xact_commit::numeric/(xact_commit + xact_rollback)) * 100,2)||\'%\'  commit_hit,\n stats_reset::VARCHAR stats_reset\nFROM pg_stat_database \nwhere datname not in (\'template0\',\'template1\') \nand blks_read + blks_hit &gt; 0 \nORDER BY cache_hit) aa\nunion all\nselect \'------\',\'\',\'\',\'\',\'\',\ntrunc(sum(blks_hit)/(sum(blks_read)+sum(blks_hit))*100,2)||\'%\' cache_hit,\ntrunc(sum(xact_commit)/(sum(xact_commit)+sum(xact_rollback))*100,2)||\'%\'  commit_hit,\n\'\'\n from pg_stat_database d \nwhere d.datname not in (\'template0\',\'template1\') ;', 0, 45);
INSERT INTO `tbl_chktemple_item` VALUES (1038, 5, '●', '数据库统计详情(坏块等)', 'select * from pg_stat_database;', 0, 46);
INSERT INTO `tbl_chktemple_item` VALUES (1039, 5, '●', '复制槽活动信息', 'SELECT * FROM pg_stat_replication_slots ;', 0, 47);
INSERT INTO `tbl_chktemple_item` VALUES (1040, 5, '●', 'copy进度', 'SELECT * FROM pg_stat_progress_copy ;', 0, 48);
INSERT INTO `tbl_chktemple_item` VALUES (1041, 5, '●', '显示访问cached pages的统计信息', 'select * from pg_stat_slru;', 0, 49);
INSERT INTO `tbl_chktemple_item` VALUES (1042, 5, '●', '查看share buffer的使用情况', 'select * from pg_shmem_allocations;', 0, 50);
INSERT INTO `tbl_chktemple_item` VALUES (1043, 5, '●', '查询备份进度', 'select * from pg_stat_progress_basebackup;', 0, 51);
INSERT INTO `tbl_chktemple_item` VALUES (1044, 5, '●', '所有角色(用户)', 'select * from pg_roles;', 0, 52);
INSERT INTO `tbl_chktemple_item` VALUES (1045, 5, '', '', 'select * from pg_user;', 0, 53);
INSERT INTO `tbl_chktemple_item` VALUES (1046, 5, '', '', 'select * from pg_shadow;', 0, 54);
INSERT INTO `tbl_chktemple_item` VALUES (1047, 5, '●', '用户和角色', 'SELECT r.rolname, r.rolsuper, r.rolinherit,\n  r.rolcreaterole, r.rolcreatedb, r.rolcanlogin,\n  r.rolconnlimit, r.rolvaliduntil,\n  ARRAY(SELECT b.rolname\n        FROM pg_catalog.pg_auth_members m\n        JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)\n        WHERE m.member = r.oid) as memberof\n, r.rolcreaterextgpfd\n, r.rolcreatewextgpfd\n, r.rolcreaterexthttp\n, r.rolreplication\nFROM pg_catalog.pg_roles r\nORDER BY 1;', 0, 55);
INSERT INTO `tbl_chktemple_item` VALUES (1048, 5, '●', '当前库的所有schema', 'select * from information_schema.schemata;', 0, 56);
INSERT INTO `tbl_chktemple_item` VALUES (1049, 5, '●', '所有语言', 'select * from pg_language;', 0, 57);
INSERT INTO `tbl_chktemple_item` VALUES (1050, 5, '●', '所有插件（已编译）', 'select * from pg_available_extensions ;', 0, 58);
INSERT INTO `tbl_chktemple_item` VALUES (1051, 5, '●', '已安装的插件', 'SELECT e.extname AS \"Name\", e.extversion AS \"Version\", n.nspname AS \"Schema\", c.description AS \"Description\"\nFROM pg_catalog.pg_extension e LEFT JOIN pg_catalog.pg_namespace n ON n.oid = e.extnamespace LEFT JOIN pg_catalog.pg_description c ON c.objoid = e.oid AND c.classoid = \'pg_catalog.pg_extension\'::pg_catalog.regclass\nORDER BY 1;', 0, 59);
INSERT INTO `tbl_chktemple_item` VALUES (1052, 5, '●', '获取已安装的PostgreSQL的信息', 'SELECT * FROM pg_config ;', 0, 60);
INSERT INTO `tbl_chktemple_item` VALUES (1089, 7, '●', '数据库基本信息', 'SELECT  now() now_date,\n	USER() user, -- USER()、 SYSTEM_USER()、 SESSION_USER()、 \n	CURRENT_USER() CURRENT_USER1,\n	CONNECTION_ID() CONNECTION_ID,\n	DATABASE() db_name, -- SCHEMA(),\n	version() Server_version,\n	( SELECT sum( TRUNCATE ( ( data_length + index_length ) / 1024 / 1024, 2 ) ) AS \'all_db_size(MB)\' FROM information_schema.TABLES b ) all_db_size_MB,\n	( SELECT @@datadir ) datadir,\n	-- ( SELECT @@tx_isolation ) tx_isolation, -- SELECT @@transaction_isolation tx_isolation\n	( SELECT @@autocommit ) autocommit', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (1090, 7, '●', '集群当前的拓扑信息', 'select * from INFORMATION_SCHEMA.cluster_info  order by type,instance', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1091, 7, '●', '版本信息', 'select tidb_version()', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1092, 7, '', '', 'show variables like \'version_%\';', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1093, 7, '●', '状态面板', 'select * from mysql.tidb d;', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1094, 7, '●', '集群硬件信息', 'select * from INFORMATION_SCHEMA.CLUSTER_HARDWARE d', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1095, 7, '●', '查询集群不同实例的内核配置信息', 'select * from INFORMATION_SCHEMA.CLUSTER_SYSTEMINFO', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1096, 7, '●', '当前数据库实例的所有数据库及其容量大小', 'select a.SCHEMA_NAME, a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME,\nsum(table_rows) as table_rows,\ntruncate(sum(data_length)/1024/1024, 2) as data_size_mb,\ntruncate(sum(index_length)/1024/1024, 2) as index_size_mb,\ntruncate(sum(data_length+index_length)/1024/1024, 2) as all_size_mb,\ntruncate(sum(max_data_length)/1024/1024, 2) as max_size_mb,\ntruncate(sum(data_free)/1024/1024, 2) as free_size_mb,\nmax(f.filesize_M)  as disk_size_mb\nfrom INFORMATION_SCHEMA.SCHEMATA a\nleft outer join information_schema.tables b\non a.SCHEMA_NAME=b.TABLE_SCHEMA\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,\n			truncate(sum(total_extents*extent_size)/1024/1024,2) filesize_M\n			from  information_schema.FILES b \n			group by substring(b.file_name,3,locate(\'/\',b.file_name,3)-3)) f\non ( a.SCHEMA_NAME= f.db_name)\ngroup by a.SCHEMA_NAME,  a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME\norder by sum(data_length) desc, sum(index_length) desc;', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1097, 7, '●', '查询存储节点信息', 'select * from INFORMATION_SCHEMA.TIKV_STORE_STATUS', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1098, 7, '●', '数据库对象', 'select db as db_name ,type as ob_type,cnt as sums from \n(select \'TABLE\' type,table_schema db, count(*) cnt  from information_schema.`TABLES` a where table_type=\'BASE TABLE\' group by table_schema\nunion all\nselect \'EVENTS\' type,event_schema db,count(*) cnt from information_schema.`EVENTS` b group by event_schema\nunion all\nselect \'TRIGGERS\' type,trigger_schema db,count(*) cnt from information_schema.`TRIGGERS` c group by trigger_schema\nunion all\nselect \'PROCEDURE\' type,routine_schema db,count(*) cnt from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'PROCEDURE\' group by db\nunion all\nselect \'FUNCTION\' type,routine_schema db,count(*) cnt  from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'FUNCTION\' group by db\nunion all\nselect \'VIEWS\' type,TABLE_SCHEMA db,count(*) cnt  from information_schema.VIEWS f group by table_schema  ) t\norder by db,type', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1099, 7, '●', '查看数据库的运行状态', 'status;', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1100, 7, '●', '占用空间最大的前10张大表', 'SELECT\n	table_schema AS db_name,\n	table_name AS table_name,\n	a.TABLE_TYPE,\n	a.`ENGINE`,\n	a.CREATE_TIME,\n	a.UPDATE_TIME,\n	a.TABLE_COLLATION,\n	table_rows AS table_rows,\n	TRUNCATE(a.DATA_LENGTH / 1024 / 1024, 2 ) AS tb_size_mb,\n	TRUNCATE( index_length / 1024 / 1024, 2 ) AS index_size_mb,\n	TRUNCATE( ( data_length + index_length ) / 1024 / 1024, 2 ) AS all_size_mb,\n  TRUNCATE( a.DATA_FREE / 1024 / 1024, 2 ) AS free_size_mb,\n  truncate(f.filesize_M,2) AS disk_size_mb\nFROM information_schema.TABLES a\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,  \n			substring(b.file_name,locate(\'/\',b.file_name,3)+1,(LENGTH(b.file_name)-locate(\'/\',b.file_name,3)-4)) as tb_name,\n			b.file_name,\n			(total_extents*extent_size)/1024/1024 filesize_M\n			from  information_schema.FILES b \n			order by filesize_M desc limit 20 ) f\non ( a.TABLE_SCHEMA= f.db_name and a.TABLE_NAME=f.tb_name )\nwhere a.DATA_LENGTH&gt; 0\nORDER BY	( data_length + index_length ) DESC \nLIMIT 10) V;', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1101, 7, '●', '所有存储引擎列表', 'SELECT * from information_schema.`ENGINES`', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1102, 7, '●', '存储引擎和DB的数量关系', 'SELECT a.`ENGINE`,count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY a.`ENGINE`', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1103, 7, '', '', 'SELECT  a.TABLE_SCHEMA,\n	a.`ENGINE`,\n	count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY  a.TABLE_SCHEMA,a.`ENGINE` \nORDER BY a.TABLE_SCHEMA', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1104, 7, '●', '查询所有用户', 'select * from mysql.user', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1105, 7, '●', '查询TiDB支持的所有字符集', 'select * from information_schema.CHARACTER_SETS', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1106, 7, '●', '集群当前所有实例的重要配置', 'select * from INFORMATION_SCHEMA.CLUSTER_CONFIG d where length(d.value)&gt;0 and d.key in (\'advertise-address\',\'host\',\'log.file.filename\',\'log.enable-slow-log\',\'log.record-plan-in-slow-log\',\'log.slow-query-file\',\'log.slow-threshold\',\'lower-case-table-names\',\'path\',\'store\',\'advertise-client-urls\',\'advertise-peer-urls\',\'client-urls\',\'cluster-version\',\'data-dir\',\'initial-cluster\',\'lease\',\'pd-server.dashboard-address\',\'peer-urls\',\'log-file\',\'log-format\',\'log-level\',\'pd.endpoints\',\'raft-engine.dir\',\'raft-engine.enable\',\'oom-action\')', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1107, 7, '●', '按照登录用户+登录服务器查看登录信息', 'SELECT USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count \nFROM `information_schema`.`PROCESSLIST` P \n-- WHERE P.USER NOT IN ( \'root\', \'repl\', \'system user\' ) \nGROUP BY USER,LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 );', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1108, 7, '●', '按照登录用户+数据库+登录服务器查看登录信息', 'SELECT  DB AS database_name,\n	USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count \nFROM  `information_schema`.`PROCESSLIST` P \n-- WHERE P.USER NOT IN ( \'root\', \'repl\', \'system user\' ) \nGROUP BY DB,USER,LEFT(HOST, POSITION( \':\' IN HOST ) - 1 );', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1109, 7, '●', '查询所有线程（排除sleep线程）', 'select * from information_schema.`PROCESSLIST`  a where a.command\'Sleep\' and a.idCONNECTION_id();', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1110, 7, '●', '事务情况', 'select * from INFORMATION_SCHEMA.CLUSTER_TIDB_TRX', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1111, 7, '●', 'sleep线程TOP20', 'select * from information_schema.`PROCESSLIST`  a where a.command=\'Sleep\' order by time desc limit 20', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1112, 7, '●', '有多少线程正在使用表', 'select * from INFORMATION_SCHEMA.DEADLOCKS d', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1113, 7, '●', '慢查询的SQL时间段', 'select count(*) counts,\n       min(time) min_time,\n       max(time) max_time\nfrom INFORMATION_SCHEMA.slow_query', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1114, 7, '●', '查询集群各个 TIDB 节点的慢查询数量', 'select instance, count(*) counts from information_schema.cluster_slow_query  group by instance', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1115, 7, '●', '慢查询的SQL语句', 'select  * from INFORMATION_SCHEMA.CLUSTER_SLOW_QUERY d where  Query not like \'%%\'  AND is_internal = false order by d.Query_time desc  limit 20', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1116, 7, '●', '执行计划发生变化的慢查询', 'select count(distinct plan_digest) as count,\n       digest,\n      min(query)  query\nfrom INFORMATION_SCHEMA.cluster_slow_query\ngroup by digest\nhaving count &gt; 1\nlimit 3', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1117, 7, '●', '最近一段时间内SQL汇总', 'select * from INFORMATION_SCHEMA.CLUSTER_STATEMENTS_SUMMARY WHERE QUERY_SAMPLE_TEXT not like \'%%\'  limit 20', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1118, 7, '●', '历史SQL汇总', 'select * from INFORMATION_SCHEMA.CLUSTER_STATEMENTS_SUMMARY_HISTORY WHERE QUERY_SAMPLE_TEXT not like \'%%\' limit 20', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1119, 7, '●', '跟踪长时间操作的进度', 'select * from performance_schema.events_stages_current', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (1120, 7, '●', 'DDL语句的进度', 'admin show ddl;', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (1121, 7, '●', '查看当前 DDL 作业队列中的所有结果', '-- 查看当前 DDL 作业队列中的所有结果（包括正在运行以及等待运行的任务）以及已执行完成的 DDL 作业队列中的最近十条结果\nadmin show ddl jobs;', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (1122, 7, '●', '查询SQL的整体消耗百分比', 'select state,\n       sum(duration) as total_r,\n       round(100 * sum(duration) / (select sum(duration) from information_schema.profiling  where query_id = 1),2) as pct_r,\n       count(*) as calls,\n       sum(duration) / count(*) as \"r/call\"\n  from information_schema.profiling\n where query_id = 1\n group by state\n order by total_r desc', 0, 33);
INSERT INTO `tbl_chktemple_item` VALUES (1123, 7, '●', '查询集群不同实例以及不同硬件类型的负载信息', 'select * from INFORMATION_SCHEMA.CLUSTER_LOAD d ', 0, 34);
INSERT INTO `tbl_chktemple_item` VALUES (1124, 7, '●', '哪些表需要做 analyze', 'show stats_healthy where Healthy&lt;=60;', 0, 35);
INSERT INTO `tbl_chktemple_item` VALUES (1125, 7, '●', '备份进度', 'show backups;', 0, 36);
INSERT INTO `tbl_chktemple_item` VALUES (1126, 7, '●', '还原进度', 'show restores;', 0, 37);
INSERT INTO `tbl_chktemple_item` VALUES (1127, 7, '●', '自增ID的使用情况（前20条）', 'SELECT table_schema,table_name,engine, Auto_increment\n FROM information_schema.tables a\n where TABLE_SCHEMA not in (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\n and  a.Auto_increment\'\'\n order by a.AUTO_INCREMENT desc\nlimit 20 ', 0, 38);
INSERT INTO `tbl_chktemple_item` VALUES (1128, 7, '●', '无主键或唯一键的表（前100条）', 'select table_schema, table_name\n from information_schema.tables\nwhere table_type=\'BASE TABLE\'\n and  (table_schema, table_name) not in ( select /*+ subquery(materialization) */ a.TABLE_SCHEMA,a.TABLE_NAME \n           from information_schema.TABLE_CONSTRAINTS a \n		   where a.CONSTRAINT_TYPE in (\'PRIMARY KEY\',\'UNIQUE\')\n		   and table_schema not in    (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')	)\n AND table_schema not in  (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\nlimit 100 ', 0, 39);
INSERT INTO `tbl_chktemple_item` VALUES (1129, 7, '●', '查询同步到TiFlash的表', 'SELECT * FROM information_schema.tiflash_replica limit 50', 0, 40);
INSERT INTO `tbl_chktemple_item` VALUES (1130, 7, '●', '集群日志', 'select * from INFORMATION_SCHEMA.CLUSTER_LOG d where d.MESSAGE like \'%%\' limit 10', 0, 41);
INSERT INTO `tbl_chktemple_item` VALUES (1131, 7, '●', '总结', 'select * from INFORMATION_SCHEMA.CLIENT_ERRORS_SUMMARY_GLOBAL limit 100', 0, 42);
INSERT INTO `tbl_chktemple_item` VALUES (1132, 7, '●', '用户', 'select * from INFORMATION_SCHEMA.CLIENT_ERRORS_SUMMARY_BY_USER limit 100', 0, 43);
INSERT INTO `tbl_chktemple_item` VALUES (1133, 7, '●', '主机', 'select * from INFORMATION_SCHEMA.CLIENT_ERRORS_SUMMARY_BY_HOST limit 100', 0, 44);
INSERT INTO `tbl_chktemple_item` VALUES (1134, 7, '●', '诊断结果', 'select * from information_schema.inspection_result', 0, 45);
INSERT INTO `tbl_chktemple_item` VALUES (1135, 8, '●', '实例信息', 'select pg_postmaster_start_time() pg_start_time ,\ninet_server_addr() server_IP,\ninet_server_port() server_port,\ninet_client_addr() client_ip,\ninet_client_port() client_port,\nversion() server_version,\n(case when pg_is_in_recovery()=\'f\' then \'primary\' else \'standby\' end ) as  primary_or_standby,\nnow() now_date;', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (1136, 8, '●', '数据库基本信息', 'SELECT d.datname as \"Name\",\n       pg_catalog.pg_get_userbyid(d.datdba) as \"Owner\",\n       pg_catalog.pg_encoding_to_char(d.encoding) as \"Encoding\",\n       d.datcollate as \"Collate\",\n       d.datctype as \"Ctype\",\n       pg_catalog.array_to_string(d.datacl, E\'\\n\') AS \"Access privileges\",\n       CASE WHEN pg_catalog.has_database_privilege(d.datname, \'CONNECT\')\n            THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))\n            ELSE \'No Access\'\n       END as \"Size\",\n       t.spcname as \"Tablespace\",\n       pg_catalog.shobj_description(d.oid, \'pg_database\') as \"Description\"\nFROM pg_catalog.pg_database d\n  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid\nORDER BY 1;', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1137, 8, '●', '所有表空间', 'SELECT oid,spcname AS \"Name\",\n  pg_catalog.pg_get_userbyid(spcowner) AS \"Owner\",\n  pg_catalog.pg_tablespace_location(oid) AS \"Location\",\n  pg_catalog.array_to_string(spcacl, E\'\\n\') AS \"Access privileges\",\n  spcoptions AS \"Options\",\n  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS \"Size\",\n  pg_catalog.shobj_description(oid, \'pg_tablespace\') AS \"Description\"\nFROM pg_catalog.pg_tablespace\nORDER BY 1;', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1138, 8, '●', '当前客户端连接信息', 'select current_user,current_database(),pg_backend_pid();', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1139, 8, '●', '前几张大表（当前库）', 'SELECT\n	t.table_catalog as db,\n	n.nspname AS schemaname,\n	c.relname,\n	c.reltuples::numeric as rowcount,\n	pg_size_pretty(pg_table_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS table_size,\n    pg_size_pretty(pg_indexes_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS indexes_size,\n	pg_size_pretty (pg_total_relation_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS total_size --,pg_relation_filepath(table_name) filepath\nFROM pg_class C \n	LEFT JOIN pg_namespace N ON ( N.oid = C.relnamespace ) \n	left join information_schema.tables t on (n.nspname= t.table_schema and c.relname=t.\"table_name\" )\nWHERE\n	nspname NOT IN ( \'pg_catalog\', \'information_schema\' ) \n	AND relkind in (\'r\',\'p\')  \nORDER BY\n	reltuples DESC \n	LIMIT 20;', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1140, 8, '●', '当前库的所有数据库对象', 'select \n    nsp.nspname as SchemaName\n    ,case cls.relkind\n        when \'r\' then \'TABLE\'\n        when \'m\' then \'MATERIALIZED_VIEW\'\n        when \'i\' then \'INDEX\'\n        when \'S\' then \'SEQUENCE\'\n        when \'v\' then \'VIEW\'\n        when \'c\' then \'composite type\'\n        when \'t\' then \'TOAST\'\n        when \'f\' then \'foreign table\'\n        when \'p\' then \'partitioned_table\'\n        when \'I\' then \'partitioned_index\'\n        else cls.relkind::text\n    end as ObjectType,\n    COUNT(*) cnt\nfrom pg_class cls\njoin pg_namespace nsp \n on nsp.oid = cls.relnamespace\nwhere nsp.nspname not in (\'information_schema\', \'pg_catalog\')\n  and nsp.nspname not like \'pg_toast%\'\nGROUP BY nsp.nspname,cls.relkind\nUNION all\nSELECT n.nspname as \"Schema\",\n CASE p.prokind\n  WHEN \'a\' THEN \'agg\'\n  WHEN \'w\' THEN \'window\'\n  WHEN \'p\' THEN \'proc\'\n  ELSE \'func\'\n END as \"Type\",\n COUNT(*) cnt\nFROM pg_catalog.pg_proc p\nLEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace\nWHERE pg_catalog.pg_function_is_visible(p.oid)\nAND n.nspname not in (\'information_schema\', \'pg_catalog\')\nGROUP BY n.nspname ,p.prokind;', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1141, 8, '●', '当前操作系统运行的状态信息', 'select * from gs_os_run_info;', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1142, 8, '●', '节点的进程信息', 'select * from pg_os_threads;', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1143, 8, '●', '所有进程总计', 'SELECT\n	max_conn 最大连接数,\n	now_conn 当前连接数,\n	max_conn - now_conn 剩余连接数 \nFROM\n	( SELECT setting::int8  AS max_conn, ( SELECT COUNT ( * ) FROM pg_stat_activity ) AS now_conn FROM pg_settings WHERE NAME = \'max_connections\' ) T;', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1144, 8, '●', '所有进程详情', 'select a.*   from pg_stat_activity   a ;', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1145, 8, '●', '锁', 'SELECT * FROM pg_locks;', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1146, 8, '●', '查询等待锁的线程状态信息', 'SELECT * FROM pg_thread_wait_status WHERE wait_status = \'acquire lock\';', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1147, 8, '●', '查询当前使用内存最多的会话信息', 'SELECT * FROM pv_session_memory_detail() ORDER BY usedsize desc limit 10;', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1148, 8, '●', 'state_change字段长时间没有更新过的连接信息', 'SELECT * FROM pg_stat_activity where state=\'idle\' order by state_change;', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1149, 8, '●', '慢SQL查询', 'select * from DBE_PERF.get_global_full_sql_by_timestamp(now()-7,now());', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1150, 8, '●', '主从流复制情况', 'select * from pg_stat_replication;', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1151, 8, '●', '主从流复制冲突统计', 'select * from pg_stat_database_conflicts;', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1152, 8, '●', '查看复制槽', 'select * from pg_replication_slots;', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1153, 8, '●', '重要参数', 'SELECT *\nFROM   pg_settings a\nWHERE  a.name IN (\'data_directory\',\n                  \'port\',\n                  \'client_encoding\',\n                  \'config_file\',\n                  \'hba_file\',\n                  \'ident_file\',\n                  \'archive_mode\',\n                  \'logging_collector\',\n                  \'log_directory\',\n                  \'log_filename\',\n                  \'log_truncate_on_rotation\',\n                  \'log_statement\',\n                  \'log_min_duration_statement\',\n                  \'max_connections\',\'listen_addresses\',\'connection_info\')\nORDER  BY NAME;', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1154, 8, '●', '数据库内存', 'select * from gs_total_memory_detail;', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1155, 8, '●', '后台写进程统计信息', 'select * from pg_stat_bgwriter;', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1156, 8, '●', 'SQL统计信息', 'select * from GS_SQL_COUNT;', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1157, 8, '●', '时间消耗信息统计', 'select * from GS_INSTANCE_TIME;', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1158, 8, '●', '数据文件IO信息统计（物理读最多的10个文件）', 'select  * from gs_file_stat order by phyrds desc  limit 10;', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1159, 8, '●', '当前库的所有schema', 'select * from information_schema.schemata;', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1160, 8, '●', '当前库的所有角色(用户)', 'select * from pg_roles;', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1161, 8, '', '', 'select * from pg_user;', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1162, 8, '●', '所有语言', 'select * from pg_language;', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1163, 8, '●', '所有插件（已编译）', 'select * from pg_available_extensions ;', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1164, 8, '●', '已安装的插件', 'SELECT e.extname AS \"Name\", e.extversion AS \"Version\", n.nspname AS \"Schema\", c.description AS \"Description\"\nFROM pg_catalog.pg_extension e LEFT JOIN pg_catalog.pg_namespace n ON n.oid = e.extnamespace LEFT JOIN pg_catalog.pg_description c ON c.objoid = e.oid AND c.classoid = \'pg_catalog.pg_extension\'::pg_catalog.regclass\nORDER BY 1;', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1165, 9, '●', '实例信息', 'select sys_postmaster_start_time() sys_start_time ,\ninet_server_addr() server_IP,\ninet_server_port() server_port,\ninet_client_addr() client_ip,\ninet_client_port() client_port,\nversion() server_version,\n(case when sys_is_in_recovery()=\'f\' then \'primary\' else \'standby\' end ) as  primary_or_standby,\nnow() now_date,\nget_license_validdays() 可用天数;', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1166, 9, '●', '数据库基本信息', 'SELECT d.datname as \"Name\",\n       sys_get_userbyid(d.datdba) as \"Owner\",\n       sys_encoding_to_char(d.encoding) as \"Encoding\",\n       d.datcollate as \"Collate\",\n       d.datctype as \"Ctype\",\n       array_to_string(d.datacl, E\'\\n\') AS \"Access privileges\",\n       CASE WHEN has_database_privilege(d.datname, \'CONNECT\')\n            THEN sys_size_pretty(sys_database_size(d.datname))\n            ELSE \'No Access\'\n       END as \"Size\",\n       t.spcname as \"Tablespace\",\n       shobj_description(d.oid, \'sys_database\') as \"Description\",\n       age(datfrozenxid)          \"年龄\",\n       2 ^ 31 - age(datfrozenxid) \"剩余年龄\"\nFROM sys_database d\n  JOIN sys_tablespace t on d.dattablespace = t.oid\nORDER BY 1;', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1167, 9, '●', '所有表空间', 'SELECT oid,spcname AS \"Name\",\n  sys_get_userbyid(spcowner) AS \"Owner\",\n  sys_tablespace_location(oid) AS \"Location\",\n  array_to_string(spcacl, E\'\\n\') AS \"Access privileges\",\n  spcoptions AS \"Options\",\n  sys_size_pretty(sys_tablespace_size(oid)) AS \"Size\",\n  shobj_description(oid, \'sys_tablespace\') AS \"Description\"\nFROM sys_tablespace\nORDER BY 1;', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1168, 9, '●', '当前客户端连接信息', 'select current_user,current_database(),sys_backend_pid();', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1169, 9, '●', '前几张大表', 'SELECT\n	t.table_catalog as db,\n	n.nspname AS schemaname,\n	c.relname,\n	c.reltuples::numeric as rowcount,\n	sys_size_pretty(sys_table_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS table_size,\n    sys_size_pretty(sys_indexes_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS indexes_size,\n	sys_size_pretty (sys_total_relation_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS total_size --,sys_relation_filepath(table_name) filepath\nFROM sys_class C \n	LEFT JOIN sys_namespace N ON ( N.oid = C.relnamespace ) \n	left join information_schema.tables t on (n.nspname= t.table_schema and c.relname=t.\"table_name\" )\nWHERE\n	nspname NOT IN ( \'pg_catalog\', \'information_schema\' ) \n	AND relkind in (\'r\',\'p\')  \nORDER BY\n	reltuples DESC \n	LIMIT 20;', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1170, 9, '●', 'TOP 10 对象使用情况', 'select current_database()::char(15)                        \"数据库\",\n       a.schemaname || \'.\' || a.relname             \"表\",\n       sys_size_pretty(sys_relation_size(a.relid)) \"大小\",\n       a.seq_scan                                \"全表扫描\",\n       a.idx_scan                                \"索引扫描\",\n       a.n_tup_ins + a.n_tup_upd + a.n_tup_del   \"DML行数\",\n       a.n_live_tup                              \"有效行数\",\n       a.n_dead_tup                              \"废弃行数\"\nfrom sys_stat_user_tables a\nwhere lower(a.schemaname)  ~ \'^sys_|sys_\'\norder by sys_relation_size(a.relid) desc\nlimit 10;', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1171, 9, '●', '用户对象占用空间的柱状图', 'select current_database()::char(15) \"数据库\",\n       buk                          \"编号\",\n       cnt                          \"对象数量\",\n       sys_size_pretty(min)         \"对象最小值\",\n       sys_size_pretty(max)         \"对象最大值\"\nfrom (select row_number() over (partition by buk order by tsize),\n             tsize,\n             buk,\n             min(tsize) over (partition by buk),\n             max(tsize) over (partition by buk),\n             count(*) over (partition by buk) cnt\n      from (select sys_relation_size(a.oid) tsize,\n                   width_bucket(sys_relation_size(a.oid), tmin, tmax, 10) buk\n            from (select min(sys_relation_size(a.oid)) tmin, max(sys_relation_size(a.oid)) tmax\n                  from sys_class a,\n                       sys_namespace c\n                  where a.relnamespace = c.oid\n                    and (lower(nspname) !~ \'^sys_|sys_\' or lower(nspname)  \'information_schema\')) t,\n                 sys_class a,\n                 sys_namespace c\n            where a.relnamespace = c.oid\n              and lower(nspname) !~ \'^sys_|sys_\'\n              and lower(nspname)  \'information_schema\') t) t\nwhere row_number = 1;', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1172, 9, '●', '当前库的所有数据库对象', 'select \n    nsp.nspname as SchemaName\n    ,case cls.relkind\n        when \'r\' then \'TABLE\'\n        when \'m\' then \'MATERIALIZED_VIEW\'\n        when \'i\' then \'INDEX\'\n        when \'S\' then \'SEQUENCE\'\n        when \'v\' then \'VIEW\'\n        when \'c\' then \'composite type\'\n        when \'t\' then \'TOAST\'\n        when \'f\' then \'foreign table\'\n        when \'p\' then \'partitioned_table\'\n        when \'I\' then \'partitioned_index\'\n        else cls.relkind::text\n    end as ObjectType,\n    COUNT(*) cnt\nfrom sys_class cls\njoin sys_namespace nsp \n on nsp.oid = cls.relnamespace\nwhere nsp.nspname not in (\'information_schema\', \'pg_catalog\')\n  and nsp.nspname not like \'sys_toast%\'\nGROUP BY nsp.nspname,cls.relkind\nUNION all\nSELECT n.nspname as \"Schema\",\n CASE p.prokind\n  WHEN \'a\' THEN \'agg\'\n  WHEN \'w\' THEN \'window\'\n  WHEN \'p\' THEN \'proc\'\n  ELSE \'func\'\n END as \"Type\",\n COUNT(*) cnt\nFROM sys_proc p\nLEFT JOIN sys_namespace n ON n.oid = p.pronamespace\nWHERE sys_function_is_visible(p.oid)\nAND n.nspname not in (\'information_schema\', \'pg_catalog\')\nGROUP BY n.nspname ,p.prokind;', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1173, 9, '●', '索引数超过4并且SIZE大于100MB的表', 'select current_database()::char(15)                         \"数据库\",\n       t2.nspname || \'.\' || t1.relname            \"表名\",\n       sys_size_pretty(sys_relation_size(t1.oid)) \"尺寸\",\n       t3.idx_cnt                                 \"索引数\"\nfrom sys_class  t1,\n     sys_namespace t2,\n     (select indrelid, count(*) idx_cnt\n      from sys_index \n      group by 1\n      having count(*) &gt; 4) t3\nwhere t1.oid = t3.indrelid\n  and t1.relnamespace = t2.oid\n  and sys_relation_size(t1.oid) / 1024 / 1024 &gt; 100\norder by t3.idx_cnt desc;', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1174, 9, '●', '上次巡检以来未使用或使用较少的索引', 'select current_database()::char(15)                             \"数据库\",\n       t2.schemaname || \'.\' || t2.relname             \"表\",\n       t2.indexrelname                                \"索引\",\n       t2.idx_scan                                    \"扫描次数\",\n       t2.idx_tup_read                                \"索引行\",\n       t2.idx_tup_fetch                               \"数据行\",\n       sys_size_pretty(sys_relation_size(indexrelid)) \"尺寸\"\nfrom sys_stat_user_tables t1,\n     sys_stat_user_indexes t2\nwhere t1.relid = t2.relid\n  and lower(t2.schemaname) !~ \'^sys_|sys_\'\n  and t2.idx_scan  65536\norder by sys_relation_size(indexrelid) desc;', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1175, 9, '●', '所有进程总计', 'SELECT\n	max_conn 最大连接数,\n	now_conn 当前连接数,\n	max_conn - now_conn 剩余连接数 \nFROM\n	( SELECT setting::int8  AS max_conn, ( SELECT COUNT ( * ) FROM sys_stat_activity ) AS now_conn FROM sys_settings WHERE NAME = \'max_connections\' ) T;', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1176, 9, '●', '详情', 'select a.*   from sys_stat_activity   a ;', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1177, 9, '●', '锁', 'SELECT * FROM sys_locks;', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1178, 9, '●', 'state_change字段长时间没有更新过的连接信息', 'SELECT * FROM sys_stat_activity where state=\'idle\' order by state_change;', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1179, 9, '●', '数据库连接数统计', 'select max_conn                               \"限制数\",\n       actv                                   \"活动数\",\n       idle                                   \"空闲数\",\n       res_for_super                          \"保留数\",\n       max_conn - actv - idle - res_for_super \"可用数\"\nfrom (select sum(case when state=\'active\' then 1 else 0 end)                    actv,\n             sum(case when state=\'active\' then 0 else 1 end)                     idle,\n			 CURRENT_SETTING(\'superuser_reserved_connections\')::int res_for_super,\n             CURRENT_SETTING(\'max_connections\') ::int               max_conn\n      from sys_stat_activity) t;', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1180, 9, '●', '总剩余连接数', 'select max_conn                        \"最大连接数\",\n       used                            \"当前连接数\",\n       res_for_super                   \"保留连接数\",\n       max_conn - used - res_for_super \"可用连接数\"\nfrom (select count(*)                                               used,\n             CURRENT_SETTING(\'superuser_reserved_connections\')::int res_for_super,\n             CURRENT_SETTING(\'max_connections\') ::int               max_conn\n      from sys_stat_activity) t1; ', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1181, 9, '●', 'TOP 5 SQL : 语句合计执行时间', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (total_time / 1000) ::decimal(10, 2)       \"总时长\",\n       (100 * total_time /SUM(total_time) OVER ())::decimal(10, 2)  \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and total_time &gt; 0\norder by total_time  desc\nlimit 5;', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1182, 9, '●', 'TOP 5 SQL : 语句单次执行时间', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (total_time / calls / 1000) ::decimal(10, 2) \"单次时长\",\n       (100 * total_time / SUM(total_time) OVER ()) ::decimal(10, 2) \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and total_time &gt; 0\norder by total_time / calls desc\nlimit 5;', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1183, 9, '●', 'TOP 5 SQL : 语句合计使用缓存量', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (shared_blks_hit ) ::decimal(10, 2)        \"总块数\",\n       (100 * shared_blks_hit /\n        SUM(shared_blks_hit) OVER ()) ::decimal(10, 2) \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and shared_blks_hit &gt; 0\norder by shared_blks_hit desc\nlimit 5;', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1184, 9, '●', 'TOP 5 SQL : 语句单次使用缓存量', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (shared_blks_hit / calls ) ::decimal(10, 2) \"单次块数\",\n       (100 * shared_blks_hit /\n        SUM(shared_blks_hit) OVER ()) ::decimal(10, 2) \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and shared_blks_hit &gt; 0\norder by shared_blks_hit / calls desc\nlimit 5;', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1185, 9, '●', 'TOP 5 SQL : 语句合计使用磁盘量', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (local_blks_hit ) ::decimal(10, 2)        \"总块数\",\n       (100 * local_blks_hit /\n        SUM(local_blks_hit) OVER ()) ::decimal(10, 2) \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and local_blks_hit &gt; 0\norder by local_blks_hit desc\nlimit 5;', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1186, 9, '●', 'TOP 5 SQL : 语句单次使用磁盘量', 'select b.datname                                  \"数据库\",\n       c.usename                                  \"用户\",\n       queryid                                    \"语句ID\",\n       calls                                      \"次数\",\n       (local_blks_hit / calls ) ::decimal(10, 2) \"单次块数\",\n       (100 * local_blks_hit /\n        SUM(local_blks_hit) OVER ()) ::decimal(10, 2) \"占比%\",\n       query::char(25) || \'...\'                   \"语句\"\nfrom (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) a\n   , sys_database b\n   , sys_user c\nwhere a.dbid = b.oid\n  and a.userid = c.usesysid\n  and a.calls &gt; 0 and local_blks_hit &gt; 0\norder by local_blks_hit / calls desc\nlimit 5;', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1187, 9, '●', 'TOP 5 SQL : 语句完整文本', 'with a as (select a.*, (a.total_parse_time + a.total_plan_time + a.total_exec_time) total_time from sys_stat_statements a) ,\n    cpu as (\n    select b.datname \"数据库\",\n           c.usename \"用户\",\n           queryid   \"语句ID\",\n           query     \"语句\"\n    from  a\n       , sys_database b\n       , sys_user c\n    where a.dbid = b.oid\n      and a.userid = c.usesysid\n      and a.calls &gt; 0\n      and total_time &gt; 0\n    order by total_time desc\n    limit 5),\n     per_cpu as (\n         select b.datname \"数据库\",\n                c.usename \"用户\",\n                queryid   \"语句ID\",\n                query     \"语句\"\n         from  a\n            , sys_database b\n            , sys_user c\n         where a.dbid = b.oid\n           and a.userid = c.usesysid\n           and a.calls &gt; 0\n           and total_time &gt; 0\n         order by total_time / calls desc\n         limit 5),\n     shr as (\n         select b.datname \"数据库\",\n                c.usename \"用户\",\n                queryid   \"语句ID\",\n                query     \"语句\"\n         from  a\n            , sys_database b\n            , sys_user c\n         where a.dbid = b.oid\n           and a.userid = c.usesysid\n           and a.calls &gt; 0\n           and shared_blks_hit &gt; 0\n         order by shared_blks_hit desc\n         limit 5),\n     per_shr as (\n         select b.datname \"数据库\",\n                c.usename \"用户\",\n                queryid   \"语句ID\",\n                query     \"语句\"\n         from  a\n            , sys_database b\n            , sys_user c\n         where a.dbid = b.oid\n           and a.userid = c.usesysid\n           and a.calls &gt; 0\n           and shared_blks_hit &gt; 0\n         order by shared_blks_hit / calls desc\n         limit 5),\n     lcl as (\n    select b.datname \"数据库\",\n           c.usename \"用户\",\n           queryid   \"语句ID\",\n           query     \"语句\"\n    from  a\n       , sys_database b\n       , sys_user c\n    where a.dbid = b.oid\n      and a.userid = c.usesysid\n      and a.calls &gt; 0\n      and local_blks_hit &gt; 0\n    order by local_blks_hit  desc\n    limit 5),\n      per_lcl as (\n    select b.datname \"数据库\",\n           c.usename \"用户\",\n           queryid   \"语句ID\",\n           query     \"语句\"\n    from  a\n       , sys_database b\n       , sys_user c\n    where a.dbid = b.oid\n      and a.userid = c.usesysid\n      and a.calls &gt; 0\n      and local_blks_hit &gt; 0\n    order by local_blks_hit /calls desc\n    limit 5)\n  select * \n	from( select * from cpu\n     union\n     select * from per_cpu\n     union\n     select * from shr\n     union\n     select * from per_shr\n     union\n     select * from lcl\n     union\n     select * from per_lcl\n     union\n     select * from cpu ) t\n   order by 1,2,3;', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1188, 9, '●', '主库查看wal日志发送状态', 'select * from sys_stat_replication;', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1189, 9, '●', '从库查看wal日志接收状态', 'select * from sys_stat_wal_receiver;', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1190, 9, '●', '主从库延迟数据（单位MB）', 'select sys_wal_lsn_diff(A .c1, replay_lsn) /(1024 * 1024) AS slave_latency_MB\nfrom sys_stat_replication,\n     sys_current_wal_lsn() AS A(c1)\nORDER BY slave_latency_MB LIMIT 1;', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1191, 9, '●', '主从流复制冲突统计', 'select * from sys_stat_database_conflicts;', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1192, 9, '●', '逻辑复制查看发布', 'select * from sys_publication;', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1193, 9, '●', '查看发布的表', 'select * from sys_publication_tables;', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1194, 9, '●', '查看所有的订阅者', 'select * from sys_stat_replication;', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (1195, 9, '●', '复制进度', 'select * from sys_stat_subscription;', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (1196, 9, '●', '查看订阅', 'select * from sys_subscription;', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (1197, 9, '●', '查看订阅的表', 'select *,srrelid::regclass from sys_subscription_rel;', 0, 33);
INSERT INTO `tbl_chktemple_item` VALUES (1198, 9, '●', '查看复制槽', 'select * from sys_replication_slots;', 0, 34);
INSERT INTO `tbl_chktemple_item` VALUES (1199, 9, '●', '参数文件记录的参数', 'select * from sys_file_settings;', 0, 35);
INSERT INTO `tbl_chktemple_item` VALUES (1200, 9, '●', '重要参数', 'SELECT *\nFROM   sys_settings a\nWHERE  a.name IN (\'data_directory\',\n                  \'port\',\n                  \'client_encoding\',\n                  \'config_file\',\n                  \'hba_file\',\n                  \'ident_file\',\n                  \'archive_mode\',\n                  \'logging_collector\',\n                  \'log_directory\',\n                  \'log_filename\',\n                  \'log_truncate_on_rotation\',\n                  \'log_statement\',\n                  \'log_min_duration_statement\',\n                  \'max_connections\',\n                  \'listen_addresses\',\n                  \'case_sensitive\',\'database_mode\',\'autovacuum\',\n                  \'server_encoding\',\'client_encoding\')\nORDER  BY NAME;', 0, 36);
INSERT INTO `tbl_chktemple_item` VALUES (1201, 9, '●', 'sys_hba.conf配置文件信息', 'select * from sys_hba_file_rules;', 0, 37);
INSERT INTO `tbl_chktemple_item` VALUES (1202, 9, '●', '后台写进程统计信息', 'select * from sys_stat_bgwriter;', 0, 38);
INSERT INTO `tbl_chktemple_item` VALUES (1203, 9, '●', 'WAL日志切换频率（需要手动修改路径）', 'with tmp_file as (\n  select t1.file,\n      t1.file_ls,\n      (sys_stat_file(t1.file)).size as size,\n      (sys_stat_file(t1.file)).access as access,\n      (sys_stat_file(t1.file)).modification as last_update_time,\n      (sys_stat_file(t1.file)).change as change,\n      (sys_stat_file(t1.file)).creation as creation,\n      (sys_stat_file(t1.file)).isdir as isdir\n   from (select dir||\'/\'||sys_ls_dir(t0.dir) as file,\n          sys_ls_dir(t0.dir) as file_ls\n       from ( select \'/opt/Kingbase/ES/V8/data/sys_wal\'::text as dir  -- 需要修改这个物理路径\n          ) t0\n      ) t1 \n   where 1=1\n   order by (sys_stat_file(file)).modification desc\n) \nselect to_char(date_trunc(\'day\',tf0.last_update_time),\'yyyymmdd\') as day_id,\n    sum(case when date_part(\'hour\',tf0.last_update_time) &gt;=0 and date_part(\'hour\',tf0.last_update_time) =0 and date_part(\'hour\',tf0.last_update_time) =1 and date_part(\'hour\',tf0.last_update_time) =2 and date_part(\'hour\',tf0.last_update_time) =3 and date_part(\'hour\',tf0.last_update_time) =4 and date_part(\'hour\',tf0.last_update_time) =5 and date_part(\'hour\',tf0.last_update_time) =6 and date_part(\'hour\',tf0.last_update_time) =7 and date_part(\'hour\',tf0.last_update_time) =8 and date_part(\'hour\',tf0.last_update_time) =9 and date_part(\'hour\',tf0.last_update_time) =10 and date_part(\'hour\',tf0.last_update_time) =11 and date_part(\'hour\',tf0.last_update_time) =12 and date_part(\'hour\',tf0.last_update_time) =13 and date_part(\'hour\',tf0.last_update_time) =14 and date_part(\'hour\',tf0.last_update_time) =15 and date_part(\'hour\',tf0.last_update_time) =16 and date_part(\'hour\',tf0.last_update_time) =17 and date_part(\'hour\',tf0.last_update_time) =18 and date_part(\'hour\',tf0.last_update_time) =19 and date_part(\'hour\',tf0.last_update_time) =20 and date_part(\'hour\',tf0.last_update_time) =21 and date_part(\'hour\',tf0.last_update_time) =22 and date_part(\'hour\',tf0.last_update_time) =23 and date_part(\'hour\',tf0.last_update_time) = 1000\nORDER BY dead_tup_ratio DESC\nLIMIT 10;', 0, 41);
INSERT INTO `tbl_chktemple_item` VALUES (1204, 9, '●', '数据库统计信息, 回滚比例, 命中比例, 数据块读写时间, 死锁, 复制冲突', 'select datname                                     \"数据库\",\n       round(100 * xact_rollback::numeric /\n             (xact_commit + xact_rollback + 1), 2) \"回滚率%\",\n       round(100 * blks_hit::numeric /\n             (blks_read + blks_hit + 1), 2)        \"命中率%\",\n       round(blk_read_time / 1000)                 \"读磁盘用时秒\",\n       round(blk_write_time / 10000)               \"写磁盘用时秒\",\n       conflicts                                   \"复制冲突\",\n       deadlocks                                   \"死锁\"\nfrom sys_stat_database\nwhere lower(datname) !~ \'template\';', 0, 42);
INSERT INTO `tbl_chktemple_item` VALUES (1205, 9, '●', '检查点, bgwriter 统计信息', 'select CHECKPOINTS_TIMED                   \"定时执行次数\",\n       CHECKPOINTS_REQ                     \"被动执行次数\",\n       round(CHECKPOINT_WRITE_TIME / 1000) \"缓存写磁盘秒\",\n       round(CHECKPOINT_SYNC_TIME / 1000)  \"脏数据同步秒\",\n       BUFFERS_CHECKPOINT                  \"检查点写入脏块\",\n       BUFFERS_CLEAN                       \"后台写入块数\",\n       MAXWRITTEN_CLEAN                    \"后台超时次数\",\n       BUFFERS_BACKEND                     \"检查点写入块数\",\n       BUFFERS_BACKEND_FSYNC               \"后台同步次数\",\n       BUFFERS_ALLOC                       \"缓存分配数量\",\n       STATS_RESET                         \"信息重置时点\"\nfrom sys_stat_bgwriter;', 0, 43);
INSERT INTO `tbl_chktemple_item` VALUES (1206, 9, '●', '表年龄', 'select current_database()::char(15)                  \"数据库\",\n       rolname                             \"用户\",\n       nspname || \'.\' || relname           \"表\",\n       (case when relkind=\'r\' then \'表\' else \'TOAST表\' end) \"类型\",\n       age(relfrozenxid)                   \"年龄\",\n       2 ^ 31 - age(relfrozenxid)          \"剩余年龄\"\nfrom sys_authid t1\n         join sys_class  t2 on t1.oid = t2.relowner\n         join sys_namespace t3 on t2.relnamespace = t3.oid\nwhere t2.relkind in (\'t\', \'r\')\norder by age(relfrozenxid) desc\nlimit 5;', 0, 44);
INSERT INTO `tbl_chktemple_item` VALUES (1207, 9, '●', '长事务, 2PC: 活动进程', 'select datname             \"数据库\",\n       usename             \"用户\",\n       query               \"SQL语句\",\n       xact_start          \"事务开始\",\n       now() - xact_start  \"事务持续\",\n       query_start         \"查询开始\",\n       now() - query_start \"查询持续\",\n       state               \"状态\"\nfrom sys_stat_activity\nwhere state  \'idle\'\n  and (backend_xid is not null or backend_xmin is not null)\n  and now() - xact_start &gt; interval \' 30 min \'\norder by xact_start;', 0, 45);
INSERT INTO `tbl_chktemple_item` VALUES (1208, 9, '●', '长事务, 2PC: 预备语句', 'select name                 \"SQL标识\",\n       statement            \"语句文本\",\n       prepare_time         \"创建时间\",\n       now() - prepare_time \"持续时间\",\n       parameter_types      \"参数类型\",\n       from_sql             \"SQL创建\"\nfrom sys_prepared_statements\nwhere now() - prepare_time &gt; interval \' 30 min \'\norder by prepare_time;', 0, 46);
INSERT INTO `tbl_chktemple_item` VALUES (1209, 9, '●', '当前库的所有schema', 'select * from information_schema.schemata;', 0, 47);
INSERT INTO `tbl_chktemple_item` VALUES (1210, 9, '●', '当前库的所有角色(用户)', 'select * from sys_roles;\nselect * from sys_user;', 0, 48);
INSERT INTO `tbl_chktemple_item` VALUES (1211, 9, '●', '所有语言', 'select * from sys_language;', 0, 49);
INSERT INTO `tbl_chktemple_item` VALUES (1212, 9, '●', '所有插件（已编译）', 'select * from sys_available_extensions ;', 0, 50);
INSERT INTO `tbl_chktemple_item` VALUES (1213, 9, '●', '已安装的插件', 'SELECT e.extname AS \"Name\", e.extversion AS \"Version\", n.nspname AS \"Schema\", c.description AS \"Description\"\nFROM sys_extension e LEFT JOIN sys_namespace n ON n.oid = e.extnamespace LEFT JOIN sys_description c ON c.objoid = e.oid AND c.classoid = \'sys_extension\'::regclass\nORDER BY 1;', 0, 51);
INSERT INTO `tbl_chktemple_item` VALUES (1214, 9, '●', '获取已安装的KingBase的信息', 'SELECT * FROM sys_config ;', 0, 52);
INSERT INTO `tbl_chktemple_item` VALUES (1215, 9, '●', '所有job', 'select * from kdb_job;', 0, 53);
INSERT INTO `tbl_chktemple_item` VALUES (1216, 6, '●', '实例信息', 'select pg_postmaster_start_time() pg_start_time ,\ninet_server_addr() server_IP,\ninet_server_port() server_port,\ninet_client_addr() client_ip,\ninet_client_port() client_port,\nversion() server_version,\n(case when pg_is_in_recovery()=\'f\' then \'primary\' else \'standby\' end ) as  primary_or_standby,\nnow() now_date;', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1217, 6, '●', '数据库基本信息', 'SELECT d.datname as \"Name\",\n       pg_catalog.pg_get_userbyid(d.datdba) as \"Owner\",\n       pg_catalog.pg_encoding_to_char(d.encoding) as \"Encoding\",\n       d.datcollate as \"Collate\",\n       d.datctype as \"Ctype\",\n       pg_catalog.array_to_string(d.datacl, E\'\\n\') AS \"Access privileges\",\n       CASE WHEN pg_catalog.has_database_privilege(d.datname, \'CONNECT\')\n            THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))\n            ELSE \'No Access\'\n       END as \"Size\",\n       t.spcname as \"Tablespace\",\n       pg_catalog.shobj_description(d.oid, \'pg_database\') as \"Description\"\nFROM pg_catalog.pg_database d\n  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid\nORDER BY 1;', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1218, 6, '●', '查看各数据库数据创建时间', 'SELECT\n	datname,\n	(\n	pg_stat_file (\n	format ( \'%s/%s/PG_VERSION\', CASE WHEN spcname = \'pg_default\' THEN \'base\' ELSE\'pg_tblspc/\' || t2.oid || \'/PG_11_201804061/\' END, t1.oid ))).* \nFROM\n	pg_database t1,\n	pg_tablespace t2 \nWHERE\n	t1.dattablespace = t2.oid;', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1219, 6, '●', '所有表空间', 'SELECT oid,spcname AS \"Name\",\n  pg_catalog.pg_get_userbyid(spcowner) AS \"Owner\",\n  pg_catalog.pg_tablespace_location(oid) AS \"Location\",\n  pg_catalog.array_to_string(spcacl, E\'\\n\') AS \"Access privileges\",\n  spcoptions AS \"Options\",\n  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS \"Size\",\n  pg_catalog.shobj_description(oid, \'pg_tablespace\') AS \"Description\"\nFROM pg_catalog.pg_tablespace\nORDER BY 1;', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1220, 6, '●', '当前客户端连接信息', 'select current_user,current_database(),pg_backend_pid();', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1221, 6, '●', '前几张大表', 'SELECT\n	t.table_catalog as db,\n	n.nspname AS schemaname,\n	c.relname,\n	c.reltuples::numeric as rowcount,\n	pg_size_pretty(pg_table_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS table_size,\n    pg_size_pretty(pg_indexes_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS indexes_size,\n	pg_size_pretty (pg_total_relation_size ( \'\"\' || nspname || \'\".\"\' || relname || \'\"\' )) AS total_size --,pg_relation_filepath(table_name) filepath\nFROM pg_class C \n	LEFT JOIN pg_namespace N ON ( N.oid = C.relnamespace ) \n	left join information_schema.tables t on (n.nspname= t.table_schema and c.relname=t.\"table_name\" )\nWHERE\n	nspname NOT IN ( \'pg_catalog\', \'information_schema\' ) \n	AND relkind in (\'r\',\'p\')  \nORDER BY\n	reltuples DESC \n	LIMIT 20;', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1222, 6, '●', '当前库的所有数据库对象', 'select \n    nsp.nspname as SchemaName\n    ,case cls.relkind\n        when \'r\' then \'TABLE\'\n        when \'m\' then \'MATERIALIZED_VIEW\'\n        when \'i\' then \'INDEX\'\n        when \'S\' then \'SEQUENCE\'\n        when \'v\' then \'VIEW\'\n        when \'c\' then \'composite type\'\n        when \'t\' then \'TOAST\'\n        when \'f\' then \'foreign table\'\n        when \'p\' then \'partitioned_table\'\n        when \'I\' then \'partitioned_index\'\n        else cls.relkind::text\n    end as ObjectType,\n    COUNT(*) cnt\nfrom pg_class cls\njoin pg_namespace nsp \n on nsp.oid = cls.relnamespace\nwhere nsp.nspname not in (\'information_schema\', \'pg_catalog\')\n  and nsp.nspname not like \'pg_toast%\'\nGROUP BY nsp.nspname,cls.relkind\nUNION all\nSELECT n.nspname as \"Schema\",\n CASE p.prokind\n  WHEN \'a\' THEN \'agg\'\n  WHEN \'w\' THEN \'window\'\n  WHEN \'p\' THEN \'proc\'\n  ELSE \'func\'\n END as \"Type\",\n COUNT(*) cnt\nFROM pg_catalog.pg_proc p\nLEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace\nWHERE pg_catalog.pg_function_is_visible(p.oid)\nAND n.nspname not in (\'information_schema\', \'pg_catalog\')\nGROUP BY n.nspname ,p.prokind;', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1223, 6, '●', '所有进程总计', 'SELECT\n	max_conn 最大连接数,\n	now_conn 当前连接数,\n	max_conn - now_conn 剩余连接数 \nFROM\n	( SELECT setting::int8  AS max_conn, ( SELECT COUNT ( * ) FROM pg_stat_activity ) AS now_conn FROM pg_settings WHERE NAME = \'max_connections\' ) T;', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1224, 6, '●', '所有进程详情', 'select a.*   from pg_stat_activity   a ;', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1225, 6, '●', '锁', 'SELECT * FROM pg_locks;', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1226, 6, '●', 'state_change字段长时间没有更新过的连接信息', 'SELECT * FROM pg_stat_activity where state=\'idle\' order by state_change;', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1227, 6, '●', '最耗共享内存 SQL', 'select * from pg_stat_statements order by shared_blks_hit+shared_blks_read desc limit 5;', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1228, 6, '●', '主库查看wal日志发送状态', 'select * from pg_stat_replication;', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1229, 6, '●', '从库查看wal日志接收状态', 'select * from pg_stat_wal_receiver;', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1230, 6, '●', '主从库延迟数据（单位MB）', 'select pg_wal_lsn_diff(A .c1, replay_lsn) /(1024 * 1024) AS slave_latency_MB\nfrom pg_stat_replication,\n     pg_current_wal_lsn() AS A(c1)\nORDER BY slave_latency_MB LIMIT 1;', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1231, 6, '●', '主从流复制冲突统计', 'select * from pg_stat_database_conflicts;', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1232, 6, '●', '数据库统计（是否有坏块）', 'select * from pg_stat_database;', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1233, 6, '●', '逻辑复制查看发布', 'select * from pg_publication;', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1234, 6, '●', '查看发布的表', 'select * from pg_publication_tables;', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1235, 6, '●', '查看所有的订阅者', 'select * from pg_stat_replication;', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1236, 6, '●', '复制进度', 'select * from pg_stat_subscription;', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1237, 6, '●', '查看订阅', 'select * from pg_subscription;', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1238, 6, '●', '查看订阅的表', 'select *,srrelid::regclass from pg_subscription_rel;', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1239, 6, '●', '查看复制槽', 'select * from pg_replication_slots;', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1240, 6, '●', '参数文件记录的参数', 'select * from pg_file_settings;', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1241, 6, '●', '重要参数', 'SELECT *\nFROM   pg_settings a\nWHERE  a.name IN (\'data_directory\',\n                  \'port\',\n                  \'client_encoding\',\n                  \'config_file\',\n                  \'hba_file\',\n                  \'ident_file\',\n                  \'archive_mode\',\n                  \'logging_collector\',\n                  \'log_directory\',\n                  \'log_filename\',\n                  \'log_truncate_on_rotation\',\n                  \'log_statement\',\n                  \'log_min_duration_statement\',\n                  \'max_connections\',\'listen_addresses\')\nORDER  BY NAME;', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1242, 6, '●', 'pg_hba.conf配置文件信息（PG10新增）', 'select * from pg_hba_file_rules;', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1243, 6, '●', '后台写进程统计信息', 'select * from pg_stat_bgwriter;', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1244, 6, '●', '查看表膨胀信息', 'SELECT\n    schemaname||\'.\'||relname as table_name,\n    pg_size_pretty(pg_relation_size(schemaname||\'.\'||relname)) as table_size,\n    n_dead_tup,\n    n_live_tup,\n    round(n_dead_tup * 100 / (n_live_tup + n_dead_tup),2) AS dead_tup_ratio\nFROM\n    pg_stat_all_tables\nWHERE\n    n_dead_tup &gt;= 1000\nORDER BY dead_tup_ratio DESC\nLIMIT 10;', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1245, 6, '●', '当前库的所有schema', 'select * from information_schema.schemata;', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (1246, 6, '●', '当前库的所有角色(用户)', 'select * from pg_roles;', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (1247, 6, '', '', 'select * from pg_user;', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (1248, 6, '●', '所有语言', 'select * from pg_language;', 0, 33);
INSERT INTO `tbl_chktemple_item` VALUES (1249, 6, '●', '所有插件（已编译）', 'select * from pg_available_extensions ;', 0, 34);
INSERT INTO `tbl_chktemple_item` VALUES (1250, 6, '●', '已安装的插件', 'SELECT e.extname AS \"Name\", e.extversion AS \"Version\", n.nspname AS \"Schema\", c.description AS \"Description\"\nFROM pg_catalog.pg_extension e LEFT JOIN pg_catalog.pg_namespace n ON n.oid = e.extnamespace LEFT JOIN pg_catalog.pg_description c ON c.objoid = e.oid AND c.classoid = \'pg_catalog.pg_extension\'::pg_catalog.regclass\nORDER BY 1;', 0, 35);
INSERT INTO `tbl_chktemple_item` VALUES (1251, 6, '●', '获取已安装的PostgreSQL的信息', 'SELECT * FROM pg_config ;', 0, 36);
INSERT INTO `tbl_chktemple_item` VALUES (1252, 10, '', '数据库基本信息', 'SELECT  now() now_date,\n	USER() user, -- USER()、 SYSTEM_USER()、 SESSION_USER()、 \n	CURRENT_USER() CURRENT_USER1,\n	CONNECTION_ID() CONNECTION_ID,\n	DATABASE() db_name, -- SCHEMA(),\n	version() Server_version,\n	( SELECT sum( TRUNCATE ( ( data_length + index_length ) / 1024 / 1024, 2 ) ) AS \'all_db_size(MB)\' FROM information_schema.TABLES b ) all_db_size_MB,\n	(select truncate(sum(total_extents*extent_size)/1024/1024,2) from  information_schema.FILES b) all_datafile_size_MB,\n	( SELECT @@datadir ) datadir,\n	( SELECT @@SOCKET ) SOCKET,\n	( SELECT @@log_error ) log_error,\n	-- ( SELECT @@tx_isolation ) tx_isolation, -- SELECT @@transaction_isolation tx_isolation\n	( SELECT @@autocommit ) autocommit,\n	( SELECT @@log_bin ) log_bin,\n	( SELECT @@server_id ) server_id', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (1253, 10, '', '版本信息', 'select * from INFORMATION_SCHEMA.global_variables where  VARIABLE_NAME like  \'version_%\'', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1254, 10, '', '查询当前节点cluster层磁盘空间使用信息', 'select * from performance_schema.DISK_USAGE_INFO', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1255, 10, '', '查询内存使用情况', 'select * from performance_schema.MEMORY_USAGE_INFO', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1256, 10, '', '当前数据库实例的所有数据库及其容量大小', 'select a.SCHEMA_NAME, a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME,\nsum(table_rows) as table_rows,\ntruncate(sum(data_length)/1024/1024, 2) as data_size_mb,\ntruncate(sum(index_length)/1024/1024, 2) as index_size_mb,\ntruncate(sum(data_length+index_length)/1024/1024, 2) as all_size_mb,\ntruncate(sum(max_data_length)/1024/1024, 2) as max_size_mb,\ntruncate(sum(data_free)/1024/1024, 2) as free_size_mb,\nmax(f.filesize_M)  as disk_size_mb\nfrom INFORMATION_SCHEMA.SCHEMATA a\nleft outer join information_schema.tables b\non a.SCHEMA_NAME=b.TABLE_SCHEMA\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,\n			truncate(sum(total_extents*extent_size)/1024/1024,2) filesize_M\n			from  information_schema.FILES b \n			group by substring(b.file_name,3,locate(\'/\',b.file_name,3)-3)) f\non ( a.SCHEMA_NAME= f.db_name)\ngroup by a.SCHEMA_NAME,  a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME\norder by sum(data_length) desc, sum(index_length) desc', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1257, 10, '', '数据库对象', 'select db as db_name ,type as ob_type,cnt as sums from \n(select \'TABLE\' type,table_schema db, count(*) cnt  from information_schema.`TABLES` a where table_type=\'BASE TABLE\' group by table_schema\nunion all\nselect \'EVENTS\' type,event_schema db,count(*) cnt from information_schema.`EVENTS` b group by event_schema\nunion all\nselect \'TRIGGERS\' type,trigger_schema db,count(*) cnt from information_schema.`TRIGGERS` c group by trigger_schema\nunion all\nselect \'PROCEDURE\' type,routine_schema db,count(*) cnt from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'PROCEDURE\' group by db\nunion all\nselect \'FUNCTION\' type,routine_schema db,count(*) cnt  from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'FUNCTION\' group by db\nunion all\nselect \'VIEWS\' type,TABLE_SCHEMA db,count(*) cnt  from information_schema.VIEWS f group by table_schema  ) t\norder by db,type', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1258, 10, '', '查看数据库的运行状态', 'status;', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1259, 10, '', '占用空间最大的前10张大表', 'SELECT\n	table_schema AS db_name,\n	table_name AS table_name,\n	a.TABLE_TYPE,\n	a.`ENGINE`,\n	a.CREATE_TIME,\n	a.UPDATE_TIME,\n	a.TABLE_COLLATION,\n	table_rows AS table_rows,\n	TRUNCATE(a.DATA_LENGTH / 1024 / 1024, 2 ) AS tb_size_mb,\n	TRUNCATE( index_length / 1024 / 1024, 2 ) AS index_size_mb,\n	TRUNCATE( ( data_length + index_length ) / 1024 / 1024, 2 ) AS all_size_mb,\n  TRUNCATE( a.DATA_FREE / 1024 / 1024, 2 ) AS free_size_mb,\n  truncate(f.filesize_M,2) AS disk_size_mb\nFROM information_schema.TABLES a\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,  \n			substring(b.file_name,locate(\'/\',b.file_name,3)+1,(LENGTH(b.file_name)-locate(\'/\',b.file_name,3)-4)) as tb_name,\n			b.file_name,\n			(total_extents*extent_size)/1024/1024 filesize_M\n			from  information_schema.FILES b \n			order by filesize_M desc limit 20 ) f\non ( a.TABLE_SCHEMA= f.db_name and a.TABLE_NAME=f.tb_name )\nORDER BY	( data_length + index_length ) DESC \nLIMIT 10', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1260, 10, '', '所有存储引擎列表', 'SELECT * from information_schema.`ENGINES`', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1261, 10, '', '存储引擎和DB的数量关系', 'SELECT a.`ENGINE`,count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY a.`ENGINE`', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1262, 10, '', '', 'SELECT  a.TABLE_SCHEMA,\n	a.`ENGINE`,\n	count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY  a.TABLE_SCHEMA,a.`ENGINE` \nORDER BY a.TABLE_SCHEMA', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1263, 10, '', '查询所有用户', 'select * from gbase.user', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1264, 10, '', '查询数据库中的用户与用户组role的关联关系', 'select * from gbase.role_edges', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1265, 10, '', '查询所有支持的字符集', 'select * from information_schema.CHARACTER_SETS', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1266, 10, '', '一些重要的参数', 'select * from INFORMATION_SCHEMA.global_variables where  VARIABLE_NAME  in ( \'datadir\',\'SQL_MODE\',\'socket\',\'TIME_ZONE\',\'tx_isolation\',\'transaction_isolation\',\'autocommit\',\'innodb_lock_wait_timeout\',\'max_connections\',\'max_user_connections\',\'slow_query_log\',\'log_output\',\'slow_query_log_file\',\'long_query_time\',\'log_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'pid_file\',\'log_error\',\'lower_case_table_names\',\'innodb_buffer_pool_size\',\'innodb_flush_log_at_trx_commit\',\'read_only\', \'log_slave_updates\',\'innodb_io_capacity\',\'query_cache_type\',\'query_cache_size\',\'max_connect_errors\',\'server_id\',\'innodb_file_per_table\') or VARIABLE_NAME like \'%compress%\' order by VARIABLE_NAME', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1267, 10, '', '查看当前连接到数据库的用户和Host', 'SELECT DISTINCT USER,HOST FROM `information_schema`.`PROCESSLIST` P WHERE P.USER NOT in (\'repl\',\'system user\') limit 100', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1268, 10, '', '查看加载进度', 'select * from information_schema.load_status', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1269, 10, '', '查看历史加载结果', 'select * from information_schema.load_result', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1270, 10, '', '查询所有线程（排除sleep线程）', 'select * from information_schema.`PROCESSLIST`  a where a.command\'Sleep\' and a.idCONNECTION_id()', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1271, 10, '', 'sleep线程TOP20', 'select * from information_schema.`PROCESSLIST`  a where a.command=\'Sleep\' order by time desc limit 20', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1272, 10, '', '有多少线程正在使用表', 'show open tables where in_use &gt; 0;', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1273, 10, '', '查看服务器的状态', 'select * from INFORMATION_SCHEMA.global_status where  VARIABLE_NAME like \'%lock%\'', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1274, 10, '', '查询SQL的整体消耗百分比', 'select state,\n       sum(duration) as total_r,\n       round(100 * sum(duration) / (select sum(duration) from information_schema.profiling  where query_id = 1),2) as pct_r,\n       count(*) as calls,\n       sum(duration) / count(*) as \"r/call\"\n  from information_schema.profiling\n where query_id = 1\n group by state\n order by total_r desc', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1275, 10, '', '高可用重要参数', 'select * from INFORMATION_SCHEMA.global_variables where  VARIABLE_NAME  in ( \'server_id\',\'server_uuid\',\'log_bin\',\'log_bin_basename\',\'sql_log_bin\',\'log_bin_index\',\'log_slave_updates\',\'read_only\',\'slave_skip_errors\',\'max_allowed_packet\',\'slave_max_allowed_packet\',\'auto_increment_increment\',\'auto_increment_offset\',\'sync_binlog\',\'binlog_format\',\'expire_logs_days\',\'max_binlog_size\',\'slave_skip_errors\',\'sql_slave_skip_counter\',\'slave_exec_mode\',\'rpl_semi_sync_master_enabled\',\'rpl_semi_sync_master_timeout\',\'rpl_semi_sync_master_trace_level\',\'rpl_semi_sync_master_wait_for_slave_count\',\'rpl_semi_sync_master_wait_no_slave\',\'rpl_semi_sync_master_wait_point\',\'rpl_semi_sync_slave_enabled\',\'rpl_semi_sync_slave_trace_level\')', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1276, 10, '', '性能参数统计', 'select * from INFORMATION_SCHEMA.global_status where  VARIABLE_NAME  in ( \'connections\',\'uptime\',\'com_select\',\'com_insert\',\'com_delete\',\'slow_queries\',\'Created_tmp_tables\',\'Created_tmp_files\',\'Created_tmp_disk_tables\',\'table_cache\',\'Handler_read_rnd_next\',\'Table_locks_immediate\',\'Table_locks_waited\',\'Open_files\',\'Opened_tables\',\'Sort_merge_passes\',\'Sort_range\',\'Sort_rows\',\'Sort_scan\')', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1277, 10, '', '插件信息', 'SELECT * FROM INFORMATION_SCHEMA.PLUGINS', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1278, 10, '', '自增ID的使用情况（前20条）', 'SELECT table_schema,table_name,engine, Auto_increment\n FROM information_schema.tables a\n where TABLE_SCHEMA not in (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\n and  a.Auto_increment\'\'\n order by a.AUTO_INCREMENT desc\nlimit 20', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1279, 10, '', '无主键或唯一键的表（前100条）', 'select table_schema, table_name\n from information_schema.tables\nwhere table_type=\'BASE TABLE\'\n and  (table_schema, table_name) not in ( select /*+ subquery(materialization) */ a.TABLE_SCHEMA,a.TABLE_NAME \n           from information_schema.TABLE_CONSTRAINTS a \n		   where a.CONSTRAINT_TYPE in (\'PRIMARY KEY\',\'UNIQUE\')\n		   and table_schema not in    (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')	)\n AND table_schema not in  (\'mysql\', \'information_schema\', \'sys\', \'performance_schema\')\nlimit 100 ', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1286, 11, '', '版本信息', 'select * from information_schema.GLOBAL_VARIABLES WHERE VARIABLE_NAME like \'version%\'', 0, 0);
INSERT INTO `tbl_chktemple_item` VALUES (1287, 11, '', '检查集群状态', 'select * from oceanbase.v$ob_cluster', 0, 1);
INSERT INTO `tbl_chktemple_item` VALUES (1288, 11, '', '检查所有服务器的状态', '-- 包括这个 Server 的 IP 地址和端口号，它隶属于哪个 zone，是否运行 root service 服务，以及当前状态等信息。\nselect * from oceanbase.__all_server', 0, 2);
INSERT INTO `tbl_chktemple_item` VALUES (1289, 11, '', '查看集群中的整体资源分配情况', 'select \nzone,\nconcat(svr_ip, \':\', svr_port) as observer,\nconcat(cpu_assigned, \' : \', cpu_total) as cpu_summary,\nconcat(mem_assigned/(1024*1024*1024),\' : \', mem_total/(1024*1024*1024)) as mem_summary_gb,\nconcat(disk_assigned/(1024*1024*1024),\' : \', disk_total/(1024*1024*1024)) as disk_summary_gb,\ncast(cpu_weight as decimal(5,2)) as c_weight,\ncast(memory_weight as decimal(5,2)) as m_weight,\ncast(disk_weight as decimal(5,2)) as d_weight,\nunit_num\nfrom oceanbase.__all_virtual_server_stat\norder by zone,observer', 0, 3);
INSERT INTO `tbl_chktemple_item` VALUES (1290, 11, '', '资源分配概况', 'select \npool.name as pool_name ,\nunit_id,\nunit_config.name as unit_config_name,\nsvr_ip,\nstatus,\nmin_cpu,\nmax_cpu,\nmin_memory/ (1024*1024*1024) as min_memory_gb,\nmax_memory/ (1024*1024*1024) as max_memory_gb\nfrom\noceanbase.__all_resource_pool pool inner join oceanbase.__all_unit unit \non pool.resource_pool_id = unit.resource_pool_id\ninner join oceanbase.__all_unit_config unit_config\non pool.unit_config_id=unit_config.unit_config_id\norder by pool_name ,unit_id,svr_ip', 0, 4);
INSERT INTO `tbl_chktemple_item` VALUES (1291, 11, '', '查看系统中定义的resource unit规格', 'select * from oceanbase.__all_unit_config', 0, 5);
INSERT INTO `tbl_chktemple_item` VALUES (1292, 11, '', '查看系统中已经分配的resource unit', 'select * from oceanbase.__all_unit', 0, 6);
INSERT INTO `tbl_chktemple_item` VALUES (1293, 11, '', '将已经分配的resource unit和具体的租户对应起来', 'select * from oceanbase.__all_resource_pool', 0, 7);
INSERT INTO `tbl_chktemple_item` VALUES (1294, 11, '', '查看memstore的使用情况', 'select \ntenant_name,\nsvr_ip,\nmemstore_limit/(1024*1024*1024) as memstore_limit,\nmajor_freeze_trigger/(1024*1024*1024) as freeze_trigger_gb,\ntotal_memstore_used/(1024*1024*1024) as memstore_used_gb,\nconcat((total_memstore_used*100/memstore_limit),\'%\') as memstore_used_percent,\nactive_memstore_used/(1024*1024*1024) as active_memstore_used_gb,\nfreeze_cnt\nfrom oceanbase.__all_virtual_tenant_memstore_info memstore_info\ninner join oceanbase.__all_tenant tenant\non memstore_info.tenant_id=tenant.tenant_id\nwhere tenant.tenant_id &gt; 1000\norder by\ntenant.tenant_name,svr_ip', 0, 8);
INSERT INTO `tbl_chktemple_item` VALUES (1295, 11, '', '查看非memstore内存分类情况,按租户区分', 'select\nZone ,\nsvr_ip,\ncase\nwhen tenant.tenant_name is not null then tenant.tenant_name \nelse concat( \'tenant \', cast(memory_info.tenant_id as char(6))) \nend as tenant_name,\nsum(hold)/(1024*1024*1024) as hold_gb ,\nsum(used)/(1024*1024*1024) as used_gb ,\n(sum(used) / sum(hold))*100 as used_percent,\nsum(alloc_count) as alloc_count,\nsum(count) as used_count,\nsum(free_count) as free_count\nfrom  oceanbase.__all_virtual_memory_info memory_info\nleft join oceanbase.__all_tenant tenant\non memory_info.tenant_id = tenant.tenant_id\ngroup by zone,\nsvr_ip,\ncase\nwhen tenant.tenant_name is not null then tenant.tenant_name \nelse concat( \'tenant \', cast(memory_info.tenant_id as char(6))) \nend\norder by  4 desc,zone,svr_ip\nlimit 30', 0, 9);
INSERT INTO `tbl_chktemple_item` VALUES (1296, 11, '', '查看非memstore内存分类情况,按租户和模块(mod_name)区分', 'select\nZone ,\nsvr_ip,\ncase\nwhen tenant.tenant_name is not null then tenant.tenant_name \nelse concat( \'tenant \', cast(memory_info.tenant_id as char(6))) \nend as tenant_name,\nmod_name,\nsum(hold)/(1024*1024*1024) as hold_gb ,\nsum(used)/(1024*1024*1024) as used_gb ,\n(sum(used) / sum(hold))*100 as used_percent,\nsum(alloc_count) as alloc_count,\nsum(count) as used_count,\nsum(free_count) as free_count\nfrom  oceanbase.__all_virtual_memory_info memory_info\nleft join oceanbase.__all_tenant tenant\non memory_info.tenant_id = tenant.tenant_id\ngroup by zone,\nsvr_ip,\ncase\nwhen tenant.tenant_name is not null then tenant.tenant_name \nelse concat( \'tenant \', cast(memory_info.tenant_id as char(6))) \nend,\nmod_name\norder by  5 desc,zone,svr_ip\nlimit 30', 0, 10);
INSERT INTO `tbl_chktemple_item` VALUES (1297, 11, '', '统计每台机器上数据盘的使用情况', 'select\nsvr_ip,\ntotal_size/(1024*1024*1024) as total_gb,\n(total_size - free_size)/(1024*1024*1024) as used_gb\nfrom oceanbase.__all_virtual_disk_stat\norder by svr_ip', 0, 11);
INSERT INTO `tbl_chktemple_item` VALUES (1298, 11, '', '统计每个zone里数据盘的使用情况', 'select \nzone,\nsum(total_size)/(1024*1024*1024) as total_gb,\nsum((total_size - free_size))/(1024*1024*1024) as used_gb\nfrom  oceanbase.__all_virtual_disk_stat disk_stat \ninner join oceanbase.__all_server all_server\non disk_stat.svr_ip = all_server.svr_ip\ngroup by zone \norder by zone', 0, 12);
INSERT INTO `tbl_chktemple_item` VALUES (1299, 11, '', '检查集群合并的状态', 'select * from oceanbase.__all_zone d where d.`name`=\'merge_status\'', 0, 13);
INSERT INTO `tbl_chktemple_item` VALUES (1300, 11, '', '查询所有租户', 'select * from oceanbase.__all_tenant', 0, 14);
INSERT INTO `tbl_chktemple_item` VALUES (1301, 11, '', '查询所有用户', 'select * from mysql.user', 0, 15);
INSERT INTO `tbl_chktemple_item` VALUES (1302, 11, '', '数据库基本信息', 'SELECT  now() now_date,\n	USER() user, -- USER()、 SYSTEM_USER()、 SESSION_USER()、 \n	CURRENT_USER() CURRENT_USER1,\n	CONNECTION_ID() CONNECTION_ID,\n	DATABASE() db_name, -- SCHEMA(),\n	version() Server_version,\n	-- ( SELECT @@tx_isolation ) tx_isolation, -- SELECT @@transaction_isolation tx_isolation\n	( SELECT @@autocommit ) autocommit,\n	( SELECT @@server_id ) server_id', 0, 16);
INSERT INTO `tbl_chktemple_item` VALUES (1303, 11, '', '当前数据库实例的所有数据库及其容量大小', 'select a.SCHEMA_NAME, a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME,\nsum(table_rows) as table_rows,\ntruncate(sum(data_length)/1024/1024, 2) as data_size_mb,\ntruncate(sum(index_length)/1024/1024, 2) as index_size_mb,\ntruncate(sum(data_length+index_length)/1024/1024, 2) as all_size_mb,\ntruncate(sum(max_data_length)/1024/1024, 2) as max_size_mb,\ntruncate(sum(data_free)/1024/1024, 2) as free_size_mb,\nmax(f.filesize_M)  as disk_size_mb\nfrom INFORMATION_SCHEMA.SCHEMATA a\nleft outer join information_schema.tables b\non a.SCHEMA_NAME=b.TABLE_SCHEMA\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,\n			truncate(sum(total_extents*extent_size)/1024/1024,2) filesize_M\n			from  information_schema.FILES b \n			group by substring(b.file_name,3,locate(\'/\',b.file_name,3)-3)) f\non ( a.SCHEMA_NAME= f.db_name)\ngroup by a.SCHEMA_NAME,  a.DEFAULT_CHARACTER_SET_NAME,a.DEFAULT_COLLATION_NAME\norder by sum(data_length) desc, sum(index_length) desc', 0, 17);
INSERT INTO `tbl_chktemple_item` VALUES (1304, 11, '', '数据库对象', 'select db as db_name ,type as ob_type,cnt as sums from \n(select \'TABLE\' type,table_schema db, count(*) cnt  from information_schema.`TABLES` a where table_type=\'BASE TABLE\' group by table_schema\n-- union all\n-- select \'EVENTS\' type,event_schema db,count(*) cnt from information_schema.`EVENTS` b group by event_schema\nunion all\nselect \'TRIGGERS\' type,trigger_schema db,count(*) cnt from information_schema.`TRIGGERS` c group by trigger_schema\nunion all\nselect \'PROCEDURE\' type,routine_schema db,count(*) cnt from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'PROCEDURE\' group by db\nunion all\nselect \'FUNCTION\' type,routine_schema db,count(*) cnt  from information_schema.ROUTINES d where`ROUTINE_TYPE` = \'FUNCTION\' group by db\nunion all\nselect \'VIEWS\' type,TABLE_SCHEMA db,count(*) cnt  from information_schema.VIEWS f group by table_schema  ) t\norder by db,type', 0, 18);
INSERT INTO `tbl_chktemple_item` VALUES (1305, 11, '', '查看数据库的运行状态', 'status;', 0, 19);
INSERT INTO `tbl_chktemple_item` VALUES (1306, 11, '', '占用空间最大的前10张大表', 'SELECT\n	table_schema AS db_name,\n	table_name AS table_name,\n	a.TABLE_TYPE,\n	a.`ENGINE`,\n	a.CREATE_TIME,\n	a.UPDATE_TIME,\n	a.TABLE_COLLATION,\n	table_rows AS table_rows,\n	TRUNCATE(a.DATA_LENGTH / 1024 / 1024, 2 ) AS tb_size_mb,\n	TRUNCATE( index_length / 1024 / 1024, 2 ) AS index_size_mb,\n	TRUNCATE( ( data_length + index_length ) / 1024 / 1024, 2 ) AS all_size_mb,\n  TRUNCATE( a.DATA_FREE / 1024 / 1024, 2 ) AS free_size_mb,\n  truncate(f.filesize_M,2) AS disk_size_mb\nFROM information_schema.TABLES a\nleft outer join \n    (select substring(b.file_name,3,locate(\'/\',b.file_name,3)-3) as db_name,  \n			substring(b.file_name,locate(\'/\',b.file_name,3)+1,(LENGTH(b.file_name)-locate(\'/\',b.file_name,3)-4)) as tb_name,\n			b.file_name,\n			(total_extents*extent_size)/1024/1024 filesize_M\n			from  information_schema.FILES b \n			order by filesize_M desc limit 20 ) f\non ( a.TABLE_SCHEMA= f.db_name and a.TABLE_NAME=f.tb_name )\nORDER BY	( data_length + index_length ) DESC \nLIMIT 10', 0, 20);
INSERT INTO `tbl_chktemple_item` VALUES (1307, 11, '', '所有存储引擎列表', 'SELECT * from information_schema.`ENGINES`', 0, 21);
INSERT INTO `tbl_chktemple_item` VALUES (1308, 11, '', '存储引擎和DB的数量关系', 'SELECT a.`ENGINE`,count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY a.`ENGINE`', 0, 22);
INSERT INTO `tbl_chktemple_item` VALUES (1309, 11, '', '', 'SELECT  a.TABLE_SCHEMA,\n	a.`ENGINE`,\n	count( * ) counts \nFROM    information_schema.`TABLES` a \nGROUP BY  a.TABLE_SCHEMA,a.`ENGINE` \nORDER BY a.TABLE_SCHEMA', 0, 23);
INSERT INTO `tbl_chktemple_item` VALUES (1310, 11, '', '查询OceanBase支持的所有字符集', 'select * from information_schema.CHARACTER_SETS', 0, 24);
INSERT INTO `tbl_chktemple_item` VALUES (1311, 11, '', '一些重要的参数', 'select * from information_schema.GLOBAL_VARIABLES WHERE VARIABLE_NAME in (\'datadir\',\'SQL_MODE\',\'socket\',\'TIME_ZONE\',\'tx_isolation\',\'autocommit\',\'innodb_lock_wait_timeout\',\'max_connections\',\'max_user_connections\',\'slow_query_log\',\'log_output\',\'slow_query_log_file\',\'long_query_time\',\'log_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'log_throttle_queries_not_using_indexes\',\'pid_file\',\'log_error\',\'lower_case_table_names\',\'innodb_buffer_pool_size\',\'innodb_flush_log_at_trx_commit\',\'read_only\', \'log_slave_updates\',\'innodb_io_capacity\',\'query_cache_type\',\'query_cache_size\',\'max_connect_errors\',\'server_id\',\'innodb_file_per_table\')', 0, 25);
INSERT INTO `tbl_chktemple_item` VALUES (1312, 11, '', '查看当前连接到数据库的用户和Host', 'SELECT DISTINCT USER,HOST FROM `information_schema`.`PROCESSLIST` P WHERE P.USER NOT in (\'repl\',\'system user\') limit 100', 0, 26);
INSERT INTO `tbl_chktemple_item` VALUES (1313, 11, '', '按照登录用户+登录服务器查看登录信息', 'SELECT USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count \nFROM `information_schema`.`PROCESSLIST` P \n-- WHERE P.USER NOT IN ( \'root\', \'repl\', \'system user\' ) \nGROUP BY USER,LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 )', 0, 27);
INSERT INTO `tbl_chktemple_item` VALUES (1314, 11, '', '按照登录用户+数据库+登录服务器查看登录信息', 'SELECT  DB AS database_name,\n	USER AS login_user,\n	LEFT ( HOST, POSITION( \':\' IN HOST ) - 1 ) AS login_ip,\n	count( 1 ) AS login_count \nFROM  `information_schema`.`PROCESSLIST` P \n-- WHERE P.USER NOT IN ( \'root\', \'repl\', \'system user\' ) \nGROUP BY DB,USER,LEFT(HOST, POSITION( \':\' IN HOST ) - 1 )', 0, 28);
INSERT INTO `tbl_chktemple_item` VALUES (1315, 11, '', '查询所有线程（排除sleep线程）', 'select * from information_schema.`PROCESSLIST`  a where a.command\'Sleep\' and a.idCONNECTION_id()', 0, 29);
INSERT INTO `tbl_chktemple_item` VALUES (1316, 11, '', 'sleep线程TOP20', 'select * from information_schema.`PROCESSLIST`  a where a.command=\'Sleep\' order by time desc limit 20', 0, 30);
INSERT INTO `tbl_chktemple_item` VALUES (1317, 11, '', '性能参数统计', 'show global status where  VARIABLE_NAME  in ( \'connections\',\'uptime\',\'com_select\',\'com_insert\',\'com_delete\',\'slow_queries\',\'Created_tmp_tables\',\'Created_tmp_files\',\'Created_tmp_disk_tables\',\'table_cache\',\'Handler_read_rnd_next\',\'Table_locks_immediate\',\'Table_locks_waited\',\'Open_files\',\'Opened_tables\',\'Sort_merge_passes\',\'Sort_range\',\'Sort_rows\',\'Sort_scan\');', 0, 31);
INSERT INTO `tbl_chktemple_item` VALUES (1318, 11, '', '无主键或唯一键的表（前100条）', 'select table_schema, table_name\n from information_schema.tables\nwhere table_type=\'BASE TABLE\'\n and  (table_schema, table_name) not in ( select /*+ subquery(materialization) */ a.TABLE_SCHEMA,a.TABLE_NAME \n           from information_schema.TABLE_CONSTRAINTS a \n		   where a.CONSTRAINT_TYPE in (\'PRIMARY KEY\',\'UNIQUE\')\n		   and table_schema not in    (\'OceanBase\', \'information_schema\', \'sys\', \'performance_schema\')	)\n AND table_schema not in  (\'OceanBase\', \'information_schema\', \'sys\', \'performance_schema\')\nlimit 100 ', 0, 32);
INSERT INTO `tbl_chktemple_item` VALUES (1319, 11, '', '自增ID的使用情况（前20条）', 'SELECT table_schema,table_name,engine, Auto_increment\n FROM information_schema.tables a\n where TABLE_SCHEMA not in (\'OceanBase\', \'information_schema\', \'sys\', \'performance_schema\')\n and  a.Auto_increment\'\'\n order by a.AUTO_INCREMENT desc\nlimit 20 ', 0, 33);

-- ----------------------------
-- Table structure for tbl_database
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database`;
CREATE TABLE IF NOT EXISTS `tbl_database`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '数据库ID',
  `db_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `db_dbname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名/实例名',
  `db_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库域名/IP',
  `db_port` int(10) NULL DEFAULT NULL COMMENT '数据库端口号',
  `db_userId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库用户名',
  `db_pwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据用户密码',
  `db_owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属管理员',
  `db_status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（0启用 1禁用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_scope` int(1) NULL DEFAULT NULL COMMENT '资产范围0数据库1实例',
  `group_id` int(10) NULL DEFAULT NULL COMMENT '资产分组ID',
  `trino_flag` int(1) NULL DEFAULT NULL COMMENT 'trino标记0不依赖1依赖',
  `trino_catalog` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型的名称',
	`version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库引擎版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_database
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_auth
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_auth`;
CREATE TABLE IF NOT EXISTS `tbl_database_auth`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `group_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群组ID',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库id',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `owner` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属数据库实例',
  `schema` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '库名',
  `tname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象名称',
  `tcolumn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称 ',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型database, table, view, procedure, function, column',
  `type_opts` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型, dql, dml, ddl+dcl',
  `dql` int(1) NULL DEFAULT NULL COMMENT '读权限 0禁用 1启用',
  `dml` int(1) NULL DEFAULT NULL COMMENT '写权限 0禁用 1启用',
  `dcl` int(1) NULL DEFAULT NULL COMMENT '管理权限 0禁用 1启用',
  `ddl` int(1) NULL DEFAULT NULL COMMENT '定义权限 0禁用 1启用',
  `tty` int(1) NULL DEFAULT NULL,
  `dql_export` int(1) NULL DEFAULT NULL,
  `dml_insert` int(1) NULL DEFAULT NULL,
  `dml_update` int(1) NULL DEFAULT NULL,
  `dml_delete` int(1) NULL DEFAULT NULL,
  `ddl_create_db` int(1) NULL DEFAULT NULL,
  `ddl_drop_db` int(1) NULL DEFAULT NULL,
  `ddl_alter_db` int(1) NULL DEFAULT NULL,
  `ddl_create` int(1) NULL DEFAULT NULL,
  `ddl_drop` int(1) NULL DEFAULT NULL,
  `ddl_alter` int(1) NULL DEFAULT NULL,
  `ddl_rename` int(1) NULL DEFAULT NULL,
  `ddl_truncate` int(1) NULL DEFAULT NULL,
  `dcl_grant_revoke` int(1) NULL DEFAULT NULL,
  `dcl_create_user` int(1) NULL DEFAULT NULL,
  `maskId` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hidden` int(11) NULL DEFAULT 0 COMMENT ' 0不禁用 1禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 274 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_database_auth
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_auth_snap
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_auth_snap`;
CREATE TABLE IF NOT EXISTS `tbl_database_auth_snap`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `group_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群组ID',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库id',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `owner` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属数据库实例',
  `schema` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '库名',
  `tname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象名称',
  `tcolumn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称 ',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型database, table, view, procedure, function, column',
  `type_opts` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型, dql, dml, ddl+dcl',
  `dql` int(1) NULL DEFAULT NULL COMMENT '读权限 0禁用 1启用',
  `dml` int(1) NULL DEFAULT NULL COMMENT '写权限 0禁用 1启用',
  `dcl` int(1) NULL DEFAULT NULL COMMENT '管理权限 0禁用 1启用',
  `ddl` int(1) NULL DEFAULT NULL COMMENT '定义权限 0禁用 1启用',
  `tty` int(1) NULL DEFAULT NULL,
  `dql_export` int(1) NULL DEFAULT NULL,
  `dml_insert` int(1) NULL DEFAULT NULL,
  `dml_update` int(1) NULL DEFAULT NULL,
  `dml_delete` int(1) NULL DEFAULT NULL,
  `ddl_create_db` int(1) NULL DEFAULT NULL,
  `ddl_drop_db` int(1) NULL DEFAULT NULL,
  `ddl_alter_db` int(1) NULL DEFAULT NULL,
  `ddl_create` int(1) NULL DEFAULT NULL,
  `ddl_drop` int(1) NULL DEFAULT NULL,
  `ddl_alter` int(1) NULL DEFAULT NULL,
  `ddl_rename` int(1) NULL DEFAULT NULL,
  `ddl_truncate` int(1) NULL DEFAULT NULL,
  `dcl_grant_revoke` int(1) NULL DEFAULT NULL,
  `dcl_create_user` int(1) NULL DEFAULT NULL,
  `maskId` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hidden` int(11) NULL DEFAULT 0 COMMENT ' 0禁用 1启用',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录名',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `snap_id` int(10) NULL DEFAULT NULL COMMENT '快照编号',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名',
  `db_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据资产名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 904 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_database_auth_snap
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_dbgroup
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_dbgroup`;
CREATE TABLE IF NOT EXISTS `tbl_database_dbgroup`  (
  `dbId` int(10) NOT NULL COMMENT '数据资产ID',
  `groupId` int(10) NOT NULL COMMENT '群组ID',
  UNIQUE INDEX `dbId`(`dbId`, `groupId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_database_dbgroup
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_driver
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_driver`;
CREATE TABLE IF NOT EXISTS `tbl_database_driver`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '数据库驱动ID',
  `db_type` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `db_driver` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库驱动',
  `db_type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型名称',
  `inspect_script` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '巡检脚本',
  `db_url` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接字符',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_database_driver
-- ----------------------------
INSERT INTO `tbl_database_driver` VALUES (1, 'mysql', 'com.mysql.cj.jdbc.Driver', 'Mysql', NULL, 'jdbc:mysql://{host}:{port}/{dbname}?useUnicode=true&useSSL=false&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&serverTimezone=GMT%2B8');
INSERT INTO `tbl_database_driver` VALUES (2, 'oracle', 'oracle.jdbc.driver.OracleDriver', 'Oracle', NULL, 'jdbc:oracle:thin:@{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (3, 'oceanbase', 'com.mysql.cj.jdbc.Driver', 'OceanBase', NULL, 'jdbc:mysql://{host}:{port}/{dbname}?useSSL=false');
INSERT INTO `tbl_database_driver` VALUES (4, 'dameng', 'dm.jdbc.driver.DmDriver', '达梦', NULL, 'jdbc:dm://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (5, 'tidb', 'com.mysql.cj.jdbc.Driver', 'Tidb', NULL, 'jdbc:mysql://{host}:{port}/{dbname}?useUnicode=true&characterEncoding=UTF-8');
INSERT INTO `tbl_database_driver` VALUES (6, 'gbase', 'com.gbase.jdbc.Driver', 'Gbase8a南大通用', NULL, 'jdbc:gbase://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (7, 'postgresql', 'org.postgresql.Driver', 'PostgreSQL', NULL, 'jdbc:postgresql://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (8, 'polardb', 'org.postgresql.Driver', 'PolarDB-PG', NULL, 'jdbc:postgresql://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (9, 'opengauss', 'org.postgresql.Driver', 'OpenGauss', NULL, 'jdbc:postgresql://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (10, 'kingbase', 'com.kingbase8.Driver', 'KingBaseES人大金仓', NULL, 'jdbc:kingbase8://{host}:{port}/{dbname}');
INSERT INTO `tbl_database_driver` VALUES (11, 'sqlserver', 'com.microsoft.sqlserver.jdbc.SQLServerDriver', 'SqlServer', NULL, 'jdbc:sqlserver://{host}:{port};databaseName={dbname};encrypt=true;trustServerCertificate=true;');
INSERT INTO `tbl_database_driver` VALUES (12, 'redis', 'com.itmuch.redis.jdbc.driver.RedisDriver', 'Redis单机', NULL, 'jdbc:redis://{host}:{port}/0');
INSERT INTO `tbl_database_driver` VALUES (13, 'rediscluster', 'com.itmuch.redis.jdbc.driver.RedisDriver', 'Redis集群', NULL, 'jdbc:redis-cluster:///{host}:{port}');
INSERT INTO `tbl_database_driver` VALUES (14, 'mongodb', NULL, 'MongoDB', NULL, 'mongodb://{host}:{port}');

-- ----------------------------
-- Table structure for tbl_database_group
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_group`;
CREATE TABLE IF NOT EXISTS `tbl_database_group`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '数据库群组ID',
  `group_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库群组名称',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0 有效 1失效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_database_group
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_role
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_role`;
CREATE TABLE IF NOT EXISTS `tbl_database_role`  (
  `id` int(10) NOT NULL COMMENT '数据操作群组ID',
  `role_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群组名称',
  `role_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群组描述',
  `role_status` int(1) NULL DEFAULT NULL COMMENT '群组有效期（0永久 1临时）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_database_role
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_snmp
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_snmp`;
CREATE TABLE IF NOT EXISTS `tbl_database_snmp`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '监控配置ID',
  `db_id` int(4) NULL DEFAULT NULL COMMENT '数据资产ID',
  `host_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器Ip',
  `cpu_oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cpu键值',
  `mem_oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内存键值',
  `disc_oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '磁盘键值',
  `community` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标名',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(1) NULL DEFAULT NULL COMMENT 'snmp状态1开启0关闭',
  `port` int(10) NULL DEFAULT NULL COMMENT '端口号',
  `mem_oid_total` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总内存键值',
  `disc_oid_total` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总磁盘键值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_database_snmp
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_database_usergroup
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_database_usergroup`;
CREATE TABLE IF NOT EXISTS `tbl_database_usergroup`  (
  `userId` int(10) NOT NULL COMMENT '用户Id',
  `groupId` int(10) NOT NULL COMMENT '群组Id',
  UNIQUE INDEX `userId`(`userId`, `groupId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_database_usergroup
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_datagroup
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_datagroup`;
CREATE TABLE IF NOT EXISTS `tbl_datagroup`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '资产组ID',
  `group_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名',
  `group_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注说明',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0有效1无效',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_datagroup
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_desen_result
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_desen_result`;
CREATE TABLE IF NOT EXISTS `tbl_desen_result`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '敏感字段表',
  `db_id` int(10) NULL DEFAULT NULL COMMENT '数据库实例ID',
  `db_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名',
  `table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `col_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `desen_id` int(11) NULL DEFAULT NULL COMMENT '脱敏方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_desen_result
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_desens_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_desens_config`;
CREATE TABLE IF NOT EXISTS `tbl_desens_config`  (
  `id` int(10) NOT NULL COMMENT '脱敏配置ID',
  `desens_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏名称',
  `desens_express` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏正则表达式',
  `desens_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏方式',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '启用状态（0启用1禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_desens_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_desens_type
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_desens_type`;
CREATE TABLE IF NOT EXISTS `tbl_desens_type`  (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT '脱敏方式Id',
  `desen_type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏方式名称',
  `desen_type_code` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '脱敏方式代码',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态',
  `desen_char` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认*',
  `desen_len` int(2) NULL DEFAULT NULL COMMENT '打码位数',
  `mask_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0 隐藏 1 两边打码 2 中间打码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_desens_type
-- ----------------------------
INSERT INTO `tbl_desens_type` VALUES (1, '隐藏', '01', '文字显示为“该信息为敏感内容，不予显示”', 0, '*', -1, '0');
INSERT INTO `tbl_desens_type` VALUES (2, '两边打码1位', '02', '两边用*打码1位', 0, '*', 1, '1');
INSERT INTO `tbl_desens_type` VALUES (3, '中间打码1位', '03', '中间用*打码1位', 0, '*', 1, '2');
INSERT INTO `tbl_desens_type` VALUES (4, '中间打码4位', '04', '中间用*打码4位', 0, '*', 4, '2');

-- ----------------------------
-- Table structure for tbl_desenscan_item
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_desenscan_item`;
CREATE TABLE IF NOT EXISTS `tbl_desenscan_item`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '扫描结果条目ID',
  `scan_id` int(10) NULL DEFAULT NULL COMMENT '扫描日志ID',
  `db_id` int(10) NULL DEFAULT NULL COMMENT '实例ID',
  `db_dbname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名',
  `db_tablename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `db_colname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `desen_id` int(10) NULL DEFAULT NULL COMMENT '敏感类型',
  `flag` int(1) NULL DEFAULT 0 COMMENT '确认标记0未确认1已确认',
  `sample` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '样本',
  `is_valid` int(1) NULL DEFAULT 0 COMMENT '有效状态0有效1无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_desenscan_item
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_desenscan_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_desenscan_log`;
CREATE TABLE IF NOT EXISTS `tbl_desenscan_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '敏感扫描任务ID',
  `db_id` int(10) NULL DEFAULT NULL COMMENT '实例ID',
  `db_dbname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扫描结果',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0扫描中1成功2失败',
  `sample_count` int(4) NULL DEFAULT NULL COMMENT '抽样上限',
  `find_count` int(6) NULL DEFAULT NULL COMMENT '发现字段数',
  `confirm_flag` int(1) NULL DEFAULT NULL COMMENT '结果确认标记0未确认1已确认',
  `sample_low` int(4) NULL DEFAULT NULL COMMENT '抽样下限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_desenscan_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_doc
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_doc`;
CREATE TABLE IF NOT EXISTS `tbl_doc`  (
  `id` int(10) NOT NULL COMMENT 'API文档ID',
  `doc_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档名称',
  `doc_brief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档简介',
  `doc_owner` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属厂商',
  `doc_size` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档大小',
  `doc_format` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档格式',
  `doc_version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档版本',
  `doc_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下载链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_doc
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_group
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_group`;
CREATE TABLE IF NOT EXISTS `tbl_group`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '群组ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '群组名称',
  `type` int(1) NOT NULL DEFAULT 0 COMMENT '组类型0普通组1用户组',
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '组状态0有效1禁用',
  `isExpire` int(1) NULL DEFAULT NULL COMMENT '有效状态0有效1失效',
  `expireAt` datetime NULL DEFAULT NULL COMMENT '失效时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_group
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_indicator_threshold
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_indicator_threshold`;
CREATE TABLE IF NOT EXISTS `tbl_indicator_threshold`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '指标阈值ID',
  `indicator_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指标代码',
  `indicator_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指标名称',
  `threshold_up` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阈值上限',
  `threshold_down` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阈值下限',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `db_id` int(4) NULL DEFAULT NULL COMMENT '数据资产ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_indicator_threshold
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_instance_db
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_instance_db`;
CREATE TABLE IF NOT EXISTS `tbl_instance_db`  (
  `id` int(6) NOT NULL AUTO_INCREMENT COMMENT '实例数据库ID',
  `instance_id` int(4) NULL DEFAULT NULL COMMENT '实例ID',
  `db_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0有效 1无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 272 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_instance_db
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_message
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_message`;
CREATE TABLE IF NOT EXISTS `tbl_message`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '站内消息ID',
  `type` int(2) NULL DEFAULT NULL COMMENT '消息类型 1安全策略报警消息 2 工单消息3监控报警',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标题',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息内容',
  `time` datetime NULL DEFAULT NULL COMMENT '消息时间',
  `receiver` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0 未读 1已读',
  `src_type` int(2) NULL DEFAULT NULL COMMENT '消息来源1安全策略2审计策略3数据库操作4系统监控',
  `src_id` int(20) NULL DEFAULT NULL COMMENT '来源标识号',
  `config_id` int(10) NULL DEFAULT NULL COMMENT '策略ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7031 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_message
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_monitor_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_monitor_config`;
CREATE TABLE IF NOT EXISTS `tbl_monitor_config`  (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT '监控指标ID',
  `monitor_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标名称',
  `monitor_status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开启状态（0开启 1关闭）',
  `monitor_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标代码',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `monitor_script` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '监控脚本',
  `sort` int(2) NULL DEFAULT NULL COMMENT '指标排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指标单位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_monitor_config
-- ----------------------------
INSERT INTO `tbl_monitor_config` VALUES (1, '连接数', '0', 'connCount', 'mysql', '', 1, 'admin', '2024-05-31 07:48:07', 'admin', '2024-05-31 07:52:26', NULL);
INSERT INTO `tbl_monitor_config` VALUES (3, '查询命中率', '1', 'queryRate', 'mysql', '', 3, 'admin', '2024-06-23 20:45:17', 'admin', '2024-07-07 19:01:20', NULL);
INSERT INTO `tbl_monitor_config` VALUES (4, 'sql数统计', '1', 'sqlCount', 'mysql', '', 4, 'admin', '2024-06-23 20:46:24', 'admin', '2024-07-07 19:46:39', NULL);
INSERT INTO `tbl_monitor_config` VALUES (5, '主备状态', '0', 'msStatus', 'mysql', '', 5, 'admin', '2024-06-23 20:49:07', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (6, '连接数', '0', 'connCount', 'oracle', '', 0, 'admin', '2024-10-12 14:39:01', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (7, '主备状态', '0', 'msStatus', 'oracle', '', 0, 'admin', '2024-10-12 14:45:47', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (8, '连接数', '0', 'connCount', 'oceanbase', '', 0, 'admin', '2024-10-12 14:46:28', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (9, '主备状态', '0', 'msStatus', 'oceanbase', '', 0, 'admin', '2024-10-12 14:46:54', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (10, '连接数', '0', 'connCount', 'dameng', '', 0, 'admin', '2024-10-12 14:47:16', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (11, '主备状态', '0', 'msStatus', 'dameng', '', 0, 'admin', '2024-10-12 14:47:34', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (12, '连接数', '0', 'connCount', 'tidb', '', 0, 'admin', '2024-10-12 14:48:37', 'admin', '2024-10-12 14:49:16', NULL);
INSERT INTO `tbl_monitor_config` VALUES (13, '主备状态', '0', 'msStatus', 'tidb', '', 0, 'admin', '2024-10-12 14:49:45', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (14, '连接数', '0', 'connCount', 'gbase', '', 0, 'admin', '2024-10-12 14:50:02', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (15, '主备状态', '0', 'msStatus', 'gbase', '', 0, 'admin', '2024-10-12 14:50:30', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (16, '连接数', '0', 'connCount', 'postgresql', '', 0, 'admin', '2024-10-12 14:52:30', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (17, '主备状态', '0', 'msStatus', 'postgresql', '', 0, 'admin', '2024-10-12 14:52:50', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (18, '连接数', '0', 'connCount', 'polardb', '', 0, 'admin', '2024-10-12 14:53:15', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (19, '主备状态', '0', 'msStatus', 'polardb', '', 0, 'admin', '2024-10-12 14:53:36', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (20, '连接数', '0', 'connCount', 'opengauss', '', 0, 'admin', '2024-10-12 14:54:16', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (21, '主备状态', '0', 'msStatus', 'opengauss', '', 0, 'admin', '2024-10-12 14:54:40', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (22, '连接数', '0', 'connCount', 'kingbase', '', 0, 'admin', '2024-10-12 14:55:08', NULL, NULL, NULL);
INSERT INTO `tbl_monitor_config` VALUES (23, '主备状态', '0', 'msStatus', 'kingbase', '', 0, 'admin', '2024-10-12 14:55:35', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_monitor_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_monitor_log`;
CREATE TABLE IF NOT EXISTS `tbl_monitor_log`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '监控日志ID',
  `db_id` int(4) NULL DEFAULT NULL COMMENT '数据库资产ID',
  `monitor_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标代码',
  `monitor_data` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控数据',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据单位',
  `time` datetime NULL DEFAULT NULL COMMENT '数据时间',
  `monitor_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 468 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_monitor_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_monitor_log_his
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_monitor_log_his`;
CREATE TABLE IF NOT EXISTS `tbl_monitor_log_his`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '监控日志ID',
  `db_id` int(4) NULL DEFAULT NULL COMMENT '数据库资产ID',
  `monitor_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标代码',
  `monitor_data` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控数据',
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据单位',
  `time` datetime NULL DEFAULT NULL COMMENT '数据时间',
  `monitor_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控指标名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 583681 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_monitor_log_his
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_monitor_obj
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_monitor_obj`;
CREATE TABLE IF NOT EXISTS `tbl_monitor_obj`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '监控对象ID',
  `obj_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象名称',
  `time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_onsite_inspection
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_onsite_inspection`;
CREATE TABLE IF NOT EXISTS `tbl_onsite_inspection`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '巡检项ID',
  `inspec_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '巡检描述',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `sql_script` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '巡检脚本',
  `sort` int(3) NULL DEFAULT NULL COMMENT '顺序',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0 有效 1无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_onsite_inspection
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_report_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_report_config`;
CREATE TABLE IF NOT EXISTS `tbl_report_config`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '报表ID',
  `prod_type` int(1) NULL DEFAULT NULL COMMENT '产生方式0手动1自动',
  `rep_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `rep_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表生成时间',
  `rep_period` int(1) NULL DEFAULT NULL COMMENT '周期：0天1周2月',
  `rep_type` int(1) NULL DEFAULT NULL COMMENT '报表类型1安全告警2审计日志3系统日志4数据库告警5用户访问',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0启动 1关闭',
  `timeStr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间区间',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员',
  `level` int(1) NULL DEFAULT NULL COMMENT '安全等级0低1中2高',
  `search_cond` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '搜索内容',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `rep_cycle_value` int(4) NULL DEFAULT NULL COMMENT '报告周期值',
  `report_uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表唯一码',
  `job_id` int(10) NULL DEFAULT NULL COMMENT '系统任务ID',
  `whitelist` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP白名单',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_report_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_report_data
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_report_data`;
CREATE TABLE IF NOT EXISTS `tbl_report_data`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '报表数据ID',
  `report_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表唯一码',
  `report_item_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '报表类容',
  `report_title` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '报表题头',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6299 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_report_data
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_report_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_report_log`;
CREATE TABLE IF NOT EXISTS `tbl_report_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '报表日志ID',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `task_id` int(10) NULL DEFAULT NULL COMMENT '报表配置ID',
  `task_starttime` datetime NULL DEFAULT NULL COMMENT '报表开始时间',
  `task_endtime` datetime NULL DEFAULT NULL COMMENT '报表结束时间',
  `task_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '知行结果',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表唯一码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_report_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_security_detail
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_security_detail`;
CREATE TABLE IF NOT EXISTS `tbl_security_detail`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `security_id` int(10) NULL DEFAULT NULL COMMENT '安全策略表头ID',
  `security_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全策略明细内容json格式',
  `security_name` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全策略明细ID',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `security_id`(`security_id`, `security_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_security_rule
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_security_rule`;
CREATE TABLE IF NOT EXISTS `tbl_security_rule`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '内置安全规则ID',
  `rule_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则表述',
  `db_type` int(1) NULL DEFAULT NULL COMMENT '数据库类型',
  `rule_case` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则案例',
  `rule_reg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则正则表达式',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0启用1禁用',
  `rule_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 111 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_security_rule
-- ----------------------------
INSERT INTO `tbl_security_rule` VALUES (1, '创建表时AUTO_INCREMENT设置为0则自增从1开始，避免数据空洞。另外在导出表结构DDL时，表结构内AUTO_INCREMENT通常为当前的自增值，通过该DDL进行建表操作会导致自增值从一个无意义数字开始。建议自增ID统一从1开始', 1, '错误示例：\r\nCREATE TABLE tbl (a int) AUTO_INCREMENT = 10;', NULL, 1, '表的初始AUTO_INCREMENT值不为0');
INSERT INTO `tbl_security_rule` VALUES (2, '通过该规则约束全局的数据库排序规则，避免创建非预期的数据库排序规则，防止业务侧出现排序结果非预期等问题。建议项目内库表使用统一的字符集和字符集排序，部分连表查询的情况下字段的字符集或排序规则不一致可能会导致索引失效且不易发现（MySQL 8.0.19版本及以上支持）', 1, '正确示例：\r\nCREATE DATABASE test DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;\r\n错误示例：\r\nCREATE DATABASE test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;', NULL, 1, '建议使用规定的数据库排序规则');
INSERT INTO `tbl_security_rule` VALUES (3, '在SQL_MODE严格模式下BLOB 和 TEXT 类型无法设置默认值，如插入数据不指定值，字段会被设置为NULL', 1, '错误示例：\r\nCREATE TABLE tbl (a blob default \"1\");', NULL, 1, 'BLOB 和 TEXT 类型的字段不可指定非 NULL 的默认值');
INSERT INTO `tbl_security_rule` VALUES (4, 'BLOB 或 TEXT 类型消耗大量的网络和IO带宽，同时在该表上的DML操作都会变得很慢', 1, '错误示例：\r\n\r\nCREATE TABLE tbl (a blob);', NULL, 1, '不建议使用 BLOB 或 TEXT 类型');
INSERT INTO `tbl_security_rule` VALUES (5, 'BLOB 和 TEXT 类型的字段无法指定默认值，如插入数据不指定字段默认为NULL，如果添加了 NOT NULL 限制，写入数据时又未对该字段指定值会导致写入失败', 1, '错误示例：\r\nCREATE TABLE tbl (a blob not null);', NULL, 1, 'BLOB 和 TEXT 类型的字段不建议设置为 NOT NULL');
INSERT INTO `tbl_security_rule` VALUES (6, 'varchar是变长字段，存储空间小，可节省存储空间，同时相对较小的字段检索效率显然也要高些', 1, '错误示例：\r\nCREATE TABLE tbl (a char(21));', NULL, 1, 'char长度大于20时，必须使用varchar类型');
INSERT INTO `tbl_security_rule` VALUES (7, 'ENUM类型不是SQL标准，移植性较差，后期如修改或增加枚举值需重建整张表，代价较大，且无法通过字面量值进行排序', 1, '错误示例：\r\nCREATE TABLE tbl (a enum(\"a\",\"b\"));', NULL, 1, '不建议使用 ENUM 类型');
INSERT INTO `tbl_security_rule` VALUES (8, '过度的宽表，会造成数据的大量冗余，后期对性能影响很大；具体规则阈值可根据业务需求调整，默认值：40', 1, '最大列：40', NULL, 1, '表中包含有太多的列');
INSERT INTO `tbl_security_rule` VALUES (9, '主建中的列过多，会导致二级索引占用更多的空间，同时增加索引维护的开销；具体规则阈值可根据业务需求调整，默认值：2', 1, '正确示例：\r\n\r\nCREATE TABLE tbl (a int, b int, c int, primary key(a,b));\r\n错误示例：\r\nCREATE TABLE tbl (a int, b int, c int, primary key(a,b,c));', NULL, 1, '主键中的列过多');
INSERT INTO `tbl_security_rule` VALUES (10, '集合的修改需要重新定义列，后期修改的代价大，建议在业务层实现', 1, '错误示例：\r\nCREATE TABLE tbl (a set(\"a\",\"b\"));', NULL, 1, '不建议使用 SET 类型');
INSERT INTO `tbl_security_rule` VALUES (11, '\r\ntimestamp添加默认值，可避免出现全为0的日期格式与业务预期不符', 1, '错误示例：\r\nCREATE TABLE tbl (a timestamp);', NULL, 1, 'timestamp 类型的列必须添加默认值');
INSERT INTO `tbl_security_rule` VALUES (12, '\r\nINT(M) 或 BIGINT(M)，M 表示最大显示宽度，可存储最大值的宽度分别为10、20，采用 INT(10) 或 BIGINT(20)可避免发生显示截断的可能', 1, '错误示例：\r\n\r\nCREATE TABLE tbl (a int(9));', NULL, 1, '整型定义建议采用 INT(10) 或 BIGINT(20)');
INSERT INTO `tbl_security_rule` VALUES (13, '自定义函数，维护较差，且依赖性高会导致SQL无法跨库使用', 1, '错误示例：\r\nCREATE FUNCTION func() RETURNS INT DETERMINISTIC RETURN 1;', NULL, 1, '禁止创建自定义函数');
INSERT INTO `tbl_security_rule` VALUES (14, '\r\n存储过程在一定程度上会使程序难以调试和拓展，各种数据库的存储过程语法相差很大，给将来的数据库移植带来很大的困难，且会极大的增加出现BUG的概率', 1, '错误示例：\r\nCREATE PROCEDURE proc() BEGIN SELECT 1; END;', NULL, 1, '禁止创建存储过程');
INSERT INTO `tbl_security_rule` VALUES (15, '\r\n使用CREATE_TIME字段，有利于问题查找跟踪和检索数据，同时避免后期对数据生命周期管理不便 ，默认值为CURRENT_TIMESTAMP可保证时间的准确性', 1, '正确示例：\r\nCREATE TABLE tbl (a int, create_time timestamp default CURRENT_TIMESTAMP);\r\n错误示例：\r\nCREATE TABLE tbl (a int);', NULL, 1, '建表DDL必须包含创建时间字段且默认值为CURRENT_TIMESTAMP');
INSERT INTO `tbl_security_rule` VALUES (16, '触发器难以开发和维护，不能高效移植，且在复杂的逻辑以及高并发下，容易出现死锁影响业务', 1, '', NULL, 1, '禁止创建触发器');
INSERT INTO `tbl_security_rule` VALUES (17, '视图的查询性能较差，同时基表结构变更，需要对视图进行维护，如果视图可读性差且包含复杂的逻辑，都会增加维护的成本', 1, '错误示例：\r\nCREATE VIEW view_name AS SELECT * FROM tbl;', NULL, 1, '禁止使用视图');
INSERT INTO `tbl_security_rule` VALUES (18, '通过配置该规则可以规范指定业务的数据库命名规则，具体命名规范可以自定义设置，默认提示值：_DB', 1, '正确示例：\r\nCREATE DATABASE users_db;\r\n错误示例：\r\nCREATE DATABASE users;', NULL, 1, '数据库名称必须使用固定后缀结尾');
INSERT INTO `tbl_security_rule` VALUES (19, '\r\n对于浮点数运算，DECIMAL精确度较高', 1, '正确示例：\r\nCREATE TABLE tbl (a decimal(10,2));\r\n错误示例：\r\nCREATE TABLE tbl (a float);', NULL, 1, '精确浮点数建议使用DECIMAL');
INSERT INTO `tbl_security_rule` VALUES (20, '\r\n如存在not null且不带默认值的字段，insert时不包含该字段，会导致插入报错', 1, '正确示例：\r\nCREATE TABLE tbl (a int not null default 0);\r\n错误示例：\r\nCREATE TABLE tbl (a int not null);', NULL, 1, '字段约束为not null时必须带默认值');
INSERT INTO `tbl_security_rule` VALUES (21, '\r\n建议开启此规则，可避免MySQL会将中文全角引号识别为命名的一部分，执行结果与业务预期不符\r\n', 1, '', NULL, 1, '检测DDL语句中是否使用了中文全角引号');
INSERT INTO `tbl_security_rule` VALUES (22, '创建约束前，先行创建索引，约束可作用于二级索引，避免全表扫描，提高性能', 1, '', NULL, 1, '建议创建约束前,先行创建索引');
INSERT INTO `tbl_security_rule` VALUES (23, 'blob类型属于大字段类型，作为索引会占用很大的存储空间', 1, '', NULL, 1, '禁止将blob类型的列加入索引');
INSERT INTO `tbl_security_rule` VALUES (24, '\r\n在表上建立的每个索引都会增加存储开销，索引对于插入、删除、更新操作也会增加处理上的开销，太多与不充分、不正确的索引对性能都毫无益处；具体规则阈值可以根据业务需求调整，默认值：5', 1, '最大索引个数 ：5', NULL, 1, '索引个数建议不超过阈值');
INSERT INTO `tbl_security_rule` VALUES (25, '\r\n选择区分度高的字段作为索引，可快速定位数据；区分度太低，无法有效利用索引，甚至可能需要扫描大量数据页，拖慢SQL；具体规则阈值可以根据业务需求调整，默认值：70', 1, '可选择性（百分比） ：70', NULL, 1, '建议选择可选性超过阈值字段作为索引');
INSERT INTO `tbl_security_rule` VALUES (26, '通过配置该规则可以规范指定业务的索引命名规则，具体命名规范可以自定义设置，默认提示值：idx_', 1, '正确示例：\r\nCREATE TABLE tbl (a int, index idx_tpl_a(a(10)));\r\n错误示例：\r\nCREATE TABLE tbl (a int, index tpl_a(a(10)));', NULL, 1, '普通索引必须使用固定前缀');
INSERT INTO `tbl_security_rule` VALUES (27, '\r\n在有单字段索引的情况下，过多的复合索引，一般都是没有存在价值的；相反，还会降低数据增加删除时的性能，特别是对频繁更新的表来说，负面影响更大；具体规则阈值可以根据业务需求调整，默认值：2', 1, '单字段的索引数最大值 ：2', NULL, 1, '检查DDL创建的新索引对应字段是否已存在过多索引');
INSERT INTO `tbl_security_rule` VALUES (28, '\r\nLIMIT M,N当偏移量m过大的时候，查询效率会很低，因为MySQL是先查出m+n个数据，然后抛弃掉前m个数据；对于有大数据量的mysql表来说，使用LIMIT分页存在很严重的性能问题', 1, '正确示例：\r\nSELECT * FROM tbl LIMIT 10 OFFSET 100000;\r\n错误示例：\r\nSELECT * FROM tbl LIMIT 100000,10;', NULL, 1, '使用LIMIT分页时,避免使用LIMIT M,N');
INSERT INTO `tbl_security_rule` VALUES (29, '数据库对象命名规范，不推荐采用大小写混用的形式建议词语之间使用下划线连接，提高代码可读性', 1, '正确示例：\r\nCREATE TABLE tbl (a int);\r\n错误示例：\r\nCREATE TABLE tBL(a int);', NULL, 1, '数据库对象命名不建议大小写字母混合');
INSERT INTO `tbl_security_rule` VALUES (30, '通过配置该规则可以规范指定业务的对象命名长度，具体长度可以自定义设置，默认最大长度：64。是MySQL规定标识符命名最大长度为64字节', 1, '最大长度（字节） ：64', NULL, 1, '表名、列名、索引名的长度不能大于指定字节');
INSERT INTO `tbl_security_rule` VALUES (31, '\r\n通过配置该规则可以规范指定业务的数据对象命名规则', 1, '正确示例：\r\nCREATE TABLE tbl_en(a int);\r\n错误示例：\r\nCREATE TABLE tbl_中文(a int);', NULL, 1, '数据库对象命名只能使用英文、下划线或数字，首字母必须是英文');
INSERT INTO `tbl_security_rule` VALUES (32, '通过配置该规则可以规范指定业务的数据对象命名规则，避免发生冲突，以及混淆', 1, '', NULL, 1, '数据库对象命名禁止使用保留字');
INSERT INTO `tbl_security_rule` VALUES (33, '通过配置该规则可以规范指定业务的主键命名规则', 1, '正确示例：\r\nCREATE TABLE tbl(a int,PRIMARY KEY pk_tpl());\r\n错误示例：\r\nCREATE TABLE tbl(a int,PRIMARY KEY (a));', NULL, 1, '建议主键命名为\"PK_表名\"');
INSERT INTO `tbl_security_rule` VALUES (34, '主键使数据达到全局唯一，可提高数据检索效率', 1, '正确示例：\r\nCREATE TABLE tbl(a int,PRIMARY KEY(a));\r\n错误示例：\r\nCREATE TABLE tbl(a int);', NULL, 1, '表必须有主键');
INSERT INTO `tbl_security_rule` VALUES (35, '自增主键，数字型速度快，而且是增量增长，占用空间小，更快速的做数据插入操作，避免增加维护索引的开销', 1, '正确示例：\r\nCREATE TABLE tbl(a bigint unsigned AUTO_INCREMENT,PRIMARY KEY(a));\r\n错误示例：\r\nCREATE TABLE tbl(a bigint unsigned,PRIMARY KEY(a));', NULL, 1, '主键建议使用自增');
INSERT INTO `tbl_security_rule` VALUES (36, '\r\nbigint unsigned拥有更大的取值范围，建议开启此规则，避免发生溢出', 1, '正确示例：\r\nCREATE TABLE tbl(a bigint unsigned,PRIMARY KEY(a));\r\n错误示例：\r\nCREATE TABLE tbl(a int,PRIMARY KEY(a));', NULL, 1, '主键建议使用 bigint 无符号类型，即 bigint unsigned');
INSERT INTO `tbl_security_rule` VALUES (37, 'MySQL需要单独维护重复的索引，冗余索引增加维护成本，并且优化器在优化查询时需要逐个进行代价计算，影响查询性能', 1, '', NULL, 1, '检查DDL是否创建冗余的索引');
INSERT INTO `tbl_security_rule` VALUES (38, '通过该规则约束全局的数据库字符集，避免创建非预期的字符集，防止业务侧出现“乱码”等问题。建议项目内库表使用统一的字符集和字符集排序，部分连表查询的情况下字段的字符集或排序规则不一致可能会导致索引失效且不易发现', 1, '数据库字符集 ：utf8mb4', NULL, 1, '必须使用指定数据库字符集');
INSERT INTO `tbl_security_rule` VALUES (39, '\r\n通过配置该规则可以规范指定业务的数据库引擎，具体规则可以自定义设置。默认值是Innodb，Innodb 支持事务，支持行级锁，更好的恢复性，高并发下性能更好', 1, '正确示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=MyISAM DEFAULT CHARSET=utf8;', NULL, 1, '必须使用指定数据库引擎');
INSERT INTO `tbl_security_rule` VALUES (40, '分区表在物理上表现为多个文件，在逻辑上表现为一个表，跨分区查询效率可能更低，建议采用物理分表的方式管理大数据', 1, '', NULL, 1, '不建议使用分区表相关功能');
INSERT INTO `tbl_security_rule` VALUES (41, '\r\n大表执行DDL，耗时较久且负载较高，长时间占用锁资源，会影响数据库性能；具体规则阈值可以根据业务需求调整，默认值：1024', 1, '表空间大小（MB） ：1024', NULL, 1, '检查DDL操作的表是否超过指定数据量');
INSERT INTO `tbl_security_rule` VALUES (42, '表添加注释能够使表的意义更明确，方便日后的维护', 1, '正确示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=\"test\";\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;', NULL, 1, '表建议添加注释');
INSERT INTO `tbl_security_rule` VALUES (43, '新建表如果表已经存在，不添加if not exists create执行SQL会报错，建议开启此规则，避免SQL实际执行报错', 1, '正确示例：\r\nCREATE TABLE IF NOT EXISTS test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;', NULL, 1, '新建表必须加入 if not exists，保证重复执行不报错');
INSERT INTO `tbl_security_rule` VALUES (44, 'RC避免了脏读的现象，但没有解决幻读的问题；使用RR，能避免幻读，但是由于引入间隙锁导致加锁的范围可能扩大，从而会影响并发，还容易造成死锁，所以在大多数业务场景下，幻读出现的机率较少，RC基本上能满足业务需求', 1, '', NULL, 1, '事物隔离级别建议设置成RC');
INSERT INTO `tbl_security_rule` VALUES (45, '通过配置该规则可以规范指定业务的unique索引命名规则', 1, '', NULL, 1, 'unique索引名必须使用 IDX_UK_表名_字段名');
INSERT INTO `tbl_security_rule` VALUES (46, '通过配置该规则可以规范指定业务的unique索引命名规则，具体命名规范可以自定义设置，默认提示值：uniq_', 1, '索引前缀 ：uniq_', NULL, 1, 'unique索引必须使用固定前缀');
INSERT INTO `tbl_security_rule` VALUES (47, '\r\n使用更新时间字段，有利于问题查找跟踪和检索数据，同时避免后期对数据生命周期管理不便 ，默认值为UPDATE_TIME可保证时间的准确性', 1, '正确示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;', NULL, 1, '建表DDL必须包含更新时间字段且默认值为CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP');
INSERT INTO `tbl_security_rule` VALUES (48, '\r\nMySQL建立索引时没有限制索引的大小，索引长度会默认采用的该字段的长度，VARCHAR 定义长度越长建立的索引存储大小越大；具体规则阈值可以根据业务需求调整，默认值：1024', 1, '正确示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(1024) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(1025) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;', NULL, 1, 'VARCHAR 定义长度过长');
INSERT INTO `tbl_security_rule` VALUES (49, '\r\nfirst,after 的alter操作通过Copy Table的方式完成，对业务影响较大', 1, '正确示例：\r\nALTER TABLE test ADD COLUMN name varchar(255) NOT NULL;\r\n错误示例：\r\nALTER TABLE test ADD COLUMN name varchar(255) NOT NULL FIRST;', NULL, 1, 'alter表字段禁止使用first,after');
INSERT INTO `tbl_security_rule` VALUES (50, '\r\nDROP是DDL，数据变更不会写入日志，无法进行回滚；建议开启此规则，避免误删除操作', 1, '正确示例：\r\nDROP INDEX test ON test;\r\n错误示例：\r\nDROP TABLE test;', NULL, 1, '禁止除索引外的drop操作');
INSERT INTO `tbl_security_rule` VALUES (51, '外键在高并发场景下性能较差，容易造成死锁，同时不利于后期维护（拆分、迁移）', 1, '错误示例：\r\nALTER TABLE test ADD CONSTRAINT fk_test FOREIGN KEY (id) REFERENCES test2(id);', NULL, 1, '禁止使用外键');
INSERT INTO `tbl_security_rule` VALUES (52, '\r\nTIMESTAMP 有最大值限制（\"2038-01-19 03:14:07\" UTC），且会时区转换的问题', 1, '正确示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;\r\n错误示例：\r\nCREATE TABLE test ( id int(11) NOT NULL AUTO_INCREMENT, name varchar(255) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8;', NULL, 1, '禁止使用TIMESTAMP字段');
INSERT INTO `tbl_security_rule` VALUES (53, '开启该规则后会自动对大表的DDL操作使用gh-ost 工具进行在线改表；直接对大表进行DDL变更时可能会导致长时间锁表问题，影响业务可持续性。', 1, '启用表空间大小 ：\r\n1024\r\n开始删除socket文件 ：\r\n\r\n结束后删除旧表 ：\r\n\r\n操作前删除旧表 ：\r\n\r\n操作前删除ghost表 ：\r\n\r\n批量写入大小 ：\r\n10\r\n旧表名使用时间戳 ：\r\n\r\ncut-over类型 ：atomic 或  two-step\r\nghost表不创建外键 ：\r\n\r\n跳过外键检查 ：\r\n\r\n是否阿里云RDS ：\r\n\r\n准确统计表行数 ：\r\n\r\n临时表名前缀 ：', NULL, 1, '启用GH-OST进行大表更新');
INSERT INTO `tbl_security_rule` VALUES (54, '业务逻辑与删除列依赖未完全消除，列被删除后可能导致程序异常（无法正常读写）的情况；开启该规则，SQLE将提醒删除列为高危操作', 1, '错误示例：\r\nALTER TABLE test DROP COLUMN name;', NULL, 1, '禁止进行删除列的操作');
INSERT INTO `tbl_security_rule` VALUES (55, '删除已有约束会影响已有业务逻辑；开启该规则，删除外键为高危操作', 1, '错误示例：\r\nALTER TABLE test DROP FOREIGN KEY fk_test;', NULL, 1, '禁止进行删除外键的操作');
INSERT INTO `tbl_security_rule` VALUES (56, '删除已有约束会影响已有业务逻辑；开启该规则，删除主键为高危操作', 1, '错误示例：\r\nALTER TABLE test DROP PRIMARY KEY;', NULL, 1, '禁止进行删除主键的操作');
INSERT INTO `tbl_security_rule` VALUES (57, '修改表的默认字符集，只会影响后续新增的字段，不会修表已有字段的字符集；如需修改整张表所有字段的字符集建议开启此规则', 1, '', NULL, 1, '修改表的默认字符集不会改表各个字段的字符集');
INSERT INTO `tbl_security_rule` VALUES (58, '\r\nrename/change 表名/列名会对线上业务不停机发布造成影响，如需这种操作应当DBA手工干预', 1, '错误示例：\r\nRENAME TABLE test TO test1;', NULL, 1, '禁止使用rename或change对表名字段名进行修改');
INSERT INTO `tbl_security_rule` VALUES (59, '统一字符集可以避免由于字符集转换产生的乱码，不同的字符集进行比较前需要进行转换会造成索引失效', 1, '正确示例：\r\nCREATE TABLE test (id INT, name VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci);\r\n错误示例：\r\nCREATE TABLE test (id INT, name VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci);', NULL, 1, '建议列与表使用同一个字符集');
INSERT INTO `tbl_security_rule` VALUES (60, '\r\n表或列的别名与其真实名称相同, 这样的别名会使得查询更难去分辨', 1, '正确示例：\r\nSELECT id AS id1 FROM test;\r\n错误示例：\r\nSELECT id AS id FROM test;', NULL, 1, '别名不要与表或列的名字相同');
INSERT INTO `tbl_security_rule` VALUES (61, '\r\n避免大事务，以及降低发生回滚对业务的影响；具体规则阈值可以根据业务需求调整，默认值：100', 1, '最大插入行数 ：100', NULL, 1, '单条insert语句，建议批量插入不超过阈值');
INSERT INTO `tbl_security_rule` VALUES (62, '\r\n大数据量的情况下，文件排序意味着SQL性能较低，会增加OS的开销，影响数据库性能', 1, '', NULL, 1, '该查询使用了文件排序');
INSERT INTO `tbl_security_rule` VALUES (63, '大数据量的情况下，临时表意味着SQL性能较低，会增加OS的开销，影响数据库性能', 1, '', NULL, 1, '该查询使用了临时表');
INSERT INTO `tbl_security_rule` VALUES (64, '使用全模糊搜索或左模糊搜索将导致查询无法使用索引，导致全表扫描', 1, '', NULL, 1, '禁止使用全模糊搜索或左模糊搜索');
INSERT INTO `tbl_security_rule` VALUES (65, '\r\n当表结构发生变更，INSERT请求不明确指定列名，会发生插入数据不匹配的情况；建议开启此规则，避免插入结果与业务预期不符', 1, '正确示例：\r\ninsert into t1(c1,c2,c3) values(1,2,3);\r\n错误示例：\r\ninsert into t1 values(1,2,3);', NULL, 1, 'insert 语句必须指定column');
INSERT INTO `tbl_security_rule` VALUES (66, '当IN值过多时，有可能会导致查询进行全表扫描，使得MySQL性能急剧下降；具体规则阈值可以根据业务需求调整，默认值：50', 1, 'in语句参数最大个数 ：50', NULL, 1, 'where条件内in语句中的参数个数不能超过阈值');
INSERT INTO `tbl_security_rule` VALUES (67, 'union会按照字段的顺序进行排序同时去重，union all只是简单的将两个结果合并后就返回，从效率上看，union all 要比union快很多；如果合并的两个结果集中允许包含重复数据且不需要排序时的话，建议开启此规则，使用union all替代union', 1, '', NULL, 1, '建议使用UNION ALL,替代UNION');
INSERT INTO `tbl_security_rule` VALUES (68, 'JOIN字段类型不一致会导致类型不匹配发生隐式准换，建议开启此规则，避免索引失效', 1, '', NULL, 1, 'JOIN字段类型不一致');
INSERT INTO `tbl_security_rule` VALUES (69, '\r\n通过配置该规则可以指定业务中需要禁止使用的内置函数，使用内置函数可能会导致SQL无法走索引或者产生一些非预期的结果。实际需要禁用的函数可通过规则设置', 1, '指定的函数集合（逗号分割） ：sha(),sqrt(),md5()', NULL, 1, '避免使用不必要的内置函数');
INSERT INTO `tbl_security_rule` VALUES (70, '\r\n\"!=\" 是非标准的运算符，\"<>\" 才是SQL中标准的不等于运算符', 1, '正确示例：\r\nselect * from t1 where c1 <> 1;\r\n错误示例：\r\nselect * from t1 where c1 != 1;', NULL, 1, '请使用\"<>\"代替\"!=\"');
INSERT INTO `tbl_security_rule` VALUES (71, '\r\n表关联越多，意味着各种驱动关系组合就越多，比较各种结果集的执行成本的代价也就越高，进而SQL查询性能会大幅度下降；具体规则阈值可以根据业务需求调整，默认值：3', 1, '最大连接表个数 ：3', NULL, 1, '使用JOIN连接表查询建议不超过阈值');
INSERT INTO `tbl_security_rule` VALUES (72, '\r\nselect for update 会对查询结果集中每行数据都添加排他锁，其他线程对该记录的更新与删除操作都会阻塞，在高并发下，容易造成数据库大量锁等待，影响数据库查询性能', 1, '', NULL, 1, '建议避免使用select for update');
INSERT INTO `tbl_security_rule` VALUES (73, '\r\n如果查询的扫描行数很大，可能会导致优化器选择错误的索引甚至不走索引；具体规则阈值可以根据业务需求调整，默认值：1000', 1, '正确示例：\r\nselect * from t1 limit 1000;\r\n错误示例：\r\nselect * from t1;', NULL, 1, 'select 语句必须带limit');
INSERT INTO `tbl_security_rule` VALUES (74, 'ORDER BY 对查询性能影响较大，同时不便于优化维护，建议将排序部分放到业务处理', 1, '正确示例：\r\nselect * from t1;\r\n错误示例：\r\nselect * from t1 order by c1;', NULL, 1, 'select 语句不能有order by');
INSERT INTO `tbl_security_rule` VALUES (75, '\r\n在 MySQL 8.0 之前当 ORDER BY 多个列指定的排序方向不同时将无法使用已经建立的索引。在MySQL8.0 之后可以建立对应的排序顺序的联合索引来优化', 1, '', NULL, 1, 'ORDER BY 语句对多个不同条件使用不同方向的排序无法使用索引');
INSERT INTO `tbl_security_rule` VALUES (76, '字符串前后存在空格将可能导致查询判断逻辑出错，如在MySQL 5.5中\"a\"和\"a \"在查询中被认为是相同的值', 1, '正确示例：\r\nselect * from t1 where c1 = \"a\";\r\n错误示例：\r\nselect * from t1 where c1 = \" a\";', NULL, 1, '引号中的字符串开头或结尾包含空格');
INSERT INTO `tbl_security_rule` VALUES (77, '攻击者通过SQL注入，可未经授权可访问数据库中的数据，存在盗取用户信息，造成用户数据泄露等安全漏洞问题', 1, '', NULL, 1, '发现常见 SQL 注入函数');
INSERT INTO `tbl_security_rule` VALUES (78, '过长的sql可读性较差，难以维护，且容易引发性能问题；具体规则阈值可以根据业务需求调整，默认值：1024', 1, 'SQL最大长度 ：1024', NULL, 1, '单条SQL语句长度超过阈值');
INSERT INTO `tbl_security_rule` VALUES (79, '当前MySQL版本不支持在子查询中进行\"LIMIT & IN/ALL/ANY/SOME\"', 1, '正确示例：\r\nselect * from t1 where c1 in (select c1 from t2);\r\n错误示例：\r\nselect * from t1 where c1 in (select c1 from t2 limit 1);', NULL, 1, '子查询不支持LIMIT');
INSERT INTO `tbl_security_rule` VALUES (80, 'DML操作大表，耗时较久且负载较高，容易影响数据库性能；具体规则阈值可以根据业务需求调整，默认值：1024', 1, '表空间大小（MB） ：1024', NULL, 1, '检查DML操作的表是否超过指定数据量');
INSERT INTO `tbl_security_rule` VALUES (81, '对条件字段做函数操作，可能会破坏索引值的有序性，导致优化器选择放弃走索引，使查询性能大幅度降低', 1, '正确示例：\r\nselect * from t1 where c1 = c2;\r\n错误示例：\r\nselect * from t1 where c1 = abs(c2);', NULL, 1, '避免对条件字段使用函数操作');
INSERT INTO `tbl_security_rule` VALUES (82, '\r\n隐式转化会导致查询有无法命中索引的风险，在高并发、大数据量的情况下，不走索引会使得数据库的查询性能严重下降', 1, '正确示例：\r\nselect * from t1 where c1 = 1;\r\n错误示例：\r\nselect * from t1 where c1 = \"1\";', NULL, 1, '条件字段存在数值和字符的隐式转换');
INSERT INTO `tbl_security_rule` VALUES (83, '使用负向查询，将导致全表扫描，出现慢SQL', 1, '正确示例：\r\nselect * from t1 where c1 = 1;\r\n错误示例：\r\nselect * from t1 where c1 != 2;', NULL, 1, '不建议对条件字段使用负向查询');
INSERT INTO `tbl_security_rule` VALUES (84, '使用 IS NULL 或 IS NOT NULL 可能导致查询放弃使用索引而进行全表扫描', 1, '正确示例：\r\nselect * from t1 where c1 = 1;\r\n错误示例：\r\nselect * from t1 where c1 is null;', NULL, 1, '不建议对条件字段使用 NULL 值判断');
INSERT INTO `tbl_security_rule` VALUES (85, '标量子查询存在多次访问同一张表的问题，执行开销大效率低，可使用left join 替代标量子查询', 1, '正确示例：\r\nselect * from t1 left join t2 on t1.c1 = t2.c1;\r\n错误示例：\r\nselect * from t1 where c1 = (select c1 from t2);', NULL, 1, '避免使用标量子查询');
INSERT INTO `tbl_security_rule` VALUES (86, '\r\n缺少where条件的dml在执行时可能会产生误操作，', 1, '错误示例：\r\ndelete from test', NULL, 1, '禁止使用没有where条件的dml语句');
INSERT INTO `tbl_security_rule` VALUES (87, '\r\ndelete/update 语句使用limit条件将随机选取数据进行删除或者更新，业务无法预期', 1, '正确示例：\r\ndelete from t1 where c1 = 1;\r\n错误示例：\r\ndelete from t1 where c1 = 1 limit 1;', NULL, 1, 'delete/update 语句不能有limit条件');
INSERT INTO `tbl_security_rule` VALUES (88, 'delete/update 存在order by会使用排序，带来无谓的开销', 1, '正确示例：\r\ndelete from t1 where c1 = 1;\r\n错误示例：\r\ndelete from t1 where c1 = 1 order by c2;', NULL, 1, 'delete/update 语句不能有order by');
INSERT INTO `tbl_security_rule` VALUES (89, '当表结构变更时，使用*通配符选择所有列将导致查询行为会发生更改，与业务期望不符；同时select * 中的无用字段会带来不必要的磁盘I/O，以及网络开销，且无法覆盖索引进而回表，大幅度降低查询效率', 1, '正确示例：\r\nselect c1,c2 from t1;\r\n错误示例：\r\nselect * from t1;', NULL, 1, '不建议使用select *');
INSERT INTO `tbl_security_rule` VALUES (90, '通过 explain 的形式将待上线的DML进行SQL是否能正确执行的检查，提前发现语句的错误，提高上线成功率', 1, '', NULL, 1, '使用explain加强预检查能力');
INSERT INTO `tbl_security_rule` VALUES (91, 'DROP/TRUNCATE是DDL，操作立即生效，不会写入日志，所以无法回滚，在执行高危操作之前对数据进行备份是很有必要的', 1, '', NULL, 1, '使用DELETE/DROP/TRUNCATE等操作时注意备份');
INSERT INTO `tbl_security_rule` VALUES (92, '\r\n在5.7中，MySQL默认会对’GROUP BY col1, …’按如下顺序’ORDER BY col1,…’隐式排序，导致产生无谓的排序，带来额外的开销；在8.0中，则不会出现这种情况。如果不需要排序建议显示添加’ORDER BY NULL’', 1, '正确示例：\r\nselect c1 from t1 group by c1 order by null;\r\n错误示例：\r\nselect c1 from t1 group by c1;', NULL, 1, '请为 GROUP BY 显示添加 ORDER BY 条件');
INSERT INTO `tbl_security_rule` VALUES (93, '\r\n查询条件永远非真，这将导致查询无匹配到的结果', 1, '正确示例：\r\nselect c1 from t1 where c1 in (1,2,3);\r\n错误示例：\r\nselect c1 from t1 where c1 in (null);', NULL, 1, '避免使用 IN (NULL) 或者 NOT IN (NULL)');
INSERT INTO `tbl_security_rule` VALUES (94, '\r\n没有ORDER BY的LIMIT会导致非确定性的结果可能与业务需求不符，这取决于执行计划', 1, '正确示例：\r\nselect c1 from t1 order by c1 limit 10;\r\n错误示例：\r\nselect c1 from t1 limit 10;', NULL, 1, '未使用 ORDER BY 的 LIMIT 查询');
INSERT INTO `tbl_security_rule` VALUES (95, '\r\n当某一列的值全是NULL时，COUNT(COL)的返回结果为0，但SUM(COL)的返回结果为NULL，因此使用SUM()时需注意NPE问题（指数据返回NULL）；如业务需避免NPE问题，建议开启此规则', 1, 'select sum(c1) from t1;', NULL, 1, '避免使用 SUM(COL)');
INSERT INTO `tbl_security_rule` VALUES (96, '\r\nTRUNCATE是DLL，数据不能回滚，在没有备份情况下，谨慎使用TRUNCATE', 1, '', NULL, 1, '请谨慎使用TRUNCATE操作');
INSERT INTO `tbl_security_rule` VALUES (97, '\r\nTRUNCATE TABLE 比 DELETE 速度快，且使用的系统和事务日志资源少，同时TRUNCATE后表所占用的空间会被释放，而DELETE后需要手工执行OPTIMIZE才能释放表空间', 1, '正确示例：\r\ntruncate table t1;\r\n错误示例：\r\ndelete from t1;', NULL, 1, '删除全表时建议使用 TRUNCATE 替代 DELETE');
INSERT INTO `tbl_security_rule` VALUES (98, '函数或运算符会导致查询无法利用表中的索引，该查询将会全表扫描，性能较差', 1, '正确示例：\r\nselect c1 from t1 where c1 = c2;\r\n错误示例：\r\nselect c1 from t1 where c1 = abs(c2);', NULL, 1, '应避免在 WHERE 条件中使用函数或其他运算符');
INSERT INTO `tbl_security_rule` VALUES (99, '\r\nGROUP BY 1 表示按第一列进行GROUP BY；在GROUP BY子句中使用数字，而不是表达式或列名称，当查询列顺序改变时，会导致查询逻辑出现问题', 1, '正确示例：\r\nselect c1 from t1 group by c1;\r\n错误示例：\r\nselect c1 from t1 group by 1;', NULL, 1, '不建议对常量进行 GROUP BY');
INSERT INTO `tbl_security_rule` VALUES (100, '\r\n当ORDER BY条件为表达式或函数时会使用到临时表，如果在未指定WHERE或WHERE条件返回的结果集较大时性能会很差', 1, '正确示例：\r\nselect c1 from t1 order by c1;\r\n错误示例：\r\nselect c1 from t1 order by c1 + c2;', NULL, 1, '不建议ORDER BY 的条件为表达式');
INSERT INTO `tbl_security_rule` VALUES (101, '\r\n对于索引字段，放在HAVING子句中时不会走索引；建议将HAVING子句改写为WHERE中的查询条件，可以在查询处理期间使用索引，提高SQL的执行效率', 1, '正确示例：\r\nselect c1 from t1 where c1 > 10 group by c1;\r\n错误示例：\r\nselect c1 from t1 group by c1 having c1 > 10;', NULL, 1, '不建议使用 HAVING 子句');
INSERT INTO `tbl_security_rule` VALUES (102, '当IN值过多时，有可能会导致查询进行全表扫描，使得MySQL性能急剧下降', 1, '', NULL, 1, '尽量不要使用IN');
INSERT INTO `tbl_security_rule` VALUES (103, '不包含通配符的 LIKE 查询逻辑上与等值查询相同，建议使用等值查询替代', 1, '正确示例：\r\nselect c1 from t1 where c1 = \"abc\";\r\n错误示例：\r\nselect c1 from t1 where c1 like \"abc\";', NULL, 1, '不建议使用没有通配符的 LIKE 查询');
INSERT INTO `tbl_security_rule` VALUES (104, '\r\nORDER BY RAND()使用了临时表，同时还要对其进行排序，在数据量很大的情况下会增加服务器负载以及增加查询时间', 1, '正确示例：\r\nselect c1 from t1 order by c1;\r\n错误示例：\r\nselect c1 from t1 order by rand();', NULL, 1, '不建议使用 ORDER BY RAND()');
INSERT INTO `tbl_security_rule` VALUES (105, '有些情况下，子查询并不能使用到索引，同时对于返回结果集比较大的子查询，会产生大量的临时表，消耗过多的CPU和IO资源，产生大量的慢查询', 1, '正确示例：\r\nselect c1 from t1, t2 where t1.c2 = t2.c2 and t1.c1 = t2.c1;\r\n错误示例：\r\nselect c1 from t1 where c1 = (select c1 from t2 where t1.c2 = t2.c2);', NULL, 1, '不推荐使用子查询');
INSERT INTO `tbl_security_rule` VALUES (106, '当SYSDATE()函数在基于statement模式的主从环境下可能造成数据的不一致，因为语句在主库中执行到日志传递到备库，存在时间差，到备库执行的时候就会变成不同的时间值，建议采取row模式的复制环境', 1, '正确示例：\r\nselect c1 from t1 where c1 = now();\r\n错误示例：\r\nselect c1 from t1 where c1 = sysdate();', NULL, 1, '不建议使用 SYSDATE() 函数');
INSERT INTO `tbl_security_rule` VALUES (107, '\r\n主键索引数据列的顺序就是表记录的物理存储顺序，频繁更新主键将导致整个表记录的顺序的调整，会耗费相当大的资源', 1, '正确示例：\r\nupdate t1 set c2 = 2 where id = 1;\r\n错误示例：\r\nupdate t1 set id = 1 where id = 2;', NULL, 1, '不要 UPDATE 主键');
INSERT INTO `tbl_security_rule` VALUES (108, '通过该规则开启索引优化建议，提供两个参数配置来定义索引优化建议的行为。1. 计算列基数阈值：配置当表数据量超过多少行时不再计算列的区分度来排序索引优先级，防止对大表进行操作影响性能；2. 联合索引最大列数：限制联合索引给到的列数最大值，防止给出建议的联合索引不符合其他SQL标准', 1, '计算列基数阈值 ：1000000\r\n联合索引最大列数 ：3', NULL, 1, '索引创建建议');
INSERT INTO `tbl_security_rule` VALUES (109, 'query缺少where条件在执行时会进行全表扫描产生额外开销，建议在大数据量高并发环境下开启，避免影响数据库查询性能', 1, '错误示例：\r\nselect * from test', NULL, 1, '禁止使用没有where条件的query语句');
INSERT INTO `tbl_security_rule` VALUES (110, '启用该规则将对访问的库表元数据进行扫描、检测（比如检查表、列是否存在）', 1, '', NULL, 1, '启用上线审核模式');

-- ----------------------------
-- Table structure for tbl_srcip_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_srcip_log`;
CREATE TABLE IF NOT EXISTS `tbl_srcip_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '源IP日志Id',
  `srcIp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '源IP',
  `time` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_srcip_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_sysinfo_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_sysinfo_config`;
CREATE TABLE IF NOT EXISTS `tbl_sysinfo_config`  (
  `id` int(2) NOT NULL COMMENT '系统信息ID',
  `sysinfo_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统信息名称',
  `sysinfo_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统信息内容',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有效（0有效1无效）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_sysinfo_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_task_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_task_config`;
CREATE TABLE IF NOT EXISTS `tbl_task_config`  (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '任务配置ID',
  `task_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务配置名称',
  `task_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务方式:0自动1手动',
  `task_cycle_unit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务周期单位：0天1周2月3季度4年',
  `task_cycle_value` int(4) NULL DEFAULT NULL COMMENT '任务周期值',
  `task_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动任务时间',
  `isEncrypted` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否加密0加密1不加密',
  `retention_value` int(4) NULL DEFAULT NULL COMMENT '保留周期值',
  `status` int(1) NULL DEFAULT NULL COMMENT '自动任务状态0关闭1开启',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务配置唯一码',
  `job_id` int(10) NULL DEFAULT NULL COMMENT '系统任务ID',
  `whitelist` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP白名单',
  `db_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据资产名称',
  `db_database` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名',
  `task_kind` int(1) NULL DEFAULT NULL COMMENT '任务类别：0巡检任务1权限快照任务2报表任务',
  `temple_id` int(10) NULL DEFAULT NULL COMMENT '巡检报告模板ID',
	`create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_task_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_task_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_task_log`;
CREATE TABLE IF NOT EXISTS `tbl_task_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `task_id` int(4) NULL DEFAULT NULL COMMENT '任务配置ID',
  `task_starttime` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `task_file` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文件',
  `task_oper` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `appId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用的标识',
  `task_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果',
  `task_endtime` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `db_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据资产名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 369 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_task_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_user_log`;
CREATE TABLE IF NOT EXISTS `tbl_user_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户日志ID',
  `userId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `time` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_view_head
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_view_head`;
CREATE TABLE IF NOT EXISTS `tbl_view_head`  (
  `id` int(11) NOT NULL COMMENT '视图ID',
  `view_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图名称',
  `filter_cond` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '查询过滤条件',
  `filter_cond_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '查询过滤条件解释',
  `join_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多表关联类型（0普通1join类）',
  `join_cond` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '关联条件',
  `join_cond_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '关联条件解释',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_view_head
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_view_item
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_view_item`;
CREATE TABLE IF NOT EXISTS `tbl_view_item`  (
  `id` int(10) NOT NULL COMMENT '视图条目ID',
  `view_id` int(10) NULL DEFAULT NULL COMMENT '视图ID',
  `view_item_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图字段名',
  `view_item_desc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '视图字段描述',
  `orderNo` int(3) NULL DEFAULT NULL COMMENT '字段呈现顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_view_item
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_warn_config
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_warn_config`;
CREATE TABLE IF NOT EXISTS `tbl_warn_config`  (
  `id` int(10) NOT NULL COMMENT '告警配置ID',
  `warn_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警标题',
  `warn_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警情形描述',
  `security_level` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全等级（0低1中2高）',
  `warn_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警方式',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（0启用1禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_warn_config
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_warn_type
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_warn_type`;
CREATE TABLE IF NOT EXISTS `tbl_warn_type`  (
  `id` int(10) NOT NULL COMMENT '告警方式ID',
  `warn_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警方式',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开启（0开启1关闭）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_warn_type
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_workorder
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_workorder`;
CREATE TABLE IF NOT EXISTS `tbl_workorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工单名称',
  `type` int(2) NULL DEFAULT NULL COMMENT '工单类型 1SQL工单；2权限工单',
  `applicant` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `auditor` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `reauditor` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '复核人',
  `data_source` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源',
  `terminal_id` int(10) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容，类型为1时是sql语句',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态 0待审核；20审核通过；21审核失败；30复核通过；31复核失败；40执行成功；41执行失败；',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `exectime_type` int(1) NULL DEFAULT NULL COMMENT '执行时间类型 0不限；1时间范围',
  `time_range` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间范围',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标数据库类型',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `db_owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库',
  `is_download` int(11) NULL DEFAULT 0 COMMENT '0否 1是',
  `is_datamask` int(11) NULL DEFAULT 1 COMMENT '0否 1是',
  `job_status` INT NULL DEFAULT 1  COMMENT '0开启 1关闭' ,
  `exe_kind` INT NULL DEFAULT 0  COMMENT '0指定时间 1循环执行' ,
  `task_cycle_unit` CHAR(1) NULL COMMENT '任务周期单位：0天1周2月3季度4年' ,
  `task_cycle_value` INT NULL COMMENT '任务周期值' ,
  `job_id` INT NULL DEFAULT 0  COMMENT '系统任务ID' ,
  `uuid` VARCHAR(255) NULL COMMENT '任务唯一码' ,
  `rollback_type` INT NULL DEFAULT 0  COMMENT '0全任务回滚 1子任务回滚' ,
  `whitelist` VARCHAR(255) NULL COMMENT '任务执行IP白名单' ,
  `task_time` VARCHAR(20) NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_workorder
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_workorder_audit
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_workorder_audit`;
CREATE TABLE IF NOT EXISTS `tbl_workorder_audit`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `work_id` int(10) NULL DEFAULT NULL,
  `db_id` int(10) NULL DEFAULT NULL,
  `terminal_id` int(10) NULL DEFAULT NULL,
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `db_owner` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库',
  `effect_row` int(10) NULL DEFAULT NULL COMMENT '影响行数',
  `exec_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行时间',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行的内容',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态 0待审核；20审核通过；21审核失败；30复核通过；31复核失败；40执行成功；41执行失败；',
  `auditor` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `sql_result` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行结果',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_workorder_audit
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_workorder_log
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_workorder_log`;
CREATE TABLE IF NOT EXISTS `tbl_workorder_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `work_id` int(10) NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL COMMENT '工单类型',
  `opt_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作的IP',
  `opt_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `opt_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情',
  `opt_mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批备注',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_workorder_log
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_workorder_result
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_workorder_result`;
CREATE TABLE IF NOT EXISTS `tbl_workorder_result`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '工单结果条目ID',
  `work_id` int(10) NULL DEFAULT NULL COMMENT '工单Id',
  `sql_type` int(1) NULL DEFAULT NULL COMMENT 'sql语句类型:0更新1查询',
  `result` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sql更新结果',
  `result_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '系统返回消息',
  `download_flag` int(1) NULL DEFAULT NULL COMMENT '下载标记:0不下载1下载',
  `desen_flag` int(1) NULL DEFAULT NULL COMMENT '结果脱敏标记:0脱敏1不脱敏',
  `sql_conts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'sql语句',
  `exec_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_workorder_result
-- ----------------------------


-- ----------------------------
-- Table structure for sys_key
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_key`;
CREATE TABLE IF NOT EXISTS `sys_key`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '密钥ID',
  `sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备序列号',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密钥',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;



-- ----------------------------
-- Table structure for tbl_lang_whitelist
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_lang_whitelist`;
CREATE TABLE IF NOT EXISTS `tbl_lang_whitelist`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'sql命令ID',
  `lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sql命令',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态0有效1无效',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `lang`(`lang`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_lang_whitelist
-- ----------------------------
INSERT INTO `tbl_lang_whitelist` VALUES (1, 'desc', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (2, 'RENAME', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (3, 'REVOKE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (4, 'COMMIT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (5, 'ROLLBACK', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (6, 'SAVEPOINT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (7, 'SET', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (8, 'LOCK', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (9, 'DECLARE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (10, 'EXCEPTION', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (11, 'DBMS_OUTPUT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (12, 'DESCRIBE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (13, 'SPOOL', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (14, 'PROMPT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (15, 'EXIT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (16, 'CONNECT', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (17, 'EXPLAIN', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (18, 'EXEC', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (19, 'FLASHBACK', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (20, 'expdp', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (21, 'impdp', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (22, 'CRSCTL', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (23, 'SRVCTL', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (24, 'olsnodes', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (25, 'LOAD', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (26, 'USE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (27, 'CALL', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (28, 'START', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (29, 'OPTIMIZE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (30, 'FLUSH', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (31, 'KILL', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (32, 'HELP', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (33, 'RESET', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (34, 'REPAIR', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (35, 'BACKUP', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (36, 'RESTORE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (37, 'mysqldump', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (38, 'mysqlimport', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (39, 'mysqlcheck', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (40, 'ADD', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (41, 'STOP', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (42, 'BULK', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (43, 'TRACE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (44, 'SHUTDOWN', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (45, 'STARTUP', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (46, 'RECOVER', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (47, 'DBCC', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (48, 'DENY', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (49, 'SOURCE', '0');
INSERT INTO `tbl_lang_whitelist` VALUES (50, 'CHECK', '0');

-- ----------------------------
-- Table structure for tbl_editor_query_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `tbl_editor_query_history` ( 
  `id` INT AUTO_INCREMENT NOT NULL,
  `created_at` DATETIME NULL,
  `status` CHAR(1) NULL DEFAULT 0  COMMENT '状态 0正常 1删除' ,
  `username` VARCHAR(64) NULL,
  `group_id` VARCHAR(64) NULL,
  `conid` VARCHAR(50) NULL COMMENT 'usernmae_groupId_dbId' ,
  `db_id` VARCHAR(50) NULL,
  `database` VARCHAR(50) NULL,
  `sql` LONGTEXT NULL COMMENT 'sql' ,
  `fingerprint` VARCHAR(100) NULL COMMENT '终端指纹' ,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_editor_saved_file
-- ----------------------------
CREATE TABLE IF NOT EXISTS `tbl_editor_saved_file` ( 
  `id` INT AUTO_INCREMENT NOT NULL,
  `username` VARCHAR(64) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `status` CHAR(1) NULL DEFAULT 0  COMMENT '状态 0正常 1删除' ,
  `file` VARCHAR(250) NULL COMMENT '文件名' ,
  `data` LONGTEXT NULL COMMENT '文件内容' ,
  `folder` VARCHAR(20) NULL COMMENT '文件夹' ,
  `format` VARCHAR(20) NULL COMMENT '格式' ,
  `fingerprint` VARCHAR(100) NULL COMMENT '终端指纹' ,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_terminal
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_terminal`;
CREATE TABLE IF NOT EXISTS `tbl_terminal`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '密钥ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端名称',
  `group_id` int(10) NULL DEFAULT NULL COMMENT '资产分组Id',
  `bounduser_id` text  CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定的用户',
  `boundrole_id` int(10) NULL DEFAULT NULL COMMENT '绑定的角色',
  `host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '远程主机地址(ip或域名)',
  `port` int(10) NULL DEFAULT NULL COMMENT '连接端口(ssh: 22)',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证方式 publickKey,password',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码,如果method为password',
  `privatekey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 私钥,如果method为publicKey',
  `passphrase` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 私钥密码',
  `protocol` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 协议类型 ssh',
  `extraOptions` text  CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 扩展可选项',
   `status` int(1) NULL DEFAULT NULL COMMENT '终端状态0启用 1禁用',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for tbl_group_terminal
-- ----------------------------

CREATE TABLE IF NOT EXISTS `tbl_group_terminal` ( 
  `group_id` INT NOT NULL COMMENT '组ID' ,
  `terminal_id` INT NOT NULL COMMENT '终端ID' ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`group_id`, `terminal_id`)
);


-- ----------------------------
-- Table structure for sys_terminal_log
-- ----------------------------
-- DROP TABLE IF EXISTS `sys_terminal_log`;
CREATE TABLE IF NOT EXISTS `sys_terminal_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,  
  `oper_time` datetime NULL DEFAULT NULL,
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tar_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `terminal_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,  
  `cmd_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,  
  `affect_conts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `command` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL, 
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_terminal_command
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_terminal_command`;
CREATE TABLE IF NOT EXISTS `tbl_terminal_command`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,  
  `group_id` int(10) NULL DEFAULT NULL COMMENT '权限群组',  
  `terminal_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '终端id',  
  `mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '启用方式,默认deny allow, deny',  
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '具体命令', 
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0有效 1无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_terminal_cmdtemplate
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_terminal_cmdtemplate`;
CREATE TABLE IF NOT EXISTS `tbl_terminal_cmdtemplate`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,  
  `command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '具体命令', 
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0有效 1无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tbl_credential
-- ----------------------------
-- DROP TABLE IF EXISTS `tbl_credential`;
CREATE TABLE IF NOT EXISTS `tbl_credential`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,  
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '凭证名称(保持唯一)', 
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'password, ssh_key, api_key,',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态0激活 1禁用',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '用户名', 
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '密码(加密存储)', 
  `private_key` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '私钥(加密存储)', 
  `passphrase` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '私钥密码(加密存储)', 
  `api_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT 'api key(加密存储)', 
  `expires_at` datetime NULL DEFAULT NULL COMMENT '凭证过期时间，默认null,不过期',
  `tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '标签', 
  `metadata` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL  COMMENT '附加信息 json存储',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
