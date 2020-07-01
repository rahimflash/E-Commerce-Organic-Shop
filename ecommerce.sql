USE `ecommerce`;

-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.19


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `Fname` varchar(35) NOT NULL,
  `Lname` varchar(35) NOT NULL,
  `phoneNumber` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES 
(1,'bafpep@gmail.com','12345678','Enoch','Baffoe','0577858781'),
(2, 'twumgilbert7@gmail.com', '12345678','Gilbert', 'Twum',  '0245453642'),
(3, 'agyengo860@gmail.com', '12345678', 'Yaw', 'Agyeman',  '0553881709'),
(4, 'essiamah20@gmail.com', '12345678', 'Bernard', 'Essiamah',  '0240157738'),
(5, 'fmeef20@gmail.com', '12345678', 'Eugene', 'Fredua-Mensah',  '0203438359'),
(6, 'ishmaelagbenya77@gmail.com',  '12345678', 'Ishmael', 'Agbenya',  '0501656670'),
(7,  'modeeny1@gmail.com', '12345678', 'Abdulai', 'Mohammed', '0266644097'),
(8, 'ahmedokiyale17@gmail.com', '12345678', 'Ahmed', 'Mohammed',  '0249331555'),
(9, 'mensahamos18@gmail.com', '12345678', 'Amos', 'Mensah Adu', '0555101733');

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `author` varchar(70) NOT NULL,
  `content` text NOT NULL,
  `approved` enum('YES','NO') DEFAULT 'NO',
  `dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  `qty` int unsigned NOT NULL,
  UNIQUE KEY `userId` (`userId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Body Scrub'),(2,'Bath and Shower'),(3,'Diary And Eggs'),(4,'Grain'),(5,'Produce'),(6,'Protein Products');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoryproduct`
--

