/*
SQLyog v10.2 
MySQL - 5.5.27 : Database - nmjzs
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `ACT_GE_BYTEARRAY` */

DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;

CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_GE_PROPERTY` */

DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;

CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_ACTINST` */

DROP TABLE IF EXISTS `ACT_HI_ACTINST`;

CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_ATTACHMENT` */

DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;

CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_COMMENT` */

DROP TABLE IF EXISTS `ACT_HI_COMMENT`;

CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_DETAIL` */

DROP TABLE IF EXISTS `ACT_HI_DETAIL`;

CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_IDENTITYLINK` */

DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;

CREATE TABLE `ACT_HI_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_PROCINST` */

DROP TABLE IF EXISTS `ACT_HI_PROCINST`;

CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  UNIQUE KEY `ACT_UNIQ_HI_BUS_KEY` (`PROC_DEF_ID_`,`BUSINESS_KEY_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_TASKINST` */

DROP TABLE IF EXISTS `ACT_HI_TASKINST`;

CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_HI_VARINST` */

DROP TABLE IF EXISTS `ACT_HI_VARINST`;

CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_ID_GROUP` */

DROP TABLE IF EXISTS `ACT_ID_GROUP`;

CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_ID_INFO` */

DROP TABLE IF EXISTS `ACT_ID_INFO`;

CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_ID_MEMBERSHIP` */

DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;

CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_ID_USER` */

DROP TABLE IF EXISTS `ACT_ID_USER`;

CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RE_DEPLOYMENT` */

DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;

CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOY_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RE_MODEL` */

DROP TABLE IF EXISTS `ACT_RE_MODEL`;

CREATE TABLE `ACT_RE_MODEL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RE_PROCDEF` */

DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;

CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_EVENT_SUBSCR` */

DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;

CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_EXECUTION` */

DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;

CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_RU_BUS_KEY` (`PROC_DEF_ID_`,`BUSINESS_KEY_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_IDENTITYLINK` */

DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;

CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_JOB` */

DROP TABLE IF EXISTS `ACT_RU_JOB`;

CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_TASK` */

DROP TABLE IF EXISTS `ACT_RU_TASK`;

CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DUE_DATE_` datetime DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ACT_RU_VARIABLE` */

DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;

CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `cms_article` */

DROP TABLE IF EXISTS `cms_article`;

CREATE TABLE `cms_article` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `link` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章链接',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章图片',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述、摘要',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `posid` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '推荐位，多选',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_article_create_by` (`create_by`),
  KEY `cms_article_title` (`title`),
  KEY `cms_article_keywords` (`keywords`),
  KEY `cms_article_del_flag` (`del_flag`),
  KEY `cms_article_weight` (`weight`),
  KEY `cms_article_update_date` (`update_date`),
  KEY `cms_article_category_id` (`category_id`),
  KEY `cms_article_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文章表';

/*Table structure for table `cms_article_data` */

DROP TABLE IF EXISTS `cms_article_data`;

CREATE TABLE `cms_article_data` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `content` text COLLATE utf8_bin COMMENT '文章内容',
  `copyfrom` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章来源',
  `relation` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '相关文章',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  PRIMARY KEY (`id`),
  KEY `cms_article_data_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文章详表';

/*Table structure for table `cms_category` */

DROP TABLE IF EXISTS `cms_category`;

CREATE TABLE `cms_category` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `site_id` varchar(64) COLLATE utf8_bin DEFAULT '1' COMMENT '站点编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `module` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目模块',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '栏目名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在导航中显示',
  `in_list` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在分类页中显示列表',
  `show_modes` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '展现方式',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否需要审核',
  `custom_list_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义列表视图',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  PRIMARY KEY (`id`),
  KEY `cms_category_parent_id` (`parent_id`),
  KEY `cms_category_parent_ids` (`parent_ids`(255)),
  KEY `cms_category_module` (`module`),
  KEY `cms_category_name` (`name`),
  KEY `cms_category_sort` (`sort`),
  KEY `cms_category_del_flag` (`del_flag`),
  KEY `cms_category_office_id` (`office_id`),
  KEY `cms_category_site_id` (`site_id`),
  KEY `cms_category_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='栏目表';

/*Table structure for table `cms_comment` */

DROP TABLE IF EXISTS `cms_comment`;

CREATE TABLE `cms_comment` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `content_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目内容的编号',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目内容的标题',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '评论内容',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论姓名',
  `ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论IP',
  `create_date` datetime NOT NULL COMMENT '评论时间',
  `audit_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_comment_category_id` (`category_id`),
  KEY `cms_comment_content_id` (`content_id`),
  KEY `cms_comment_status` (`del_flag`),
  KEY `cms_comment_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='评论表';

/*Table structure for table `cms_guestbook` */

DROP TABLE IF EXISTS `cms_guestbook`;

CREATE TABLE `cms_guestbook` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '留言分类',
  `content` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '留言内容',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `phone` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '电话',
  `workunit` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '单位',
  `ip` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '留言时间',
  `re_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '回复人',
  `re_date` datetime DEFAULT NULL COMMENT '回复时间',
  `re_content` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '回复内容',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_guestbook_del_flag` (`del_flag`),
  KEY `cms_site_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='留言板';

/*Table structure for table `cms_link` */

DROP TABLE IF EXISTS `cms_link`;

CREATE TABLE `cms_link` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '链接名称',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接地址',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_link_category_id` (`category_id`),
  KEY `cms_link_title` (`title`),
  KEY `cms_link_del_flag` (`del_flag`),
  KEY `cms_link_weight` (`weight`),
  KEY `cms_link_create_by` (`create_by`),
  KEY `cms_link_update_date` (`update_date`),
  KEY `cms_link_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='友情链接';

/*Table structure for table `cms_site` */

DROP TABLE IF EXISTS `cms_site`;

CREATE TABLE `cms_site` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点名称',
  `title` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点标题',
  `logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点Logo',
  `domain` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点域名',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `theme` varchar(255) COLLATE utf8_bin DEFAULT 'default' COMMENT '主题',
  `copyright` text COLLATE utf8_bin COMMENT '版权信息',
  `custom_index_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义站点首页视图',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_site_del_flag` (`del_flag`),
  KEY `cms_site_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='站点表';

/*Table structure for table `jxjycase` */

DROP TABLE IF EXISTS `jxjycase`;

CREATE TABLE `jxjycase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xm` varchar(50) DEFAULT NULL,
  `zjhm` varchar(50) DEFAULT NULL,
  `zcbh` varchar(50) DEFAULT NULL,
  `zylb` varchar(50) DEFAULT NULL,
  `hgzbh` varchar(50) DEFAULT NULL,
  `qfrq` datetime DEFAULT NULL,
  `bxxs` int(11) DEFAULT NULL,
  `xxxs` int(11) DEFAULT NULL,
  `gzdw` varchar(50) DEFAULT NULL,
  `pxsjq` datetime DEFAULT NULL,
  `pxsjz` datetime DEFAULT NULL,
  `zhgxsj` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0  未审核 1初审  2审核完毕',
  `pass` varchar(50) DEFAULT NULL,
  `createBy` varchar(50) DEFAULT NULL,
  `creaetDate` datetime DEFAULT NULL,
  `updateBy` varchar(11) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2079 DEFAULT CHARSET=utf8;

/*Table structure for table `jxjycasecims` */

DROP TABLE IF EXISTS `jxjycasecims`;

CREATE TABLE `jxjycasecims` (
  `id` int(11) NOT NULL DEFAULT '0',
  `xm` varchar(50) DEFAULT NULL,
  `zjhm` varchar(50) DEFAULT NULL,
  `zcbh` varchar(50) DEFAULT NULL,
  `zylb` varchar(50) DEFAULT NULL,
  `hgzbh` varchar(50) DEFAULT NULL,
  `qfrq` datetime DEFAULT NULL,
  `bxxs` int(11) DEFAULT NULL,
  `xxxs` int(11) DEFAULT NULL,
  `gzdw` varchar(50) DEFAULT NULL,
  `pxsjq` datetime DEFAULT NULL,
  `pxsjz` datetime DEFAULT NULL,
  `zhgxsj` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0  未审核 1初审  2审核完毕',
  `pass` varchar(50) DEFAULT NULL,
  `createBy` varchar(50) DEFAULT NULL,
  `creaetDate` datetime DEFAULT NULL,
  `updateBy` varchar(11) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `jxjycasesafty` */

DROP TABLE IF EXISTS `jxjycasesafty`;

CREATE TABLE `jxjycasesafty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xm` varchar(50) DEFAULT NULL,
  `zjhm` varchar(50) DEFAULT NULL,
  `zcbh` varchar(50) DEFAULT NULL,
  `zylb` varchar(50) DEFAULT NULL,
  `hgzbh` varchar(50) DEFAULT NULL,
  `qfrq` datetime DEFAULT NULL,
  `bxxs` int(11) DEFAULT NULL,
  `xxxs` int(11) DEFAULT NULL,
  `gzdw` varchar(50) DEFAULT NULL,
  `pxsjq` datetime DEFAULT NULL,
  `pxsjz` datetime DEFAULT NULL,
  `zhgxsj` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0  未审核 1初审  2审核完毕',
  `pass` varchar(50) DEFAULT NULL,
  `createBy` varchar(50) DEFAULT NULL,
  `creaetDate` datetime DEFAULT NULL,
  `updateBy` varchar(11) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_HGZBH` (`hgzbh`)
) ENGINE=InnoDB AUTO_INCREMENT=5230 DEFAULT CHARSET=utf8;

/*Table structure for table `oa_leave` */

DROP TABLE IF EXISTS `oa_leave`;

CREATE TABLE `oa_leave` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `process_instance_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例编号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `leave_type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '请假类型',
  `reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请假理由',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `reality_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `reality_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  `process_status` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '流程状态',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_leave_create_by` (`create_by`),
  KEY `oa_leave_process_instance_id` (`process_instance_id`),
  KEY `oa_leave_del_flag` (`del_flag`),
  KEY `oa_leave_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='请假流程表';

/*Table structure for table `prj_project` */

DROP TABLE IF EXISTS `prj_project`;

CREATE TABLE `prj_project` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `root_package` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '包名',
  `erm_path` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '数据文件路径',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`),
  KEY `prj_project_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='项目';

/*Table structure for table `sequence` */

DROP TABLE IF EXISTS `sequence`;

CREATE TABLE `sequence` (
  `name` varchar(50) NOT NULL,
  `current_value` int(11) NOT NULL,
  `increment` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `serv_ac_base` */

DROP TABLE IF EXISTS `serv_ac_base`;

CREATE TABLE `serv_ac_base` (
  `SERVID` int(11) NOT NULL COMMENT '服务编号',
  `AC_ID` varchar(64) DEFAULT NULL COMMENT '注册编号',
  `NAME` varchar(100) DEFAULT NULL COMMENT '姓名',
  `SEX` varchar(6) DEFAULT NULL COMMENT '性别',
  `NOTION` varchar(6) DEFAULT NULL COMMENT '民族',
  `BIRTH_DATE` date DEFAULT NULL COMMENT '出生日期',
  `ID_TYPE` varchar(6) DEFAULT NULL COMMENT '证件类型',
  `ID_NO` varchar(32) DEFAULT NULL COMMENT '证件号码',
  `GARD_SCHOOL` varchar(64) DEFAULT NULL COMMENT '毕业院校',
  `GARD_DATE` date DEFAULT NULL COMMENT '毕业时间',
  `GARD_MAJOR` varchar(32) DEFAULT NULL COMMENT '毕业专业',
  `DEGREE` varchar(32) DEFAULT NULL COMMENT '学历',
  `EDUCATION` varchar(64) DEFAULT NULL COMMENT '学位',
  `MOBILE_PHONE` varchar(32) DEFAULT NULL COMMENT '移动电话',
  `MAIL` varchar(64) DEFAULT NULL COMMENT '电子邮箱',
  `ECONOMIC_TYPE` varchar(6) DEFAULT NULL COMMENT '经济类型',
  `REGISTER_ADDR` varchar(2048) DEFAULT NULL COMMENT '注册地址',
  `LEG_PERSON` varchar(128) DEFAULT NULL COMMENT '企业法人',
  `CONTACT_PERSON` varchar(32) DEFAULT NULL COMMENT '联系人',
  `COMPANY_TYPE` varchar(6) DEFAULT NULL COMMENT '01 施工单位 02 建设单位 03 建筑业施工企业  04 监理企业 05 造价咨询机构 06 招标代理机构 07 工程质量检测企业 08  建筑工程材料企业 09 房地产开发企业 10 房地产评估企业 11 房地产经纪机构 12 物业管理企业 13 房屋拆迁企业 14 测绘机构 15 检测单位 16 协会 17 其它',
  `COMPANY_OPIN` varchar(2048) DEFAULT NULL COMMENT '企业意见',
  `EMPLOYEE` varchar(32) DEFAULT NULL COMMENT '受聘人名称',
  `CONTRACT_START_DATE` date DEFAULT NULL COMMENT '合同开始日期',
  `CONTRACT_END_DATE` date DEFAULT NULL COMMENT '合同结束日期',
  `COMPANY` varchar(64) DEFAULT NULL COMMENT '工作单位',
  `SIGN_DATE` date DEFAULT NULL COMMENT '签章日期',
  `CHECK_CODE` varchar(6) DEFAULT NULL COMMENT '校验码',
  `PATH_ID` varchar(512) DEFAULT NULL COMMENT '路径编号，关联路径表',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `STS` char(1) NOT NULL COMMENT '申请主表：状态 0 保存 1 提交 2 完成 3 撤销 4注销 5 返销. 证书主表：0 有效 1 失效',
  `STS_DATE` date NOT NULL COMMENT '状态时间',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注',
  KEY `IDX_SERVID` (`SERVID`),
  KEY `IDX_RSRV_STR3` (`RSRV_STR3`),
  KEY `IDX_ID_NO` (`ID_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='建造师-基本信息服务表';

