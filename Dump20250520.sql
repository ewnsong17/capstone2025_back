-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: capstone
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `main_image_list`
--

DROP TABLE IF EXISTS `main_image_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_image_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('banner','package') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='메인 하단 이미지 리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_image_list`
--

LOCK TABLES `main_image_list` WRITE;
/*!40000 ALTER TABLE `main_image_list` DISABLE KEYS */;
INSERT INTO `main_image_list` VALUES (1,'banner','http://tkfile.yes24.com/Upload2/Display/202505/20250508/wel_mv_53433.jpg/dims/quality/70/'),(2,'banner','https://tourimage.interpark.com/product/tour/00161/A60/1000/A6020760_1_470.jpg'),(3,'package','https://tourimage.interpark.com/product/tour/00161/A30/1000/A3019415_1_003.jpg'),(4,'package','https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015584_1_470.jpg'),(5,'package','package_ex_3.png');
/*!40000 ALTER TABLE `main_image_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `move_info`
--

DROP TABLE IF EXISTS `move_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `move_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `place` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `price` int NOT NULL,
  `date` date NOT NULL,
  `type` enum('flight','lodge') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='패키지 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `move_info`
--

LOCK TABLES `move_info` WRITE;
/*!40000 ALTER TABLE `move_info` DISABLE KEYS */;
INSERT INTO `move_info` VALUES (1,'서울','서울항공',100000,'2025-05-18','flight'),(2,'인천','인천항공',300000,'2025-05-19','flight'),(3,'부산','부산항공',250000,'2025-05-18','flight'),(4,'나고야','일본항공',150000,'2025-05-22','flight'),(5,'도쿄','일본항공B',1100000,'2025-05-19','flight'),(6,'서울','서울호텔A',110000,'2025-05-18','lodge'),(7,'부산','부산호텔B',15000,'2025-05-18','lodge');
/*!40000 ALTER TABLE `move_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_info`
--

DROP TABLE IF EXISTS `package_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` int NOT NULL,
  `price` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_package_info_search_filter_list` (`type`,`price`) USING BTREE,
  CONSTRAINT `FK_package_info_search_filter_list` FOREIGN KEY (`type`) REFERENCES `search_filter_list` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='패키지 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_info`
--

LOCK TABLES `package_info` WRITE;
/*!40000 ALTER TABLE `package_info` DISABLE KEYS */;
INSERT INTO `package_info` VALUES (0,'',0,0,'0000-00-00','0000-00-00','',''),(1,'싱가포르 여행 재밌게 즐기자!',1,500000,'2025-04-12','2025-04-19','singapore','http://tkfile.yes24.com/Upload2/Display/202505/20250508/wel_mv_53433.jpg/dims/quality/70/'),(2,'유럽 투어 가자!',1,30000,'2025-06-12','2025-07-12','germany,france,italy','http://tkfile.yes24.com/upload2/PerfBlog/202503/20250306/20250306-53040.jpg'),(3,'일본 여행 가자!',1,100000,'2025-05-12','2025-05-15','japan','http://tkfile.yes24.com/upload2/PerfBlog/202504/20250408/20250408-53385.jpg'),(4,'제주도 올렛길 체험',2,10,'2025-03-23','2025-04-01','jeju','http://tkfile.yes24.com/upload2/PerfBlog/202502/20250204/20250204-52551.jpg'),(5,'춘천 둘러보기',2,100,'2025-03-12','2025-03-13','chuncheon','http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg'),(6,'dsf',2,1500,'2025-02-12','2025-03-14','fdsa','http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg'),(7,'dsfad',3,150,'2025-05-20','2025-05-25','dsa','http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg'),(8,'fdsf',3,206,'2025-07-15','2025-07-29','fasd','http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg'),(9,'fdsasd',3,202352,'2025-08-14','2025-08-25','fdsa','http://tkfile.yes24.com/upload2/PerfBlog/202505/20250509/20250509-53782.jpg');
/*!40000 ALTER TABLE `package_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_city_list`
--

DROP TABLE IF EXISTS `search_city_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_city_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('inner','outer') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='검색 국가 리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_city_list`
--

LOCK TABLES `search_city_list` WRITE;
/*!40000 ALTER TABLE `search_city_list` DISABLE KEYS */;
INSERT INTO `search_city_list` VALUES (1,'inner','서울'),(2,'inner','인천'),(3,'inner','부산'),(4,'outer','미국'),(5,'outer','일본'),(6,'outer','호주'),(7,'outer','독일');
/*!40000 ALTER TABLE `search_city_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_filter_list`
--

DROP TABLE IF EXISTS `search_filter_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_filter_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='검색 타입 리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_filter_list`
--

LOCK TABLES `search_filter_list` WRITE;
/*!40000 ALTER TABLE `search_filter_list` DISABLE KEYS */;
INSERT INTO `search_filter_list` VALUES (1,'뮤지컬'),(2,'콘서트'),(3,'스포츠');
/*!40000 ALTER TABLE `search_filter_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorites`
--

DROP TABLE IF EXISTS `user_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__user_info` (`user_id`) USING BTREE,
  KEY `FK_user_review_package_info` (`package_id`) USING BTREE,
  CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_favorites_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package_info` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='유저 찜 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorites`
--

LOCK TABLES `user_favorites` WRITE;
/*!40000 ALTER TABLE `user_favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `birthday` date NOT NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (7,'test','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','','2025-05-19');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_review`
--

DROP TABLE IF EXISTS `user_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `rate` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__user_info` (`user_id`),
  KEY `FK_user_review_package_info` (`package_id`),
  CONSTRAINT `FK__user_info` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_review_package_info` FOREIGN KEY (`package_id`) REFERENCES `package_info` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 리뷰 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_review`
--

LOCK TABLES `user_review` WRITE;
/*!40000 ALTER TABLE `user_review` DISABLE KEYS */;
INSERT INTO `user_review` VALUES (1,7,1,48,'바다가 이뻐요'),(2,7,3,97,'벚꽃이 이뻐요'),(3,7,4,58,'생각보다 별로에요');
/*!40000 ALTER TABLE `user_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 15:51:19
