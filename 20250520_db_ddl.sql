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

-- 테이블 capstone.api_key 구조 내보내기
DROP TABLE IF EXISTS `api_key`;
CREATE TABLE IF NOT EXISTS `api_key` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('ai','amadeus') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='API KEY 리스트';

-- 테이블 데이터 capstone.api_key:~2 rows (대략적) 내보내기
DELETE FROM `api_key`;
INSERT INTO `api_key` (`id`, `type`, `value`) VALUES
	(1, 'ai', ''),
	(2, 'amadeus', '');

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
	(2, 'banner', 'http://tkfile.yes24.com/Upload2/Display/202503/20250305/m_mainbig_52978_1.jpg'),
	(3, 'package', 'https://tourimage.interpark.com/product/tour/00161/A60/1000/A6020760_1_470.jpg'),
	(4, 'package', 'https://img.modetour.com/eagle/photoimg/10084/bfile/635865726403134229.jpg'),
	(5, 'package', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/03/16/10000/34c29c95-444f-4991-b298-8595145ecfeb.jpg'),
	(6, 'package', 'http://tkfile.yes24.com/Upload2/Display/202503/20250307/m_mainbig_53040_1.jpg'),
	(7, 'package', 'http://tkfile.yes24.com/Upload2/Display/202505/20250512/m_mainbig_53644.jpg'),
	(8, 'package', 'http://tkfile.yes24.com/Upload2/Display/202503/20250320/mainbig_50841.jpg');

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
  `url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_package_info_search_filter_list` (`type`,`price`) USING BTREE,
  CONSTRAINT `FK_package_info_search_filter_list` FOREIGN KEY (`type`) REFERENCES `search_filter_list` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='패키지 정보';

-- 테이블 데이터 capstone.package_info:~24 rows (대략적) 내보내기
DELETE FROM `package_info`;
INSERT INTO `package_info` (`id`, `name`, `type`, `price`, `start_date`, `end_date`, `country`, `image`, `url`) VALUES
	(1, '[웨스트엔드 뮤지컬 관람] 영국 런던 6일 <노팁 노옵션 /애프터눈 티 버스 투어>', 1, 6390000, '2025-06-04', '2025-06-09', '영국', 'https://img.modetour.com/eagle/photoimg/11449/bfile/636087603464748821.jpg', 'https://travel.interpark.com/package/products/EUGBP00009?adults=1&children=0&infants=0&date=2025-06-04&itemGroupId=673eb3ee35adda2f5ec22885'),
	(2, '[하이클래스/비즈니스] 뉴욕 명작(名作) 일주 7일 <맨해튼★★★★★/디너크루즈/뮤지컬/2명부터100%>', 1, 18098000, '2025-06-04', '2025-06-10', '미국', 'https://img.modetour.com/eagle/photoimg/1071/bfile/635865687037746130.jpg', 'https://img.modetour.com/eagle/photoimg/1071/bfile/635865687037746130.jpg'),
	(3, '[/노팁/노쇼핑/노옵션] 뉴욕 완전정복 7일 <준특급 숙박/특식3회/브로드웨이뮤지컬/2대전망대/2대미술관>', 1, 5967200, '2025-09-10', '2025-09-16', '미국', 'https://img.modetour.com/eagle/photoimg/10084/bfile/635865726403134229.jpg', 'https://travel.interpark.com/package/products/NAUSP00405?adults=1&children=0&infants=0&date=2025-09-10&itemGroupId=67610c1e30db954ae12fbe9d'),
	(4, '프랑스/영국 2국 8일 #런던뮤지컬관람 #옥스포드&코츠월즈 #지베르니&베르사유궁전 #전일정4성호텔 #파리1일자유일정 #에펠탑/세느강유람선 #맛5', 1, 3950000, '2025-06-09', '2025-06-16', '영국', 'https://image.hanatour.com/usr/cms/resize/800_0/2021/08/24/20000/bcfea77f-4c7f-4890-ba50-d7a049576b09.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=EWX73725060900R&depDay=20250609&newWin=true'),
	(5, '프랑스/영국 2국 8일 #전일정4성급호텔 #런던뮤지컬관람 #옥스포드&코츠월즈 #파리뷰맛집 #베르사유궁전&오베르(고흐마을)', 1, 4650000, '2025-06-07', '2025-06-13', '영국', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/03/11/10000/24a2ffff-23fa-41b9-9c39-b4179e0f32a7.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=EWP167250607KE8&depDay=20250607&newWin=true'),
	(6, '[출발임박][버킷리스트] 미국 대륙횡단 18일 #LA에서 뉴욕까지 #미국북부횡단 #13개주 #9개 핵심도시 & 14개 명소 관광 #그랜드캐년노스림 #옐로스톤 #러쉬모어 #배드랜드 #나이아가라', 1, 19990000, '2025-09-06', '2025-09-23', '미국', 'https://image.hanatour.com/usr/cms/resize/800_0/2017/08/02/10000/cc1e0c61-6d78-4440-9c9a-3a418d4b84d0.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=HWP170250906KE6&depDay=20250906&newWin=true'),
	(7, '뉴욕 테마여행 7일 #브로드웨이 뮤지컬 #모마 도슨트투어 #미슐랭다이닝 #뉴욕근교여행 #오헤카캐슬', 1, 17000000, '2025-06-02', '2025-06-08', '미국', 'https://image.hanatour.com/usr/cms/resize/800_0/2019/11/13/10000/2bb2b83a-8d60-4565-be35-d4b176b1f0fe.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=HEZ111250602KEA&depDay=20250602&newWin=true'),
	(8, '[야구홀릭] 로스앤젤레스 6일, 야구티켓포함+첫날가이드서비스+시내중심호텔 4박(조식포함)+로스앤젤레스 자유여행+4인이상 할인제공', 3, 4390000, '2025-06-02', '2025-06-07', '미국', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015838_15_100.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25060222378'),
	(9, '[축구홀릭][에어프레미아] LA 6일, 파리생제르맹 VS 아틀레티코마드리드 경기관람+시내중심호텔 4박+이동서비스제공+자유여행', 3, 4390000, '2025-06-13', '2025-06-18', '미국', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015840_4_977.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25061312597'),
	(10, '[25/26시즌 8월 출발 사전모집] 런던 8일, 여행후기인증, 영국축구 프리미엄좌석관람', 3, 5690000, '2025-08-20', '2025-08-27', '영국', 'https://tourimage.interpark.com/product/tour/00161/A30/1000/A3019404_1_720.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25082011608'),
	(11, '[LA홀릭] 로스앤젤레스 6일, 첫날가이드서비스+시내중심호텔 4박(조식포함)+로스앤젤레스 자유여행+단독여행 선택가능', 3, 2790000, '2025-09-09', '2025-09-09', '미국', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015829_7_973.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25090910712'),
	(12, '[축구홀릭] 뉴욕 6일, 플루미넨시 FC VS 울산 HD 경기관람+시내중심호텔 3박+이동서비스제공+자유여행', 3, 4090000, '2025-06-20', '2025-06-25', '미국', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015840_2_120.jpg', 'https://travel.interpark.com/tour/goods?baseGoodsCd=A2015840'),
	(13, '[야구홀릭][여름휴가 야구여행][20명한정] 미서부 7일, 미국프로야구 2경기 관람 (샌프란시스코 자이언츠/LA다저스), 유니버설스튜디오,시내중심 4성급 호텔 숙박', 3, 5490000, '2025-08-11', '2025-08-17', '미국', 'https://tourimage.interpark.com/product/tour/00161/A20/1000/A2015584_8_890.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25081111804'),
	(14, '[2030전용] 샌프란시스코 MLB 직관여행 6일 #코리안리거 #한일전 #직관 #샌프란시스코자이언츠 #LA다저스 #JUNG HOO CREW ZONE', 3, 4490000, '2025-09-11', '2025-09-15', '미국', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/03/16/10000/34c29c95-444f-4991-b298-8595145ecfeb.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=HWP055250911UAM&depDay=20250911&newWin=true'),
	(15, '샌프란시스코 MLB 직관여행 6일 #코리안리거 #한일전 #직관 #샌프란시스코자이언츠 #LA다저스 #JUNG HOO CREW ZONE', 3, 4490000, '2025-09-11', '2025-09-15', '미국', 'https://image.hanatour.com/usr/cms/resize/800_0/2025/05/15/10000/2fcb7b62-3adf-4f59-88dd-554eb40dde0e.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=HWP053250911UAB&depDay=20250911&newWin=true'),
	(16, '할마할빠랑 영국일주 9일 #스코틀랜드 #옥스포드&코츠월즈 #해리포터스튜디오&뮤지컬관람 #토트넘구장투어 #템즈강크루즈', 3, 5990000, '2025-06-01', '2025-06-08', '영국', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/12/15/10000/d99ed2c2-f1fd-4e09-8baf-b90ad017d92e.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=EWP143250601OZS&depDay=20250601&newWin=true'),
	(17, '[스포츠봉과 함께 하는] 백두산 자전거 라이딩 6일#환상의남파코스 #압록강 #천지 #노쇼핑/노팁 #단동페리 #포토동반 #전문가동반', 3, 1299000, '2025-08-15', '2025-08-20', '중국', 'https://image.hanatour.com/usr/cms/resize/800_0/2025/04/25/10000/1e717b26-3f0e-471d-94c5-d224923f5211.png', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=CRK259250815DWA&depDay=20250815&newWin=true'),
	(18, '[2030전용] 시드니 6일 #헬씨파민여행 #낭만여행 #본다이비치 서핑 #블루마운틴 선셋+별빛투어', 3, 2949000, '2025-06-30', '2025-07-05', '호주', 'https://image.hanatour.com/usr/cms/resize/800_0/2025/02/20/130000/92fae44a-f41b-47d1-a8d2-5a4fa9f55b29.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=PAP102250630TWM&depDay=20250630&newWin=true'),
	(19, '캐나다 동부 골프 여행 9일 #골프 여행 #퀘벡시티 #몬트리올 #대자연 #나이아가라폭포 #페어몬트호텔', 3, 20000000, '2025-05-29', '2025-06-06', '캐나다', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/08/08/10000/391c4cd0-7460-496b-ba05-8cdbe43b5596.PNG', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=HCZ141250529KEZ&depDay=20250529&newWin=true'),
	(20, '[소그룹여행] 오스트리아 비엔나 일주 7일 #5성급 시내 호텔 2박 #요한슈트라우스 #자유시간 #그레첼 #클래식 공연 #비엔나 #빈 #음악여행', 2, 7699000, '2025-06-04', '2025-06-09', '오스트리아', 'https://image.hanatour.com/usr/cms/resize/800_0/2024/11/15/10000/72d67d41-57c3-477d-a1fe-a5f5723ab90c.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=EEP111250604KEG&depDay=20250604&newWin=true'),
	(21, '[락페홀릭] 후지록 5일, 후지록 페스티벌 전일 관람 + 페스티벌장 내부 캠핑장 전일 숙박', 2, 1999000, '2025-07-24', '2025-07-28', '일본', 'https://tourimage.interpark.com/product/tour/00161/A60/1000/A6020753_2_527.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25072411511'),
	(22, '[임윤찬홀릭] 도쿄 4일, 임윤찬 피아노 리사이틀 2025 관람 패키지, 도쿄 핵심 관광까지!', 2, 1799000, '2025-07-05', '2025-07-05', '일본', 'https://tourimage.interpark.com/product/tour/00161/A60/1000/A6020760_1_470.jpg', 'https://travel.interpark.com/tour/goods?goodsCd=25070512101'),
	(23, '[임윤찬 X 뉴욕 필하모닉] 클래식 읽어주는 남자와 함께 떠나는 뉴욕 클래식 문화 여행 7일<맨하튼 숙박/브로드웨이 뮤지컬/도슨트 투어/파인다이닝>', 2, 8899400, '2025-09-14', '2025-09-20', '미국', 'https://img.modetour.com/eagle/photoimg/10084/bfile/635865726363998581.png', 'https://travel.interpark.com/package/products/NAUSP11263?adults=1&children=0&infants=0&date=2025-09-14&itemGroupId=6822705088f5fa752df7c4ea'),
	(24, '[출발확정/마감임박] 오스트리아 일주 9일 #빈5성급시내호텔2박 #잘츠캄머구트숙박 #특별한맛집 #파이브핑거스 #노르트케테 #할슈타트 #음악회 #그라츠 #첼암제', 2, 6099000, '2025-06-18', '2025-06-26', '오스트리아 ', 'https://image.hanatour.com/usr/cms/resize/800_0/2021/09/24/10000/a25cc348-b034-4391-ad13-b71e77a7a7a5.jpg', 'https://seju.hanatour.com/trp/pkg/CHPC0PKG0200M200?pkgCd=EEP110250618KEA&depDay=20250618&newWin=true');

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
  `image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `birthday` date NOT NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='유저 정보';

-- 테이블 데이터 capstone.user_info:~0 rows (대략적) 내보내기
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
