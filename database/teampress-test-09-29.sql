-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2020. Sze 26. 12:21
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
  `TEAM_ID` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `calendar`
--

INSERT INTO `calendar` (`ID`, `ORGANIZATION_ID`, `TEAM_ID`, `EVENT_NAME`, `EVENT_COLOR`, `START_DATE_TIME`, `END_DATE_TIME`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(63, 1, 5001, 'teszt-ut18', NULL, '2020-09-27 11:00:00', '2020-09-27 11:00:00', 0, 'Edzo', '2020-09-26 10:54:13', NULL, NULL),
(64, 1, 5001, 'teszt-ut18', NULL, '2020-09-27 11:00:00', '2020-09-27 11:00:00', 0, 'Edzo', '2020-09-26 10:56:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `custom_game`
--

DROP TABLE IF EXISTS `customgame`;
CREATE TABLE IF NOT EXISTS `customgame` (
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
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `custom_game`
--

INSERT INTO `customgame` (`ID`, `ORG_ID`, `TEAM_ID`, `ELLEN`, `DATUM`, `HELY`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(161, 1, 5001, 'DVSC', '2020-07-30 16:38:00', 'Kecsekemét', 0, 0, 'Edzo', '2020-07-22 16:38:30', NULL, NULL),
(162, 1, 5001, 'FTC', '2020-08-01 18:40:00', 'Kecskemét', 0, 0, 'Edzo', '2020-07-22 18:41:06', NULL, NULL),
(163, 1, 5001, 'asd', '2020-07-08 09:30:00', 'asd', 1, 2, 'Edzo', '2020-08-01 09:31:08', '2020-08-01 09:31:24', 'Edzo');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `exercise`
--

INSERT INTO `exercise` (`ID`, `NAME`, `TYPE`, `ORGANIZATION_ID`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(31, 'faljáték', 4993, 1, 0, 0, 'Edzo', '2020-06-19 21:15:26', NULL, NULL),
(32, '1 on 1 befejezés', 4995, 1, 0, 0, 'Edzo', '2020-06-19 21:15:36', NULL, NULL),
(33, '3v3 labdatartás', 4996, 1, 0, 0, 'Edzo', '2020-06-19 21:15:50', NULL, NULL),
(34, 'ívelgetés', 4995, 1, 0, 0, 'Edzo', '2020-06-19 21:16:09', NULL, NULL),
(35, '4v4 labdatartás', 4997, 1, 0, 0, 'Edzo', '2020-06-20 06:18:24', NULL, NULL),
(36, '5v5 területváltós labdatartás', 4997, 1, 0, 0, 'Edzo', '2020-06-20 06:18:46', NULL, NULL),
(37, 'iramjáték', 4994, 1, 0, 0, 'Edzo', '2020-06-20 06:18:58', NULL, NULL),
(38, 'húzóra ivás', 4995, 1, 0, 0, 'Edzo', '2020-07-24 22:42:20', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `folder`
--

INSERT INTO `folder` (`ID`, `ORG_ID`, `NAME`, `URL`, `DESCRIPTION`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(10, 1, 'Gólok', 'Edzo_d38395508b4f2eb38cfd2005a6d2b84d.jpg', 'Szerzett gólok a meccseken', 2, NULL, '2020-07-28 16:49:04', '2020-09-09 19:22:20', 'Edzo');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fordulo`
--

DROP TABLE IF EXISTS `turn`;
CREATE TABLE IF NOT EXISTS `turn` (
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
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `fordulo`
--

INSERT INTO `turn` (`ID`, `LIGA_ID`, `FORDULO`, `DATE_TO_POLL`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(130, 1, 30, NULL, 1, NULL, '2020-05-30 14:20:45', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gameplan`
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
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SORSOLAS_ID` (`SORSOLAS_ID`,`USER_ID`),
  KEY `fk_o_LOOKUP_idx` (`ORG_ID`),
  KEY `fk_s_LOOKUP_idx` (`SORSOLAS_ID`),
  KEY `fk_u_LOOKUP_idx` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `gameplan`
--

INSERT INTO `lineup` (`ID`, `ORG_ID`, `SORSOLAS_ID`, `CUSTOM_GAME_ID`, `USER_ID`, `ATTENDANCE`, `X`, `Y`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(84, 1, NULL, 161, 14, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(85, 1, NULL, 161, 15, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(86, 1, NULL, 161, 16, 2, 118, 169, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(87, 1, NULL, 161, 17, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(88, 1, NULL, 161, 18, 2, 397, 167, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(89, 1, NULL, 161, 19, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(90, 1, NULL, 161, 20, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(91, 1, NULL, 161, 21, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(92, 1, NULL, 161, 22, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(93, 1, NULL, 161, 23, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(94, 1, NULL, 161, 24, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(95, 1, NULL, 161, 25, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(96, 1, NULL, 161, 26, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(97, 1, NULL, 161, 27, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(98, 1, NULL, 161, 28, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(99, 1, NULL, 161, 29, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(100, 1, NULL, 161, 30, 1, NULL, NULL, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL),
(101, 1, NULL, 161, 10, 2, 272, 56, 0, 'Edzo', '2020-09-10 07:44:21', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `goals`
--

DROP TABLE IF EXISTS `goal`;
CREATE TABLE IF NOT EXISTS `goal` (
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
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `goals`
--

INSERT INTO `goal` (`ID`, `ORG_ID`, `LIGA_ID`, `FORD`, `HELYEZES`, `NEV`, `GOALS`, `FORD_GOAL`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(180, 1, 1, 1, 1, 'BOZSIK MÁTÉ', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(181, 1, 1, 1, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(182, 1, 1, 2, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(183, 1, 1, 2, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(184, 1, 1, 3, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(185, 1, 1, 3, 1, 'MAJOR DÁVID CSABA', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(186, 1, 1, 3, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(187, 1, 1, 4, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(188, 1, 1, 4, 1, 'MAJOR DÁVID CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(189, 1, 1, 4, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(190, 1, 1, 5, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(191, 1, 1, 5, 1, 'MAJOR DÁVID CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(192, 1, 1, 5, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(193, 1, 1, 5, 1, 'SZEDMÁK ROLAND JÁNOS', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(194, 1, 1, 6, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(195, 1, 1, 6, 1, 'MAJOR DÁVID CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(196, 1, 1, 6, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(197, 1, 1, 6, 1, 'SZEDMÁK ROLAND JÁNOS', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(198, 1, 1, 7, 1, 'BOZSIK MÁTÉ', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(199, 1, 1, 7, 1, 'MAJOR DÁVID CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(200, 1, 1, 7, 1, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(201, 1, 1, 7, 1, 'SZEDMÁK ROLAND JÁNOS', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(202, 1, 1, 8, 1, 'BOZSIK MÁTÉ', 3, 2, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(203, 1, 1, 8, 2, 'MAJOR DÁVID CSABA', 2, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(204, 1, 1, 8, 3, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(205, 1, 1, 8, 3, 'STEIN CSABA', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(206, 1, 1, 8, 3, 'SZEDMÁK ROLAND JÁNOS', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(207, 1, 1, 9, 1, 'BOZSIK MÁTÉ', 4, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(208, 1, 1, 9, 2, 'MAJOR DÁVID CSABA', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(209, 1, 1, 9, 3, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(210, 1, 1, 9, 3, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(211, 1, 1, 9, 3, 'SZEDMÁK ROLAND JÁNOS', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(212, 1, 1, 10, 1, 'BOZSIK MÁTÉ', 4, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(213, 1, 1, 10, 2, 'MAJOR DÁVID CSABA', 3, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(214, 1, 1, 10, 3, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(215, 1, 1, 10, 3, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(216, 1, 1, 10, 3, 'SZEDMÁK ROLAND JÁNOS', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(217, 1, 1, 11, 1, 'BOZSIK MÁTÉ', 5, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(218, 1, 1, 11, 2, 'MAJOR DÁVID CSABA', 4, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(219, 1, 1, 11, 3, 'SZEDMÁK ROLAND JÁNOS', 2, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(220, 1, 1, 11, 4, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(221, 1, 1, 11, 4, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(222, 1, 1, 11, 4, 'SZŰCS DOMINIK', 1, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(223, 1, 1, 12, 1, 'BOZSIK MÁTÉ', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(224, 1, 1, 12, 2, 'MAJOR DÁVID CSABA', 4, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(225, 1, 1, 12, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(226, 1, 1, 12, 4, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(227, 1, 1, 12, 4, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(228, 1, 1, 12, 4, 'SZŰCS DOMINIK', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(229, 1, 1, 13, 1, 'BOZSIK MÁTÉ', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(230, 1, 1, 13, 2, 'MAJOR DÁVID CSABA', 4, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(231, 1, 1, 13, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(232, 1, 1, 13, 4, 'BOGÁR IMRE', 2, 2, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(233, 1, 1, 13, 5, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(234, 1, 1, 13, 5, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(235, 1, 1, 13, 5, 'SZŰCS DOMINIK', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(236, 1, 1, 14, 1, 'BOZSIK MÁTÉ', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(237, 1, 1, 14, 2, 'MAJOR DÁVID CSABA', 4, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(238, 1, 1, 14, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(239, 1, 1, 14, 4, 'BOGÁR IMRE', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(240, 1, 1, 14, 4, 'SZŰCS DOMINIK', 2, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(241, 1, 1, 14, 6, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(242, 1, 1, 14, 6, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(243, 1, 1, 15, 1, 'BOZSIK MÁTÉ', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(244, 1, 1, 15, 1, 'MAJOR DÁVID CSABA', 5, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(245, 1, 1, 15, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(246, 1, 1, 15, 4, 'BOGÁR IMRE', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(247, 1, 1, 15, 4, 'SZŰCS DOMINIK', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(248, 1, 1, 15, 6, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(249, 1, 1, 15, 6, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(250, 1, 1, 16, 1, 'BOZSIK MÁTÉ', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(251, 1, 1, 16, 1, 'MAJOR DÁVID CSABA', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(252, 1, 1, 16, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(253, 1, 1, 16, 4, 'BOGÁR IMRE', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(254, 1, 1, 16, 4, 'SZŰCS DOMINIK', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(255, 1, 1, 16, 6, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(256, 1, 1, 16, 6, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(257, 1, 1, 17, 1, 'BOZSIK MÁTÉ', 7, 2, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(258, 1, 1, 17, 2, 'MAJOR DÁVID CSABA', 5, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(259, 1, 1, 17, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(260, 1, 1, 17, 4, 'BOGÁR IMRE', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(261, 1, 1, 17, 4, 'SZŰCS DOMINIK', 2, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(262, 1, 1, 17, 6, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(263, 1, 1, 17, 6, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(264, 1, 1, 18, 1, 'BOZSIK MÁTÉ', 8, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(265, 1, 1, 18, 2, 'MAJOR DÁVID CSABA', 6, 1, 0, 'system', '2020-06-21 11:57:27', NULL, NULL),
(266, 1, 1, 18, 3, 'SZEDMÁK ROLAND JÁNOS', 3, 0, 0, 'system', '2020-06-21 11:57:28', NULL, NULL),
(267, 1, 1, 18, 4, 'BOGÁR IMRE', 2, 0, 0, 'system', '2020-06-21 11:57:28', NULL, NULL),
(268, 1, 1, 18, 4, 'SZŰCS DOMINIK', 2, 0, 0, 'system', '2020-06-21 11:57:28', NULL, NULL),
(269, 1, 1, 18, 6, 'PUSZTAI ATTILA ISTVÁN', 1, 0, 0, 'system', '2020-06-21 11:57:28', NULL, NULL),
(270, 1, 1, 18, 6, 'STEIN CSABA', 1, 0, 0, 'system', '2020-06-21 11:57:28', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `income`
--

INSERT INTO `income` (`ID`, `ORG_ID`, `NAME`, `INCOME`, `PRIZE`, `ACCEPTED`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(10, 1, 'test', 1, 3000, 0, 1, 2, 'Tulajdonos', '2020-06-27 17:58:34', '2020-06-27 17:58:51', 'Tulajdonos'),
(11, 1, 'Admin', 0, 3000, 1, 1, 2, 'Tulajdonos', '2020-06-27 18:00:03', '2020-08-15 14:51:02', 'Tulajdonos'),
(12, 1, 'test', 1, 10000, 1, 0, 1, 'Tulajdonos', '2020-07-19 15:34:54', '2020-07-19 15:35:17', 'Tulajdonos'),
(13, 1, 'test2', 0, 2000, 1, 0, 1, 'Tulajdonos', '2020-07-19 15:51:31', '2020-07-19 15:51:36', 'Tulajdonos'),
(14, 1, 'testest', 0, 30000, 1, 0, 1, 'Tulajdonos', '2020-07-22 18:48:18', '2020-07-22 18:48:24', 'Tulajdonos'),
(15, 1, 'Vodka', 0, 35000, 1, 0, 2, 'Tulajdonos', '2020-07-24 23:20:04', '2020-07-24 23:21:19', 'Tulajdonos'),
(16, 1, 'Admin', 0, 1201231, 1, 0, 1, 'Tulajdonos', '2020-08-05 16:58:14', '2020-09-04 12:29:52', 'Tulajdonos'),
(17, 1, 'tesz', 1, 10000, 1, 0, 1, 'Tulajdonos', '2020-09-04 12:24:51', '2020-09-04 12:29:50', 'Tulajdonos'),
(18, 1, 'asdasd', 0, 10000, 1, 0, 1, 'Tulajdonos', '2020-09-04 12:25:51', '2020-09-04 12:26:07', 'Tulajdonos'),
(19, 1, 'tttt', 1, 2000, 1, 0, 1, 'Tulajdonos', '2020-09-04 12:29:23', '2020-09-04 12:29:47', 'Tulajdonos'),
(20, 1, 'eerwf', 1, 5000, 1, 0, 1, 'Tulajdonos', '2020-09-04 12:29:35', '2020-09-04 12:29:42', 'Tulajdonos');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income_group`
--

DROP TABLE IF EXISTS `incomegroup`;
CREATE TABLE IF NOT EXISTS `incomegroup` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `income_group`
--

INSERT INTO `incomegroup` (`ID`, `NAME`, `DESCRIPTION`, `DELETED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(2, 'mredly', '', 1, 1, 'Tulajdonos', '2020-06-27 18:00:46', '2020-06-27 18:00:51', 'Tulajdonos'),
(3, 'Adminisztrátor', '', 0, 0, 'Tulajdonos', '2020-06-27 18:00:54', NULL, NULL),
(4, 'tagdíj', '', 0, 0, 'Tulajdonos', '2020-07-24 23:22:13', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `income_group_conn`
--

DROP TABLE IF EXISTS `incomegroupconnection`;
CREATE TABLE IF NOT EXISTS `incomegroupconnection` (
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `income_group_conn`
--

INSERT INTO `incomegroupconnection` (`ID`, `ORG_ID`, `INCOME_ID`, `GROUP_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(6, 1, 12, 3, 0, 'Tulajdonos', '2020-07-19 15:43:27', NULL, NULL),
(7, 1, 13, 3, 0, 'Tulajdonos', '2020-07-19 15:51:42', NULL, NULL),
(8, 1, 14, 3, 0, 'Tulajdonos', '2020-07-22 18:48:53', NULL, NULL),
(9, 1, 15, 4, 0, 'Tulajdonos', '2020-07-24 23:27:15', NULL, NULL),
(10, 1, 18, 3, 0, 'Tulajdonos', '2020-09-04 12:26:14', NULL, NULL),
(11, 1, 20, 4, 0, 'Tulajdonos', '2020-09-04 12:30:10', NULL, NULL),
(12, 1, 19, 3, 0, 'Tulajdonos', '2020-09-04 12:30:15', NULL, NULL),
(13, 1, 17, 3, 0, 'Tulajdonos', '2020-09-26 11:59:28', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jelen`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `jelen`
--

INSERT INTO `attendance` (`ID`, `ORG_ID`, `TEAM_ID`, `USER_ID`, `TRAINING_ID`, `JELEN`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 5001, 10, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(2, 1, 5001, 14, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(3, 1, 5001, 15, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(4, 1, 5001, 16, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(5, 1, 5001, 17, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(6, 1, 5001, 18, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(7, 1, 5001, 19, 1, '0', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(8, 1, 5001, 20, 1, '0', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(9, 1, 5001, 21, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(10, 1, 5001, 22, 1, '1', 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(11, 1, 5001, 23, 1, '0', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(12, 1, 5001, 24, 1, '0', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(13, 1, 5001, 25, 1, '1', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(14, 1, 5001, 26, 1, '1', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(15, 1, 5001, 27, 1, '0', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(16, 1, 5001, 28, 1, '0', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(17, 1, 5001, 29, 1, '1', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(18, 1, 5001, 30, 1, '1', 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(19, 1, 5001, 10, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(20, 1, 5001, 14, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(21, 1, 5001, 15, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(22, 1, 5001, 16, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(23, 1, 5001, 17, 2, 'igazolt', 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(24, 1, 5001, 18, 2, 'igazolatlan', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(25, 1, 5001, 19, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(26, 1, 5001, 20, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(27, 1, 5001, 21, 2, 'igazolatlan', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(28, 1, 5001, 22, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(29, 1, 5001, 23, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(30, 1, 5001, 24, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(31, 1, 5001, 25, 2, 'igazolt', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(32, 1, 5001, 26, 2, 'igazolatlan', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(33, 1, 5001, 27, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(34, 1, 5001, 28, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(35, 1, 5001, 29, 2, 'igazolt', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(36, 1, 5001, 30, 2, 'jelen', 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(37, 1, 5001, 10, 5, 'igazolatlan', 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(38, 1, 5001, 10, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(39, 1, 5001, 14, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(40, 1, 5001, 15, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(41, 1, 5001, 16, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(42, 1, 5001, 17, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(43, 1, 5001, 18, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(44, 1, 5001, 19, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(45, 1, 5001, 20, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(46, 1, 5001, 21, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(47, 1, 5001, 22, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(48, 1, 5001, 23, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(49, 1, 5001, 24, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(50, 1, 5001, 25, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(51, 1, 5001, 26, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(52, 1, 5001, 27, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(53, 1, 5001, 28, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(54, 1, 5001, 29, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(55, 1, 5001, 30, 8, 'igazolatlan', 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(56, 1, 5001, 10, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(57, 1, 5001, 14, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(58, 1, 5001, 15, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(59, 1, 5001, 16, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(60, 1, 5001, 17, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(61, 1, 5001, 18, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(62, 1, 5001, 19, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(63, 1, 5001, 20, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(64, 1, 5001, 21, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(65, 1, 5001, 22, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(66, 1, 5001, 23, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(67, 1, 5001, 24, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(68, 1, 5001, 25, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(69, 1, 5001, 26, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(70, 1, 5001, 27, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(71, 1, 5001, 28, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(72, 1, 5001, 29, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(73, 1, 5001, 30, 7, 'igazolatlan', 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `liga`
--

DROP TABLE IF EXISTS `league`;
CREATE TABLE IF NOT EXISTS `league` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `liga`
--

INSERT INTO `league` (`ID`, `EVAD`, `SZERVEZO`, `LIGA`, `KLUB_NEV`, `TEAM`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, '2019/2020', 'Bács-Kiskun', 'MEGYEI I.', 'KECSKEMÉTI LC', 'U-18', 1, NULL, '2020-05-30 13:25:51', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lookup_code`
--

DROP TABLE IF EXISTS `lookupcode`;
CREATE TABLE IF NOT EXISTS `lookupcode` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LGROUP` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `CODE` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `NAME` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=5002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `lookup_code`
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
-- Tábla szerkezet ehhez a táblához `organization`
--

DROP TABLE IF EXISTS `club`;
CREATE TABLE IF NOT EXISTS `club` (
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `organization`
--

INSERT INTO `club` (`ID`, `NAME`, `DATABANK_URL`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', 1, NULL, '2019-12-14 13:07:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `org_country`
--

DROP TABLE IF EXISTS `clubdata`;
CREATE TABLE IF NOT EXISTS `clubdata` (
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `org_country`
--

INSERT INTO `clubdata` (`ID`, `ORG_ID`, `COUNTRY_CODE`, `NAME`, `CITY`, `POST_CODE`, `STREET`, `STREET2`, `PRIMARY_OC`, `TEMP`, `TYPE`, `TEMP_UPDATE`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(6, 1, 'Magyarország', 'Kecskeméti Labdarúgó Klub ', 'Kecskemét', '6000', 'Nemtudom utca 33.', 'II. em', NULL, 15, '0', '2020-09-26', 36, 'Admin', '2020-06-13 13:17:45', '2020-09-26 11:31:00', 'farago.samuel');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `parameters`
--

DROP TABLE IF EXISTS `parameter`;
CREATE TABLE IF NOT EXISTS `parameter` (
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- A tábla adatainak kiíratása `parameters`
--

INSERT INTO `parameter` (`ID`, `GROUP`, `CODE`, `VALUE`, `ATTR1`, `ATTR2`, `ATTR3`, `ATTR4`, `ATTR5`, `VERSION`, `DELETABLE`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(17, 'TRAINER_RATING', 'KECSKEMÉTI LC', '2', NULL, NULL, NULL, NULL, NULL, 1, b'0', NULL, '2020-07-20 16:38:23', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `player_data`
--

DROP TABLE IF EXISTS `playerdata`;
CREATE TABLE IF NOT EXISTS `playerdata` (
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `player_data`
--

INSERT INTO `playerdata` (`ID`, `USER_ID`, `SZUL`, `KOR`, `MECCSEK`, `GOLOK`, `ONGOLOK`, `SARGA`, `PIROS`, `KEZDO`, `CSERE`, `KISPAD`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(30, 10, '1995. 12. 29.', 24, 97, 29, 0, 10, 0, 73, 21, 3, 0, NULL, '2020-05-30 12:14:51', NULL, NULL),
(31, 14, '1995. 06. 04.', 25, 331, 22, 0, 10, 0, 246, 61, 24, 1, NULL, '2020-05-30 12:14:52', '2020-06-12 15:57:23', 'system'),
(32, 15, '2000. 04. 18.', 20, 267, 20, 1, 8, 2, 224, 39, 4, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(33, 16, '1998. 01. 02.', 22, 297, 42, 1, 53, 3, 256, 31, 10, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(34, 17, '1999. 06. 18.', 21, 252, 160, 0, 15, 0, 170, 74, 8, 1, NULL, '2020-05-30 12:14:52', '2020-06-19 19:12:13', 'system'),
(35, 18, '1999. 05. 07.', 21, 209, 3, 0, 3, 0, 80, 44, 85, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(36, 19, '1999. 11. 21.', 20, 283, 6, 2, 6, 0, 210, 67, 6, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(37, 20, '1999. 11. 16.', 20, 202, 65, 0, 10, 0, 162, 25, 15, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(38, 21, '1999. 04. 06.', 21, 281, 13, 1, 14, 1, 184, 78, 19, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(39, 22, '1997. 03. 26.', 23, 273, 126, 0, 16, 0, 179, 82, 12, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(40, 23, '1982. 08. 21.', 37, 167, 5, 0, 12, 1, 87, 52, 28, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(41, 24, '1982. 02. 11.', 38, 362, 38, 0, 80, 7, 296, 56, 10, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(42, 25, '1996. 10. 07.', 23, 234, 91, 0, 10, 0, 169, 42, 23, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(43, 26, '1999. 08. 26.', 20, 240, 54, 0, 14, 1, 174, 61, 5, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(44, 27, '1998. 01. 20.', 22, 266, 89, 0, 3, 1, 158, 91, 17, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(45, 28, '2002. 06. 07.', 18, 203, 135, 2, 33, 0, 115, 73, 15, 1, NULL, '2020-05-30 12:14:52', '2020-06-12 15:57:23', 'system'),
(46, 29, '1999. 02. 05.', 21, 241, 67, 0, 35, 0, 171, 69, 1, 0, NULL, '2020-05-30 12:14:52', NULL, NULL),
(47, 30, '1998. 02. 25.', 22, 302, 50, 0, 15, 1, 241, 57, 4, 0, NULL, '2020-05-30 12:14:52', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `privilege`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
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
) ENGINE=InnoDB AUTO_INCREMENT=939 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `privilege`
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
(933, 'PLAYERS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(934, 'TEAMS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(935, 'TRAINERS_STAT', NULL, 1, 0, NULL, '2020-06-13 04:17:58', NULL, NULL),
(936, 'ADMIN', NULL, 1, 0, NULL, '2020-06-13 11:41:45', NULL, NULL),
(937, 'VIDEO_ANALYTICS', NULL, 1, 0, NULL, '2020-06-18 14:55:23', NULL, NULL),
(938, 'EVENT_CREATE', NULL, 1, 0, NULL, '2020-09-26 10:52:11', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `red_card`
--

DROP TABLE IF EXISTS `redcard`;
CREATE TABLE IF NOT EXISTS `redcard` (
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
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `red_card`
--

INSERT INTO `redcard` (`ID`, `ORG_ID`, `LIGA_ID`, `HELYEZES`, `NEV`, `CARD`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(159, 1, 1, 1, 'SZŰCS DOMINIK', 1, 0, NULL, '2020-06-02 13:44:21', NULL, NULL);

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
-- Tábla szerkezet ehhez a táblához `role_privileges`
--

DROP TABLE IF EXISTS `rolepermission`;
CREATE TABLE IF NOT EXISTS `rolepermission` (
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
) ENGINE=InnoDB AUTO_INCREMENT=1261 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `role_privileges`
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
(1249, 27, 933, 1, NULL, '2020-06-13 04:47:27', NULL, NULL),
(1250, 27, 934, 1, NULL, '2020-06-13 04:47:27', NULL, NULL),
(1251, 32, 933, 1, NULL, '2020-06-13 04:48:21', NULL, NULL),
(1252, 32, 934, 1, NULL, '2020-06-13 04:48:21', NULL, NULL),
(1253, 32, 935, 1, NULL, '2020-06-13 04:48:21', NULL, NULL),
(1254, 33, 933, 1, NULL, '2020-06-13 04:48:51', NULL, NULL),
(1255, 33, 934, 1, NULL, '2020-06-13 04:48:51', NULL, NULL),
(1256, 33, 935, 1, NULL, '2020-06-13 04:48:51', NULL, NULL),
(1257, 28, 755, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(1258, 28, 936, 1, NULL, '2020-06-13 11:43:16', NULL, NULL),
(1259, 32, 937, 1, NULL, '2020-06-18 14:55:47', NULL, NULL),
(1260, 32, 938, 1, NULL, '2020-05-28 09:52:34', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `scene`
--

INSERT INTO `scene` (`ID`, `ORG_ID`, `TEAM_ID`, `USER_ID`, `FOLDER_ID`, `VIDEO_ID`, `NAME`, `DESCRIPTION`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(17, 1, 5001, 10, 10, 23, 'Samu óriási gólja ', 'A 44. percben bevarta ahogy kell!!', 0, 'Edzo', '2020-09-09 18:46:15', NULL, NULL),
(18, 1, 5001, 16, 10, 24, 'Beadásból gól', 'Beadásból gól az 50. percben', 0, 'Edzo', '2020-09-10 04:06:04', NULL, NULL),
(19, 1, 5001, 18, 10, 25, 'teszt', 'Testdesc', 0, 'Edzo', '2020-09-25 17:14:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sorsolas`
--

DROP TABLE IF EXISTS `lottery`;
CREATE TABLE IF NOT EXISTS `lottery` (
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
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `sorsolas`
--

INSERT INTO `lottery` (`ID`, `LIGA_ID`, `HAZAI`, `HAZAI_IMG`, `EREDMENY`, `VENDEG`, `VENDEG_IMG`, `DATUM`, `HELY`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(159, 1, 'LAJOSMIZSEI VLC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12328.jpg', '2 - 2', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-08-11 15:00:00', 'Lázár Bence Lajosmizsei Labdarúgó Sportcentrum', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(160, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '0 - 0', 'KALOCSAI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12152.jpg', '2019-08-17 15:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(161, 1, 'HARTA SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/h.png', '5 - 1', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-08-24 15:00:00', 'Harta Sporttelep', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(162, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '0 - 3', 'JÁNOSHALMI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12326.jpg', '2019-08-31 14:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(163, 1, 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', '3 - 1', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-09-08 14:30:00', 'Akasztó Sporttelep', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(164, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '0 - 3', 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '2019-09-14 14:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(165, 1, 'SOLTVADKERTI TE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12537.png', '2 - 4', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-09-29 14:00:00', 'Soltvadkert Sporttelep', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(166, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '1 - 2', 'FADDIKORR-KISKUNHALASI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/4/3100.jpg', '2019-10-05 13:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(167, 1, 'DUNA ASZFALT TLC II.', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12609.png', '5 - 1', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-10-12 15:00:00', 'Tiszakécske Városi Sportcentrum', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(168, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '4 - 0', 'KECEL FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/k.png', '2019-10-19 12:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(169, 1, 'KISKŐRÖSI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/11/10590.jpg', '1 - 1', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-10-27 12:30:00', 'Kiskőrös Sporttelep', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(170, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2 - 1', 'BÁCSALMÁSI PVSE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11692.jpg', '2019-11-02 12:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(171, 1, 'KEREKEGYHÁZI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11637.jpg', '3 - 1', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2019-11-09 12:30:00', 'Kerekegyháza Borbás Gáspár Sporttelep', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(172, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '1 - 3', 'KISKUNFÉLEGYHÁZI HTK', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/6/5170.jpg', '2019-11-16 12:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(173, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '0 - 0', 'LAJOSMIZSEI VLC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12328.jpg', '2020-02-22 13:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:49', NULL, NULL),
(174, 1, 'KALOCSAI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12152.jpg', '0 - 2', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-03-01 13:00:00', 'Kalocsa Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(175, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2 - 3', 'HARTA SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/h.png', '2020-03-07 13:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(176, 1, 'JÁNOSHALMI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12326.jpg', '2 - 0', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-03-14 13:30:00', 'Jánoshalma Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(177, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '04-11\n16:30', 'SOLTVADKERTI TE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12537.png', '2020-04-11 14:30:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(178, 1, 'FADDIKORR-KISKUNHALASI FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/4/3100.jpg', '04-18\n17:00', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-04-18 15:00:00', 'Kiskunhalas Bundzsák Dezső Városi Sportközpont', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(179, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '04-25\n17:00', 'DUNA ASZFALT TLC II.', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12609.png', '2020-04-25 15:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(180, 1, 'KECEL FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/k.png', '05-03\n17:00', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-05-03 15:00:00', 'Kecel Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(181, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '05-09\n17:00', 'KISKŐRÖSI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/11/10590.jpg', '2020-05-09 15:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(182, 1, 'BÁCSALMÁSI PVSE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11692.jpg', '05-17\n17:00', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-05-17 15:00:00', 'Bácsalmás Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(183, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '05-23\n17:00', 'KEREKEGYHÁZI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11637.jpg', '2020-05-23 15:00:00', 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(184, 1, 'KISKUNFÉLEGYHÁZI HTK', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/6/5170.jpg', '05-30\n17:00', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '2020-05-30 15:00:00', 'Kiskunfélegyházi HTK Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(185, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(186, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, NULL, '2020-06-02 10:43:50', NULL, NULL),
(187, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-02 15:26:26', NULL, NULL),
(188, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-02 15:26:26', NULL, NULL),
(189, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-02 15:41:19', NULL, NULL),
(190, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-02 15:41:19', NULL, NULL),
(191, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-02 16:32:54', NULL, NULL),
(192, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-02 16:32:54', NULL, NULL),
(193, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-02 16:39:19', NULL, NULL),
(194, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-02 16:39:19', NULL, NULL),
(195, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-13 04:50:23', NULL, NULL),
(196, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-13 04:50:23', NULL, NULL),
(197, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-19 19:12:46', NULL, NULL),
(198, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-19 19:12:46', NULL, NULL),
(199, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-19 19:21:33', NULL, NULL),
(200, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-19 19:21:33', NULL, NULL),
(201, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-21 10:28:28', NULL, NULL),
(202, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-21 10:28:28', NULL, NULL),
(203, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-21 10:37:28', NULL, NULL),
(204, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-21 10:37:29', NULL, NULL),
(205, 1, 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', '06-30', 'AKASZTÓ FC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/13/12516.jpg', NULL, 'Kecskeméti Széktói Stadion', 0, 'system', '2020-06-21 11:10:14', NULL, NULL),
(206, 1, 'SZABADSZÁLLÁSI SE', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/s.png', '06-30', 'KECSKEMÉTI LC', 'https://adatbank.mlsz.hu/img/EgyesuletLogo/Logo/12/11215.png', NULL, 'Szabadszállás Sporttelep', 0, 'system', '2020-06-21 11:10:14', NULL, NULL);

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

DROP TABLE IF EXISTS `leaguetable`;
CREATE TABLE IF NOT EXISTS `leaguetable` (
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
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `tabella`
--

INSERT INTO `leaguetable` (`ID`, `LIGA_ID`, `FORDULO`, `HELYEZES`, `CSAPAT`, `MECSEK_SZAMA`, `GYOZELMEK_SZAMA`, `DONTETLENEK_SZAMA`, `VERESEGEK_SZAMA`, `LOTT_GOLOK_SZAMA`, `KAPOTT_GOLOK_SZAMA`, `GOLKULONBSEG`, `PONTSZAM`, `ELLENFELEK_HELYEZESEK_ATLAGA`, `FROMA_1`, `FROMA_2`, `FORMA_3`, `FORMA_4`, `FORMA_5`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(145, 1, 1, 1, 'KISKUNFÉLEGYHÁZI HTK', 1, 1, 0, 0, 6, 3, 3, 3, '15', 'GY', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:20:56', NULL, NULL),
(146, 1, 1, 2, 'KEREKEGYHÁZI SE', 1, 1, 0, 0, 5, 2, 3, 3, '16', 'GY', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(147, 1, 1, 3, 'KECEL FC', 1, 1, 0, 0, 3, 1, 2, 3, '14', 'GY', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(148, 1, 1, 4, 'HARTA SE', 1, 1, 0, 0, 4, 3, 1, 3, '12', 'GY', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(149, 1, 1, 5, 'SZABADSZÁLLÁSI SE', 1, 1, 0, 0, 2, 1, 1, 3, '13', 'GY', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(150, 1, 1, 6, 'KECSKEMÉTI LC', 1, 0, 1, 0, 2, 2, 0, 1, '7', 'D', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(151, 1, 1, 7, 'LAJOSMIZSEI VLC', 1, 0, 1, 0, 2, 2, 0, 1, '6', 'D', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(152, 1, 1, 8, 'BÁCSALMÁSI PVSE', 1, 0, 1, 0, 1, 1, 0, 1, '9', 'D', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(153, 1, 1, 9, 'DUNA ASZFALT TLC II.', 1, 0, 1, 0, 1, 1, 0, 1, '8', 'D', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(154, 1, 1, 10, 'JÁNOSHALMI FC', 0, 0, 0, 0, 0, 0, 0, 0, '0', NULL, NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(155, 1, 1, 11, 'AKASZTÓ FC', 1, 0, 0, 1, 3, 4, -1, 0, '4', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(156, 1, 1, 12, 'KALOCSAI FC', 1, 0, 0, 1, 1, 2, -1, 0, '5', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(157, 1, 1, 13, 'KISKŐRÖSI LC', 1, 0, 0, 1, 1, 3, -2, 0, '3', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(158, 1, 1, 14, 'SOLTVADKERTI TE', 1, 0, 0, 1, 3, 6, -3, 0, '1', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(159, 1, 1, 15, 'FADDIKORR-KISKUNHALASI FC', 1, 0, 0, 1, 2, 5, -3, 0, '2', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:21:04', NULL, NULL),
(160, 1, 2, 1, 'KECEL FC', 2, 2, 0, 0, 5, 1, 4, 6, '13', 'GY', 'GY', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(161, 1, 2, 2, 'HARTA SE', 2, 2, 0, 0, 7, 5, 2, 6, '6.5', 'GY', 'GY', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(162, 1, 2, 3, 'KISKUNFÉLEGYHÁZI HTK', 2, 1, 1, 0, 8, 5, 3, 4, '14', 'D', 'GY', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(163, 1, 2, 4, 'KEREKEGYHÁZI SE', 2, 1, 1, 0, 6, 3, 3, 4, '10', 'D', 'GY', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(164, 1, 2, 5, 'LAJOSMIZSEI VLC', 2, 1, 1, 0, 4, 3, 1, 4, '12.5', 'GY', 'D', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(165, 1, 2, 6, 'AKASZTÓ FC', 2, 1, 0, 1, 6, 5, 1, 3, '8', 'GY', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(166, 1, 2, 7, 'SZABADSZÁLLÁSI SE', 2, 1, 0, 1, 4, 4, 0, 3, '6', 'V', 'GY', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(167, 1, 2, 8, 'DUNA ASZFALT TLC II.', 2, 0, 2, 0, 2, 2, 0, 2, '7.5', 'D', 'D', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(168, 1, 2, 9, 'KECSKEMÉTI LC', 2, 0, 2, 0, 2, 2, 0, 2, '7.5', 'D', 'D', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(169, 1, 2, 10, 'KALOCSAI FC', 2, 0, 1, 1, 1, 2, -1, 1, '8', 'D', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(170, 1, 2, 11, 'BÁCSALMÁSI PVSE', 2, 0, 1, 1, 1, 3, -2, 1, '4.5', 'V', 'D', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(171, 1, 2, 12, 'FADDIKORR-KISKUNHALASI FC', 2, 0, 1, 1, 4, 7, -3, 1, '3.5', 'D', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(172, 1, 2, 13, 'JÁNOSHALMI FC', 1, 0, 0, 1, 1, 3, -2, 0, '6', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(173, 1, 2, 14, 'KISKŐRÖSI LC', 1, 0, 0, 1, 1, 3, -2, 0, '1', 'V', NULL, NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(174, 1, 2, 15, 'SOLTVADKERTI TE', 2, 0, 0, 2, 4, 8, -4, 0, '4', 'V', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(175, 1, 3, 1, 'HARTA SE', 3, 3, 0, 0, 12, 6, 6, 9, '8.7', 'GY', 'GY', 'GY', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(176, 1, 3, 2, 'KEREKEGYHÁZI SE', 3, 2, 1, 0, 14, 3, 11, 7, '10.3', 'GY', 'D', 'GY', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(177, 1, 3, 3, 'KISKUNFÉLEGYHÁZI HTK', 3, 2, 1, 0, 12, 6, 6, 7, '13', 'GY', 'D', 'GY', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(178, 1, 3, 4, 'LAJOSMIZSEI VLC', 3, 2, 1, 0, 7, 4, 3, 7, '13.3', 'GY', 'GY', 'D', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(179, 1, 3, 5, 'KECEL FC', 3, 2, 0, 1, 5, 9, -4, 6, '7.7', 'V', 'GY', 'GY', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(180, 1, 3, 6, 'AKASZTÓ FC', 2, 1, 0, 1, 6, 5, 1, 3, '5', 'GY', 'V', NULL, NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(181, 1, 3, 7, 'KISKŐRÖSI LC', 2, 1, 0, 1, 4, 4, 0, 3, '9.5', 'GY', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(182, 1, 3, 8, 'SZABADSZÁLLÁSI SE', 3, 1, 0, 2, 5, 6, -1, 3, '6.7', 'V', 'V', 'GY', NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(183, 1, 3, 9, 'JÁNOSHALMI FC', 2, 1, 0, 1, 3, 4, -1, 3, '7', 'GY', 'V', NULL, NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(184, 1, 3, 10, 'KALOCSAI FC', 3, 0, 2, 1, 1, 2, -1, 2, '11', 'D', 'D', 'V', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(185, 1, 3, 11, 'DUNA ASZFALT TLC II.', 3, 0, 2, 1, 3, 6, -3, 2, '6.3', 'V', 'D', 'D', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(186, 1, 3, 12, 'KECSKEMÉTI LC', 3, 0, 2, 1, 3, 7, -4, 2, '5', 'V', 'D', 'D', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(187, 1, 3, 13, 'SOLTVADKERTI TE', 3, 0, 1, 2, 4, 8, -4, 1, '5.7', 'D', 'V', 'V', NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(188, 1, 3, 14, 'BÁCSALMÁSI PVSE', 3, 0, 1, 2, 2, 6, -4, 1, '7.7', 'V', 'V', 'D', NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(189, 1, 3, 15, 'FADDIKORR-KISKUNHALASI FC', 3, 0, 1, 2, 5, 10, -5, 1, '3', 'V', 'D', 'V', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(190, 1, 4, 1, 'HARTA SE', 4, 3, 1, 0, 15, 9, 6, 10, '10.8', 'D', 'GY', 'GY', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(191, 1, 4, 2, 'KEREKEGYHÁZI SE', 4, 2, 2, 0, 16, 5, 11, 8, '8', 'D', 'GY', 'D', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(192, 1, 4, 3, 'KISKUNFÉLEGYHÁZI HTK', 4, 2, 2, 0, 14, 8, 6, 8, '8.5', 'D', 'GY', 'D', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(193, 1, 4, 4, 'LAJOSMIZSEI VLC', 4, 2, 1, 1, 9, 9, 0, 7, '10.8', 'V', 'GY', 'GY', 'D', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(194, 1, 4, 5, 'KECEL FC', 4, 2, 1, 1, 7, 11, -4, 7, '7.5', 'D', 'V', 'GY', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(195, 1, 4, 6, 'SZABADSZÁLLÁSI SE', 4, 2, 0, 2, 11, 6, 5, 6, '8', 'GY', 'V', 'V', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(196, 1, 4, 7, 'JÁNOSHALMI FC', 3, 2, 0, 1, 6, 4, 2, 6, '10.3', 'GY', 'GY', 'V', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(197, 1, 4, 8, 'DUNA ASZFALT TLC II.', 4, 1, 2, 1, 8, 8, 0, 5, '6', 'GY', 'V', 'D', 'D', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(198, 1, 4, 9, 'FADDIKORR-KISKUNHALASI FC', 4, 1, 1, 2, 10, 10, 0, 4, '5.5', 'GY', 'V', 'D', 'V', NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(199, 1, 4, 10, 'KISKŐRÖSI LC', 3, 1, 1, 1, 6, 6, 0, 4, '7.3', 'D', 'GY', 'V', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(200, 1, 4, 11, 'AKASZTÓ FC', 3, 1, 0, 2, 6, 11, -5, 3, '4.7', 'V', 'GY', 'V', NULL, NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(201, 1, 4, 12, 'SOLTVADKERTI TE', 4, 0, 2, 2, 7, 11, -4, 2, '5.3', 'D', 'D', 'V', 'V', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(202, 1, 4, 13, 'KALOCSAI FC', 4, 0, 2, 2, 1, 7, -6, 2, '10.3', 'V', 'D', 'D', 'V', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(203, 1, 4, 14, 'KECSKEMÉTI LC', 4, 0, 2, 2, 3, 10, -7, 2, '6.3', 'V', 'V', 'D', 'D', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(204, 1, 4, 15, 'BÁCSALMÁSI PVSE', 3, 0, 1, 2, 2, 6, -4, 1, '7.7', 'V', 'V', 'D', NULL, NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(205, 1, 5, 1, 'HARTA SE', 5, 4, 1, 0, 18, 11, 7, 13, '10.6', 'GY', 'D', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(206, 1, 5, 2, 'KEREKEGYHÁZI SE', 5, 3, 2, 0, 22, 6, 16, 11, '10.6', 'GY', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(207, 1, 5, 3, 'KISKUNFÉLEGYHÁZI HTK', 5, 3, 2, 0, 16, 8, 8, 11, '10.2', 'GY', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(208, 1, 5, 4, 'LAJOSMIZSEI VLC', 5, 3, 1, 1, 13, 10, 3, 10, '10.6', 'GY', 'V', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(209, 1, 5, 5, 'JÁNOSHALMI FC', 4, 3, 0, 1, 7, 4, 3, 9, '10.5', 'GY', 'GY', 'GY', 'V', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(210, 1, 5, 6, 'KECEL FC', 5, 2, 1, 2, 8, 15, -7, 7, '7.2', 'V', 'D', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(211, 1, 5, 7, 'SZABADSZÁLLÁSI SE', 4, 2, 0, 2, 11, 6, 5, 6, '6', 'GY', 'V', 'V', 'GY', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(212, 1, 5, 8, 'AKASZTÓ FC', 4, 2, 0, 2, 9, 12, -3, 6, '6.8', 'GY', 'V', 'GY', 'V', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(213, 1, 5, 9, 'DUNA ASZFALT TLC II.', 5, 1, 2, 2, 8, 9, -1, 5, '6.8', 'V', 'GY', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(214, 1, 5, 10, 'KALOCSAI FC', 5, 1, 2, 2, 2, 7, -5, 5, '10.8', 'GY', 'V', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(215, 1, 5, 11, 'FADDIKORR-KISKUNHALASI FC', 5, 1, 1, 3, 12, 13, -1, 4, '4', 'V', 'GY', 'V', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(216, 1, 5, 12, 'KISKŐRÖSI LC', 4, 1, 1, 2, 6, 8, -2, 4, '6.5', 'V', 'D', 'GY', 'V', NULL, 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(217, 1, 5, 13, 'SOLTVADKERTI TE', 5, 0, 2, 3, 7, 12, -5, 2, '4.6', 'V', 'D', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(218, 1, 5, 14, 'KECSKEMÉTI LC', 5, 0, 2, 3, 4, 13, -9, 2, '5.6', 'V', 'V', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(219, 1, 5, 15, 'BÁCSALMÁSI PVSE', 4, 0, 1, 3, 3, 12, -9, 1, '7.3', 'V', 'V', 'V', 'D', NULL, 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(220, 1, 6, 1, 'KISKUNFÉLEGYHÁZI HTK', 6, 4, 2, 0, 18, 9, 9, 14, '11.2', 'GY', 'GY', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(221, 1, 6, 2, 'HARTA SE', 6, 4, 1, 1, 19, 14, 5, 13, '10.3', 'V', 'GY', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(222, 1, 6, 3, 'JÁNOSHALMI FC', 5, 4, 0, 1, 8, 4, 4, 12, '11', 'GY', 'GY', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(223, 1, 6, 4, 'KEREKEGYHÁZI SE', 5, 3, 2, 0, 22, 6, 16, 11, '11', 'GY', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(224, 1, 6, 5, 'LAJOSMIZSEI VLC', 6, 3, 2, 1, 15, 12, 3, 11, '11', 'D', 'GY', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(225, 1, 6, 6, 'SZABADSZÁLLÁSI SE', 5, 3, 0, 2, 14, 6, 8, 9, '7.4', 'GY', 'GY', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(226, 1, 6, 7, 'DUNA ASZFALT TLC II.', 6, 2, 2, 2, 11, 10, 1, 8, '5.8', 'GY', 'V', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(227, 1, 6, 8, 'KALOCSAI FC', 6, 2, 2, 2, 4, 7, -3, 8, '10.2', 'GY', 'GY', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(228, 1, 6, 9, 'KECEL FC', 6, 2, 1, 3, 8, 17, -9, 7, '7.3', 'V', 'V', 'D', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(229, 1, 6, 10, 'AKASZTÓ FC', 5, 2, 0, 3, 10, 14, -4, 6, '7.4', 'V', 'GY', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(230, 1, 6, 11, 'KISKŐRÖSI LC', 5, 1, 2, 2, 8, 10, -2, 5, '6.8', 'D', 'V', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(231, 1, 6, 12, 'SOLTVADKERTI TE', 6, 1, 2, 3, 9, 13, -4, 5, '4.8', 'GY', 'V', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(232, 1, 6, 13, 'FADDIKORR-KISKUNHALASI FC', 6, 1, 1, 4, 12, 14, -2, 4, '3.8', 'V', 'V', 'GY', 'V', 'D', 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(233, 1, 6, 14, 'KECSKEMÉTI LC', 6, 0, 2, 4, 4, 16, -12, 2, '5.7', 'V', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(234, 1, 6, 15, 'BÁCSALMÁSI PVSE', 5, 0, 1, 4, 4, 14, -10, 1, '6.4', 'V', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(235, 1, 7, 1, 'HARTA SE', 7, 5, 1, 1, 25, 15, 10, 16, '10.1', 'GY', 'V', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(236, 1, 7, 2, 'JÁNOSHALMI FC', 6, 5, 0, 1, 11, 6, 5, 15, '10.2', 'GY', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(237, 1, 7, 3, 'KISKUNFÉLEGYHÁZI HTK', 7, 4, 3, 0, 20, 11, 9, 15, '10.6', 'D', 'GY', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(238, 1, 7, 4, 'LAJOSMIZSEI VLC', 7, 4, 2, 1, 17, 13, 4, 14, '11.9', 'GY', 'D', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(239, 1, 7, 5, 'KEREKEGYHÁZI SE', 6, 3, 3, 0, 24, 8, 16, 12, '10.2', 'D', 'GY', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(240, 1, 7, 6, 'KALOCSAI FC', 7, 3, 2, 2, 5, 7, -2, 11, '10.7', 'GY', 'GY', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(241, 1, 7, 7, 'SZABADSZÁLLÁSI SE', 6, 3, 1, 2, 15, 7, 8, 10, '7.2', 'D', 'GY', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(242, 1, 7, 8, 'DUNA ASZFALT TLC II.', 7, 2, 2, 3, 13, 13, 0, 8, '5.1', 'V', 'GY', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(243, 1, 7, 9, 'AKASZTÓ FC', 6, 2, 1, 3, 12, 16, -4, 7, '7.8', 'D', 'V', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(244, 1, 7, 10, 'KECEL FC', 7, 2, 1, 4, 9, 23, -14, 7, '6.7', 'V', 'V', 'V', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(245, 1, 7, 11, 'SOLTVADKERTI TE', 7, 1, 3, 3, 10, 14, -4, 6, '4.6', 'D', 'GY', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(246, 1, 7, 12, 'FADDIKORR-KISKUNHALASI FC', 7, 1, 2, 4, 14, 16, -2, 5, '4.3', 'D', 'V', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(247, 1, 7, 13, 'KISKŐRÖSI LC', 6, 1, 2, 3, 8, 11, -3, 5, '7.2', 'V', 'D', 'V', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(248, 1, 7, 14, 'KECSKEMÉTI LC', 6, 0, 2, 4, 4, 16, -12, 2, '4.8', 'V', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(249, 1, 7, 15, 'BÁCSALMÁSI PVSE', 6, 0, 1, 5, 5, 16, -11, 1, '7.2', 'V', 'V', 'V', 'V', 'V', 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(250, 1, 8, 1, 'HARTA SE', 8, 6, 1, 1, 28, 15, 13, 19, '10.5', 'GY', 'GY', 'V', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(251, 1, 8, 2, 'JÁNOSHALMI FC', 7, 6, 0, 1, 13, 6, 7, 18, '10.1', 'GY', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(252, 1, 8, 3, 'KISKUNFÉLEGYHÁZI HTK', 7, 4, 3, 0, 20, 11, 9, 15, '10.7', 'D', 'GY', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(253, 1, 8, 4, 'LAJOSMIZSEI VLC', 8, 4, 3, 1, 19, 15, 4, 15, '11.1', 'D', 'GY', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(254, 1, 8, 5, 'KALOCSAI FC', 8, 4, 2, 2, 7, 8, -1, 14, '11.3', 'GY', 'GY', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(255, 1, 8, 6, 'KEREKEGYHÁZI SE', 7, 3, 4, 0, 26, 10, 16, 13, '9.1', 'D', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(256, 1, 8, 7, 'SZABADSZÁLLÁSI SE', 7, 3, 2, 2, 18, 10, 8, 11, '7.7', 'D', 'D', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(257, 1, 8, 8, 'DUNA ASZFALT TLC II.', 8, 2, 3, 3, 15, 15, 0, 9, '5.6', 'D', 'V', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(258, 1, 8, 9, 'AKASZTÓ FC', 7, 2, 2, 3, 14, 18, -4, 8, '7.9', 'D', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(259, 1, 8, 10, 'KECEL FC', 8, 2, 1, 5, 9, 25, -16, 7, '6.1', 'V', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(260, 1, 8, 11, 'FADDIKORR-KISKUNHALASI FC', 8, 1, 3, 4, 17, 19, -2, 6, '4.6', 'D', 'D', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(261, 1, 8, 12, 'SOLTVADKERTI TE', 8, 1, 3, 4, 12, 18, -6, 6, '5.6', 'V', 'D', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(262, 1, 8, 13, 'KISKŐRÖSI LC', 7, 1, 2, 4, 8, 14, -6, 5, '6.3', 'V', 'V', 'D', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(263, 1, 8, 14, 'KECSKEMÉTI LC', 7, 1, 2, 4, 8, 18, -10, 5, '5.7', 'GY', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(264, 1, 8, 15, 'BÁCSALMÁSI PVSE', 7, 0, 1, 6, 6, 18, -12, 1, '7', 'V', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(265, 1, 9, 1, 'HARTA SE', 9, 7, 1, 1, 31, 16, 15, 22, '10.9', 'GY', 'GY', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(266, 1, 9, 2, 'JÁNOSHALMI FC', 8, 7, 0, 1, 15, 6, 9, 21, '10.4', 'GY', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(267, 1, 9, 3, 'KISKUNFÉLEGYHÁZI HTK', 8, 5, 3, 0, 23, 12, 11, 18, '10', 'GY', 'D', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:32', 'system'),
(268, 1, 9, 4, 'KALOCSAI FC', 9, 5, 2, 2, 8, 8, 0, 17, '10.6', 'GY', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(269, 1, 9, 5, 'LAJOSMIZSEI VLC', 9, 4, 3, 2, 20, 18, 2, 15, '10.2', 'V', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(270, 1, 9, 6, 'SZABADSZÁLLÁSI SE', 8, 4, 2, 2, 20, 10, 10, 14, '7.5', 'GY', 'D', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(271, 1, 9, 7, 'KEREKEGYHÁZI SE', 8, 3, 4, 1, 26, 11, 15, 13, '8.5', 'V', 'D', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(272, 1, 9, 8, 'FADDIKORR-KISKUNHALASI FC', 9, 2, 3, 4, 19, 20, -1, 9, '5.8', 'GY', 'D', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(273, 1, 9, 9, 'DUNA ASZFALT TLC II.', 9, 2, 3, 4, 15, 17, -2, 9, '5.9', 'V', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(274, 1, 9, 10, 'AKASZTÓ FC', 8, 2, 3, 3, 15, 19, -4, 9, '7.9', 'D', 'D', 'D', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(275, 1, 9, 11, 'KECEL FC', 9, 2, 2, 5, 10, 26, -16, 8, '6.7', 'D', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(276, 1, 9, 12, 'SOLTVADKERTI TE', 8, 1, 3, 4, 12, 18, -6, 6, '5.6', 'V', 'D', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(277, 1, 9, 13, 'KISKŐRÖSI LC', 8, 1, 2, 5, 8, 16, -8, 5, '6', 'V', 'V', 'V', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(278, 1, 9, 14, 'KECSKEMÉTI LC', 8, 1, 2, 5, 9, 20, -11, 5, '6', 'V', 'GY', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(279, 1, 9, 15, 'BÁCSALMÁSI PVSE', 8, 0, 1, 7, 7, 21, -14, 1, '6.6', 'V', 'V', 'V', 'V', 'V', 0, 'system', '2020-07-14 11:24:23', NULL, NULL),
(280, 1, 10, 1, 'HARTA SE', 10, 7, 1, 2, 34, 20, 14, 22, '10.3', 'V', 'GY', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(281, 1, 10, 2, 'JÁNOSHALMI FC', 9, 7, 1, 1, 17, 8, 9, 22, '10.9', 'D', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(282, 1, 10, 3, 'KISKUNFÉLEGYHÁZI HTK', 9, 6, 3, 0, 25, 13, 12, 21, '9.3', 'GY', 'GY', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(283, 1, 10, 4, 'KALOCSAI FC', 10, 5, 2, 3, 9, 10, -1, 17, '9.6', 'V', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(284, 1, 10, 5, 'KEREKEGYHÁZI SE', 9, 4, 4, 1, 30, 14, 16, 16, '7.8', 'GY', 'V', 'D', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(285, 1, 10, 6, 'SZABADSZÁLLÁSI SE', 9, 4, 3, 2, 22, 12, 10, 15, '8', 'D', 'GY', 'D', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(286, 1, 10, 7, 'LAJOSMIZSEI VLC', 9, 4, 3, 2, 20, 18, 2, 15, '10', 'V', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(287, 1, 10, 8, 'FADDIKORR-KISKUNHALASI FC', 10, 3, 3, 4, 23, 20, 3, 12, '6.5', 'GY', 'GY', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(288, 1, 10, 9, 'DUNA ASZFALT TLC II.', 10, 3, 3, 4, 20, 18, 2, 12, '6.7', 'GY', 'V', 'D', 'V', 'GY', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(289, 1, 10, 10, 'AKASZTÓ FC', 9, 2, 3, 4, 15, 23, -8, 9, '8.4', 'V', 'D', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(290, 1, 10, 11, 'KECEL FC', 10, 2, 3, 5, 12, 28, -16, 9, '6.5', 'D', 'D', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(291, 1, 10, 12, 'KISKŐRÖSI LC', 9, 2, 2, 5, 12, 16, -4, 8, '6.4', 'GY', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(292, 1, 10, 13, 'SOLTVADKERTI TE', 9, 1, 3, 5, 12, 22, -10, 6, '6.1', 'V', 'V', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(293, 1, 10, 14, 'KECSKEMÉTI LC', 9, 1, 2, 6, 10, 25, -15, 5, '6.7', 'V', 'V', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(294, 1, 10, 15, 'BÁCSALMÁSI PVSE', 9, 0, 2, 7, 9, 23, -14, 2, '6', 'D', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:23', '2020-07-14 13:34:33', 'system'),
(295, 1, 11, 1, 'JÁNOSHALMI FC', 10, 8, 1, 1, 21, 11, 10, 25, '10.3', 'GY', 'D', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(296, 1, 11, 2, 'KISKUNFÉLEGYHÁZI HTK', 10, 7, 3, 0, 30, 13, 17, 24, '8.8', 'GY', 'GY', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(297, 1, 11, 3, 'HARTA SE', 11, 7, 1, 3, 34, 25, 9, 22, '9.5', 'V', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(298, 1, 11, 4, 'KALOCSAI FC', 11, 6, 2, 3, 12, 10, 2, 20, '9.3', 'GY', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(299, 1, 11, 5, 'SZABADSZÁLLÁSI SE', 10, 5, 3, 2, 26, 13, 13, 18, '8.5', 'GY', 'D', 'GY', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(300, 1, 11, 6, 'KEREKEGYHÁZI SE', 10, 4, 4, 2, 33, 18, 15, 16, '7.4', 'V', 'GY', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(301, 1, 11, 7, 'LAJOSMIZSEI VLC', 10, 4, 3, 3, 20, 21, -1, 15, '9.4', 'V', 'V', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(302, 1, 11, 8, 'FADDIKORR-KISKUNHALASI FC', 10, 3, 3, 4, 23, 20, 3, 12, '6.3', 'GY', 'GY', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(303, 1, 11, 9, 'DUNA ASZFALT TLC II.', 11, 3, 3, 5, 20, 20, 0, 12, '7.1', 'V', 'GY', 'V', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(304, 1, 11, 10, 'AKASZTÓ FC', 10, 2, 4, 4, 15, 23, -8, 10, '9.1', 'D', 'V', 'D', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(305, 1, 11, 11, 'SOLTVADKERTI TE', 10, 2, 3, 5, 14, 22, -8, 9, '6.3', 'GY', 'V', 'V', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(306, 1, 11, 12, 'KECEL FC', 11, 2, 3, 6, 12, 32, -20, 9, '7.3', 'V', 'D', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(307, 1, 11, 13, 'KISKŐRÖSI LC', 10, 2, 2, 6, 13, 20, -7, 8, '6.5', 'V', 'GY', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(308, 1, 11, 14, 'KECSKEMÉTI LC', 10, 2, 2, 6, 14, 25, -11, 8, '7', 'GY', 'V', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(309, 1, 11, 15, 'BÁCSALMÁSI PVSE', 10, 0, 3, 7, 9, 23, -14, 3, '6.7', 'D', 'D', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(310, 1, 12, 1, 'JÁNOSHALMI FC', 11, 9, 1, 1, 23, 12, 11, 28, '9.5', 'GY', 'GY', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(311, 1, 12, 2, 'HARTA SE', 12, 8, 1, 3, 37, 25, 12, 25, '9.3', 'GY', 'V', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(312, 1, 12, 3, 'KISKUNFÉLEGYHÁZI HTK', 11, 7, 3, 1, 31, 15, 16, 24, '8.1', 'V', 'GY', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(313, 1, 12, 4, 'SZABADSZÁLLÁSI SE', 11, 6, 3, 2, 29, 14, 15, 21, '9.1', 'GY', 'GY', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(314, 1, 12, 5, 'KALOCSAI FC', 11, 6, 2, 3, 12, 10, 2, 20, '9.2', 'GY', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(315, 1, 12, 6, 'KEREKEGYHÁZI SE', 11, 5, 4, 2, 38, 19, 19, 19, '7.9', 'GY', 'V', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(316, 1, 12, 7, 'LAJOSMIZSEI VLC', 11, 4, 3, 4, 20, 24, -4, 15, '8.8', 'V', 'V', 'V', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(317, 1, 12, 8, 'FADDIKORR-KISKUNHALASI FC', 11, 3, 4, 4, 25, 22, 3, 13, '6.5', 'D', 'GY', 'GY', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(318, 1, 12, 9, 'DUNA ASZFALT TLC II.', 12, 3, 4, 5, 22, 22, 0, 13, '7.1', 'D', 'V', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(319, 1, 12, 10, 'SOLTVADKERTI TE', 11, 3, 3, 5, 17, 23, -6, 12, '7', 'GY', 'GY', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(320, 1, 12, 11, 'AKASZTÓ FC', 11, 2, 4, 5, 16, 28, -12, 10, '8.5', 'V', 'D', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(321, 1, 12, 12, 'KISKŐRÖSI LC', 11, 2, 3, 6, 14, 21, -7, 9, '7.4', 'D', 'V', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(322, 1, 12, 13, 'KECSKEMÉTI LC', 11, 2, 3, 6, 15, 26, -11, 9, '7.5', 'D', 'GY', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(323, 1, 12, 14, 'KECEL FC', 12, 2, 3, 7, 13, 35, -22, 9, '7.4', 'V', 'V', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(324, 1, 12, 15, 'BÁCSALMÁSI PVSE', 11, 0, 3, 8, 10, 26, -16, 3, '6.7', 'V', 'D', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(325, 1, 13, 1, 'JÁNOSHALMI FC', 12, 10, 1, 1, 28, 12, 16, 31, '9.3', 'GY', 'GY', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(326, 1, 13, 2, 'KISKUNFÉLEGYHÁZI HTK', 12, 8, 3, 1, 35, 16, 19, 27, '8.4', 'GY', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(327, 1, 13, 3, 'HARTA SE', 13, 8, 1, 4, 38, 29, 9, 25, '8.9', 'V', 'GY', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(328, 1, 13, 4, 'KALOCSAI FC', 12, 7, 2, 3, 16, 11, 5, 23, '8.5', 'GY', 'GY', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(329, 1, 13, 5, 'SZABADSZÁLLÁSI SE', 12, 6, 4, 2, 29, 14, 15, 22, '8.8', 'D', 'GY', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(330, 1, 13, 6, 'KEREKEGYHÁZI SE', 12, 5, 5, 2, 38, 19, 19, 20, '7.6', 'D', 'GY', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(331, 1, 13, 7, 'FADDIKORR-KISKUNHALASI FC', 12, 4, 4, 4, 29, 24, 5, 16, '7.3', 'GY', 'D', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(332, 1, 13, 8, 'LAJOSMIZSEI VLC', 12, 4, 3, 5, 20, 29, -9, 15, '7.8', 'V', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(333, 1, 13, 9, 'DUNA ASZFALT TLC II.', 12, 3, 4, 5, 22, 22, 0, 13, '7.3', 'D', 'V', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(334, 1, 13, 10, 'KISKŐRÖSI LC', 12, 3, 3, 6, 16, 21, -5, 12, '7.8', 'GY', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(335, 1, 13, 11, 'SOLTVADKERTI TE', 12, 3, 3, 6, 17, 25, -8, 12, '7.3', 'V', 'GY', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(336, 1, 13, 12, 'KECSKEMÉTI LC', 12, 3, 3, 6, 17, 27, -10, 12, '8.3', 'GY', 'D', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(337, 1, 13, 13, 'AKASZTÓ FC', 12, 2, 4, 6, 17, 32, -15, 10, '7.9', 'V', 'V', 'D', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(338, 1, 13, 14, 'KECEL FC', 13, 2, 3, 8, 15, 39, -24, 9, '7.5', 'V', 'V', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(339, 1, 13, 15, 'BÁCSALMÁSI PVSE', 12, 0, 3, 9, 11, 28, -17, 3, '7.3', 'V', 'V', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(340, 1, 14, 1, 'JÁNOSHALMI FC', 13, 10, 1, 2, 29, 15, 14, 31, '8.8', 'V', 'GY', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(341, 1, 14, 2, 'KISKUNFÉLEGYHÁZI HTK', 13, 8, 4, 1, 36, 17, 19, 28, '8.1', 'D', 'GY', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(342, 1, 14, 3, 'KALOCSAI FC', 13, 8, 2, 3, 19, 12, 7, 26, '8.2', 'GY', 'GY', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(343, 1, 14, 4, 'HARTA SE', 13, 8, 1, 4, 38, 29, 9, 25, '8.8', 'V', 'GY', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(344, 1, 14, 5, 'KEREKEGYHÁZI SE', 13, 6, 5, 2, 41, 20, 21, 23, '7.9', 'GY', 'D', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(345, 1, 14, 6, 'SZABADSZÁLLÁSI SE', 13, 6, 5, 2, 30, 15, 15, 23, '8.2', 'D', 'D', 'GY', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(346, 1, 14, 7, 'FADDIKORR-KISKUNHALASI FC', 13, 4, 5, 4, 32, 27, 5, 17, '7.5', 'D', 'GY', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(347, 1, 14, 8, 'LAJOSMIZSEI VLC', 13, 4, 3, 6, 21, 31, -10, 15, '8.2', 'V', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(348, 1, 14, 9, 'DUNA ASZFALT TLC II.', 13, 3, 5, 5, 23, 23, 0, 14, '7.8', 'D', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(349, 1, 14, 10, 'KISKŐRÖSI LC', 13, 3, 4, 6, 19, 24, -5, 13, '7.8', 'D', 'GY', 'D', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(350, 1, 14, 11, 'AKASZTÓ FC', 13, 3, 4, 6, 19, 33, -14, 13, '8.2', 'GY', 'V', 'V', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(351, 1, 14, 12, 'SOLTVADKERTI TE', 13, 3, 3, 7, 17, 26, -9, 12, '7.9', 'V', 'V', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(352, 1, 14, 13, 'KECSKEMÉTI LC', 13, 3, 3, 7, 18, 30, -12, 12, '8.1', 'V', 'GY', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(353, 1, 14, 14, 'KECEL FC', 14, 2, 4, 8, 16, 40, -24, 10, '7.6', 'D', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(354, 1, 14, 15, 'BÁCSALMÁSI PVSE', 13, 1, 3, 9, 12, 28, -16, 6, '7.5', 'GY', 'V', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(355, 1, 15, 1, 'JÁNOSHALMI FC', 14, 11, 1, 2, 35, 15, 20, 34, '8.5', 'GY', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(356, 1, 15, 2, 'KISKUNFÉLEGYHÁZI HTK', 14, 9, 4, 1, 39, 18, 21, 31, '8.4', 'GY', 'D', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(357, 1, 15, 3, 'KALOCSAI FC', 14, 9, 2, 3, 21, 12, 9, 29, '8.4', 'GY', 'GY', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(358, 1, 15, 4, 'SZABADSZÁLLÁSI SE', 14, 7, 5, 2, 34, 16, 18, 26, '8.3', 'GY', 'D', 'D', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(359, 1, 15, 5, 'HARTA SE', 14, 8, 1, 5, 38, 35, 3, 25, '8.2', 'V', 'V', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(360, 1, 15, 6, 'KEREKEGYHÁZI SE', 14, 6, 5, 3, 41, 23, 18, 23, '8.1', 'V', 'GY', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(361, 1, 15, 7, 'FADDIKORR-KISKUNHALASI FC', 14, 4, 5, 5, 34, 30, 4, 17, '8.1', 'V', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(362, 1, 15, 8, 'KISKŐRÖSI LC', 14, 4, 4, 6, 21, 25, -4, 16, '8', 'GY', 'D', 'GY', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(363, 1, 15, 9, 'SOLTVADKERTI TE', 14, 4, 3, 7, 20, 26, -6, 15, '7.9', 'GY', 'V', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(364, 1, 15, 10, 'LAJOSMIZSEI VLC', 14, 4, 3, 7, 22, 35, -13, 15, '7.9', 'V', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(365, 1, 15, 11, 'DUNA ASZFALT TLC II.', 14, 3, 5, 6, 24, 25, -1, 14, '7.8', 'V', 'D', 'D', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(366, 1, 15, 12, 'AKASZTÓ FC', 14, 3, 4, 7, 19, 35, -16, 13, '7.7', 'V', 'GY', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(367, 1, 15, 13, 'KECSKEMÉTI LC', 14, 3, 3, 8, 19, 33, -14, 12, '7.6', 'V', 'V', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(368, 1, 15, 14, 'KECEL FC', 14, 2, 4, 8, 16, 40, -24, 10, '7.6', 'D', 'V', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(369, 1, 15, 15, 'BÁCSALMÁSI PVSE', 14, 2, 3, 9, 15, 30, -15, 9, '7.5', 'GY', 'GY', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(370, 1, 16, 1, 'JÁNOSHALMI FC', 14, 11, 1, 2, 35, 15, 20, 34, '8.5', 'GY', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(371, 1, 16, 2, 'KALOCSAI FC', 15, 10, 2, 3, 22, 12, 10, 32, '8.3', 'GY', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(372, 1, 16, 3, 'KISKUNFÉLEGYHÁZI HTK', 15, 9, 5, 1, 41, 20, 21, 32, '8.5', 'D', 'GY', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(373, 1, 16, 4, 'HARTA SE', 15, 8, 2, 5, 40, 37, 3, 26, '8.5', 'D', 'V', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(374, 1, 16, 5, 'KEREKEGYHÁZI SE', 15, 7, 5, 3, 43, 23, 20, 26, '8.1', 'GY', 'V', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(375, 1, 16, 6, 'SZABADSZÁLLÁSI SE', 15, 7, 5, 3, 34, 17, 17, 26, '7.7', 'V', 'GY', 'D', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(376, 1, 16, 7, 'FADDIKORR-KISKUNHALASI FC', 15, 4, 5, 6, 34, 32, 2, 17, '7.9', 'V', 'V', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(377, 1, 16, 8, 'DUNA ASZFALT TLC II.', 15, 4, 5, 6, 26, 26, 0, 17, '8.5', 'GY', 'V', 'D', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(378, 1, 16, 9, 'KISKŐRÖSI LC', 15, 4, 4, 7, 21, 26, -5, 16, '8.3', 'V', 'GY', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(379, 1, 16, 10, 'SOLTVADKERTI TE', 15, 4, 4, 7, 22, 28, -6, 16, '7.5', 'D', 'GY', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(380, 1, 16, 11, 'LAJOSMIZSEI VLC', 15, 4, 4, 7, 22, 35, -13, 16, '8.1', 'D', 'V', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(381, 1, 16, 12, 'AKASZTÓ FC', 15, 3, 5, 7, 21, 37, -16, 14, '7.5', 'D', 'V', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(382, 1, 16, 13, 'KECSKEMÉTI LC', 15, 3, 4, 8, 19, 33, -14, 13, '7.9', 'D', 'V', 'V', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(383, 1, 16, 14, 'KECEL FC', 15, 3, 4, 8, 17, 40, -23, 13, '7.7', 'GY', 'D', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(384, 1, 16, 15, 'BÁCSALMÁSI PVSE', 15, 2, 3, 10, 16, 32, -16, 9, '7.5', 'V', 'GY', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(385, 1, 17, 1, 'JÁNOSHALMI FC', 15, 12, 1, 2, 38, 16, 22, 37, '8.9', 'GY', 'GY', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(386, 1, 17, 2, 'KALOCSAI FC', 16, 10, 2, 4, 22, 14, 8, 32, '8.4', 'V', 'GY', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(387, 1, 17, 3, 'KISKUNFÉLEGYHÁZI HTK', 16, 9, 5, 2, 42, 23, 19, 32, '8.3', 'V', 'D', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(388, 1, 17, 4, 'SZABADSZÁLLÁSI SE', 16, 8, 5, 3, 36, 18, 18, 29, '7.8', 'GY', 'V', 'GY', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(389, 1, 17, 5, 'KEREKEGYHÁZI SE', 16, 7, 6, 3, 45, 25, 20, 27, '8.1', 'D', 'GY', 'V', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(390, 1, 17, 6, 'HARTA SE', 16, 8, 2, 6, 41, 39, 2, 26, '8.3', 'V', 'D', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(391, 1, 17, 7, 'FADDIKORR-KISKUNHALASI FC', 16, 5, 5, 6, 37, 33, 4, 20, '7.6', 'GY', 'V', 'V', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(392, 1, 17, 8, 'DUNA ASZFALT TLC II.', 16, 4, 6, 6, 28, 28, 0, 18, '8.3', 'D', 'GY', 'V', 'D', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(393, 1, 17, 9, 'SOLTVADKERTI TE', 16, 4, 5, 7, 23, 29, -6, 17, '7.8', 'D', 'D', 'GY', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(394, 1, 17, 10, 'LAJOSMIZSEI VLC', 16, 4, 5, 7, 23, 36, -13, 17, '8.2', 'D', 'D', 'V', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(395, 1, 17, 11, 'KISKŐRÖSI LC', 15, 4, 4, 7, 21, 26, -5, 16, '8.1', 'V', 'GY', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(396, 1, 17, 12, 'KECSKEMÉTI LC', 16, 4, 4, 8, 21, 33, -12, 16, '7.5', 'GY', 'D', 'V', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(397, 1, 17, 13, 'KECEL FC', 16, 4, 4, 8, 18, 40, -22, 16, '8.3', 'GY', 'GY', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(398, 1, 17, 14, 'AKASZTÓ FC', 16, 3, 5, 8, 22, 40, -18, 14, '7.1', 'V', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(399, 1, 17, 15, 'BÁCSALMÁSI PVSE', 16, 2, 3, 11, 16, 33, -17, 9, '7.9', 'V', 'V', 'GY', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(400, 1, 18, 1, 'JÁNOSHALMI FC', 16, 12, 2, 2, 40, 18, 22, 38, '8.6', 'D', 'GY', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(401, 1, 18, 2, 'KALOCSAI FC', 17, 10, 2, 5, 23, 19, 4, 32, '8.5', 'V', 'V', 'GY', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(402, 1, 18, 3, 'KISKUNFÉLEGYHÁZI HTK', 17, 9, 5, 3, 45, 28, 17, 32, '8.3', 'V', 'V', 'D', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(403, 1, 18, 4, 'KEREKEGYHÁZI SE', 17, 8, 6, 3, 48, 27, 21, 30, '8.5', 'GY', 'D', 'GY', 'V', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(404, 1, 18, 5, 'SZABADSZÁLLÁSI SE', 17, 8, 6, 3, 38, 20, 18, 30, '7.3', 'D', 'GY', 'V', 'GY', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(405, 1, 18, 6, 'HARTA SE', 17, 9, 2, 6, 44, 41, 3, 29, '8.5', 'GY', 'V', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(406, 1, 18, 7, 'FADDIKORR-KISKUNHALASI FC', 17, 5, 6, 6, 38, 34, 4, 21, '7.6', 'D', 'GY', 'V', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(407, 1, 18, 8, 'DUNA ASZFALT TLC II.', 17, 5, 6, 6, 33, 31, 2, 21, '7.9', 'GY', 'D', 'GY', 'V', 'D', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(408, 1, 18, 9, 'SOLTVADKERTI TE', 17, 5, 5, 7, 28, 30, -2, 20, '7.4', 'GY', 'D', 'D', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(409, 1, 18, 10, 'LAJOSMIZSEI VLC', 17, 4, 6, 7, 24, 37, -13, 18, '8.1', 'D', 'D', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(410, 1, 18, 11, 'KISKŐRÖSI LC', 16, 4, 5, 7, 21, 26, -5, 17, '8.6', 'D', 'V', 'GY', 'D', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(411, 1, 18, 12, 'KECSKEMÉTI LC', 17, 4, 4, 9, 23, 36, -13, 16, '7.4', 'V', 'GY', 'D', 'V', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(412, 1, 18, 13, 'KECEL FC', 17, 4, 4, 9, 20, 43, -23, 16, '8.1', 'V', 'GY', 'GY', 'D', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(413, 1, 18, 14, 'AKASZTÓ FC', 16, 3, 5, 8, 22, 40, -18, 14, '7.1', 'V', 'D', 'V', 'GY', 'V', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system'),
(414, 1, 18, 15, 'BÁCSALMÁSI PVSE', 17, 2, 4, 11, 16, 33, -17, 10, '8.1', 'D', 'V', 'V', 'GY', 'GY', 1, 'system', '2020-07-14 11:24:24', '2020-07-14 13:34:33', 'system');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainer_rating`
--

DROP TABLE IF EXISTS `trainerrating`;
CREATE TABLE IF NOT EXISTS `trainerrating` (
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `trainer_rating`
--

INSERT INTO `trainerrating` (`ID`, `ORG_ID`, `TEAM_ID`, `USER_ID`, `DONE`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(27, 1, 5001, 10, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(28, 1, 5001, 14, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(29, 1, 5001, 15, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(30, 1, 5001, 16, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(31, 1, 5001, 17, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(32, 1, 5001, 18, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(33, 1, 5001, 19, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(34, 1, 5001, 20, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(35, 1, 5001, 21, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(36, 1, 5001, 22, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(37, 1, 5001, 23, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(38, 1, 5001, 24, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(39, 1, 5001, 25, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(40, 1, 5001, 26, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(41, 1, 5001, 27, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(42, 1, 5001, 28, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(43, 1, 5001, 29, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(44, 1, 5001, 30, 0, 1, 'system', '2020-07-20 17:30:11', '2020-07-20 17:36:01', 'system'),
(45, 1, 5001, 10, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(46, 1, 5001, 14, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(47, 1, 5001, 15, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(48, 1, 5001, 16, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(49, 1, 5001, 17, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(50, 1, 5001, 18, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(51, 1, 5001, 19, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(52, 1, 5001, 20, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(53, 1, 5001, 21, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(54, 1, 5001, 22, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(55, 1, 5001, 23, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(56, 1, 5001, 24, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(57, 1, 5001, 25, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(58, 1, 5001, 26, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(59, 1, 5001, 27, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(60, 1, 5001, 28, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(61, 1, 5001, 29, 0, 1, 'system', '2020-07-20 17:36:01', '2020-07-20 17:46:44', 'system'),
(62, 1, 5001, 30, 0, 1, 'system', '2020-07-20 17:36:02', '2020-07-20 17:46:44', 'system'),
(63, 1, 5001, 10, 1, 5, 'system', '2020-07-20 17:46:44', '2020-07-23 06:11:05', 'farago.samuel'),
(64, 1, 5001, 14, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(65, 1, 5001, 15, 1, 1, 'system', '2020-07-20 17:46:44', '2020-07-25 08:09:18', 'csordas.mate'),
(66, 1, 5001, 16, 1, 1, 'system', '2020-07-20 17:46:44', '2020-08-10 11:19:33', 'bogar.imre'),
(67, 1, 5001, 17, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(68, 1, 5001, 18, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(69, 1, 5001, 19, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(70, 1, 5001, 20, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(71, 1, 5001, 21, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(72, 1, 5001, 22, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(73, 1, 5001, 23, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(74, 1, 5001, 24, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(75, 1, 5001, 25, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(76, 1, 5001, 26, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(77, 1, 5001, 27, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(78, 1, 5001, 28, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(79, 1, 5001, 29, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL),
(80, 1, 5001, 30, NULL, 0, 'system', '2020-07-20 17:46:44', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `trainer_rating_result`
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
  `CREATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `CREATION_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LAST_UPDATE_DATE` timestamp NULL DEFAULT NULL,
  `LAST_UPDATED_BY` varchar(255) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `trainer_rating_result`
--

INSERT INTO `trainerratingresult` (`ID`, `ORG_ID`, `TEAM_ID`, `TRAINER_ID`, `RESULT`, `RATING_DATE`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(13, 1, 5001, 11, 9, '2020-07-20 17:46:44', 0, 'farago.samuel', '2020-07-23 06:11:05', NULL, NULL),
(14, 1, 5001, 11, 7, '2020-07-20 17:46:44', 0, 'csordas.mate', '2020-07-25 08:09:18', NULL, NULL),
(15, 1, 5001, 11, 9, '2020-07-20 17:46:44', 0, 'bogar.imre', '2020-08-10 11:19:33', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `training_planner`
--

DROP TABLE IF EXISTS `trainingplan`;
CREATE TABLE IF NOT EXISTS `trainingplan` (
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `training_planner`
--

INSERT INTO `trainingplan` (`ID`, `ORGANIZATION_ID`, `TEAM_ID`, `TRAINING_DATE`, `EXERCISE_1_ID`, `EXERCISE_1_TIME_MIN`, `EXERCISE_2_ID`, `EXERCISE_2_TIME_MIN`, `EXERCISE_3_ID`, `EXERCISE_3_TIME_MIN`, `EXERCISE_4_ID`, `EXERCISE_4_TIME_MIN`, `EXERCISE_5_ID`, `EXERCISE_5_TIME_MIN`, `EXERCISE_6_ID`, `EXERCISE_6_TIME_MIN`, `EXERCISE_7_ID`, `EXERCISE_7_TIME_MIN`, `EXERCISE_8_ID`, `EXERCISE_8_TIME_MIN`, `EXERCISE_9_ID`, `EXERCISE_9_TIME_MIN`, `EXERCISE_10_ID`, `EXERCISE_10_TIME_MIN`, `EXERCISE_11_ID`, `EXERCISE_11_TIME_MIN`, `EXERCISE_12_ID`, `EXERCISE_12_TIME_MIN`, `EXERCISE_13_ID`, `EXERCISE_13_TIME_MIN`, `EXERCISE_14_ID`, `EXERCISE_14_TIME_MIN`, `EXERCISE_15_ID`, `EXERCISE_15_TIME_MIN`, `EXERCISE_16_ID`, `EXERCISE_16_TIME_MIN`, `EXERCISE_17_ID`, `EXERCISE_17_TIME_MIN`, `EXERCISE_18_ID`, `EXERCISE_18_TIME_MIN`, `EXERCISE_19_ID`, `EXERCISE_19_TIME_MIN`, `EXERCISE_20_ID`, `EXERCISE_20_TIME_MIN`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 5001, '2020-07-18 15:25:00', 32, 10, 33, 10, 31, 10, 34, 10, 32, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-18 15:26:13', NULL, NULL),
(2, 1, 5001, '2020-07-23 13:37:00', 32, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-19 13:37:17', NULL, NULL),
(3, 1, 5001, '2020-07-29 16:44:00', 31, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(4, 1, 5001, '2020-08-01 20:41:00', 34, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(5, 1, 5001, '2020-07-30 22:49:00', 31, 20, 32, 10, 34, 30, 36, 40, 38, 10, 33, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(6, 1, 5001, '2020-07-25 08:00:00', 32, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(7, 1, 5001, '2020-09-11 06:00:00', 31, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(8, 1, 5001, '2020-09-25 06:52:00', 32, 10, 33, 10, 35, 10, 31, 10, 37, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(10, 1, 5001, '2020-09-26 17:04:00', 31, 10, 32, 10, 34, 10, 36, 10, 35, 10, 37, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`ID`, `USERNAME`, `NAME`, `PASSWORD`, `PROFIL_IMG`, `EMAIL`, `PHONE_NUMBER`, `DATABANK_URL`, `PLAYER`, `TRAINER`, `DELETED`, `ENABLED`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 'Admin', 'Adminisztrátor', '$2a$10$PvXhF9vBrFEYhZ/4Bj31tuT4z0HAXZpxd5QwoHX6C7/IAeCAfwoJe', 'userphoto.png', 'redlymatyi@gmail.com', 'asd', '', 0, 0, 0, 1, 3, NULL, '2020-02-16 14:08:05', '2020-06-13 15:54:45', 'Admin'),
(10, 'farago.samuel', 'Faragó Sámuel', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'farago.samuel_PregaFS.jpg', 'farago.samuel@gmail.com', '06-20-263-1254', 'http://ada1bank.mlsz.hu/player?itemId=373780', 1, 0, 0, 1, 26, NULL, '2020-02-16 14:08:05', '2020-06-19 19:22:32', 'farago.samuel'),
(11, 'Edzo', 'Lalibá', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, NULL, 0, 1, 0, 1, 1, NULL, '2020-02-16 14:08:05', '2020-02-16 14:44:57', NULL),
(12, 'Tulajdonos', 'Horváth János', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, NULL, 0, 0, 0, 1, 1, NULL, '2020-02-16 14:08:05', '2020-02-16 14:44:57', NULL),
(13, 'Szulo', 'Kiss Pál', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, NULL, 0, 0, 0, 1, 1, NULL, '2020-02-16 14:08:05', '2020-02-16 14:44:57', NULL),
(14, 's.juhasz.tamas', 'S.Juhász Tamás', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=251892', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:53:56', NULL),
(15, 'csordas.mate', 'Csordás Máté', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=302689\r\n', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:53:58', NULL),
(16, 'bogar.imre', 'Bogár Imre', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=163365', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:00', NULL),
(17, 'bozsik.mate', 'Bozsik Máté', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=303498', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:01', NULL),
(18, 'erdelyi.gabor', 'Erdélyi Gábor', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=347322', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:02', NULL),
(19, 'koros.jozsef', 'Kőrös József', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=302692', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:03', NULL),
(20, 'major.david', 'Major Dávid', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=303497', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:04', NULL),
(21, 'modra.gergo', 'Módra Gergő', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=425083', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:06', NULL),
(22, 'nemesvari.dani', 'Nemesvári Dani', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=372618', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:07', NULL),
(23, 'palnok.laszlo', 'Pálnok László', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=371677', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:08', NULL),
(24, 'pentek.jozsef', 'Péntek József', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=269293', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:10', NULL),
(25, 'stein.csaba', 'Stein Csaba', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'https://adatbank.mlsz.hu/player/324712.html', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:11', NULL),
(26, 'szucs.dominik', 'Szűcs Dominik', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=425075', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:12', NULL),
(27, 'toth.kornel', 'Tóth Kornél', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=289239', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:13', NULL),
(28, 'szedmak.roland', 'Szedmák Roland', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=357157', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:15', NULL),
(29, 'pusztai.attila', 'Pusztai Attila', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=425082', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:16', NULL),
(30, 'zsoldos.laszlo', 'Zsoldos László', '$2a$10$u2QqdDwCt8ir7CwO/qcpf.x6Xicvfp6l1AIypGusEsgPlITr/6qGa', 'userphoto.png', NULL, NULL, 'http://ada1bank.mlsz.hu/player?itemId=385038', 1, 0, 0, 1, 2, NULL, '2020-05-28 15:03:56', '2020-06-01 13:54:17', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_notification`
--

DROP TABLE IF EXISTS `usernotification`;
CREATE TABLE IF NOT EXISTS `usernotification` (
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
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_notification`
--

INSERT INTO `usernotification` (`ID`, `USER_ID`, `SRC`, `TITLE`, `DESCRIPTION`, `SEEN`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 10, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-09 16:00:26', '2020-07-19 16:26:56', 'farago.samuel'),
(2, 14, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(3, 15, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(4, 16, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(5, 17, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(6, 18, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(7, 19, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(8, 20, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(9, 21, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(10, 22, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(11, 23, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(12, 24, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(13, 25, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(14, 26, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(15, 27, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(16, 28, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(17, 29, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(18, 30, 'trainingplan', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:00:26', NULL, NULL),
(19, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-09 16:14:32', '2020-07-19 16:26:53', 'farago.samuel'),
(20, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(21, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(22, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(23, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(24, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(25, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(26, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(27, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(28, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(29, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(30, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(31, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(32, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(33, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(34, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(35, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(36, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-09 16:14:32', NULL, NULL),
(37, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-12 15:58:27', '2020-07-19 16:26:50', 'farago.samuel'),
(38, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(39, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(40, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(41, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(42, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(43, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(44, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(45, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(46, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(47, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(48, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(49, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(50, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(51, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(52, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(53, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(54, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-12 15:58:27', NULL, NULL),
(55, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 14:51:23', '2020-07-19 16:26:48', 'farago.samuel'),
(56, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(57, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 14:51:23', '2020-07-25 08:09:04', 'csordas.mate'),
(58, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(59, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(60, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(61, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(62, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(63, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(64, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(65, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(66, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(67, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(68, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(69, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(70, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(71, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(72, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 14:51:23', NULL, NULL),
(73, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 20:13:46', '2020-07-19 16:26:45', 'farago.samuel'),
(74, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(75, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(76, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(77, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(78, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(79, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(80, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(81, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(82, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(83, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(84, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(85, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(86, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(87, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(88, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(89, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(90, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:13:46', NULL, NULL),
(91, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 20:15:08', '2020-07-19 16:26:40', 'farago.samuel'),
(92, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(93, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(94, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(95, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(96, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(97, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(98, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(99, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(100, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(101, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(102, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(103, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(104, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(105, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(106, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(107, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(108, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:15:08', NULL, NULL),
(109, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 20:29:49', '2020-07-19 16:22:19', 'farago.samuel'),
(110, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(111, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(112, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(113, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(114, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(115, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(116, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(117, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(118, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(119, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(120, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(121, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(122, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(123, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(124, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(125, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(126, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:29:49', NULL, NULL),
(127, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 20:32:06', '2020-07-19 16:22:01', 'farago.samuel'),
(128, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(129, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(130, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(131, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(132, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(133, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(134, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(135, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(136, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(137, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(138, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(139, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(140, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(141, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(142, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(143, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(144, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 20:32:06', NULL, NULL),
(145, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 21:02:55', '2020-07-19 16:19:55', 'farago.samuel'),
(146, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(147, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(148, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(149, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(150, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(151, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(152, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(153, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(154, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(155, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(156, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(157, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(158, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(159, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(160, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(161, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(162, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:02:55', NULL, NULL),
(163, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-06-19 21:03:21', '2020-07-19 16:19:29', 'farago.samuel'),
(164, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(165, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(166, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(167, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(168, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(169, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(170, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(171, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(172, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(173, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(174, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(175, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(176, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(177, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(178, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(179, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(180, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-06-19 21:03:22', NULL, NULL),
(181, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-07-22 16:44:36', '2020-07-22 18:46:35', 'farago.samuel'),
(182, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(183, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(184, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(185, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(186, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(187, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(188, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(189, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(190, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(191, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(192, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(193, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(194, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(195, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(196, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(197, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(198, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 16:44:36', NULL, NULL),
(199, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-07-22 18:41:52', '2020-07-22 18:46:29', 'farago.samuel'),
(200, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(201, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(202, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(203, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(204, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(205, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(206, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(207, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(208, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(209, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(210, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(211, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(212, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(213, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(214, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(215, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(216, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-22 18:41:52', NULL, NULL),
(217, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-07-24 22:47:03', '2020-07-24 23:31:34', 'farago.samuel'),
(218, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(219, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(220, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-07-24 22:47:03', '2020-08-10 11:26:44', 'bogar.imre'),
(221, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(222, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(223, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(224, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(225, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(226, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(227, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(228, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(229, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(230, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(231, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(232, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(233, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(234, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-24 22:47:03', NULL, NULL),
(235, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-07-25 08:01:07', '2020-07-25 08:02:18', 'farago.samuel'),
(236, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(237, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(238, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(239, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(240, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(241, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(242, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(243, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(244, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(245, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(246, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(247, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(248, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(249, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(250, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(251, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(252, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-07-25 08:01:07', NULL, NULL),
(253, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-09-04 05:25:40', '2020-09-04 05:26:02', 'farago.samuel'),
(254, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(255, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(256, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(257, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(258, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(259, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(260, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(261, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(262, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(263, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(264, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(265, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(266, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(267, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(268, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(269, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(270, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 05:25:40', NULL, NULL),
(271, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-09-04 06:53:41', '2020-09-04 13:53:32', 'farago.samuel'),
(272, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(273, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(274, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(275, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(276, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(277, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(278, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(279, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(280, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(281, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(282, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(283, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(284, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(285, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(286, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(287, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(288, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-04 06:53:41', NULL, NULL),
(289, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-09-13 07:26:34', '2020-09-22 14:41:21', 'farago.samuel'),
(290, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(291, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(292, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(293, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(294, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(295, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(296, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(297, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(298, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(299, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(300, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(301, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(302, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(303, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(304, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(305, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(306, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-13 07:26:34', NULL, NULL),
(307, 10, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 1, 1, 'Edzo', '2020-09-25 17:05:45', '2020-09-26 10:59:14', 'farago.samuel'),
(308, 14, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(309, 15, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(310, 16, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(311, 17, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(312, 18, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(313, 19, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(314, 20, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(315, 21, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(316, 22, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(317, 23, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(318, 24, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(319, 25, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(320, 26, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(321, 27, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(322, 28, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(323, 29, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL),
(324, 30, 'workout', 'Új edzés', 'Lalibá edzést vett fel!', 0, 0, 'Edzo', '2020-09-25 17:05:45', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_organization`
--

DROP TABLE IF EXISTS `userclub`;
CREATE TABLE IF NOT EXISTS `userclub` (
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_organization`
--

INSERT INTO `userclub` (`ID`, `USER_ID`, `ORGANIZATION_ID`, `TEAM_ID`, `LIGA_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(8, 10, 1, 5001, 1, 1, 'Admin', '2020-01-25 07:39:27', NULL, NULL),
(9, 11, 1, 5001, 1, 1, 'Admin', '2020-01-25 07:39:27', NULL, NULL),
(12, 12, 1, 5001, 1, 1, 'Admin', '2020-01-25 07:39:27', NULL, NULL),
(14, 14, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(15, 15, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(16, 16, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(17, 17, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(18, 18, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(19, 19, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(20, 20, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(21, 21, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(22, 22, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(23, 23, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(24, 24, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(25, 25, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(26, 26, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(27, 27, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(28, 28, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(29, 29, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL),
(30, 30, 1, 5001, 1, 1, NULL, '2020-05-28 15:29:14', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_post`
--

DROP TABLE IF EXISTS `userpost`;
CREATE TABLE IF NOT EXISTS `userpost` (
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_post`
--

INSERT INTO `userpost` (`ID`, `USER_ID`, `ORGANIZATION_ID`, `TEAM_ID`, `POST`, `IMAGE_URL`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 11, 1, NULL, '<div class=\"mb-4\">asd</div>', NULL, 0, 'Edzo', '2020-08-07 14:51:20', NULL, NULL),
(2, 11, 1, NULL, '<div class=\"mb-4\">bceouwvbewoivn</div>', NULL, 0, 'Edzo', '2020-08-11 09:08:41', NULL, NULL),
(3, 11, 1, NULL, '<div class=\"mb-4\">nkvnkréoré</div>', NULL, 0, 'Edzo', '2020-08-29 06:20:42', NULL, NULL),
(13, 10, 1, NULL, NULL, 'farago.samuel_d38395508b4f2eb38cfd2005a6d2b84d.jpg', 0, 'farago.samuel', '2020-09-09 17:37:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_post_comments`
--

DROP TABLE IF EXISTS `userpostcomment`;
CREATE TABLE IF NOT EXISTS `userpostcomment` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_post_comments`
--

INSERT INTO `userpostcomment` (`ID`, `USER_ID`, `POST_ID`, `COMMENT`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 11, 1, 'asd', 0, 'Edzo', '2020-08-07 14:51:27', NULL, NULL),
(2, 11, 1, 'asd2', 0, 'Edzo', '2020-08-07 14:51:31', NULL, NULL),
(3, 11, 2, 'igbn n fepepf', 0, 'Edzo', '2020-08-11 09:08:52', NULL, NULL),
(4, 10, 2, 'lalalala', 0, 'farago.samuel', '2020-08-16 10:42:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_roles`
--

DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_roles`
--

INSERT INTO `userrole` (`ID`, `USER_ID`, `ROLE_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(13, 1, 28, 1, NULL, '2020-02-16 14:08:06', NULL, NULL),
(14, 10, 27, 1, NULL, '2020-02-16 14:34:18', NULL, NULL),
(15, 11, 32, 1, NULL, '2020-02-16 14:34:18', NULL, NULL),
(16, 12, 33, 1, NULL, '2020-05-28 09:15:18', NULL, NULL),
(18, 14, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(19, 15, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(20, 16, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(21, 17, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(22, 18, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(23, 19, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(24, 20, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(25, 21, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(26, 22, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(27, 23, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(28, 24, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(29, 25, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(30, 26, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(31, 27, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(32, 28, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(33, 29, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL),
(34, 30, 27, 1, NULL, '2020-05-28 15:07:21', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `video`
--

INSERT INTO `video` (`ID`, `NAME`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(22, '8b4e529c-4b3d-444b-8c60-07943e8284d5.mp4', 0, 'Edzo', '2020-09-09 18:43:19', NULL, NULL),
(23, '40cf8c2d-4936-4696-bcdc-dd2c990942d5.mp4', 0, 'Edzo', '2020-09-09 18:46:15', NULL, NULL),
(24, '9f7ecf7f-05e7-497a-974a-137541f4b11a.mp4', 0, 'Edzo', '2020-09-10 04:06:04', NULL, NULL),
(25, '1366730d-aad3-4c8e-92ea-74ba6622e721.mp4', 0, 'Edzo', '2020-09-25 17:14:03', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `videoeditor`
--

INSERT INTO `videoeditor` (`ID`, `ORG_ID`, `TEAM_ID`, `SORSOLAS_ID`, `CUSTOM_GAME_ID`, `TRAINING_ID`, `VIDEO_ID`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(8, 1, 5001, NULL, 161, NULL, 22, 0, 'Edzo', '2020-09-09 18:43:19', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `workout`
--

INSERT INTO `workout` (`ID`, `ORG_ID`, `TEAM_ID`, `USER_ID`, `TRAINING_ID`, `EXERCISE_ID`, `RESULT`, `PERCENT`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(1, 1, 5001, 10, 1, 32, '6', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(2, 1, 5001, 10, 1, 33, '28', 28, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(3, 1, 5001, 10, 1, 31, '5', 100, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(4, 1, 5001, 10, 1, 34, '6', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(5, 1, 5001, 10, 1, 32, '6', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(6, 1, 5001, 14, 1, 32, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(7, 1, 5001, 14, 1, 33, '24', 24, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(8, 1, 5001, 14, 1, 31, '1', 20, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(9, 1, 5001, 14, 1, 34, '2', 20, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(10, 1, 5001, 14, 1, 32, '5', 50, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(11, 1, 5001, 15, 1, 32, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(12, 1, 5001, 15, 1, 33, '88', 88, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(13, 1, 5001, 15, 1, 31, '3', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(14, 1, 5001, 15, 1, 34, '9', 90, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(15, 1, 5001, 15, 1, 32, '3', 30, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(16, 1, 5001, 16, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(17, 1, 5001, 16, 1, 33, '90', 90, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(18, 1, 5001, 16, 1, 31, '3', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(19, 1, 5001, 16, 1, 34, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(20, 1, 5001, 16, 1, 32, '9', 90, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(21, 1, 5001, 17, 1, 32, '5', 50, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(22, 1, 5001, 17, 1, 33, '44', 44, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(23, 1, 5001, 17, 1, 31, '4', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(24, 1, 5001, 17, 1, 34, '3', 30, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(25, 1, 5001, 17, 1, 32, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(26, 1, 5001, 18, 1, 32, '5', 50, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(27, 1, 5001, 18, 1, 33, '56', 56, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(28, 1, 5001, 18, 1, 31, '2', 40, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(29, 1, 5001, 18, 1, 34, '4', 40, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(30, 1, 5001, 18, 1, 32, '6', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(31, 1, 5001, 19, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(32, 1, 5001, 19, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(33, 1, 5001, 19, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(34, 1, 5001, 19, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(35, 1, 5001, 19, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(36, 1, 5001, 20, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(37, 1, 5001, 20, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(38, 1, 5001, 20, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(39, 1, 5001, 20, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(40, 1, 5001, 20, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(41, 1, 5001, 21, 1, 32, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(42, 1, 5001, 21, 1, 33, '62', 62, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(43, 1, 5001, 21, 1, 31, '5', 100, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(44, 1, 5001, 21, 1, 34, '8', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(45, 1, 5001, 21, 1, 32, '6', 60, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(46, 1, 5001, 22, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(47, 1, 5001, 22, 1, 33, '72', 72, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(48, 1, 5001, 22, 1, 31, '4', 80, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(49, 1, 5001, 22, 1, 34, '9', 90, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(50, 1, 5001, 22, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:11', NULL, NULL),
(51, 1, 5001, 23, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(52, 1, 5001, 23, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(53, 1, 5001, 23, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(54, 1, 5001, 23, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(55, 1, 5001, 23, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(56, 1, 5001, 24, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(57, 1, 5001, 24, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(58, 1, 5001, 24, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(59, 1, 5001, 24, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(60, 1, 5001, 24, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(61, 1, 5001, 25, 1, 32, '5', 50, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(62, 1, 5001, 25, 1, 33, '74', 74, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(63, 1, 5001, 25, 1, 31, '4', 80, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(64, 1, 5001, 25, 1, 34, '4', 40, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(65, 1, 5001, 25, 1, 32, '5', 50, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(66, 1, 5001, 26, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(67, 1, 5001, 26, 1, 33, '35', 35, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(68, 1, 5001, 26, 1, 31, '5', 100, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(69, 1, 5001, 26, 1, 34, '5', 50, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(70, 1, 5001, 26, 1, 32, '6', 60, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(71, 1, 5001, 27, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(72, 1, 5001, 27, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(73, 1, 5001, 27, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(74, 1, 5001, 27, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(75, 1, 5001, 27, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(76, 1, 5001, 28, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(77, 1, 5001, 28, 1, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(78, 1, 5001, 28, 1, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(79, 1, 5001, 28, 1, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(80, 1, 5001, 28, 1, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(81, 1, 5001, 29, 1, 32, '8', 80, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(82, 1, 5001, 29, 1, 33, '34', 34, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(83, 1, 5001, 29, 1, 31, '4', 80, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(84, 1, 5001, 29, 1, 34, '9', 90, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(85, 1, 5001, 29, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(86, 1, 5001, 30, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(87, 1, 5001, 30, 1, 33, '73', 73, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(88, 1, 5001, 30, 1, 31, '2', 40, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(89, 1, 5001, 30, 1, 34, '6', 60, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(90, 1, 5001, 30, 1, 32, '7', 70, 0, 'Edzo', '2020-07-18 15:28:12', NULL, NULL),
(91, 1, 5001, 10, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(92, 1, 5001, 14, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(93, 1, 5001, 15, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(94, 1, 5001, 16, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(95, 1, 5001, 17, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(96, 1, 5001, 18, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:46', NULL, NULL),
(97, 1, 5001, 19, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(98, 1, 5001, 20, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(99, 1, 5001, 21, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(100, 1, 5001, 22, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(101, 1, 5001, 23, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(102, 1, 5001, 24, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(103, 1, 5001, 25, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(104, 1, 5001, 26, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(105, 1, 5001, 27, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(106, 1, 5001, 28, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(107, 1, 5001, 29, 2, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(108, 1, 5001, 30, 2, 32, '0', 0, 0, 'Edzo', '2020-07-22 17:03:47', NULL, NULL),
(109, 1, 5001, 10, 5, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(110, 1, 5001, 10, 5, 32, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(111, 1, 5001, 10, 5, 34, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(112, 1, 5001, 10, 5, 36, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(113, 1, 5001, 10, 5, 38, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(114, 1, 5001, 10, 5, 33, 'H~h~H', NULL, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(115, 1, 5001, 14, 5, 31, '4', 80, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(116, 1, 5001, 14, 5, 32, '6', 60, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(117, 1, 5001, 14, 5, 34, '6', 60, 0, 'Edzo', '2020-07-24 22:51:11', NULL, NULL),
(118, 1, 5001, 10, 8, 32, '7', 70, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(119, 1, 5001, 10, 8, 33, '33', 33, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(120, 1, 5001, 10, 8, 35, '3/10', 30, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(121, 1, 5001, 10, 8, 31, '5', 100, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(122, 1, 5001, 10, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(123, 1, 5001, 14, 8, 32, '8', 80, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(124, 1, 5001, 14, 8, 33, '73', 73, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(125, 1, 5001, 14, 8, 35, '3/10', 30, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(126, 1, 5001, 14, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(127, 1, 5001, 14, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(128, 1, 5001, 15, 8, 32, '5', 50, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(129, 1, 5001, 15, 8, 33, '81', 81, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(130, 1, 5001, 15, 8, 35, '2/10', 20, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(131, 1, 5001, 15, 8, 31, '3', 60, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(132, 1, 5001, 15, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(133, 1, 5001, 16, 8, 32, '6', 60, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(134, 1, 5001, 16, 8, 33, '67', 67, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(135, 1, 5001, 16, 8, 35, '6/10', 60, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(136, 1, 5001, 16, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(137, 1, 5001, 16, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(138, 1, 5001, 17, 8, 32, '8', 80, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(139, 1, 5001, 17, 8, 33, '59', 59, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(140, 1, 5001, 17, 8, 35, '3/10', 30, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(141, 1, 5001, 17, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(142, 1, 5001, 17, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(143, 1, 5001, 18, 8, 32, '3', 30, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(144, 1, 5001, 18, 8, 33, '57', 57, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(145, 1, 5001, 18, 8, 35, '4/10', 40, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(146, 1, 5001, 18, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(147, 1, 5001, 18, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(148, 1, 5001, 19, 8, 32, '7', 70, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(149, 1, 5001, 19, 8, 33, '38', 38, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(150, 1, 5001, 19, 8, 35, '4/10', 40, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(151, 1, 5001, 19, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(152, 1, 5001, 19, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(153, 1, 5001, 20, 8, 32, '2', 20, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(154, 1, 5001, 20, 8, 33, '88', 88, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(155, 1, 5001, 20, 8, 35, '5/10', 50, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(156, 1, 5001, 20, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(157, 1, 5001, 20, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(158, 1, 5001, 21, 8, 32, '7', 70, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(159, 1, 5001, 21, 8, 33, '61', 61, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(160, 1, 5001, 21, 8, 35, '1/10', 10, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(161, 1, 5001, 21, 8, 31, '3', 60, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(162, 1, 5001, 21, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:57', NULL, NULL),
(163, 1, 5001, 22, 8, 32, '10', 100, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(164, 1, 5001, 22, 8, 33, '0', 0, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(165, 1, 5001, 22, 8, 35, '7/10', 70, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(166, 1, 5001, 22, 8, 31, '5', 100, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(167, 1, 5001, 22, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(168, 1, 5001, 23, 8, 32, '4', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(169, 1, 5001, 23, 8, 33, '6', 6, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(170, 1, 5001, 23, 8, 35, '6/10', 60, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(171, 1, 5001, 23, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(172, 1, 5001, 23, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(173, 1, 5001, 24, 8, 32, '9', 90, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(174, 1, 5001, 24, 8, 33, '83', 83, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(175, 1, 5001, 24, 8, 35, '5/10', 50, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(176, 1, 5001, 24, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(177, 1, 5001, 24, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(178, 1, 5001, 25, 8, 32, '7', 70, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(179, 1, 5001, 25, 8, 33, '88', 88, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(180, 1, 5001, 25, 8, 35, '4/10', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(181, 1, 5001, 25, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(182, 1, 5001, 25, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(183, 1, 5001, 26, 8, 32, '10', 100, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(184, 1, 5001, 26, 8, 33, '94', 94, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(185, 1, 5001, 26, 8, 35, '3/10', 30, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(186, 1, 5001, 26, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(187, 1, 5001, 26, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(188, 1, 5001, 27, 8, 32, '4', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(189, 1, 5001, 27, 8, 33, '55', 55, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(190, 1, 5001, 27, 8, 35, '2/10', 20, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(191, 1, 5001, 27, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(192, 1, 5001, 27, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(193, 1, 5001, 28, 8, 32, '6', 60, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(194, 1, 5001, 28, 8, 33, '71', 71, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(195, 1, 5001, 28, 8, 35, '6/10', 60, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(196, 1, 5001, 28, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(197, 1, 5001, 28, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(198, 1, 5001, 29, 8, 32, '7', 70, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(199, 1, 5001, 29, 8, 33, '75', 75, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(200, 1, 5001, 29, 8, 35, '5/10', 50, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(201, 1, 5001, 29, 8, 31, '2', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(202, 1, 5001, 29, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(203, 1, 5001, 30, 8, 32, '4', 40, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(204, 1, 5001, 30, 8, 33, '51', 51, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(205, 1, 5001, 30, 8, 35, '7/10', 70, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(206, 1, 5001, 30, 8, 31, '4', 80, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(207, 1, 5001, 30, 8, 37, '', NULL, 0, 'Edzo', '2020-09-04 08:53:58', NULL, NULL),
(208, 1, 5001, 10, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(209, 1, 5001, 14, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(210, 1, 5001, 15, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(211, 1, 5001, 16, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(212, 1, 5001, 17, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(213, 1, 5001, 18, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(214, 1, 5001, 19, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(215, 1, 5001, 20, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(216, 1, 5001, 21, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(217, 1, 5001, 22, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(218, 1, 5001, 23, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(219, 1, 5001, 24, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(220, 1, 5001, 25, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(221, 1, 5001, 26, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(222, 1, 5001, 27, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(223, 1, 5001, 28, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(224, 1, 5001, 29, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL),
(225, 1, 5001, 30, 7, 31, 'H~h~H', NULL, 0, 'Edzo', '2020-09-13 07:34:42', NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `yellow_card`
--

DROP TABLE IF EXISTS `yellowcard`;
CREATE TABLE IF NOT EXISTS `yellowcard` (
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
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `yellow_card`
--

INSERT INTO `yellowcard` (`ID`, `ORG_ID`, `LIGA_ID`, `HELYEZES`, `NEV`, `CARD`, `VERSION`, `CREATED_BY`, `CREATION_DATE`, `LAST_UPDATE_DATE`, `LAST_UPDATED_BY`) VALUES
(159, 1, 1, 1, 'BOGÁR IMRE', 5, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(160, 1, 1, 2, 'BOZSIK MÁTÉ', 2, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(161, 1, 1, 2, 'SZEDMÁK ROLAND JÁNOS', 2, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(162, 1, 1, 4, 'CSORDÁS MÁTÉ', 1, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(163, 1, 1, 4, 'FARAGÓ SÁMUEL', 1, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(164, 1, 1, 4, 'GONDA ZSOLT', 1, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(165, 1, 1, 4, 'KŐRÖS JÓZSEF', 1, 0, NULL, '2020-06-02 13:43:38', NULL, NULL),
(166, 1, 1, 4, 'MAJOR DÁVID CSABA', 1, 0, NULL, '2020-06-02 13:43:38', NULL, NULL);

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
-- Megkötések a táblához `training_planner`
--
ALTER TABLE `trainingplan`
  ADD CONSTRAINT `fk_TRAINING_EXERCISE341234` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `club` (`ID`),
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
