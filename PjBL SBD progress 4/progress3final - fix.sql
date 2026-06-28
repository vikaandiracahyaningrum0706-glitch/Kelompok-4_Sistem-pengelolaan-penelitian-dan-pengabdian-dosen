-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sistem_pengelolaan_penelitian_dan_pengabdian_dosen
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anggota_kegiatan`
--

DROP TABLE IF EXISTS `anggota_kegiatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anggota_kegiatan` (
  `id_anggota` int(11) NOT NULL AUTO_INCREMENT,
  `id_kegiatan` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `peran` enum('Ketua','Anggota') NOT NULL,
  PRIMARY KEY (`id_anggota`),
  KEY `id_kegiatan` (`id_kegiatan`),
  KEY `id_dosen` (`id_dosen`),
  CONSTRAINT `anggota_kegiatan_ibfk_1` FOREIGN KEY (`id_kegiatan`) REFERENCES `kegiatan` (`id_kegiatan`),
  CONSTRAINT `anggota_kegiatan_ibfk_2` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anggota_kegiatan`
--

LOCK TABLES `anggota_kegiatan` WRITE;
/*!40000 ALTER TABLE `anggota_kegiatan` DISABLE KEYS */;
INSERT INTO `anggota_kegiatan` VALUES (2,1,123457,'Ketua'),(3,1,123458,'Anggota'),(4,2,123456,'Ketua');
/*!40000 ALTER TABLE `anggota_kegiatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dosen`
--

DROP TABLE IF EXISTS `dosen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nidn` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `id_prodi` int(11) DEFAULT NULL,
  `jabatan_fungsional` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  PRIMARY KEY (`id_dosen`),
  UNIQUE KEY `nidn` (`nidn`),
  UNIQUE KEY `email` (`email`),
  KEY `id_prodi` (`id_prodi`),
  CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dosen`
--

LOCK TABLES `dosen` WRITE;
/*!40000 ALTER TABLE `dosen` DISABLE KEYS */;
INSERT INTO `dosen` VALUES (123456,'000111','Dr. Nayla Putri Zelfia M.ST',1,'Kaprodi','nayla@univ.ac.id','08222776654'),(123457,'000222','Dr. Dara Puspitasari M.Bg',2,'Dekan','dara@univ.ac.id','08345678976'),(123458,'000333','Dr. Yazira Sartika M.Ts',3,'Asisten Ahli','ayas@univ.ac.id','0864578321');
/*!40000 ALTER TABLE `dosen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kegiatan`
--

DROP TABLE IF EXISTS `kegiatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kegiatan` (
  `id_kegiatan` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) NOT NULL,
  `id_skema` int(11) NOT NULL,
  `id_ketua` int(11) NOT NULL,
  `tahun_usulan` year(4) NOT NULL,
  `dana_disetujui` decimal(15,2) NOT NULL,
  `status` enum('Diusulkan','Didanai','Berjalan','Selesai','Ditolak') NOT NULL,
  PRIMARY KEY (`id_kegiatan`),
  KEY `id_skema` (`id_skema`),
  KEY `id_ketua` (`id_ketua`),
  CONSTRAINT `kegiatan_ibfk_1` FOREIGN KEY (`id_skema`) REFERENCES `skema` (`id_skema`),
  CONSTRAINT `kegiatan_ibfk_2` FOREIGN KEY (`id_ketua`) REFERENCES `dosen` (`id_dosen`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kegiatan`
--

LOCK TABLES `kegiatan` WRITE;
/*!40000 ALTER TABLE `kegiatan` DISABLE KEYS */;
INSERT INTO `kegiatan` VALUES (1,'Pengembangan AI untuk Diagnosis Penyakit',1,123457,2026,45000000.00,'Selesai'),(2,'Penerapan Sistem Pendeteksi Tsunami di Kawasan Pesisir',2,123456,2026,15000000.00,'Diusulkan');
/*!40000 ALTER TABLE `kegiatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laporan_kemajuan`
--

DROP TABLE IF EXISTS `laporan_kemajuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laporan_kemajuan` (
  `id_laporan` int(11) NOT NULL AUTO_INCREMENT,
  `id_kegiatan` int(11) NOT NULL,
  `jenis_laporan` enum('Kemajuan','Akhir') DEFAULT NULL,
  `tanggal_unggah` date NOT NULL,
  `file_laporan` varchar(255) NOT NULL,
  `catatan_reviewer` text DEFAULT NULL,
  PRIMARY KEY (`id_laporan`),
  KEY `id_kegiatan` (`id_kegiatan`),
  CONSTRAINT `laporan_kemajuan_ibfk_1` FOREIGN KEY (`id_kegiatan`) REFERENCES `kegiatan` (`id_kegiatan`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laporan_kemajuan`
--

LOCK TABLES `laporan_kemajuan` WRITE;
/*!40000 ALTER TABLE `laporan_kemajuan` DISABLE KEYS */;
INSERT INTO `laporan_kemajuan` VALUES (1,1,'Kemajuan','2026-06-15','laporan_kemajuan_AI.pdf','Sangat baik, lanjutkan ke tahap akhir.'),(2,1,'Akhir','2026-11-30','laporan_akhir_AI.pdf','Revisi bagian hasil dan pembahasan, unggah ulang.'),(3,1,'Kemajuan','2026-06-15','laporan_kemajuan_AI.pdf','Sangat baik, lanjutkan ke tahap akhir.'),(4,1,'Akhir','2026-11-30','laporan_akhir_AI.pdf',NULL);
/*!40000 ALTER TABLE `laporan_kemajuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luaran`
--

DROP TABLE IF EXISTS `luaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `luaran` (
  `id_luaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_kegiatan` int(11) NOT NULL,
  `jenis_luaran` varchar(50) NOT NULL,
  `judul_luaran` varchar(255) NOT NULL,
  `status_luaran` enum('Draft','Submit','Accepted','Published') NOT NULL,
  `tahun_terbit` year(4) DEFAULT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_luaran`),
  KEY `id_kegiatan` (`id_kegiatan`),
  CONSTRAINT `luaran_ibfk_1` FOREIGN KEY (`id_kegiatan`) REFERENCES `kegiatan` (`id_kegiatan`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luaran`
--

LOCK TABLES `luaran` WRITE;
/*!40000 ALTER TABLE `luaran` DISABLE KEYS */;
INSERT INTO `luaran` VALUES (1,1,'Jurnal','AI in Healthcare and Diagnosis','Published',2026,'https://jurnal.univ.ac.id/ai-diagnosis'),(2,1,'Prosiding','Machine Learning Approach for Medical Data','Accepted',2026,'https://conference.univ.ac.id/ml-approach');
/*!40000 ALTER TABLE `luaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodi`
--

DROP TABLE IF EXISTS `prodi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prodi` (
  `id_prodi` int(11) NOT NULL,
  `nama_prodi` varchar(100) DEFAULT NULL,
  `fakultas` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodi`
--

LOCK TABLES `prodi` WRITE;
/*!40000 ALTER TABLE `prodi` DISABLE KEYS */;
INSERT INTO `prodi` VALUES (1,'Teknik Informatika','Fakultas Teknik'),(2,'Sistem Informasi','Fakultas Teknik'),(3,'Hukum','Fakultas Hukum');
/*!40000 ALTER TABLE `prodi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skema`
--

DROP TABLE IF EXISTS `skema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skema` (
  `id_skema` int(11) NOT NULL AUTO_INCREMENT,
  `nama_skema` varchar(100) NOT NULL,
  `jenis_kegiatan` enum('Penelitian','Pengabdian') NOT NULL,
  `sumber_dana` varchar(100) NOT NULL,
  `tahun_berlaku` year(4) NOT NULL,
  PRIMARY KEY (`id_skema`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skema`
--

LOCK TABLES `skema` WRITE;
/*!40000 ALTER TABLE `skema` DISABLE KEYS */;
INSERT INTO `skema` VALUES (1,'Penelitian Dasar','Penelitian','Kemendikbud',2026),(2,'Pengabdian Masyarakat Kemaritiman','Pengabdian','Internal Kampus',2026);
/*!40000 ALTER TABLE `skema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_anggota_tim_kegiatan`
--

DROP TABLE IF EXISTS `v_anggota_tim_kegiatan`;
/*!50001 DROP VIEW IF EXISTS `v_anggota_tim_kegiatan`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_anggota_tim_kegiatan` AS SELECT
 1 AS `id_anggota`,
  1 AS `judul_kegiatan`,
  1 AS `nama_dosen`,
  1 AS `nidn`,
  1 AS `peran` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_monitoring_progres`
--

DROP TABLE IF EXISTS `v_monitoring_progres`;
/*!50001 DROP VIEW IF EXISTS `v_monitoring_progres`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_monitoring_progres` AS SELECT
 1 AS `id_kegiatan`,
  1 AS `judul_kegiatan`,
  1 AS `jenis_laporan`,
  1 AS `tanggal_unggah`,
  1 AS `file_laporan`,
  1 AS `jenis_luaran`,
  1 AS `judul_luaran`,
  1 AS `status_luaran` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_rekap_kegiatan`
--

DROP TABLE IF EXISTS `v_rekap_kegiatan`;
/*!50001 DROP VIEW IF EXISTS `v_rekap_kegiatan`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_rekap_kegiatan` AS SELECT
 1 AS `id_kegiatan`,
  1 AS `judul_kegiatan`,
  1 AS `nama_skema`,
  1 AS `jenis_kegiatan`,
  1 AS `nama_ketua`,
  1 AS `prodi_ketua`,
  1 AS `tahun_usulan`,
  1 AS `dana_disetujui`,
  1 AS `status_kegiatan` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_anggota_tim_kegiatan`
--

/*!50001 DROP VIEW IF EXISTS `v_anggota_tim_kegiatan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_anggota_tim_kegiatan` AS select `ak`.`id_anggota` AS `id_anggota`,`k`.`judul` AS `judul_kegiatan`,`d`.`nama` AS `nama_dosen`,`d`.`nidn` AS `nidn`,`ak`.`peran` AS `peran` from ((`anggota_kegiatan` `ak` join `kegiatan` `k` on(`ak`.`id_kegiatan` = `k`.`id_kegiatan`)) join `dosen` `d` on(`ak`.`id_dosen` = `d`.`id_dosen`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_monitoring_progres`
--

/*!50001 DROP VIEW IF EXISTS `v_monitoring_progres`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_monitoring_progres` AS select `k`.`id_kegiatan` AS `id_kegiatan`,`k`.`judul` AS `judul_kegiatan`,`lk`.`jenis_laporan` AS `jenis_laporan`,`lk`.`tanggal_unggah` AS `tanggal_unggah`,`lk`.`file_laporan` AS `file_laporan`,`l`.`jenis_luaran` AS `jenis_luaran`,`l`.`judul_luaran` AS `judul_luaran`,`l`.`status_luaran` AS `status_luaran` from ((`kegiatan` `k` left join `laporan_kemajuan` `lk` on(`k`.`id_kegiatan` = `lk`.`id_kegiatan`)) left join `luaran` `l` on(`k`.`id_kegiatan` = `l`.`id_kegiatan`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_rekap_kegiatan`
--

/*!50001 DROP VIEW IF EXISTS `v_rekap_kegiatan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_rekap_kegiatan` AS select `k`.`id_kegiatan` AS `id_kegiatan`,`k`.`judul` AS `judul_kegiatan`,`s`.`nama_skema` AS `nama_skema`,`s`.`jenis_kegiatan` AS `jenis_kegiatan`,`d`.`nama` AS `nama_ketua`,`p`.`nama_prodi` AS `prodi_ketua`,`k`.`tahun_usulan` AS `tahun_usulan`,`k`.`dana_disetujui` AS `dana_disetujui`,`k`.`status` AS `status_kegiatan` from (((`kegiatan` `k` join `skema` `s` on(`k`.`id_skema` = `s`.`id_skema`)) join `dosen` `d` on(`k`.`id_ketua` = `d`.`id_dosen`)) join `prodi` `p` on(`d`.`id_prodi` = `p`.`id_prodi`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-28 12:38:54
