-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3308
-- Létrehozás ideje: 2021. Ápr 04. 05:13
-- Kiszolgáló verziója: 8.0.18
-- PHP verzió: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `tempress_dev1`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `analyticsaction`
--

DROP TABLE IF EXISTS `analyticsaction`;
CREATE TABLE IF NOT EXISTS `analyticsaction` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `VIDEO_ID` int(11) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PLAYERS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `COMMENT` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TIME` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `JSON` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_AA_VIDEO_ID` (`VIDEO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `annual_payment`
--

DROP TABLE IF EXISTS `annual_payment`;
CREATE TABLE IF NOT EXISTS `annual_payment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `INCOME_GROUP_ID` int(11) DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `AMOUNT` int(11) NOT NULL,
  `DAY` int(2) NOT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx1` (`ORG_ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx2` (`TEAM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  `TRAINING_ID` int(11) NOT NULL,
  `JELEN` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_org_uq` (`USER_ID`,`TRAINING_ID`),
  KEY `fk_WK_idx` (`TRAINING_ID`),
  KEY `fk_us_WK_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `calendar`
--

DROP TABLE IF EXISTS `calendar`;
CREATE TABLE IF NOT EXISTS `calendar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `EVENT_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `EVENT_COLOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `START_DATE_TIME` timestamp NULL DEFAULT NULL,
  `END_DATE_TIME` timestamp NULL DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_org_calendar` (`ORGANIZATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `club`
--

DROP TABLE IF EXISTS `club`;
CREATE TABLE IF NOT EXISTS `club` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `TYPE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CURRENCY` varchar(3) COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'HUF',
  `PUBLIC_KEY` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `PRIVATE_KEY` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DATABANK_URL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `club`
--

INSERT INTO `club` (`ID`, `NAME`, `TYPE`, `CURRENCY`, `PUBLIC_KEY`, `PRIVATE_KEY`, `DATABANK_URL`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(4, 'KLC', 'football', 'HUF', 'ASD', 'AS', NULL, 0, 'Admin', '2021-03-31 13:34:43', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `clubdata`
--

DROP TABLE IF EXISTS `clubdata`;
CREATE TABLE IF NOT EXISTS `clubdata` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `COUNTRY_CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `CITY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `POST_CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `STREET` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `STREET2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `PRIMARY_OC` bit(1) DEFAULT b'0',
  `TEMP` int(5) DEFAULT NULL,
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `TEMP_UPDATE` date DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ORG_COUNTRY_CODE_UNIQUE` (`ORG_ID`,`COUNTRY_CODE`),
  KEY `FK_org_ctry_ORG_ID` (`ORG_ID`),
  KEY `fk_ORG_COUNTRY_LOOKUP_CODE1_idx` (`COUNTRY_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `clubdata`
--

INSERT INTO `clubdata` (`ID`, `ORG_ID`, `COUNTRY_CODE`, `NAME`, `CITY`, `POST_CODE`, `STREET`, `STREET2`, `PRIMARY_OC`, `TEMP`, `TYPE`, `TEMP_UPDATE`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 3, 'asd', 'asd', 'asd', 'asd', 'asd', 'asd', NULL, NULL, NULL, NULL, 0, 'Admin', '2021-03-31 07:41:32', NULL, NULL),
(2, 4, 'Magyarország', 'KLC', 'Pomáz', '2013', 'Mikszáth Kálmán utca', '30', NULL, NULL, NULL, NULL, 0, 'Admin', '2021-03-31 13:34:43', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `customgame`
--

DROP TABLE IF EXISTS `customgame`;
CREATE TABLE IF NOT EXISTS `customgame` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `ELLEN` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DATUM` timestamp NULL DEFAULT NULL,
  `HELY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DELETED` tinyint(1) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_ORG_id` (`ORG_ID`),
  KEY `fk_TEAM_id` (`TEAM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `exercise`
--

DROP TABLE IF EXISTS `exercise`;
CREATE TABLE IF NOT EXISTS `exercise` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `TYPE` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `DELETED` tinyint(4) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_NAME_TYPE_uq` (`NAME`,`TYPE`),
  KEY `fk_EXERCISE_ORG_idx` (`ORGANIZATION_ID`),
  KEY `fk_EXERCISE_LOOKUP_idx` (`TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income`
--

DROP TABLE IF EXISTS `income`;
CREATE TABLE IF NOT EXISTS `income` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `UUID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `INCOME` tinyint(1) NOT NULL,
  `PRIZE` int(11) NOT NULL,
  `ACCEPTED` tinyint(1) DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `incomegroup`
--

DROP TABLE IF EXISTS `incomegroup`;
CREATE TABLE IF NOT EXISTS `incomegroup` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `incomegroupconnection`
--

DROP TABLE IF EXISTS `incomegroupconnection`;
CREATE TABLE IF NOT EXISTS `incomegroupconnection` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `INCOME_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_orgasd_idx1` (`INCOME_ID`),
  KEY `fk_usr_asdorg1_idx1` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `league`
--

DROP TABLE IF EXISTS `league`;
CREATE TABLE IF NOT EXISTS `league` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EVAD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `SZERVEZO` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LIGA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `KLUB_NEV` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TEAM` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lineup`
--

DROP TABLE IF EXISTS `lineup`;
CREATE TABLE IF NOT EXISTS `lineup` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `SORSOLAS_ID` int(11) DEFAULT NULL,
  `CUSTOM_GAME_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  `ATTENDANCE` int(11) NOT NULL,
  `X` int(11) DEFAULT NULL,
  `Y` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SORSOLAS_ID` (`SORSOLAS_ID`,`USER_ID`),
  KEY `fk_o_LOOKUP_idx` (`ORG_ID`),
  KEY `fk_s_LOOKUP_idx` (`SORSOLAS_ID`),
  KEY `fk_u_LOOKUP_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LEVEL` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `LOGGER` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `MESSAGE` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `USER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lookupcode`
--

DROP TABLE IF EXISTS `lookupcode`;
CREATE TABLE IF NOT EXISTS `lookupcode` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LGROUP` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_lgroup_code_uq` (`LGROUP`,`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=5002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `lookupcode`
--

INSERT INTO `lookupcode` (`ID`, `LGROUP`, `CODE`, `NAME`, `DESCRIPTION`, `ATTR1`, `ATTR2`, `ATTR3`, `ATTR4`, `ATTR5`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATED_BY`, `LAST_UPDATE_DATE`) VALUES
(4993, 'EXERCISE_TYPE', 'Csillagok', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:09:43', NULL, NULL),
(4994, 'EXERCISE_TYPE', 'Szöveges értékelés', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:09:43', NULL, NULL),
(4995, 'EXERCISE_TYPE', '1-10 -es skála', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:03', NULL, NULL),
(4996, 'EXERCISE_TYPE', 'Százalék', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:03', NULL, NULL),
(4997, 'EXERCISE_TYPE', 'Sikeres/darabszám', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:39', NULL, NULL),
(4998, 'TEAM_TYPE', 'U-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL),
(4999, 'TEAM_TYPE', 'U-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL),
(5001, 'TEAM_TYPE', 'U-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `parameter`
--

DROP TABLE IF EXISTS `parameter`;
CREATE TABLE IF NOT EXISTS `parameter` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GROUP` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` bit(1) DEFAULT b'0',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_code_group_uq` (`GROUP`,`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `parameter`
--

INSERT INTO `parameter` (`ID`, `GROUP`, `CODE`, `VALUE`, `ATTR1`, `ATTR2`, `ATTR3`, `ATTR4`, `ATTR5`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(17, 'TRAINER_RATING', 'KECSKEMÉTI LC', '2', NULL, NULL, NULL, NULL, NULL, 1, b'0', NULL, '2020-07-20 16:38:23', NULL, NULL),
(18, 'SYSTEM', 'FOLDER_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\folderImages\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:33', 'Admin'),
(19, 'SYSTEM', 'UPLOAD_FOLDER', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\videoAnalytics\\upload\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:46', 'Admin'),
(20, 'SYSTEM', 'SCENE_FOLDER', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\videoAnalytics\\scene\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:57', 'Admin'),
(21, 'SYSTEM', 'POST_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\postImages\\', '', '', '', '', '', 1, b'0', 'Admin', '2020-10-31 08:49:35', '2021-01-12 09:56:04', 'Admin'),
(22, 'SYSTEM', 'PROFILE_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\profileImages\\', '', '', '', '', '', 2, b'0', 'Admin', '2020-10-31 08:51:37', '2021-01-12 09:56:12', 'Admin'),
(23, 'SYSTEM', 'DOMAIN', 'http://localhost:8080', '', '', '', '', '', 2, b'0', 'Admin', '2020-10-31 08:51:37', '2021-01-12 09:56:12', 'Admin');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payment_request`
--

DROP TABLE IF EXISTS `payment_request`;
CREATE TABLE IF NOT EXISTS `payment_request` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `INCOME_GROUP_ID` int(11) DEFAULT NULL,
  `UUID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `AMOUNT` int(11) NOT NULL,
  `COMPLETED` tinyint(1) DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx1` (`ORG_ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx2` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DESCRIPTION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_priv_name_uq` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=945 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `permission`
--

INSERT INTO `permission` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(755, 'LOGGED_IN', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(756, 'DATA_UPLOAD', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(913, 'HOME_HEADER_BUTTONS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(914, 'POST_COMMENT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(915, 'POST_COMMENT_READ', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(916, 'CAREER_HEADER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(917, 'CAREER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(918, 'EXERCISE_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(919, 'EXERCISE_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(920, 'TRAIN_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(921, 'TRAIN_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(922, 'WORKOUT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(923, 'WORKOUT_PLAYER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(924, 'WORKOUT_ALL_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(925, 'PLANNER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(926, 'PLANS_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(927, 'COST_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(928, 'COST_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(929, 'COST_ACCEPT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(930, 'GROUP_COSTS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(931, 'STATEMENT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(932, 'PLANS_CREATE', NULL, 1, 0, NULL, '2020-06-01 13:39:38', NULL, NULL),
(933, 'MLSZ_STATISTICS', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(936, 'ADMIN', NULL, 1, 0, NULL, '2020-06-13 11:41:45', NULL, NULL),
(937, 'VIDEO_ANALYTICS', NULL, 1, 0, NULL, '2020-06-18 14:55:23', NULL, NULL),
(938, 'EVENT_CREATE', NULL, 1, 0, NULL, '2020-09-26 10:52:11', NULL, NULL),
(939, 'HOME_WEATHER', NULL, 1, 0, NULL, '2020-10-17 11:07:21', NULL, NULL),
(941, 'EVENT_OWNER', NULL, 1, 0, NULL, '2021-03-02 10:28:57', NULL, NULL),
(942, 'VIDEO_ANALYTICS_EDIT', NULL, 1, 0, NULL, '2021-03-02 17:57:51', NULL, NULL),
(943, 'ANNUAL_COST_CREATE', NULL, 1, 0, NULL, '2021-03-04 10:31:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_role_name_uq` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(27, 'PLAYER', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(28, 'ADMIN', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(32, 'TRAINER', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(33, 'OWNER', NULL, 1, 0, NULL, '2020-05-27 15:27:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rolepermission`
--

DROP TABLE IF EXISTS `rolepermission`;
CREATE TABLE IF NOT EXISTS `rolepermission` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(11) NOT NULL,
  `PRIVILEGE_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_role_priv_uq` (`ROLE_ID`,`PRIVILEGE_ID`),
  KEY `fk_role_priv_priv_id` (`PRIVILEGE_ID`),
  KEY `fk_role_role_id` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1271 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `rolepermission`
--

INSERT INTO `rolepermission` (`ID`, `ROLE_ID`, `PRIVILEGE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1214, 27, 755, 1, NULL, '2020-05-28 06:39:31', NULL, NULL),
(1215, 27, 915, 1, NULL, '2020-05-28 06:51:18', NULL, NULL),
(1216, 27, 914, 1, NULL, '2020-05-28 06:52:07', NULL, NULL),
(1218, 27, 917, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(1219, 27, 916, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(1220, 27, 923, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(1221, 27, 926, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(1223, 32, 755, 1, NULL, '2020-05-28 06:39:31', NULL, NULL),
(1224, 32, 914, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1225, 32, 915, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1226, 32, 917, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1227, 32, 918, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1228, 32, 919, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1229, 32, 920, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1230, 32, 921, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1231, 32, 922, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1232, 32, 924, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1233, 32, 925, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1235, 33, 755, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1236, 33, 914, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1237, 33, 915, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1238, 33, 917, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1240, 33, 924, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1241, 33, 926, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1242, 33, 927, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1243, 33, 928, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1244, 33, 929, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1245, 33, 930, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1246, 33, 931, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(1247, 32, 932, 1, NULL, '2020-06-01 13:40:08', NULL, NULL),
(1248, 27, 913, 1, NULL, '2020-06-02 16:33:55', NULL, NULL),
(1257, 28, 755, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(1258, 28, 936, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(1259, 32, 937, 1, NULL, '2020-06-18 14:55:47', NULL, NULL),
(1260, 32, 938, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(1261, 27, 939, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(1262, 32, 939, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(1263, 33, 939, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(1264, 33, 938, 1, NULL, '2021-03-02 10:23:41', NULL, NULL),
(1265, 33, 941, 1, NULL, '2021-03-02 10:29:23', NULL, NULL),
(1266, 32, 942, 1, NULL, '2021-03-02 17:58:18', NULL, NULL),
(1267, 27, 937, 1, NULL, '2021-03-02 17:59:07', NULL, NULL),
(1268, 33, 937, 1, NULL, '2021-03-02 17:59:07', NULL, NULL),
(1269, 33, 943, 1, NULL, '2021-03-04 10:32:40', NULL, NULL),
(1270, 32, 927, 1, NULL, '2021-03-04 10:33:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `CREATION_TIME` bigint(20) DEFAULT NULL,
  `EXPIRY_TIME` longblob,
  `LAST_ACCESS_TIME` longblob,
  `MAX_INACTIVE_INTERVAL` int(11) DEFAULT NULL,
  `PRINCIPAL_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `SESSION_ID` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`PRIMARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `ATTRIBUTE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ATTRIBUTE_BYTES` longblob,
  `SESSION_PRIMARY_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`ATTRIBUTE_NAME`,`SESSION_PRIMARY_ID`),
  KEY `FK_SPR_SESS_ATT_SPR_SESS` (`SESSION_PRIMARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainerrating`
--

DROP TABLE IF EXISTS `trainerrating`;
CREATE TABLE IF NOT EXISTS `trainerrating` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `DONE` tinyint(1) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainerratingresult`
--

DROP TABLE IF EXISTS `trainerratingresult`;
CREATE TABLE IF NOT EXISTS `trainerratingresult` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `TRAINER_ID` int(11) NOT NULL,
  `RESULT` int(11) DEFAULT NULL,
  `RATING_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainingplan`
--

DROP TABLE IF EXISTS `trainingplan`;
CREATE TABLE IF NOT EXISTS `trainingplan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `TRAINING_DATE` timestamp NULL DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_TRAINING_ORG_idx` (`ORGANIZATION_ID`),
  KEY `fk_TRAINING_LOOKUP_idx` (`TEAM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainingplan_connection`
--

DROP TABLE IF EXISTS `trainingplan_connection`;
CREATE TABLE IF NOT EXISTS `trainingplan_connection` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SORT` int(3) NOT NULL,
  `TRAININGPLAN_ID` int(11) DEFAULT NULL,
  `EXERCISE_ID` int(11) DEFAULT NULL,
  `DURATION` int(3) DEFAULT NULL,
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `VERSION` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó felhasználóneve',
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó neve',
  `PASSWORD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó jelszava BCrypt-el encryptelve',
  `PROFIL_IMG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'userphoto.png',
  `EMAIL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL COMMENT 'A felhasználó email címe',
  `PHONE_NUMBER` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL COMMENT 'Telefon szám',
  `DATABANK_URL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PLAYER` tinyint(1) NOT NULL DEFAULT '0',
  `TRAINER` tinyint(1) DEFAULT '0',
  `DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Törölve van-e a felhasználó',
  `ENABLED` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Felhasználó engedélyezve van-e',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`ID`, `USERNAME`, `NAME`, `PASSWORD`, `PROFIL_IMG`, `EMAIL`, `PHONE_NUMBER`, `DATABANK_URL`, `PLAYER`, `TRAINER`, `DELETED`, `ENABLED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'Admin', 'Adminisztrátor', '$2a$10$gB9OtSUDzYXnPcssXcxg8O71Z5P5WYsco7.Mtoh8Qv1ogByaVhk7i', 'userphoto.png', 'redlymatyi@gmail.com', 'asd', '', 0, 0, 0, 1, 7, NULL, '2020-02-16 14:08:05', '2021-04-03 13:02:30', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userclub`
--

DROP TABLE IF EXISTS `userclub`;
CREATE TABLE IF NOT EXISTS `userclub` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `LIGA_ID` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_org_uq` (`USER_ID`,`ORGANIZATION_ID`,`TEAM_ID`) USING BTREE,
  KEY `fk_usr_org_idx` (`ORGANIZATION_ID`),
  KEY `FK_usr_org_LOOKUP_CODE_idx` (`TEAM_ID`),
  KEY `fk_usr_org1_idx` (`USER_ID`),
  KEY `LIGA_ID` (`LIGA_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `usernotification`
--

DROP TABLE IF EXISTS `usernotification`;
CREATE TABLE IF NOT EXISTS `usernotification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `SRC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TITLE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `SEEN` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_noti_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userpost`
--

DROP TABLE IF EXISTS `userpost`;
CREATE TABLE IF NOT EXISTS `userpost` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `POST` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `IMAGE_URL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_org_idx1` (`ORGANIZATION_ID`),
  KEY `fk_usr_org1_idx1` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userpostcomment`
--

DROP TABLE IF EXISTS `userpostcomment`;
CREATE TABLE IF NOT EXISTS `userpostcomment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `POST_ID` int(11) NOT NULL,
  `COMMENT` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_org_idx1` (`POST_ID`),
  KEY `fk_usr_org1_idx1` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userrole`
--

DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_role_uq` (`USER_ID`,`ROLE_ID`),
  KEY `FK_user_roles_role_id` (`ROLE_ID`),
  KEY `fk_usr_usr_id` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `userrole`
--

INSERT INTO `userrole` (`ID`, `USER_ID`, `ROLE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(13, 1, 28, 1, NULL, '2020-02-16 14:08:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `video`
--

DROP TABLE IF EXISTS `video`;
CREATE TABLE IF NOT EXISTS `video` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PUBLIC` tinyint(1) DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `workout`
--

DROP TABLE IF EXISTS `workout`;
CREATE TABLE IF NOT EXISTS `workout` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  `TRAINING_ID` int(11) NOT NULL,
  `EXERCISE_ID` int(11) NOT NULL,
  `RESULT` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PERCENT` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_WK_idx` (`TRAINING_ID`),
  KEY `FK_WK_LOOKUP_CODE_idx` (`EXERCISE_ID`),
  KEY `fk_us_WK_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `exercise`
--
ALTER TABLE `exercise`
  ADD CONSTRAINT `fk_EXERCISE_1` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `club` (`ID`),
  ADD CONSTRAINT `fk_EXERCISE_2` FOREIGN KEY (`TYPE`) REFERENCES `lookupcode` (`ID`);

--
-- Megkötések a táblához `trainingplan`
--
ALTER TABLE `trainingplan`
  ADD CONSTRAINT `fk_TRAINING_EXERCISE341234` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `club` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