/*Table structure for table `serv_attachment` */

DROP TABLE IF EXISTS `serv_attachment`;

CREATE TABLE `serv_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `servid` int(11) NOT NULL COMMENT '申请编号',
  `app_id` varchar(6) NOT NULL COMMENT '模块',
  `so_type` varchar(6) NOT NULL COMMENT '业务类型',
  `content_type` varchar(255) DEFAULT NULL COMMENT '类型',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '最后修改时间',
  `name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `new_filename` varchar(255) DEFAULT NULL COMMENT '新文件名',
  `size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `thumbnail_filename` varchar(255) DEFAULT NULL COMMENT '缩略图文件名',
  `thumbnail_size` bigint(20) DEFAULT NULL COMMENT '缩略图文件大小',
  `pass` char(1) DEFAULT NULL COMMENT '是否通过',
  `pass_user_id` varchar(64) DEFAULT NULL COMMENT '审核人',
  `pass_date` datetime DEFAULT NULL COMMENT '审核时间',
  `path` varchar(255) DEFAULT NULL COMMENT '存储路径',
  `sts` char(1) DEFAULT NULL COMMENT '状态 0-提交未审核 1-提交已审核',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `IDX_SERVID` (`servid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `serv_path` */

DROP TABLE IF EXISTS `serv_path`;

