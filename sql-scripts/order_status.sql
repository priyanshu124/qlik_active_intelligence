Drop Table if exists order_status;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table order_status (
    order_status_id int(11) NOT NULL AUTO_INCREMENT,
    order_status varchar(60) DEFAULT NULL,
    PRIMARY KEY(order_status_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/order_status.csv'
INTO TABLE order_status
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   order_status
    )
Set order_status_id=null;

Select * from order_status;