DROP TABLE IF EXISTS `categoryproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoryproduct` (
  `categoryId` int NOT NULL,
  `productId` int NOT NULL,
  UNIQUE KEY `categoryId` (`categoryId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `categoryproduct_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`),
  CONSTRAINT `categoryproduct_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoryproduct`
--

LOCK TABLES `categoryproduct` WRITE;
/*!40000 ALTER TABLE `categoryproduct` DISABLE KEYS */;
INSERT INTO `categoryproduct` VALUES (1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,90),(1,91),(1,92),(2,99),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(1,118),(3,147),(3,148),(3,149),(3,150),(3,151),(3,152),(3,153),(3,154),(3,155),(4,155),(4,162),(4,165),(4,166),(4,167),(4,168),(4,169),(4,170),(4,171),(4,172),(4,173),(4,174),(5,180),(5,181),(5,182),(5,183),(5,184),(5,185),(5,186),(5,187),(5,188),(5,189),(6,195),(6,196),(6,197),(6,198),(6,199),(6,200),(6,201),(6,202),(6,203),(6,204);
/*!40000 ALTER TABLE `categoryproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordercontent`
--

DROP TABLE IF EXISTS `ordercontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordercontent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  `orderId` int NOT NULL,
  `price` float(10,2) NOT NULL,
  `qty` int DEFAULT '1',
  `status` varchar(45) DEFAULT NULL,
  `deliverydate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`),
  KEY `orderId` (`orderId`),
  CONSTRAINT `ordercontent_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ordercontent_ibfk_3` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordercontent`
--

LOCK TABLES `ordercontent` WRITE;
/*!40000 ALTER TABLE `ordercontent` DISABLE KEYS */;
INSERT INTO `ordercontent` VALUES (1,4,105,1,3.85,1,'Processing',NULL),(2,4,150,1,6.59,1,'Delivered',NULL),(3,4,151,1,4.39,1,'Processing',NULL),(4,4,166,1,34.51,1,'Processing',NULL),(5,4,199,1,21.45,1,'Processing',NULL),(6,4,105,2,3.85,1,'Processing',NULL),(7,4,150,2,6.59,1,'In Delivery',NULL),(8,4,151,2,4.39,1,'Processing',NULL),(9,4,166,2,34.51,1,'Processing',NULL),(10,4,199,2,21.45,1,'Processing',NULL),(11,4,105,3,3.85,1,'Processing',NULL),(12,4,150,3,6.59,1,'Processing',NULL),(13,4,151,3,4.39,1,'Processing',NULL),(14,4,166,3,34.51,1,'Processing',NULL),(15,4,199,3,21.45,1,'Processing',NULL),(16,4,105,4,3.85,1,'Processing',NULL),(17,4,150,4,6.59,1,'Processing',NULL),(18,4,151,4,4.39,1,'Processing',NULL),(19,4,166,4,34.51,1,'Processing',NULL),(20,4,199,4,21.45,1,'Processing',NULL),(21,4,105,5,3.85,5,'Processing',NULL),(22,4,150,5,6.59,1,'Processing',NULL),(23,4,151,5,4.39,1,'Processing',NULL),(24,4,166,5,34.51,1,'Processing',NULL),(25,4,199,5,21.45,1,'Processing',NULL),(26,4,105,6,3.85,5,'Processing',NULL),(27,4,150,6,6.59,6,'Processing',NULL),(28,4,151,6,4.39,1,'Processing',NULL),(29,4,166,6,34.51,1,'Processing',NULL),(30,4,199,6,21.45,1,'Processing',NULL),(31,4,105,7,3.85,5,'Processing',NULL),(32,4,150,7,6.59,6,'Processing',NULL),(33,4,151,7,4.39,1,'Processing',NULL),(34,4,166,7,34.51,1,'Processing',NULL),(35,4,199,7,21.45,1,'Processing',NULL),(36,4,105,8,3.85,5,'Processing',NULL),(37,4,150,8,6.59,6,'Processing',NULL),(38,4,151,8,4.39,1,'Processing',NULL),(39,4,166,8,34.51,1,'Processing',NULL),(40,4,199,8,21.45,1,'Processing',NULL),(41,4,105,9,3.85,5,'Processing',NULL),(42,4,150,9,6.59,6,'Processing',NULL),(43,4,151,9,4.39,1,'Processing',NULL),(44,4,166,9,34.51,1,'Processing',NULL),(45,4,199,9,21.45,1,'Processing',NULL),(46,4,105,10,3.85,5,'Processing',NULL),(47,4,150,10,6.59,6,'Processing',NULL),(48,4,151,10,4.39,1,'Processing',NULL),(49,4,166,10,34.51,1,'Processing',NULL),(50,4,199,10,21.45,1,'Processing',NULL),(51,4,105,11,3.85,5,'Processing',NULL),(52,4,150,11,6.59,6,'Processing',NULL),(53,4,151,11,4.39,1,'Processing',NULL),(54,4,166,11,34.51,1,'Processing',NULL),(55,4,199,11,21.45,1,'Processing',NULL),(56,4,105,12,3.85,5,'Processing',NULL),(57,4,150,12,6.59,6,'Processing',NULL),(58,4,151,12,4.39,1,'Processing',NULL),(59,4,166,12,34.51,1,'Processing',NULL),(60,4,199,12,21.45,1,'Processing',NULL),(61,4,105,13,3.85,5,'Processing',NULL),(62,4,150,13,6.59,6,'Processing',NULL),(63,4,151,13,4.39,1,'Processing',NULL),(64,4,166,13,34.51,1,'Processing',NULL),(65,4,199,13,21.45,1,'Processing',NULL),(66,4,105,14,3.85,5,'Processing',NULL),(67,4,150,14,6.59,6,'Processing',NULL),(68,4,151,14,4.39,1,'Processing',NULL),(69,4,166,14,34.51,1,'Processing',NULL),(70,4,199,14,21.45,1,'Processing',NULL),(71,4,199,15,21.45,1,'Processing',NULL);
/*!40000 ALTER TABLE `ordercontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `recipientName` varchar(70) NOT NULL,
  `trackingNumber` varchar(20) DEFAULT NULL,
  `totalAmount` float(10,2) NOT NULL,
  `orderDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `country` varchar(45) DEFAULT 'Ghana',
  `region` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `address` varchar(128) NOT NULL,
  `arrivalDate` timestamp NULL DEFAULT NULL,
  `paymentMethod` varchar(45) DEFAULT NULL,
  `phoneNumber` varchar(13) NOT NULL,
  `orderStatus` enum('Order Placed','Processing','In-transit','In-delivery','Delivered') DEFAULT 'Order Placed',
  `shippingFee` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `constraint_trackingNumber` (`trackingNumber`),
  KEY `userId` (`userId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,4,'Enoch Baffoe','b760a4e99cc2a3caca41',70.78,'2020-06-29 19:24:34','Ghana','Greater Accra','Tesano','Near the school',NULL,'On Delivery','0577858781','Order Placed',6.43),(2,4,'Enoch Baffoe','fd3ccfc10631230688a9',70.78,'2020-06-29 19:27:27','Ghana','Greater Accra','Tesano','Near the school',NULL,'On Delivery','0577858781','Order Placed',6.43),(3,4,'Enoch Baffoe','9230b74f41030bb839f8',70.78,'2020-06-29 19:32:02','Ghana','Greater Accra','Tesano','Near the school',NULL,'On Delivery','0577858781','Order Placed',6.43),(4,4,'Enoch Baffoe','8ecc735e387e81ed3229',70.78,'2020-06-29 19:33:36','Ghana','Greater Accra','Tesano','Near the school',NULL,'On Delivery','0577858781','Order Placed',6.43),(5,4,'Kwabena Ansah','7d02f99cba6ea889e83f',86.19,'2020-06-29 19:34:32','Ghana','Ashanti','Kotei','Canam Hostel',NULL,'On Delivery','0254545646','Order Placed',7.84),(6,4,'Kwaku Antwi','1416aab3e84e79447cf1',119.13,'2020-06-29 19:37:43','Ghana','Greater Accra','Kaneshie','the tracking light Under',NULL,'On Delivery','0525525555','Order Placed',10.83),(7,4,'Kwaku Antwi','de3167e3ecd0257d0837',119.13,'2020-06-29 19:39:56','Ghana','Greater Accra','Kaneshie','the tracking light Under',NULL,'On Delivery','0525525555','Order Placed',10.83),(8,4,'Bra Kwame','65ca04904ef143ed070c',119.13,'2020-06-29 19:43:18','Ghana','Greater Accra','Tema','Near the school',NULL,'On Delivery','0555546566','Order Placed',10.83),(9,4,'Bra Kwame','06bc4039a829ef58681a',119.13,'2020-06-29 19:45:06','Ghana','Greater Accra','Accra','Near the waakye Seller',NULL,'On Delivery','0255598855','Order Placed',10.83),(10,4,'Bra Kwame','eeb9e2aa731f0970e70d',119.13,'2020-06-29 19:45:12','Ghana','Greater Accra','Accra','Near the waakye Seller',NULL,'On Delivery','0255598855','Order Placed',10.83),(11,4,'Bra Kwame','dea8a95a67cff225fae5',119.13,'2020-06-29 19:45:19','Ghana','Greater Accra','Accra','Near the waakye Seller',NULL,'On Delivery','0255598855','Order Placed',10.83),(12,4,'Kwabena Ansah','f7840ad5fb7c60e1bb3b',119.13,'2020-06-29 19:48:17','Ghana','Ashanti','Kotei','Near the school',NULL,'On Delivery','0577858781','Order Placed',10.83),(13,4,'Kwabena Ansah','a5da51f53a79ce67c1a5',119.13,'2020-06-29 19:48:23','Ghana','Ashanti','Kotei','Near the school',NULL,'On Delivery','0577858781','Order Placed',10.83),(14,4,'Enoch Baffoe','cde0382d7d211a8f8070',119.13,'2020-06-29 19:49:55','Ghana','Ashanti','Kotei','Near the school',NULL,'On Delivery','0577858781','Order Placed',10.83),(15,4,'Kwabena Ansah','24299088b2204e4d7422',21.45,'2020-06-29 22:30:44','Ghana','Greater Accra','Accra','Canam Hostel',NULL,'On Delivery','0577858781','Order Placed',1.95);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `name` varchar(128) NOT NULL,
  `shopId` int NOT NULL,
  `description` text NOT NULL,
  `price` float(10,2) NOT NULL,
  `qty` int NOT NULL,
  `weight` float DEFAULT NULL,
  `dimension` varchar(45) DEFAULT NULL,
  `approved` enum('YES','NO') DEFAULT 'NO',
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `qtySold` int NOT NULL DEFAULT '0',
  `dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `views` int unsigned DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `shopId` (`shopId`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`shopId`) REFERENCES `shop` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('Provence lemongrass body scrub',5,'A refined body scrub made with organic lemongrass oil and natural sugar gently cleans and smoothes your skin, making it gentle and beautifully soft.',4.99,200,0.3,NULL,'YES','Provence lemongrass body scrub.jpg',NULL,'N ',200,'2020-02-21 00:00:00',53,6),('Brazilian Coffee body scrub',2,'An exquisite body scrub full of organic coffee oil and natural sugar makes skin unusually soft and gentle while giving it a light, refined aroma. Directions: Apply to damp skin in a circular motion, then rinse thoroughly. Use two to three times a week for the best results.',10.00,30,0.2,NULL,'YES','Brazilian Coffee body scrub.jpg',NULL,NULL,120,'2020-02-21 00:00:00',32,7),('Body Desserts gift set',7,'This fruity, fun Organic Shop giftset containing our 2 best-selling body desserts doesn\'t just smell delicious but is the perfect combo for silky, smooth, hydrated skin',2.50,70,0.5,NULL,'YES','Body Desserts gift set.jpg',NULL,NULL,150,'2020-02-22 00:00:00',40,8),('Sugar lotus foot scrub',3,'Relish the invigorating boost and comfort that this shower gel delivers. Organic mint extract is great for toning and hydrating your skin, while organic lemongrass oil helps to give your skin a vitamin bath to add freshness that lasts the whole day through.',4.00,20,0.4,NULL,'YES','Sugar lotus foot scrub.jpg',NULL,NULL,100,'2020-02-22 00:00:00',89,9),('Sicilian orange body scrub',6,'This toning body scrub full of organic orange oil and natural sugar instantly restores smoothness and suppleness of your skin.',15.00,170,0.23,NULL,'YES','Sicilian orange body scrub.jpg',NULL,NULL,50,'2020-02-23 00:00:00',102,10),('Belgian chocolate body scrub',2,'This luxurious body scrub made with organic cocoa butter and natural sugar instantly restores elasticity of your skin, giving it amazing suppleness and seductive aroma of chocolate. Directions: Apply to damp skin in a circular motion, then rinse thoroughly. Use two to three times a week for the best results.',25.00,210,0.12,NULL,'YES','Belgian chocolate body scrub.jpg',NULL,NULL,62,'2020-02-23 00:00:00',16,11),('Honey Cinnamon body scrub ',5,'Give your skin a luxurious care with this aromatic body scrub made with organic cinnamon extract, organic honey and natural sugar. Cinnamon and sugar have gentle and soothing properties, while honey nourishes your skin with vitamins to effectively rejuvenate and renew it.',6.00,140,0.5,NULL,'YES','Honey Cinnamon body scrub.jpg',NULL,NULL,126,'2020-02-23 00:00:00',76,12),('Juicy papaya body scrub ',9,'This soft fruity body scrub is made with organic papaya extract and natural sugar to exfoliate and cleanse your skin, while rejuvenating and bringing magical scent to your body.',3.50,65,0.1,NULL,'YES','Juicy papaya body scrub','.jpg',NULL,0,'0000-00-00 00:00:00',2020,90),('Raspberry cream body scrub',10,'A beautiful combination of organic raspberry extract and natural sugar provides gentle treatment for your skin. Organic raspberry saturates your skin with nutrients, improving its appearance and structure while natural sugar sumptuously renews it.',120.00,23,0.56,NULL,'YES','Raspberry cream body scrub.jpg',NULL,NULL,10,'2020-02-24 00:00:00',86,91),('Kenyan mango body scrub ',15,'This fruity, aromatic body scrub with organic mango extract and natural sugar sumptuously exfoliates and renews your skin, giving it smoothness, silkiness and a healthy glow. Directions: Apply to damp skin in a circular motion, then rinse thoroughly. Use two to three times a week for the best results.',30.00,56,0.32,NULL,'YES','Kenyan mango body scrub.jpg',NULL,'N ',59,'2020-02-24 00:00:00',200,92),('Thermal spring spa shower gel',5,'Experience a waterfall-like torrent of emotions with this shower gel. Organic aloe extract is amazing for hydrating your skin, filling it  with energy and a freshly-toned tang. Organic laminaria extractre juvenates and renews the skin, while marine minerals nourish and restore the natural structure.',4.99,200,0.3,NULL,'YES','Thermal spring spa shower gel.jpg',NULL,NULL,200,'2020-02-21 00:00:00',34,99),('Chocolate milk bath foam',2,'Organic cocoa butter offers deep nourishment for the skin, enriching it with vitamins and enhancing its softness and beauty. Milk proteins are a wonderful moisturiser for the skin that restore its natural balance.',10.00,30,0.2,NULL,'YES','Chocolate milk bath foam.jpg',NULL,NULL,120,'2020-02-21 00:00:00',43,100),('Orange blossom bath salt',7,'Spoil yourself with a warm bath and this amazing bath salt made with sea salt and organic neroli extract. Neroli flowers with their magical delicate scent and moisturizing action are certain to arouse your emotions and make your skin soft and silky.',2.50,70,0.5,NULL,'YES','Orange blossom bath salt.jpg',NULL,NULL,150,'2020-02-22 00:00:00',98,101),('Youthful skin bath foam',6,'Treat yourself to spa-salon style intensive care with this Dead Sea Spa Resort bath foam. Marine minerals nourish, restore and rejuvenate your skin. Organic laminaria extract moistens and smoothes the skin, leaving it feeling more youthful and elastic',15.00,170,0.23,NULL,'YES','Youthful skin bath foam.jpg',NULL,NULL,50,'2020-02-23 00:00:00',79,102),('Herbs of Provence bath foam',2,'Release a torrent of emotions and exciting feelings when you try this shower gel. Organic tangerine extract nourishes your skin with vitamins that smooth and add tone. Organic mango extract helps to protect and restore your skin, adding softness and suppleness.',25.00,210,0.12,NULL,'YES','Herbs of Provence bath foam.jpg',NULL,NULL,62,'2020-02-23 00:00:00',22,103),('Anti stress bath foam ',5,'Immerse yourself in an atmosphere of pleasure and let yourself relax in warm velvety foam with orchid extract and organic clary sage oil. Orchid extract is a wonderful remedy for skin moisturizing Ð making it seem younger, softer and more beautiful. Organic clary sage oil helps you to relax and drop off into a land of beautiful dreams.',6.00,140,0.5,NULL,NULL,'Anti stress bath foam.jpg',NULL,NULL,126,'2020-02-23 00:00:00',69,104),('Lemon honey smooth skin bath foam',9,'Soft Face Gommage wonderfully cleanses the skin making it smoother and silkier. Organic coffee and limonnik extract tone, refresh and renew its natural energy and vibrancy.',3.50,65,0.1,NULL,'YES','Lemon honey smooth skin bath foam.jpg',NULL,NULL,230,'2020-02-24 00:00:00',98,105),('Superb silk beauty shower gel',10,'Give yourself a present with this shower gel that will leave your skin silkier and softer. The evocative scent of lotus lends notes of comfort and calmness to last through the day. Organic lotus extract hydrates and softens your skin, making it gentle and supple.',120.00,23,0.56,NULL,'NO','Superb silk beauty shower gel.jpg',NULL,NULL,10,'2020-02-24 00:00:00',100,106),('Minty rain fresh shower gel',15,'Relish the invigorating boost and comfort that this shower gel delivers. Organic mint extract is great for toning and hydrating your skin, while organic lemongrass oil helps to give your skin a vitamin bath to add freshness that lasts the whole day through.',30.00,56,0.32,NULL,'NO','Minty rain fresh shower gel.jpg',NULL,NULL,59,'2020-02-24 00:00:00',90,107),('Tumeric Powder',12,'This is the best product on the market',50.00,800,2,'','YES','teratumericPowder2.jpg','teratumericPowder.jpg','Turmeric_Powder_2000x.jpeg',0,'2020-06-29 00:26:20',NULL,118),('Liberte Organic Whole Milk Yogurt',2,'Liberte\'s Mediterranean yogurt starts with pure, organic whole milk, sourced from a co op of family farms. It\'s lightly sweetened, but we wish there was a little less fat and calories and a little more protein. Nutrition per 5.5 oz serving: 190 calories, 13 g fat (8 g saturated fat), 75 mg sodium, 11 g carbs (0 g fiber, 10 g sugar), 5 g protein, Calcium 15%, Vitamin A 10%',4.99,120,150,NULL,'YES','liberteyogurt.jpg',NULL,NULL,100,'2015-02-20 00:00:00',540,147),('Stonyfield Organic 100% Grassfed Yogurt',3,'Milk from cows who graze naturally on grass (rather than grain) not only gives yogurt a rich and unique flavor, but it also contains more body benefiting fatty acids like omega 3s and CLA a fat that has been linked to weight loss. Nutrition per 6 oz serving: 130 calories, 6 g fat (3.5 g saturated fat), 70 mg sodium, 14 g carbs (0 g fiber, 13 g sugar), 4 g protein, Calcium 15%',4.99,200,185,NULL,'YES','stonyfieldorganic.jpg',NULL,NULL,50,'2021-02-20 00:00:00',400,148),('Wallaby Organic Greek Whole Milk Yogurt',4,'Yes, Wallaby\'s yogurt is higher in sugar than the one from Stonyfield before, but it contains 6 grams more protein: a macronutrient that will help you stay fuller longer and may counteract dips in blood sugar that lead to ravaging hunger pangs. Nutrition per 6 oz serving: 170 calories, 5 g fat (3.5 g saturated fat), 55 mg sodium, 20 g carbs (0 g fiber, 18 g sugar), 10 g protein, Calcium 15%',2.59,400,120,NULL,'YES','wallabygreek.jpg',NULL,NULL,100,'2015-02-20 00:00:00',491,149),('Dannon Oikos Triple Zero Greek Nonfat Yogurt',5,'Cultured from milk and enzymes, no yogurt should have fiber in it. That being said, Dannon\'s addition of chicory root fiber allows the yogurt\'s six grams of naturally occurring sugar to be matched with an equal amount of digestion slowing fiber. Chicory root fiber is a source of inulin, a prebiotic that may help feed those live active probiotic cultures and can help minimize spikes in insulin after a carb heavy meal. Nutrition per 5.3 oz serving: 120 calories, 0 g fat (0 g saturated fat), 65 mg sodium, 14 g carbs (6 g fiber, 6 g sugar), 15 g protein, Calcium 15%, Vitamin D 15%',5.99,450,200,NULL,'YES','dannonoikos.jpg',NULL,NULL,200,'2017-02-20 00:00:00',230,150),('Organic Valley Omega 3 Milk',6,'Omega 3s are important raw materials for the human brain and body, and omega 3 milk contains both DHA and EPA, compared to other organic milk brands out there. So while buying Organic Valley Omega 3 Milk may not make you smarter on its own, adding it to your basket is a pretty good sign you’re one smart cookie.',3.99,300,1890,NULL,'YES','ovomega3.jpg',NULL,NULL,200,'2010-02-20 00:00:00',400,151),('Organic Valley Pasture Raised White Milk',7,'The quality and taste are consistent coast to coast, and you can find them pretty much everywhere, from big box stores to small local food co ops. These are your everyday go to white milks. They also give you plenty of options. Our pasture raised milks come in whole, 2% reduced fat, 1% lowfat, and nonfat—and all of these are available in pasteurized and ultra pasteurized too. (Pasteurization: What’s the difference?) There are gallons, half gallons, quarts, and even single serving sizes perfect for quick grabs and lunchboxes. It also comes in the most amazing 2% chocolate you’ll ever taste.',2.99,180,1890,NULL,'YES','ovpastureraised.jpg',NULL,NULL,40,'2010-02-20 00:00:00',272,152),('Organic Valley GrassMilk',8,'All of our milks come from cows that eat a lot of pasture grass, but Organic Valley Grassmilk comes from cows that eat 100% grass and dried forages—no grains—just as nature intended. This high pasture diet means Grassmilk has higher levels of some fatty acids, like omega 3 and CLA—more than 100% more of each, according to one study.',3.59,200,1890,NULL,'YES','ovgrassmilk.jpg',NULL,NULL,112,'2009-02-20 00:00:00',244,153),('Quail Eggs',9,'A single quail egg provides a significant chunk of your daily vitamin B12, selenium, riboflavin, and choline needs, along with some iron — all in a serving that contains only 14 calories. Selenium and riboflavin are important nutrients that help your body break down the food you eat and transform it into energy. Selenium also helps ensure healthy thyroid function. Meanwhile, vitamin B12 and iron promote healthy nervous system function and help maintain optimal energy levels through their roles in red blood cell formation',1.99,100,120,NULL,'YES','quaileggs.jpg',NULL,NULL,73,'2009-02-20 00:00:00',550,154),('Chicken Eggs',10,'Chicken egg is a main component of the human diet serving as a dietary source of protein, fat, and other nutrients. The chicken egg is made up of approximately two thirds white and one third yolk. The yolk contains lipids, vitamins, minerals, and carotenoid pigments.',1.99,200,600,NULL,'YES','chickeneggs.jpg',NULL,NULL,98,'2015-02-20 00:00:00',745,155),('Quaker Oats Organic Old Fashioned Oats',21,'Start your morning with a bowlful of healthy and tasty Quaker Organic Oats. The sodium free whole grain oats can be topped with any of your favorite flavors. Fresh or dried fruit and nuts give the oats crunch, while honey, cinnamon, or brown sugar makes for a warming sweet flavor. And Quaker Oats aren\'t just limited to breakfast time. Try them as a wholesome ingredient in a variety of dishes, such as meatloaf or classic oatmeal cookies. ',3.99,370,100,'1 x 10.5 x 3.5 inches','YES','quakerorganicold.jpg',NULL,NULL,70,'2023-02-20 00:00:00',204,162),('Quaker Oats Organic Old Fashioned Oats',4,'Start your morning with a bowlful of healthy and tasty Quaker Organic Oats. The sodium free whole grain oats can be topped with any of your favorite flavors. Fresh or dried fruit and nuts give the oats crunch, while honey, cinnamon, or brown sugar makes for a warming sweet flavor. And Quaker Oats aren\'t just limited to breakfast time. Try them as a wholesome ingredient in a variety of dishes, such as meatloaf or classic oatmeal cookies. ',3.99,370,100,'1 x 10.5 x 3.5 inches','YES','quakerorganicold.jpg',NULL,NULL,70,'2023-02-20 00:00:00',204,165),('Quaker Simple and Wholesome Organic Multigrain Hot Cereal',16,'Enjoy this unique blend of grains expertly milled for their inherent goodness. Made with four simple ingredients   whole grain oats, barley, whole grain rye, and red quinoa   every bite has all the goodness you want.',31.37,40,100,NULL,'YES','quakersimpleandwholesome1.jpg','quakersimpleandwholesome2.jpg','quakersimpleandwholesome3.jpg',30,'2020-02-20 00:00:00',455,166),('Bob\'s Red Mill Organic Regular Rolled Oats',18,'Organic Regular Old Fashioned Rolled Oats make a deliciously wholesome, chewy, hot cereal that provides lasting energy all morning. This favorite breakfast cereal is a great way to start your day and add fiber to your diet. Higher in protein and healthy fats, and lower in carbohydrates than most other whole grains, they contain more soluble fiber than any other grain. Oats contain more than 20 unique polyphenols called avenanthramides, which have strong anti oxidant, anti inflammatory, and anti itching activity. They also have the best amino acid balance of all the cereal grains.',29.98,200,908,'13 x 6 x 7.5 inches','YES','bobsredmilloats.jpg',NULL,NULL,120,'2020-02-20 00:00:00',300,167),('Shiloh Farms Whole Grain Organic Oat Groats',4,'Shiloh Farms offers organic, non GMO oat groats that you can feel good about eating for breakfast. One serving of these 100 percent whole grain oat groats provides you with seven grams of protein, 29 grams of carbs, and four grams of fiber with no sugar, sodium, or trans fat.',10.00,240,340,NULL,'YES','shilohoatgroats1.jpg','shilohoatgroats2.jpg','shilohoatgroats3.jpg',100,'2015-02-20 00:00:00',190,168),('Flahavan\'s Irish Steel Cut Oatmeal',8,'Grown, milled, and produced in Ireland, Flahavan\'s Irish Steel Cut Oatmeal simply contains 100 percent natural whole grain Irish oats perfect for cooking on the stove for breakfast or overnight. One serving contains 150 calories, 29 grams of carbohydrates, three grams of dietary fiber, and four grams of protein. Although it doesn\'t contain any sodium or cholesterol, it does list one gram of sugar on the nutrition label.',19.18,100,794,'1 x 1 x 1 inches','YES','flahavansirish.jpg',NULL,NULL,80,'2017-02-20 00:00:00',200,169),('Organic Brown Ghana Rice ',9,'25 kg Package. A great choice for everyday consumption. All natural/ organic. Planted in Ghana and milled in Ghana',28.30,180,2500,NULL,'YES','organicbrowngh.jpg',NULL,NULL,50,'2017-02-20 00:00:00',154,170),('Mahatma Organic Brown Rice',12,'Mahatma Organic Whole Grain Brown Rice is known for its high consistent quality. It is a rice grain with only the outer hull removed. The fiber and nutrient dense bran layers cover the inner part of the grain. These bran layers have a light brown color, and contribute a subtle nut like taste and somewhat chewy texture. Mahatma Organic brown rice is a good source of whole grain dietary fiber, naturally sodium free, cholesterol free, gluten free, Non GMO Project Verified, Kosher and certified USDA Organic. ',7.99,200,1000,NULL,'YES','mahatmaorganic.jpg',NULL,NULL,45,'2020-02-20 00:00:00',200,171),('Dave’s Killer Bread Organic 21 Whole Grains and Seeds Bread ',10,'Dave’s Killer Bread Organic 21 Whole Grains and Seeds Bread offers a sweet taste and hearty texture. With a seed coated crust, this organic sliced bread offers killer flavor. This pre sliced bread is the perfect base for a cucumber and avocado sandwich or turkey pepper jack sandwich. Non GMO Project Verified and Certified USDA Organic, this whole grain seeded bread is made with killer taste and texture, with 5 grams of protein, 5 grams of fiber and 22 grams of whole grains per serving. Try America\'s favorite organic sliced bread, because Dave\'s Killer Bread is the best bread in the universe. ',18.96,150,765,NULL,'YES','daveskillerbread.jpg',NULL,NULL,97,'2014-02-20 00:00:00',154,172),('Mestemacher Whole Rye Bread',12,'Packaged bread. Excellent source of whole grain long shelf life through pasteurization. Kosher low in fat high in fibre no preservatives. Long shelf life through pasterization. German origin ',12.52,300,500,NULL,'YES','mestemacherrye.jpg',NULL,NULL,200,'2015-02-20 00:00:00',500,173),('Bob\'s Red Mill Organic Whole Wheat Flour',5,'Our Organic Whole Wheat Flour is 100% stone ground from hard red spring wheat, with all of the nutrients from the bran and germ still intact. This high protein, certified organic flour is the preferred choice of traditional bread bakers for consistent, high rising loaves and other baked goods.',8.39,90,2268,NULL,'YES','bobsredmillflour1.jpg','bobsredmillflour2.jpg','bobsredmillflour3.jpg',70,'2022-02-20 00:00:00',452,174),('Blue Diamond Almonds',8,'Whole Natural Blue Diamond almonds are the best way to appreciate the flavor of the almond. It\'s also a good way to get a handful of almonds\' benefits every day.',14.00,230,1134,NULL,'YES','bluediamond.jpg',NULL,NULL,133,'2021-02-20 00:00:00',209,180),('Nutiva Organic Premium Black Chia Seeds',14,'Nutiva Organic, non GMO, Raw, Premium Black Chia Seeds pack a powerful superfood punch. These small, crunchy, gluten free seeds are a rich source of protein, beneficial antioxidants, essential omega 3 fatty acids and wholesome fiber. In fact, just 3 tablespoons of Nutiva Organic, non GMO, Raw, Premium Black Chia Seeds contains 15x more magnesium than broccoli, 6x more calcium than whole milk, 30% more antioxidants than blueberries, and 2x more potassium than bananas! It\'s no wonder that use of this ancient superfood can be traced back to 3500 BCE. Nutiva Organic, non GMO, Raw, Premium Black Chia Seeds are easy to digest whole and can be easily incorporated into vegetarian, vegan, raw, whole food, paleo, ketogenic, and gluten free diets. Blend them into a healthful smoothie, sprinkle them onto yogurt, or stir them into oatmeal to kick start your day. Add them to sauces as a gourmet thickener, or even use them in baked goods as a replacement for egg. Nutiva\'s Chia products are always certified organic, non GMO, unrefined, vegan, raw, and never processed using hexane or other dangerous chemicals. Nutiva was founded in 1999 with a single purpose in mind   to Revolutionize the Way the World Eats. Our role is to produce and promote organic, nutrient dense superfoods that are good for you and good for the planet. Social and environmental responsibility is a core part of Nutiva’s culture and business. From sourcing organic products, to obtaining fair trade certification, to greening our facilities and operations, to funding tree planting at schools in our local community, we are constantly seeking ways to better protect our environment and ensure a better quality of life for employees, customers, and the communities we serve. ',12.50,190,907,'N ','YES','nutivaorganic1.jpg','nutivaorganic2.jpg',NULL,54,'2020-02-20 00:00:00',120,181),('Fresh Ginger Root',21,'Ginger is an essential ingredient used in cuisine all over the world and is also known for its medicinal purposes. The ginger root originated in China and then spread to India and other countries. It contains upto 3% of esesntial oil that creats the fragrance of this spice. The juice from ginger roots is very potent and its pungent taste adds flavor to many dishes and tea. When grounded, ginger powder is commonly used to make gingerbread and other delicious recipes. Ginger is also used to make candy and flavoring cookies, crackers, cake and also carbonated drink (Ginger Ale). In India, fresh ginger is a main spice used when making pulse and lentil curries. Other than cullinary uses, ginger is also known to cure nausea and cold remedies. ',5.99,340,454,NULL,'YES','ginger.jpg',NULL,NULL,200,'2015-02-20 00:00:00',290,182),('Food to Live Organic Walnuts',6,'Organic Walnuts are rich in omega 3 fatty acids. There is no measuring the value of omega 3 fatty acids for your health as they are important for too many processes to count. 72% of all organic walnut fats are monosaturated omega 3 fatty acids, which makes them one of the best plant sources of these essential elements. Note that the main food that contains omega 3 is fatty fish. Walnuts make a great alternative for vegans and vegetarians.',36.48,300,454,NULL,'YES','ftlwalnuts1.jpg','ftlwalnuts2.jpg',NULL,250,'2015-02-20 00:00:00',339,183),('Viva Naturals Ground Flaxseed',7,'As one of the very first crops cultivated by man, flaxseed was traditionally recognized for its exceptionally strong fibers and medicinal properties worldwide. Today, it’s considered one of the most powerful plant foods on the planet. Rich in heart loving omega 3 essential fatty acids, lignans, and both soluble and insoluble fiber, flaxseed bestows health benefits like no other—but to unlock its full potential, it should be eaten in ground or crushed form. Keep ground flaxseed on hand to transform shakes, salads, baked goods, yogurt, oatmeal and more with its delightful nutty taste and nutrient packed punch. ',10.30,79,425,NULL,'YES','vnflaxseed1.jpg','vnflaxseed2.jpg',NULL,76,'2012-02-20 00:00:00',450,184),('All Natural Organic Soft Dried Calimyrna Figs',13,'Amphora Organic Dried Figs are a moist, sweet and tart, read to eat treat.   We use organic Turkish Aydin figs ripened on trees on hillsides warmed by the Mediterranean sun. They are handpicked and dried naturally, with no preservatives or colors added. Then they are gently pasteurized and re hydrated with natural spring water making them soft and delicious! Unlike other dried figs, these are moist and ready to eat. Our figs are a great addition to your healthy breakfast, on your next cheese platter, or just as a wholesome midday snack. Eat well, live well. Buy now! ',24.99,100,700,'5.5 x 0.8 x 5.5 inches','YES','driedfigs1.jpg','driedfigs2.jpg',NULL,67,'2022-02-20 00:00:00',350,185),('Red Onions',10,'Two pounds of locally grown Red Onions. Sliced raw in salads, pickled, added to salsa, sweated as the base for a savory dish, caramelized, roasted, or added to soup, onions are a versatile vegetable that adds savory flavor to so many dishes. Organic Red Onions also nutrient dense. They\'re a good source of vitamin C, and they?re rich in other vitamins and nutrients as well. Grown by local farms such as Denny ',11.50,250,907,'10 x 5 x 10 inches ','YES','redonions.jpg',NULL,NULL,173,'2020-02-20 00:00:00',300,186),('Yellow Onions',12,'Yellow onions are the go to onion and can be used whenever a recipe simply calls for onion. Storing: Onions last for several weeks when kept in a cool, dry, well ventilated place. After an onion is cut, wrap the extra in plastic wrap and put it in the refrigerator for up to 4 days. ',19.25,250,4535,'14 x 10 x 14 inches ','YES','yellowonions.jpg',NULL,NULL,130,'2020-02-20 00:00:00',279,187),('NOW Foods Organic Dried Apricots',14,'For fruit lovers there\'s no more welcome sign of the arrival of summer than Apricots ripening on the branch. These succulent little fruits are more than just a harbinger of warm weather. They\'re one of the best natural sources of vitamin A (beta carotene) you\'ll find, and they\'re also a good source of fiber and potassium. NOW Real Food Organic Apricots are unsweetened and contain no added sulfites, just natural goodness you and your family will love. ',8.99,100,454,'8.8 x 5.6 x 1 inches','YES','organicapricots.jpg',NULL,NULL,75,'2021-02-20 00:00:00',272,188),('Garlic Bulb',21,'NON GMO. HEIRLOOM. GROWN NATURALLY WITHOUT THE USE OF CHEMICALS AND PESTICIDES AT MY SEED FARM, HARVESTED AND PACKAGED BY HAND IN RESEALABLE AIR TIGHT BAGS (EACH BAG IS INDIVIDUALLY LABELED). EACH PURCHASE INCLUDES A FULL PAGE SEED FACT SHEET AND PLANTING/GROWING INSTRUCTIONS. ALL SEED LOTS ARE TESTED FOR GERMINATION. Approximately 8 cloves per bulb Early season garlic harvest! This is likely the most commonly grown variety in the U.S., and for good reason. It is a large, easy to grow softneck, with a nice mild flavor and excellent storage ability. Cal Early is one of our work horse” varieties we depend on, year after year, for fresh market and garlic braiding. The skins are a nice off white with a purple blush and it produces 8 10 cloves per head. Product Details Zones: 3 9 Planting Depth: Plant individual cloves with the scab end down and the pointed end up, one to two inches deep in well worked beds. Spacing: 4 apart in same row. Place 36 between separate rows. Sun/Shade: Full Sun When to Plant:Plant 4 6 weeks before frost. Early mid Spring. Will develop in spring. or plant in spring for mid late summer harvest.',8.74,300,255,'3 x 4 x 1 inches ','YES','garlicbulb.jpg',NULL,NULL,200,'2015-02-20 00:00:00',134,189),('Vega One Organic Meal Replacement Plant Based Protein Powder',8,'Vega One Organic All in One Shake, Plant Based Non Dairy Protein Powder, Chocolate, 1.9 pounds, 17 Servings. ',40.79,120,708,'5.2 x 5.2 x 9.1 inches','YES','vegaone.jpg',NULL,NULL,57,'2020-02-20 00:00:00',144,195),('NOW Sports Nutrition Organic Pea Protein',14,'Peas are well known for being a source of highly bioavailable protein. Additionally, peas are not considered one of the major dietary allergens. Collectively, this makes pea protein an ideal source of post workout nutrition for athletes who may have difficulty supplementing with other types of protein. NOW® Sports Organic Pea Protein is a non GMO vegetable protein isolate that has 15 grams of easily digested protein. Each 2 scoop serving typically has over 2,700 mg of branched chain amino acids, and over 1,300 mg of arginine. NOW® Sports Organic Pea Protein is pure and natural, unflavored, and mixes easily into your favorite beverages. ',26.14,340,853,'5.5 x 5.5 x 7.8 inches','YES','nowsportspea.jpg',NULL,NULL,114,'2015-02-20 00:00:00',120,196),('Beautifully Bamboo Organic Bamboo Silica Extract Power',13,'Enjoy the Silica Rich Goodness from the Fastest Growing Plant in the World. Silica fortifies our bones, strengthens nails, helps the skin produce/maintain collagen and creates thicker hair. Maximize your internal beauty routine by adding this fine powder to any beverage. Enjoy the many benefits at bamboo has to offer. ',14.50,300,90,NULL,'YES','organicbamboo1.jpg','organicbamboo2.jpg',NULL,124,'2017-02-20 00:00:00',45,197),('UpNature Baobab Essential Oil',14,'Baobab Oil can help your skin! Thanks to its many nourishing ingredients that have to ability to heal the skin from deep within. As the oil is rich in many different vitamins, it does an incredible job at combating the early signs of aging, and due to its anti inflammatory properties, it can reduce redness and inflammation. ',17.99,275,250,NULL,'YES','boababoil1.jpg','boababoil2.jpg','boababoil3.jpg',200,'2022-02-20 00:00:00',244,198),('ALOHA Organic Plant Based Protein Bars',15,'At ALOHA, we believe that plants are the ultimate source of nourishment, and that real foods should be really convenient. So when you’re looking for a great tasting, organic, plant based protein boost, we’ve got you covered. ALOHA protein bars use simple, organic ingredients that are naturally packed with the tools your body needs to do its best: protein, iron, fiber, and healthy fats. With 14g clean protein and only 4g of natural sugar, ALOHA’s protein bars are the perfect, healthy snack to tide you over. Our thoughtfully selected, plant based protein is sourced from a balanced mix of organic pumpkin seed and organic brown rice, to deliver steady energy that will carry you through the day without the dreaded sugar crash. ALOHA’s organic, plant based products are vegan, non GMO, gluten free, soy free, dairy free (lactose free), stevia free, high protein, Kosher Certified and USDA certified organic. ALOHA checks the all the boxes, so you can enjoy a tasty, nutritious snack without hesitation. All of our protein bars and protein products are made free of artificial ingredients and free of sugar alcohols, because we know that what you eat and how you feel are intimately connected. ALOHA’s organic, plant based Peanut Butter Chocolate Chip protein bars use a short line of organic, whole food ingredients that are delicious and self explanatory: like real, organic chocolate chips, organic peanuts, organic roasted pumpkin seeds, of sea salt. The perfect protein bar for when you’re between meetings, warming up for the gym (or cooling down!), on the road, taking a pit stop on your weekend cycle, or looking for an easy, nutritious option at home. The search for a healthy, satisfying, go to snack is over: sit back and enjoy a great tasting, rejuvenating ALOHA protein bar. ',19.50,445,454,'6.5 x 5.2 x 2 inches','YES','alohabar.jpg',NULL,NULL,390,'2012-02-20 00:00:00',427,199),('Organic Earth Body Cell Food',16,'Combined has 92 of the nutrients and minerals that the body needs. Burdock Root adds another 10 percent to make it a complete body supplement of 102 MINERALS. Each bag of 8 ounces of powder is professionally packed and sealed here in the United States for safety and freshness. Is a source of potassium chloride, a nutrient which helps to dissolve catarrhs (inflammation and phlegm in the mucous membranes), which cause congestion. It also contains compounds which act as natural antimicrobial and antiviral agents, helping to get rid of infections. Helps with arthritis, joint pain, hardening of the arteries(arteriosclerosis), digestive disorders, heartburn, blood cleansing, constipation, bronchitis, emphysema, urinary tract disorders, and anxiety. Other uses include boosting the immune system and increasing energy. Is a blood purifier, lymphatic system strengthener, natural diuretic. It also helps improve arthritis. ',34.99,200,227,NULL,'YES','bodyfood.jpg',NULL,NULL,142,'2017-02-20 00:00:00',340,200),('Santa Cruz Organic Dark Roasted Creamy Peanut Butter Spread',17,'Light and dark roasts aren\'t just for coffee anymore. Santa Cruz Organic peanut butters are offered in both light and dark roasted, creamy and crunchy varieties. Made with certified USDA organic Spanish peanuts, these peanut butters not only taste great, they also contain no hydrogenated oils and no artificial ingredients. ',12.38,290,454,' 3.2 x 3.2 x 4.9 inches ','YES','santacruz1.jpg','santacruz2.jpg',NULL,150,'2015-02-20 00:00:00',192,201),('Wild Planet Organic Roasted Chicken Breast',18,'Roasted right in the can without added water or liquids, Wild Planet Organic Roasted Chicken Breast has that delicious, savory, rotisserie taste that can be enjoyed on its own or in your favorite recipe. Skinless and boneless, Wild Planet chicken can be easily added to salads, burritos or soups for a quick, easy, delicious, and nutritious meal. Our cooking method allows the chicken to retain its natural flavor, nutrients, and moisture content. Wild Planet chicken is never injected with fillers, liquids, or additives, so enjoy this essential source of protein knowing exactly what you\'re getting: 100% certified organic, free range chicken. USDA certified organic free range chicken, No added water, liquids, modifying starches, or other additives, Certified Humane Raised and Handled, Flavorful natural juices remain with the chicken to mix back in for serving, No need to drain – 100% chicken in its own juice, compared to other canned chicken, which usually contains up to 40% water and often, processing additives, Paleo friendly, keto friendly. With our belief that a healthy planet is comprised of living water and living soil, we have expanded our product line to include our first land based product – Organic Roasted Chicken Breast. This premium chicken is raised on an organic diet — including non GMO corn grown on land that is free of chemical fertilizers, herbicides and pesticides.',3.85,340,142,NULL,'YES','wildplanet.jpg',NULL,NULL,110,'2020-02-20 00:00:00',231,202),('Pura D\'or Organic Sweet Almond Oil',5,' Sweet Almond Oil is a natural source of vitamins and nutrients that keep your skin cells healthy and protect your skin from environmental toxins that can damage the skin as well as your hair. Multiple benefits of using Sweet Almond Oil can be appreciated by those with oily, dry, and sensitive skin and hair. Carrier oils are pressed from fatty portions of the plant such as the seeds, nuts, or kernels. They often have a faint sweet nutty aroma to odorless. It makes essential oils be “carried” smoothly and safely to your skin. Argan Carrier Oil makes essential oils safe for topical application by itself and can be used to help dry areas or soothe minor irritations, or even as a full body moisturizer and addition to your daily skincare regimen. ',14.99,427,454,NULL,'YES','purador1.jpg','purador2.jpg',NULL,113,'2022-02-20 00:00:00',200,203),('Garden of Life Raw Organic Protein Vanilla Powder',10,'Unlock the nutritive power of living grains and seeds with Garden of Life RAW Organic Protein —a certified organic, RAW, vegan protein powder. Featuring 13 RAW and organic sprouts, RAW Organic Protein is an excellent source of complete protein—providing 22 grams and 34% of the Daily Value—including all essential amino acids. RAW Organic Protein contains RAW Food Created fat soluble vitamins A, D, E and K and supports digestive health and function with live probiotics and protein digesting enzymes. ',34.89,100,620,'5.2 x 5.2 x 9.2 inches','YES','proteinvanilla.jpg',NULL,NULL,70,'2017-02-20 00:00:00',422,204);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rating` decimal(2,1) NOT NULL,
  `review` text,
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop` (
  `email` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `FnameOfOwner` varchar(35) NOT NULL,
  `LnameOfOwner` varchar(35) NOT NULL,
  `phoneNumber` varchar(13) DEFAULT NULL,
  `nameOfShop` varchar(255) NOT NULL,
  `country` varchar(45) NOT NULL,
  `region` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES ('ahmedokiyale17@gmail.com','Beastforlife ','2020-02-12 00:00:00','Ahmed','Mohammed','0249331555','PurestQuality','Ghana','Volta','Sogakope\r',2),('Modeeny1@gmail.com','Justlaugh','2020-02-12 00:00:00','Abdulai','Mohammed','0266644097','Earth Hearted','Ghana','Accra','Circle',3),('ishmaelagbenya77@gmail.com','Youngish1','2020-02-12 00:00:00','Ishmeal','Agbenya ','0501656670','GreenLife','Ghana','Eastern','Koforidua\r',4),('twumgilbert7@gmail.com','Flash','2020-02-13 00:00:00','Gilbert','Twum','0245453642','SuperGrowth','Ghana','Accra','Marina\r',5),('fmeef20@gmail.com','Password1234','2020-02-13 00:00:00','Eugene','Fredua','0203438359','Healthgod','Ghana','Accra','Lapaz\r',6),('essiamah20@gmail.com','Ben1234','2020-02-13 00:00:00','Bernard','Essiamah','0240157738','LiveHealthy','Ghana','Accra','Adenta\r',7),('Agyengo860@gmail.com','Agyengo247','2020-02-13 00:00:00','Yaw','Agyemang','0553881709','Fruityard ','Ghana','Ashanti','Bantama\r',8),('Mens@gmail.com','Incorrect','2020-02-13 00:00:00','John','Mensah','0201122335','FarmBasket','Ghana','Accra','Mallam\r',9),('Nanaaba@gmail.com','ghana57','2020-02-13 00:00:00','Aba','Stones','0554242312','CraveBetter','Ghana','Oti','Jamestown\r',10),('Iketon@hotmail.com','Livinglife','2020-02-14 00:00:00','Isaac','Lesley','0541235654','HelloRaw','Ghana','Ashanti','Ahoudjo\r',11),('Tera@yahoo.com','Hellothere','2020-02-15 00:00:00','Enoch','Anson','0278845331','Natures Basket','Ghana','Northern','Wale',12),('hello3@gmail.com','knowledge','2020-02-14 00:00:00','Hilda','Stevens','0506717837','GreenOrganica','Ghana','Accra','Accra\r',13),('Baba1@yahoo.com','keystone','2020-02-14 00:00:00','Martha','Lartey','0573728199','Nutrivano','Ghana','Volta','Ho\r',14),('Deen@gmail.com','Godisking','2020-02-14 00:00:00','Kofi','Ahmed','0509213723','Naturalness','Ghana','Central','Abura\r',15),('James@gmail.com','hallame','2020-02-14 00:00:00','James','Scotts','0243271683','Upgrows','Ghana','Ashanti','Kejetia\r',16),('InkoomG@gmail.com','godisking','2020-02-15 00:00:00','Gladys','Inkoom','0576243918','Vitalful','Ghana','Accra','Spintex\r',17),('LydiaH@gmail.com','mybaby','2020-02-16 00:00:00','Lydia','Hilton','0507251635','PeakNutrition','Ghana','Central','Winneba\r',18),('bafpep@gmail.com','qwerty1234','2020-06-26 17:21:57','Enoch','Baffoe','0577858781','Tera Shop','Ghana','Greater Accra','Tesano',21);
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(128) NOT NULL,
  `dateCreated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Fname` varchar(35) NOT NULL,
  `Lname` varchar(35) NOT NULL,
  `phoneNumber` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'bafpep@gmail.com','12345678','2020-06-28 22:00:02','Enoch','Baffoe','0577858781'),(5,'godTera@gmail.com','12345678','2020-06-29 20:13:29','Enoch','Baffoe','0501659244');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('jon','dow');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  UNIQUE KEY `userId` (`userId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (4,183),(4,199);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-29 23:38:14
