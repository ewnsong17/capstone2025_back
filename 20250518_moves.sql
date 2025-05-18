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

-- 테이블 capstone.move_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `move_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `place` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `price` int NOT NULL,
  `date` date NOT NULL,
  `type` enum('flight','lodge') COLLATE utf8mb4_bin NOT NULL,
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

ALTER TABLE `user_info`
ADD COLUMN `image` VARCHAR(300) NOT NULL AFTER `password`,
ADD COLUMN `birthday` DATE NOT NULL DEFAULT (current_TIMESTAMP()) AFTER `image`,
DROP COLUMN `nickname`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
