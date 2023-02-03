Drop Table if exists shipping_mode;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table shipping_mode (
    shipping_mode_id int(11) NOT NULL AUTO_INCREMENT,
    shipping_mode varchar(60) DEFAULT NULL,
    scheduled_days_for_shipping Integer DEFAULT NULL,
    PRIMARY KEY(shipping_mode_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `shipping_mode` WRITE;
/*!40000 ALTER TABLE `shipping_mode` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/shipping_mode.csv'
INTO TABLE shipping_mode
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   shipping_mode,
	scheduled_days_for_shipping
    )
Set shipping_mode_id=null;

Select * from shipping_mode;


