-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: rocket_mall
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 用戶',6,'add_user'),(22,'Can change 用戶',6,'change_user'),(23,'Can delete 用戶',6,'delete_user'),(24,'Can view 用戶',6,'view_user'),(25,'Can add 用戶地址',7,'add_address'),(26,'Can change 用戶地址',7,'change_address'),(27,'Can delete 用戶地址',7,'delete_address'),(28,'Can view 用戶地址',7,'view_address'),(29,'Can add fb用戶',8,'add_oauthfbuser'),(30,'Can change fb用戶',8,'change_oauthfbuser'),(31,'Can delete fb用戶',8,'delete_oauthfbuser'),(32,'Can view fb用戶',8,'view_oauthfbuser'),(33,'Can add google用戶',9,'add_oauthgoogleuser'),(34,'Can change google用戶',9,'change_oauthgoogleuser'),(35,'Can delete google用戶',9,'delete_oauthgoogleuser'),(36,'Can view google用戶',9,'view_oauthgoogleuser'),(37,'Can add line用戶',10,'add_oauthlineuser'),(38,'Can change line用戶',10,'change_oauthlineuser'),(39,'Can delete line用戶',10,'delete_oauthlineuser'),(40,'Can view line用戶',10,'view_oauthlineuser'),(41,'Can add 行政區',11,'add_area'),(42,'Can change 行政區',11,'change_area'),(43,'Can delete 行政區',11,'delete_area'),(44,'Can view 行政區',11,'view_area'),(45,'Can add 廣告內容類別',12,'add_contentcategory'),(46,'Can change 廣告內容類別',12,'change_contentcategory'),(47,'Can delete 廣告內容類別',12,'delete_contentcategory'),(48,'Can view 廣告內容類別',12,'view_contentcategory'),(49,'Can add 廣告內容',13,'add_content'),(50,'Can change 廣告內容',13,'change_content'),(51,'Can delete 廣告內容',13,'delete_content'),(52,'Can view 廣告內容',13,'view_content'),(53,'Can add 商品類別',14,'add_goodschannelgroup'),(54,'Can change 商品類別',14,'change_goodschannelgroup'),(55,'Can delete 商品類別',14,'delete_goodschannelgroup'),(56,'Can view 商品類別',14,'view_goodschannelgroup'),(57,'Can add 商品類别',15,'add_goodscategory'),(58,'Can change 商品類别',15,'change_goodscategory'),(59,'Can delete 商品類别',15,'delete_goodscategory'),(60,'Can view 商品類别',15,'view_goodscategory'),(61,'Can add 規格選項',16,'add_specificationoption'),(62,'Can change 規格選項',16,'change_specificationoption'),(63,'Can delete 規格選項',16,'delete_specificationoption'),(64,'Can view 規格選項',16,'view_specificationoption'),(65,'Can add 商品頻道',17,'add_goodschannel'),(66,'Can change 商品頻道',17,'change_goodschannel'),(67,'Can delete 商品頻道',17,'delete_goodschannel'),(68,'Can view 商品頻道',17,'view_goodschannel'),(69,'Can add 商品',18,'add_goods'),(70,'Can change 商品',18,'change_goods'),(71,'Can delete 商品',18,'delete_goods'),(72,'Can view 商品',18,'view_goods'),(73,'Can add SKU圖片',19,'add_skuimage'),(74,'Can change SKU圖片',19,'change_skuimage'),(75,'Can delete SKU圖片',19,'delete_skuimage'),(76,'Can view SKU圖片',19,'view_skuimage'),(77,'Can add 商品規格',20,'add_goodsspecification'),(78,'Can change 商品規格',20,'change_goodsspecification'),(79,'Can delete 商品規格',20,'delete_goodsspecification'),(80,'Can view 商品規格',20,'view_goodsspecification'),(81,'Can add SKU規格',21,'add_skuspecification'),(82,'Can change SKU規格',21,'change_skuspecification'),(83,'Can delete SKU規格',21,'delete_skuspecification'),(84,'Can view SKU規格',21,'view_skuspecification'),(85,'Can add 品牌',22,'add_brand'),(86,'Can change 品牌',22,'change_brand'),(87,'Can delete 品牌',22,'delete_brand'),(88,'Can view 品牌',22,'view_brand'),(89,'Can add 商品SKU',23,'add_sku'),(90,'Can change 商品SKU',23,'change_sku'),(91,'Can delete 商品SKU',23,'delete_sku'),(92,'Can view 商品SKU',23,'view_sku'),(93,'Can add 統計分類商品訪問量',24,'add_goodsvisitcount'),(94,'Can change 統計分類商品訪問量',24,'change_goodsvisitcount'),(95,'Can delete 統計分類商品訪問量',24,'delete_goodsvisitcount'),(96,'Can view 統計分類商品訪問量',24,'view_goodsvisitcount'),(97,'Can add 訂單商品',25,'add_ordergoods'),(98,'Can change 訂單商品',25,'change_ordergoods'),(99,'Can delete 訂單商品',25,'delete_ordergoods'),(100,'Can view 訂單商品',25,'view_ordergoods'),(101,'Can add 訂單基本資料',26,'add_orderinfo'),(102,'Can change 訂單基本資料',26,'change_orderinfo'),(103,'Can delete 訂單基本資料',26,'delete_orderinfo'),(104,'Can view 訂單基本資料',26,'view_orderinfo'),(105,'Can add 支付資訊',27,'add_payment'),(106,'Can change 支付資訊',27,'change_payment'),(107,'Can delete 支付資訊',27,'delete_payment'),(108,'Can view 支付資訊',27,'view_payment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_tb_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'areas','area'),(3,'auth','group'),(2,'auth','permission'),(13,'contents','content'),(12,'contents','contentcategory'),(4,'contenttypes','contenttype'),(22,'goods','brand'),(18,'goods','goods'),(15,'goods','goodscategory'),(17,'goods','goodschannel'),(14,'goods','goodschannelgroup'),(20,'goods','goodsspecification'),(24,'goods','goodsvisitcount'),(23,'goods','sku'),(19,'goods','skuimage'),(21,'goods','skuspecification'),(16,'goods','specificationoption'),(8,'oauth','oauthfbuser'),(9,'oauth','oauthgoogleuser'),(10,'oauth','oauthlineuser'),(25,'orders','ordergoods'),(26,'orders','orderinfo'),(27,'payment','payment'),(5,'sessions','session'),(7,'users','address'),(6,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-09-12 05:46:49.003572'),(2,'contenttypes','0002_remove_content_type_name','2020-09-12 05:46:49.027293'),(3,'auth','0001_initial','2020-09-12 05:46:49.057112'),(4,'auth','0002_alter_permission_name_max_length','2020-09-12 05:46:49.114078'),(5,'auth','0003_alter_user_email_max_length','2020-09-12 05:46:49.118810'),(6,'auth','0004_alter_user_username_opts','2020-09-12 05:46:49.124093'),(7,'auth','0005_alter_user_last_login_null','2020-09-12 05:46:49.129353'),(8,'auth','0006_require_contenttypes_0002','2020-09-12 05:46:49.131737'),(9,'auth','0007_alter_validators_add_error_messages','2020-09-12 05:46:49.138899'),(10,'auth','0008_alter_user_username_max_length','2020-09-12 05:46:49.144515'),(11,'auth','0009_alter_user_last_name_max_length','2020-09-12 05:46:49.149449'),(12,'auth','0010_alter_group_name_max_length','2020-09-12 05:46:49.165413'),(13,'auth','0011_update_proxy_permissions','2020-09-12 05:46:49.171256'),(14,'auth','0012_alter_user_first_name_max_length','2020-09-12 05:46:49.175950'),(15,'users','0001_initial','2020-09-12 05:46:49.208646'),(16,'admin','0001_initial','2020-09-12 05:46:49.268569'),(17,'admin','0002_logentry_remove_auto_add','2020-09-12 05:46:49.295014'),(18,'admin','0003_logentry_add_action_flag_choices','2020-09-12 05:46:49.301276'),(19,'areas','0001_initial','2020-09-12 05:46:49.312107'),(20,'oauth','0001_initial','2020-09-12 05:46:49.354774'),(21,'oauth','0002_auto_20200909_0646','2020-09-12 05:46:49.411474'),(22,'sessions','0001_initial','2020-09-12 05:46:49.419565'),(23,'users','0002_user_email_active','2020-09-12 05:46:49.442558'),(24,'users','0003_auto_20200912_1346','2020-09-12 05:46:49.490286'),(26,'goods','0001_initial','2020-09-14 03:34:37.197263'),(28,'goods','0002_auto_20200915_1710','2020-09-15 09:12:37.839580'),(29,'contents','0001_initial','2020-09-16 03:01:09.043555'),(30,'goods','0003_auto_20200916_2122','2020-09-16 13:22:55.987078'),(31,'goods','0004_goodsvisitcount','2020-09-20 11:55:36.441519'),(32,'orders','0001_initial','2020-09-23 13:25:26.113753'),(33,'payment','0001_initial','2020-09-25 08:29:27.706440');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_address`
--

DROP TABLE IF EXISTS `tb_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(20) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `place` varchar(50) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `area_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_address_area_id_e6b3cfb7_fk_tb_areas_id` (`area_id`),
  KEY `tb_address_city_id_bcf28c8d_fk_tb_areas_id` (`city_id`),
  KEY `tb_address_district_id_d2c72fb7_fk_tb_areas_id` (`district_id`),
  KEY `tb_address_user_id_476bb898_fk_tb_user_id` (`user_id`),
  CONSTRAINT `tb_address_area_id_e6b3cfb7_fk_tb_areas_id` FOREIGN KEY (`area_id`) REFERENCES `tb_areas` (`id`),
  CONSTRAINT `tb_address_city_id_bcf28c8d_fk_tb_areas_id` FOREIGN KEY (`city_id`) REFERENCES `tb_areas` (`id`),
  CONSTRAINT `tb_address_district_id_d2c72fb7_fk_tb_areas_id` FOREIGN KEY (`district_id`) REFERENCES `tb_areas` (`id`),
  CONSTRAINT `tb_address_user_id_476bb898_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_address`
--

LOCK TABLES `tb_address` WRITE;
/*!40000 ALTER TABLE `tb_address` DISABLE KEYS */;
INSERT INTO `tb_address` VALUES (10,'2020-09-13 13:30:25.560902','2020-09-13 13:30:25.560993','testuser12','testuser12','0966666667','aidansky0989@gmail.com','翠谷街83巷12號',0,1001,200,222,1),(11,'2020-09-13 13:34:08.405102','2020-09-13 13:34:08.405175','test123','testuser','0966666668','aidan34781@gmail.com','神洲路豐洲里29鄰159號',0,1002,900,429,1),(12,'2020-09-14 00:05:02.171693','2020-09-14 00:05:02.171782','testuser543','testuser543','0966666669','aidan34781@gmail.com','翠谷街83巷10號',0,1001,200,222,1),(13,'2020-09-30 14:37:08.371923','2020-09-30 14:37:08.372037','testuser333','testuser333','0988613235','aidansky0989@gmail.com','神洲路豐洲里29鄰159號',0,1002,900,420,9);
/*!40000 ALTER TABLE `tb_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_areas`
--

DROP TABLE IF EXISTS `tb_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_areas_parent_id_bae67575_fk_tb_areas_id` (`parent_id`),
  CONSTRAINT `tb_areas_parent_id_bae67575_fk_tb_areas_id` FOREIGN KEY (`parent_id`) REFERENCES `tb_areas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2501 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_areas`
--

LOCK TABLES `tb_areas` WRITE;
/*!40000 ALTER TABLE `tb_areas` DISABLE KEYS */;
INSERT INTO `tb_areas` VALUES (100,'台北市',1001),(102,'中正區',100),(103,'大同區',100),(104,'中山區',100),(105,'松山區',100),(106,'大安區',100),(108,'萬華區',100),(110,'信義區',100),(111,'士林區',100),(112,'北投區',100),(114,'內湖區',100),(115,'南港區',100),(116,'文山區',100),(200,'新北市',1001),(201,'信義區',300),(202,'中正區',300),(203,'中山區',300),(204,'安樂區',300),(205,'暖暖區',300),(206,'七堵區',300),(207,'萬里區',200),(208,'金山區',200),(209,'南竿',2400),(210,'北竿',2400),(211,'莒光',2400),(212,'東引',2400),(220,'板橋區',200),(221,'汐止區',200),(222,'深坑區',200),(223,'石碇區',200),(224,'瑞芳區',200),(226,'平溪區',200),(227,'雙溪區',200),(228,'貢寮區',200),(230,'仁愛區',300),(231,'新店區',200),(232,'坪林區',200),(233,'烏來區',200),(234,'永和區',200),(235,'中和區',200),(236,'土城區',200),(237,'三峽區',200),(238,'樹林區',200),(239,'鶯歌區',200),(241,'三重區',200),(242,'新莊區',200),(243,'泰山區',200),(244,'林口區',200),(247,'蘆洲區',200),(248,'五股區',200),(249,'八里區',200),(251,'淡水區',200),(252,'三芝區',200),(253,'石門區',200),(260,'宜蘭',400),(261,'頭城',400),(262,'礁溪',400),(263,'壯圍',400),(264,'員山',400),(265,'羅東',400),(266,'三星',400),(267,'大同',400),(268,'五結',400),(269,'冬山',400),(270,'蘇澳',400),(272,'南澳',400),(290,' 釣魚台列嶼',400),(300,'基隆市',1001),(301,'北區',700),(302,'竹北',600),(303,'湖口',600),(304,'新豐',600),(305,'新埔',600),(306,'關西',600),(307,'芎林',600),(308,'寶山',600),(309,'香山區',700),(310,'竹東',600),(311,'五峰',600),(312,'橫山',600),(313,'尖石',600),(314,'北埔',600),(315,'峨嵋',600),(316,'東區',700),(320,'中壢',500),(324,'平鎮',500),(325,'龍潭',500),(326,'楊梅',500),(327,'新屋',500),(328,'觀音',500),(330,'桃園',500),(333,'龜山',500),(334,'八德',500),(335,'大溪',500),(336,'復興',500),(337,'大園',500),(338,'蘆竹',500),(350,'竹南',800),(351,'頭份',800),(352,'三灣',800),(353,'南庄',800),(354,'獅潭',800),(356,'後龍',800),(357,'通霄',800),(358,'苑裡',800),(360,'苗栗',800),(361,'造橋',800),(362,'頭屋',800),(363,'公館',800),(364,'大湖',800),(365,'泰安',800),(366,'銅鑼',800),(367,'三義',800),(368,'西湖',800),(369,'卓蘭',800),(400,'宜蘭縣',1001),(401,'東區',900),(402,'南區',900),(403,'西區',900),(404,'北區',900),(406,'北屯區',900),(407,'西屯區',900),(408,'南屯區',900),(411,'太平區',900),(412,'大里區',900),(413,'霧峰區',900),(414,'烏日區',900),(420,'豐原區',900),(421,'后里區',900),(422,'石岡區',900),(423,'東勢區',900),(424,'和平區',900),(426,'新社區',900),(427,'潭子區',900),(428,'大雅區',900),(429,'神岡區',900),(432,'大肚區',900),(433,'沙鹿區',900),(434,'龍井區',900),(435,'梧棲區',900),(436,'清水區',900),(437,'大甲區',900),(438,'外埔區',900),(439,'大安區',900),(450,'中區',900),(500,'桃園縣',1001),(502,'芬園',1100),(503,'花壇',1100),(504,'秀水',1100),(505,'鹿港',1100),(506,'福興',1100),(507,'線西',1100),(508,'和美',1100),(509,'伸港',1100),(510,'員林',1100),(511,'社頭',1100),(512,'永靖',1100),(513,'埔心',1100),(514,'溪湖',1100),(515,'大村',1100),(516,'埔鹽',1100),(520,'田中',1100),(521,'北斗',1100),(522,'田尾',1100),(523,'埤頭',1100),(524,'溪州',1100),(525,'竹塘',1100),(526,'二林',1100),(527,'大城',1100),(528,'芳苑',1100),(530,'二水',1100),(540,'南投',1200),(541,'中寮',1200),(542,'草屯',1200),(544,'國姓',1200),(545,'埔里',1200),(546,'仁愛',1200),(551,'名間',1200),(552,'集集',1200),(553,'水里',1200),(555,'魚池',1200),(556,'信義',1200),(557,'竹山',1200),(558,'鹿谷',1200),(570,'彰化',1100),(600,'新竹縣',1001),(602,'番路',1500),(603,'梅山',1500),(604,'竹崎',1500),(605,'阿里山',1500),(606,'中埔',1500),(607,'大埔',1500),(608,'水上',1500),(611,'鹿草',1500),(612,'太保',1500),(613,'朴子',1500),(614,'東石',1500),(615,'六腳',1500),(616,'新港',1500),(621,'民雄',1500),(622,'大林',1500),(623,'溪口',1500),(624,'義竹',1500),(625,'布袋',1500),(630,'斗南',1300),(631,'大埤',1300),(632,'虎尾',1300),(633,'土庫',1300),(634,'褒忠',1300),(635,'東勢',1300),(636,'臺西',1300),(637,'崙背',1300),(638,'麥寮',1300),(640,'斗六',1300),(643,'林內',1300),(646,'古坑',1300),(647,'莿桐',1300),(648,'西螺',1300),(649,'二崙',1300),(651,'北港',1300),(652,'水林',1300),(653,'口湖',1300),(654,'四湖',1300),(655,'元長',1300),(700,'新竹市',1001),(701,'東區',1700),(702,'南區',1700),(703,'西區',1700),(704,'北區',1700),(708,'安平區',1700),(709,'安南區',1700),(710,'永康區',1700),(711,'歸仁區',1700),(712,'新化區',1700),(713,'左鎮區',1700),(714,'玉井區',1700),(715,'楠西區',1700),(716,'南化區',1700),(717,'仁德區',1700),(718,'關廟區',1700),(719,'龍崎區',1700),(720,'官田區',1700),(721,'麻豆區',1700),(722,'佳里區',1700),(723,'西港區',1700),(724,'七股區',1700),(725,'將軍區',1700),(726,'學甲區',1700),(727,'北門區',1700),(730,'新營區',1700),(731,'後壁區',1700),(732,'白河區',1700),(733,'東山區',1700),(734,'六甲區',1700),(735,'下營區',1700),(736,'柳營區',1700),(737,'鹽水區',1700),(741,'善化區',1700),(742,'大內區',1700),(743,'山上區',1700),(744,'新市區',1700),(745,'安定區',1700),(780,'中區',1700),(800,'苗栗縣',1002),(801,'前金區',1900),(802,'芩雅區',1900),(803,'鹽埕區',1900),(804,'鼓山區',1900),(805,'旗津區',1900),(806,'前鎮區',1900),(807,'三民區',1900),(811,'楠梓區',1900),(812,'小港區',1900),(813,'左營區',1900),(814,'仁武區',1900),(815,'大社區',1900),(817,'東沙',2500),(819,'南沙',2500),(820,'岡山區',1900),(821,'路竹區',1900),(822,'阿蓮區',1900),(823,'田寮區',1900),(824,'燕巢區',1900),(825,'橋頭區',1900),(826,'梓官區',1900),(827,'彌陀區',1900),(828,'永安區',1900),(829,'湖內區',1900),(830,'鳳山區',1900),(831,'大寮區',1900),(832,'林園區',1900),(833,'鳥松區',1900),(840,'大樹區',1900),(842,'旗山區',1900),(843,'美濃區',1900),(844,'六龜區',1900),(845,'內門區',1900),(846,'杉林區',1900),(847,'甲仙區',1900),(848,'桃源區',1900),(849,'三民區',1900),(851,'茂林',1900),(852,'茄萣',1900),(873,'新興區',1900),(880,'馬公',2300),(881,'西嶼',2300),(882,'望安',2300),(883,'七美',2300),(884,'白沙',2300),(885,'湖西',2300),(890,'金沙',2400),(891,'金湖',2400),(892,'金寧',2400),(893,'金城',2400),(894,'烈嶼',2400),(896,'烏坵',2400),(900,'台中市',1002),(901,'三地門',2000),(902,'霧臺',2000),(903,'瑪家',2000),(904,'九如',2000),(905,'里港',2000),(906,'高樹',2000),(907,'盬埔',2000),(908,'長治',2000),(909,'麟洛',2000),(911,'竹田',2000),(912,'內埔',2000),(913,'萬丹',2000),(920,'潮州',2000),(921,'泰武',2000),(922,'來義',2000),(923,'萬巒',2000),(924,'崁頂',2000),(925,'新埤',2000),(926,'南州',2000),(927,'林邊',2000),(928,'東港',2000),(929,'琉球',2000),(931,'佳冬',2000),(932,'新園',2000),(940,'枋寮',2000),(941,'枋山',2000),(942,'春日',2000),(943,'獅子',2000),(944,'車城',2000),(945,'牡丹',2000),(946,'恆春',2000),(947,'滿州',2000),(950,'臺東',2100),(951,'綠島',2100),(952,'蘭嶼',2100),(953,'延平',2100),(954,'卑南',2100),(955,'鹿野',2100),(956,'關山',2100),(957,'海端',2100),(958,'池上',2100),(959,'東河',2100),(961,'成功',2100),(962,'長濱',2100),(963,'太麻里',2100),(964,'金峰',2100),(965,'大武',2100),(966,'達仁',2100),(970,'花蓮',2200),(971,'新城',2200),(972,'秀林',2200),(973,'吉安',2200),(974,'壽豐',2200),(975,'鳳林',2200),(976,'光復',2200),(977,'豐濱',2200),(978,'瑞穗',2200),(979,'萬榮',2200),(981,'玉里',2200),(982,'卓溪',2200),(983,'富里',2200),(990,'屏東',2000),(1001,'北部',NULL),(1002,'中部',NULL),(1003,'南部',NULL),(1004,'東部',NULL),(1005,'離島',NULL),(1100,'彰化縣',1002),(1200,'南投縣 ',1002),(1300,'雲林縣',1002),(1400,'嘉義市',1003),(1500,'嘉義縣',1003),(1700,'台南市',1003),(1900,'高雄市',1003),(2000,'屏東縣',1003),(2100,'台東縣',1004),(2200,'花蓮縣',1004),(2300,'澎湖縣 ',1003),(2400,'金門連江',1005),(2500,'南海列嶼',1005);
/*!40000 ALTER TABLE `tb_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_brand`
--

DROP TABLE IF EXISTS `tb_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `first_letter` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_brand`
--

LOCK TABLES `tb_brand` WRITE;
/*!40000 ALTER TABLE `tb_brand` DISABLE KEYS */;
INSERT INTO `tb_brand` VALUES (1,'2018-04-11 15:58:07.692997','2018-04-11 15:58:07.693099','Apple','group1/M00/00/00/rBQAA19h3kOABhaqAAAOI9gL8f0924.jpg','A'),(2,'2018-04-14 03:01:13.193045','2018-04-14 03:01:13.193091','Dell','group1/M00/00/00/rBQAA19h3t6AN_YcAAAj1jrgyWk65.jpeg','D');
/*!40000 ALTER TABLE `tb_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_channel_group`
--

DROP TABLE IF EXISTS `tb_channel_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_channel_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_channel_group`
--

LOCK TABLES `tb_channel_group` WRITE;
/*!40000 ALTER TABLE `tb_channel_group` DISABLE KEYS */;
INSERT INTO `tb_channel_group` VALUES (1,'2018-04-09 09:15:38.057078','2018-04-09 09:15:38.057150','手機數碼'),(2,'2018-04-09 09:17:29.097657','2018-04-09 09:17:29.097706','電腦家電'),(3,'2018-04-09 09:17:45.065222','2018-04-09 09:17:45.065264','家居家裝'),(4,'2018-04-09 09:18:10.865628','2018-04-09 09:18:10.865669','男女童裝'),(5,'2018-04-09 09:18:26.508512','2018-04-09 09:18:26.508581','女鞋箱包'),(6,'2018-04-09 09:18:44.054270','2018-04-09 09:18:44.054322','運動戶外'),(7,'2018-04-09 09:19:17.539464','2018-04-09 09:19:17.539538','情趣護理'),(8,'2018-04-09 09:19:17.539464','2018-04-09 09:19:27.460744','婦幼專區'),(9,'2018-04-09 09:19:40.863343','2018-04-09 09:19:40.863387','食品生鮮'),(10,'2018-04-09 09:19:50.561302','2018-04-09 09:19:50.561364','圖書音像'),(11,'2018-04-09 09:20:01.493344','2018-04-09 09:20:01.493495','旅遊生活');
/*!40000 ALTER TABLE `tb_channel_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_content`
--

DROP TABLE IF EXISTS `tb_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url` varchar(300) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `text` longtext,
  `sequence` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_content_category_id_c6e5ac73_fk_tb_content_category_id` (`category_id`),
  CONSTRAINT `tb_content_category_id_c6e5ac73_fk_tb_content_category_id` FOREIGN KEY (`category_id`) REFERENCES `tb_content_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_content`
--

LOCK TABLES `tb_content` WRITE;
/*!40000 ALTER TABLE `tb_content` DISABLE KEYS */;
INSERT INTO `tb_content` VALUES (1,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','女神約會穿搭','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gi-eABdspAAFe6Ctxh9s818.jpg','',1,1,1),(2,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','銀行刷卡優惠','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gjB6ANq7pAAFnjKcd_1Y230.jpg','',2,1,1),(3,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','我的風格家','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gjD2APy7XAAQ9ffJ9Id4311.jpg','',3,1,1),(4,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','廚神的料理神器','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gjF-AB4lCAAJg2x7xBzc654.jpg','',4,1,1),(5,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','迎接開學季 新學期必買3折UP ','http://www.rocketmall.gq','','',1,1,2),(6,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','超級品牌日 DR.WU領券折200 ','http://www.rocketmall.gq','','',2,1,2),(7,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','MacBookPro LinePay導購立折10% ','http://www.rocketmall.gq','','',3,1,2),(8,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','RockeT免運券限時開搶 ','http://www.rocketmall.gq','','',4,1,2),(9,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','防疫新生活 口罩超取9折 ','http://www.rocketmall.gq','','',5,1,2),(10,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','中秋團圓GO 生鮮零食滿800減200 ','http://www.rocketmall.gq','','',6,1,2),(11,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','電競巔峰24H 三倍券買筆電折9999 ','http://www.rocketmall.gq','','',7,1,2),(12,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','ZOLARO','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19hXAeAHQNFAAAbxEBO_Ss131.jpg ','',1,1,3),(14,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','國際風尚 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gjKGAPlufAABP9Sy7ejM576.jpg','',1,1,5),(15,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','內衣','http://www.rocketmall.gq','','',1,1,6),(16,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','男裝','http://www.rocketmall.gq','','',2,1,6),(17,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','女裝','http://www.rocketmall.gq','','',3,1,6),(18,'2020-09-15 13:34:08.405102','2018-04-09 17:02:47.086983','童裝','http://www.rocketmall.gq','','',4,1,6),(19,'2018-04-09 17:03:06.144946','2018-04-09 17:03:06.144990','襯衫','http://www.rocketmall.gq','','',1,1,7),(20,'2018-04-09 17:03:23.268285','2018-04-09 17:03:23.268333','西裝','http://www.rocketmall.gq','','',2,1,7),(21,'2018-04-09 17:03:36.403398','2018-04-09 17:03:36.403463','休閒褲','http://www.rocketmall.gq','','',3,1,7),(22,'2018-04-09 17:03:54.000395','2018-04-09 17:03:54.000460','牛仔褲','http://www.rocketmall.gq','','',4,1,7),(23,'2018-04-09 17:04:12.517924','2018-04-09 17:04:12.517972','針織衫','http://www.rocketmall.gq','','',5,1,7),(24,'2018-04-09 17:04:29.338056','2018-04-09 17:04:29.338132','女士內衣','http://www.rocketmall.gq','','',6,1,7),(25,'2018-04-09 17:04:45.403852','2018-04-09 17:04:45.403917','男士背心','http://www.rocketmall.gq','','',7,1,7),(26,'2018-04-09 17:04:58.159270','2018-04-09 17:04:58.159321','T恤','http://www.rocketmall.gq','','',8,1,7),(27,'2018-04-09 17:05:14.234438','2018-04-09 17:05:14.234482','睡衣褲','http://www.rocketmall.gq','','',9,1,7),(28,'2018-04-10 08:51:33.422870','2018-04-10 08:51:33.422915','俞兆林 長袖襯衫男士純色商務休閒正裝','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdJaAZI3ZAAARhQ15WOA76.jpeg ','$415',1,1,8),(29,'2018-04-10 08:52:50.280197','2018-04-10 08:52:50.280243','法國KJ無肩帶文胸隱形防滑無鋼圈內衣上托側收一字肩加厚小胸平胸聚攏性感防走光抹胸婚紗禮服胸罩 膚色 75B=34B(單件文胸)','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdNyAYnDHAAAU4_xVpHk86.jpeg ','$660',2,1,8),(30,'2018-04-10 08:56:33.016220','2018-04-10 09:16:59.298002','都市麗人刺繡無鋼圈文胸性感蕾絲聚攏女士胸罩內衣2B6513黑色70B ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdPmABzygAAAOUwCkf5M88.jpeg ','$355',3,1,8),(31,'2018-04-10 08:57:52.744863','2018-04-10 09:18:36.211831','黛天麗 聚攏文胸內衣女 無鋼圈小胸蕾絲調整型胸罩性感胸罩內衣 綠色(單文胸) 36B=80B','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdRSAEuNWAAAOzhRODZs05.jpeg ','$290',4,1,8),(32,'2018-04-10 08:59:19.379261','2018-04-10 09:20:59.490599','朗曼倫夾克男2020春秋新款外套男韓版修身男裝秋冬季男士牛仔休閒衣服','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdT2ANvedAAAPUqL1mQc24.jpeg\n','$660',5,1,8),(33,'2018-04-10 09:19:52.078636','2018-04-10 09:21:15.251997','翠雅閣 小白鞋女夏季新款2020韓版休閒鞋女學生百搭平底板鞋女繫帶皮面女鞋 白色-比心 37\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdVaAMZ0JAAAKyp5TIdc77.jpeg ','$370',6,1,8),(34,'2018-04-10 09:20:43.322594','2018-04-10 09:21:08.660170','布彥西服男2020新款男士休閒西裝潮流帥氣商務小西裝男韓版修身青年秋季外套單西純色上衣套裝 黑色單西 M\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdWyAOXGiAAAO63nMjMo28.jpeg ','$1080',7,1,8),(35,'2018-04-10 09:22:14.074590','2018-04-10 09:22:14.074656','BOYXCO 毛衣男2020秋冬新款針織衫男士元領套頭打底衫潮流毛線衣','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdZiAUDWNAAARee857Jg47.jpeg ','$415',8,1,8),(36,'2018-04-10 09:22:52.988391','2018-04-10 09:22:52.988518','離梢黑暗系風衣男2020秋季新款中長款韓版復古老外套過膝早秋大衣','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gda6AVMQfAAAPyN5qmo437.jpeg\n','$790',9,1,8),(37,'2018-04-10 09:23:26.963050','2018-04-10 09:23:26.963128','女外套新款2019駝色寬鬆羊絨大衣女短款小個子毛呢外套學院風 駝色 XL ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdcuAVX9KAAARDIHOOFo75.jpeg ','$400',10,1,8),(38,'2018-04-10 09:29:30.877589','2018-04-10 09:29:30.877630','俞兆林 長袖襯衫男士純色商務休閒正裝','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdJaAZI3ZAAARhQ15WOA76.jpeg ','$415',1,1,10),(39,'2018-04-10 09:29:59.145437','2018-04-10 09:29:59.145821','法國KJ無肩帶文胸隱形防滑無鋼圈內衣上托側收一字肩加厚小胸平胸聚攏性感防走光抹胸婚紗禮服胸罩 膚色 75B=34B(單件文胸)\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdNyAYnDHAAAU4_xVpHk86.jpeg ','$660',2,1,10),(40,'2018-04-10 09:30:29.868913','2018-04-10 09:30:29.868969','都市麗人刺繡無鋼圈文胸性感蕾絲聚攏女士胸罩內衣2B6513黑色70B','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdPmABzygAAAOUwCkf5M88.jpeg ','$355',3,1,10),(41,'2018-04-10 09:31:07.855868','2018-04-10 09:31:07.855915','黛天麗 聚攏文胸內衣女 無鋼圈小胸蕾絲調整型胸罩性感胸罩內衣 綠色(單文胸) 36B=80B','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdRSAEuNWAAAOzhRODZs05.jpeg ','$290',4,1,10),(42,'2018-04-10 09:31:42.980397','2018-04-10 09:31:42.980445','朗曼倫夾克男2020春秋新款外套男韓版修身男裝秋冬季男士牛仔休閒衣服','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdT2ANvedAAAPUqL1mQc24.jpeg\n','$660',5,1,10),(43,'2018-04-10 09:34:08.867671','2018-04-10 09:34:08.867712','翠雅閣 小白鞋女夏季新款2020韓版休閒鞋女學生百搭平底板鞋女繫帶皮面女鞋 白色-比心 37','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdVaAMZ0JAAAKyp5TIdc77.jpeg ','$370',6,1,10),(44,'2018-04-10 09:35:12.710916','2018-04-10 09:35:12.710989','布彥西服男2020新款男士休閒西裝潮流帥氣商務小西裝男韓版修身青年秋季外套單西純色上衣套裝 黑色單西 M ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdWyAOXGiAAAO63nMjMo28.jpeg ','$1080',7,1,10),(45,'2018-04-10 09:35:42.251919','2018-04-10 09:35:42.251963','BOYXCO 毛衣男2020秋冬新款針織衫男士元領套頭打底衫潮流毛線衣','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdZiAUDWNAAARee857Jg47.jpeg ','$415',8,1,10),(46,'2018-04-10 09:36:12.028644','2018-04-10 09:36:12.028685','離梢黑暗系風衣男2020秋季新款中長款韓版復古老外套過膝早秋大衣\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gda6AVMQfAAAPyN5qmo437.jpeg\n','$790',9,1,10),(47,'2018-04-10 09:36:36.804759','2018-04-10 09:36:36.804804','女外套新款2019駝色寬鬆羊絨大衣女短款小個子毛呢外套學院風 駝色 XL\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdcuAVX9KAAARDIHOOFo75.jpeg ','$400',10,1,10),(48,'2018-04-10 09:38:59.226650','2018-04-10 09:38:59.226695','俞兆林 長袖襯衫男士純色商務休閒正裝\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdJaAZI3ZAAARhQ15WOA76.jpeg ','$415',1,1,11),(49,'2018-04-10 09:39:32.483523','2018-04-10 09:39:32.483585','法國KJ無肩帶文胸隱形防滑無鋼圈內衣上托側收一字肩加厚小胸平胸聚攏性感防走光抹胸婚紗禮服胸罩 膚色 75B=34B(單件文胸)\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdNyAYnDHAAAU4_xVpHk86.jpeg ','$660',2,1,11),(50,'2018-04-10 09:40:08.968290','2018-04-10 09:40:08.968367','都市麗人刺繡無鋼圈文胸性感蕾絲聚攏女士胸罩內衣2B6513黑色70B\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdPmABzygAAAOUwCkf5M88.jpeg ','$355',4,1,11),(51,'2018-04-10 09:40:40.405191','2018-04-10 09:40:40.405231','黛天麗 聚攏文胸內衣女 無鋼圈小胸蕾絲調整型胸罩性感胸罩內衣 綠色(單文胸) 36B=80B 64G','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdRSAEuNWAAAOzhRODZs05.jpeg ','$290',5,1,11),(52,'2018-04-10 09:42:15.130337','2018-04-10 09:42:15.130419','朗曼倫夾克男2020春秋新款外套男韓版修身男裝秋冬季男士牛仔休閒衣服\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdT2ANvedAAAPUqL1mQc24.jpeg\n','$660',6,1,11),(53,'2018-04-10 09:43:07.486074','2018-04-10 09:43:07.486118','翠雅閣 小白鞋女夏季新款2020韓版休閒鞋女學生百搭平底板鞋女繫帶皮面女鞋 白色-比心 37\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdVaAMZ0JAAAKyp5TIdc77.jpeg ','$370',7,1,11),(54,'2018-04-10 09:43:38.901332','2018-04-10 09:43:38.901374','布彥西服男2020新款男士休閒西裝潮流帥氣商務小西裝男韓版修身青年秋季外套單西純色上衣套裝 黑色單西 M\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdWyAOXGiAAAO63nMjMo28.jpeg ','$1080',8,1,11),(55,'2018-04-10 09:44:39.359738','2018-04-10 09:44:39.359783','BOYXCO 毛衣男2020秋冬新款針織衫男士元領套頭打底衫潮流毛線衣\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gdZiAUDWNAAARee857Jg47.jpeg ','$415',9,1,11),(56,'2018-04-10 09:45:17.804328','2018-04-10 09:45:17.804368','離梢黑暗系風衣男2020秋季新款中長款韓版復古老外套過膝早秋大衣\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gda6AVMQfAAAPyN5qmo437.jpeg\n','$790',10,1,11),(57,'2018-04-10 09:58:35.242596','2018-04-10 09:58:35.242654','Apple iPhone 11 (A2223) 128GB 白色 雙卡雙待 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19grjKAHNFyAAAOThFiSzc62.jpeg','$24800',1,1,16),(58,'2018-04-10 09:59:16.706582','2018-04-10 09:59:16.706628','Apple iPhone 11 Pro Max (A2220) 64GB 暗夜綠色 雙卡雙待','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19grmiAYyydAAALDWaNqGI46.jpeg','$40300',2,1,16),(59,'2018-04-11 06:39:11.953183','2018-04-11 06:39:11.953229','Apple iPhone 11 Pro (A2217) 64GB 深空灰色 雙卡雙待','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19grpCAAnk6AAAJoBB7xfg12.jpeg','$36500',3,1,16),(60,'2018-04-11 06:40:29.270078','2018-04-11 06:40:29.270123','Apple iPhone XS (A2100) 256GB 深空灰色','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19grsCACOykAAAPWHtKxz088.jpeg','$22700',4,1,16),(61,'2018-04-11 06:41:03.054344','2018-04-11 06:41:03.054390','Apple iPhone XR (A2108) 64GB 藍色 雙卡雙待','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19grviATiMzAAAL4ATP7yM22.jpeg','$18300',5,1,16),(62,'2018-04-11 06:42:11.402524','2018-04-11 06:42:11.402782','三星 Galaxy S20 5G (SM-G9810)雙模5G 驍龍865 120Hz超感屏 8K視頻 遊戲手機 12GB+128GB 浮氧藍','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gryaAfYW4AAANYDw3mCM97.jpeg','$29200',6,1,16),(63,'2018-04-11 06:42:47.985726','2018-04-11 06:42:47.985771','三星Galaxy Note10+ 5G 手機 莫奈彩 全網通 (12GB RAM+256GB ROM)\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gr2GAa8NwAAAQkEPklmM09.jpeg','$25600',7,1,16),(64,'2018-04-11 06:43:19.285413','2018-04-11 06:43:19.285477','三星 Galaxy A51 5G 雙模5G Super AMOLED屏 4800萬後置四攝 3200萬前置 雙卡雙待手機 8GB+128GB落英粉','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gr5qAZbNwAAALgGTtJBM22.jpeg','$10900',8,1,16),(65,'2018-04-11 06:43:59.651504','2018-04-11 06:43:59.651581','三星 Galaxy Z Flip 5G（SM-F7070） 折疊屏手機 雙模5G 驍龍865+ 8GB+256GB 迷霧金','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gr8mAOvpIAAAI1Ul-1sk66.jpeg','$52500',9,1,16),(66,'2018-04-11 06:44:29.649982','2018-04-11 06:44:29.650036','Galaxy S20+ 5G BTS定製版 雙模5G 驍龍865 120Hz超感屏 8K視頻 遊戲手機 12GB+128GB 小王紫 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsC6ALwsCAAAMHTdDyUw35.jpeg','$35300',10,1,16),(67,'2018-04-11 06:46:32.465443','2018-04-11 06:46:32.465515','Apple 2020新款 MacBook Pro 13.3【帶Touchbar】十代i5 16G 512G 2.0GHz 深空灰 筆記本電腦 輕薄本 MWP42CH/A ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsIyAO1WHAAALI6KTN1A53.jpeg','$60900',1,1,18),(68,'2018-04-11 06:47:11.689035','2018-04-11 06:47:11.689102','Apple 2020新款 MacBook Air 13.3 Retina屏 十代i5 8G 512G SSD 深空灰 筆記本電腦 輕薄本 MVH22CH/A ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsKyARJy7AAAKKVD3FbA90.jpeg','$42000',2,1,18),(69,'2018-04-11 06:48:08.629095','2018-04-11 06:48:08.629138','Apple 2019款 MacBook Pro 16 九代i7 16G 512G 深空灰 RP5300M顯卡 筆記本電腦 輕薄本 MVVJ2CH/A ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsNWAGbT0AAAKykkxHMg04.jpeg','$75600',3,1,18),(70,'2018-04-11 06:48:34.571822','2018-04-11 06:48:34.571868','ROG G14 輕薄商務辦公設計師14英寸2K屏筆記本電腦(銳龍R7-4800HS 8核 7nm 16G 512GSSD RTX2060MaxQ)經典黑 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsPeAVxV_AAANIzdpizU12.jpeg','$42000',4,1,18),(71,'2018-04-11 06:49:16.497815','2018-04-26 12:46:17.580482','ROG A15 15.6英寸240Hz電競屏高色域輕薄便攜遊戲本筆記本電腦（R9-4900HS 8核7nm 16G 1TSSD RTX2060MaxQ） ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsPeAVxV_AAANIzdpizU12.jpeg','$42000',5,1,18),(72,'2018-04-11 06:49:49.839309','2018-04-11 06:49:49.839349','聯想ThinkPad T14 2020款(04CD)14英寸 7納米八核 高性能 全面屏 筆記本電腦(R7 PRO-4750U 16G 512G) ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsW2AEoz3AAAIAWFAfDY64.jpeg','$25200',6,1,18),(73,'2018-04-11 06:50:19.092920','2018-04-11 06:50:19.093006','聯想ThinkPad X1 Carbon 2020(05CD)英特爾酷睿i5 14英寸輕薄筆記本電腦(i5-10210U 16G 512GSSD FHD)沉浸黑 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsZiAI_xdAAAKNxNsYsk73.jpeg','$42000',7,1,18),(74,'2018-04-11 06:50:41.252312','2018-04-11 06:50:41.252453','戴爾DELL XPS13-7390 13.3英寸英特爾酷睿i7超輕薄商務辦公輕奢筆記本電腦(i7-10210U 8G 512GSSD 高色域)銀 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gseSAAt7OAAAMzIAqTTU50.jpeg','$37300',8,1,18),(75,'2018-04-11 06:51:12.922333','2018-04-11 06:51:12.922378','戴爾DELL XPS15-9500 15.6英寸英特爾酷睿i7 2020新款防藍光全面屏設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)銀 送兩年碎屏保 ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsgaAQ8oqAAAJCLH0YAk01.jpeg','$67200',9,1,18),(76,'2018-04-11 06:51:40.271373','2018-04-11 06:51:40.271422','微星(msi) GL75 17.3英寸遊戲筆記本電腦(十代i7 16G 512G SSD RTX2060 144Hz 高色域) ','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsiWALMtcAAASwjJRA4g05.jpeg','$40800',10,1,18),(77,'2018-04-11 06:53:31.774835','2018-04-11 06:53:31.774982','3C館','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gjPaAfe_AAAA3MIvKxQw458.jpg ','',1,1,13),(78,'2018-04-11 06:53:46.540973','2018-04-11 06:53:46.541041','手機','http://www.rocketmall.gq','','',1,1,14),(79,'2018-04-11 06:54:00.356620','2018-04-11 06:54:00.356669','遊戲機','http://www.rocketmall.gq','','',2,1,14),(80,'2018-04-11 06:54:11.361324','2018-04-11 06:54:11.361367','藍芽耳機','http://www.rocketmall.gq','','',3,1,14),(81,'2018-04-11 06:54:21.777505','2018-04-11 06:54:21.777549','筆電','http://www.rocketmall.gq','','',4,1,14),(82,'2018-04-11 06:54:36.170021','2018-04-11 06:54:36.170082','遊戲手機','http://www.rocketmall.gq','','',1,1,15),(83,'2018-04-11 06:54:50.484452','2018-04-11 06:54:50.484499','平板電腦','http://www.rocketmall.gq','','',2,1,15),(84,'2018-04-11 06:55:11.333884','2018-04-11 06:55:11.333934','手機殼','http://www.rocketmall.gq','','',3,1,15),(85,'2018-04-11 06:55:31.975211','2018-04-11 06:55:31.975285','充電線','http://www.rocketmall.gq','','',4,1,15),(86,'2018-04-11 06:55:43.070748','2018-04-11 06:55:43.070796','行動電源','http://www.rocketmall.gq','','',5,1,15),(87,'2018-04-11 06:55:57.563944','2018-04-11 06:55:57.563999','單眼相機','http://www.rocketmall.gq','','',6,1,15),(88,'2018-04-11 06:56:14.604570','2018-04-11 06:56:14.604661','音箱','http://www.rocketmall.gq','','',7,1,15),(89,'2018-04-11 06:56:25.639226','2018-04-11 06:56:25.639271','無線滑鼠','http://www.rocketmall.gq','','',8,1,15),(90,'2018-04-11 06:56:34.836303','2018-04-11 06:56:34.836374','手機支架','http://www.rocketmall.gq','','',9,1,15),(91,'2018-04-11 06:56:58.113652','2018-04-11 06:56:58.113703','家居生活','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gksKAHnTJAABUUiDYsrQ237.jpg ','',1,1,21),(92,'2018-04-11 06:57:13.215501','2018-04-11 06:57:13.215548','生活日用','http://www.rocketmall.gq','','',1,1,22),(93,'2018-04-11 06:57:30.689560','2018-04-11 06:57:30.689647','家居布置','http://www.rocketmall.gq','','',2,1,22),(94,'2018-04-11 06:57:50.983438','2018-04-11 06:57:50.983481','烹飪鍋具','http://www.rocketmall.gq','','',3,1,22),(95,'2018-04-11 06:58:03.324082','2018-04-11 06:58:03.324128','床單被套','http://www.rocketmall.gq','','',1,1,23),(96,'2018-04-11 06:58:13.694750','2018-04-11 06:58:13.694795','毛巾浴巾','http://www.rocketmall.gq','','',2,1,23),(97,'2018-04-11 06:58:31.412903','2018-04-11 06:58:31.412949','沙發','http://www.rocketmall.gq','','',3,1,23),(98,'2018-04-11 06:58:52.598947','2018-04-11 06:58:52.598992','書桌','http://www.rocketmall.gq','','',4,1,23),(99,'2018-04-11 06:59:07.562439','2018-04-11 06:59:07.562541','炒鍋電鍋','http://www.rocketmall.gq','','',5,1,23),(100,'2018-04-11 06:59:24.628095','2018-04-11 06:59:24.628162','整套鍋具','http://www.rocketmall.gq','','',6,1,23),(101,'2018-04-11 06:59:37.707050','2018-04-11 06:59:37.707098','保溫杯','http://www.rocketmall.gq','','',7,1,23),(102,'2018-04-11 06:59:48.635658','2018-04-11 06:59:48.635707','咖啡機','http://www.rocketmall.gq','','',8,1,23),(103,'2018-04-11 06:59:57.465653','2018-04-11 06:59:57.465696','收納用品','http://www.rocketmall.gq','','',9,1,23),(104,'2018-04-11 07:02:03.780376','2018-04-11 07:02:03.780419','雅高 抹布 廚房魔力去污布 5片裝 加厚雙面洗碗布多功能百潔布\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv22AeRuvAAAM9XQA5NE92.jpeg ','$50',1,1,24),(105,'2018-04-11 07:02:46.547111','2018-04-11 07:02:46.547187','妙潔 海綿百潔布 洗碗棉 一般廚具 四色分用 8片裝','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv52AdsIlAAAJBbefDzU79.jpeg ','$63',2,1,24),(106,'2018-04-11 07:03:18.325791','2018-04-11 07:03:18.325869','妙潔八層疏油洗碗布 去油抹布清潔纖維巾廚房擦地桌子玻璃杯乾淨不掉毛用工具 3片裝\n','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv-uATguGAAASzbGjMX822.jpeg ','$44',3,1,24),(107,'2018-04-11 07:04:04.509724','2018-04-11 07:04:04.509770','品沐 多功能切刨絲器 廚房切菜器切絲切菜神器家用擦絲器切片器瀝水水瓢 ins北歐風深藍色AA074','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwCGAOclRAAAOvvw5A1Q77.jpeg ','$90',4,1,24),(108,'2018-04-11 07:04:34.799452','2018-04-11 07:04:34.799494','傾樂 免打孔不銹鋼鍋蓋砧板架 U型壁掛式廚房置物架1對 菜板架案板炒菜平底鍋廚房收納架','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwC6AOG6LAAAOAPyxE8U74.jpeg ','$121',5,1,24),(109,'2018-04-11 07:05:10.845016','2018-04-11 07:05:10.845072','拜傑多功能不銹鋼碗夾盤夾 防燙提盤碟夾砂鍋夾','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwDiAZStKAAAOQo5Rl8k94.jpeg ','$55',6,1,24),(110,'2018-04-11 07:05:41.147138','2018-04-11 07:05:41.147210','美之扣 切菜神器多功能切丁土豆絲切絲器刨絲器家用土豆片切片廚房用品擦絲器 灰色','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsZiAI_xdAAAKNxNsYsk73.jpeg ','$265',7,1,24),(111,'2018-04-11 07:06:12.674584','2018-04-11 07:06:12.674634','維艾 不銹鋼盆子五件套裝加厚家用廚房打蛋和麵淘米洗菜瀝水籃漏湯盆加大款','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwEqAc3-fAAANTe9julk51.jpeg ','$330',8,1,24),(112,'2018-04-11 07:06:54.675238','2018-04-11 07:06:54.675282','吉睿 廚房DIY/小工具 廚寶系列 304不銹鋼大號滷肉調料過濾隔渣篩網鹵料球','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19hWU6AClFtAAAJKGbYb8E23.jpeg ','$45',9,1,24),(113,'2018-04-11 07:07:29.946108','2018-04-11 07:07:29.946151','美廚 削皮刀削皮器 不銹鋼刨刀瓜刨刮皮刀 蔬菜水果刀','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwGuALomrAAAHQ4zwkdc35.jpeg ','$53',10,1,24),(114,'2018-04-11 07:09:57.168028','2018-04-11 07:09:57.168075','雅高 抹布 廚房魔力去污布 5片裝 加厚雙面洗碗布多功能百潔布','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv22AeRuvAAAM9XQA5NE92.jpeg ','$50',1,1,25),(115,'2018-04-11 07:10:32.939492','2018-04-11 07:10:32.939538','妙潔 海綿百潔布 洗碗棉 一般廚具 四色分用 8片裝','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv52AdsIlAAAJBbefDzU79.jpeg ','$63',2,1,25),(116,'2018-04-11 07:11:13.792342','2018-04-11 07:11:13.792386','妙潔八層疏油洗碗布 去油抹布清潔纖維巾廚房擦地桌子玻璃杯乾淨不掉毛用工具 3片裝','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gv-uATguGAAASzbGjMX822.jpeg ','$44',3,1,25),(117,'2018-04-11 07:12:01.447582','2018-04-11 07:12:01.447628','品沐 多功能切刨絲器 廚房切菜器切絲切菜神器家用擦絲器切片器瀝水水瓢 ins北歐風深藍色','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwCGAOclRAAAOvvw5A1Q77.jpeg ','$90',4,1,25),(118,'2018-04-11 07:12:34.001525','2018-04-11 07:12:34.001609','傾樂 免打孔不銹鋼鍋蓋砧板架 U型壁掛式廚房置物架1對 菜板架案板炒菜平底鍋廚房收納架','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwC6AOG6LAAAOAPyxE8U74.jpeg ','$121',5,1,25),(119,'2018-04-11 07:13:17.630873','2018-04-11 07:13:17.630916','拜傑多功能不銹鋼碗夾盤夾 防燙提盤碟夾砂鍋夾','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwDiAZStKAAAOQo5Rl8k94.jpeg ','$55',6,1,25),(120,'2018-04-11 07:13:45.655300','2018-04-11 07:13:45.655340','美之扣 切菜神器多功能切丁土豆絲切絲器刨絲器家用土豆片切片廚房用品擦絲器 灰色','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gsZiAI_xdAAAKNxNsYsk73.jpeg ','$265',7,1,25),(121,'2018-04-11 07:14:11.876255','2018-04-11 07:14:11.876328','維艾 不銹鋼盆子五件套裝加厚家用廚房打蛋和麵淘米洗菜瀝水籃漏湯盆加大款','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwEqAc3-fAAANTe9julk51.jpeg ','$330',8,1,25),(122,'2018-04-11 07:14:42.828364','2018-04-11 07:14:42.828410','吉睿 廚房DIY/小工具 廚寶系列 304不銹鋼大號滷肉調料過濾隔渣篩網鹵料球','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19hWU6AClFtAAAJKGbYb8E23.jpeg ','$45',9,1,25),(123,'2018-04-11 07:15:11.019433','2018-04-11 07:15:11.019475','美廚 削皮刀削皮器 不銹鋼刨刀瓜刨刮皮刀 蔬菜水果刀','http://www.rocketmall.gq','group1/M00/00/00/rBQAA19gwGuALomrAAAHQ4zwkdc35.jpeg ','$53 ',10,1,25);
/*!40000 ALTER TABLE `tb_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_content_category`
--

DROP TABLE IF EXISTS `tb_content_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_content_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(50) NOT NULL,
  `key` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_content_category`
--

LOCK TABLES `tb_content_category` WRITE;
/*!40000 ALTER TABLE `tb_content_category` DISABLE KEYS */;
INSERT INTO `tb_content_category` VALUES (1,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','輪播圖','index_lbt'),(2,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','新人大禮包','index_kx'),(3,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','頁首小廣告','index_ytgg'),(5,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','國際風尚Logo','index_1f_logo'),(6,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','國際風尚頻道','index_1f_pd'),(7,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','國際風尚標籤','index_1f_bq'),(8,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','風尚穿搭','index_1f_ssxp'),(10,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','男裝女裝','index_1f_njnj'),(11,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','熱銷必買','index_1f_zsbm'),(13,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','3C館Logo','index_2f_logo'),(14,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','3C館頻道','index_2f_pd'),(15,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','3C館標籤','index_2f_bq'),(16,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','手機推薦','index_2f_sjtj'),(18,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','筆記型電腦','index_2f_nb'),(21,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','家居生活Logo','index_3f_logo'),(22,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','家居生活頻道','index_3f_pd'),(23,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','家居生活標籤','index_3f_bq'),(24,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','生活用品','index_3f_shyp'),(25,'2020-09-15 13:34:08.405102','2020-09-15 13:34:08.405102','廚房用品','index_3f_cfyp');
/*!40000 ALTER TABLE `tb_content_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_fb_user`
--

DROP TABLE IF EXISTS `tb_fb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_fb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `name` varchar(50) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`),
  KEY `tb_fb_user_user_id_d8356573_fk_tb_user_id` (`user_id`),
  CONSTRAINT `tb_fb_user_user_id_d8356573_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_fb_user`
--

LOCK TABLES `tb_fb_user` WRITE;
/*!40000 ALTER TABLE `tb_fb_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_fb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_goods`
--

DROP TABLE IF EXISTS `tb_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sales` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `desc_detail` longtext NOT NULL,
  `desc_pack` longtext NOT NULL,
  `desc_service` longtext NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category1_id` int(11) NOT NULL,
  `category2_id` int(11) NOT NULL,
  `category3_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_goods_category1_id_49c4fab9_fk_tb_goods_category_id` (`category1_id`),
  KEY `tb_goods_category2_id_ea351ced_fk_tb_goods_category_id` (`category2_id`),
  KEY `tb_goods_category3_id_d3ea8415_fk_tb_goods_category_id` (`category3_id`),
  KEY `tb_goods_brand_id_5c5be571_fk_tb_brand_id` (`brand_id`),
  CONSTRAINT `tb_goods_brand_id_5c5be571_fk_tb_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `tb_brand` (`id`),
  CONSTRAINT `tb_goods_category1_id_49c4fab9_fk_tb_goods_category_id` FOREIGN KEY (`category1_id`) REFERENCES `tb_goods_category` (`id`),
  CONSTRAINT `tb_goods_category2_id_ea351ced_fk_tb_goods_category_id` FOREIGN KEY (`category2_id`) REFERENCES `tb_goods_category` (`id`),
  CONSTRAINT `tb_goods_category3_id_d3ea8415_fk_tb_goods_category_id` FOREIGN KEY (`category3_id`) REFERENCES `tb_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_goods`
--

LOCK TABLES `tb_goods` WRITE;
/*!40000 ALTER TABLE `tb_goods` DISABLE KEYS */;
INSERT INTO `tb_goods` VALUES (1,'2018-04-11 16:01:28.547507','2020-09-30 13:50:10.820368','Apple MacBook Pro 筆記型',3603,15498,'<h1 style=\\\"text-align:center\\\">MacBook Pro 您最得力的助手</h1><p>它纖薄如刃，輕盈如羽，卻又比以往速度更快、性能更強大。它為你展現的，是迄今最明亮、最多彩的 Mac 筆記型顯示屏。它更配備了觸控欄，一個內置於鍵盤的玻璃面多點觸控條，讓你能在需要時快速取用各種工具。MacBook Pro 是對我們突破性理念的一場出色演繹，而它，也正期待著演繹你的奇思妙想。</p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/00/rBQAA19h95yANSvrAAAKSxJ0Vzg673.jpg\\\" style=\\\"height:360px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/00/rBQAA19h98OAVL7vAAAEdutygTY264.jpg\\\" style=\\\"height:1858px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/00/rBQAA19h9-SAB4jVAAAL98S702s178.jpg\\\" style=\\\"height:2271px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/00/rBQAA19h-AKAb6tWAAADoLh6boM299.jpg\\\" style=\\\"height:1776px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/00/rBQAA19h-CGAH1oJAAAHq1rHy5I968.jpg\\\" style=\\\"height:1667px; width:750px\\\" /></p>','<h2>包裝清單</h2><p>MacBook Air 電源適配器 交流電源插頭 電源線</p>','<p>&nbsp;<strong>廠家服務</strong></p><p>本產品全國維修，享受服務，保固為：一年保固<br />如因品質問題或故障，憑廠商維修中心或特約維修點的品質檢測證明，享受7日內退貨，15日內換貨，15日以上在保固內享受免費保固等服務！<br />(注:如廠家在商品介紹中有售後保障的說明,則此商品按照廠家說明執行售後保障服務。) 您可以查詢本品牌在各地售後服務中心的聯絡方式，<a href=\"http://www.apple.com/tw/\" target=\\\"_blank\\\">請點擊查詢......</a><br /><br />品牌官方網站：<a href=\"http://www.apple.com/tw/\" target=\\\"_blank\\\">http://www.apple.com/tw/</a><br />售後服務電話：02-66666666</p><p>&nbsp;<strong>羅奇承諾</strong></p><p>羅奇平台賣家銷售並发貨的商品，由平台賣家提供發票和相應的售後服務。請您放心購買！<br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p><p><strong>正品</strong></p><p>羅奇商城向您保證所售商品均為正品，羅奇商品開具紙本發票或電子發票。</p><p><strong>全國維修</strong></p><p>憑保固證書及羅奇商城發票，可享受全國維修服務（奢侈品、鐘表除外；奢侈品、鐘表由羅奇聯絡保固，享受法定售後服務），與您親臨商場選購的商品享受相同的保固品質。羅奇商城還為您提供具有競爭力的商品價格和<a href=\"http://www.rocketmall.gq\" target=\\\"_blank\\\">運費政策</a>，請您放心購買！&nbsp;<br /><br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p>',1,4,45,157),(2,'2018-04-14 02:09:40.437769','2020-09-30 13:50:10.891182','Apple iPhone 11',6667,7859,'<h1 style=\\\"text-align:center\\\">精彩不少，付出不多。</h1><p>iphone11擁有我們最強大的晶片和最受歡迎的尺寸，更有讓你心動不已的價格。一切精彩，一如你所期待。</p><p><img alt=\\\"\\\" src=\\\" group1/M00/00/00/rBQAA19h-ruAc9RRAAAMxOtyYsY487.jpg \\\" style=\\\"height:341px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/02/CtM3BVrRYpCAS9FFAADxmVbf5qw4487023\\\" style=\\\"height:277px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/02/CtM3BVrRYp6ACUuEAAWXt1XYzNg5251947\\\" style=\\\"height:2337px; width:750px\\\" /></p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/02/CtM3BVrRYqmANdXMAAXn26rWyDY0861997\\\" style=\\\"height:2963px; width:750px\\\" /></p>','<h3>包裝清單</h3><p>采用 Lightning 接頭的 EarPods *1，iPhone *1，Lightning 至 USB 連接線*1，5W USB 電源適配器*1，Lightning 至3.5毫米耳機插孔轉換器*1</p>','<p>&nbsp;<strong>廠家服務</strong></p><p>本產品全國維修，享受服務，保固為：一年保固<br />如因品質問題或故障，憑廠商維修中心或特約維修點的品質檢測證明，享受7日內退貨，15日內換貨，15日以上在保固內享受免費保固等服務！<br />(注:如廠家在商品介紹中有售後保障的說明,則此商品按照廠家說明執行售後保障服務。) 您可以查詢本品牌在各地售後服務中心的聯絡方式，<a href=\"http://www.apple.com/tw/\" target=\\\"_blank\\\">請點擊查詢......</a><br /><br />品牌官方網站：<a href=\"http://www.apple.com/tw/\" target=\\\"_blank\\\">http://www.apple.com/tw/</a><br />售後服務電話：02-66666666</p><p>&nbsp;<strong>羅奇承諾</strong></p><p>羅奇平台賣家銷售並发貨的商品，由平台賣家提供發票和相應的售後服務。請您放心購買！<br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p><p><strong>正品</strong></p><p>羅奇商城向您保證所售商品均為正品，羅奇商品開具紙本發票或電子發票。</p><p><strong>全國維修</strong></p><p>憑保固證書及羅奇商城發票，可享受全國維修服務（奢侈品、鐘表除外；奢侈品、鐘表由羅奇聯絡保固，享受法定售後服務），與您親臨商場選購的商品享受相同的保固品質。羅奇商城還為您提供具有競爭力的商品價格和<a href=\"http://www.rocketmall.gq\" target=\\\"_blank\\\">運費政策</a>，請您放心購買！&nbsp;<br /><br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p>',1,1,38,117),(3,'2018-04-14 03:03:53.059061','2020-09-30 14:37:14.709635','戴爾DELL XPS',2576,3578,'<h1 style=\\\"text-align:center\\\">臻於完美的設計</h1><p>搭配選購的 4K Ultra HD 觸控顯示器及強大的處理器，超過 8 百萬像素的驚人畫質，帶給您超震撼的視覺饗宴。</p><p><img alt=\\\"\\\" src=\\\"http://172.20.0.3:8888/group1/M00/00/02/CtM3BVrRb2yAJ0cWADV9oDHhgG06294506\\\" style=\\\"height:10460px; width:750px\\\" /></p>','<h3>包裝清單</h3><p>手機（含內置電池） x 1、大電流華為SuperCharge充電器 x 1、 USB數據線 x 1、半入耳式線控耳機 x 1、快速指南 x 1、憑證 x 1、取卡針 x 1、保護殼 x 1</p>','<p>&nbsp;<strong>廠家服務</strong></p><p>本產品全國維修，享受服務，保固為：一年保固<br />如因品質問題或故障，憑廠商維修中心或特約維修點的品質檢測證明，享受7日內退貨，15日內換貨，15日以上在保固內享受免費保固等服務！<br />(注:如廠家在商品介紹中有售後保障的說明,則此商品按照廠家說明執行售後保障服務。) 您可以查詢本品牌在各地售後服務中心的聯絡方式，<a href=\"https://www.dell.com/zh-tw/\" target=\\\"_blank\\\">請點擊查詢......</a><br /><br />品牌官方網站：<a href=\"https://www.dell.com/zh-tw/\" target=\\\"_blank\\\">https://www.dell.com/zh-tw/</a><br />售後服務電話：02-777777777</p><p>&nbsp;<strong>羅奇承諾</strong></p><p>羅奇平台賣家銷售並发貨的商品，由平台賣家提供發票和相應的售後服務。請您放心購買！<br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p><p><strong>正品</strong></p><p>羅奇商城向您保證所售商品均為正品，羅奇商品開具紙本發票或電子發票。</p><p><strong>全國維修</strong></p><p>憑保固證書及羅奇商城發票，可享受全國維修服務（奢侈品、鐘表除外；奢侈品、鐘表由羅奇聯絡保固，享受法定售後服務），與您親臨商場選購的商品享受相同的保固品質。羅奇商城還為您提供具有競爭力的商品價格和<a href=\"http://www.rocketmall.gq\" target=\\\"_blank\\\">運費政策</a>，請您放心購買！&nbsp;<br /><br />注：因廠家會在沒有任何提前通知的情況下更改產品包裝、產地或者一些附件，本司不能確保客戶收到的貨物與商城圖片、產地、附件說明完全一致。只能確保為原廠正貨！並且保證與當時市場上同樣主流新品一致。若本商城沒有及時更新，請大家諒解！</p>',2,4,45,157);
/*!40000 ALTER TABLE `tb_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_goods_category`
--

DROP TABLE IF EXISTS `tb_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(10) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_goods_category_parent_id_5abc16fa_fk_tb_goods_category_id` (`parent_id`),
  CONSTRAINT `tb_goods_category_parent_id_5abc16fa_fk_tb_goods_category_id` FOREIGN KEY (`parent_id`) REFERENCES `tb_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=556 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_goods_category`
--

LOCK TABLES `tb_goods_category` WRITE;
/*!40000 ALTER TABLE `tb_goods_category` DISABLE KEYS */;
INSERT INTO `tb_goods_category` VALUES (1,'2018-04-09 08:03:18.507741','2018-04-09 08:03:18.507787','手機',NULL),(2,'2018-04-09 08:04:06.884304','2018-04-09 08:04:06.884389','相機',NULL),(3,'2018-04-09 08:04:10.066446','2018-04-09 08:04:10.066496','數碼',NULL),(4,'2018-04-09 08:05:08.975211','2018-04-09 08:05:08.975276','電腦',NULL),(5,'2018-04-09 08:05:11.678905','2018-04-09 08:05:11.678946','辦公',NULL),(6,'2018-04-09 08:05:15.661520','2018-04-09 08:05:15.661563','家用電器',NULL),(7,'2018-04-09 08:05:31.640302','2018-04-09 08:05:31.640350','家居',NULL),(8,'2018-04-09 08:05:36.662490','2018-04-09 08:05:36.662589','家具',NULL),(9,'2018-04-09 08:05:48.522108','2018-04-09 08:05:48.522167','家裝',NULL),(10,'2018-04-09 08:05:51.761687','2018-04-09 08:05:51.761729','廚具',NULL),(11,'2018-04-09 08:06:00.668337','2018-04-09 08:06:00.668376','男裝',NULL),(12,'2018-04-09 08:06:03.390254','2018-04-09 08:06:03.390309','女裝',NULL),(13,'2018-04-09 08:06:06.366323','2018-04-09 08:06:06.366365','童裝',NULL),(14,'2018-04-09 08:06:11.022792','2018-04-09 08:06:11.022872','內衣',NULL),(15,'2018-04-09 08:06:39.183635','2018-04-09 08:06:39.183676','女鞋',NULL),(16,'2018-04-09 08:08:55.929149','2018-04-09 08:08:55.929221','箱包',NULL),(17,'2018-04-09 08:09:02.512577','2018-04-09 08:09:02.512622','鐘表',NULL),(18,'2018-04-09 08:09:32.381612','2018-04-09 08:09:32.381652','珠寶',NULL),(19,'2018-04-09 08:09:46.196811','2018-04-09 08:09:46.196853','男鞋',NULL),(20,'2018-04-09 08:09:50.331597','2018-04-09 08:09:50.331661','運動',NULL),(21,'2018-04-09 08:09:53.161070','2018-04-09 08:09:53.161115','家庭清潔',NULL),(22,'2018-04-09 08:11:25.870180','2018-04-09 08:11:25.870221','個人護理',NULL),(23,'2018-04-09 08:11:32.357967','2018-04-09 08:11:32.358008','情趣',NULL),(24,'2018-04-09 08:11:38.193287','2018-04-09 08:11:38.193342','美妝',NULL),(25,'2018-04-09 08:11:43.723485','2018-04-09 08:11:43.723526','婦幼',NULL),(26,'2018-04-09 08:11:53.163455','2018-04-09 08:11:53.163509','玩具樂器',NULL),(27,'2018-04-09 08:56:04.627338','2018-04-09 08:56:04.627400','食品',NULL),(28,'2018-04-09 08:56:09.781208','2018-04-09 08:56:09.781251','酒類',NULL),(29,'2018-04-09 08:56:13.794667','2018-04-09 08:56:13.794706','生鮮',NULL),(30,'2018-04-09 08:56:16.944058','2018-04-09 08:56:16.944197','特產',NULL),(31,'2018-04-09 08:56:20.053145','2018-04-09 08:56:20.053183','圖書',NULL),(32,'2018-04-09 08:56:33.399045','2018-04-09 08:56:33.399100','音像',NULL),(33,'2018-04-09 08:56:40.072007','2018-04-09 08:56:40.072045','電子書',NULL),(34,'2018-04-09 08:56:44.456894','2018-04-09 08:56:44.456936','機票',NULL),(35,'2018-04-09 08:56:50.652838','2018-04-09 08:56:50.652918','飯店',NULL),(36,'2018-04-09 08:56:59.213818','2018-04-09 08:56:59.213867','旅遊',NULL),(37,'2018-04-09 08:57:04.589202','2018-04-09 08:57:04.589251','生活',NULL),(38,'2018-04-09 09:29:22.371056','2018-04-09 09:29:22.371100','手機通訊',1),(39,'2018-04-09 09:30:48.196806','2018-04-09 09:30:48.196857','手機配件',1),(40,'2018-04-09 09:34:17.533219','2018-04-09 09:34:17.533261','攝影攝像',2),(41,'2018-04-09 09:34:34.235105','2018-04-09 09:34:34.235143','數碼配件',3),(42,'2018-04-09 09:35:34.785967','2018-04-09 09:35:34.786010','影音娛樂',3),(43,'2018-04-09 09:35:45.307642','2018-04-09 09:35:45.307682','智能配備',3),(44,'2018-04-09 09:35:52.032395','2018-04-09 09:35:52.032460','電子教具',3),(45,'2018-04-09 09:37:07.280693','2018-04-09 09:37:07.280744','電腦',4),(46,'2018-04-09 09:37:18.429870','2018-04-09 09:37:18.429912','電腦零件',4),(47,'2018-04-09 09:37:28.654365','2018-04-09 09:37:28.654407','電腦配件',4),(48,'2018-04-09 09:37:40.238157','2018-04-09 09:37:40.238206','辦公配備',5),(49,'2018-04-09 09:37:49.104183','2018-04-09 09:37:49.104222','文具',5),(51,'2018-04-09 09:38:02.637781','2018-04-09 09:38:02.637834','冷氣',6),(52,'2018-04-09 09:38:07.771986','2018-04-09 09:38:07.772027','洗衣機',6),(53,'2018-04-09 09:38:12.913525','2018-04-09 09:38:12.913568','冰箱',6),(55,'2018-04-09 09:38:38.885029','2018-04-09 09:38:38.885076','生活電器',6),(56,'2018-04-09 09:40:41.787484','2018-04-09 09:40:41.787552','日常用品',7),(57,'2018-04-09 09:41:13.610650','2018-04-09 09:41:13.610693','紡織品',7),(58,'2018-04-09 09:41:29.602616','2018-04-09 09:41:29.602671','燈具',8),(59,'2018-04-09 09:41:36.701091','2018-04-09 09:41:36.701133','傢俱',8),(60,'2018-04-09 09:42:05.085107','2018-04-09 09:42:05.085176','居家布置',9),(61,'2018-04-09 09:42:14.306983','2018-04-09 09:42:14.307046','家裝材料',9),(62,'2018-04-09 09:42:27.065822','2018-04-09 09:42:27.065865','五金用品',9),(63,'2018-04-09 09:42:33.681358','2018-04-09 09:42:33.681419','廚具',10),(64,'2018-04-09 09:42:44.381715','2018-04-09 09:42:44.381761','廚房衛浴',10),(65,'2018-04-09 09:43:11.880846','2018-04-09 09:43:11.880932','男裝',11),(66,'2018-04-09 09:43:20.531461','2018-04-09 09:43:20.531505','女裝',12),(67,'2018-04-09 09:43:32.392066','2018-04-09 09:43:32.392117','童裝',13),(68,'2018-04-09 09:43:43.728460','2018-04-09 09:43:43.728501','童鞋',13),(69,'2018-04-09 09:43:52.886429','2018-04-09 09:43:52.886473','內衣',14),(70,'2018-04-09 09:44:48.786459','2018-04-09 09:44:48.786505','隨身衣物',14),(71,'2018-04-09 09:45:52.322960','2018-04-09 09:45:52.323019','時尚女鞋',15),(72,'2018-04-09 09:46:13.344472','2018-04-09 09:46:13.344512','潮流女包',16),(73,'2018-04-09 09:46:26.135392','2018-04-09 09:46:26.135450','精品男包',16),(74,'2018-04-09 09:46:32.838944','2018-04-09 09:46:32.838985','隨身箱包',16),(75,'2018-04-09 09:46:46.934480','2018-04-09 09:46:46.934544','鐘表',17),(76,'2018-04-09 09:47:06.012737','2018-04-09 09:47:06.012780','首飾',18),(77,'2018-04-09 09:49:49.168425','2018-04-09 09:49:49.168465','流行男鞋',19),(78,'2018-04-09 09:49:59.855801','2018-04-09 09:49:59.855840','運動鞋包',20),(79,'2018-04-09 09:50:11.153031','2018-04-09 09:50:11.153072','運動服飾',20),(80,'2018-04-09 09:50:25.907804','2018-04-09 09:50:25.907850','健身愛用',20),(81,'2018-04-09 09:50:44.505123','2018-04-09 09:50:44.505169','運動必備',20),(82,'2018-04-09 09:50:52.703445','2018-04-09 09:50:52.703485','體育用品',20),(83,'2018-04-09 09:51:03.497014','2018-04-09 09:51:03.497061','戶外衣鞋',20),(84,'2018-04-09 09:51:23.359440','2018-04-09 09:51:23.359483','野戰專區',20),(85,'2018-04-09 09:51:51.629105','2018-04-09 09:51:51.629160','清潔用具',21),(86,'2018-04-09 09:52:55.706995','2018-04-09 09:52:55.707037','清潔紙品',21),(87,'2018-04-09 09:53:17.292113','2018-04-09 09:53:17.292164','口腔護理',22),(88,'2018-04-09 09:53:27.099413','2018-04-09 09:53:27.099455','女性護理',22),(89,'2018-04-09 09:53:35.047364','2018-04-09 09:53:35.047410','情趣用品',23),(90,'2018-04-09 09:53:47.657176','2018-04-09 09:53:47.657269','美妝用品',24),(91,'2018-04-09 09:54:40.431814','2018-04-09 09:54:40.431856','媽媽專區',25),(92,'2018-04-09 09:55:00.705824','2018-04-09 09:55:00.705930','餵養用品',25),(93,'2018-04-09 09:55:31.822948','2018-04-09 09:55:31.822990','尿褲濕巾',25),(94,'2018-04-09 09:55:53.206682','2018-04-09 09:55:53.206725','玩具',26),(95,'2018-04-09 09:55:59.998048','2018-04-09 09:55:59.998088','樂器',26),(96,'2018-04-09 09:56:37.026947','2018-04-09 09:56:37.026990','新鮮水果',27),(97,'2018-04-09 09:56:47.145970','2018-04-09 09:56:47.146014','蔬菜蛋品',27),(98,'2018-04-09 09:57:06.761066','2018-04-09 09:57:06.761109','精選肉類',27),(99,'2018-04-09 09:57:18.402356','2018-04-09 09:57:18.402429','精選佳釀',28),(100,'2018-04-09 09:57:32.278070','2018-04-09 09:57:32.278132','海鮮水產',29),(101,'2018-04-09 09:57:55.205251','2018-04-09 09:57:55.205317','冷凍即食',29),(102,'2018-04-09 09:58:08.325159','2018-04-09 09:58:08.325199','地方特產',30),(103,'2018-04-09 09:59:23.347674','2018-04-09 09:59:23.347716','青少幼兒',31),(104,'2018-04-09 09:59:41.251268','2018-04-09 09:59:41.251307','教育',31),(105,'2018-04-09 09:59:47.532578','2018-04-09 09:59:47.532627','文藝',31),(106,'2018-04-09 10:00:07.689899','2018-04-09 10:00:07.689986','影音遊戲',32),(107,'2018-04-09 10:00:15.146903','2018-04-09 10:00:15.146943','電子書',33),(108,'2018-04-09 10:00:24.463854','2018-04-09 10:00:24.463893','科技',31),(109,'2018-04-09 10:01:04.222035','2018-04-09 10:01:04.222085','交通出遊',34),(110,'2018-04-09 10:01:26.371711','2018-04-09 10:01:26.371761','飯店預訂',35),(111,'2018-04-09 10:01:38.237549','2018-04-09 10:01:38.237624','旅遊度假',36),(112,'2018-04-09 10:01:54.257150','2018-04-09 10:01:54.257190','門票',37),(113,'2018-04-09 10:02:04.652269','2018-04-09 10:02:04.652320','生活繳費',37),(114,'2018-04-09 10:02:12.979008','2018-04-09 10:02:12.979053','生活服務',37),(115,'2018-04-09 10:03:27.799903','2018-04-09 10:03:27.799952','5G手機',38),(116,'2018-04-09 10:03:36.651429','2018-04-09 10:03:36.651502','遊戲手機',38),(117,'2018-04-09 10:03:50.946486','2018-04-09 10:03:50.946530','拍照手機',38),(118,'2018-04-09 10:04:03.363153','2018-04-09 10:04:03.363464','老人推薦',38),(119,'2018-04-09 10:04:29.550363','2018-04-09 10:04:29.550406','手機殼',39),(120,'2018-04-09 10:04:40.174739','2018-04-09 10:04:40.174807','保護貼',39),(121,'2018-04-09 10:04:49.015076','2018-04-09 10:04:49.015119','手機記憶卡',39),(122,'2018-04-09 10:04:55.274758','2018-04-09 10:04:55.274991','數據線',39),(123,'2018-04-09 10:05:01.247210','2018-04-09 10:05:01.247253','充電器',39),(124,'2018-04-09 10:05:08.572487','2018-04-09 10:05:08.572568','Qi無線充電器',39),(125,'2018-04-09 10:05:15.548216','2018-04-09 10:05:15.548283','手機耳機',39),(126,'2018-04-09 10:05:24.038601','2018-04-09 10:05:24.038668','行動電源',39),(127,'2018-04-09 10:05:33.149296','2018-04-09 10:05:33.149367','手機支架',39),(128,'2018-04-09 10:05:43.691569','2018-04-09 10:05:43.691625','數位相機',40),(129,'2018-04-09 10:06:02.872228','2018-04-09 10:06:02.872272','微單眼相機',40),(130,'2018-04-09 10:06:12.120240','2018-04-09 10:06:12.120292','單眼反光相機',40),(131,'2018-04-09 10:06:24.655699','2018-04-09 10:06:24.655738','拍立得',40),(132,'2018-04-09 10:06:32.889706','2018-04-09 10:06:32.889745','運動相機',40),(133,'2018-04-09 10:06:40.857296','2018-04-09 10:06:40.857348','攝影機',40),(134,'2018-04-09 10:06:47.823916','2018-04-09 10:06:47.823964','鏡頭',40),(135,'2018-04-09 10:06:59.148589','2018-04-09 10:06:59.148671','數位相框',40),(136,'2018-04-09 10:07:12.634274','2018-04-09 10:07:12.634339','記憶卡',41),(137,'2018-04-09 10:07:21.818264','2018-04-09 10:07:21.818310','三腳架',41),(138,'2018-04-09 10:07:47.797150','2018-04-09 10:07:47.797241','閃光燈',41),(139,'2018-04-09 10:08:05.025411','2018-04-09 10:08:05.025455','電池充電器',41),(140,'2018-04-09 10:08:14.509554','2018-04-09 10:08:14.509593','讀卡機',41),(141,'2018-04-09 10:08:27.331909','2018-04-09 10:08:27.332059','耳機耳麥',42),(142,'2018-04-09 10:08:39.528114','2018-04-09 10:08:39.528322','音箱音響',42),(143,'2018-04-09 10:08:55.509999','2018-04-09 10:08:55.510276','音源線',42),(144,'2018-04-09 10:09:04.503537','2018-04-09 10:09:04.503583','收音機',42),(145,'2018-04-09 10:09:15.076932','2018-04-09 10:09:15.077010','麥克風',42),(146,'2018-04-09 10:09:29.493302','2018-04-09 10:09:29.493374','專業音響',42),(147,'2018-04-09 10:09:38.404834','2018-04-09 10:09:38.404878','智能手環',43),(148,'2018-04-09 10:09:47.213524','2018-04-09 10:09:47.213567','智能手表',43),(149,'2018-04-09 10:10:04.097229','2018-04-09 10:10:04.097339','VR&AR',43),(150,'2018-04-09 10:10:10.770129','2018-04-09 10:10:10.770173','智能家居',43),(151,'2018-04-09 10:10:32.247134','2018-04-09 10:10:32.247204','無人機',43),(152,'2018-04-09 10:10:47.727920','2018-04-09 10:10:47.727987','學生平板',44),(153,'2018-04-09 10:11:01.757694','2018-04-09 10:11:01.757734','點讀機',44),(154,'2018-04-09 10:11:46.678814','2018-04-09 10:11:46.678857','翻譯機',44),(155,'2018-04-09 10:12:00.019422','2018-04-09 10:12:00.019466','電子書',44),(156,'2018-04-09 10:12:08.762703','2018-04-09 10:12:08.762746','電子詞典',44),(157,'2018-04-09 10:12:54.929293','2018-04-09 10:12:54.929354','筆記型電腦',45),(158,'2018-04-09 10:13:12.992620','2018-04-09 10:13:12.992705','電競專機',45),(159,'2018-04-09 10:13:21.687276','2018-04-09 10:13:21.687320','平板電腦',45),(160,'2018-04-09 10:13:41.221773','2018-04-09 10:13:41.221816','桌上型電腦',45),(161,'2018-04-09 10:13:51.268043','2018-04-09 10:13:51.268533','桌電套組',45),(162,'2018-04-09 10:14:07.305384','2018-04-09 10:14:07.305465','行動工作站',45),(163,'2018-04-09 10:16:57.458227','2018-04-09 10:16:57.458275','顯示器',46),(164,'2018-04-09 10:17:08.245240','2018-04-09 10:17:08.245285','CPU',46),(165,'2018-04-09 10:17:15.241497','2018-04-09 10:17:15.241614','主機板',46),(166,'2018-04-09 10:17:25.695159','2018-04-09 10:17:25.695207','顯卡',46),(167,'2018-04-09 10:17:35.032649','2018-04-09 10:17:35.032696','硬碟',46),(168,'2018-04-09 10:17:42.230729','2018-04-09 10:17:42.230770','記憶體',46),(169,'2018-04-09 10:17:50.016675','2018-04-09 10:17:50.016722','機箱',46),(170,'2018-04-09 10:17:55.578428','2018-04-09 10:17:55.578482','電源',46),(171,'2018-04-09 10:18:05.104997','2018-04-09 10:18:05.105038','散熱器',46),(172,'2018-04-09 10:18:18.113135','2018-04-09 10:18:18.113185','滑鼠',47),(173,'2018-04-09 10:18:26.352592','2018-04-09 10:18:26.352654','鍵盤',47),(174,'2018-04-09 10:18:45.584707','2018-04-09 10:18:45.584746','配件套組 ',47),(175,'2018-04-09 10:18:54.592085','2018-04-09 10:18:54.592146','USB',47),(176,'2018-04-09 10:19:02.774592','2018-04-09 10:19:02.774644','行動硬碟',47),(177,'2018-04-09 10:19:29.344648','2018-04-09 10:19:29.344688','滑鼠墊',47),(178,'2018-04-09 10:20:01.647599','2018-04-09 10:20:01.647652','網路攝影機',47),(179,'2018-04-09 10:20:10.633329','2018-04-09 10:20:10.633371','電纜',47),(180,'2018-04-09 10:20:29.108708','2018-04-09 10:20:29.108750','手寫板',47),(181,'2018-04-09 10:20:50.965054','2018-04-09 10:20:50.965110','投影機',48),(182,'2018-04-09 10:21:11.973042','2018-04-09 10:21:11.973085','投影配件',48),(183,'2018-04-09 10:28:38.875264','2018-04-09 10:28:38.875323','多功能桌機',48),(184,'2018-04-09 10:28:58.044119','2018-04-09 10:28:58.044161','影印機',48),(185,'2018-04-09 10:29:24.286741','2018-04-09 10:29:24.286786','墨粉',49),(186,'2018-04-09 10:29:32.433762','2018-04-09 10:29:32.433832','墨水匣',49),(187,'2018-04-09 10:29:40.185494','2018-04-09 10:29:40.185535','色帶',49),(188,'2018-04-09 10:29:51.285563','2018-04-09 10:29:51.285630','紙類',49),(189,'2018-04-09 10:30:02.125287','2018-04-09 10:30:02.125326','辦公文具',49),(190,'2018-04-09 10:30:13.747314','2018-04-09 10:30:13.747366','文件收納',49),(191,'2018-04-09 10:30:25.486463','2018-04-09 10:30:25.486503','計算機',49),(192,'2018-04-09 10:30:33.569198','2018-04-09 10:30:33.569262','筆類',49),(197,'2018-04-09 10:31:30.282436','2018-04-09 10:31:30.282480','壁掛式空調',51),(198,'2018-04-09 10:31:46.070209','2018-04-09 10:31:46.070256','櫃式空調',51),(199,'2018-04-09 10:31:53.705108','2018-04-09 10:31:53.705152','變頻空調',51),(200,'2018-04-09 10:32:02.828470','2018-04-09 10:32:02.828512','節能空調',51),(201,'2018-04-09 10:32:10.699372','2018-04-09 10:32:10.699438','智能空調',51),(202,'2018-04-09 10:32:21.537627','2018-04-09 10:32:21.537671','滾筒洗衣機',52),(203,'2018-04-09 10:32:40.271821','2018-04-09 10:32:40.271865','洗烘一體機',52),(204,'2018-04-09 10:33:07.290966','2018-04-09 10:33:07.291127','波輪洗衣機',52),(205,'2018-04-09 10:33:17.913196','2018-04-09 10:33:17.913237','迷你洗衣機',52),(206,'2018-04-09 10:33:30.617336','2018-04-09 10:33:30.617428','多門',53),(207,'2018-04-09 10:35:16.138738','2018-04-09 10:35:16.138781','對開門',53),(208,'2018-04-09 10:35:27.196414','2018-04-09 10:35:27.196483','三門',53),(209,'2018-04-09 10:35:35.870793','2018-04-09 10:35:35.870876','雙門',53),(215,'2018-04-09 10:44:09.292409','2018-04-09 10:44:09.292481','空氣清淨機',55),(216,'2018-04-09 10:44:21.773107','2018-04-09 10:44:21.773185','電風扇',55),(217,'2018-04-09 10:44:30.623621','2018-04-09 10:44:30.623668','掃地機器人',55),(218,'2018-04-09 10:44:47.127513','2018-04-09 10:44:47.127554','拖地機',55),(219,'2018-04-09 10:44:57.367766','2018-04-09 10:44:57.367812','烘衣機',55),(220,'2018-04-09 10:45:05.140806','2018-04-09 10:45:05.140845','電話',55),(221,'2018-04-09 10:45:43.383869','2018-04-09 10:45:43.383911','收納用品',56),(222,'2018-04-09 10:45:55.997898','2018-04-09 10:45:55.997945','雨傘雨具',56),(223,'2018-04-09 10:46:11.700313','2018-04-09 10:46:11.700382','清潔除味',56),(224,'2018-04-09 10:46:21.798864','2018-04-09 10:46:21.798963','浴室用品',56),(225,'2018-04-09 10:46:38.851705','2018-04-09 10:46:38.851744','縫紉針織',56),(226,'2018-04-09 10:47:29.768792','2018-04-09 10:47:29.768851','床被套件',57),(227,'2018-04-09 10:47:43.068195','2018-04-09 10:47:43.068238','被子',57),(228,'2018-04-09 10:47:55.954652','2018-04-09 10:47:55.954704','枕芯',57),(229,'2018-04-09 10:48:07.054248','2018-04-09 10:48:07.054299','蚊帳',57),(230,'2018-04-09 10:48:13.148110','2018-04-09 10:48:13.148207','涼席',57),(231,'2018-04-09 10:48:22.983566','2018-04-09 10:48:22.983608','毛巾浴巾',57),(232,'2018-04-09 10:48:40.536740','2018-04-09 10:48:40.537102','吸頂燈',58),(233,'2018-04-09 10:48:49.011808','2018-04-09 10:48:49.011852','吊燈',58),(234,'2018-04-09 10:48:57.503376','2018-04-09 10:48:57.503551','檯燈',58),(235,'2018-04-09 10:49:09.990632','2018-04-09 10:49:09.990674','筒燈射燈',58),(236,'2018-04-09 10:49:19.476924','2018-04-09 10:49:19.476970','裝飾燈',58),(237,'2018-04-09 10:49:34.463529','2018-04-09 10:49:34.463587','臥室傢俱',59),(238,'2018-04-09 10:49:43.863760','2018-04-09 10:49:43.863805','客廳傢俱',59),(239,'2018-04-09 10:49:52.890521','2018-04-09 10:49:52.890566','餐廳傢俱',59),(240,'2018-04-09 10:50:00.371566','2018-04-09 10:50:00.371818','書房傢俱',59),(241,'2018-04-09 10:50:07.098922','2018-04-09 10:50:07.098961','兒童傢俱',59),(242,'2018-04-09 10:50:19.143462','2018-04-09 10:50:19.143527','裝飾字畫',60),(243,'2018-04-09 10:50:26.723524','2018-04-09 10:50:26.723568','裝飾擺設',60),(244,'2018-04-09 10:50:37.529642','2018-04-09 10:50:37.529683','十字繡',60),(245,'2018-04-09 10:51:02.366545','2018-04-09 10:51:02.366585','牆貼',60),(246,'2018-04-09 10:51:14.673577','2018-04-09 10:51:14.673622','瓷磚',61),(247,'2018-04-09 10:51:20.529141','2018-04-09 10:51:20.529261','地板',61),(248,'2018-04-09 10:51:31.121585','2018-04-09 10:51:31.121641','油漆塗料',61),(249,'2018-04-09 10:51:39.261015','2018-04-09 10:51:39.261077','壁紙',61),(250,'2018-04-09 10:52:03.520983','2018-04-09 10:52:03.521024','鎖具',62),(251,'2018-04-09 10:52:12.470392','2018-04-09 10:52:12.470482','電動工具',62),(252,'2018-04-09 10:52:21.041130','2018-04-09 10:52:21.041174','手動工具',62),(253,'2018-04-09 10:52:31.599209','2018-04-09 10:52:31.599255','測量工具',62),(254,'2018-04-09 10:52:49.673907','2018-04-09 10:52:49.673945','勞防用品',62),(255,'2018-04-09 10:53:22.230127','2018-04-09 10:53:22.230194','杯具酒具',63),(256,'2018-04-09 10:53:36.874892','2018-04-09 10:53:36.874935','烹飪鍋具',63),(257,'2018-04-09 10:53:46.025047','2018-04-09 10:53:46.025129','餐具',63),(258,'2018-04-09 10:53:59.183741','2018-04-09 10:53:59.183788','廚房配件',63),(259,'2018-04-09 10:54:17.154351','2018-04-09 10:54:17.154409','菜板剪刀 ',63),(260,'2018-04-09 10:54:28.054467','2018-04-09 10:54:28.054511','鍋具套裝',63),(261,'2018-04-09 10:54:39.436215','2018-04-09 10:54:39.436460','水槽',64),(262,'2018-04-09 10:54:48.490520','2018-04-09 10:54:48.490561','龍頭組',64),(263,'2018-04-09 10:54:58.615841','2018-04-09 10:54:58.616299','淋浴花灑',64),(264,'2018-04-09 10:55:07.214304','2018-04-09 10:55:07.214363','馬桶',64),(265,'2018-04-09 10:55:24.453550','2018-04-09 10:55:24.453593','廚衛掛件',64),(266,'2018-04-09 10:55:37.042973','2018-04-09 10:55:37.043014','浴室櫃',64),(267,'2018-04-09 10:55:58.093400','2018-04-09 10:55:58.093487','T恤',65),(268,'2018-04-09 10:56:06.167659','2018-04-09 10:56:06.167702','牛仔褲',65),(269,'2018-04-09 10:56:15.579739','2018-04-09 10:56:15.579781','襯衫',65),(270,'2018-04-09 10:56:21.330228','2018-04-09 10:56:21.330268','運動短褲',65),(271,'2018-04-09 10:56:31.432431','2018-04-09 10:56:31.432506','羽絨衣',65),(272,'2018-04-09 10:56:45.065922','2018-04-09 10:56:45.065962','吊帶背心',65),(273,'2018-04-09 10:57:07.546075','2018-04-09 10:57:07.546116','西服套裝',65),(274,'2018-04-09 10:57:18.823678','2018-04-09 10:57:18.823720','襯衫',66),(275,'2018-04-09 10:57:41.556178','2018-04-09 10:57:41.556225','雪紡衫',66),(276,'2018-04-09 10:57:52.929657','2018-04-09 10:57:52.929697','針織衫',66),(277,'2018-04-09 10:57:59.657898','2018-04-09 10:57:59.657943','設計師潮牌',66),(278,'2018-04-09 10:58:07.246701','2018-04-09 10:58:07.246743','半身裙',66),(279,'2018-04-09 10:58:17.075213','2018-04-09 10:58:17.075255','牛仔褲',66),(280,'2018-04-09 10:58:28.783506','2018-04-09 10:58:28.783624',' T恤',66),(281,'2018-04-09 10:58:39.734123','2018-04-09 10:58:39.734165','內衣褲',67),(282,'2018-04-09 10:58:54.035921','2018-04-09 10:58:54.035999','親子裝',67),(283,'2018-04-09 10:59:01.809045','2018-04-09 10:59:01.809112','褲子',67),(284,'2018-04-09 10:59:11.529237','2018-04-09 10:59:11.529278','外套',67),(285,'2018-04-09 10:59:19.701142','2018-04-09 10:59:19.701182','羽絨衣',67),(286,'2018-04-09 10:59:29.917807','2018-04-09 10:59:29.917935','棉服',67),(287,'2018-04-09 10:59:37.808649','2018-04-09 10:59:37.808697',' T恤',67),(288,'2018-04-09 10:59:47.335110','2018-04-09 10:59:47.335153','運動鞋',68),(289,'2018-04-09 10:59:55.048010','2018-04-09 10:59:55.048115','靴子',68),(290,'2018-04-09 11:00:01.655226','2018-04-09 11:00:01.655389','帆布鞋',68),(291,'2018-04-09 11:00:10.050759','2018-04-09 11:00:10.050847','棉鞋',68),(292,'2018-04-09 11:00:36.252685','2018-04-09 11:00:36.252727','睡衣',69),(293,'2018-04-09 11:00:51.916631','2018-04-09 11:00:51.916725','連身褲襪',69),(294,'2018-04-09 11:01:03.507003','2018-04-09 11:01:03.507082','女士內衣',69),(295,'2018-04-09 11:01:17.165081','2018-04-09 11:01:17.165123','男士內衣',69),(296,'2018-04-09 11:01:27.044001','2018-04-09 11:01:27.044043','男士內褲',69),(297,'2018-04-09 11:01:36.242881','2018-04-09 11:01:36.242924','女士內褲',69),(298,'2018-04-09 11:01:54.834481','2018-04-09 11:01:54.834524','披肩',70),(299,'2018-04-09 11:02:00.645511','2018-04-09 11:02:00.645551','圍巾',70),(300,'2018-04-09 11:02:11.482667','2018-04-09 11:02:11.482721','遮陽帽',70),(301,'2018-04-09 11:02:20.022779','2018-04-09 11:02:20.022826','太陽眼鏡',70),(302,'2018-04-09 11:02:34.084449','2018-04-09 11:02:34.084490','毛帽',70),(303,'2018-04-09 11:02:46.119130','2018-04-09 11:02:46.119177','禮帽',70),(304,'2018-04-09 11:02:58.516680','2018-04-09 11:02:58.516821','口罩',70),(305,'2018-04-09 11:03:18.478719','2018-04-09 11:03:18.478762','馬丁靴',71),(306,'2018-04-09 11:03:34.487317','2018-04-09 11:03:34.487363','休閒鞋',71),(307,'2018-04-09 11:03:43.157761','2018-04-09 11:03:43.157841','內增高',71),(308,'2018-04-09 11:03:52.414196','2018-04-09 11:03:52.414241','帆布鞋',71),(309,'2018-04-09 11:04:07.541405','2018-04-09 11:04:07.541475','女靴',71),(310,'2018-04-09 11:04:21.823807','2018-04-09 11:04:21.823863','高跟鞋',71),(311,'2018-04-09 11:04:33.148296','2018-04-09 11:04:33.148342','雪靴',71),(312,'2018-04-09 11:04:42.712939','2018-04-09 11:04:42.712979','單肩包',72),(313,'2018-04-09 11:05:01.537643','2018-04-09 11:05:01.537695','雙肩包',72),(314,'2018-04-09 11:05:10.452996','2018-04-09 11:05:10.453036','手提包',72),(315,'2018-04-09 11:05:21.516678','2018-04-09 11:05:21.516722','側背包',72),(316,'2018-04-09 11:18:13.518247','2018-04-09 11:18:13.518288','復古背包',72),(317,'2018-04-09 11:18:24.704274','2018-04-09 11:18:24.704314','錢包',72),(318,'2018-04-09 11:21:41.102117','2018-04-09 11:21:41.102167','雙肩包',73),(319,'2018-04-09 11:21:51.040168','2018-04-09 11:21:51.040272','單肩包',73),(320,'2018-04-09 11:22:20.721731','2018-04-09 11:22:20.721812','手提包',73),(321,'2018-04-09 11:22:37.133514','2018-04-09 11:22:37.133556','側背包',73),(322,'2018-04-09 11:22:51.040191','2018-04-09 11:22:51.040233','錢包',73),(323,'2018-04-09 11:24:09.390104','2018-04-09 11:24:09.390170','旅行箱',74),(324,'2018-04-09 11:24:20.905499','2018-04-09 11:24:20.905542','拉桿包',74),(325,'2018-04-09 11:24:38.908847','2018-04-09 11:24:38.908888','旅行包',74),(326,'2018-04-09 11:24:59.546666','2018-04-09 11:24:59.546709','電腦包',74),(327,'2018-04-09 11:25:09.425172','2018-04-09 11:25:09.425223','休閒背包',74),(328,'2018-04-09 11:25:17.336990','2018-04-09 11:25:17.337047','書包',74),(329,'2018-04-09 11:25:29.965879','2018-04-09 11:25:29.965945','登山背包',74),(330,'2018-04-09 11:25:56.939364','2018-04-09 11:25:56.939402','日韓錶',75),(331,'2018-04-09 11:26:13.919984','2018-04-09 11:26:13.920027','歐美錶',75),(332,'2018-04-09 11:26:51.898328','2018-04-09 11:26:51.898506','瑞士錶',75),(333,'2018-04-09 11:27:09.494057','2018-04-09 11:27:09.494120','德國錶',75),(334,'2018-04-09 11:27:15.382732','2018-04-09 11:27:15.382833','鬧鐘',75),(335,'2018-04-09 11:27:24.784177','2018-04-09 11:27:24.784225','兒童手錶',75),(336,'2018-04-09 11:27:31.447596','2018-04-09 11:27:31.447669','智能手錶',75),(337,'2018-04-09 11:27:42.642805','2018-04-09 11:27:42.642852','銀手鐲 ',76),(338,'2018-04-09 11:27:49.327614','2018-04-09 11:27:49.327665','項鍊',76),(339,'2018-04-09 11:28:01.614654','2018-04-09 11:28:01.614700','胸針',76),(340,'2018-04-09 11:28:09.412255','2018-04-09 11:28:09.412299','鑽戒',76),(341,'2018-04-09 11:28:22.916617','2018-04-09 11:28:22.916662','情侶對戒',76),(342,'2018-04-09 11:28:30.345615','2018-04-09 11:28:30.345663','寶寶金飾',76),(343,'2018-04-09 11:28:39.321423','2018-04-09 11:28:39.321477','手鍊',76),(344,'2018-04-09 11:28:57.657591','2018-04-09 11:28:57.657636','休閒鞋',77),(345,'2018-04-09 12:08:16.560944','2018-04-11 12:37:00.856809','籃球鞋',77),(346,'2018-04-09 12:09:27.344880','2018-04-09 12:09:27.344924','皮鞋',77),(347,'2018-04-09 12:09:36.131127','2018-04-09 12:09:36.131175','皮靴',77),(348,'2018-04-09 12:09:46.733096','2018-04-09 12:09:46.733135','設計潮牌',77),(349,'2018-04-09 12:10:12.669806','2018-04-09 12:10:12.669851','跑步鞋',78),(350,'2018-04-09 12:10:24.462717','2018-04-09 12:10:24.462757','休閒鞋',78),(351,'2018-04-09 12:10:33.369187','2018-04-09 12:10:33.369266','籃球鞋',78),(352,'2018-04-09 12:10:41.678099','2018-04-09 12:10:41.678147','帆布鞋',77),(353,'2018-04-09 12:10:52.832621','2018-04-09 12:10:52.832671','跑步鞋',77),(354,'2018-04-09 12:11:11.611198','2018-04-09 12:11:11.611250','帆布鞋',78),(355,'2018-04-09 12:11:20.463957','2018-04-09 12:11:20.464001','運動背包',78),(356,'2018-04-09 12:11:37.214241','2018-04-09 12:11:37.214291','足球鞋',78),(357,'2018-04-09 12:13:15.915511','2018-04-09 12:13:15.915579','T恤',79),(358,'2018-04-09 12:13:38.332607','2018-04-09 12:13:38.332682','運動套裝',79),(359,'2018-04-09 12:13:48.314684','2018-04-09 12:13:48.314757','運動褲',79),(360,'2018-04-09 12:13:58.115856','2018-04-09 12:13:58.115930','登山鞋',79),(361,'2018-04-09 12:14:05.741448','2018-04-09 12:14:05.741497','夾克',79),(362,'2018-04-09 12:14:13.258943','2018-04-09 12:14:13.258986','排汗衣',79),(363,'2018-04-09 12:14:44.556933','2018-04-09 12:14:44.556986','跑步機',80),(364,'2018-04-09 12:15:14.348396','2018-04-09 12:15:14.348504','收腹機 ',80),(365,'2018-04-09 12:15:25.182779','2018-04-09 12:15:25.182818','啞鈴',80),(366,'2018-04-09 12:15:39.011764','2018-04-09 12:15:39.011803','舞蹈用品',80),(367,'2018-04-09 12:15:52.191090','2018-04-09 12:15:52.191133','瑜珈用品',80),(368,'2018-04-09 12:16:00.759984','2018-04-09 12:16:00.760022','健身護具',80),(369,'2018-04-09 12:16:23.743936','2018-04-09 12:16:23.743975','甩脂機',80),(370,'2018-04-09 12:16:37.158374','2018-04-09 12:16:37.158419','山地車',81),(371,'2018-04-09 12:16:47.227313','2018-04-09 12:16:47.227353','公路車',81),(372,'2018-04-09 12:16:54.949681','2018-04-09 12:16:54.949725','折疊車',81),(373,'2018-04-09 12:17:05.820361','2018-04-09 12:17:05.820407','騎行衣',81),(374,'2018-04-09 12:17:13.605959','2018-04-09 12:17:13.606000','電動車',81),(375,'2018-04-09 12:17:33.944309','2018-04-09 12:17:33.944412','電動滑板車',81),(376,'2018-04-09 12:17:50.672612','2018-04-09 12:17:50.672823','乒乓球',82),(377,'2018-04-09 12:18:02.249051','2018-04-09 12:18:02.249115','羽毛球',81),(378,'2018-04-09 12:18:17.658163','2018-04-09 12:18:32.143808','籃球',82),(379,'2018-04-09 12:18:44.169275','2018-04-09 12:18:44.169314','足球',82),(380,'2018-04-09 12:18:59.052389','2018-04-09 12:18:59.052430','輪滑滑板',82),(381,'2018-04-09 12:19:13.369855','2018-04-09 12:19:13.369895','網球',82),(382,'2018-04-09 12:19:20.514040','2018-04-09 12:19:20.514088','高爾夫',82),(383,'2018-04-09 12:19:41.478550','2018-04-09 12:19:41.478590','室外風衣',83),(384,'2018-04-09 12:19:50.948351','2018-04-09 12:19:50.948402','步鞋',83),(385,'2018-04-09 12:20:00.773041','2018-04-09 12:20:00.773107','T恤',83),(386,'2018-04-09 12:20:13.572677','2018-04-09 12:20:13.572731','登山裝 ',83),(387,'2018-04-09 12:20:35.830642','2018-04-09 12:20:35.830691','排汗衣褲',83),(388,'2018-04-09 12:20:45.236874','2018-04-09 12:20:45.236916','越野跑鞋',83),(389,'2018-04-09 12:20:53.484799','2018-04-09 12:20:53.484931','滑雪衣',83),(390,'2018-04-09 12:21:03.664043','2018-04-09 12:21:03.664087','背包',84),(391,'2018-04-09 12:21:13.588552','2018-04-09 12:21:13.588761','帳篷',84),(392,'2018-04-09 12:21:22.627360','2018-04-09 12:21:22.627441','望遠鏡',84),(393,'2018-04-09 12:21:31.571427','2018-04-09 12:21:31.571470','燒烤用具',84),(394,'2018-04-09 12:21:43.436347','2018-04-09 12:21:43.436386','釣具',84),(395,'2018-04-09 12:21:51.496392','2018-04-09 12:21:51.496432','戶外配飾',84),(396,'2018-04-09 12:22:03.144795','2018-04-09 12:22:03.144838','迷彩用品',84),(397,'2018-04-09 12:22:19.174208','2018-04-09 12:22:19.174256','髮圈',90),(398,'2018-04-09 12:22:32.680341','2018-04-09 12:22:32.680381','髮夾髮套',90),(399,'2018-04-09 12:23:13.036354','2018-04-09 12:23:13.036402','假髮',90),(400,'2018-04-09 12:23:20.661348','2018-04-09 12:23:20.661400','化妝工具',90),(401,'2018-04-09 12:23:32.836788','2018-04-09 12:23:32.836830','美髮工具',90),(402,'2018-04-09 12:23:47.819951','2018-04-09 12:23:47.820002','牙間刷',87),(403,'2018-04-09 12:23:56.486888','2018-04-09 12:23:56.486929','牙刷',87),(404,'2018-04-09 12:24:09.346459','2018-04-09 12:24:09.346508','牙線',87),(405,'2018-04-09 12:24:23.609500','2018-04-09 12:24:23.609542','美白牙貼',87),(406,'2018-04-09 12:24:34.464050','2018-04-09 12:24:34.464093','牙膏',87),(407,'2018-04-09 12:24:46.157301','2018-04-09 12:24:46.157342','垃圾袋',85),(408,'2018-04-09 12:24:54.173351','2018-04-09 12:24:54.173391','臉盆水桶',85),(409,'2018-04-09 12:25:01.636545','2018-04-09 12:25:01.636588','清潔刷具',85),(410,'2018-04-09 12:25:13.324702','2018-04-09 12:25:13.324750','手套圍裙',85),(411,'2018-04-09 12:25:23.875459','2018-04-09 12:25:23.875500','拖把掃把',85),(412,'2018-04-09 12:25:35.605448','2018-04-09 12:25:35.605489','抹布',85),(413,'2018-04-09 12:25:48.272607','2018-04-09 12:25:48.272647','一次性清潔用品',85),(414,'2018-04-09 12:26:04.737314','2018-04-09 12:26:04.737356','衛生棉',88),(415,'2018-04-09 12:26:25.466016','2018-04-09 12:26:25.466060','化妝棉',88),(416,'2018-04-09 12:26:41.636108','2018-04-09 12:26:41.636148','衛生護墊',88),(417,'2018-04-09 12:26:50.317697','2018-04-09 12:26:50.317737','化妝刷',88),(418,'2018-04-09 12:27:04.852657','2018-04-09 12:27:04.852698','面膜',88),(419,'2018-04-09 12:27:28.245163','2018-04-09 12:27:28.245206','美妝蛋',88),(420,'2018-04-09 12:27:42.249996','2018-04-09 12:27:42.250040','女性護理套組',88),(421,'2018-04-09 12:27:56.558508','2018-04-09 12:27:56.558549','飛機杯',89),(422,'2018-04-09 12:28:07.738113','2018-04-09 12:28:07.738158','倒模',89),(423,'2018-04-09 12:28:20.669977','2018-04-09 12:28:20.670037','衛生套',89),(424,'2018-04-09 12:28:30.768756','2018-04-09 12:28:30.768865','跳蛋',89),(425,'2018-04-09 12:28:40.911231','2018-04-09 12:28:40.911300','模擬陽具',89),(426,'2018-04-09 12:28:50.264210','2018-04-09 12:28:50.264251','驗孕排卵',89),(427,'2018-04-09 12:29:05.698627','2018-04-09 12:29:05.698671','震動棒',89),(428,'2018-04-09 12:29:21.396287','2018-04-09 12:29:21.396347','抽取式衛生紙',86),(429,'2018-04-09 12:29:29.941158','2018-04-09 12:29:29.941199','滾筒式衛生紙',86),(430,'2018-04-09 12:29:38.039932','2018-04-09 12:29:38.039976','紙手帕',86),(431,'2018-04-09 12:29:45.055847','2018-04-09 12:29:45.055888','廚房紙巾',86),(432,'2018-04-09 12:29:53.265950','2018-04-09 12:29:53.265998','紙面膜',86),(433,'2018-04-09 12:30:04.204188','2018-04-09 12:30:04.204227','吸油面紙',86),(434,'2018-04-09 12:30:21.022724','2018-04-09 12:30:21.022771','孕婦裝',91),(435,'2018-04-09 12:30:28.705125','2018-04-09 12:30:28.705297','防溢乳墊',91),(436,'2018-04-09 12:30:41.640737','2018-04-09 12:30:41.640777','待產護理',91),(437,'2018-04-09 12:30:47.938600','2018-04-09 12:30:47.938654','月子裝',91),(438,'2018-04-09 12:31:01.503065','2018-04-09 12:31:01.503251','產後塑身',91),(439,'2018-04-09 12:31:10.862232','2018-04-09 12:31:10.862287','背嬰袋',91),(440,'2018-04-09 12:31:20.344400','2018-04-09 12:31:20.344443','吸奶器',92),(441,'2018-04-09 12:31:30.706523','2018-04-09 12:31:30.706688','暖奶消毒',92),(442,'2018-04-09 12:31:44.035896','2018-04-09 12:31:44.035975','奶瓶奶嘴',92),(443,'2018-04-09 12:31:57.403136','2018-04-09 12:31:57.403180','兒童餐具',92),(444,'2018-04-09 12:32:10.384580','2018-04-09 12:32:10.384629','輔食料理機',92),(445,'2018-04-09 12:32:21.916098','2018-04-09 12:32:21.916144','紙尿褲NB',93),(446,'2018-04-09 12:32:29.287475','2018-04-09 12:32:29.287523','紙尿褲S',93),(447,'2018-04-09 12:32:36.424841','2018-04-09 12:32:36.424887','紙尿褲M',93),(448,'2018-04-09 12:32:42.132988','2018-04-09 12:32:42.133030','紙尿褲L',93),(449,'2018-04-09 12:32:50.778168','2018-04-09 12:32:50.778233','紙尿褲XL',93),(450,'2018-04-09 12:32:57.068461','2018-04-09 12:32:57.068502','紙尿褲XXL',93),(451,'2018-04-09 12:33:06.777164','2018-04-09 12:33:06.777211','嬰兒紙尿片',93),(452,'2018-04-09 12:33:24.613039','2018-04-09 12:33:24.613080','絨毛娃娃',94),(453,'2018-04-09 12:33:31.652664','2018-04-09 12:33:31.652732','益智玩具',94),(454,'2018-04-09 12:33:45.339728','2018-04-09 12:33:45.339766','積木玩具',94),(455,'2018-04-09 12:33:55.126028','2018-04-09 12:33:55.126067','模型玩具',94),(456,'2018-04-09 12:34:11.655807','2018-04-09 12:34:11.655851','親子DIY',94),(457,'2018-04-09 12:34:20.900620','2018-04-09 12:34:20.900691','鍵盤樂器',95),(458,'2018-04-09 12:34:28.181696','2018-04-09 12:34:28.181746','吹奏樂器',95),(459,'2018-04-09 12:34:39.033787','2018-04-09 12:34:39.033837','打擊樂器',95),(460,'2018-04-09 12:34:44.586005','2018-04-09 12:34:44.586048','管樂器',95),(461,'2018-04-09 12:35:00.803528','2018-04-09 12:35:00.803568','音樂配件',95),(462,'2018-04-09 12:35:17.639608','2018-04-09 12:35:17.639654','蘋果',96),(463,'2018-04-09 12:35:24.396253','2018-04-09 12:35:24.396333','香蕉',96),(464,'2018-04-09 12:35:38.853589','2018-04-09 12:35:38.853630','梨',96),(465,'2018-04-09 12:35:44.700034','2018-04-09 12:35:44.700076','柳橙',96),(466,'2018-04-09 12:35:54.523749','2018-04-09 12:35:54.523791','奇異果',96),(467,'2018-04-09 12:36:04.893146','2018-04-09 12:36:04.893199','火龍果',96),(468,'2018-04-09 12:36:14.484152','2018-04-09 12:36:14.485197','蛋品',97),(469,'2018-04-09 12:36:28.415979','2018-04-09 12:36:28.416033','葉菜類',97),(470,'2018-04-09 12:36:37.316846','2018-04-09 12:36:37.316905','根莖類',97),(471,'2018-04-09 12:36:56.682895','2018-04-09 12:36:56.682936','蔥薑蒜椒',97),(472,'2018-04-09 12:37:09.086730','2018-04-09 12:37:09.086801','豬肉',98),(473,'2018-04-09 12:37:14.763994','2018-04-09 12:37:14.764035','牛肉',98),(474,'2018-04-09 12:37:23.722896','2018-04-09 12:37:23.722937','羊肉',98),(475,'2018-04-09 12:37:31.952876','2018-04-09 12:37:31.952917','雞肉',98),(476,'2018-04-09 12:37:40.185669','2018-04-09 12:37:40.185708','鴨肉',98),(477,'2018-04-09 12:37:54.541087','2018-04-09 12:37:54.541206','白酒',99),(478,'2018-04-09 12:38:00.476058','2018-04-09 12:38:00.476103','葡萄酒',99),(479,'2018-04-09 12:38:07.401633','2018-04-09 12:38:07.401673','洋酒',99),(480,'2018-04-09 12:38:15.374182','2018-04-09 12:38:15.374237','啤酒',99),(481,'2018-04-09 12:38:22.161741','2018-04-09 12:38:22.162162','威士忌',99),(482,'2018-04-09 12:38:34.069996','2018-04-09 12:38:34.070069','魚類',100),(483,'2018-04-09 12:38:40.454694','2018-04-09 12:38:40.454748','蝦類',100),(484,'2018-04-09 12:38:50.430100','2018-04-09 12:38:50.430144','蟹類',100),(485,'2018-04-09 12:38:59.664340','2018-04-09 12:38:59.664378','貝類',100),(486,'2018-04-09 12:39:07.324234','2018-04-09 12:39:07.324272','海參',100),(487,'2018-04-09 12:39:17.066508','2018-04-09 12:39:17.066561','魷魚',100),(488,'2018-04-09 12:39:24.459066','2018-04-09 12:39:24.459109','水餃',101),(489,'2018-04-09 12:39:34.604818','2018-04-09 12:39:34.604873','湯圓',101),(490,'2018-04-09 12:39:41.951256','2018-04-09 12:39:41.951389','麵點',101),(491,'2018-04-09 12:39:56.644602','2018-04-09 12:39:56.644666','烘培半成品',101),(492,'2018-04-09 12:40:06.995033','2018-04-09 12:40:06.995079','冷凍調理包',101),(493,'2018-04-09 12:40:18.989451','2018-04-09 12:40:18.989491','太陽餅',102),(494,'2018-04-09 12:40:24.498405','2018-04-09 12:40:24.498446','花蓮麻糬',102),(495,'2018-04-09 12:40:35.291572','2018-04-09 12:40:35.291613','方塊酥',102),(496,'2018-04-09 12:40:44.577503','2018-04-09 12:40:44.577596','新竹米粉',102),(497,'2018-04-09 12:40:50.353640','2018-04-09 12:40:50.353719','鳳梨酥',102),(498,'2018-04-09 12:40:59.948664','2018-04-09 12:40:59.948705','金門貢糖',102),(499,'2018-04-09 12:41:04.991165','2018-04-09 12:41:04.991210','鴨賞',102),(500,'2018-04-09 12:41:20.415788','2018-04-09 12:41:33.490500','0-2歲',103),(501,'2018-04-09 12:41:51.393210','2018-04-09 12:41:51.393266','3-6歲',103),(502,'2018-04-09 12:42:00.521776','2018-04-09 12:42:00.521834','7-10歲',103),(503,'2018-04-09 12:42:06.853828','2018-04-09 12:42:06.853879','11-14歲',103),(504,'2018-04-09 12:42:15.217304','2018-04-09 12:42:15.217346','兒童文藝',103),(505,'2018-04-09 12:42:21.085464','2018-04-09 12:42:21.085572','童話繪本',103),(506,'2018-04-09 12:42:26.635396','2018-04-09 12:42:26.635436','科普讀物',103),(507,'2018-04-09 12:42:35.299418','2018-04-09 12:42:35.299457','教科書',104),(508,'2018-04-09 12:42:44.941114','2018-04-09 12:42:44.941153','中小學參考書',104),(509,'2018-04-09 12:42:51.391709','2018-04-09 12:42:51.391751','公職考試',104),(510,'2018-04-09 12:43:03.953751','2018-04-09 12:43:03.953795','外語學習',104),(511,'2018-04-09 12:43:13.404857','2018-04-09 12:43:13.404902','字典詞典',104),(512,'2018-04-09 12:43:22.635176','2018-04-09 12:43:22.635220','小說',105),(513,'2018-04-09 12:43:29.185733','2018-04-09 12:43:29.185956','經典文學',105),(514,'2018-04-09 12:43:36.123019','2018-04-09 12:43:36.123619','青春文學',105),(515,'2018-04-09 12:43:57.373715','2018-04-09 12:43:57.373760','傳記',105),(516,'2018-04-09 12:44:02.905921','2018-04-09 12:44:02.905961','輕小說',105),(517,'2018-04-09 12:44:10.930632','2018-04-09 12:44:10.930677','藝術',105),(518,'2018-04-09 12:44:22.797355','2018-04-09 12:44:22.797407','音樂',106),(519,'2018-04-09 12:44:29.689156','2018-04-09 12:44:29.689196','影視',106),(520,'2018-04-09 12:44:41.896114','2018-04-09 12:44:41.896156','教育',106),(521,'2018-04-09 12:44:52.139493','2018-04-09 12:44:52.139567','遊戲',106),(522,'2018-04-09 12:45:04.183430','2018-04-09 12:45:04.183788','領導力',107),(523,'2018-04-09 12:45:12.853989','2018-04-09 12:45:12.854064','勵志與成功',107),(524,'2018-04-09 12:45:20.095013','2018-04-09 12:45:20.095176','經濟金融',107),(525,'2018-04-09 12:45:29.048014','2018-04-09 12:45:29.048060','管理',107),(526,'2018-04-09 12:45:45.137162','2018-04-09 12:45:45.137200','計算機與網路',108),(527,'2018-04-09 12:45:55.864096','2018-04-09 12:45:55.864135','科普',108),(528,'2018-04-09 12:46:02.495930','2018-04-09 12:46:02.495974','建築',108),(529,'2018-04-09 12:46:12.225136','2018-04-09 12:46:12.225451','工業技術',108),(530,'2018-04-09 12:46:22.281103','2018-04-09 12:46:22.281142','電子通信',108),(531,'2018-04-09 12:46:28.058464','2018-04-09 12:46:28.058510','醫學',108),(532,'2018-04-09 12:46:34.969122','2018-04-09 12:46:34.969166','農林漁',108),(533,'2018-04-09 12:46:50.460306','2018-04-09 12:46:50.460367','國內機票',109),(534,'2018-04-09 12:47:03.136221','2018-04-09 12:47:03.136285','國際機票',109),(535,'2018-04-09 12:47:08.441450','2018-04-09 12:47:08.441508','火車票',109),(536,'2018-04-09 12:47:15.969474','2018-04-09 12:47:15.969514','機場服務',109),(537,'2018-04-09 12:47:27.075057','2018-04-09 12:47:27.075338','國內飯店民宿',110),(538,'2018-04-09 12:47:37.048895','2018-04-09 12:47:37.048936','國際飯店',110),(539,'2018-04-09 12:47:49.230938','2018-04-09 12:47:49.230980','精選飯店民宿',110),(540,'2018-04-09 12:47:59.488914','2018-04-09 12:47:59.488958','國內旅遊',111),(541,'2018-04-09 12:48:13.464137','2018-04-09 12:48:13.464184','境外旅遊',111),(542,'2018-04-09 12:48:25.847481','2018-04-09 12:48:25.847528','景點門票',111),(543,'2018-04-09 12:48:43.599292','2018-04-09 12:48:43.599333','電影劃位',112),(544,'2018-04-09 12:49:00.580843','2018-04-09 12:49:00.580886','演唱會',112),(545,'2018-04-09 12:49:09.886332','2018-04-09 12:49:09.886374','音樂會',112),(546,'2018-04-09 12:49:24.549168','2018-04-09 12:49:24.549214','話劇歌劇',112),(547,'2018-04-09 12:49:31.673625','2018-04-09 12:49:31.673733','體育賽事',112),(548,'2018-04-09 12:49:40.124527','2018-04-09 12:49:40.124722','水費',113),(549,'2018-04-09 12:49:47.944100','2018-04-09 12:49:47.944139','電費',113),(550,'2018-04-09 12:49:55.874111','2018-04-09 12:49:55.874156','瓦斯費',113),(551,'2018-04-09 12:50:05.470708','2018-04-09 12:50:05.470749','通話費',113),(552,'2018-04-09 12:50:21.772953','2018-04-09 12:50:21.773025','居家清潔',114),(553,'2018-04-09 12:50:36.536493','2018-04-09 12:50:36.536542','攝影寫真',114),(554,'2018-04-09 12:50:50.325220','2018-04-09 12:50:50.325264','養生',114),(555,'2018-04-09 12:51:01.075371','2018-04-26 14:51:12.471116','代理代辦',114);
/*!40000 ALTER TABLE `tb_goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_goods_channel`
--

DROP TABLE IF EXISTS `tb_goods_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `group_id` int(11) NOT NULL,
  `url` varchar(50) NOT NULL,
  `sequence` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_goods_channel_category_id_8e1b1d82_fk_tb_goods_category_id` (`category_id`),
  CONSTRAINT `tb_goods_channel_category_id_8e1b1d82_fk_tb_goods_category_id` FOREIGN KEY (`category_id`) REFERENCES `tb_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_goods_channel`
--

LOCK TABLES `tb_goods_channel` WRITE;
/*!40000 ALTER TABLE `tb_goods_channel` DISABLE KEYS */;
INSERT INTO `tb_goods_channel` VALUES (1,'2018-04-09 09:15:38.057078','2018-04-09 09:15:38.057150',1,'http://www.rocketmall.gq',1,1),(2,'2018-04-09 09:17:29.097657','2018-04-09 09:17:29.097706',1,'http://www.rocketmall.gq',2,2),(3,'2018-04-09 09:17:45.065222','2018-04-09 09:17:45.065264',1,'http://www.rocketmall.gq',3,3),(4,'2018-04-09 09:18:10.865628','2018-04-09 09:18:10.865669',2,'http://www.rocketmall.gq',1,4),(5,'2018-04-09 09:18:26.508512','2018-04-09 09:18:26.508581',2,'http://www.rocketmall.gq',2,5),(6,'2018-04-09 09:18:44.054270','2018-04-09 09:18:44.054322',2,'http://www.rocketmall.gq',3,6),(7,'2018-04-09 09:19:17.539464','2018-04-09 09:19:17.539538',3,'http://www.rocketmall.gq',1,7),(8,'2018-04-09 09:19:27.460701','2018-04-09 09:19:27.460744',3,'http://www.rocketmall.gq',2,8),(9,'2018-04-09 09:19:40.863343','2018-04-09 09:19:40.863387',3,'http://www.rocketmall.gq',3,9),(10,'2018-04-09 09:19:50.561302','2018-04-09 09:19:50.561364',3,'http://www.rocketmall.gq',4,10),(11,'2018-04-09 09:20:01.493344','2018-04-09 09:20:01.493495',4,'http://www.rocketmall.gq',1,11),(12,'2018-04-09 09:20:34.086724','2018-04-09 09:20:34.086785',4,'http://www.rocketmall.gq',2,12),(13,'2018-04-09 09:20:42.379403','2018-04-09 09:20:42.379451',4,'http://www.rocketmall.gq',4,13),(14,'2018-04-09 09:21:28.958754','2018-04-09 09:21:28.958795',4,'http://www.rocketmall.gq',4,14),(15,'2018-04-09 09:21:40.106887','2018-04-09 09:21:40.106969',5,'http://www.rocketmall.gq',1,15),(16,'2018-04-09 09:21:53.353755','2018-04-09 09:21:53.353799',5,'http://www.rocketmall.gq',2,16),(17,'2018-04-09 09:22:00.609357','2018-04-09 09:22:00.609399',5,'http://www.rocketmall.gq',3,17),(18,'2018-04-09 09:22:22.954795','2018-04-09 09:22:22.954840',5,'http://www.rocketmall.gq',4,18),(19,'2018-04-09 09:22:36.104435','2018-04-09 09:22:36.104479',6,'http://www.rocketmall.gq',1,19),(20,'2018-04-09 09:22:45.332578','2018-04-09 09:22:45.332620',6,'http://www.rocketmall.gq',2,20),(21,'2018-04-09 09:22:54.175772','2018-04-09 09:22:54.176014',8,'http://www.rocketmall.gq',3,21),(22,'2018-04-09 09:23:05.485045','2018-04-09 09:23:05.485122',7,'http://www.rocketmall.gq',1,22),(23,'2018-04-09 09:23:15.810944','2018-04-09 09:23:15.810994',7,'http://www.rocketmall.gq',2,23),(24,'2018-04-09 09:23:23.689513','2018-04-09 09:23:23.689560',7,'http://www.rocketmall.gq',3,24),(25,'2018-04-09 09:23:35.724733','2018-04-09 09:23:35.724773',8,'http://www.rocketmall.gq',1,25),(26,'2018-04-09 09:23:48.261767','2018-04-09 09:23:48.261814',8,'http://www.rocketmall.gq',2,26),(27,'2018-04-09 09:24:03.645182','2018-04-09 09:24:03.645227',9,'http://www.rocketmall.gq',1,27),(28,'2018-04-09 09:24:23.379561','2018-04-09 09:24:23.379603',9,'http://www.rocketmall.gq',2,28),(29,'2018-04-09 09:24:35.402469','2018-04-09 09:24:35.402513',9,'http://www.rocketmall.gq',3,29),(30,'2018-04-09 09:24:52.890507','2018-04-09 09:24:52.890549',9,'http://www.rocketmall.gq',4,30),(31,'2018-04-09 09:25:00.005576','2018-04-09 09:25:00.005658',10,'http://www.rocketmall.gq',1,31),(32,'2018-04-09 09:25:06.989099','2018-04-09 09:25:06.989139',10,'http://www.rocketmall.gq',2,32),(33,'2018-04-09 09:25:13.785850','2018-04-09 09:25:13.785911',10,'http://www.rocketmall.gq',3,33),(34,'2018-04-09 09:25:21.231690','2018-04-09 09:25:21.231772',11,'http://www.rocketmall.gq',1,34),(35,'2018-04-09 09:25:30.766132','2018-04-09 09:25:30.766177',11,'http://www.rocketmall.gq',2,35),(36,'2018-04-09 09:25:43.574584','2018-04-09 09:25:43.574629',11,'http://www.rocketmall.gq',3,36),(37,'2018-04-09 09:26:00.332843','2018-04-26 13:13:00.959857',11,'http://www.rocketmall.gq',4,37);
/*!40000 ALTER TABLE `tb_goods_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_goods_specification`
--

DROP TABLE IF EXISTS `tb_goods_specification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_goods_specification_goods_id_41f4eda6_fk_tb_goods_id` (`goods_id`),
  CONSTRAINT `tb_goods_specification_goods_id_41f4eda6_fk_tb_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `tb_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_goods_specification`
--

LOCK TABLES `tb_goods_specification` WRITE;
/*!40000 ALTER TABLE `tb_goods_specification` DISABLE KEYS */;
INSERT INTO `tb_goods_specification` VALUES (1,'2018-04-11 17:20:30.142577','2020-10-05 01:21:55.016859','螢幕尺寸',1),(2,'2018-04-11 17:21:57.862419','2018-04-11 17:21:57.862464','顏色',1),(3,'2018-04-11 17:22:04.687913','2018-04-11 17:22:04.687956','版本',1),(4,'2018-04-14 02:10:32.810681','2018-04-14 02:10:32.810728','顏色',2),(5,'2018-04-14 02:10:39.748266','2018-04-14 02:10:39.748314','記憶體',2),(6,'2018-04-14 03:04:39.450373','2018-04-14 03:04:39.450418','顏色',3),(7,'2018-04-14 03:04:50.182073','2018-04-14 03:04:50.182118','版本',3);
/*!40000 ALTER TABLE `tb_goods_specification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_goods_visit`
--

DROP TABLE IF EXISTS `tb_goods_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_goods_visit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `count` int(11) NOT NULL,
  `date` date NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_goods_visit_category_id_b3e36237_fk_tb_goods_category_id` (`category_id`),
  CONSTRAINT `tb_goods_visit_category_id_b3e36237_fk_tb_goods_category_id` FOREIGN KEY (`category_id`) REFERENCES `tb_goods_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_goods_visit`
--

LOCK TABLES `tb_goods_visit` WRITE;
/*!40000 ALTER TABLE `tb_goods_visit` DISABLE KEYS */;
INSERT INTO `tb_goods_visit` VALUES (1,'2020-09-21 03:32:33.529311','2020-09-21 13:09:38.456831',101,'2020-09-21',157),(2,'2020-09-22 00:25:59.011120','2020-09-22 12:19:46.471677',89,'2020-09-22',157),(3,'2020-09-22 23:30:30.309479','2020-09-23 05:04:31.746725',32,'2020-09-23',157),(4,'2020-09-23 03:26:30.194073','2020-09-23 11:55:28.103976',19,'2020-09-23',117),(5,'2020-09-24 01:23:27.828601','2020-09-24 06:19:31.642084',25,'2020-09-24',157),(6,'2020-09-24 01:54:18.886057','2020-09-24 01:54:18.886120',1,'2020-09-24',117),(7,'2020-09-25 00:30:42.668473','2020-09-25 05:23:13.600044',13,'2020-09-25',157),(8,'2020-09-26 03:14:14.042988','2020-09-27 11:37:07.167345',20,'2020-09-26',157),(9,'2020-09-26 09:33:14.554396','2020-09-28 11:37:18.561611',4,'2020-09-26',117),(10,'2020-09-28 04:06:58.761498','2020-09-28 04:07:09.499767',3,'2020-09-28',157),(11,'2020-09-28 13:30:52.933030','2020-09-29 13:30:52.933148',55,'2020-09-29',117),(12,'2020-09-29 00:57:17.626686','2020-09-29 00:58:38.405578',43,'2020-09-29',157),(13,'2020-09-30 06:39:03.332025','2020-09-30 14:36:27.929419',9,'2020-09-30',157),(14,'2020-10-04 09:52:21.817247','2020-10-04 10:07:39.428009',8,'2020-10-04',117),(15,'2020-10-04 09:53:24.820258','2020-10-04 10:03:00.258973',8,'2020-10-04',157),(16,'2020-10-06 12:25:54.057806','2020-10-06 12:26:24.370133',3,'2020-10-06',157),(17,'2020-10-06 12:26:46.032090','2020-10-06 12:26:46.032126',1,'2020-10-06',117),(18,'2020-10-08 10:31:49.701357','2020-10-08 11:30:06.725777',4,'2020-10-08',117);
/*!40000 ALTER TABLE `tb_goods_visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_google_user`
--

DROP TABLE IF EXISTS `tb_google_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_google_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `name` varchar(50) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`),
  KEY `tb_google_user_user_id_28038ca9_fk_tb_user_id` (`user_id`),
  CONSTRAINT `tb_google_user_user_id_28038ca9_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_google_user`
--

LOCK TABLES `tb_google_user` WRITE;
/*!40000 ALTER TABLE `tb_google_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_google_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_line_user`
--

DROP TABLE IF EXISTS `tb_line_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_line_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `name` varchar(50) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`),
  KEY `tb_line_user_user_id_3eaf058e_fk_tb_user_id` (`user_id`),
  CONSTRAINT `tb_line_user_user_id_3eaf058e_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_line_user`
--

LOCK TABLES `tb_line_user` WRITE;
/*!40000 ALTER TABLE `tb_line_user` DISABLE KEYS */;
INSERT INTO `tb_line_user` VALUES (5,'2020-09-27 01:24:44.701469','2020-09-27 01:24:44.701522','Ud625971b4415c4b844e48f587a48d9d7','陳致文','https://profile.line-scdn.net/0h9Ux5vpIQZnpFTE0Nl0EZLXkJaBcyYmAyPSMpFWFPaB1vKHEtKSkqGTRFa09sKSArLCghGmBPak08',9);
/*!40000 ALTER TABLE `tb_line_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order_goods`
--

DROP TABLE IF EXISTS `tb_order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` longtext NOT NULL,
  `score` smallint(6) NOT NULL,
  `is_anonymous` tinyint(1) NOT NULL,
  `is_commented` tinyint(1) NOT NULL,
  `order_id` varchar(64) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_order_goods_order_id_3cce2d8f_fk_tb_order_info_order_id` (`order_id`),
  KEY `tb_order_goods_sku_id_e335e3b1_fk_tb_sku_id` (`sku_id`),
  CONSTRAINT `tb_order_goods_order_id_3cce2d8f_fk_tb_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `tb_order_info` (`order_id`),
  CONSTRAINT `tb_order_goods_sku_id_e335e3b1_fk_tb_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `tb_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order_goods`
--

LOCK TABLES `tb_order_goods` WRITE;
/*!40000 ALTER TABLE `tb_order_goods` DISABLE KEYS */;
INSERT INTO `tb_order_goods` VALUES (32,'2020-09-25 09:23:32.194436','2020-09-25 09:23:32.194489',1,60900.00,'',5,0,0,'20200925172332000000001',2),(33,'2020-09-26 09:33:00.416318','2020-09-26 09:33:00.416373',1,60900.00,'',5,0,0,'20200926173300000000001',2),(34,'2020-09-26 09:33:19.396530','2020-09-26 09:33:19.396627',1,60900.00,'',5,0,0,'20200926173319000000001',2),(35,'2020-09-26 09:33:43.591360','2020-09-26 09:33:43.591416',1,24800.00,'',5,0,0,'20200926173343000000001',4),(36,'2020-09-26 09:34:16.011031','2020-09-26 09:34:16.011131',1,28200.00,'',5,0,0,'20200926173415000000001',7),(37,'2020-09-26 11:37:32.476889','2020-09-26 11:37:32.476942',1,24800.00,'',5,0,0,'20200926193732000000001',5),(38,'2020-09-26 11:37:32.490855','2020-09-26 11:37:32.490912',1,67200.00,'',5,0,0,'20200926193732000000001',11),(39,'2020-09-26 11:37:32.504304','2020-09-26 11:37:32.504357',1,28200.00,'',5,0,0,'20200926193732000000001',7),(40,'2020-09-30 06:39:19.959364','2020-09-30 06:39:19.959420',1,60900.00,'',5,0,0,'20200930143919000000001',2),(41,'2020-09-30 06:39:19.972832','2020-09-30 06:39:19.972885',1,28200.00,'',5,0,0,'20200930143919000000001',7),(42,'2020-09-30 06:39:19.985560','2020-09-30 06:39:19.985605',1,67200.00,'',5,0,0,'20200930143919000000001',11),(43,'2020-09-30 06:39:19.996513','2020-09-30 06:39:19.996561',1,24800.00,'',5,0,0,'20200930143919000000001',5),(44,'2020-09-30 13:50:10.746889','2020-09-30 13:50:10.747033',1,24800.00,'',5,0,0,'20200930215010000000001',5),(45,'2020-09-30 13:50:10.789752','2020-09-30 13:50:10.789924',1,60900.00,'',5,0,0,'20200930215010000000001',2),(46,'2020-09-30 13:50:10.827103','2020-09-30 13:50:10.827270',1,76000.00,'',5,0,0,'20200930215010000000001',1),(47,'2020-09-30 13:50:10.865282','2020-09-30 13:50:10.865377',1,67200.00,'',5,0,0,'20200930215010000000001',11),(48,'2020-09-30 13:50:10.900054','2020-09-30 13:50:10.900155',1,28200.00,'',5,0,0,'20200930215010000000001',7),(49,'2020-09-30 14:37:14.714903','2020-09-30 14:37:14.715159',4,67200.00,'',5,0,0,'20200930223714000000009',12);
/*!40000 ALTER TABLE `tb_order_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order_info`
--

DROP TABLE IF EXISTS `tb_order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order_info` (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `order_id` varchar(64) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `freight` decimal(10,2) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `tb_order_info_address_id_7e00bc8d_fk_tb_address_id` (`address_id`),
  KEY `tb_order_info_user_id_e662f1ad_fk_tb_user_id` (`user_id`),
  CONSTRAINT `tb_order_info_address_id_7e00bc8d_fk_tb_address_id` FOREIGN KEY (`address_id`) REFERENCES `tb_address` (`id`),
  CONSTRAINT `tb_order_info_user_id_e662f1ad_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order_info`
--

LOCK TABLES `tb_order_info` WRITE;
/*!40000 ALTER TABLE `tb_order_info` DISABLE KEYS */;
INSERT INTO `tb_order_info` VALUES ('2020-09-25 09:23:32.171302','2020-09-25 09:23:32.198141','20200925172332000000001',1,60960.00,60.00,2,4,11,1),('2020-09-26 09:33:00.398134','2020-10-05 07:35:04.742168','20200926173300000000001',1,60960.00,60.00,2,1,11,1),('2020-09-26 09:33:19.381826','2020-09-26 09:33:19.399698','20200926173319000000001',1,60960.00,60.00,2,1,11,1),('2020-09-26 09:33:43.576941','2020-09-26 09:33:43.593852','20200926173343000000001',1,24860.00,60.00,2,1,11,1),('2020-10-06 09:34:15.998787','2020-09-26 09:34:16.013708','20200926173415000000001',1,28260.00,60.00,2,1,11,1),('2020-10-06 11:37:32.461953','2020-09-26 11:37:32.505674','20200926193732000000001',3,120260.00,60.00,2,1,11,1),('2020-10-06 06:39:19.942858','2020-09-30 06:39:19.997699','20200930143919000000001',4,181160.00,60.00,2,1,11,1),('2020-10-06 13:50:10.671390','2020-09-30 13:50:10.902884','20200930215010000000001',5,257160.00,60.00,2,1,11,1),('2020-10-06 14:37:14.690060','2020-09-30 14:37:14.751849','20200930223714000000009',4,268860.00,60.00,2,1,13,9);
/*!40000 ALTER TABLE `tb_order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_payment`
--

DROP TABLE IF EXISTS `tb_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `trade_id` varchar(100) DEFAULT NULL,
  `order_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trade_id` (`trade_id`),
  KEY `tb_payment_order_id_e3bfc510_fk_tb_order_info_order_id` (`order_id`),
  CONSTRAINT `tb_payment_order_id_e3bfc510_fk_tb_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `tb_order_info` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_payment`
--

LOCK TABLES `tb_payment` WRITE;
/*!40000 ALTER TABLE `tb_payment` DISABLE KEYS */;
INSERT INTO `tb_payment` VALUES (4,'2020-09-25 09:24:27.204270','2020-09-25 09:24:27.204961','2020092522001478920501064406','20200925172332000000001');
/*!40000 ALTER TABLE `tb_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sku`
--

DROP TABLE IF EXISTS `tb_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(300) NOT NULL,
  `caption` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  `market_price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `is_launched` tinyint(1) NOT NULL,
  `default_image_url` varchar(200) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_sku_category_id_23dd76b7_fk_tb_goods_category_id` (`category_id`),
  KEY `tb_sku_goods_id_fa5267c2_fk_tb_goods_id` (`goods_id`),
  CONSTRAINT `tb_sku_category_id_23dd76b7_fk_tb_goods_category_id` FOREIGN KEY (`category_id`) REFERENCES `tb_goods_category` (`id`),
  CONSTRAINT `tb_sku_goods_id_fa5267c2_fk_tb_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `tb_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sku`
--

LOCK TABLES `tb_sku` WRITE;
/*!40000 ALTER TABLE `tb_sku` DISABLE KEYS */;
INSERT INTO `tb_sku` VALUES (1,'2018-04-11 17:28:21.804713','2020-09-24 09:31:54.273381','Apple 2019款 MacBook Pro 16 九代i7 16G 512G 太空灰 RP5300M顯卡 筆記本電腦 輕薄本 MVVJ2CH/A','【全新2020款】MacBook Pro,一身才華，一觸即發 了解【周末特惠】 更多產品請點擊【羅奇官方Apple旗艦店】',76000.00,66000.00,76000.00,2976,2524,2000,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsIyAO1WHAAALI6KTN1A53.jpeg',157,1),(2,'2018-04-12 06:53:54.575306','2020-09-24 09:31:54.346272','Apple 2020新款 MacBook Pro 13.3【帶Touchbar】十代i5 16G 512G 2.0GHz 銀色 筆記本電腦 輕薄本 MWP42CH/A ','【全新2020款】MacBook Pro,一身才華，一觸即發 了解【周末特惠】 更多產品請點擊【羅奇官方Apple旗艦店】',60900.00,55900.00,60900.00,2964,1936,1000,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsIyAO1WHAAALI6KTN1A53.jpeg',157,1),(3,'2018-04-14 02:14:04.599169','2018-04-14 17:26:54.041015','Apple iPhone 11 (A2223) 128GB 白色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',24800.00,19000.00,24800.00,3000,2547,1490,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19grjKAHNFyAAAOThFiSzc62.jpeg',117,2),(4,'2018-04-14 02:20:33.355996','2018-04-14 17:27:12.736139','Apple iPhone 11 (A2223) 128GB 黑色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',24800.00,19000.00,24800.00,2999,2497,1580,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19kmqyAbHVdAAANSFLOb8499.jpeg',117,2),(5,'2018-04-14 02:45:23.341909','2018-04-14 17:27:17.181609','Apple iPhone 11 (A2223) 128GB 紅色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',24800.00,19000.00,24800.00,2997,2383,1870,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19kmyGATyuTAAAREQJQto8662.jpg',117,2),(6,'2018-04-14 02:49:40.912682','2018-04-25 11:09:35.936530','Apple iPhone 11 (A2223) 256GB 黃色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',28200.00,22000.00,28200.00,3000,2687,2090,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19km1mARntUAAAN8dBn9dE13.jpeg',117,2),(7,'2018-04-14 02:55:11.172604','2018-04-14 17:27:28.772353','Apple iPhone 11 (A2223) 256GB 紫色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',28200.00,22000.00,28200.00,2996,2396,1830,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19km3yAI-pWAAAOOtOuL4445.jpeg',117,2),(8,'2018-04-14 02:56:17.331169','2018-04-14 17:27:34.536772','Apple iPhone 11 (A2223) 256GB 綠色 雙卡雙待','選【學生優惠】新機配新卡，立享八折+4G流量吃到飽專屬優惠！',28200.00,22000.00,28200.00,3000,2767,670,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19km5aAb_T6AAAN7G19dXk15.jpeg',117,2),(9,'2018-04-14 03:09:00.909709','2018-04-14 17:27:40.624770','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)銀 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',67200.00,63000.00,67200.00,3000,1958,740,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsgaAQ8oqAAAJCLH0YAk01.jpeg',157,3),(10,'2018-04-14 03:13:40.226704','2018-04-25 11:06:55.087206','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計新款筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)白 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',67200.00,63000.00,67200.00,2998,1322,320,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19klgSALTceAAArw5MamIk905.jpg',157,3),(11,'2018-04-14 03:16:27.620102','2018-04-25 10:56:51.267674','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計新款筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)黑 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',67200.00,63000.00,67200.00,2997,893,570,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19kljSAGmETAABCgKrfX28668.jpg',157,3),(12,'2018-04-14 03:17:25.671905','2018-04-14 17:28:06.649098','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款防藍光全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)防藍光 白 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',67200.00,63000.00,67200.00,2996,2644,1400,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19klgSALTceAAArw5MamIk905.jpg',157,3),(13,'2018-04-14 03:18:04.588296','2018-04-14 17:28:23.886231','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)4K螢幕 黑 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',93000.00,72000.00,93000.00,3000,2655,2360,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19kljSAGmETAABCgKrfX28668.jpg',157,3),(14,'2018-04-14 03:19:03.691772','2018-04-25 11:10:51.316291','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)4K螢幕 銀 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',88200.00,69000.00,88200.00,3000,1732,658,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsgaAQ8oqAAAJCLH0YAk01.jpeg',157,3),(15,'2018-04-14 03:20:00.777150','2018-04-14 17:28:16.738212','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款防藍光全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)防藍光 銀 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',67200.00,63000.00,67200.00,3000,1408,500,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsgaAQ8oqAAAJCLH0YAk01.jpeg',157,3),(16,'2018-04-14 03:20:36.855901','2018-04-26 10:47:07.236432','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款防藍光全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)防藍光 黑 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',88200.00,69000.00,88200.00,3000,1689,430,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19gsgaAQ8oqAAAJCLH0YAk01.jpeg',157,3),(17,'2018-04-14 03:20:36.855901','2018-04-26 10:47:07.236432','戴爾DELL XPS15-9500 15.6英寸 Intel i7 2020新款全螢幕設計筆記本電腦(十代標壓i7-10750H 16G 512G GTX1650Ti 4G獨顯)4K螢幕 白 送兩年螢幕保','第十代intel標壓處理器，92.9%超大屏占比，GTX1650Ti顯卡，支持64G記憶體+4TB硬碟，碳聚高分子風扇+Gore隔熱膜散熱升級',88200.00,69000.00,88200.00,3000,445,79,1,'http://172.20.0.3:8888/group1/M00/00/00/rBQAA19klgSALTceAAArw5MamIk905.jpg',157,3);
/*!40000 ALTER TABLE `tb_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sku_image`
--

DROP TABLE IF EXISTS `tb_sku_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sku_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_sku_image_sku_id_8c6d7195_fk_tb_sku_id` (`sku_id`),
  CONSTRAINT `tb_sku_image_sku_id_8c6d7195_fk_tb_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `tb_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sku_image`
--

LOCK TABLES `tb_sku_image` WRITE;
/*!40000 ALTER TABLE `tb_sku_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_sku_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sku_specification`
--

DROP TABLE IF EXISTS `tb_sku_specification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sku_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `option_id` int(11) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `spec_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_sku_specification_option_id_80a17a3d_fk_tb_specif` (`option_id`),
  KEY `tb_sku_specification_sku_id_10aee5ae_fk_tb_sku_id` (`sku_id`),
  KEY `tb_sku_specification_spec_id_5aa6db0c_fk_tb_goods_` (`spec_id`),
  CONSTRAINT `tb_sku_specification_option_id_80a17a3d_fk_tb_specif` FOREIGN KEY (`option_id`) REFERENCES `tb_specification_option` (`id`),
  CONSTRAINT `tb_sku_specification_sku_id_10aee5ae_fk_tb_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `tb_sku` (`id`),
  CONSTRAINT `tb_sku_specification_spec_id_5aa6db0c_fk_tb_goods_` FOREIGN KEY (`spec_id`) REFERENCES `tb_goods_specification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sku_specification`
--

LOCK TABLES `tb_sku_specification` WRITE;
/*!40000 ALTER TABLE `tb_sku_specification` DISABLE KEYS */;
INSERT INTO `tb_sku_specification` VALUES (1,'2018-04-11 17:53:37.178101','2018-04-11 17:53:37.178148',1,1,1),(2,'2018-04-11 17:56:00.141036','2018-04-11 17:56:00.141078',4,1,2),(3,'2018-04-11 17:56:17.907973','2018-04-11 17:56:17.908017',5,1,3),(4,'2018-04-12 07:11:20.138634','2018-04-12 07:11:20.138677',2,2,1),(5,'2018-04-12 07:11:28.227056','2018-04-12 07:11:28.227099',3,2,2),(6,'2018-04-12 07:11:48.046789','2018-04-12 07:11:48.046885',6,2,3),(7,'2018-04-14 02:16:36.204410','2018-04-14 02:16:36.204453',7,3,4),(8,'2018-04-14 02:16:44.309888','2018-04-14 02:16:44.309972',11,3,5),(9,'2018-04-14 02:20:55.765324','2018-04-14 02:20:55.765377',8,4,4),(10,'2018-04-14 02:21:04.971106','2018-04-14 02:21:04.971155',11,4,5),(11,'2018-04-14 02:45:41.913322','2018-04-14 02:45:41.913372',9,5,4),(12,'2018-04-14 02:45:50.801926','2018-04-14 02:45:50.802005',11,5,5),(13,'2018-04-14 02:50:00.232648','2018-04-14 02:50:00.232694',22,6,4),(14,'2018-04-14 02:50:08.715882','2018-04-14 02:50:08.715927',12,6,5),(15,'2018-04-14 02:56:48.320934','2018-04-14 02:56:48.320980',23,7,4),(16,'2018-04-14 02:56:55.879794','2018-04-14 02:56:55.879839',12,7,5),(17,'2018-04-14 02:57:04.305406','2018-04-14 02:57:04.305462',24,8,4),(18,'2018-04-14 02:57:12.212999','2018-04-14 02:57:12.213047',12,8,5),(19,'2018-04-14 03:10:09.203601','2018-04-14 03:10:09.203646',13,9,6),(20,'2018-04-14 03:10:19.242994','2018-04-14 03:10:19.243421',16,9,7),(21,'2018-04-14 03:14:02.319574','2018-04-14 03:14:02.319621',14,10,6),(22,'2018-04-14 03:14:14.554189','2018-04-14 03:14:14.554237',16,10,7),(23,'2018-04-14 03:21:25.602470','2018-04-14 03:21:25.602519',15,11,6),(24,'2018-04-14 03:21:38.123239','2018-04-14 03:21:38.123285',16,11,7),(25,'2018-04-14 03:21:48.843531','2018-04-14 03:21:48.843577',14,12,6),(26,'2018-04-14 03:22:01.324252','2018-04-14 03:22:01.324321',21,12,7),(27,'2018-04-14 03:22:11.921568','2018-04-14 03:22:11.921613',15,13,6),(28,'2018-04-14 03:22:23.702276','2018-04-14 03:22:23.702323',20,13,7),(29,'2018-04-14 03:22:45.382268','2018-04-14 03:22:45.382313',13,14,6),(30,'2018-04-14 03:22:53.418091','2018-04-14 03:22:53.418147',20,14,7),(31,'2018-04-14 03:23:02.508118','2018-04-14 03:23:02.508186',13,15,6),(32,'2018-04-14 03:23:12.294204','2018-04-14 03:23:12.294255',21,15,7),(33,'2018-04-14 03:23:20.134049','2018-04-14 03:23:20.134095',15,16,6),(34,'2018-04-14 03:23:36.250798','2018-04-14 03:23:36.250844',21,16,7),(35,'2018-04-11 17:53:37.178101','2018-04-11 17:53:37.178148',14,17,6),(36,'2018-04-11 17:53:37.178101','2018-04-11 17:53:37.178148',20,17,7);
/*!40000 ALTER TABLE `tb_sku_specification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_specification_option`
--

DROP TABLE IF EXISTS `tb_specification_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_specification_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `value` varchar(20) NOT NULL,
  `spec_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_specification_opt_spec_id_3f11adee_fk_tb_goods_` (`spec_id`),
  CONSTRAINT `tb_specification_opt_spec_id_3f11adee_fk_tb_goods_` FOREIGN KEY (`spec_id`) REFERENCES `tb_goods_specification` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_specification_option`
--

LOCK TABLES `tb_specification_option` WRITE;
/*!40000 ALTER TABLE `tb_specification_option` DISABLE KEYS */;
INSERT INTO `tb_specification_option` VALUES (1,'2018-04-11 17:22:55.126053','2018-04-11 17:22:55.126095','16英寸',1),(2,'2018-04-11 17:24:04.841221','2018-04-11 17:24:04.841265','13.3英寸',1),(3,'2018-04-11 17:24:23.862341','2018-04-11 17:24:23.862385','銀色',2),(4,'2018-04-11 17:24:35.256820','2018-04-11 17:24:35.256868','太空灰',2),(5,'2018-04-11 17:25:04.607535','2018-04-11 17:25:04.607604','九代i7 16G 512G',3),(6,'2018-04-11 17:25:15.969671','2018-04-11 17:25:15.969714','十代i5 16G 512G',3),(7,'2018-04-11 17:25:35.025857','2018-04-12 07:12:08.090494','白色',4),(8,'2018-04-14 02:11:12.231649','2018-04-14 02:11:12.231700','黑色',4),(9,'2018-04-14 02:11:21.073811','2018-04-14 02:11:21.073917','紅色',4),(10,'2018-04-14 02:11:27.692284','2018-04-14 02:11:27.692329','銀色',4),(11,'2018-04-14 02:11:35.967113','2018-04-14 02:11:35.967163','128GB',5),(12,'2018-04-14 02:11:42.557263','2018-04-14 02:11:42.557354','256GB',5),(13,'2018-04-14 03:05:48.316724','2018-04-14 03:05:48.316835','銀色',6),(14,'2018-04-14 03:05:58.478640','2018-04-14 03:05:58.478689','白色',6),(15,'2018-04-14 03:06:05.995609','2018-04-14 03:06:05.995652','黑色',6),(16,'2018-04-14 03:06:37.587555','2018-04-14 03:06:37.587603','送兩年螢幕保',7),(20,'2018-04-14 03:07:15.727628','2018-04-14 03:07:15.727670','4K螢幕 送兩年螢幕保',7),(21,'2018-04-14 03:07:23.480154','2018-04-14 03:07:23.480237','防藍光 送兩年螢幕保',7),(22,'2018-04-11 17:22:55.126053','2018-04-11 17:22:55.126095','黃色',4),(23,'2018-04-11 17:24:23.862341','2018-04-11 17:24:23.862385','紫色',4),(24,'2018-04-11 17:24:04.841221','2018-04-11 17:24:04.841265','綠色',4);
/*!40000 ALTER TABLE `tb_specification_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `email_active` tinyint(1) NOT NULL,
  `default_address_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `tb_user_default_address_id_2ae8190b_fk_tb_address_id` (`default_address_id`),
  CONSTRAINT `tb_user_default_address_id_2ae8190b_fk_tb_address_id` FOREIGN KEY (`default_address_id`) REFERENCES `tb_address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'pbkdf2_sha256$216000$3uWdwyuz9w0d$zmasxnMgQq0RENRS8oDlPo0GxTeWrvhjPS6zo09GfZI=','2020-10-08 11:28:33.324494',1,'testuser','','','',1,1,'2020-10-06 05:48:47.549056','0966666666',0,11),(9,'!tPzMNBC62IkdUXWuIJAdGq9zuwt0U5GtMtPhEuuD','2020-09-30 14:36:04.121883',0,'Arvin1995','','','',0,1,'2020-10-06 01:24:44.685236','0966666667',0,13),(12,'pbkdf2_sha256$216000$44gboS27W9nZ$y78aqOGJ/9gml8meU/aBjPPLq4rAJGhR+gtqm69SZOY=',NULL,0,'python','','','',0,1,'2020-09-29 04:33:40.610190','0966666668',0,NULL),(14,'pbkdf2_sha256$216000$20G1WHgSTvci$xCZobLdsbi6Dx6f0SdjHhYX+2j2GxS5Vro9D2of3p/Q=',NULL,0,'django','','','',0,1,'2020-09-29 11:10:39.516032','0966666669',0,NULL);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_groups`
--

DROP TABLE IF EXISTS `tb_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tb_user_groups_user_id_group_id_adb62351_uniq` (`user_id`,`group_id`),
  KEY `tb_user_groups_group_id_3d826fde_fk_auth_group_id` (`group_id`),
  CONSTRAINT `tb_user_groups_group_id_3d826fde_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `tb_user_groups_user_id_162ae03c_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_groups`
--

LOCK TABLES `tb_user_groups` WRITE;
/*!40000 ALTER TABLE `tb_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_user_permissions`
--

DROP TABLE IF EXISTS `tb_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tb_user_user_permissions_user_id_permission_id_fb1d58db_uniq` (`user_id`,`permission_id`),
  KEY `tb_user_user_permiss_permission_id_83890c0b_fk_auth_perm` (`permission_id`),
  CONSTRAINT `tb_user_user_permiss_permission_id_83890c0b_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `tb_user_user_permissions_user_id_1b639637_fk_tb_user_id` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_user_permissions`
--

LOCK TABLES `tb_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `tb_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-09  8:27:48
