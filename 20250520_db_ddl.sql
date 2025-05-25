-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.42 - MySQL Community Server - GPL
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
  `image_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='메인 하단 이미지 리스트';

-- 테이블 데이터 capstone.main_image_list:~5 rows (대략적) 내보내기
DELETE FROM `main_image_list`;
INSERT INTO `main_image_list` (`id`, `type`, `image_url`) VALUES
	(1, 'banner', 'http://tkfile.yes24.com/Upload2/Display/202505/20250508/wel_mv_53433.jpg/dims/quality/70/'),
	(2, 'banner', 'https://tourimage.interpark.com/product/tour/00161/A60/1000/A6020760_1_470.jpg'),
	(3, 'package', 'https://tourimage.interpark.com/product/tour/00161/A30/1000/A3019415_1_003.jpg'),
	(4, 'package', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015584_1_470.jpg'),
	(5, 'package', 'package_ex_3.png');

-- 테이블 capstone.move_info 구조 내보내기
DROP TABLE IF EXISTS `move_info`;
CREATE TABLE IF NOT EXISTS `move_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `place` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `price` int NOT NULL,
  `date` date NOT NULL,
  `type` enum('flight','lodge') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='패키지 정보';

-- 테이블 데이터 capstone.move_info:~7 rows (대략적) 내보내기
DELETE FROM `move_info`;
INSERT INTO `move_info` (`id`, `place`, `name`, `price`, `date`, `type`) VALUES
	(1, '서울', '서울항공', 100000, '2025-05-18', 'flight'),
	(2, '인천', '인천항공', 300000, '2025-05-19', 'flight'),
	(3, '부산', '부산항공', 250000, '2025-05-18', 'flight'),
	(4, '나고야', '일본항공', 150000, '2025-05-22', 'flight'),
	(5, '도쿄', '일본항공B', 1100000, '2025-05-19', 'flight'),
	(6, '서울', '서울호텔A', 110000, '2025-05-18', 'lodge'),
	(7, '부산', '부산호텔B', 15000, '2025-05-18', 'lodge');

-- 테이블 capstone.my_trip_info 구조 내보내기
DROP TABLE IF EXISTS `my_trip_info`;
CREATE TABLE IF NOT EXISTS `my_trip_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_package_info_search_filter_list` (`type`) USING BTREE,
  KEY `my_trip_info_ibfk_2` (`user_id`) USING BTREE,
  CONSTRAINT `my_trip_info_ibfk_1` FOREIGN KEY (`type`) REFERENCES `search_filter_list` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `my_trip_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='내 여행 정보';

-- 테이블 데이터 capstone.my_trip_info:~3 rows (대략적) 내보내기
DELETE FROM `my_trip_info`;
INSERT INTO `my_trip_info` (`id`, `user_id`, `name`, `type`, `start_date`, `end_date`, `country`) VALUES
	(1, 7, '내 여행 1', 1, '2025-05-22', '2025-05-24', 'korea'),
	(2, 7, '내 여행 2', 1, '2025-06-12', '2025-07-12', 'france'),
	(3, 7, '내AA여행12345', 1, '2025-05-12', '2025-05-15', 'japan');

-- 테이블 capstone.my_trip_place_info 구조 내보내기
DROP TABLE IF EXISTS `my_trip_place_info`;
CREATE TABLE IF NOT EXISTS `my_trip_place_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL COMMENT '내여행 ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '이름',
  `place` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '장소',
  `reg_date` date NOT NULL DEFAULT (now()) COMMENT '날짜',
  PRIMARY KEY (`id`),
  KEY `FK_my_trip_place_info_my_trip_info` (`trip_id`),
  CONSTRAINT `FK_my_trip_place_info_my_trip_info` FOREIGN KEY (`trip_id`) REFERENCES `my_trip_info` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='내 여행 장소 정보';

-- 테이블 데이터 capstone.my_trip_place_info:~3 rows (대략적) 내보내기
DELETE FROM `my_trip_place_info`;
INSERT INTO `my_trip_place_info` (`id`, `trip_id`, `name`, `place`, `reg_date`) VALUES
	(1, 1, '서울구경', 'seoul', '2025-05-22'),
	(2, 1, '인천구경', 'incheon', '2025-05-23'),
	(3, 1, '테스트', 'test', '2025-05-24');

