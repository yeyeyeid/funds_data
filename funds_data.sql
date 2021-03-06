-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 03 月 13 日 21:31
-- 服务器版本: 5.5.35
-- PHP 版本: 5.4.4-14+deb7u8

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `lxq_fundsdb`
--

-- --------------------------------------------------------

--
-- 表的结构 `funds_company`
--

CREATE TABLE IF NOT EXISTS `funds_company` (
  `company_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公司ID',
  `company_name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '公司名称',
  PRIMARY KEY (`company_id`),
  KEY `company_name` (`company_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `funds_list`
--

CREATE TABLE IF NOT EXISTS `funds_list` (
  `fund_code` varchar(6) NOT NULL COMMENT '»ùœðŽúÂë',
  `type_id` int(1) DEFAULT NULL,
  `fund_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '»ùœðÃû³Æ',
  `fund_origin_date` date DEFAULT NULL,
  `funds_company_id` int(4) DEFAULT NULL,
  `comment` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`fund_code`),
  KEY `FK_Relationship_1` (`type_id`),
  KEY `FK_funds_company` (`funds_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='»ùœðÁÐ±í';

-- --------------------------------------------------------

--
-- 表的结构 `funds_stock_data`
--

CREATE TABLE IF NOT EXISTS `funds_stock_data` (
  `fund_code` varchar(6) NOT NULL COMMENT '»ùœðŽúÂë',
  `stock_code` varchar(8) NOT NULL,
  `public_date` date DEFAULT NULL COMMENT '·¢²ŒÈÕÆÚ',
  PRIMARY KEY (`fund_code`,`stock_code`),
  KEY `FK_funds_stock_data2` (`stock_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `funds_type`
--

CREATE TABLE IF NOT EXISTS `funds_type` (
  `type_id` int(1) NOT NULL,
  `type_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='»ùœðÀàÐÍŽúÂë';

-- --------------------------------------------------------

--
-- 表的结构 `funds_value`
--

CREATE TABLE IF NOT EXISTS `funds_value` (
  `value_data_id` int(8) NOT NULL AUTO_INCREMENT,
  `fund_code` varchar(6) CHARACTER SET latin1 NOT NULL COMMENT '基金代码',
  `value_date` date NOT NULL,
  `value_leiji` float DEFAULT NULL COMMENT '累积净值',
  `value_curr` float DEFAULT NULL COMMENT '当日净值',
  PRIMARY KEY (`value_data_id`),
  KEY `fund_code` (`fund_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2390 ;

-- --------------------------------------------------------

--
-- 表的结构 `stock_list`
--

CREATE TABLE IF NOT EXISTS `stock_list` (
  `stock_code` varchar(8) NOT NULL,
  `stock_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`stock_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='¹ÉÆ±ÁÐ±í';

--
-- 限制导出的表
--

--
-- 限制表 `funds_list`
--
ALTER TABLE `funds_list`
  ADD CONSTRAINT `FK_funds_company` FOREIGN KEY (`funds_company_id`) REFERENCES `funds_company` (`company_id`),
  ADD CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`type_id`) REFERENCES `funds_type` (`type_id`);

--
-- 限制表 `funds_stock_data`
--
ALTER TABLE `funds_stock_data`
  ADD CONSTRAINT `FK_funds_stock_data` FOREIGN KEY (`fund_code`) REFERENCES `funds_list` (`fund_code`),
  ADD CONSTRAINT `FK_funds_stock_data2` FOREIGN KEY (`stock_code`) REFERENCES `stock_list` (`stock_code`);

--
-- 限制表 `funds_value`
--
ALTER TABLE `funds_value`
  ADD CONSTRAINT `funds_value_ibfk_2` FOREIGN KEY (`fund_code`) REFERENCES `funds_list` (`fund_code`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
