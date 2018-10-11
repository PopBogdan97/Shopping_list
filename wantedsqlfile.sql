-- MySQL dump 10.16  Distrib 10.1.34-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: progetto
-- ------------------------------------------------------
-- Server version	10.1.34-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cat_lista`
--

DROP TABLE IF EXISTS `cat_lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_lista` (
  `Nome` varchar(50) NOT NULL,
  `Descrizione` varchar(50) DEFAULT NULL,
  `Immagine` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_lista`
--

LOCK TABLES `cat_lista` WRITE;
/*!40000 ALTER TABLE `cat_lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_prodotto`
--

DROP TABLE IF EXISTS `cat_prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_prodotto` (
  `Nome` varchar(50) NOT NULL,
  `Descrizione` varchar(100) DEFAULT NULL,
  `Logo` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_prodotto`
--

LOCK TABLES `cat_prodotto` WRITE;
/*!40000 ALTER TABLE `cat_prodotto` DISABLE KEYS */;
INSERT INTO `cat_prodotto` VALUES ('nome','descrizione','logo');
/*!40000 ALTER TABLE `cat_prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista`
--

DROP TABLE IF EXISTS `lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lista` (
  `Nome` varchar(50) NOT NULL,
  `NomeCat` varchar(50) NOT NULL,
  `Descrizione` varchar(100) DEFAULT NULL,
  `Immagine` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Nome`,`NomeCat`),
  KEY `NomeCat` (`NomeCat`),
  CONSTRAINT `lista_ibfk_1` FOREIGN KEY (`NomeCat`) REFERENCES `cat_lista` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista`
--

LOCK TABLES `lista` WRITE;
/*!40000 ALTER TABLE `lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prodotto` (
  `Nome` varchar(50) NOT NULL,
  `NomeCat` varchar(50) NOT NULL,
  `Note` varchar(100) DEFAULT NULL,
  `Fotografia` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Nome`,`NomeCat`),
  KEY `NomeCat` (`NomeCat`),
  CONSTRAINT `prodotto_ibfk_1` FOREIGN KEY (`NomeCat`) REFERENCES `cat_prodotto` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente` (
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Nominativo` varchar(50) DEFAULT NULL,
  `Immagine` varchar(255) DEFAULT NULL,
  `Tipologia` varchar(50) DEFAULT NULL,
  `Cod` varchar(50) DEFAULT NULL,
  `Valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Email`,`Password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES ('emiliantolo@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','emiliantolo','C:\\Users\\Emiliano\\Documents\\NetBeansProjects\\web_programming_2018\\build\\web\\\\images\\Screenshot (54).png','normal','POIEXF4Y',1);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'progetto'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-06  1:04:46
