-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: burgertime
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

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
-- Table structure for table `customerOrder`
--

DROP TABLE IF EXISTS `customerOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerOrder` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `orderTime` timestamp NULL DEFAULT NULL,
  `orderType` enum('dine in','take out') DEFAULT NULL,
  `totalPrice` decimal(6,2) DEFAULT NULL,
  `customerName` varchar(64) DEFAULT NULL,
  `specialRequests` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerOrder`
--

LOCK TABLES `customerOrder` WRITE;
/*!40000 ALTER TABLE `customerOrder` DISABLE KEYS */;
INSERT INTO `customerOrder` VALUES (46,'2021-12-02 16:11:24','take out',13.00,'Nick',''),(47,'2021-12-02 16:17:13','dine in',24.50,'Hunter','Make the Ketup '),(51,'2021-12-02 23:22:43','dine in',18.50,'Sean',''),(52,'2021-12-02 23:23:23','take out',13.50,'Jeremy',''),(53,'2021-12-02 23:23:54','dine in',37.00,'Vinny',''),(54,'2021-12-03 00:01:58','take out',10.50,'Bob',''),(55,'2021-12-04 17:07:48','take out',12.50,'Kinzer',''),(56,'2021-12-04 20:22:48','take out',17.50,'Customer','Extra cheese on the pizza please!'),(57,'2021-12-05 05:34:20','take out',4.00,'Bola','');
/*!40000 ALTER TABLE `customerOrder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jt`@`%`*/ /*!50003 TRIGGER `orderLogger` AFTER INSERT ON `customerOrder` FOR EACH ROW INSERT INTO debug VALUES (NEW.orderID) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `debug`
--

DROP TABLE IF EXISTS `debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debug` (
  `newOrderID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug`
--

LOCK TABLES `debug` WRITE;
/*!40000 ALTER TABLE `debug` DISABLE KEYS */;
INSERT INTO `debug` VALUES (38),(38),(38),(38),(38),(39),(40),(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),(61),(62),(63),(64),(65),(66),(67),(68),(69);
/*!40000 ALTER TABLE `debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dishIngredient`
--

DROP TABLE IF EXISTS `dishIngredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishIngredient` (
  `dishID` int NOT NULL,
  `inventoryID` int NOT NULL,
  `ingredientQuantity` int DEFAULT NULL,
  PRIMARY KEY (`dishID`,`inventoryID`),
  KEY `inventoryID` (`inventoryID`),
  CONSTRAINT `dishIngredient_ibfk_1` FOREIGN KEY (`dishID`) REFERENCES `dishes` (`dishID`),
  CONSTRAINT `dishIngredient_ibfk_2` FOREIGN KEY (`inventoryID`) REFERENCES `inventory` (`inventoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishIngredient`
--

LOCK TABLES `dishIngredient` WRITE;
/*!40000 ALTER TABLE `dishIngredient` DISABLE KEYS */;
INSERT INTO `dishIngredient` VALUES (1,1,1),(1,2,1),(2,5,3),(2,9,10),(2,10,10),(2,12,1),(3,24,1),(4,11,1),(5,13,1),(6,1,1),(6,3,1),(7,1,1),(7,14,1),(9,9,4),(9,15,2),(10,9,2),(10,16,4),(11,18,1),(12,13,1),(13,11,1),(13,19,1),(14,17,1),(15,23,1),(16,22,1),(17,21,4);
/*!40000 ALTER TABLE `dishIngredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
  `dishID` int NOT NULL AUTO_INCREMENT,
  `dishName` varchar(64) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `dishType` enum('entree','side','drink') DEFAULT NULL,
  PRIMARY KEY (`dishID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

LOCK TABLES `dishes` WRITE;
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` VALUES (1,'Hamburger','A juicy quarter-pounder on brioche bun with crisp lettuce and fresh tomato',5.00,'entree'),(2,'Pepperoni Pizza','10 slices, enough to feed a small group',10.00,'entree'),(3,'Sweet Tea','Brewed fresh every day',1.00,'drink'),(4,'Pepsi Max','Refreshing diet pepsi taste!',1.50,'drink'),(5,'Fries','Crispy and fresh',2.00,'side'),(6,'Turkeyburger','Like a hamburger but better!',6.00,'entree'),(7,'Grilled Chicken Sandwich','Also called the Colby Special!',4.00,'entree'),(9,'Grilled Cheese','Ooey gooey cheems!',2.50,'entree'),(10,'Mac \'n Cheese','Ooey gooey cheems!',2.00,'side'),(11,'Coleslaw','Cabbage!',1.00,'side'),(12,'Mashed Potaters','Look ma, no skin!',1.50,'side'),(13,'Pilk','Luxury Life Choice',15.00,'drink'),(14,'Water','Boring, but good for you',1.00,'drink'),(15,'Mountain Dew','Yellow 5 in my veins!',0.50,'drink'),(16,'Dr. Pepper','What flavor?',2.50,'drink'),(17,'Corn','Ohio\'s crop!',1.50,'side');
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventoryID` int NOT NULL AUTO_INCREMENT,
  `inventoryName` varchar(64) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `unit` enum('self','cups','pounds','ounces') DEFAULT NULL,
  PRIMARY KEY (`inventoryID`),
  UNIQUE KEY `inventoryName` (`inventoryName`),
  KEY `idx_invenName` (`inventoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'buns',200,'self'),(2,'beef patty',205,'self'),(3,'turkey patty',198,'self'),(4,'lettuce',200,'self'),(5,'tomatoes',167,'self'),(9,'cheese',76,'ounces'),(10,'pepperoni',90,'ounces'),(11,'Pepsi Max',165,'self'),(12,'dough',189,'pounds'),(13,'potatoes',189,'self'),(14,'chicken',198,'pounds'),(15,'Bread',198,'self'),(16,'Macaroni',180,'ounces'),(17,'Water',198,'cups'),(18,'Coleslaw',198,'cups'),(19,'Milk',67,'cups'),(21,'Corn',200,'ounces'),(22,'Dr. Pepper',198,'cups'),(23,'Mountain Dew',199,'cups'),(24,'Sweet Tea',199,'cups');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderItems`
--

DROP TABLE IF EXISTS `orderItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderItems` (
  `orderID` int NOT NULL,
  `dishID` int NOT NULL,
  `dishQuantity` int DEFAULT NULL,
  PRIMARY KEY (`orderID`,`dishID`),
  KEY `dishID` (`dishID`),
  CONSTRAINT `orderItems_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `customerOrder` (`orderID`),
  CONSTRAINT `orderItems_ibfk_2` FOREIGN KEY (`dishID`) REFERENCES `dishes` (`dishID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderItems`
--

LOCK TABLES `orderItems` WRITE;
/*!40000 ALTER TABLE `orderItems` DISABLE KEYS */;
INSERT INTO `orderItems` VALUES (46,2,1),(46,10,1),(46,14,1),(47,1,1),(47,5,1),(47,13,1),(47,16,1),(51,2,1),(51,6,1),(51,11,1),(51,12,1),(52,2,1),(52,4,1),(52,5,1),(53,2,1),(53,3,1),(53,7,1),(53,10,1),(53,11,1),(53,12,1),(53,13,1),(53,16,1),(54,1,1),(54,4,1),(54,5,1),(54,10,1),(55,2,1),(55,5,1),(55,15,1),(56,2,1),(56,5,1),(56,9,1),(56,10,1),(56,14,1),(57,5,1),(57,10,1);
/*!40000 ALTER TABLE `orderItems` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jt`@`%`*/ /*!50003 TRIGGER `updateInventory` AFTER INSERT ON `orderItems` FOR EACH ROW UPDATE orderItems NATURAL JOIN dishIngredient NATURAL JOIN inventory SET quantity = quantity - ingredientQuantity * dishQuantity WHERE orderID=NEW.orderID AND dishID=NEW.dishID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `employeeID` int NOT NULL AUTO_INCREMENT,
  `employeeName` varchar(64) DEFAULT NULL,
  `employeePosition` enum('manager','waitstaff','chef','assistant manager') DEFAULT NULL,
  `wage` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'JT','manager',20.00),(2,'Colby','chef',18.00),(3,'Tyler','assistant manager',19.00),(4,'Omo','chef',17.50),(5,'Mehdi','waitstaff',9.00),(6,'Sarah','waitstaff',9.00),(7,'Anthony','waitstaff',9.00);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `staffNames`
--

DROP TABLE IF EXISTS `staffNames`;
/*!50001 DROP VIEW IF EXISTS `staffNames`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `staffNames` AS SELECT 
 1 AS `employeeID`,
 1 AS `employeeName`,
 1 AS `employeePosition`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `timeclock`
--

DROP TABLE IF EXISTS `timeclock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeclock` (
  `employeeID` int NOT NULL,
  `clockTime` timestamp NOT NULL,
  `clockType` enum('in','out') DEFAULT NULL,
  PRIMARY KEY (`employeeID`,`clockTime`),
  CONSTRAINT `timeclock_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `staff` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeclock`
--

LOCK TABLES `timeclock` WRITE;
/*!40000 ALTER TABLE `timeclock` DISABLE KEYS */;
INSERT INTO `timeclock` VALUES (1,'2021-12-02 17:19:50','in'),(1,'2021-12-06 02:21:00','in'),(1,'2021-12-06 20:58:23','out'),(2,'2021-12-06 20:58:24','out'),(3,'2021-12-06 20:58:25','out'),(4,'2021-12-06 20:58:26','out'),(4,'2021-12-06 20:58:48','out'),(5,'2021-12-03 02:10:04','in'),(5,'2021-12-03 02:10:27','out'),(5,'2021-12-06 20:58:28','out'),(6,'2021-12-06 20:58:29','out');
/*!40000 ALTER TABLE `timeclock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `staffNames`
--

/*!50001 DROP VIEW IF EXISTS `staffNames`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`colby`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `staffNames` AS select `staff`.`employeeID` AS `employeeID`,`staff`.`employeeName` AS `employeeName`,`staff`.`employeePosition` AS `employeePosition` from `staff` */;
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

-- Dump completed on 2021-12-06 21:27:41
