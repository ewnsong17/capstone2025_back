-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.41 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- capstone 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `capstone`;
CREATE DATABASE IF NOT EXISTS `capstone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `capstone`;

-- 테이블 capstone.main_image_list 구조 내보내기
DROP TABLE IF EXISTS `main_image_list`;
CREATE TABLE IF NOT EXISTS `main_image_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('banner','package') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image_url` varchar(400) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='메인 하단 이미지 리스트';

-- 테이블 데이터 capstone.main_image_list:~0 rows (대략적) 내보내기
DELETE FROM `main_image_list`;
INSERT INTO `main_image_list` (`id`, `type`, `image_url`) VALUES
	(1, 'banner', 'banner_ex_1.png'),
	(2, 'banner', 'banner_ex_2.png'),
	(3, 'package', 'package_ex_1.png'),
	(4, 'package', 'package_ex_2.png'),
	(5, 'package', 'package_ex_3.png');

-- 테이블 capstone.package_info 구조 내보내기
DROP TABLE IF EXISTS `package_info`;
CREATE TABLE IF NOT EXISTS `package_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` int NOT NULL,
  `price` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `image` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_package_info_search_filter_list` (`type`,`price`) USING BTREE,
  CONSTRAINT `FK_package_info_search_filter_list` FOREIGN KEY (`type`) REFERENCES `search_filter_list` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='패키지 정보';

-- 테이블 데이터 capstone.package_info:~0 rows (대략적) 내보내기
DELETE FROM `package_info`;
INSERT INTO `package_info` (`id`, `name`, `type`, `price`, `start_date`, `end_date`, `country`, `image`) VALUES
	(1, '싱가포르 여행 재밌게 즐기자!', 1, 500000, '2025-04-12', '2025-04-19', 'singapore', 'ex_singapore_1.png'),
	(2, '유럽 투어 가자!', 1, 30000, '2025-06-12', '2025-07-12', 'germany,france,italy', 'ex_europe_1.png'),
	(3, '일본 여행 가자!', 1, 100000, '2025-05-12', '2025-05-15', 'japan', 'ex_japan_1.png'),
	(4, '제주도 올렛길 체험', 2, 10, '2025-03-23', '2025-04-01', 'jeju', 'ex_jeju_1.png'),
	(5, '춘천 둘러보기', 2, 100, '2025-03-12', '2025-03-13', 'chuncheon', 'ex_chuncheon_1.png');

-- 테이블 capstone.search_city_list 구조 내보내기
DROP TABLE IF EXISTS `search_city_list`;
CREATE TABLE IF NOT EXISTS `search_city_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('inner','outer') COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='검색 국가 리스트';

-- 테이블 데이터 capstone.search_city_list:~7 rows (대략적) 내보내기
DELETE FROM `search_city_list`;
INSERT INTO `search_city_list` (`id`, `type`, `value`) VALUES
	(1, 'inner', '서울'),
	(2, 'inner', '인천'),
	(3, 'inner', '부산'),
	(4, 'outer', '미국'),
	(5, 'outer', '일본'),
	(6, 'outer', '호주'),
	(7, 'outer', '독일');

-- 테이블 capstone.search_filter_list 구조 내보내기
DROP TABLE IF EXISTS `search_filter_list`;
CREATE TABLE IF NOT EXISTS `search_filter_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='검색 타입 리스트';

-- 테이블 데이터 capstone.search_filter_list:~0 rows (대략적) 내보내기
DELETE FROM `search_filter_list`;
INSERT INTO `search_filter_list` (`id`, `type`) VALUES
	(1, '뮤지컬'),
	(2, '콘서트');

-- 테이블 capstone.user_favorites 구조 내보내기
DROP TABLE IF EXISTS `user_favorites`;
CREATE TABLE IF NOT EXISTS `user_favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__user_info` (`user_id`) USING BTREE,
  KEY `FK_user_review_package_info` (`package_id`) USING BTREE,
  CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_favorites_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package_info` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='유저 찜 정보';

-- 테이블 데이터 capstone.user_favorites:~0 rows (대략적) 내보내기
DELETE FROM `user_favorites`;

-- 테이블 capstone.user_info 구조 내보내기
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE IF NOT EXISTS `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 정보';

-- 테이블 데이터 capstone.user_info:~0 rows (대략적) 내보내기
DELETE FROM `user_info`;
INSERT INTO `user_info` (`id`, `name`, `password`, `nickname`) VALUES
	(7, 'test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', NULL);

-- 테이블 capstone.user_review 구조 내보내기
DROP TABLE IF EXISTS `user_review`;
CREATE TABLE IF NOT EXISTS `user_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `rate` int NOT NULL,
  `comment` text COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__user_info` (`user_id`),
  KEY `FK_user_review_package_info` (`package_id`),
  CONSTRAINT `FK__user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_review_package_info` FOREIGN KEY (`package_id`) REFERENCES `package_info` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 리뷰 정보';

-- 테이블 데이터 capstone.user_review:~0 rows (대략적) 내보내기
DELETE FROM `user_review`;
INSERT INTO `user_review` (`id`, `user_id`, `package_id`, `rate`, `comment`) VALUES
	(1, 7, 1, 48, '바다가 이뻐요'),
	(2, 7, 3, 97, '벚꽃이 이뻐요'),
	(3, 7, 4, 58, '생각보다 별로에요');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
