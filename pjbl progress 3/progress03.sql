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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anggota_kegiatan`
--

LOCK TABLES `anggota_kegiatan` WRITE;
/*!40000 ALTER TABLE `anggota_kegiatan` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kegiatan`
--

LOCK TABLES `kegiatan` WRITE;
/*!40000 ALTER TABLE `kegiatan` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laporan_kemajuan`
--

LOCK TABLES `laporan_kemajuan` WRITE;
/*!40000 ALTER TABLE `laporan_kemajuan` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luaran`
--

LOCK TABLES `luaran` WRITE;
/*!40000 ALTER TABLE `luaran` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skema`
--

LOCK TABLES `skema` WRITE;
/*!40000 ALTER TABLE `skema` DISABLE KEYS */;
/*!40000 ALTER TABLE `skema` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-24 11:57:37