-- 테이블 capstone.package_info 구조 내보내기
DROP TABLE IF EXISTS `package_info`;
CREATE TABLE IF NOT EXISTS `package_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` int NOT NULL,
  `price` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `url` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_package_info_search_filter_list` (`type`,`price`) USING BTREE,
  CONSTRAINT `FK_package_info_search_filter_list` FOREIGN KEY (`type`) REFERENCES `search_filter_list` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='패키지 정보';

-- 테이블 데이터 capstone.package_info:~9 rows (대략적) 내보내기
DELETE FROM `package_info`;
INSERT INTO `package_info` (`id`, `name`, `type`, `price`, `start_date`, `end_date`, `country`, `image`, `url`) VALUES
	(1, '싱가포르 여행 재밌게 즐기자!', 1, 500000, '2025-04-12', '2025-04-19', 'singapore', 'http://tkfile.yes24.com/Upload2/Display/202505/20250508/wel_mv_53433.jpg/dims/quality/70/', 'https://www.naver.com'),
	(2, '유럽 투어 가자!', 1, 30000, '2025-06-12', '2025-07-12', 'germany,france,italy', 'http://tkfile.yes24.com/upload2/PerfBlog/202503/20250306/20250306-53040.jpg', 'https://www.naver.com'),
	(3, '일본 여행 가자!', 1, 100000, '2025-05-12', '2025-05-15', 'japan', 'http://tkfile.yes24.com/upload2/PerfBlog/202504/20250408/20250408-53385.jpg', 'https://www.naver.com'),
	(4, '제주도 올렛길 체험', 2, 10, '2025-03-23', '2025-04-01', 'jeju', 'http://tkfile.yes24.com/upload2/PerfBlog/202502/20250204/20250204-52551.jpg', 'https://www.naver.com'),
	(5, '춘천 둘러보기', 2, 100, '2025-03-12', '2025-03-13', 'chuncheon', 'http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg', 'https://www.naver.com'),
	(6, 'dsf', 2, 1500, '2025-02-12', '2025-03-14', 'fdsa', 'http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg', 'https://www.naver.com'),
	(7, 'dsfad', 3, 150, '2025-05-20', '2025-05-25', 'dsa', 'http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg', 'https://www.naver.com'),
	(8, 'asd', 3, 206, '2025-07-15', '2025-07-29', 'fasd', 'http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg', 'https://www.naver.com'),
	(9, 'sdf', 3, 202352, '2025-08-14', '2025-08-25', 'fdsa', 'http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg', 'https://www.naver.com');

-- 테이블 capstone.search_city_list 구조 내보내기
DROP TABLE IF EXISTS `search_city_list`;
CREATE TABLE IF NOT EXISTS `search_city_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('inner','outer') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
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
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='검색 타입 리스트';

-- 테이블 데이터 capstone.search_filter_list:~3 rows (대략적) 내보내기
DELETE FROM `search_filter_list`;
INSERT INTO `search_filter_list` (`id`, `type`) VALUES
	(1, '뮤지컬'),
	(2, '콘서트'),
	(3, '스포츠');

-- 테이블 capstone.user_info 구조 내보내기
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE IF NOT EXISTS `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `birthday` date NOT NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 정보';

-- 테이블 데이터 capstone.user_info:~1 rows (대략적) 내보내기
DELETE FROM `user_info`;
INSERT INTO `user_info` (`id`, `email`, `name`, `password`, `image`, `birthday`) VALUES
	(7, 'test', '', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', '', '2025-05-19');

-- 테이블 capstone.user_review 구조 내보내기
DROP TABLE IF EXISTS `user_review`;
CREATE TABLE IF NOT EXISTS `user_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `target_id` int NOT NULL,
  `rate` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` enum('mine','package') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__user_info` (`user_id`),
  KEY `FK_user_review_package_info` (`target_id`) USING BTREE,
  CONSTRAINT `FK__user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 리뷰 정보';

-- 테이블 데이터 capstone.user_review:~4 rows (대략적) 내보내기
DELETE FROM `user_review`;
INSERT INTO `user_review` (`id`, `user_id`, `target_id`, `rate`, `comment`, `type`) VALUES
	(1, 7, 1, 48, '바다가 이뻐요', 'package'),
	(2, 7, 3, 97, '벚꽃이 이뻐요', 'package'),
	(3, 7, 4, 58, '생각보다 별로에요', 'package'),
	(4, 7, 3, 58, '내 여행 리뷰에요', 'mine');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
