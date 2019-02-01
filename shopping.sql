-- MySQL dump 10.16  Distrib 10.1.34-MariaDB, for Win32 (AMD64)
--
-- Host: waltnas.ddns.net    Database: shopping
-- ------------------------------------------------------
-- Server version	5.5.62-0ubuntu0.14.04.1

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
-- Table structure for table `Chat`
--

DROP TABLE IF EXISTS `Chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chat` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ListId` int(11) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `PrebuildMesId` int(11) NOT NULL,
  `Message` varchar(200) NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Chat_Id_uindex` (`Id`),
  KEY `Chat_User_Email_fk` (`Email`),
  KEY `Chat_List_Id_fk` (`ListId`),
  KEY `Chat_PrebuildMessages_Id_fk` (`PrebuildMesId`),
  CONSTRAINT `Chat_PrebuildMessages_Id_fk` FOREIGN KEY (`PrebuildMesId`) REFERENCES `PrebuildMessages` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Chat_List_Id_fk` FOREIGN KEY (`ListId`) REFERENCES `List` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Chat_User_Email_fk` FOREIGN KEY (`Email`) REFERENCES `User` (`Email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chat`
--

LOCK TABLES `Chat` WRITE;
/*!40000 ALTER TABLE `Chat` DISABLE KEYS */;
INSERT INTO `Chat` VALUES (266,39,'pop.bogdan.pvab@gmail.com',1,'','2019-01-31 00:04:27'),(267,39,'pop.bogdan.pvab@gmail.com',2,'','2019-01-31 00:04:28'),(268,39,'pop.bogdan.pvab@gmail.com',5,'','2019-01-31 00:25:08'),(269,39,'pop.bogdan.pvab@gmail.com',3,'','2019-01-31 00:25:10'),(270,46,'emiliantolo@gmail.com',4,'','2019-01-31 00:29:09'),(271,46,'emiliantolo@gmail.com',2,'','2019-01-31 00:29:54'),(272,46,'bentivoglio.luca97@gmail.com',5,'','2019-01-31 00:30:53');
/*!40000 ALTER TABLE `Chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Collaborator`
--

DROP TABLE IF EXISTS `Collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Collaborator` (
  `Email` varchar(50) NOT NULL,
  `ListId` int(11) NOT NULL,
  `AddProduct` tinyint(1) NOT NULL,
  `RemoveProduct` tinyint(1) NOT NULL,
  `EditList` tinyint(1) NOT NULL,
  `DeleteList` tinyint(1) NOT NULL,
  `ListName` varchar(50) NOT NULL,
  PRIMARY KEY (`Email`,`ListId`),
  KEY `Collaborator_List_Id_fk` (`ListId`),
  CONSTRAINT `Collaborator_List_Id_fk` FOREIGN KEY (`ListId`) REFERENCES `List` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Collaborator_User_Email_fk` FOREIGN KEY (`Email`) REFERENCES `User` (`Email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Collaborator`
--

LOCK TABLES `Collaborator` WRITE;
/*!40000 ALTER TABLE `Collaborator` DISABLE KEYS */;
INSERT INTO `Collaborator` VALUES ('benti@gmail.com',50,1,1,1,1,'Banco da lavoro'),('bentivoglio.luca97@gmail.com',50,1,1,1,1,'Banco da lavoro'),('emiliano.tolotti@gmail.com',41,1,1,1,0,'My other list'),('emiliantolo@gmail.com',46,1,1,1,1,'Mare 2019'),('pop.bogdan.pvab@gmail.com',42,0,1,1,1,'First List'),('pop.bogdan.pvab@gmail.com',43,1,0,1,1,'Second List'),('pop.bogdan.pvab@gmail.com',44,1,1,1,0,'Third List'),('pop.bogdan.pvab@gmail.com',46,1,1,1,1,'Mare 2019'),('pop.bogdan.pvab@gmail.com',50,1,1,1,1,'Banco da lavoro');
/*!40000 ALTER TABLE `Collaborator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `List`
--

DROP TABLE IF EXISTS `List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `List` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `CatName` varchar(50) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Image` varchar(70) DEFAULT NULL,
  `OwnerEmail` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `List_Id_uindex` (`Id`),
  UNIQUE KEY `List_pk` (`Name`,`CatName`),
  KEY `List_User_Email_fk` (`OwnerEmail`),
  KEY `List_ListCategory_Name_fk` (`CatName`),
  CONSTRAINT `List_ListCategory_Name_fk` FOREIGN KEY (`CatName`) REFERENCES `ListCategory` (`Name`) ON DELETE CASCADE,
  CONSTRAINT `List_User_Email_fk` FOREIGN KEY (`OwnerEmail`) REFERENCES `User` (`Email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `List`
--

LOCK TABLES `List` WRITE;
/*!40000 ALTER TABLE `List` DISABLE KEYS */;
INSERT INTO `List` VALUES (38,'Lista alimenti','Alimentari','Alimentari vari','38.png','admin@gmail.com'),(39,'My list','Alimentari','Per la festa',NULL,'pop.bogdan.pvab@gmail.com'),(40,'anonymous list','Ferramenta','attrezzi',NULL,'601a113f-6b32-4646-9894-74a1c1417e1e'),(41,'My other list','Alimentari','Cena di domani',NULL,'pop.bogdan.pvab@gmail.com'),(42,'First List','Sport e tempo libero','Calcio',NULL,'zfzobfxx@imgof.com'),(43,'Second List','Prodotti per pulizia e igiene','Bagno ',NULL,'zfzobfxx@imgof.com'),(44,'Third List','Alimentari','Frigo',NULL,'zfzobfxx@imgof.com'),(46,'Mare 2019','Sport e tempo libero','Croazia, Pag','46.png','bentivoglio.luca97@gmail.com'),(47,'Fourth','Sport e tempo libero','Tennis','47.png','pop.bogdan.pvab@gmail.com'),(49,'anon','Prodotti per pulizia e igiene','the pusher','49.png','cf7a6819-0691-4df8-9a7e-a717955a711f'),(50,'Banco da lavoro','Ferramenta','Utensili da lavoro e materiale vario',NULL,'emiliantolo@gmail.com');
/*!40000 ALTER TABLE `List` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ListCategory`
--

DROP TABLE IF EXISTS `ListCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ListCategory` (
  `Name` varchar(50) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Image` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `ListCategory_Name_uindex` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ListCategory`
--

LOCK TABLES `ListCategory` WRITE;
/*!40000 ALTER TABLE `ListCategory` DISABLE KEYS */;
INSERT INTO `ListCategory` VALUES ('Alimentari','Alimentari vari','Alimentari.png'),('Ferramenta','Vari prodotti per il lavoro','Ferramenta.png'),('Prodotti per pulizia e igiene','Vari prodotti per pulizia e igiene','Prodotti per pulizia e igiene.png'),('Sport e tempo libero','Vari prodotti per sport e tempo libero','Sport e tempo libero.png');
/*!40000 ALTER TABLE `ListCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `List_Product`
--

DROP TABLE IF EXISTS `List_Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `List_Product` (
  `ListId` int(11) NOT NULL,
  `ProductId` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`ListId`,`ProductId`),
  KEY `List_Product_Product_Name_fk` (`ProductId`),
  CONSTRAINT `List_Product_Product_Name_fk` FOREIGN KEY (`ProductId`) REFERENCES `Product` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `List_Product_List_Name_fk` FOREIGN KEY (`ListId`) REFERENCES `List` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `List_Product`
--

LOCK TABLES `List_Product` WRITE;
/*!40000 ALTER TABLE `List_Product` DISABLE KEYS */;
INSERT INTO `List_Product` VALUES (38,92,3),(38,94,1),(39,47,2),(39,55,2),(39,267,1),(41,55,8),(43,140,4),(46,226,1),(46,228,1),(46,230,1),(46,232,1),(46,233,1),(46,234,1);
/*!40000 ALTER TABLE `List_Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrebuildMessages`
--

DROP TABLE IF EXISTS `PrebuildMessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrebuildMessages` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Message` varchar(100) NOT NULL,
  UNIQUE KEY `PrebuildMessages_Id_uindex` (`Id`),
  UNIQUE KEY `PrebuildMessages_Message_uindex` (`Message`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrebuildMessages`
--

LOCK TABLES `PrebuildMessages` WRITE;
/*!40000 ALTER TABLE `PrebuildMessages` DISABLE KEYS */;
INSERT INTO `PrebuildMessages` VALUES (4,'E\' ora di fare la spesa. Chi va?'),(2,'Lista modificata. Guarda cosa ho aggiunto'),(3,'Spesa fatta. Ti puoi rilassare'),(1,'Stò andando a fare la spesa, manca qualcosa?'),(5,'Vado io a fare la spesa!');
/*!40000 ALTER TABLE `PrebuildMessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `CatName` varchar(50) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Image` varchar(70) DEFAULT NULL,
  `Logo` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Product_Id_uindex` (`Id`),
  UNIQUE KEY `Product_pk` (`Name`,`CatName`),
  KEY `Product_ProductCategory_Name_fk` (`CatName`),
  CONSTRAINT `Product_ProductCategory_Name_fk` FOREIGN KEY (`CatName`) REFERENCES `ProductCategory` (`Name`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (42,'Finocchio','Frutta e verdura','Finocchio selvatico','42.png',''),(43,'Cipolla','Frutta e verdura','Cipolla rossa di Tropea','43.png',''),(44,'Lattuga','Frutta e verdura','Lattuga gentilina','44.png',''),(45,'Pomodoro','Frutta e verdura','Varietà cuore di bue','45.png',''),(46,'Cetriolo','Frutta e verdura','Cetriolo tagliato a fette','46.png',''),(47,'Banana','Frutta e verdura','Varietà Cavendish','47.png',''),(48,'Mela','Frutta e verdura','Varietà Golden Delicious della Melinda','48.png',''),(49,'Pera','Frutta e verdura','Pera Williams','49.png',''),(50,'Arancia','Frutta e verdura','Provenienti direttamente dalla Sicilia','50.png',''),(51,'Limone','Frutta e verdura','Limoni freschi Femminello','51.png',''),(52,'Fragola','Frutta e verdura','Fragoline di montagna','52.png',''),(53,'Lampone','Frutta e verdura','Vaschetta di lamponi da 150g','53.png',''),(54,'Mora','Frutta e verdura','Mora di rovo e di gelso','54.png',''),(55,'Anguria','Frutta e verdura','Metà anguria Romagnola','55.png',''),(56,'Lonza di maiale','Carne e pesce','Lonza tagliata a fette fine','56.png',''),(57,'Braciola','Carne e pesce','Braciola di maiale','57.png',''),(58,'Hamburger','Carne e pesce','Hamburger di cervo','58.png',''),(59,'Manzo','Carne e pesce','Filetto di manzo bovino','59.png',''),(60,'Pollo','Carne e pesce','Petto di pollo','60.png',''),(61,'Branzino','Carne e pesce','Branzino fresco','61.png',''),(62,'Polpo','Carne e pesce','Carpaccio di polpo','62.png',''),(63,'Calamari','Carne e pesce','Calamari indopacifici puliti surgelati','63.png',''),(64,'Gamberi','Carne e pesce','Gamberi boreali surgelati','64.png',''),(65,'Trota salmonata','Carne e pesce','Filetto di trota salmonata','65.png',''),(66,'Coca cola','Bevande','Coca Cola in bottiglia di plastica 1L','66.png',''),(67,'Fanta','Bevande','Fanta Orange 2L','67.png',''),(68,'Lemonsoda','Bevande','Lemonsoda in lattina 333ml','68.png',''),(69,'Acqua','Bevande','Acqua Pejo Frizzante 1,5L','69.png',''),(70,'The alla pesca','Bevande','Thè alla pesca 500ml','70.png',''),(71,'The a limone','Bevande','Thè al limone 500ml','71.png',''),(72,'Cedrata','Bevande','Cedrata Tassoni','72.png',''),(73,'Vino','Bevande','Pinot Nero 0,75L','73.png',''),(74,'Birra','Bevande','Birra Peroni 33cl','74.png',''),(75,'Succo all\'albicocca','Bevande','Succo Yoga gusto albicocca 1L','75.png',''),(76,'Succo alla pesca','Bevande','Succo alla pesca Zuegg 3X200ml','76.png',''),(77,'Succo di mela','Bevande','Succo di mela biologico 500ml','77.png',''),(78,'Succo all\'ananas','Bevande','Succo di frutta in vetro gusto ananas','78.png',''),(79,'Latte','Bevande','Latte parzialmente scremato UHT','79.png',''),(80,'Caffè','Bevande','Caffè Lavazza Espresso 250g','80.png',''),(81,'Spaccata','Forno','Pane spaccata','81.png',''),(82,'Rosetta','Forno','Pane rosetta','82.png',''),(83,'Pane nero','Forno','Pane nero al carbone vegetale','83.png',''),(84,'Pane integrale','Forno','Pane con farina integrale','84.png',''),(85,'Croissant al cacao','Forno','Croissant ripieni di crema al cacao ','85.png',''),(86,'Krapfen alla crema','Forno','Krapfen alla crema con zucchero a velo','86.png',''),(87,'Biscotti','Forno','Baiocchi al cioccolato','87.png',''),(88,'Pizza','Forno','Pizza Margherita','88.png',''),(89,'Focaccia','Forno','Focaccia genovese','89.png',''),(90,'Grissini','Forno','Grissini senza sale','90.png',''),(91,'Yogurt','Frigo','Yogurt bianco con latte di montagna','91.png',''),(92,'Budino','Frigo','Budino Cameo da zuccherare gusto cioccolato','92.png',''),(93,'Mozzarella','Frigo','Mozzarella Santa Lucia','93.png',''),(94,'Brie','Frigo','Brie President francese cremoso','94.png',''),(95,'Spicchio di grana','Frigo','Trentingrana DOP','95.png',''),(96,'Grana grattugiato','Frigo','In busta richiudibile','96.png',''),(97,'Sottilette','Frigo','Sottilette Classiche','97.png',''),(98,'Ricotta','Frigo','Ricotta magra','98.png',''),(99,'Pasta sfoglia','Frigo','Per preparazione dolci e salate','99.png',''),(100,'Mascarpone','Frigo','Mascarpone per dolci','100.png',''),(101,'Detersivo per piatti','Cucina','Confezione MAXI da 1,5l','101.png',''),(102,'Sgrassatore','Cucina','100% brillante','102.png',''),(103,'Scottex','Cucina','In confezione da 2 pezzi','103.png',''),(104,'Spugna','Cucina','Con lato abrasivo','104.png',''),(105,'Sacchi immondizia','Cucina','Rotolo da 10 pezzi, dimensione grande','105.png',''),(106,'Pastiglie per lavastoviglie','Cucina','In confezione da 40 tabs','106.png',''),(107,'Carta da forno','Cucina','Ideale per cuocere in forno','107.png',''),(108,'Alluminio da cucina','Cucina','In rotolo da 25 metri','108.png',''),(109,'Pellicola trasparente','Cucina','Ottima per sigillare le pietanze','109.png',''),(110,'Sacchetti','Cucina','Confezione da 20 sacchetti per congelatore','110.png',''),(111,'Straccio','Cucina','100% cotone','111.png',''),(112,'Carta igienica','Bagno','2 veli, 500 strappi','112.png',''),(113,'Sapone liquido','Bagno','Flacone da 750ml','113.png',''),(114,'Saponetta','Bagno','Puro sapone di Marsiglia','114.png',''),(115,'Shampoo','Bagno','Per cute sensibile','115.png',''),(116,'Balsamo','Bagno','Per capelli lisci','116.png',''),(117,'Bagnoschiuma','Bagno','Ph neutro','117.png',''),(118,'Spugna da doccia','Bagno','In materiale sintetico','118.png',''),(119,'Dentifricio','Bagno','Dentifricio al fluoro','119.png',''),(120,'Rasoio','Bagno','A 5 lame','120.png',''),(121,'Schiuma da barba','Bagno','Anti irritazioni','121.png',''),(122,'Salviette profumate','Bagno','Salviette per la detersione della pelle','122.png',''),(123,'Colluttorio','Bagno','Colluttorio a base di fluoro','123.png',''),(124,'Deodorante','Bagno','Deodorante unisex','124.png',''),(125,'Capsule per wc','Bagno','Confezione da 25 capsule','125.png',''),(126,'Candeggina','Bagno','Soluzione di ipoclorito di sodio per la pulizia','126.png',''),(127,'Anticalcare','Bagno','Anticalcare per rubinetteria','127.png',''),(128,'Detersivo panni','Bagno','Detersivo per lavatrice profumato','128.png',''),(129,'Ammorbidente','Bagno','Ammorbidente per lavatrice','129.png',''),(130,'Alcol per vetri','Materiale pulizia','Alccol etilico 90° per pulizie','130.png',''),(131,'Detersivo per pavimenti','Materiale pulizia','Detersivo disinfettante per varie pavimentazioni','131.png',''),(133,'Panno catturapolvere','Materiale pulizia','Panni catturapolvere elettrostatici','133.png',''),(134,'Secchio','Materiale pulizia','Secchio da 10l','134.png',''),(135,'Spazzolone','Materiale pulizia','Spazzolone lavapavimenti','135.png',''),(137,'Detersivo parquet','Materiale pulizia','Detersivo per pavimentazioni in parquet','137.png',''),(139,'Guanti in gomma','Materiale pulizia','Guanti in gomma antiscivolo','139.png',''),(140,'Aspirapolvere a cavo','Strumenti','Aspirapolvere senza sacco 1300W','140.png',''),(141,'Aspirapolvere wireless','Strumenti','Aspirabriciole senza fili','141.png',''),(142,'Robot aspirapolvere','Strumenti','Robot aspirapolvere con mappatura laser','142.png',''),(143,'Scopa','Strumenti','Scopa con mamnico telescopico','143.png',''),(144,'Pattumiera','Strumenti','Pattumiera in metallo','144.png',''),(145,'Mocio','Strumenti','Mocio per la pulizia del pavimento','145.png',''),(146,'Secchio per mocio','Strumenti','Secchio per mocio 8 litri','146.png',''),(147,'Vaporella','Strumenti','Ferro da stiro a vapore','147.png',''),(148,'Ferro da stiro','Strumenti','Ferro da stiro tradizionale','148.png',''),(149,'Asse da stiro','Strumenti','Asse da stiro con struttura in legno','149.png',''),(150,'Cerotti','Salute','Confezione varie misure','150.png',''),(151,'Garze','Salute','Garze sterili in cotone idrofilo','151.png',''),(152,'Disinfettante','Salute','Disinfettante analcolico per ferite','152.png',''),(153,'Pinzette','Salute','Pinzette metalliche levaschegge','153.png',''),(154,'Aspirina','Salute','Acido Acetilsalicilico in compresse effervescenti','154.png',''),(155,'Acqua ossigenata','Salute','Perossido di idrogeno 250ml','155.png',''),(156,'Pomata antidolorifica','Salute','Pomata antidolorifica in gel 100g','156.png',''),(157,'Antinfiammatorio','Salute','Antinfiammatorio in polvere','157.png',''),(158,'Collirio','Salute','Gocce oculari lubrificanti (soluzione oftalmica)','158.png',''),(159,'Dischetti in cotone','Salute','Dischetti in cotone struccanti','159.png',''),(160,'Martello','Attrezzatura','Martello da carpentiere con impugnatura gommata per piantare ed estrarre chiodi','160.png',''),(161,'Sega','Attrezzatura','Sega manuale per legno','161.png',''),(162,'Cacciavite','Attrezzatura','Cacciavite a stella','162.png',''),(163,'Pinza a pappagallo','Attrezzatura','Pinza a becco di pappagallo con manico isolato','163.png',''),(164,'Trapano','Attrezzatura','Trapano/avvitatore a batteria con percussione','164.png',''),(165,'Tenaglia','Attrezzatura','Tenaglia da falegname in acciaio','165.png',''),(166,'Cassetta portautensili','Attrezzatura','Cassetta portautensili con compartimenti in polipropilene','166.png',''),(167,'Smerigliatrice','Attrezzatura','Smerigliatrice angolare elettronica con dischi diamantati','167.png',''),(168,'Brugole','Attrezzatura','Set brugole esagonali','168.png',''),(169,'Chiave inglese','Attrezzatura','Chiave inglese in acciaio al cromo-vanadio','169.png',''),(170,'Chiave a bussola','Attrezzatura','Chiave a bussola universale con cricchetto','170.png',''),(171,'Inserti per bussola','Attrezzatura','Inserti intercambiabili per chiave a bussola','171.png',''),(172,'Chiodi','Minuteria','Chiodi in acciaio','172.png',''),(173,'Bulloni','Minuteria','Bulloni a testa esagonale','173.png',''),(174,'Dadi','Minuteria','Dadi esagonali in acciaio','174.png',''),(175,'Autofilettanti','Minuteria','Viti autofilettanti a testa piana','175.png',''),(176,'Tasselli','Minuteria','Tasselli di fissaggio in nylon','176.png',''),(177,'Rondelle','Minuteria','Rondella piatta in acciaio','177.png',''),(178,'Fascette','Minuteria','Fascette multiuso in plastica','178.png',''),(179,'Filo di ferro','Minuteria','Bobina filo di ferro cotto','179.png',''),(180,'Rivetti','Minuteria','Rivetti a strappo in acciaio','180.png',''),(181,'Raccordi','Minuteria','Raccordi per tubature in ottone','181.png',''),(182,'Vernice bianca','Edilizia e vernici','Pittura murale bianca antimuffa per interni','182.png',''),(183,'Vernice spray','Edilizia e vernici','Vernice spray acrilica lucida','183.png',''),(184,'Acquaragia','Edilizia e vernici','Solvente acquaragia inodore','184.png',''),(185,'Smalto','Edilizia e vernici','Pittura smalto murale per esterni','185.png',''),(186,'Stucco','Edilizia e vernici','Stucco per pareti esterne','186.png',''),(187,'Spatola','Edilizia e vernici','Spatola per pareti con manico in legno','187.png',''),(188,'Carta abrasiva','Edilizia e vernici','Carta vetrata al corindone','188.png',''),(189,'Cemento','Edilizia e vernici','Cemento Portland 32,5 R 25Kg','189.png',''),(190,'Calce','Edilizia e vernici','Intonaco tradizionale a base di calce idraulica','190.png',''),(191,'Silicone','Edilizia e vernici','Silicone sigillante neutro','191.png',''),(192,'Rastrello','Giardino','Rastrello in acciaio a 12 denti','192.png',''),(193,'Vanga','Giardino','Vanga in acciaio temperato','193.png',''),(194,'Piccone','Giardino','Piccone in acciaio con manico in abete','194.png',''),(195,'Tosaerba','Giardino','Tosaerba a scoppio 45 cm di taglio','195.png',''),(196,'Innaffiatoio','Giardino','Innaffiatoio in plastica 4l con diffusore','196.png',''),(197,'Tubo irrigazione','Giardino','Tubo irrigazione 1/4\" 20 metri','197.png',''),(198,'Girandola','Giardino','Irrigatore da giardino','198.png',''),(199,'Tagliasiepe','Giardino','Tagliasiepi a scoppio lama 60 cm','199.png',''),(200,'Cesoie','Giardino','Cesoia manuale telescopica','200.png',''),(201,'Guanti','Giardino','Guanti multiuso da lavoro','201.png',''),(202,'Motosega','Giardino','Motosega 30cc lama da 35 cm','202.png',''),(203,'Aspirafoglie','Giardino','Aspiratore/soffiatore elettrico 3000W','203.png',''),(204,'Decespugliatore','Giardino','Decespugliatore a scoppio 41cc','204.png',''),(205,'Cavi','Materiale elettrico','Cavo CPR multipolare 1,5 mm','205.png',''),(206,'Spelafili','Materiale elettrico','Pinza spelafili automatica','206.png',''),(207,'Multimetro','Materiale elettrico','Multimetro digitale multifunzione','207.png',''),(208,'Batterie','Materiale elettrico','Batterie AA ricaricabili NiMH 2000mAh','208.png',''),(209,'Lampadine','Materiale elettrico','Lampadine a risparmio energetico','209.png',''),(210,'Torcia elettrica','Materiale elettrico','Torcia elettrica LED ricaricabile','210.png',''),(211,'Capicorda','Materiale elettrico','Terminali capocorda femmina e maschio','211.png',''),(212,'Prolunga','Materiale elettrico','Prolunga multipresa con avvolgitore 25 m','212.png',''),(213,'Nastro isolante','Materiale elettrico','Nastro isolante in PVC 10 m','213.png',''),(214,'Lampade al neon','Materiale elettrico','Lampade al neon a LED','214.png',''),(215,'Scarpe da calcio','Calcio','Scarpini da calcio in pelle per terreni morbidi','215.png',''),(216,'Pallone','Calcio','Pallone da calcio in cuoio Size5','216.png',''),(217,'Parastinchi','Calcio','Parastinchi flessibili in plastica con fasce elastiche a strap','217.png',''),(218,'Guanti','Calcio','Guanti da portiere con stecche','218.png',''),(219,'Tacchetti','Calcio','Tacchetti a vite per scarpe da calcio in alluminio','219.png',''),(220,'Calzettoni','Calcio','Calzettoni da calcio elasticizzati','220.png',''),(221,'Pantaloncini','Calcio','Pantaloni corti da calcio','221.png',''),(222,'Maglietta maniche corte','Calcio','Maglia maniche corte 100% poliestere','222.png',''),(223,'Felpa','Calcio','Felpa sportiva a maniche lunghe','223.png',''),(224,'Pantaloni lunghi','Calcio','Pantaloni lunghi sportivi','224.png',''),(225,'Cuffia','Nuoto','Cuffia da piscina in materiale plastico','225.png',''),(226,'Costume','Nuoto','Costume boxer maschile sintetico','226.png',''),(227,'Ciabatte','Nuoto','Ciabatte da piscina','227.png',''),(228,'Infradito','Nuoto','Infradito da mare','228.png',''),(229,'Occhialini','Nuoto','Occhialini per piscina','229.png',''),(230,'Maschera','Nuoto','Maschera per snorkeling','230.png',''),(231,'Tappanaso','Nuoto','Clip tappanaso per piscina','231.png',''),(232,'Pinne','Nuoto','Pinne per immersioni subacquee','232.png',''),(233,'Boccaglio','Nuoto','Boccaglio per immersioni','233.png',''),(234,'Braccioli','Nuoto','Braccioli gonfiabili','234.png',''),(235,'Racchetta da tennis','Tennis','Racchetta da tennis in fibra di carbonio','235.png',''),(236,'Borsone da tennis','Tennis','Borsona porta racchette da tennis','236.png',''),(237,'Palline da tennis','Tennis','Palle da tennis in tubo da 4','237.png',''),(238,'Scarpe da tennis','Tennis','Calzature da tennis per campi in cemento','238.png',''),(240,'Visiera','Tennis','Visiera unisex taglia unica','240.png',''),(241,'Racchetta da pingpong','Tennis','Professional line','241.png',''),(242,'Palline da pingpong','Tennis','Varie colorazioni','242.png',''),(243,'Rete da pingpong','Tennis','Agganciabile con viti a galletto','243.png',''),(244,'Tavolo da pingpong','Tennis','Adatto per interni','244.png',''),(245,'Casco','Ciclismo','Casco da ciclismo','245.png',''),(246,'Bicicletta','Ciclismo','Mountain bike 21 velocità','246.png',''),(247,'E-bike','Ciclismo','Motore 250W, batteria 500Wh','247.png',''),(248,'Scarpe da bici','Ciclismo','Scarpe per ciclismo','248.png',''),(249,'Copriscarpe','Ciclismo','Copriscarpe per ciclismo','249.png',''),(250,'Camera d\'aria','Ciclismo','In gomma','250.png',''),(251,'Copertone','Ciclismo','24\", 27,5\" e 29\"','251.png',''),(252,'Braghette da bici','Ciclismo','In poliestere','252.png',''),(253,'Maglietta da bici','Ciclismo','In poliestere','253.png',''),(254,'Scarpe da trekking','Montagna','Waterproof','254.png',''),(255,'Racchette','Montagna','Regolabili in altezza','255.png',''),(256,'Moschettone','Montagna','Con sicura a vite','256.png',''),(257,'Corda','Montagna','Conforme EN 892','257.png',''),(258,'Scarpette da arrampicata','Montagna','Varie misure','258.png',''),(260,'Sacca magnesite','Montagna','Massimo attrito','260.png',''),(261,'Crash pad','Montagna','Una buona protezione','261.png',''),(262,'Casco','Montagna','Indispensabile','262.png',''),(263,'Imbragatura','Montagna','Varie taglie','263.png',''),(264,'Picozza','Montagna','Indispensabile per l\'alpinismo','264.png',''),(265,'Zaino','Montagna','Leggero, 40L di capienza','265.png',''),(266,'Orologio GPS','Montagna','Sport, tempo libero, GPS GLONASS e Galileo','266.png',''),(267,'Pomelo','User Products','Cina','',''),(268,'Mango','User Products','Sud America','','268.png');
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductCat_ListCat`
--

DROP TABLE IF EXISTS `ProductCat_ListCat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductCat_ListCat` (
  `ListCatName` varchar(50) NOT NULL DEFAULT '',
  `ProductCatName` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`ListCatName`,`ProductCatName`),
  KEY `ProductCat_ListCat_ProductCategory_Name_fk` (`ProductCatName`),
  CONSTRAINT `ProductCat_ListCat_ProductCategory_Name_fk` FOREIGN KEY (`ProductCatName`) REFERENCES `ProductCategory` (`Name`) ON DELETE CASCADE,
  CONSTRAINT `ProductCat_ListCat_ListCategory_Name_fk` FOREIGN KEY (`ListCatName`) REFERENCES `ListCategory` (`Name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCat_ListCat`
--

LOCK TABLES `ProductCat_ListCat` WRITE;
/*!40000 ALTER TABLE `ProductCat_ListCat` DISABLE KEYS */;
INSERT INTO `ProductCat_ListCat` VALUES ('Ferramenta','Attrezzatura'),('Prodotti per pulizia e igiene','Bagno'),('Alimentari','Bevande'),('Sport e tempo libero','Calcio'),('Alimentari','Carne e pesce'),('Sport e tempo libero','Ciclismo'),('Prodotti per pulizia e igiene','Cucina'),('Ferramenta','Edilizia e vernici'),('Alimentari','Forno'),('Alimentari','Frigo'),('Alimentari','Frutta e verdura'),('Ferramenta','Giardino'),('Ferramenta','Materiale elettrico'),('Prodotti per pulizia e igiene','Materiale pulizia'),('Ferramenta','Minuteria'),('Sport e tempo libero','Montagna'),('Sport e tempo libero','Nuoto'),('Prodotti per pulizia e igiene','Salute'),('Prodotti per pulizia e igiene','Strumenti'),('Sport e tempo libero','Tennis');
/*!40000 ALTER TABLE `ProductCat_ListCat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductCategory`
--

DROP TABLE IF EXISTS `ProductCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductCategory` (
  `Name` varchar(50) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Logo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `ProductCategory_Name_uindex` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategory`
--

LOCK TABLES `ProductCategory` WRITE;
/*!40000 ALTER TABLE `ProductCategory` DISABLE KEYS */;
INSERT INTO `ProductCategory` VALUES ('Attrezzatura','Attrezzature varie da lavoro','Attrezzatura.png'),('Bagno','Alcuni prodotti per il bagno','Bagno.png'),('Bevande','Alcuni tipi di bevanda','Bevande.png'),('Calcio','Attrezzatura per giocare a calcio','Calcio.png'),('Carne e pesce','Alcuni tipi di carne e pesce','Carne e pesce.png'),('Ciclismo','Attrezzatura per il ciclismo','Ciclismo.png'),('Cucina','Alcuni prodotti per la cucina','Cucina.png'),('Edilizia e vernici','Alcuni prodotti per ediliza e verniciatura','Edilizia e vernici.png'),('Forno','Alcuni prodotti da forno','Forno.png'),('Frigo','Alcuni prodotti da frigo','Frigo.png'),('Frutta e verdura','Alcuni tipi di frutta e verdura','Frutta e verdura.png'),('Giardino','Alcuni prodotti da giardinaggio','Giardino.png'),('Materiale elettrico','Materiale elettrico vario','Materiale elettrico.png'),('Materiale pulizia','Materiale da pulizia','Materiale pulizia.png'),('Minuteria','Alcuni prodotti di minuteria','Minuteria.png'),('Montagna','Attrezzatura per le escursioni in montagna','Montagna.png'),('Nuoto','Attrezzatura per il nuoto','Nuoto.png'),('Salute','Alcuni prodotti per la salute','Salute.png'),('Strumenti','Strumenti vari per la casa','Strumenti.png'),('Tennis','Attrezzatura per tennis o tennis da tavolo','Tennis.png'),('User Products','Used for saving the user products','');
/*!40000 ALTER TABLE `ProductCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Image` varchar(70) DEFAULT NULL,
  `Typology` varchar(50) NOT NULL,
  `Valid` tinyint(1) DEFAULT NULL,
  `Cod` varchar(50) DEFAULT NULL,
  `Cookie` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE KEY `User_Email_uindex` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('07255c49-120c-4cb1-9566-7e11a3ee03cc','*8B3183903081A8BE753EC0194E953C17AFC6599B','07255c49-120c-4cb1-9566-7e11a3ee03cc','20190130','','anonymous',1,NULL,'07255c49-120c-4cb1-9566-7e11a3ee03cc'),('254ebe52-cc1c-450f-8e61-d0324c99e76f','*CFF813E2D893A33AEFF58C357E058CE8F953C3AC','254ebe52-cc1c-450f-8e61-d0324c99e76f','20190131','','anonymous',1,NULL,'254ebe52-cc1c-450f-8e61-d0324c99e76f'),('3f2c6049-b39c-477d-ad5c-4cdee3f4471a','*5FAD1591D5E8167B35656E18DBD9DDB7AF04A6EA','3f2c6049-b39c-477d-ad5c-4cdee3f4471a','20190130','','anonymous',1,NULL,'3f2c6049-b39c-477d-ad5c-4cdee3f4471a'),('539ecbca-088d-4b65-b78e-7e640d4dd5bc','*5D33CA8DE5003E7ED02958320FC31A82B3041792','539ecbca-088d-4b65-b78e-7e640d4dd5bc','20190131','','anonymous',1,NULL,'539ecbca-088d-4b65-b78e-7e640d4dd5bc'),('601a113f-6b32-4646-9894-74a1c1417e1e','*5B2BA256E4846334C6CB25AB87C2A62B52F10B84','601a113f-6b32-4646-9894-74a1c1417e1e','20190131','','anonymous',1,NULL,'601a113f-6b32-4646-9894-74a1c1417e1e'),('a22e8b34-c55f-4e4c-899e-5dee38fb8b58','*A328128D2AC496867062F1A52754CBEAFE9EF818','a22e8b34-c55f-4e4c-899e-5dee38fb8b58','20190131','','anonymous',1,NULL,'a22e8b34-c55f-4e4c-899e-5dee38fb8b58'),('admin@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','Admin','Root','admin@gmail.com.png','admin',1,'MNDGF8T3','NULL'),('benti@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','lucaB','Benti','','normal',0,NULL,NULL),('bentivoglio.luca97@gmail.com','*A007D9B999697F70E2F227A69026115562CBDDBF','Luca','Bentivoglio','bentivoglio.luca97@gmail.com.png','normal',1,'KU0LWK6Q','NULL'),('c0a0e185-a97c-428f-973b-db4d00b86256','*0A19C605B5D57AD39D1F5D77DC0E242C34CD96EF','c0a0e185-a97c-428f-973b-db4d00b86256','20190131','','anonymous',1,NULL,'c0a0e185-a97c-428f-973b-db4d00b86256'),('c208fd57-af17-4bcb-969b-5d5b0d699895','*6DB294F2ECA7BACAA59D1E1750B7A87D40305E67','c208fd57-af17-4bcb-969b-5d5b0d699895','20190131','','anonymous',1,NULL,'c208fd57-af17-4bcb-969b-5d5b0d699895'),('cf7a6819-0691-4df8-9a7e-a717955a711f','*6331F36BF23D63657FE7715F277E51B3CD101679','cf7a6819-0691-4df8-9a7e-a717955a711f','20190131','','anonymous',1,NULL,'cf7a6819-0691-4df8-9a7e-a717955a711f'),('dfg@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','Giacomo','Totti','','normal',0,'EFAA3I3F',NULL),('emiliano.tolotti@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','Emiliano','Tolotti','emiliano.tolotti@gmail.com.png','normal',1,'KBATSDOM',NULL),('emiliantolo@gmail.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','Emiliano','Tolotti','emiliantolo@gmail.com.png','normal',1,'7X83YYNG','NULL'),('fa2b387e-9225-4aba-b303-e86d8ce129b2','*C3852DFED2145C4002D08210DB2181CAEC0D11A0','fa2b387e-9225-4aba-b303-e86d8ce129b2','20190131','','anonymous',1,NULL,'fa2b387e-9225-4aba-b303-e86d8ce129b2'),('luca.bentivoglio@studenti.unitn.it','*B4E3E0AE00ED134E04BF6D3A123CBD02A69C96F1','Luca','Benti','','normal',1,'5OWKINB1','da7586ec-b5d5-4990-8534-816eae07dd3d'),('mark_mena97@hotmail.it','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','Marco','Menapace','mark_mena97@hotmail.it.png','normal',1,'J9NXY9U7','NULL'),('pop.bogdan.pvab@gmail.com','*2B631A42CF2C466C1195879A3BD51D43EEA6E8AC','Pop','Bogdan','pop.bogdan.pvab@gmail.com.png','normal',1,'QHYT72FX','NULL'),('zfzobfxx@imgof.com','*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19','zorzi','rossi','','normal',1,'5SD2XSZ6',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-01 11:21:42
