-- MySQL dump 10.13  Distrib 5.5.44, for Linux (x86_64)
--
-- Host: localhost    Database: lfg
-- ------------------------------------------------------
-- Server version	5.5.44

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
-- Table structure for table `Activities`
--

DROP TABLE IF EXISTS `Activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Activities` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) NOT NULL,
  `activity_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `fk_activities_games_idx` (`game_id`),
  CONSTRAINT `FK_Activities_Games` FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Activities`
--

LOCK TABLES `Activities` WRITE;
/*!40000 ALTER TABLE `Activities` DISABLE KEYS */;
INSERT INTO `Activities` VALUES (1,1,'Supply Raid'),(2,1,'Survivors'),(3,1,'Interrogation'),(4,2,'Chaos Squad'),(5,3,'Arena'),(6,3,'Capture the Flag'),(7,3,'Control Point'),(8,4,'Free-for-All'),(9,4,'Team Deathmatch'),(10,4,'Zombies'),(11,4,'PS4 - Exclusive Example'),(12,4,'X1 - Exclusive Example'),(13,4,'PC - Exclusive Example');
/*!40000 ALTER TABLE `Activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ActivitiesSystemsGames`
--

DROP TABLE IF EXISTS `ActivitiesSystemsGames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActivitiesSystemsGames` (
  `activity_id` int(11) NOT NULL,
  `system_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`,`system_id`,`game_id`),
  KEY `fk_SystemsActivities_Activities_idx` (`activity_id`),
  KEY `FK_ActivitiesSystemsGames_Games_idx` (`game_id`),
  KEY `fk_ActivitiesSystemsGames_Systems` (`system_id`),
  CONSTRAINT `fk_ActivitiesSystemsGames_Systems` FOREIGN KEY (`system_id`) REFERENCES `Systems` (`system_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActivitiesSystemsGames_Activities` FOREIGN KEY (`activity_id`) REFERENCES `Activities` (`activity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_ActivitiesSystemsGames_Games` FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActivitiesSystemsGames`
--

LOCK TABLES `ActivitiesSystemsGames` WRITE;
/*!40000 ALTER TABLE `ActivitiesSystemsGames` DISABLE KEYS */;
INSERT INTO `ActivitiesSystemsGames` VALUES (1,1,1),(2,1,1),(3,1,1),(4,2,2),(5,3,3),(6,3,3),(7,3,3),(8,1,4),(8,2,4),(8,3,4),(9,1,4),(9,2,4),(9,3,4),(10,1,4),(10,2,4),(10,3,4),(11,1,4),(12,2,4),(13,3,4);
/*!40000 ALTER TABLE `ActivitiesSystemsGames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Games`
--

DROP TABLE IF EXISTS `Games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Games` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `game_name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Games`
--

LOCK TABLES `Games` WRITE;
/*!40000 ALTER TABLE `Games` DISABLE KEYS */;
INSERT INTO `Games` VALUES (1,'The Last of Us'),(2,'Sunset Overdrive'),(3,'Team Fortess 2'),(4,'Call of Duty: Black Ops 3');
/*!40000 ALTER TABLE `Games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groups` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_user` varchar(50) NOT NULL,
  `group_system` int(11) NOT NULL,
  `group_game` int(11) NOT NULL,
  `group_activity` int(11) NOT NULL,
  `group_iam` tinyint(4) NOT NULL,
  `group_details` varchar(80) DEFAULT NULL,
  `group_language` char(3) NOT NULL,
  `group_time` int(11) NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `name_UNIQUE` (`group_user`),
  UNIQUE KEY `group_id_UNIQUE` (`group_id`),
  KEY `fk_group_systems_idx` (`group_system`),
  KEY `fk_group_games_idx` (`group_game`),
  KEY `fk_groups_activities_idx` (`group_activity`),
  CONSTRAINT `FK_Groups_Systems` FOREIGN KEY (`group_system`) REFERENCES `Systems` (`system_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Groups_Games` FOREIGN KEY (`group_game`) REFERENCES `Games` (`game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Groups_Activities` FOREIGN KEY (`group_activity`) REFERENCES `Activities` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groups`
--

LOCK TABLES `Groups` WRITE;
/*!40000 ALTER TABLE `Groups` DISABLE KEYS */;
INSERT INTO `Groups` VALUES (1,'testUser_1',1,4,11,0,'Looking for a sherpa','eng',1475632990),(2,'testUser_2',1,1,1,0,'','eng',1475632971),(3,'testUser_3',3,3,7,0,'','eng',1475633030),(4,'testUser_4',2,4,8,0,'Sherpa looking to help others','jpn',1475633041),(5,'testUser_5',3,3,5,1,'','eng',1475633165),(6,'testUser_6',2,2,4,1,'','eng',1475633126),(7,'testUser_7',3,4,9,1,'','eng',1475633072),(8,'testUser_8',1,1,1,0,'Sherpa looking to help others','jpn',1475632991),(9,'testUser_9',1,1,1,1,'','eng',1475633009),(10,'testUser_10',2,2,4,0,'Newbs and vets welcome!','eng',1475633158),(11,'testUser_11',2,4,8,0,'','eng',1475633208),(12,'testUser_12',3,3,7,1,'','eng',1475633074),(13,'testUser_13',2,2,4,0,'','spa',1475633054),(14,'testUser_14',3,3,5,1,'Next 2 hours only','eng',1475633162),(15,'testUser_15',1,1,2,1,'','eng',1475632920),(16,'testUser_16',3,3,7,1,'Newbs and vets welcome!','spa',1475632908),(17,'testUser_17',2,2,4,1,'Sherpa looking to help others','ger',1475633218),(18,'testUser_18',1,1,1,0,'','eng',1475633215),(19,'testUser_19',3,3,6,0,'','eng',1475633068),(20,'testUser_20',3,4,13,0,'I really need help!','eng',1475633201),(21,'testUser_21',2,2,4,0,'Sherpa looking to help others','eng',1475633174),(22,'testUser_22',2,2,4,0,'All night run, please be committed!','eng',1475633098),(23,'testUser_23',3,3,7,1,'','jpn',1475633135),(24,'testUser_24',1,4,9,0,'','eng',1475633147),(25,'testUser_25',1,1,2,1,'','eng',1475632957),(26,'testUser_26',1,1,2,1,'I need high-level players','eng',1475633014),(27,'testUser_27',1,1,1,1,'No mic = kick!','jpn',1475633081),(28,'testUser_28',3,3,6,1,'','eng',1475632974),(29,'testUser_29',1,1,1,0,'','eng',1475633127),(30,'testUser_30',2,4,12,0,'','eng',1475633129),(31,'testUser_31',3,3,7,1,'Only between 1 and 4 PM PST please','eng',1475633136),(32,'testUser_32',1,1,2,1,'No mic = kick!','ger',1475633086),(33,'testUser_33',2,2,4,1,'','eng',1475633046),(34,'testUser_34',3,3,7,1,'','eng',1475633128),(35,'testUser_35',2,2,4,0,'','ger',1475633170),(36,'testUser_36',3,3,6,0,'If I miss you try again at 15:00','eng',1475633181),(37,'testUser_37',1,1,3,0,'Need 1 more','jpn',1475632923),(38,'testUser_38',1,4,11,0,'','jpn',1475633008),(39,'testUser_39',1,1,3,1,'Newbs and vets welcome!','spa',1475632968),(40,'testUser_40',1,4,10,1,'I will run this again at 4pm if I miss you','ger',1475633079),(41,'testUser_41',3,4,13,1,'Looking for 4','jpn',1475632941),(42,'testUser_42',2,2,4,1,'','eng',1475633216),(43,'testUser_43',1,1,2,1,'','eng',1475633089),(44,'testUser_44',1,1,2,1,'If I miss you try again at 15:00','eng',1475633001),(45,'testUser_45',2,4,12,0,'','jpn',1475632933),(46,'testUser_46',2,2,4,0,'Please message me before sending friend request','eng',1475633048),(47,'testUser_47',2,2,4,0,'','eng',1475633187),(48,'testUser_48',3,3,5,1,'','eng',1475633087),(49,'testUser_49',2,2,4,0,'','eng',1475632950),(50,'testUser_50',2,2,4,1,'','eng',1475633094),(51,'testUser_51',2,2,4,0,'Looking for 4','jpn',1475633178),(52,'testUser_52',3,4,13,0,'Next 2 hours only','ger',1475632925),(53,'testUser_53',3,4,10,0,'Newbs and vets welcome!','eng',1475633075),(54,'testUser_54',2,2,4,0,'Just wrecking stuff','eng',1475633221),(55,'testUser_55',2,2,4,0,'I\'m very skilled','jpn',1475633100),(56,'testUser_56',1,4,10,0,'','jpn',1475632928),(57,'testUser_57',2,4,8,0,'','jpn',1475633124),(58,'testUser_58',1,1,3,1,'','eng',1475633153),(59,'testUser_59',3,4,10,1,'I\'m very skilled','ger',1475632932),(60,'testUser_60',3,3,6,0,'','eng',1475632962),(61,'testUser_61',2,2,4,0,'','eng',1475633011),(62,'testUser_62',1,1,2,1,'','eng',1475632953),(63,'testUser_63',1,1,3,0,'Need 1 more','ger',1475632930),(64,'testUser_64',2,2,4,1,'No mic = kick!','jpn',1475632997),(65,'testUser_65',2,2,4,1,'','eng',1475633171),(66,'testUser_66',3,3,5,1,'','eng',1475632979),(67,'testUser_67',2,2,4,1,'All night run, please be committed!','eng',1475633120),(68,'testUser_68',1,4,9,1,'Newbs and vets welcome!','eng',1475633040),(69,'testUser_69',2,2,4,0,'Looking for 4','eng',1475632947),(70,'testUser_70',2,2,4,1,'','eng',1475633038),(71,'testUser_71',3,3,7,1,'I will run this again at 4pm if I miss you','eng',1475632977),(72,'testUser_72',3,3,7,1,'','eng',1475632942),(73,'testUser_73',2,4,8,1,'','eng',1475633223),(74,'testUser_74',1,4,11,1,'Only need 3 more!','eng',1475633003),(75,'testUser_75',2,2,4,1,'Will do other modes as well','eng',1475633034),(76,'testUser_76',3,3,5,1,'','eng',1475632907),(77,'testUser_77',3,3,6,0,'','eng',1475632958),(78,'testUser_78',3,3,5,0,'','eng',1475633082),(79,'testUser_79',1,1,2,1,'No laggy players PLEASE!','eng',1475633096),(80,'testUser_80',1,1,1,0,'I\'m very skilled','eng',1475633058),(81,'testUser_81',1,1,2,1,'','spa',1475633164),(82,'testUser_82',1,1,2,0,'','eng',1475633105),(83,'testUser_83',2,4,8,0,'No mic = kick!','eng',1475633107),(84,'testUser_84',1,1,1,1,'I\'m very skilled','eng',1475633023),(85,'testUser_85',3,3,6,1,'Need 1 more','eng',1475633106),(86,'testUser_86',1,4,9,0,'No mic = kick!','spa',1475633029),(87,'testUser_87',3,3,7,1,'','eng',1475633166),(88,'testUser_88',3,3,5,1,'','ger',1475633156),(89,'testUser_89',1,1,3,0,'I\'m very skilled','eng',1475633224),(90,'testUser_90',3,3,5,0,'Will do other modes as well','eng',1475632954),(91,'testUser_91',1,1,3,1,'No mic = kick!','eng',1475633179),(92,'testUser_92',2,2,4,1,'Need 1 more','jpn',1475633077),(93,'testUser_93',1,1,3,0,'','eng',1475633025),(94,'testUser_94',3,3,5,0,'All night run, please be committed!','eng',1475632918),(95,'testUser_95',2,4,12,0,'','eng',1475633194),(96,'testUser_96',1,4,8,1,'If I miss you try again at 15:00','ger',1475633154),(97,'testUser_97',1,4,10,0,'Looking for 4','eng',1475632969),(98,'testUser_98',2,4,12,0,'','eng',1475632946),(99,'testUser_99',2,4,8,0,'No laggy players PLEASE!','eng',1475633205),(100,'testUser_100',1,4,8,1,'','ger',1475633145),(101,'testUser_101',1,1,3,1,'If I miss you try again at 15:00','eng',1475632913),(102,'testUser_102',1,1,1,0,'','eng',1475633209),(103,'testUser_103',1,4,8,1,'','eng',1475633167),(104,'testUser_104',3,3,7,0,'','eng',1475632978),(105,'testUser_105',3,3,7,1,'I\'m very skilled','spa',1475633024),(106,'testUser_106',1,4,8,1,'Top player looking to help','eng',1475633028),(107,'testUser_107',1,1,3,1,'','eng',1475632960),(108,'testUser_108',3,4,13,1,'I\'m very skilled','eng',1475633099),(109,'testUser_109',1,4,11,1,'I will run this again at 4pm if I miss you','spa',1475633080),(110,'testUser_110',3,3,6,0,'Next 2 hours only','jpn',1475633037),(111,'testUser_111',3,3,5,0,'','eng',1475633202),(112,'testUser_112',3,3,7,0,'','jpn',1475633102),(113,'testUser_113',2,4,10,0,'I really need help!','eng',1475633161),(114,'testUser_114',3,3,5,1,'Will do other modes as well','eng',1475632976),(115,'testUser_115',3,3,6,1,'','eng',1475633026),(116,'testUser_116',1,4,8,0,'','eng',1475633152),(117,'testUser_117',1,1,2,1,'','eng',1475632981),(118,'testUser_118',3,3,5,0,'','eng',1475633210),(119,'testUser_119',1,1,2,1,'Newbs and vets welcome!','eng',1475632949),(120,'testUser_120',2,2,4,1,'','eng',1475633112),(121,'testUser_121',2,2,4,0,'Top player looking to help','eng',1475633103),(122,'testUser_122',3,3,7,0,'','eng',1475633115),(123,'testUser_123',2,4,9,0,'','eng',1475633188),(124,'testUser_124',3,4,10,1,'','eng',1475632909),(125,'testUser_125',1,4,8,1,'No mic = kick!','eng',1475633220),(126,'testUser_126',2,2,4,0,'Looking for a sherpa','jpn',1475633184),(127,'testUser_127',2,4,8,0,'','eng',1475633190),(128,'testUser_128',2,2,4,0,'','eng',1475632985),(129,'testUser_129',3,3,5,0,'','eng',1475633104),(130,'testUser_130',1,1,3,1,'','jpn',1475633043),(131,'testUser_131',3,3,5,1,'No mic = kick!','jpn',1475633159),(132,'testUser_132',2,2,4,1,'Looking for 4','eng',1475633045),(133,'testUser_133',1,1,2,1,'If I miss you try again at 15:00','eng',1475633130),(134,'testUser_134',1,1,3,1,'No laggy players PLEASE!','eng',1475632906),(135,'testUser_135',2,2,4,0,'I\'m very skilled','eng',1475632948),(136,'testUser_136',2,2,4,0,'Need 1 more','eng',1475633036),(137,'testUser_137',2,2,4,0,'','ger',1475632938),(138,'testUser_138',3,3,7,0,'Mic and clean language or kick!','eng',1475633070),(139,'testUser_139',3,4,13,0,'Newbs and vets welcome!','jpn',1475633180),(140,'testUser_140',1,1,2,1,'','eng',1475633031),(141,'testUser_141',3,4,8,0,'Top player looking to help','eng',1475632921),(142,'testUser_142',3,3,7,0,'Only need 3 more!','eng',1475632989),(143,'testUser_143',3,4,9,0,'Please message me before sending friend request','eng',1475633219),(144,'testUser_144',3,4,10,1,'','eng',1475633084),(145,'testUser_145',1,4,9,1,'I will run this again at 4pm if I miss you','jpn',1475633010),(146,'testUser_146',1,1,1,1,'','eng',1475633143),(147,'testUser_147',2,4,9,0,'','eng',1475633097),(148,'testUser_148',1,1,2,0,'','jpn',1475633163),(149,'testUser_149',1,1,3,1,'','eng',1475632905),(150,'testUser_150',2,2,4,1,'Need 1 more','eng',1475632910),(151,'testUser_151',3,4,9,0,'Only need 3 more!','eng',1475633060),(152,'testUser_152',2,4,9,0,'','spa',1475633200),(153,'testUser_153',2,2,4,0,'','eng',1475633113),(154,'testUser_154',2,2,4,1,'Please message me before sending friend request','spa',1475633059),(155,'testUser_155',3,4,13,0,'','jpn',1475633122),(156,'testUser_156',1,1,1,0,'','eng',1475633144),(157,'testUser_157',2,2,4,0,'','eng',1475633172),(158,'testUser_158',3,3,7,1,'','eng',1475633101),(159,'testUser_159',3,3,7,0,'Only between 1 and 4 PM PST please','ger',1475633050),(160,'testUser_160',1,1,1,1,'','jpn',1475633175),(161,'testUser_161',3,3,5,0,'Mic and clean language or kick!','eng',1475633000),(162,'testUser_162',2,2,4,1,'','eng',1475633002),(163,'testUser_163',1,1,1,1,'','eng',1475633004),(164,'testUser_164',3,3,6,1,'','eng',1475633211),(165,'testUser_165',1,1,3,0,'Only between 1 and 4 PM PST please','eng',1475633137),(166,'testUser_166',1,1,2,1,'','ger',1475633017),(167,'testUser_167',2,2,4,0,'','jpn',1475633177),(168,'testUser_168',2,4,8,1,'','eng',1475632924),(169,'testUser_169',3,3,5,1,'No laggy players PLEASE!','spa',1475632987),(170,'testUser_170',2,2,4,0,'No mic = kick!','eng',1475633131),(171,'testUser_171',3,4,10,0,'Looking for 4','eng',1475633111),(172,'testUser_172',2,2,4,1,'','eng',1475632919),(173,'testUser_173',2,2,4,1,'Mic required!','jpn',1475633222),(174,'testUser_174',1,4,10,1,'Top player looking to help','eng',1475633150),(175,'testUser_175',3,4,9,1,'Looking for 4','eng',1475633051),(176,'testUser_176',1,1,1,0,'Only between 1 and 4 PM PST please','eng',1475633067),(177,'testUser_177',2,4,8,0,'Doing this between 17:00 and 20:00','spa',1475633151),(178,'testUser_178',2,4,9,0,'','eng',1475633123),(179,'testUser_179',2,4,9,0,'Only between 1 and 4 PM PST please','ger',1475632963),(180,'testUser_180',3,3,6,0,'Doing this between 17:00 and 20:00','ger',1475633073),(181,'testUser_181',3,3,7,0,'Only need 3 more!','eng',1475633108),(182,'testUser_182',3,4,9,1,'','eng',1475633006),(183,'testUser_183',1,1,2,1,'','eng',1475632935),(184,'testUser_184',2,2,4,1,'Mic required!','eng',1475633191),(185,'testUser_185',2,2,4,1,'','eng',1475633012),(186,'testUser_186',1,1,1,0,'','spa',1475633121),(187,'testUser_187',1,4,9,1,'','eng',1475633212),(188,'testUser_188',3,3,6,1,'Mic required!','eng',1475633196),(189,'testUser_189',1,1,2,0,'','eng',1475633078),(190,'testUser_190',2,2,4,0,'','eng',1475632911),(191,'testUser_191',2,2,4,1,'Top player looking to help','eng',1475633053),(192,'testUser_192',2,2,4,1,'','eng',1475633066),(193,'testUser_193',1,4,8,1,'Looking for a sherpa','eng',1475632994),(194,'testUser_194',1,1,1,0,'Newbs and vets welcome!','eng',1475633110),(195,'testUser_195',3,3,5,1,'','eng',1475633148),(196,'testUser_196',3,3,7,0,'','spa',1475633140),(197,'testUser_197',2,2,4,1,'','eng',1475633062),(198,'testUser_198',2,2,4,0,'No mic = kick!','ger',1475633109),(199,'testUser_199',2,2,4,1,'Top player looking to help','eng',1475633016),(200,'testUser_200',1,1,3,1,'','eng',1475632999),(201,'testUser_201',3,4,10,0,'I\'m very skilled','ger',1475632912),(202,'testUser_202',3,3,6,1,'Friend requests OK','eng',1475633217),(203,'testUser_203',1,1,3,1,'Please message me before sending friend request','eng',1475633055),(204,'testUser_204',2,2,4,0,'All night run, please be committed!','eng',1475632914),(205,'testUser_205',1,4,10,1,'','eng',1475633146),(206,'testUser_206',3,3,7,1,'Top player looking to help','spa',1475632922),(207,'testUser_207',1,1,3,1,'Will do other modes as well','jpn',1475633005),(208,'testUser_208',3,3,7,0,'No mic = kick!','eng',1475632943),(209,'testUser_209',3,3,5,0,'','eng',1475632915),(210,'testUser_210',2,2,4,0,'','eng',1475632983),(211,'testUser_211',1,1,2,1,'I will run this again at 4pm if I miss you','spa',1475632956),(212,'testUser_212',2,2,4,1,'Need 1 more','eng',1475632929),(213,'testUser_213',1,1,2,1,'','eng',1475632926),(214,'testUser_214',2,4,12,0,'','eng',1475633204),(215,'testUser_215',3,3,6,1,'','eng',1475633133),(216,'testUser_216',1,1,1,1,'Looking for a sherpa','eng',1475633085),(217,'testUser_217',3,4,8,1,'Next 2 hours only','eng',1475632970),(218,'testUser_218',3,4,10,1,'','eng',1475633117),(219,'testUser_219',1,1,1,1,'No mic = kick!','spa',1475632967),(220,'testUser_220',1,1,3,1,'','eng',1475633169),(221,'testUser_221',3,3,7,1,'Looking for 4','eng',1475633091),(222,'testUser_222',3,3,5,0,'Looking for 4','jpn',1475632952),(223,'testUser_223',3,3,6,1,'Looking for 4','ger',1475633063),(224,'testUser_224',2,2,4,0,'Will do other modes as well','eng',1475632917),(225,'testUser_225',1,1,3,0,'Doing this between 17:00 and 20:00','eng',1475633119),(226,'testUser_226',2,2,4,0,'','eng',1475633088),(227,'testUser_227',3,3,6,0,'','eng',1475633049),(228,'testUser_228',2,2,4,0,'','eng',1475633065),(229,'testUser_229',3,3,7,0,'','eng',1475633185),(230,'testUser_230',1,1,3,1,'','spa',1475633195),(231,'testUser_231',3,3,5,0,'','eng',1475633213),(232,'testUser_232',3,4,13,1,'Only need 3 more!','ger',1475633183),(233,'testUser_233',3,3,6,0,'If I miss you try again at 15:00','jpn',1475633118),(234,'testUser_234',2,2,4,1,'','eng',1475632984),(235,'testUser_235',3,3,5,1,'Only need 3 more!','eng',1475633176),(236,'testUser_236',1,4,9,0,'','spa',1475633020),(237,'testUser_237',1,1,2,1,'Looking for 4','eng',1475632951),(238,'testUser_238',3,4,8,1,'','eng',1475633018),(239,'testUser_239',2,2,4,0,'No laggy players PLEASE!','eng',1475633007),(240,'testUser_240',2,2,4,0,'','ger',1475632927),(241,'testUser_241',1,1,2,1,'','eng',1475633206),(242,'testUser_242',3,3,5,0,'Looking for a sherpa','eng',1475633193),(243,'testUser_243',1,1,3,1,'Doing this between 17:00 and 20:00','ger',1475633056),(244,'testUser_244',2,2,4,1,'','eng',1475633092),(245,'testUser_245',3,3,7,1,'I really need help!','eng',1475633157),(246,'testUser_246',1,4,8,0,'Looking for 4','eng',1475633139),(247,'testUser_247',3,3,5,1,'','spa',1475632966),(248,'testUser_248',3,3,5,1,'No laggy players PLEASE!','jpn',1475632945),(249,'testUser_249',2,2,4,1,'I\'m very skilled','eng',1475632961),(250,'testUser_250',1,1,1,1,'','eng',1475633173),(251,'testUser_251',1,4,10,0,'Looking for 4','eng',1475632959),(252,'testUser_252',3,4,13,1,'I need high-level players','spa',1475633044),(253,'testUser_253',3,3,7,0,'','eng',1475633189),(254,'testUser_254',1,4,9,1,'Sherpa looking to help others','eng',1475632996),(255,'testUser_255',2,2,4,0,'','eng',1475632937),(256,'testUser_256',1,1,3,1,'Only between 1 and 4 PM PST please','eng',1475633199),(257,'testUser_257',2,2,4,1,'','spa',1475633125),(258,'testUser_258',1,1,3,0,'','eng',1475633116),(259,'testUser_259',1,1,1,0,'Only between 1 and 4 PM PST please','eng',1475633203),(260,'testUser_260',2,2,4,0,'I need high-level players','spa',1475633019),(261,'testUser_261',2,2,4,1,'Top player looking to help','eng',1475632931),(262,'testUser_262',1,1,2,0,'Need 1 more','eng',1475633134),(263,'testUser_263',2,2,4,0,'Only need 3 more!','eng',1475633093),(264,'testUser_264',3,3,7,1,'','eng',1475633214),(265,'testUser_265',2,2,4,1,'Looking for 4','eng',1475633090),(266,'testUser_266',2,4,12,0,'','eng',1475633061),(267,'testUser_267',1,1,3,0,'No mic = kick!','eng',1475633021),(268,'testUser_268',3,3,5,1,'','eng',1475633076),(269,'testUser_269',1,1,3,1,'Mic required!','ger',1475633015),(270,'testUser_270',2,2,4,1,'No laggy players PLEASE!','jpn',1475632992),(271,'testUser_271',1,4,10,1,'','eng',1475633197),(272,'testUser_272',3,3,7,1,'','eng',1475633064),(273,'testUser_273',1,1,1,0,'Will do other modes as well','eng',1475632995),(274,'testUser_274',2,4,12,1,'Need 1 more','spa',1475633022),(275,'testUser_275',2,2,4,0,'','spa',1475632955),(276,'testUser_276',1,4,10,1,'','eng',1475633142),(277,'testUser_277',1,1,3,1,'I will run this again at 4pm if I miss you','eng',1475632964),(278,'testUser_278',3,3,5,0,'No laggy players PLEASE!','eng',1475633141),(279,'testUser_279',3,3,5,0,'','jpn',1475633114),(280,'testUser_280',1,1,2,1,'','eng',1475632980),(281,'testUser_281',1,1,3,0,'Top player looking to help','eng',1475633071),(282,'testUser_282',3,3,5,1,'No laggy players PLEASE!','eng',1475633095),(283,'testUser_283',2,2,4,0,'','eng',1475632965),(284,'testUser_284',1,1,3,0,'No laggy players PLEASE!','eng',1475633052),(285,'testUser_285',2,4,9,0,'','eng',1475633207),(286,'testUser_286',2,2,4,0,'Next 2 hours only','eng',1475632973),(287,'testUser_287',1,1,1,1,'I need high-level players','eng',1475633057),(288,'testUser_288',3,3,5,0,'Mic and clean language or kick!','eng',1475633168),(289,'testUser_289',2,2,4,1,'','eng',1475633047),(290,'testUser_290',3,3,7,0,'','jpn',1475633032),(291,'testUser_291',2,4,10,0,'','eng',1475633039),(292,'testUser_292',1,4,10,1,'Mic and clean language or kick!','eng',1475633069),(293,'testUser_293',3,4,10,1,'','eng',1475633132),(294,'testUser_294',3,3,5,0,'','eng',1475632988),(295,'testUser_295',3,3,6,0,'','eng',1475633042),(296,'testUser_296',2,2,4,1,'','eng',1475632916),(297,'testUser_297',2,2,4,1,'','ger',1475633192),(298,'testUser_298',3,3,7,1,'','eng',1475633013),(299,'testUser_299',2,2,4,1,'I will run this again at 4pm if I miss you','eng',1475633083),(300,'testUser_300',1,1,3,0,'Top player looking to help','eng',1475633186),(301,'testUser_301',2,2,4,0,'','eng',1475632940),(302,'testUser_302',2,4,12,0,'','eng',1475632975),(303,'testUser_303',2,2,4,1,'Doing this between 17:00 and 20:00','eng',1475633160),(304,'testUser_304',3,3,5,1,'','eng',1475632934),(305,'testUser_305',1,1,2,0,'','eng',1475632986),(306,'testUser_306',1,4,9,0,'I\'m very skilled','jpn',1475632982),(307,'testUser_307',2,2,4,1,'Top player looking to help','eng',1475632998),(308,'testUser_308',2,2,4,1,'','eng',1475633149),(309,'testUser_309',3,3,5,0,'','eng',1475633138),(310,'testUser_310',2,4,10,0,'Sherpa looking to help others','eng',1475632939),(311,'testUser_311',1,1,2,0,'','eng',1475633155),(312,'testUser_312',3,3,6,0,'','eng',1475632993),(313,'testUser_313',1,1,2,0,'Doing this between 17:00 and 20:00','spa',1475632944),(314,'testUser_314',1,1,1,0,'','eng',1475633035),(315,'testUser_315',2,2,4,1,'','eng',1475632972),(316,'testUser_316',1,1,2,1,'I\'m very skilled','eng',1475633027),(317,'testUser_317',1,1,1,0,'Need 1 more','eng',1475632936),(318,'testUser_318',2,2,4,0,'','eng',1475633182),(319,'testUser_319',3,3,5,0,'Need 1 more','ger',1475633033),(320,'testUser_320',1,4,11,1,'','eng',1475633198);
/*!40000 ALTER TABLE `Groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Systems`
--

DROP TABLE IF EXISTS `Systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Systems` (
  `system_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Systems`
--

LOCK TABLES `Systems` WRITE;
/*!40000 ALTER TABLE `Systems` DISABLE KEYS */;
INSERT INTO `Systems` VALUES (1,'PS4'),(2,'X1'),(3,'PC');
/*!40000 ALTER TABLE `Systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SystemsGames`
--

DROP TABLE IF EXISTS `SystemsGames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SystemsGames` (
  `system_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  PRIMARY KEY (`system_id`,`game_id`),
  KEY `fk_games_games_idx` (`game_id`),
  CONSTRAINT `FK_SystemsGames_Systems` FOREIGN KEY (`system_id`) REFERENCES `Systems` (`system_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SystemsGames_Games` FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=big5 COLLATE=big5_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SystemsGames`
--

LOCK TABLES `SystemsGames` WRITE;
/*!40000 ALTER TABLE `SystemsGames` DISABLE KEYS */;
INSERT INTO `SystemsGames` VALUES (1,1),(2,2),(3,3),(1,4),(2,4),(3,4);
/*!40000 ALTER TABLE `SystemsGames` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-14  0:13:39
