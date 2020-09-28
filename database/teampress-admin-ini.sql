-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2020. Sze 26. 08:32
-- Kiszolgáló verziója: 5.7.26
-- PHP verzió: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `teampress`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `calendar`
--

DROP TABLE IF EXISTS `calendar`;
CREATE TABLE IF NOT EXISTS `calendar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `TEAM` varchar(11) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `EVENT_NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `EVENT_COLOR` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `START_DATE_TIME` timestamp NULL DEFAULT NULL,
  `END_DATE_TIME` timestamp NULL DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_org_calendar` (`ORGANIZATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `custom_game`
--

DROP TABLE IF EXISTS `custom_game`;
CREATE TABLE IF NOT EXISTS `custom_game` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `ELLEN` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DATUM` timestamp NULL DEFAULT NULL,
  `HELY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DELETED` tinyint(1) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
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
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `TYPE` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `DELETED` tinyint(4) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_NAME_TYPE_uq` (`NAME`,`TYPE`),
  KEY `fk_EXERCISE_ORG_idx` (`ORGANIZATION_ID`),
  KEY `fk_EXERCISE_LOOKUP_idx` (`TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `folder`
--

DROP TABLE IF EXISTS `folder`;
CREATE TABLE IF NOT EXISTS `folder` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `URL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fordulo`
--

DROP TABLE IF EXISTS `fordulo`;
CREATE TABLE IF NOT EXISTS `fordulo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LIGA_ID` int(11) DEFAULT NULL,
  `FORDULO` int(11) DEFAULT NULL,
  `DATE_TO_POLL` timestamp NULL DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_play_uq` (`LIGA_ID`,`FORDULO`),
  KEY `fk_liga_tab` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gameplan`
--

DROP TABLE IF EXISTS `gameplan`;
CREATE TABLE IF NOT EXISTS `gameplan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `SORSOLAS_ID` int(11) DEFAULT NULL,
  `CUSTOM_GAME_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  `ATTENDANCE` int(11) NOT NULL,
  `X` int(11) DEFAULT NULL,
  `Y` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SORSOLAS_ID` (`SORSOLAS_ID`,`USER_ID`),
  KEY `fk_o_LOOKUP_idx` (`ORG_ID`),
  KEY `fk_s_LOOKUP_idx` (`SORSOLAS_ID`),
  KEY `fk_u_LOOKUP_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `goals`
--

DROP TABLE IF EXISTS `goals`;
CREATE TABLE IF NOT EXISTS `goals` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `LIGA_ID` int(11) NOT NULL,
  `FORD` int(11) DEFAULT NULL,
  `HELYEZES` int(11) NOT NULL,
  `NEV` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `GOALS` int(11) NOT NULL,
  `FORD_GOAL` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_g_org_id` (`ORG_ID`),
  KEY `fk_g_liga_id` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income`
--

DROP TABLE IF EXISTS `income`;
CREATE TABLE IF NOT EXISTS `income` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `INCOME` tinyint(1) NOT NULL,
  `PRIZE` int(11) NOT NULL,
  `ACCEPTED` tinyint(1) DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_LANGUAGE_LOOKUP_idx` (`ORG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income_group`
--

DROP TABLE IF EXISTS `income_group`;
CREATE TABLE IF NOT EXISTS `income_group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income_group_conn`
--

DROP TABLE IF EXISTS `income_group_conn`;
CREATE TABLE IF NOT EXISTS `income_group_conn` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `INCOME_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_orgasd_idx1` (`INCOME_ID`),
  KEY `fk_usr_asdorg1_idx1` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jelen`
--

DROP TABLE IF EXISTS `jelen`;
CREATE TABLE IF NOT EXISTS `jelen` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) NOT NULL,
  `TRAINING_ID` int(11) NOT NULL,
  `JELEN` varchar(11) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_org_uq` (`USER_ID`,`TRAINING_ID`),
  KEY `fk_WK_idx` (`TRAINING_ID`),
  KEY `fk_us_WK_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `liga`
--

DROP TABLE IF EXISTS `liga`;
CREATE TABLE IF NOT EXISTS `liga` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `EVAD` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `SZERVEZO` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LIGA` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `KLUB_NEV` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TEAM` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LEVEL` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `LOGGER` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `MESSAGE` longtext COLLATE utf8mb4_bin,
  `USER_ID` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lookup_code`
--

DROP TABLE IF EXISTS `lookup_code`;
CREATE TABLE IF NOT EXISTS `lookup_code` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LGROUP` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `CODE` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL COMMENT 'TaMÁs',
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR1` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR2` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR3` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR4` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `ATTR5` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_lgroup_code_uq` (`LGROUP`,`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `lookup_code`
--

INSERT INTO `lookup_code` (`ID`, `LGROUP`, `CODE`, `NAME`, `DESCRIPTION`, `ATTR1`, `ATTR2`, `ATTR3`, `ATTR4`, `ATTR5`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATED_BY`, `LAST_UPDATE_DATE`) VALUES
(1, 'EXERCISE_TYPE', 'Csillagok', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:09:43', NULL, NULL),
(2, 'EXERCISE_TYPE', 'Szöveges értékelés', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:09:43', NULL, NULL),
(3, 'EXERCISE_TYPE', '1-10 -es skála', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:03', NULL, NULL),
(4, 'EXERCISE_TYPE', 'Százalék', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:03', NULL, NULL),
(5, 'EXERCISE_TYPE', 'Sikeres/darabszám', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-02-16 15:11:39', NULL, NULL),
(6, 'TEAM_TYPE', 'U-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL),
(7, 'TEAM_TYPE', 'U-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL),
(8, 'TEAM_TYPE', 'U-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2020-04-14 11:57:53', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `organization`
--

DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DATABANK_URL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `org_country`
--

DROP TABLE IF EXISTS `org_country`;
CREATE TABLE IF NOT EXISTS `org_country` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `COUNTRY_CODE` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CITY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `POST_CODE` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `STREET` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `STREET2` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `PRIMARY_OC` bit(1) DEFAULT b'0',
  `TEMP` int(5) DEFAULT NULL,
  `TYPE` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `TEMP_UPDATE` date DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ORG_COUNTRY_CODE_UNIQUE` (`ORG_ID`,`COUNTRY_CODE`),
  KEY `FK_org_ctry_ORG_ID` (`ORG_ID`),
  KEY `fk_ORG_COUNTRY_LOOKUP_CODE1_idx` (`COUNTRY_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `parameters`
--

DROP TABLE IF EXISTS `parameters`;
CREATE TABLE IF NOT EXISTS `parameters` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GROUP` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `CODE` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `VALUE` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR1` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR2` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR3` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR4` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `ATTR5` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` bit(1) DEFAULT b'0',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_code_group_uq` (`GROUP`,`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `player_data`
--

DROP TABLE IF EXISTS `player_data`;
CREATE TABLE IF NOT EXISTS `player_data` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `SZUL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `KOR` int(11) DEFAULT NULL,
  `MECCSEK` int(11) DEFAULT NULL,
  `GOLOK` int(11) DEFAULT NULL,
  `ONGOLOK` int(11) DEFAULT NULL,
  `SARGA` int(11) DEFAULT NULL,
  `PIROS` int(11) DEFAULT NULL,
  `KEZDO` int(11) DEFAULT NULL,
  `CSERE` int(11) DEFAULT NULL,
  `KISPAD` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_play_uq` (`USER_ID`),
  KEY `fk_user_databank` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `privilege`
--

DROP TABLE IF EXISTS `privilege`;
CREATE TABLE IF NOT EXISTS `privilege` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `DESCRIPTION` varchar(200) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_priv_name_uq` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `privilege`
--

INSERT INTO `privilege` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'LOGGED_IN', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(2, 'DATA_UPLOAD', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(3, 'HOME_HEADER_BUTTONS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(4, 'POST_COMMENT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(5, 'POST_COMMENT_READ', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(6, 'CAREER_HEADER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(7, 'CAREER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(8, 'EXERCISE_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(9, 'EXERCISE_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(10, 'TRAIN_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(11, 'TRAIN_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(12, 'WORKOUT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(13, 'WORKOUT_PLAYER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(14, 'WORKOUT_ALL_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(15, 'PLANNER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(16, 'PLANS_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(17, 'COST_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(18, 'COST_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(19, 'COST_ACCEPT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(20, 'GROUP_COSTS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(21, 'STATEMENT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(22, 'PLANS_CREATE', NULL, 1, 0, NULL, '2020-06-01 13:39:38', NULL, NULL),
(23, 'PLAYERS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(24, 'TEAMS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(25, 'TRAINERS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(26, 'ADMIN', NULL, 1, 0, NULL, '2020-06-13 11:41:45', NULL, NULL),
(27, 'VIDEO_ANALYTICS', NULL, 1, 0, NULL, '2020-06-18 14:55:23', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `red_card`
--

DROP TABLE IF EXISTS `red_card`;
CREATE TABLE IF NOT EXISTS `red_card` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `LIGA_ID` int(11) NOT NULL,
  `HELYEZES` int(11) NOT NULL,
  `NEV` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `CARD` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_r_org_id` (`ORG_ID`),
  KEY `fk_r_liga_id` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(200) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `DELETABLE` tinyint(1) DEFAULT '0',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_role_name_uq` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'ADMIN', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(2, 'PLAYER', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(3, 'TRAINER', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(4, 'OWNER', NULL, 1, 0, NULL, '2020-05-27 15:27:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role_privileges`
--

DROP TABLE IF EXISTS `role_privileges`;
CREATE TABLE IF NOT EXISTS `role_privileges` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(11) NOT NULL,
  `PRIVILEGE_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_role_priv_uq` (`ROLE_ID`,`PRIVILEGE_ID`),
  KEY `fk_role_priv_priv_id` (`PRIVILEGE_ID`),
  KEY `fk_role_role_id` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `role_privileges`
--

INSERT INTO `role_privileges` (`ID`, `ROLE_ID`, `PRIVILEGE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 1, 1, NULL, '2020-09-26 08:27:38', NULL, NULL),
(2, 1, 26, 1, NULL, '2020-09-26 08:30:05', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `scene`
--

DROP TABLE IF EXISTS `scene`;
CREATE TABLE IF NOT EXISTS `scene` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `FOLDER_ID` int(11) DEFAULT NULL,
  `VIDEO_ID` int(11) DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sorsolas`
--

DROP TABLE IF EXISTS `sorsolas`;
CREATE TABLE IF NOT EXISTS `sorsolas` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LIGA_ID` int(11) NOT NULL,
  `HAZAI` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `HAZAI_IMG` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `EREDMENY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VENDEG` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VENDEG_IMG` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DATUM` timestamp NULL DEFAULT NULL,
  `HELY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_rsors_liga_id` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` varchar(36) COLLATE utf8mb4_bin NOT NULL,
  `CREATION_TIME` bigint(20) DEFAULT NULL,
  `EXPIRY_TIME` longblob,
  `LAST_ACCESS_TIME` longblob,
  `MAX_INACTIVE_INTERVAL` int(11) DEFAULT NULL,
  `PRINCIPAL_NAME` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `SESSION_ID` longtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`PRIMARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `ATTRIBUTE_NAME` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `ATTRIBUTE_BYTES` longblob,
  `SESSION_PRIMARY_ID` varchar(36) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`ATTRIBUTE_NAME`,`SESSION_PRIMARY_ID`),
  KEY `FK_SPR_SESS_ATT_SPR_SESS` (`SESSION_PRIMARY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tabella`
--

DROP TABLE IF EXISTS `tabella`;
CREATE TABLE IF NOT EXISTS `tabella` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LIGA_ID` int(11) DEFAULT NULL,
  `FORDULO` int(11) DEFAULT NULL,
  `HELYEZES` int(11) DEFAULT NULL,
  `CSAPAT` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `MECSEK_SZAMA` int(11) DEFAULT NULL,
  `GYOZELMEK_SZAMA` int(11) DEFAULT NULL,
  `DONTETLENEK_SZAMA` int(11) DEFAULT NULL,
  `VERESEGEK_SZAMA` int(11) DEFAULT NULL,
  `LOTT_GOLOK_SZAMA` int(11) DEFAULT NULL,
  `KAPOTT_GOLOK_SZAMA` int(11) DEFAULT NULL,
  `GOLKULONBSEG` int(11) DEFAULT NULL,
  `PONTSZAM` int(11) DEFAULT NULL,
  `ELLENFELEK_HELYEZESEK_ATLAGA` varchar(11) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `FROMA_1` varchar(2) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `FROMA_2` varchar(2) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `FORMA_3` varchar(2) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `FORMA_4` varchar(2) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `FORMA_5` varchar(2) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_play_uq` (`LIGA_ID`,`FORDULO`,`HELYEZES`),
  KEY `fk_liga_tab` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainer_rating`
--

DROP TABLE IF EXISTS `trainer_rating`;
CREATE TABLE IF NOT EXISTS `trainer_rating` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `DONE` tinyint(1) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainer_rating_result`
--

DROP TABLE IF EXISTS `trainer_rating_result`;
CREATE TABLE IF NOT EXISTS `trainer_rating_result` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `TRAINER_ID` int(11) NOT NULL,
  `RESULT` int(11) DEFAULT NULL,
  `RATING_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `training_planner`
--

DROP TABLE IF EXISTS `training_planner`;
CREATE TABLE IF NOT EXISTS `training_planner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORGANIZATION_ID` int(11) DEFAULT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `TRAINING_DATE` timestamp NULL DEFAULT NULL,
  `EXERCISE_1_ID` int(11) DEFAULT NULL,
  `EXERCISE_1_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_2_ID` int(11) DEFAULT NULL,
  `EXERCISE_2_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_3_ID` int(11) DEFAULT NULL,
  `EXERCISE_3_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_4_ID` int(11) DEFAULT NULL,
  `EXERCISE_4_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_5_ID` int(11) DEFAULT NULL,
  `EXERCISE_5_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_6_ID` int(11) DEFAULT NULL,
  `EXERCISE_6_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_7_ID` int(11) DEFAULT NULL,
  `EXERCISE_7_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_8_ID` int(11) DEFAULT NULL,
  `EXERCISE_8_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_9_ID` int(11) DEFAULT NULL,
  `EXERCISE_9_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_10_ID` int(11) DEFAULT NULL,
  `EXERCISE_10_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_11_ID` int(11) DEFAULT NULL,
  `EXERCISE_11_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_12_ID` int(11) DEFAULT NULL,
  `EXERCISE_12_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_13_ID` int(11) DEFAULT NULL,
  `EXERCISE_13_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_14_ID` int(11) DEFAULT NULL,
  `EXERCISE_14_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_15_ID` int(11) DEFAULT NULL,
  `EXERCISE_15_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_16_ID` int(11) DEFAULT NULL,
  `EXERCISE_16_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_17_ID` int(11) DEFAULT NULL,
  `EXERCISE_17_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_18_ID` int(11) DEFAULT NULL,
  `EXERCISE_18_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_19_ID` int(11) DEFAULT NULL,
  `EXERCISE_19_TIME_MIN` int(11) DEFAULT NULL,
  `EXERCISE_20_ID` int(11) DEFAULT NULL,
  `EXERCISE_20_TIME_MIN` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_TRAINING_ORG_idx` (`ORGANIZATION_ID`),
  KEY `fk_TRAINING_LOOKUP_idx` (`TEAM_ID`),
  KEY `fk_TRAINING_E1_idx` (`EXERCISE_1_ID`),
  KEY `fk_TRAINING_E2_idx` (`EXERCISE_2_ID`),
  KEY `fk_TRAINING_E3_idx` (`EXERCISE_3_ID`),
  KEY `fk_TRAINING_E4_idx` (`EXERCISE_4_ID`),
  KEY `fk_TRAINING_E5_idx` (`EXERCISE_5_ID`),
  KEY `fk_TRAINING_E6_idx` (`EXERCISE_6_ID`),
  KEY `fk_TRAINING_E7_idx` (`EXERCISE_7_ID`),
  KEY `fk_TRAINING_E8_idx` (`EXERCISE_8_ID`),
  KEY `fk_TRAINING_E_9idx` (`EXERCISE_9_ID`),
  KEY `fk_TRAINING_E_10idx` (`EXERCISE_10_ID`),
  KEY `fk_TRAINING_E11_idx` (`EXERCISE_11_ID`),
  KEY `fk_TRAINING_E12_idx` (`EXERCISE_12_ID`),
  KEY `fk_TRAINING_E_13idx` (`EXERCISE_13_ID`),
  KEY `fk_TRAINING_E_i14dx` (`EXERCISE_14_ID`),
  KEY `fk_TRAINING_E_idx15` (`EXERCISE_15_ID`),
  KEY `fk_TRAINING_E16_idx` (`EXERCISE_16_ID`),
  KEY `fk_TRAINING_E_i17dx` (`EXERCISE_17_ID`),
  KEY `fk_TRAINING_E_18idx` (`EXERCISE_18_ID`),
  KEY `fk_TRAINING_E_19idx` (`EXERCISE_19_ID`),
  KEY `fk_TRAINING_E_20idx` (`EXERCISE_20_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó felhasználóneve',
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó neve',
  `PASSWORD` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL COMMENT 'A felhasználó jelszava BCrypt-el encryptelve',
  `PROFIL_IMG` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT '/content/baseImages/userphoto.png',
  `EMAIL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL COMMENT 'A felhasználó email címe',
  `PHONE_NUMBER` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL COMMENT 'Telefon szám',
  `DATABANK_URL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PLAYER` tinyint(1) NOT NULL DEFAULT '0',
  `TRAINER` tinyint(1) DEFAULT '0',
  `DELETED` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Törölve van-e a felhasználó',
  `ENABLED` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Felhasználó engedélyezve van-e',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`ID`, `USERNAME`, `NAME`, `PASSWORD`, `PROFIL_IMG`, `EMAIL`, `PHONE_NUMBER`, `DATABANK_URL`, `PLAYER`, `TRAINER`, `DELETED`, `ENABLED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'Admin', 'Adminisztrátor', '$2a$10$PvXhF9vBrFEYhZ/4Bj31tuT4z0HAXZpxd5QwoHX6C7/IAeCAfwoJe', 'userphoto.png', 'redlymatyi@gmail.com', 'asd', '', 0, 0, 0, 1, 1, NULL, '2020-02-16 14:08:05', '2020-06-13 15:54:45', 'Admin');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_notification`
--

DROP TABLE IF EXISTS `user_notification`;
CREATE TABLE IF NOT EXISTS `user_notification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `SRC` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `TITLE` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `SEEN` tinyint(1) NOT NULL DEFAULT '0',
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_noti_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_organization`
--

DROP TABLE IF EXISTS `user_organization`;
CREATE TABLE IF NOT EXISTS `user_organization` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) NOT NULL,
  `LIGA_ID` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_org_uq` (`USER_ID`,`ORGANIZATION_ID`,`TEAM_ID`) USING BTREE,
  KEY `fk_usr_org_idx` (`ORGANIZATION_ID`),
  KEY `FK_usr_org_LOOKUP_CODE_idx` (`TEAM_ID`),
  KEY `fk_usr_org1_idx` (`USER_ID`),
  KEY `LIGA_ID` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_post`
--

DROP TABLE IF EXISTS `user_post`;
CREATE TABLE IF NOT EXISTS `user_post` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ORGANIZATION_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `POST` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `IMAGE_URL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_org_idx1` (`ORGANIZATION_ID`),
  KEY `fk_usr_org1_idx1` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_post_comments`
--

DROP TABLE IF EXISTS `user_post_comments`;
CREATE TABLE IF NOT EXISTS `user_post_comments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `POST_ID` int(11) NOT NULL,
  `COMMENT` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usr_org_idx1` (`POST_ID`),
  KEY `fk_usr_org1_idx1` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_privileges`
--

DROP TABLE IF EXISTS `user_privileges`;
CREATE TABLE IF NOT EXISTS `user_privileges` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `PRIVILEGE_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_priv_uq` (`USER_ID`,`PRIVILEGE_ID`),
  KEY `FK_user_priv_priv_id` (`PRIVILEGE_ID`),
  KEY `fk_user_user_id` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_role_uq` (`USER_ID`,`ROLE_ID`),
  KEY `FK_user_roles_role_id` (`ROLE_ID`),
  KEY `fk_usr_usr_id` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_roles`
--

INSERT INTO `user_roles` (`ID`, `USER_ID`, `ROLE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 1, 1, NULL, '2020-02-16 14:08:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `video`
--

DROP TABLE IF EXISTS `video`;
CREATE TABLE IF NOT EXISTS `video` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `videoeditor`
--

DROP TABLE IF EXISTS `videoeditor`;
CREATE TABLE IF NOT EXISTS `videoeditor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `TEAM_ID` int(11) DEFAULT NULL,
  `SORSOLAS_ID` int(11) DEFAULT NULL,
  `CUSTOM_GAME_ID` int(11) DEFAULT NULL,
  `TRAINING_ID` int(11) DEFAULT NULL,
  `VIDEO_ID` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `video_analyzer`
--

DROP TABLE IF EXISTS `video_analyzer`;
CREATE TABLE IF NOT EXISTS `video_analyzer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `SORSOLAS_ID` int(11) DEFAULT NULL,
  `CUSTOM_GAME_ID` int(11) DEFAULT NULL,
  `VIDEO_URL` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CONTENT_TYPE` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_o_UP_idx` (`ORG_ID`),
  KEY `fk_s_UP_idx` (`SORSOLAS_ID`),
  KEY `fk_u_UP_idx` (`CUSTOM_GAME_ID`)
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
  `RESULT` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `PERCENT` int(11) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_WK_idx` (`TRAINING_ID`),
  KEY `FK_WK_LOOKUP_CODE_idx` (`EXERCISE_ID`),
  KEY `fk_us_WK_idx` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `yellow_card`
--

DROP TABLE IF EXISTS `yellow_card`;
CREATE TABLE IF NOT EXISTS `yellow_card` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
  `LIGA_ID` int(11) NOT NULL,
  `HELYEZES` int(11) NOT NULL,
  `NEV` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `CARD` int(11) NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_y_org_id` (`ORG_ID`),
  KEY `fk_y_liga_id` (`LIGA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `exercise`
--
ALTER TABLE `exercise`
  ADD CONSTRAINT `fk_EXERCISE_1` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `organization` (`ID`),
  ADD CONSTRAINT `fk_EXERCISE_2` FOREIGN KEY (`TYPE`) REFERENCES `lookup_code` (`ID`);

--
-- Megkötések a táblához `training_planner`
--
ALTER TABLE `training_planner`
  ADD CONSTRAINT `fk_TRAINING_EXERCISE341234` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `organization` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_1` FOREIGN KEY (`EXERCISE_1_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_10` FOREIGN KEY (`EXERCISE_10_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_11` FOREIGN KEY (`EXERCISE_11_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_12` FOREIGN KEY (`EXERCISE_12_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_13` FOREIGN KEY (`EXERCISE_13_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_14` FOREIGN KEY (`EXERCISE_14_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_15` FOREIGN KEY (`EXERCISE_15_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_16` FOREIGN KEY (`EXERCISE_16_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_17` FOREIGN KEY (`EXERCISE_17_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_18` FOREIGN KEY (`EXERCISE_18_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_19` FOREIGN KEY (`EXERCISE_19_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_2` FOREIGN KEY (`EXERCISE_2_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_20` FOREIGN KEY (`EXERCISE_20_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_3` FOREIGN KEY (`EXERCISE_3_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_4` FOREIGN KEY (`EXERCISE_4_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_5` FOREIGN KEY (`EXERCISE_5_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_6` FOREIGN KEY (`EXERCISE_6_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_7` FOREIGN KEY (`EXERCISE_7_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_8` FOREIGN KEY (`EXERCISE_8_ID`) REFERENCES `exercise` (`ID`),
  ADD CONSTRAINT `fk_TRAINING_EXERCISE_9` FOREIGN KEY (`EXERCISE_9_ID`) REFERENCES `exercise` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