CREATE TABLE `serv_path` (
  `SERVID` int(11) NOT NULL COMMENT '服务编号',
  `PATH_ID` varchar(512) DEFAULT NULL COMMENT '路径编号，关联路径表',
  `PATH` varchar(5124) DEFAULT NULL COMMENT '路径',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `STS` char(1) NOT NULL COMMENT '申请主表：状态 0 保存 1 提交 2 完成 3 撤销 4注销 5 返销. 证书主表：0 有效 1 失效',
  `STS_DATE` date NOT NULL COMMENT '状态时间',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件路径信息服务表';

/*Table structure for table `serv_print` */

DROP TABLE IF EXISTS `serv_print`;

CREATE TABLE `serv_print` (
  `SERVID` int(11) NOT NULL COMMENT '服务编号',
  `CONTENT` varchar(8000) DEFAULT NULL COMMENT '内容',
  `PRINT_STAFF_ID` varchar(6) DEFAULT NULL COMMENT '打证人',
  `PRINT_STS` varchar(6) DEFAULT NULL COMMENT '打证状态 0 未打印  1 已打印',
  `PRINT_DATE` date DEFAULT NULL COMMENT '打证时间',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务打证信息表';

/*Table structure for table `so_attachment` */

DROP TABLE IF EXISTS `so_attachment`;

CREATE TABLE `so_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `soid` varchar(64) NOT NULL COMMENT '申请编号',
  `app_id` varchar(64) NOT NULL COMMENT '模块',
  `so_type` varchar(64) NOT NULL COMMENT '业务类型',
  `content_type` varchar(255) DEFAULT NULL COMMENT '类型',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '最后修改时间',
  `name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `new_filename` varchar(255) DEFAULT NULL COMMENT '新文件名',
  `size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `thumbnail_filename` varchar(255) DEFAULT NULL COMMENT '缩略图文件名',
  `thumbnail_size` bigint(20) DEFAULT NULL COMMENT '缩略图文件大小',
  `pass` char(1) DEFAULT NULL COMMENT '是否通过',
  `pass_user_id` varchar(64) DEFAULT NULL COMMENT '审核人',
  `pass_date` datetime DEFAULT NULL COMMENT '审核时间',
  `path` varchar(5124) DEFAULT NULL COMMENT '存储路径',
  `sts` char(1) DEFAULT NULL COMMENT '状态 0-提交未审核 1-提交已审核',
  PRIMARY KEY (`id`),
  KEY `IDX_SOID` (`soid`)
) ENGINE=InnoDB AUTO_INCREMENT=879906 DEFAULT CHARSET=utf8;

/*Table structure for table `so_audit` */

DROP TABLE IF EXISTS `so_audit`;

CREATE TABLE `so_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `soid` varchar(64) NOT NULL,
  `audit_type` char(1) DEFAULT NULL COMMENT '0-发票审核 1-学时减免审核 2-学时审核 3-考试审核',
  `audit_tag` char(1) DEFAULT NULL COMMENT '审核标记',
  `audit_by` varchar(64) DEFAULT NULL COMMENT '审核人',
  `audit_level` char(1) DEFAULT NULL COMMENT '0-初审 1-复审 2-终审',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_info` varchar(255) DEFAULT NULL COMMENT '审核信息',
  `rsrv_str1` varchar(255) DEFAULT NULL,
  `rsrv_str2` varchar(255) DEFAULT NULL,
  `rsrv_str3` varchar(255) DEFAULT NULL,
  `sts` char(1) DEFAULT NULL,
  `sts_date` datetime DEFAULT NULL,
  `so_hours_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15264 DEFAULT CHARSET=utf8;

/*Table structure for table `so_course` */

DROP TABLE IF EXISTS `so_course`;

CREATE TABLE `so_course` (
  `soid` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请流水',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请用户编码',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程编码',
  `apply_date` datetime DEFAULT NULL COMMENT '申请时间',
  `start_date` datetime DEFAULT NULL COMMENT '开始学习时间',
  `finish_date` datetime DEFAULT NULL COMMENT '完成时间',
  `exp_date` date DEFAULT NULL COMMENT '失效时间',
  `audit_tag` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '审核标记',
  `valid` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '可用标记：0-不可用 1-可用',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `so_exam_detail` */

DROP TABLE IF EXISTS `so_exam_detail`;

CREATE TABLE `so_exam_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `soid` varchar(64) NOT NULL,
  `ExaminfoId` int(9) NOT NULL,
  `QuestionId` bigint(9) DEFAULT NULL,
  `UserAnswer` varchar(10) DEFAULT NULL,
  `IsCorrect` bigint(2) DEFAULT NULL,
  `userid` varchar(64) NOT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `rsrv_str1` varchar(255) DEFAULT NULL,
  `rsrv_str2` varchar(255) DEFAULT NULL,
  `rsrv_str3` varchar(255) DEFAULT NULL,
  `sts` char(1) NOT NULL DEFAULT '0',
  `sts_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2230 DEFAULT CHARSET=utf8;

/*Table structure for table `so_exam_info` */

DROP TABLE IF EXISTS `so_exam_info`;

CREATE TABLE `so_exam_info` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `soid` varchar(64) NOT NULL,
  `userId` varchar(64) NOT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `profession` varchar(20) NOT NULL,
  `p_type` varchar(20) NOT NULL,
  `StartTime` varchar(20) DEFAULT NULL,
  `EndTime` varchar(20) DEFAULT NULL,
  `questionTotals` varchar(10) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `RequireTime` int(5) NOT NULL,
  `cores` varchar(6) DEFAULT NULL,
  `exam_type` varchar(1) NOT NULL DEFAULT '0',
  `pass_tag` varchar(6) DEFAULT NULL,
  `audit_tag` char(1) DEFAULT NULL,
  `audit_level` varchar(6) DEFAULT NULL,
  `audit_by` varchar(64) DEFAULT NULL,
  `audit_date` datetime DEFAULT NULL,
  `rsrv_str1` varchar(255) DEFAULT NULL,
  `rsrv_str2` varchar(255) DEFAULT NULL,
  `rsrv_str3` varchar(255) DEFAULT NULL,
  `sts` char(1) NOT NULL DEFAULT '0',
  `sts_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1615 DEFAULT CHARSET=utf8;

/*Table structure for table `so_exam_info_again` */

DROP TABLE IF EXISTS `so_exam_info_again`;

CREATE TABLE `so_exam_info_again` (
  `id` int(20) NOT NULL,
  `soid` varchar(64) NOT NULL,
  `userId` varchar(64) NOT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `profession` varchar(20) DEFAULT NULL,
  `p_type` varchar(20) DEFAULT NULL,
  `StartTime` varchar(20) DEFAULT NULL,
  `EndTime` varchar(20) DEFAULT NULL,
  `questionTotals` varchar(10) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `RequireTime` int(5) DEFAULT NULL,
  `cores` varchar(6) DEFAULT NULL,
  `exam_type` varchar(1) NOT NULL DEFAULT '1',
  `pass_tag` varchar(6) DEFAULT NULL,
  `audit_tag` char(1) DEFAULT NULL,
  `audit_level` varchar(6) DEFAULT NULL,
  `audit_by` varchar(64) DEFAULT NULL,
  `audit_date` datetime DEFAULT NULL,
  `rsrv_str1` varchar(255) DEFAULT NULL,
  `rsrv_str2` varchar(255) DEFAULT NULL,
  `rsrv_str3` varchar(255) DEFAULT NULL,
  `sts` char(1) DEFAULT '0',
  `sts_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `so_hours` */

DROP TABLE IF EXISTS `so_hours`;

CREATE TABLE `so_hours` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `soid` varchar(64) NOT NULL COMMENT '申请流水',
  `user_id` varchar(64) NOT NULL COMMENT '用户编码',
  `type` char(1) NOT NULL COMMENT '类型：0-减免申请 1-课程学时',
  `plan_id` bigint(20) DEFAULT NULL COMMENT '计划编码',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程编码',
  `lesson_id` bigint(20) DEFAULT NULL COMMENT '课件编码',
  `hours` double DEFAULT NULL COMMENT 'type为0时为减免学时，1时为课程学时',
  `video_time` int(11) DEFAULT NULL COMMENT '课件时长',
  `played_time` int(11) DEFAULT NULL COMMENT '实际时长',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `audit_tag` char(1) DEFAULT NULL COMMENT '审核标记',
  `audit_level` varchar(6) DEFAULT NULL COMMENT '审核环节',
  `audit_by` varchar(64) DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `company_name` varchar(255) DEFAULT NULL COMMENT '执业单位',
  `reduce_reason` varchar(255) DEFAULT NULL COMMENT '减免原因',
  `cert_no` varchar(200) DEFAULT NULL COMMENT '继续教育证书编号',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注：具体情况说明',
  `rsrv_str1` varchar(255) DEFAULT NULL,
  `rsrv_str2` varchar(255) DEFAULT NULL,
  `rsrv_str3` varchar(255) DEFAULT NULL,
  `sts` char(1) NOT NULL,
  `sts_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_SO_HOURS_SOID` (`soid`),
  KEY `IDX_SO_HOURS_USERID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8925 DEFAULT CHARSET=utf8;

/*Table structure for table `so_invoice` */

DROP TABLE IF EXISTS `so_invoice`;

CREATE TABLE `so_invoice` (
  `soid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '申请流水',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请用户编码',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '发票抬头',
  `apply_date` datetime DEFAULT NULL COMMENT '申请时间',
  `fee` float DEFAULT NULL COMMENT '发票金额',
  `contact_phone` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `contact_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `post_code` varchar(6) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `post_address` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '邮寄地址',
  `company_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '公司名称',
  `remark` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `audit_tag` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '审核标记',
  `audit_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_info` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '审核信息',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`soid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `so_lesson` */

DROP TABLE IF EXISTS `so_lesson`;

CREATE TABLE `so_lesson` (
  `soid` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请流水',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请用户编码',
  `lesson_id` bigint(20) DEFAULT NULL COMMENT '课程编码',
  `create_date` datetime DEFAULT NULL COMMENT '申请时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始播放时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成播放时间',
  `video_time` int(11) DEFAULT NULL COMMENT '课件总时长',
  `played_time` int(11) DEFAULT NULL COMMENT '实际播放时长',
  `img_num` int(11) DEFAULT NULL COMMENT '抓取图片数',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `so_main_cert` */

DROP TABLE IF EXISTS `so_main_cert`;

CREATE TABLE `so_main_cert` (
  `soid` varchar(64) NOT NULL COMMENT '申请编号',
  `servid` int(20) NOT NULL COMMENT '服务编号',
  `company_id` int(11) NOT NULL COMMENT '企业编码',
  `cert_type` varchar(6) NOT NULL COMMENT '1 安全合格证 2 安全许可证 3 一级建造师 4 二级建造师 5 一级临时建造师 6 二级临时建造师 7 企业资质证书',
  `cert_no` varchar(64) DEFAULT NULL COMMENT '证书编号',
  `eff_date` date DEFAULT NULL COMMENT '首次批准资质时间',
  `exp_date` date DEFAULT NULL COMMENT '失效期',
  `issue_by` varchar(64) DEFAULT NULL COMMENT '发证单位',
  `issue_date` datetime DEFAULT NULL COMMENT '发证时间',
  `rsrv_str1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `rsrv_str2` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `rsrv_str3` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `cert_sts` varchar(6) NOT NULL DEFAULT '1' COMMENT '证书状态1待分配 2取消分配 0 已分配',
  `cert_date` date DEFAULT NULL COMMENT '状态时间',
  `sts` char(1) NOT NULL DEFAULT '0' COMMENT '申请主表：状态 0 保存 1 提交 2 完成 3 撤销 4注销 5 返销. 证书主表：0 有效 1 失效',
  `sts_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `so_path` */

DROP TABLE IF EXISTS `so_path`;

CREATE TABLE `so_path` (
  `SOID` varchar(64) DEFAULT NULL COMMENT '申请编号，16位编码',
  `ACT_TYPE` char(1) DEFAULT NULL COMMENT '动作类型，申请单子表的操作方式。1 新增 2 删除 3 变更 ',
  `PATH_ID` varchar(512) DEFAULT NULL COMMENT '路径编号，关联路径表',
  `SEQ` int(11) DEFAULT NULL COMMENT '序号',
  `PATH` varchar(5124) DEFAULT NULL COMMENT '路径',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='一个模块，一个子表下会存在多个文件上传，需要将文件路径通过该表统一管理，通过PATH_ID与相关表关联';

/*Table structure for table `so_pay` */

DROP TABLE IF EXISTS `so_pay`;

CREATE TABLE `so_pay` (
  `soId` varchar(64) NOT NULL COMMENT '申报单号',
  `user_id` varchar(64) NOT NULL COMMENT '用户编号',
  `pay_Id` varchar(64) NOT NULL COMMENT '支付流水',
  `fee_type` varchar(64) NOT NULL DEFAULT '100' COMMENT '费用类型',
  `fee` float NOT NULL COMMENT '费用',
  `create_date` datetime NOT NULL COMMENT '支付时间',
  `rsp_code` varchar(32) DEFAULT NULL COMMENT '支付返回状态 0 初始状态 1 返回成功 2返回失败',
  `rsp_desc` varchar(255) DEFAULT NULL COMMENT '支付返回描述',
  `rsp_date` datetime DEFAULT NULL COMMENT '支付返回时间',
  `audit_tag` char(1) DEFAULT NULL COMMENT '审核状态',
  `audit_by` varchar(64) DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `rsrv_str1` varchar(255) DEFAULT NULL COMMENT '扩展字段1',
  `rsrv_str2` varchar(255) DEFAULT NULL COMMENT '扩展字段2',
  `rsrv_str3` varchar(255) DEFAULT NULL COMMENT '扩展字段3',
  `sts` char(1) NOT NULL COMMENT '0 有效 1 作废',
  `sts_date` datetime NOT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `so_plan` */

DROP TABLE IF EXISTS `so_plan`;

CREATE TABLE `so_plan` (
  `soid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '申请流水',
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '申请用户编码',
  `company_id` int(11) DEFAULT NULL COMMENT '所属企业',
  `plan_id` bigint(20) NOT NULL COMMENT '计划编码',
  `apply_date` datetime NOT NULL COMMENT '申请时间',
  `finish_date` datetime DEFAULT NULL COMMENT '完成时间',
  `exp_date` date DEFAULT NULL COMMENT '失效时间',
  `fee_id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '收费流水',
  `fee` float DEFAULT NULL COMMENT '收费金额',
  `fee_state` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '收费状态 0-未收费 1-已收费',
  `hour_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '学时状态 0-未通过 1-已通过',
  `learn_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '学习状态 0-未完成 1-已完成',
  `exam_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '考试状态 0-未通过 1-已通过',
  `cert_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '证书状态 0-未领取 1-已领取',
  `reduce_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '减免标志 0-不减免 1-减免',
  `local_id` int(6) NOT NULL COMMENT '地市编码',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '扩展字段1',
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '扩展字段2',
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT '0' COMMENT '扩展字段3',
  `ofline_user` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `ofline_no` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `ofline_remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ofline_path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ofline_sts` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  `ofline_sts_date` datetime DEFAULT NULL,
  `ofline_audit_by` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin NOT NULL COMMENT '状态',
  `sts_date` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`soid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `sys_area` */

DROP TABLE IF EXISTS `sys_area`;

CREATE TABLE `sys_area` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '区域名称',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_parent_ids` (`parent_ids`(255)),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

/*Table structure for table `sys_batch` */

DROP TABLE IF EXISTS `sys_batch`;

CREATE TABLE `sys_batch` (
  `batch_id` varchar(32) DEFAULT NULL,
  `BATCH_TYPE` varchar(6) NOT NULL COMMENT '0 申报批次 1 公示批次 2 其他批次',
  `BATCH_NAME` varchar(64) NOT NULL COMMENT '批次名',
  `BATCH_YEAR` int(11) NOT NULL COMMENT '批次年度',
  `BATCH_MONTH` int(11) NOT NULL COMMENT '批次月份',
  `BATCH_SEQ` int(3) NOT NULL COMMENT '序号要求四位数字',
  `BEGIN_NO` int(11) DEFAULT NULL COMMENT '批次区间始',
  `END_NO` int(11) DEFAULT NULL COMMENT '批次区间末',
  `APP_ID` varchar(6) NOT NULL COMMENT '业务模块，EQ 企业资质  OC一级建造师 AC二级建造师  TC临时建造师 CP三类人员 SE安全许可 SD示范工地  FR外进企业',
  `COMPANY_ID` int(11) NOT NULL COMMENT '企业编码',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATE_DATE` date DEFAULT NULL COMMENT '更新时间',
  `DELETE_BY` varchar(32) DEFAULT NULL COMMENT '删除人',
  `DELETE_DATE` datetime DEFAULT NULL COMMENT '删除时间',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `STS` varchar(6) NOT NULL COMMENT '状态',
  `STS_DATE` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-批次信息表';

/*Table structure for table `sys_config` */

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `CONFIG_ID` int(11) DEFAULT NULL COMMENT '系统配置编号',
  `CONFIG_TYPE` varchar(6) DEFAULT NULL COMMENT '系统配置类型 00 系统配置 01 业务配置',
  `CONFIG_ITEM_CODE` varchar(1024) DEFAULT NULL COMMENT '配置项编号，英文缩写编号如CP_RES',
  `CONFIG_ITEM_VALUE` varchar(1024) DEFAULT NULL COMMENT '配置项值',
  `CONFIG_ITEM_NAME` varchar(128) DEFAULT NULL COMMENT '配置项名称',
  `OPEN_FLAG` varchar(1) DEFAULT NULL COMMENT '0 打开 1关闭',
  `CONFIG_ITEM_DESC` varchar(512) DEFAULT NULL COMMENT '配置项描述',
  `APP_ID` varchar(6) DEFAULT NULL COMMENT '业务模块，EQ 企业资质  OC一级建造师 AC二级建造师  TC临时建造师 CP三类人员 SE安全许可 SD示范工地  FR外进企业',
  `PROVINCE_ID` varchar(6) DEFAULT NULL COMMENT '省分',
  `LOCAL_ID` int(11) DEFAULT NULL COMMENT '地级市',
  `AREA_ID` int(11) DEFAULT NULL COMMENT '地级市下级县区',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  `DELETE_BY` varchar(32) DEFAULT NULL COMMENT '删除人',
  `DELETE_DATE` datetime DEFAULT NULL COMMENT '删除时间',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-系统配置表';

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `params` text COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text COLLATE utf8_bin COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='日志表';

/*Table structure for table `sys_mdict` */

DROP TABLE IF EXISTS `sys_mdict`;

CREATE TABLE `sys_mdict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_parent_ids` (`parent_ids`(255)),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多级字典表';

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '菜单名称',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `is_show` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否在菜单中显示',
  `is_activiti` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否同步工作流',
  `permission` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_parent_ids` (`parent_ids`(255)),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜单表';

/*Table structure for table `sys_office` */

DROP TABLE IF EXISTS `sys_office`;

CREATE TABLE `sys_office` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `area_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属区域',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '机构名称',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构类型',
  `grade` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构等级',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '传真',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_parent_ids` (`parent_ids`(255)),
  KEY `sys_office_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='机构表';

/*Table structure for table `sys_print_template` */

DROP TABLE IF EXISTS `sys_print_template`;

CREATE TABLE `sys_print_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `cert_type` varchar(12) DEFAULT NULL,
  `so_type` varchar(12) DEFAULT NULL,
  `page_num` int(11) DEFAULT NULL,
  `index_item` int(6) DEFAULT NULL,
  `para_type` varchar(300) DEFAULT NULL,
  `para_num` int(6) DEFAULT NULL,
  `para_name` varchar(1200) DEFAULT NULL,
  `para_code1` varchar(1500) DEFAULT NULL,
  `para_code2` varchar(1500) DEFAULT NULL,
  `para_code3` varchar(1500) DEFAULT NULL,
  `para_code4` varchar(1500) DEFAULT NULL,
  `para_code5` varchar(1500) DEFAULT NULL,
  `para_code6` varchar(1500) DEFAULT NULL,
  `para_code7` varchar(1500) DEFAULT NULL,
  `para_code8` varchar(1500) DEFAULT NULL,
  `para_code9` varchar(1500) DEFAULT NULL,
  `para_code10` varchar(1500) DEFAULT NULL,
  `sts` char(3) DEFAULT NULL,
  `remark` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='打印模板配置表';

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `data_scope` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '数据范围',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-菜单';

/*Table structure for table `sys_role_office` */

DROP TABLE IF EXISTS `sys_role_office`;

CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-机构';

/*Table structure for table `sys_tag` */

DROP TABLE IF EXISTS `sys_tag`;

CREATE TABLE `sys_tag` (
  `TAG_CODE` varchar(64) DEFAULT NULL,
  `TAG_NAME` varchar(255) DEFAULT NULL,
  `TAG_CHAR` char(1) DEFAULT NULL,
  `TAG_INFO` varchar(255) DEFAULT NULL,
  `TAG_USE` char(1) DEFAULT NULL COMMENT '开关0-打开 非0关闭',
  `PROVINCE_ID` varchar(6) DEFAULT NULL COMMENT '省分 ZZ:通配',
  `LOCAL_ID` int(11) DEFAULT NULL COMMENT '地级市 -1:通配',
  `AREA_ID` int(11) DEFAULT NULL COMMENT '地级市下级县区 -1:通配',
  `CREATE_BY` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_BY` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-TAG表';

/*Table structure for table `sys_tree_menu` */

DROP TABLE IF EXISTS `sys_tree_menu`;

CREATE TABLE `sys_tree_menu` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '编号',
  `app_id` varchar(6) NOT NULL COMMENT '模块',
  `so_type` varchar(6) NOT NULL COMMENT '业务类型',
  `parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '栏目模块',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '栏目名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '1' COMMENT '是否在导航中显示',
  `in_list` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '1' COMMENT '是否在分类页中显示列表',
  `show_modes` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0' COMMENT '展现方式',
  `allow_comment` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '是否需要审核',
  `office_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `site_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '1' COMMENT '站点编号',
  `custom_list_view` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义列表视图',
  `custom_content_view` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  `view_config` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '视图配置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `company_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `local_id` int(11) DEFAULT NULL COMMENT '地市',
  `user_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `login_ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  `user_company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';

/*Table structure for table `sys_user_bak` */

DROP TABLE IF EXISTS `sys_user_bak`;

CREATE TABLE `sys_user_bak` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '编号',
  `company_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `no` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `local_id` int(11) NOT NULL COMMENT '地市',
  `user_type` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `login_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  `user_company_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户-角色';

/*Table structure for table `sys_user_role_bak` */

DROP TABLE IF EXISTS `sys_user_role_bak`;

CREATE TABLE `sys_user_role_bak` (
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_answer` */

DROP TABLE IF EXISTS `t_answer`;

CREATE TABLE `t_answer` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `questionId` int(20) DEFAULT NULL,
  `answer` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_idx_1` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=23605 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Table structure for table `t_company` */

DROP TABLE IF EXISTS `t_company`;

CREATE TABLE `t_company` (
  `COMPANY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '企业编码',
  `COMPANY_NAME` varchar(256) NOT NULL COMMENT '企业名称',
  `COMPANY_TYPE` varchar(6) DEFAULT NULL COMMENT '01 施工单位 02 建设单位 03 建筑业施工企业  04 监理企业 05 造价咨询机构 06 招标代理机构 07 工程质量检测企业 08  建筑工程材料企业 09 房地产开发企业 10 房地产评估企业 11 房地产经纪机构 12 物业管理企业 13 房屋拆迁企业 14 测绘机构 15 检测单位 16 协会 17 其它',
  `ORG_CODE` varchar(32) DEFAULT NULL COMMENT '组织机构登记号',
  `TAX_NO` varchar(128) DEFAULT NULL COMMENT '税务登记证号',
  `LICENCE_NO` varchar(32) DEFAULT NULL COMMENT '营业执照号',
  `ECONOMIC_TYPE` varchar(6) DEFAULT NULL COMMENT '经济类型',
  `QUAL_LEVEL` varchar(6) DEFAULT NULL COMMENT '资质等级',
  `QUAL_TYPE` varchar(6) DEFAULT NULL COMMENT '资质类别',
  `QUAL_CERT_NO` varchar(64) DEFAULT NULL COMMENT '资质证书编号',
  `LEG_PERSON` varchar(128) DEFAULT NULL COMMENT '企业法人',
  `LEG_ID_TYPE` varchar(6) DEFAULT NULL COMMENT '法人证件类型',
  `LEG_NO` varchar(32) DEFAULT NULL COMMENT '法人证件号码',
  `REGISTER_TYPE` varchar(6) DEFAULT NULL COMMENT '注册类型：01 国有企业 02 集体企业 03 私营企业 04 有限责任公司 05 外商企业 06 港澳台企业 07 个体工商户 08  个人独资企业 09 合伙企业 ',
  `REGISTER_ADDR` varchar(2048) DEFAULT NULL COMMENT '注册地址',
  `REGISTER_CAPITAL` varchar(32) DEFAULT NULL COMMENT '注册资本',
  `EFF_DATE` date DEFAULT NULL COMMENT '首次批准资质时间',
  `EXP_DATE` date DEFAULT NULL COMMENT '失效期',
  `ADDRESS` varchar(2048) DEFAULT NULL COMMENT '地址信息',
  `POST_CODE` varchar(6) DEFAULT NULL,
  `CONTACT_PERSON` varchar(32) DEFAULT NULL COMMENT '联系人',
  `CONTACT_PHONE` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `FAX` varchar(20) DEFAULT NULL COMMENT '传真电话',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `PROFILE` varchar(4096) DEFAULT NULL COMMENT '简介',
  `PORTAL_CODE` varchar(2048) DEFAULT NULL COMMENT '企业网址',
  `PROVINCE_ID` varchar(6) NOT NULL COMMENT '省分',
  `LOCAL_ID` int(11) NOT NULL COMMENT '地级市',
  `AREA_ID` int(11) DEFAULT NULL COMMENT '地级市下级县区',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注',
  `STS` char(1) NOT NULL COMMENT '申请主表：状态 0 保存 1 提交 2 完成 3 撤销 4注销 5 返销. 证书主表：0 有效 1 失效',
  `STS_DATE` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`COMPANY_ID`),
  KEY `IDX_COMPANY_NAME` (`COMPANY_NAME`(255)),
  KEY `IDX_LOCAL_ID` (`LOCAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000095 DEFAULT CHARSET=utf8 COMMENT='统一维护网上办事大厅所有企业相关信息';

/*Table structure for table `t_course` */

DROP TABLE IF EXISTS `t_course`;

CREATE TABLE `t_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL,
  `course_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `plan_id` bigint(20) NOT NULL,
  `major_id` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_type` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_hours` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `teacher_id` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `teacher_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `teacher_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `size` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `path` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `image` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `RSRV_STR1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STS` char(1) COLLATE utf8_bin NOT NULL,
  `STS_DATE` datetime DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_course_center` */

DROP TABLE IF EXISTS `t_course_center`;

CREATE TABLE `t_course_center` (
  `course_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `major_id` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_type` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_hours` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `course_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `teacher_id` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `teacher_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `teacher_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `size` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `path` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `image` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `RSRV_STR1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STS` char(1) COLLATE utf8_bin DEFAULT NULL,
  `STS_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_course_lesson` */

DROP TABLE IF EXISTS `t_course_lesson`;

CREATE TABLE `t_course_lesson` (
  `lesson_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '课节编码',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程编码',
  `lesson_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '课节名称',
  `lesson_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT '课节介绍',
  `pay_tag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '是否付费0-未付费 1-已付费',
  `watch_times` int(11) DEFAULT NULL COMMENT '观看次数',
  `file_type` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '文件类型',
  `file_url` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '文件URL',
  `play_time` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '播放时间',
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `show_index` int(11) DEFAULT '1' COMMENT '展示顺序',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_lesson` */

DROP TABLE IF EXISTS `t_lesson`;

CREATE TABLE `t_lesson` (
  `lesson_id` bigint(20) NOT NULL COMMENT '课件编号',
  `lesson_name` varchar(1024) NOT NULL COMMENT '课件名称',
  `plan_id` bigint(20) NOT NULL COMMENT '计划编号',
  `major_id` varchar(32) NOT NULL COMMENT '课程专业',
  `lesson_type` varchar(6) NOT NULL COMMENT '课程类型 0公共课 1公共课 2选修课',
  `lesson_hours` varchar(6) NOT NULL COMMENT '课程学时',
  `lesson_info` varchar(5124) DEFAULT NULL COMMENT '课程介绍',
  `teacher_id` varchar(32) DEFAULT NULL COMMENT '主讲老师编号',
  `teacher_name` varchar(64) DEFAULT NULL COMMENT '主讲老师姓名',
  `teacher_info` varchar(5124) DEFAULT NULL COMMENT '主讲老师信息',
  `size` varchar(32) NOT NULL COMMENT '课件大小',
  `type` varchar(32) NOT NULL COMMENT '课件型号',
  `path` varchar(1024) NOT NULL COMMENT '课件路径',
  `image` varchar(32) DEFAULT NULL COMMENT '课件缩略图',
  `image_path` varchar(1024) DEFAULT NULL COMMENT '课件缩略图路径',
  `up_date` date DEFAULT NULL COMMENT '上传时间',
  `up_user_id` varchar(12) DEFAULT NULL COMMENT '上传人',
  `modify_date` date DEFAULT NULL COMMENT '修改时间',
  `modify_user_id` varchar(12) DEFAULT NULL COMMENT '修改人',
  `del_date` date DEFAULT NULL COMMENT '删除时间',
  `del_user_id` varchar(12) DEFAULT NULL COMMENT '删除人',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `STS` char(1) NOT NULL COMMENT '生效状态 0 生效 1 时效',
  `STS_DATE` datetime NOT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_plan` */

DROP TABLE IF EXISTS `t_plan`;

CREATE TABLE `t_plan` (
  `plan_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `plan_type` varchar(5) COLLATE utf8_bin NOT NULL,
  `major_id` varchar(32) COLLATE utf8_bin NOT NULL,
  `plan_hours` varchar(10) COLLATE utf8_bin NOT NULL,
  `charge_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `charge` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `audit_sts` char(1) COLLATE utf8_bin DEFAULT NULL,
  `audit_date` datetime DEFAULT NULL,
  `year` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `month` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `day` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `local_id` int(6) DEFAULT NULL,
  `create_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `RSRV_STR1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RSRV_STR3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STS` char(1) COLLATE utf8_bin NOT NULL,
  `STS_DATE` datetime NOT NULL,
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10034 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_question` */

DROP TABLE IF EXISTS `t_question`;

CREATE TABLE `t_question` (
  `answer` varchar(20) DEFAULT NULL,
  `questionId` int(20) DEFAULT NULL,
  `id` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_question_lib` */

DROP TABLE IF EXISTS `t_question_lib`;

CREATE TABLE `t_question_lib` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `profession` varchar(20) DEFAULT NULL,
  `QuestionStyle` varchar(20) DEFAULT NULL,
  `type_que` varchar(20) DEFAULT NULL,
  `question` varchar(5124) DEFAULT NULL,
  `delFlag` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2156 DEFAULT CHARSET=utf8;

/*Table structure for table `t_question_lib_copy` */

DROP TABLE IF EXISTS `t_question_lib_copy`;

CREATE TABLE `t_question_lib_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `style` bigint(1) DEFAULT NULL,
  `levels` bigint(1) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `Answer` varchar(10) DEFAULT NULL,
  `delFlag` bigint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_question_lib_sub` */

DROP TABLE IF EXISTS `t_question_lib_sub`;

CREATE TABLE `t_question_lib_sub` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `questionId` int(20) NOT NULL,
  `question_choice` varchar(200) NOT NULL,
  `index_sub` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionsub_idx_1` (`questionId`)
) ENGINE=InnoDB AUTO_INCREMENT=19592 DEFAULT CHARSET=utf8;

/*Table structure for table `t_seal` */

DROP TABLE IF EXISTS `t_seal`;

CREATE TABLE `t_seal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',
  `local_id` varchar(64) NOT NULL COMMENT '本地网',
  `seal_id` varchar(64) NOT NULL COMMENT '公章ID',
  `seal_name` varchar(255) DEFAULT NULL COMMENT '公章名字',
  `content_type` varchar(255) DEFAULT NULL COMMENT '类型',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '最后修改时间',
  `name` varchar(255) DEFAULT NULL COMMENT '图片文件名',
  `thumbnail_name` varchar(255) DEFAULT NULL COMMENT '缩略图文件名',
  `path` varchar(255) DEFAULT NULL COMMENT '存储路径',
  `sts` char(1) DEFAULT NULL COMMENT '状态 0-有效 1-失效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=263648 DEFAULT CHARSET=utf8;

/*Table structure for table `t_serv` */

DROP TABLE IF EXISTS `t_serv`;

CREATE TABLE `t_serv` (
  `SERVID` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务编号',
  `USER_ID` varchar(64) NOT NULL COMMENT '用户编码',
  `COMPANY_ID` int(11) DEFAULT NULL COMMENT '企业编码',
  `APP_ID` varchar(6) NOT NULL COMMENT '业务模块，EQ 企业资质  OC一级建造师 AC二级建造师  TC临时建造师 CP三类人员 SE安全许可 SD示范工地  FR外进企业',
  `PROVINCE_ID` varchar(6) NOT NULL COMMENT '省分',
  `LOCAL_ID` int(11) NOT NULL COMMENT '地级市',
  `AREA_ID` int(11) DEFAULT NULL COMMENT '地级市下级县区',
  `NAME` varchar(100) NOT NULL COMMENT '姓名',
  `SEX` varchar(6) DEFAULT NULL COMMENT '性别',
  `BIRTH_DATE` date DEFAULT NULL COMMENT '出生日期',
  `ID_TYPE` varchar(6) NOT NULL COMMENT '证件类型',
  `ID_NO` varchar(32) NOT NULL COMMENT '证件号码',
  `GARD_SCHOOL` varchar(64) DEFAULT NULL COMMENT '毕业院校',
  `GARD_DATE` date DEFAULT NULL COMMENT '毕业时间',
  `GARD_MAJOR` varchar(32) DEFAULT NULL COMMENT '毕业专业',
  `DEGREE` varchar(32) DEFAULT NULL COMMENT '学历',
  `EDUCATION` varchar(64) DEFAULT NULL COMMENT '学位',
  `WORKING_DATE` date DEFAULT NULL COMMENT '参加工作时间',
  `CONTACT_PERSON` varchar(32) DEFAULT NULL COMMENT '联系人',
  `CONTACT_PHONE` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `CONTACT_ADDR` varchar(1024) DEFAULT NULL COMMENT '联系地址',
  `POST_CODE` varchar(6) DEFAULT NULL COMMENT '邮编',
  `MAIL` varchar(128) DEFAULT NULL COMMENT '电子邮箱',
  `CERT_TYPE` varchar(4) DEFAULT NULL COMMENT '证书类型 4二建资格证',
  `CERT_NO` varchar(64) DEFAULT NULL COMMENT '证书编号',
  `ISSUE_BY` varchar(64) DEFAULT NULL COMMENT '发证单位',
  `ISSUE_DATE` date DEFAULT NULL COMMENT '发证日期',
  `REGI_NO` varchar(64) DEFAULT NULL COMMENT '注册编号',
  `REGI_DATE` date DEFAULT NULL COMMENT '注册日期',
  `EDUC_NO` varchar(64) DEFAULT NULL COMMENT '继续教育证书编号',
  `EDUC_DATE` date DEFAULT NULL COMMENT '继续教育签发日期',
  `MAJOR_FIRST` varchar(32) DEFAULT NULL COMMENT '第一专业',
  `MAJOR_SECOND` varchar(32) DEFAULT NULL COMMENT '第二专业',
  `MAJOR_THIRD` varchar(32) DEFAULT NULL COMMENT '第三专业',
  `MAJOR_FOURTH` varchar(32) DEFAULT NULL COMMENT '第四专业',
  `MAJOR_FIFTH` varchar(32) DEFAULT NULL COMMENT '第五专业',
  `MAJOR_SIXTH` varchar(32) DEFAULT NULL COMMENT '第六专业',
  `PATCH_ID` varchar(1024) DEFAULT NULL COMMENT '附件路径',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `EMP_FLAG` varchar(6) DEFAULT NULL COMMENT '是否在职 0在职 1离职',
  `STS` char(1) NOT NULL COMMENT '状态 0 有效 1 失效',
  `STS_DATE` datetime NOT NULL COMMENT '状态时间',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SERVID`),
  KEY `IDX_COMPANY_ID` (`COMPANY_ID`),
  KEY `IDX_APP_ID` (`APP_ID`),
  KEY `IDX_TSERV_USERID` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=83179 DEFAULT CHARSET=utf8;

/*Table structure for table `t_so` */

DROP TABLE IF EXISTS `t_so`;

CREATE TABLE `t_so` (
  `SOID` varchar(64) NOT NULL COMMENT '申请编号，16位编码',
  `QR_ID` varchar(128) DEFAULT NULL COMMENT '二维码，申请单提交时生成',
  `APP_ID` varchar(6) NOT NULL COMMENT '业务模块，EQ 企业资质  OC一级建造师 AC二级建造师  TC临时建造师 CP三类人员 SE安全许可 SD示范工地  FR外进企业',
  `SO_TYPE` varchar(6) NOT NULL COMMENT '业务类型，01 初始申报 02 增项申报  03 变更 04 注销 05 遗失补办 06 换证 07 重新申报 08 延续申报  09 主项升级 10 增项升级',
  `FLOW_ID` varchar(64) DEFAULT NULL COMMENT '流程编号',
  `BPM_ID` varchar(64) DEFAULT NULL COMMENT '流程实例编号',
  `BATCH_ID` varchar(64) DEFAULT NULL COMMENT '批次号',
  `COMPANY_ID` int(11) NOT NULL COMMENT '企业编码',
  `USER_ID` varchar(63) NOT NULL COMMENT '用户编码',
  `PROVINCE_ID` varchar(6) NOT NULL COMMENT '省分',
  `LOCAL_ID` int(11) NOT NULL COMMENT '地级市',
  `AREA_ID` int(11) DEFAULT NULL COMMENT '地级市下级县区',
  `APPL_PERSON` varchar(32) NOT NULL COMMENT '申报人',
  `APPL_DATE` date NOT NULL COMMENT '申报时间',
  `APPL_ID_NO` varchar(32) DEFAULT NULL,
  `AUDI_FLAG` varchar(1) DEFAULT NULL COMMENT '审核标记：0完成审核 1 未完成审核',
  `AUDI_DATE` datetime DEFAULT NULL COMMENT '审核标记时间',
  `REPO_FLAG` varchar(1) DEFAULT NULL COMMENT '上报标记 0 已上报 1 未上报',
  `REPO_DATE` datetime DEFAULT NULL COMMENT '上报标记时间',
  `NOTI_FLAG` varchar(1) DEFAULT NULL COMMENT '公示标记:0 已公示 1 未公示',
  `NOTI_DATE` datetime DEFAULT NULL COMMENT '公示标记时间',
  `APPE_FLAG` varchar(1) DEFAULT NULL COMMENT '申诉标记：0 不申诉 1 申诉',
  `APPE_DATE` datetime DEFAULT NULL,
  `WARN_FLAG` varchar(1) DEFAULT NULL COMMENT '警示标记：0 未警示 1超时警示',
  `WARN_DATE` datetime DEFAULT NULL COMMENT '警示标记时间',
  `BATCH_FLAG` varchar(1) DEFAULT NULL COMMENT '批量标记',
  `BATCH_DATE` datetime DEFAULT NULL COMMENT '批量标记时间',
  `PROCESS_STS` varchar(50) DEFAULT NULL COMMENT '流程状态',
  `PROCESS_DATE` datetime DEFAULT NULL COMMENT '流程状态时间',
  `SERVID` int(11) DEFAULT NULL COMMENT '服务编号',
  `CREATE_DATE` datetime NOT NULL COMMENT '创建时间',
  `COMP_DATE` datetime DEFAULT NULL COMMENT '完成时间',
  `RSRV_STR1` varchar(128) DEFAULT NULL COMMENT '扩展字段1',
  `RSRV_STR2` varchar(128) DEFAULT NULL COMMENT '扩展字段2',
  `RSRV_STR3` varchar(128) DEFAULT NULL COMMENT '扩展字段3',
  `REMARKS` varchar(2048) DEFAULT NULL COMMENT '备注',
  `STS` char(1) NOT NULL COMMENT '申请主表： 0 竣工 1 保存 2提交 3审核中 4注销 5 撤销 6作废',
  `STS_DATE` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`SOID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_sys_user` */

DROP TABLE IF EXISTS `t_sys_user`;

CREATE TABLE `t_sys_user` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `user_course` */

DROP TABLE IF EXISTS `user_course`;

CREATE TABLE `user_course` (
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '申请用户编码',
  `course_id` bigint(20) DEFAULT NULL COMMENT '课程编码',
  `apply_date` datetime DEFAULT NULL COMMENT '申请时间',
  `start_date` datetime DEFAULT NULL COMMENT '开始学习时间',
  `finish_date` datetime DEFAULT NULL COMMENT '完成时间',
  `exp_date` date DEFAULT NULL COMMENT '失效时间',
  `audit_tag` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '审核标记',
  `valid` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '可用标记：0-不可用 1-可用',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `user_invoice` */

DROP TABLE IF EXISTS `user_invoice`;

CREATE TABLE `user_invoice` (
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '发票抬头',
  `contact_phone` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `contact_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `post_code` varchar(6) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `post_address` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '邮寄地址',
  `company_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '公司名称',
  `rsrv_str1` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str2` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rsrv_str3` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sts` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `sts_date` datetime DEFAULT NULL COMMENT '状态时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `event_clear_seal` */

/*!50106 DROP EVENT IF EXISTS `event_clear_seal`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`nmjzs`@`%` EVENT `event_clear_seal` ON SCHEDULE EVERY 1 MINUTE STARTS '2015-08-03 23:43:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	   CALL proc_seal();
	END */$$
DELIMITER ;

/* Event structure for event `event_syninfo` */

/*!50106 DROP EVENT IF EXISTS `event_syninfo`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`nmjzs`@`%` EVENT `event_syninfo` ON SCHEDULE EVERY 1440 MINUTE STARTS '2015-08-03 23:43:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	   CALL proc_syninfo();
	END */$$
DELIMITER ;

/* Function  structure for function  `currval` */

/*!50003 DROP FUNCTION IF EXISTS `currval` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`nmjzs`@`localhost` FUNCTION `currval`(seq_name VARCHAR(50)) RETURNS int(11)
    DETERMINISTIC
BEGIN
         DECLARE VALUE INTEGER;
         SET VALUE = 0;
         SELECT current_value INTO VALUE
                   FROM sequence
                   WHERE NAME = seq_name;
         RETURN VALUE;
END */$$
DELIMITER ;

/* Function  structure for function  `nextval` */

/*!50003 DROP FUNCTION IF EXISTS `nextval` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`nmjzs`@`localhost` FUNCTION `nextval`(seq_name VARCHAR(50)) RETURNS int(11)
    DETERMINISTIC
BEGIN
         UPDATE sequence
                   SET current_value = current_value + increment
                   WHERE NAME = seq_name;
         RETURN currval(seq_name);
END */$$
DELIMITER ;

/* Function  structure for function  `setval` */

/*!50003 DROP FUNCTION IF EXISTS `setval` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`nmjzs`@`localhost` FUNCTION `setval`(seq_name VARCHAR(50), VALUE INTEGER) RETURNS int(11)
    DETERMINISTIC
BEGIN
         UPDATE sequence
                   SET current_value = VALUE
                   WHERE NAME = seq_name;
         RETURN currval(seq_name);
END */$$
DELIMITER ;

/* Procedure structure for procedure `getUserInfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `getUserInfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserInfo`()
BEGIN
declare i_zjhm varchar(32); -- 用户名
declare i_major int ; -- 语文
declare done int;
DECLARE i_count INT;
-- 定义游标
DECLARE rs_cursor CURSOR FOR SELECT a.id_no,d.major_id FROM  t_serv a ,t_company b, so_plan c ,t_plan d  WHERE  d.sts ='0' AND d.plan_id = c.plan_id AND c.sts='0' AND c.fee_state ='1' AND c.hour_state ='1' AND a.user_id=c.user_id AND  a.sts ='0' AND b.sts ='0' AND a.company_id= b.company_id   ;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
open rs_cursor; 
cursor_loop:loop
   FETCH rs_cursor into i_zjhm, i_major; -- 取数据
   if done=1 then
    leave cursor_loop;
   end if;
   delete from jxjycasesafty where zjhm = i_zjhm and zylb =i_major;
-- 更新表
end loop cursor_loop;
close rs_cursor;
INSERT INTO jxjycasesafty (xm,zjhm,zcbh,zylb,hgzbh,qfrq,bxxs,xxxs,gzdw,pxsjq,pxsjz,zhgxsj,state,pass,createby,creaetdate,updateby,updateDate) 
SELECT DISTINCT a.name,a.id_no,regi_no,d.major_id AS major,c.rsrv_str2,a.issue_date, d.plan_hours/2,d.plan_hours/2,b.company_name,NULL,NULL,NULL, a.sts,'0','1',NOW(),NULL,NULL FROM  t_serv a ,t_company b, so_plan c ,t_plan d  WHERE  d.sts ='0' AND d.plan_id = c.plan_id AND c.sts='0' AND c.fee_state ='1' AND c.hour_state ='1' AND a.user_id=c.user_id AND  a.sts ='0' AND b.sts ='0' AND a.company_id= b.company_id   ;
DELETE FROM jxjycasesafty WHERE zjhm IS NULL  OR zjhm = '';
    END */$$
DELIMITER ;

/* Procedure structure for procedure `proc_seal` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_seal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`nmjzs`@`%` PROCEDURE `proc_seal`()
BEGIN
DELETE  FROM t_seal  WHERE  NOW()> DATE_ADD(create_date, INTERVAL 1 HOUR)  AND sts ='0';
END */$$
DELIMITER ;

/* Procedure structure for procedure `proc_syninfo` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_syninfo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`nmjzs`@`%` PROCEDURE `proc_syninfo`()
BEGIN
DECLARE i_zjhm VARCHAR(32); 
DECLARE i_major INT ; 
DECLARE done INT;
DECLARE i_count INT;
DECLARE rs_cursor CURSOR FOR SELECT a.id_no,d.major_id FROM  t_serv a ,t_company b, so_plan c ,t_plan d  WHERE  d.sts ='0' AND d.plan_id = c.plan_id AND c.sts='0' AND c.fee_state ='1' AND c.hour_state ='1' AND a.user_id=c.user_id AND  a.sts ='0' AND b.sts ='0' AND a.company_id= b.company_id   AND d.major_id IN (10,11,12,13,14);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
OPEN rs_cursor; 
cursor_loop:LOOP
   FETCH rs_cursor INTO i_zjhm, i_major; -- 取数据
   IF done=1 THEN
    LEAVE cursor_loop;
   END IF;
   DELETE FROM jxjycasesafty WHERE zjhm = i_zjhm AND zylb =i_major;
END LOOP cursor_loop;
CLOSE rs_cursor;
INSERT INTO jxjycase (xm,zjhm,zcbh,zylb,hgzbh,qfrq,bxxs,xxxs,gzdw,pxsjq,pxsjz,zhgxsj,state,pass,createby,creaetdate,updateby,updateDate) 
SELECT DISTINCT a.name,a.id_no,regi_no,CASE  WHEN d.major_id = '0' THEN  '公共' WHEN d.major_id = '1' THEN '建筑' WHEN d.major_id ='2' THEN '市政' WHEN d.major_id ='3' THEN '公路' WHEN d.major_id='4' THEN '水利' WHEN d.major_id='5' THEN '机电'  WHEN d.major_id='6' THEN '矿业'END AS major,c.rsrv_str2,a.issue_date, d.plan_hours/2,d.plan_hours/2,b.company_name,NULL,NULL,NULL, a.sts,'0','1',NOW(),NULL,NULL FROM  t_serv a ,t_company b, so_plan c ,t_plan d WHERE  d.sts ='0' AND d.plan_id = c.plan_id AND c.sts='0' AND c.fee_state ='1' AND c.exam_state ='1' AND a.user_id=c.user_id AND  a.sts ='0' AND b.sts ='0' AND (a.emp_flag IS NULL OR a.emp_flag !='1') AND a.company_id= b.company_id AND c.rsrv_str2 IS NOT NULL AND  NOT EXISTS (SELECT 1 FROM jxjycase e WHERE c.rsrv_str2=e.hgzbh) AND  d.major_id IN (1,2,3,4,5,6); 
DELETE FROM jxjycase WHERE zjhm IS NULL  OR zjhm = '';
INSERT INTO jxjycasecims (xm,zjhm,zcbh,zylb,hgzbh,qfrq,bxxs,xxxs,gzdw,pxsjq,pxsjz,zhgxsj,state,pass,createby,creaetdate,updateby,updateDate) 
SELECT DISTINCT a.name,a.id_no,regi_no,CASE  WHEN d.major_id = '1' THEN  '1' WHEN d.major_id = '4' THEN '2' WHEN d.major_id ='2' THEN '3' WHEN d.major_id ='5' THEN '4' WHEN d.major_id='3' THEN '5' WHEN d.major_id='6' THEN '6'  END AS major,c.rsrv_str2,a.issue_date, d.plan_hours/2,d.plan_hours/2,b.company_name,NULL,NULL,NULL, a.sts,'0','1',NOW(),NULL,NULL FROM  t_serv a ,t_company b, so_plan c ,t_plan d WHERE  d.sts ='0' AND d.plan_id = c.plan_id AND c.sts='0' AND c.fee_state ='1' AND c.exam_state ='1' AND a.user_id=c.user_id AND  a.sts ='0' AND b.sts ='0' AND (a.emp_flag IS NULL OR a.emp_flag !='100') AND a.company_id= b.company_id AND c.rsrv_str2 IS NOT NULL AND  NOT EXISTS (SELECT 1 FROM jxjycasecims e WHERE c.rsrv_str2=e.hgzbh) AND  d.major_id IN (1,2,3,4,5,6); 
DELETE FROM jxjycasecims WHERE zjhm IS NULL  OR zjhm = '';
DELETE FROM jxjycasecims WHERE  NOW()> DATE_ADD(qfrq, INTERVAL 3 YEAR); 
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
