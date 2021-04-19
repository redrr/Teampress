-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3308
-- Létrehozás ideje: 2021. Ápr 19. 16:04
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
-- Adatbázis: `teampress_dev1`
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
  `CURRENCY` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'HUF',
  `PUBLIC_KEY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `PRIVATE_KEY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME_UNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `club`
--

INSERT INTO `club` (`ID`, `NAME`, `TYPE`, `CURRENCY`, `PUBLIC_KEY`, `PRIVATE_KEY`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'DLC', 'football', 'HUF', 'ASD', 'AS', 1, 'Admin', '2021-03-31 13:34:43', '2021-04-19 15:01:08', 'Admin');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `clubdata`
--

INSERT INTO `clubdata` (`ID`, `ORG_ID`, `COUNTRY_CODE`, `NAME`, `CITY`, `POST_CODE`, `STREET`, `STREET2`, `PRIMARY_OC`, `TEMP`, `TYPE`, `TEMP_UPDATE`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 'Magyarország', 'Demo Labdarugó Klub', 'Budapest', '2013', 'Mikszáth Kálmán utca', '17', NULL, NULL, NULL, NULL, 1, 'Admin', '2021-03-31 13:34:43', '2021-04-19 15:01:22', 'Admin');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `income`
--

INSERT INTO `income` (`ID`, `ORG_ID`, `UUID`, `NAME`, `INCOME`, `PRIZE`, `ACCEPTED`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(2, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-13 15:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(3, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-03-29 15:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(4, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-03-22 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(5, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-03-18 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(6, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-03-10 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(7, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-02-22 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(8, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-02-20 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(9, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-02-14 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a'),
(10, 1, NULL, 'Tagdíj', 1, 5000, 1, 0, 1, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-01-14 16:42:53', '2021-04-19 15:44:40', '468686d4-f038-4830-a1b8-8fd0a133935a');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `incomegroup`
--

INSERT INTO `incomegroup` (`ID`, `ORG_ID`, `NAME`, `DESCRIPTION`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 'Tagdíj', 'Havi tagdíjak', 0, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:42:10', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `incomegroupconnection`
--

INSERT INTO `incomegroupconnection` (`ID`, `ORG_ID`, `INCOME_ID`, `GROUP_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 1, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:33', NULL, NULL),
(2, 1, 2, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:36', NULL, NULL),
(3, 1, 3, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:38', NULL, NULL),
(4, 1, 4, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:41', NULL, NULL),
(5, 1, 5, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:43', NULL, NULL),
(6, 1, 6, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:45', NULL, NULL),
(7, 1, 7, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:47', NULL, NULL),
(8, 1, 8, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:49', NULL, NULL),
(9, 1, 9, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:51', NULL, NULL),
(10, 1, 10, 1, 0, '468686d4-f038-4830-a1b8-8fd0a133935a', '2021-04-19 15:48:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lineup`
--

DROP TABLE IF EXISTS `lineup`;
CREATE TABLE IF NOT EXISTS `lineup` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_ID` int(11) NOT NULL,
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
  UNIQUE KEY `SORSOLAS_ID` (`USER_ID`),
  KEY `fk_o_LOOKUP_idx` (`ORG_ID`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

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
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_lgroup_code_uq` (`LGROUP`,`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `lookupcode`
--

INSERT INTO `lookupcode` (`ID`, `LGROUP`, `CODE`, `NAME`, `DESCRIPTION`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATED_BY`, `LAST_UPDATE_DATE`) VALUES
(1, 'EXERCISE_TYPE', 'Csillagok', NULL, NULL, 1, NULL, '2020-02-16 15:09:43', NULL, NULL),
(2, 'EXERCISE_TYPE', 'Szöveges értékelés', NULL, NULL, 1, NULL, '2020-02-16 15:09:43', NULL, NULL),
(3, 'EXERCISE_TYPE', '1-10 -es skála', NULL, NULL, 1, NULL, '2020-02-16 15:11:03', NULL, NULL),
(4, 'EXERCISE_TYPE', 'Százalék', NULL, NULL, 1, NULL, '2020-02-16 15:11:03', NULL, NULL),
(5, 'EXERCISE_TYPE', 'Sikeres/darabszám', NULL, NULL, 1, NULL, '2020-02-16 15:11:39', NULL, NULL),
(6, 'TEAM_TYPE', 'U-14', NULL, NULL, 1, NULL, '2020-04-14 11:57:53', NULL, NULL),
(7, 'TEAM_TYPE', 'U-16', NULL, NULL, 1, NULL, '2020-04-14 11:57:53', NULL, NULL),
(8, 'TEAM_TYPE', 'U-18', '', '', 0, 'Admin', '2021-04-17 17:31:07', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `parameter`
--

INSERT INTO `parameter` (`ID`, `GROUP`, `CODE`, `VALUE`, `ATTR1`, `ATTR2`, `ATTR3`, `ATTR4`, `ATTR5`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'TRAINER_RATING', 'KECSKEMÉTI LC', '2', NULL, NULL, NULL, NULL, NULL, 1, b'0', NULL, '2020-07-20 16:38:23', NULL, NULL),
(2, 'SYSTEM', 'FOLDER_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\folderImages\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:33', 'Admin'),
(3, 'SYSTEM', 'UPLOAD_FOLDER', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\videoAnalytics\\upload\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:46', 'Admin'),
(4, 'SYSTEM', 'SCENE_FOLDER', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\videoAnalytics\\scene\\', '', '', '', '', '', 3, b'0', NULL, '2020-10-31 08:41:40', '2021-01-12 09:55:57', 'Admin'),
(5, 'SYSTEM', 'POST_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\postImages\\', '', '', '', '', '', 1, b'0', 'Admin', '2020-10-31 08:49:35', '2021-01-12 09:56:04', 'Admin'),
(6, 'SYSTEM', 'PROFILE_IMG', 'D:\\Projects\\PlaymakerProjects\\git\\TeampressDev\\application\\playmaker_v0.1\\src\\main\\webapp\\content\\profileImages\\', '', '', '', '', '', 2, b'0', 'Admin', '2020-10-31 08:51:37', '2021-01-12 09:56:12', 'Admin'),
(7, 'SYSTEM', 'DOMAIN', 'http://localhost:8080', '', '', '', '', '', 2, b'0', 'Admin', '2020-10-31 08:51:37', '2021-01-12 09:56:12', 'Admin');

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `permission`
--

INSERT INTO `permission` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'LOGGED_IN', NULL, 1, 0, NULL, '2020-02-16 14:08:05', NULL, NULL),
(2, 'HOME_HEADER_BUTTONS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(3, 'POST_COMMENT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(4, 'POST_COMMENT_READ', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(5, 'CAREER_HEADER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(6, 'CAREER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(7, 'EXERCISE_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(8, 'EXERCISE_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(9, 'TRAIN_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(10, 'TRAIN_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(11, 'WORKOUT_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(12, 'WORKOUT_PLAYER_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(13, 'WORKOUT_ALL_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(14, 'PLANNER', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(15, 'PLANS_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(16, 'COST_CREATE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(17, 'COST_TABLE', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(18, 'COST_ACCEPT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(19, 'GROUP_COSTS', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(20, 'STATEMENT', NULL, 1, 0, NULL, '2020-05-27 15:32:35', NULL, NULL),
(21, 'PLANS_CREATE', NULL, 1, 0, NULL, '2020-06-01 13:39:38', NULL, NULL),
(22, 'ADMIN', NULL, 1, 0, NULL, '2020-06-13 11:41:45', NULL, NULL),
(23, 'VIDEO_ANALYTICS', NULL, 1, 0, NULL, '2020-06-18 14:55:23', NULL, NULL),
(24, 'EVENT_CREATE', NULL, 1, 0, NULL, '2020-09-26 10:52:11', NULL, NULL),
(25, 'HOME_WEATHER', NULL, 1, 0, NULL, '2020-10-17 11:07:21', NULL, NULL),
(26, 'EVENT_OWNER', NULL, 1, 0, NULL, '2021-03-02 10:28:57', NULL, NULL),
(27, 'VIDEO_ANALYTICS_EDIT', NULL, 1, 0, NULL, '2021-03-02 17:57:51', NULL, NULL),
(28, 'ANNUAL_COST_CREATE', NULL, 1, 0, NULL, '2021-03-04 10:31:55', NULL, NULL),
(29, 'MY_TEAM', NULL, 1, 0, NULL, '2021-04-18 05:20:57', NULL, NULL),
(30, 'MY_CLUB', NULL, 1, 0, NULL, '2021-04-18 05:20:57', NULL, NULL),
(31, 'DELETE_POST_COMMENT', NULL, 1, 0, NULL, '2021-04-18 15:09:38', NULL, NULL);

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
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_role_name_uq` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`ID`, `NAME`, `DESCRIPTION`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'PLAYER', NULL, 1, NULL, '2020-02-16 14:08:05', NULL, NULL),
(2, 'ADMIN', NULL, 1, NULL, '2020-02-16 14:08:05', NULL, NULL),
(3, 'TRAINER', NULL, 1, NULL, '2020-02-16 14:08:05', NULL, NULL),
(4, 'OWNER', NULL, 1, NULL, '2020-05-27 15:27:26', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `rolepermission`
--

INSERT INTO `rolepermission` (`ID`, `ROLE_ID`, `PRIVILEGE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 1, 1, NULL, '2020-05-28 06:39:31', NULL, NULL),
(2, 1, 4, 1, NULL, '2020-05-28 06:51:18', NULL, NULL),
(3, 1, 3, 1, NULL, '2020-05-28 06:52:07', NULL, NULL),
(4, 1, 6, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(5, 1, 5, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(6, 1, 12, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(7, 1, 15, 1, NULL, '2020-05-28 06:53:00', NULL, NULL),
(8, 3, 1, 1, NULL, '2020-05-28 06:39:31', NULL, NULL),
(9, 3, 3, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(10, 3, 4, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(11, 3, 6, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(12, 3, 7, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(13, 3, 8, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(14, 3, 9, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(15, 3, 10, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(16, 3, 11, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(17, 3, 13, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(18, 3, 14, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(19, 4, 1, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(20, 4, 3, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(21, 4, 4, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(22, 4, 6, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(23, 4, 13, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(24, 4, 15, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(25, 4, 16, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(26, 4, 17, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(27, 4, 18, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(28, 4, 19, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(29, 4, 20, 1, NULL, '2020-05-28 11:48:44', NULL, NULL),
(30, 3, 21, 1, NULL, '2020-06-01 13:40:08', NULL, NULL),
(31, 1, 2, 1, NULL, '2020-06-02 16:33:55', NULL, NULL),
(32, 2, 1, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(33, 2, 22, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(34, 3, 23, 1, NULL, '2020-06-18 14:55:47', NULL, NULL),
(35, 3, 24, 1, NULL, '2020-05-28 09:52:34', NULL, NULL),
(36, 1, 25, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(37, 3, 25, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(38, 4, 25, 1, NULL, '2020-10-17 11:08:43', NULL, NULL),
(39, 4, 24, 1, NULL, '2021-03-02 10:23:41', NULL, NULL),
(40, 4, 26, 1, NULL, '2021-03-02 10:29:23', NULL, NULL),
(41, 3, 27, 1, NULL, '2021-03-02 17:58:18', NULL, NULL),
(42, 1, 23, 1, NULL, '2021-03-02 17:59:07', NULL, NULL),
(43, 4, 23, 1, NULL, '2021-03-02 17:59:07', NULL, NULL),
(44, 4, 28, 1, NULL, '2021-03-04 10:32:40', NULL, NULL),
(45, 3, 16, 1, NULL, '2021-03-04 10:33:26', NULL, NULL),
(46, 3, 29, 0, 'Admin', '2021-04-18 05:22:15', NULL, NULL),
(47, 4, 30, 0, 'Admin', '2021-04-18 05:22:25', NULL, NULL),
(48, 3, 31, 0, 'Admin', '2021-04-18 15:10:00', NULL, NULL),
(49, 4, 31, 0, 'Admin', '2021-04-18 15:10:08', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`ID`, `USERNAME`, `NAME`, `PASSWORD`, `PROFIL_IMG`, `EMAIL`, `PHONE_NUMBER`, `PLAYER`, `TRAINER`, `DELETED`, `ENABLED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'Admin', 'Adminisztrátor', '$2a$10$OC37s80ZifU4UhS1YSbt1.NFMcv0dA3fvwPiH5KxOoJw16Ma14gKC', 'userphoto.png', 'redlymatyi@gmail.com', 'asd', 0, 0, 0, 1, 11, NULL, '2020-02-16 14:08:05', '2021-04-17 08:40:59', NULL),
(2, '5a9c29bd-6ee7-424e-aa4e-54c39b2b9650', 'Pintér Róbert', '$2a$10$DLwnnaUuBMYvhiugb6zOie3ndlH4qwKZNWR27cQHAnOdTLZwJrb5G', 'userphoto.png', 'app.teampress+21@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:51', NULL, NULL),
(3, 'c4a69040-7e1d-4663-ac49-44b6e49d9efb', 'Czinege Henrik', '$2a$10$mPJsxZ7iG8JBMr7HsPVfXOHUDobGzMVX6dGGCxdEptSSPdWOxmCem', 'userphoto.png', 'app.teampress+22@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:53', NULL, NULL),
(4, '2248a2da-eb86-4e4a-8085-c4d63f851476', 'Hosszu Károly', '$2a$10$Km4.mglYmFKtKvZrny0nE.jeDV2pe7HShyn4F/XzwU3gB5AF9gfMi', 'userphoto.png', 'app.teampress+23@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:54', NULL, NULL),
(5, 'a014a809-4a19-4ba7-bb44-4225d779a643', 'Einbecker Rudolf', '$2a$10$aRN.hd.BJl.zU0/6J2qI2eia8rxH0STlJV4lm7fkj3E9bm5TuTydm', 'userphoto.png', 'app.teampress+24@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:55', NULL, NULL),
(6, 'e70d8908-7b7b-4e78-adbd-72fe1caf9c68', 'Skopp József', '$2a$10$dF0YiRVItfs7CLP23mRKoO0CRFaCxm5KeC7W4nZS2PBOZWJM3KAgK', 'userphoto.png', 'app.teampress+25@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:56', NULL, NULL),
(7, '0756ee33-bdfa-4424-8fd2-ebc2fee4c0ce', 'Molnár Máté', '$2a$10$xLT00IhZ78LfiELZz/mFs.9fZfUfHtCBGf0NWd2Q75BJhxaU4nJJ6', 'userphoto.png', 'app.teampress+26@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:57', NULL, NULL),
(8, '2ec7ca69-b41e-48c9-8187-8bf371a297d2', 'Terbe Donát', '$2a$10$UdhZEXZmhlmAx7M/bpsBaeB2EM6OQsf0BRxTQW2310tQY6TVN4/56', 'userphoto.png', 'app.teampress+27@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:01:59', NULL, NULL),
(9, '367f0766-e32b-40ae-8116-e0db3864e0a9', 'Münchausen Dominik', '$2a$10$Vwc.ke1mCcnQi79KhO3ZFer/rNYykB5aAlW8iKO5Dk/S7olGelUEC', 'userphoto.png', 'app.teampress+28@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:00', NULL, NULL),
(10, 'c497e29f-ec0f-4e51-bed8-a9bd5bcdfd2c', 'Gera Zsolt', '$2a$10$Xn3GxDm6oluGdHzx8wytO.lX7hqTqLGOiqQ0l0HAeoHZKKmf1Yxi6', 'userphoto.png', 'app.teampress+29@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:01', NULL, NULL),
(11, 'ce44d173-f2d0-4520-8169-dd19aed4c43d', 'Fodor László', '$2a$10$3HbxJVVah/MJyelQWCvwvOJFAKvy/L7Sb/QzdRC0A17TiR06baqYi', 'userphoto.png', 'app.teampress+30@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:02', NULL, NULL),
(12, 'be57cdf2-323a-4700-a365-042290eaab09', 'Simonka Balázs', '$2a$10$Noy8pC/ppleT3o74M/m8UeMaQD.07KleCIQoyK0zKctPYAxXSogRu', 'userphoto.png', 'app.teampress+31@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:03', NULL, NULL),
(13, 'e08f669a-cbab-47c9-8643-386d1b3b38a1', 'Korsós Géza', '$2a$10$fNjYMHRTkfwfUMEfvtVvU.Jiy2.qajpovHzVx26iSM4YK60jYDzUC', 'userphoto.png', 'app.teampress+32@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:04', NULL, NULL),
(14, '597eaf9b-33dd-4242-becd-e43c10c64363', 'Hauszmann Menyhért', '$2a$10$Vy9gi0hQBzvW7X6UQVYn7upvWgvRuYkk9lhdkkC2YZVuZNUkIQynC', 'userphoto.png', 'app.teampress+33@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:06', NULL, NULL),
(15, 'fcca0473-197f-494e-9151-559667764507', 'Voldbaek Boldizsár', '$2a$10$6hBJYbQkQNFyi0cedXy/L.ooYajqV.W9ytGZQD1A6xg4m9SsWnJH.', 'userphoto.png', 'app.teampress+34@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:07', NULL, NULL),
(16, 'fd87c977-4295-46a2-a029-9a18798cabf3', 'Listók Sándor', '$2a$10$DZlVHwnBFTAjAX1cnJmkmOCBZGbzBLXDQPk.WCeShwt.4H4Q8cwqi', 'userphoto.png', 'app.teampress+35@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:08', NULL, NULL),
(17, '5bc6bb6a-1ae5-446f-a0b0-1bdce2a2d2b7', 'Cukor Bence', '$2a$10$qYMiEKZG48rx95Xc56CwoOqQl675cRWgqpMK5wxTJNxzvDkPJ9Qj.', 'userphoto.png', 'app.teampress+36@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:09', NULL, NULL),
(18, '7c643e0d-bf3b-4d79-a872-b12b26b621cf', 'Kele Zoltán', '$2a$10$gU/50P5KJrD6QgR4JWmufOITt9xFLQ2RzDwP1NDnFopp1Q/gedHWG', 'userphoto.png', 'app.teampress+37@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:10', NULL, NULL),
(19, '78d17923-1d69-42eb-a8fb-7bf3c8522ccb', 'Pál Endre', '$2a$10$UpYJK8ZABHJjV0ZFXdaSt.96U00Z7p8JxpiEC.YMgpamgsTnInVTO', 'userphoto.png', 'app.teampress+38@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:12', NULL, NULL),
(20, 'a76644ee-c429-4a18-9744-0b7ee92f7441', 'Zulka Simon', '$2a$10$bnTtQIk7hJ818m926FrEi.pxsttjQGn/ncmAQ5OXKPX2nyQmsqpqi', 'userphoto.png', 'app.teampress+40@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:13', NULL, NULL),
(21, '20e8939a-97f5-4206-9684-f42e03185b72', 'Kovács Tibor', '$2a$10$ptEDrfsaLqaxfx8cg/wrZOI1OM3CPTlawkQoT6rNRQJBiOz1dRnPi', 'userphoto.png', 'app.teampress+39@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:02:14', NULL, NULL),
(22, 'ebdf55d0-060e-43e9-a211-65ece79bfd87', 'Verdi Sándor', '$2a$10$toL98bBEFqkTPArdia2A8OU8XKV10KeddzrY/5/UeuURCkRtrjmGq', 'userphoto.png', 'app.teampress+1@gmail.com', NULL, 0, 1, 0, 1, 0, 'Admin', '2021-04-19 15:02:42', NULL, NULL),
(23, '301b8a14-39b8-457f-9a63-ef7369d627d9', 'Nagy Kristóf', '$2a$10$5O8VKQ944o7RmYeMOA1Au.LCQsvq3TgWxXfLQrLl6KSMUhje.GLaq', 'userphoto.png', 'sportolo@teampress.hu', NULL, 1, 0, 0, 1, 1, 'Admin', '2021-04-19 15:03:06', '2021-04-19 15:08:03', NULL),
(24, '02e5ba13-311e-4cf3-9598-9e56bd77c0f2', 'Tóth Benedek', '$2a$10$32Vv2Ry/yGCkq2crQmTWm.BBH/FAVmlSyo/9gZsIagUewgU9le8XS', 'userphoto.png', 'app.teampress+2@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:07', NULL, NULL),
(25, 'a89422b4-ee50-40e9-bac5-c8abaf949587', 'Jávor György', '$2a$10$EeGlOmOv1yrHSA5edCdCH.ULkHRwQe7uovRo7qVCJvJC3P42ONTvq', 'userphoto.png', 'app.teampress+3@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:09', NULL, NULL),
(26, '87153b12-fda9-4261-bf5c-6bea23dcabdc', 'Simon Gergő', '$2a$10$uFJolUtt04pEtVgOh3IId.fG.EKGEhtwiADwtqCLgQIQAbBnYuWje', 'userphoto.png', 'app.teampress+4@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:10', NULL, NULL),
(27, 'd3b56023-1bc9-4bd1-8841-046d5904a39e', 'Kispál István', '$2a$10$RS7zijH72obkF.tD8zRw5u9UMeS.cWaRBzt0Vi2ffdnl5lO6jLdXm', 'userphoto.png', 'app.teampress+5@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:11', NULL, NULL),
(28, '5c65bd2b-72d7-458c-aff5-9e7104de3a43', 'Mészáros Dávid', '$2a$10$4s8qhv5jTa..8Qu0kHR7C.P7jzVrH9WmFslHWDp9N1LkeO4KA7EHG', 'userphoto.png', 'app.teampress+6@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:13', NULL, NULL),
(29, '35cd6e25-b395-4fcc-9e93-2228fdae5a17', 'Zvara Ottó', '$2a$10$YH.DTmCwY3ltWGo5RGtDXur24p8uuumHIcCFNo77Jrf/141ADvzny', 'userphoto.png', 'app.teampress+7@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:14', NULL, NULL),
(30, '6931860d-5a23-4706-904b-2420d481d7a6', 'Nikola Ferenc', '$2a$10$f6qxJTk0aPxpZx/FdLlPveIw8zTj1EsOyBbN12gX61c/5.staifmK', 'userphoto.png', 'app.teampress+8@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:15', NULL, NULL),
(31, '22a2ef66-e9ae-4bb3-903e-14837510e3f2', 'Somogyi Máté', '$2a$10$jsUAwL/scvkwSSEIQ90dcuDY6u8maMpyM2BbdKl5xlpm2ZDxOJKje', 'userphoto.png', 'app.teampress+9@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:17', NULL, NULL),
(32, 'e5ab2724-ca56-4911-93a4-06bdc8a4ebfd', 'Szultán Tibor', '$2a$10$vS.ROJJmWcl0AHHvzXgTTe82VKQgkivdxNLZB.xBzeFdvCHODQWDi', 'userphoto.png', 'app.teampress+10@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:18', NULL, NULL),
(33, 'f08b2878-d1f9-4e03-aa14-3776bd5226e8', 'Halmavánszki Attila', '$2a$10$9Zzm.CTLZlZtRchaWaeL7eKVg6y4fDZvh4zq7iSjBF0OOY4MtUu4C', 'userphoto.png', 'app.teampress+11@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:19', NULL, NULL),
(34, 'fb87d6f5-b26d-4528-9c2e-7d607c6b5282', 'Cserép Barnabás', '$2a$10$qcihI.kwM7CcpuBcIpcpqejzuumtqbWp0VOu.GBtaZwJxfq8iRvWK', 'userphoto.png', 'app.teampress+12@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:20', NULL, NULL),
(35, '502a56e9-90ad-407e-bd07-c2c68fa4f86d', 'Balambér János', '$2a$10$GgeCG9TGB1Sc.fziBfQOVe3hfd192ChTzZc9/DYM06f/4tyqT/c9O', 'userphoto.png', 'app.teampress+13@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:21', NULL, NULL),
(36, '43749c98-7b96-4bda-983e-bff7e6435b54', 'Remete Mihály', '$2a$10$GjkIxto0iqZ9nOXyWQXXC.HgoVee53hKbwZcZdIFOVVFyD72N7q/y', 'userphoto.png', 'app.teampress+14@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:22', NULL, NULL),
(37, 'd1c1badb-c3e9-4bcf-8f49-c8e9ed7ed324', 'Tihanyi Miklós', '$2a$10$md41fCQ.gRr1CJljkpwU4.fmJtO96DPONP5rj2Y3aVnE5JZNU.I0y', 'userphoto.png', 'app.teampress+15@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:24', NULL, NULL),
(38, 'addc7f8e-f71d-4eaf-8190-2f28f6f191e8', 'Győri András', '$2a$10$a4IsVtbWisjADW5QVwl/0uzw0RNhRwhpvD1kvSYMeTEg4rN1iFJkS', 'userphoto.png', 'app.teampress+16@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:25', NULL, NULL),
(39, '199e4d65-f893-4e44-98a3-b9f1676372b7', 'Treiber Botond', '$2a$10$ip/LX1APpZ./1wWfF4eqaO5U3aIsuFsBJJZ2Z/B1ArWUkBy0G5k7.', 'userphoto.png', 'app.teampress+17@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:26', NULL, NULL),
(40, '6479e4c7-a4f2-40d3-9b19-f1f2613b38ff', 'Holló Dénes', '$2a$10$NqGlAGql8JzMPeUrwCsruuXjXr6t20m1Ofz9RYbx0MT3SjpzdXLj2', 'userphoto.png', 'app.teampress+18@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:27', NULL, NULL),
(41, '31930ee9-b1c6-47d5-99d6-88842d9281ec', 'Szöllősi Gábor', '$2a$10$8EMcpo.N5IsLFEEdlOZzXeUu.YCULLlK9zVQVrVfwFiYHNUwEBNyO', 'userphoto.png', 'app.teampress+19@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:28', NULL, NULL),
(42, '87291695-bcfe-4dde-94c1-04bc73054a43', 'Király István', '$2a$10$l7zNfPNTvKLHczUUcEJtquyXU3TX3FLE2DKP2/NnUuHvUVDc6RBRK', 'userphoto.png', 'app.teampress+20@gmail.com', NULL, 1, 0, 0, 1, 0, 'Admin', '2021-04-19 15:03:29', NULL, NULL),
(43, '399bdeef-446f-418c-8643-d066592cbe73', 'Nagy Lajos', '$2a$10$U4B7sWKx/gnw7z3YjztaSesEOps4SNZ2gtJYy0s9EziTmOlL72sEa', 'userphoto.png', 'edzo@teampress.hu', NULL, 0, 1, 0, 1, 1, 'Admin', '2021-04-19 15:04:22', '2021-04-19 15:09:41', NULL),
(44, '468686d4-f038-4830-a1b8-8fd0a133935a', 'Dr. Kiss István', '$2a$10$OCzhB7fKSsoWOcRs8Oo4l.1xxjj9lMc24AWo2VI0ieLphAefz1l8e', 'userphoto.png', 'vezeto@teampress.hu', NULL, 0, 0, 0, 1, 1, 'Admin', '2021-04-19 15:04:35', '2021-04-19 15:12:17', NULL);

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
  `VERSION` int(11) DEFAULT '1',
  `CREATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_usr_org_uq` (`USER_ID`,`ORGANIZATION_ID`,`TEAM_ID`) USING BTREE,
  KEY `fk_usr_org_idx` (`ORGANIZATION_ID`),
  KEY `FK_usr_org_LOOKUP_CODE_idx` (`TEAM_ID`),
  KEY `fk_usr_org1_idx` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `userclub`
--

INSERT INTO `userclub` (`ID`, `USER_ID`, `ORGANIZATION_ID`, `TEAM_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 2, 1, 7, 0, 'Admin', '2021-04-19 15:01:53', NULL, NULL),
(2, 3, 1, 7, 0, 'Admin', '2021-04-19 15:01:54', NULL, NULL),
(3, 4, 1, 7, 0, 'Admin', '2021-04-19 15:01:55', NULL, NULL),
(4, 5, 1, 7, 0, 'Admin', '2021-04-19 15:01:56', NULL, NULL),
(5, 6, 1, 7, 0, 'Admin', '2021-04-19 15:01:57', NULL, NULL),
(6, 7, 1, 7, 0, 'Admin', '2021-04-19 15:01:59', NULL, NULL),
(7, 8, 1, 7, 0, 'Admin', '2021-04-19 15:02:00', NULL, NULL),
(8, 9, 1, 7, 0, 'Admin', '2021-04-19 15:02:01', NULL, NULL),
(9, 10, 1, 7, 0, 'Admin', '2021-04-19 15:02:02', NULL, NULL),
(10, 11, 1, 7, 0, 'Admin', '2021-04-19 15:02:03', NULL, NULL),
(11, 12, 1, 7, 0, 'Admin', '2021-04-19 15:02:04', NULL, NULL),
(12, 13, 1, 7, 0, 'Admin', '2021-04-19 15:02:05', NULL, NULL),
(13, 14, 1, 7, 0, 'Admin', '2021-04-19 15:02:07', NULL, NULL),
(14, 15, 1, 7, 0, 'Admin', '2021-04-19 15:02:08', NULL, NULL),
(15, 16, 1, 7, 0, 'Admin', '2021-04-19 15:02:09', NULL, NULL),
(16, 17, 1, 7, 0, 'Admin', '2021-04-19 15:02:10', NULL, NULL),
(17, 18, 1, 7, 0, 'Admin', '2021-04-19 15:02:12', NULL, NULL),
(18, 19, 1, 7, 0, 'Admin', '2021-04-19 15:02:13', NULL, NULL),
(19, 20, 1, 7, 0, 'Admin', '2021-04-19 15:02:14', NULL, NULL),
(20, 21, 1, 7, 0, 'Admin', '2021-04-19 15:02:17', NULL, NULL),
(21, 22, 1, 7, 0, 'Admin', '2021-04-19 15:02:43', NULL, NULL),
(22, 23, 1, 8, 0, 'Admin', '2021-04-19 15:03:07', NULL, NULL),
(23, 24, 1, 8, 0, 'Admin', '2021-04-19 15:03:08', NULL, NULL),
(24, 25, 1, 8, 0, 'Admin', '2021-04-19 15:03:10', NULL, NULL),
(25, 26, 1, 8, 0, 'Admin', '2021-04-19 15:03:11', NULL, NULL),
(26, 27, 1, 8, 0, 'Admin', '2021-04-19 15:03:12', NULL, NULL),
(27, 28, 1, 8, 0, 'Admin', '2021-04-19 15:03:14', NULL, NULL),
(28, 29, 1, 8, 0, 'Admin', '2021-04-19 15:03:15', NULL, NULL),
(29, 30, 1, 8, 0, 'Admin', '2021-04-19 15:03:16', NULL, NULL),
(30, 31, 1, 8, 0, 'Admin', '2021-04-19 15:03:18', NULL, NULL),
(31, 32, 1, 8, 0, 'Admin', '2021-04-19 15:03:19', NULL, NULL),
(32, 33, 1, 8, 0, 'Admin', '2021-04-19 15:03:20', NULL, NULL),
(33, 34, 1, 8, 0, 'Admin', '2021-04-19 15:03:21', NULL, NULL),
(34, 35, 1, 8, 0, 'Admin', '2021-04-19 15:03:22', NULL, NULL),
(35, 36, 1, 8, 0, 'Admin', '2021-04-19 15:03:23', NULL, NULL),
(36, 37, 1, 8, 0, 'Admin', '2021-04-19 15:03:25', NULL, NULL),
(37, 38, 1, 8, 0, 'Admin', '2021-04-19 15:03:26', NULL, NULL),
(38, 39, 1, 8, 0, 'Admin', '2021-04-19 15:03:27', NULL, NULL),
(39, 40, 1, 8, 0, 'Admin', '2021-04-19 15:03:28', NULL, NULL),
(40, 41, 1, 8, 0, 'Admin', '2021-04-19 15:03:29', NULL, NULL),
(41, 42, 1, 8, 0, 'Admin', '2021-04-19 15:03:30', NULL, NULL),
(42, 43, 1, 8, 0, 'Admin', '2021-04-19 15:04:23', NULL, NULL),
(43, 44, 1, 6, 0, 'Admin', '2021-04-19 15:04:36', NULL, NULL),
(44, 44, 1, 7, 0, 'Admin', '2021-04-19 15:04:51', NULL, NULL),
(45, 44, 1, 8, 0, 'Admin', '2021-04-19 15:05:16', NULL, NULL);

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
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
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
  `DELETED` tinyint(1) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `userrole`
--

INSERT INTO `userrole` (`ID`, `USER_ID`, `ROLE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 2, 1, NULL, '2021-04-17 17:07:27', NULL, NULL),
(2, 2, 1, 0, 'Admin', '2021-04-19 15:01:51', NULL, NULL),
(3, 3, 1, 0, 'Admin', '2021-04-19 15:01:53', NULL, NULL),
(4, 4, 1, 0, 'Admin', '2021-04-19 15:01:54', NULL, NULL),
(5, 5, 1, 0, 'Admin', '2021-04-19 15:01:55', NULL, NULL),
(6, 6, 1, 0, 'Admin', '2021-04-19 15:01:56', NULL, NULL),
(7, 7, 1, 0, 'Admin', '2021-04-19 15:01:57', NULL, NULL),
(8, 8, 1, 0, 'Admin', '2021-04-19 15:01:59', NULL, NULL),
(9, 9, 1, 0, 'Admin', '2021-04-19 15:02:00', NULL, NULL),
(10, 10, 1, 0, 'Admin', '2021-04-19 15:02:01', NULL, NULL),
(11, 11, 1, 0, 'Admin', '2021-04-19 15:02:02', NULL, NULL),
(12, 12, 1, 0, 'Admin', '2021-04-19 15:02:03', NULL, NULL),
(13, 13, 1, 0, 'Admin', '2021-04-19 15:02:04', NULL, NULL),
(14, 14, 1, 0, 'Admin', '2021-04-19 15:02:06', NULL, NULL),
(15, 15, 1, 0, 'Admin', '2021-04-19 15:02:07', NULL, NULL),
(16, 16, 1, 0, 'Admin', '2021-04-19 15:02:08', NULL, NULL),
(17, 17, 1, 0, 'Admin', '2021-04-19 15:02:09', NULL, NULL),
(18, 18, 1, 0, 'Admin', '2021-04-19 15:02:10', NULL, NULL),
(19, 19, 1, 0, 'Admin', '2021-04-19 15:02:12', NULL, NULL),
(20, 20, 1, 0, 'Admin', '2021-04-19 15:02:13', NULL, NULL),
(21, 21, 1, 0, 'Admin', '2021-04-19 15:02:14', NULL, NULL),
(22, 22, 3, 0, 'Admin', '2021-04-19 15:02:42', NULL, NULL),
(23, 23, 1, 0, 'Admin', '2021-04-19 15:03:06', NULL, NULL),
(24, 24, 1, 0, 'Admin', '2021-04-19 15:03:07', NULL, NULL),
(25, 25, 1, 0, 'Admin', '2021-04-19 15:03:09', NULL, NULL),
(26, 26, 1, 0, 'Admin', '2021-04-19 15:03:10', NULL, NULL),
(27, 27, 1, 0, 'Admin', '2021-04-19 15:03:11', NULL, NULL),
(28, 28, 1, 0, 'Admin', '2021-04-19 15:03:13', NULL, NULL),
(29, 29, 1, 0, 'Admin', '2021-04-19 15:03:14', NULL, NULL),
(30, 30, 1, 0, 'Admin', '2021-04-19 15:03:15', NULL, NULL),
(31, 31, 1, 0, 'Admin', '2021-04-19 15:03:17', NULL, NULL),
(32, 32, 1, 0, 'Admin', '2021-04-19 15:03:18', NULL, NULL),
(33, 33, 1, 0, 'Admin', '2021-04-19 15:03:19', NULL, NULL),
(34, 34, 1, 0, 'Admin', '2021-04-19 15:03:20', NULL, NULL),
(35, 35, 1, 0, 'Admin', '2021-04-19 15:03:21', NULL, NULL),
(36, 36, 1, 0, 'Admin', '2021-04-19 15:03:22', NULL, NULL),
(37, 37, 1, 0, 'Admin', '2021-04-19 15:03:24', NULL, NULL),
(38, 38, 1, 0, 'Admin', '2021-04-19 15:03:25', NULL, NULL),
(39, 39, 1, 0, 'Admin', '2021-04-19 15:03:26', NULL, NULL),
(40, 40, 1, 0, 'Admin', '2021-04-19 15:03:27', NULL, NULL),
(41, 41, 1, 0, 'Admin', '2021-04-19 15:03:28', NULL, NULL),
(42, 42, 1, 0, 'Admin', '2021-04-19 15:03:29', NULL, NULL),
(43, 43, 3, 0, 'Admin', '2021-04-19 15:04:22', NULL, NULL),
(44, 44, 4, 0, 'Admin', '2021-04-19 15:04:35', NULL, NULL);

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
