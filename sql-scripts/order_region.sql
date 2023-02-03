Drop Table if exists order_region;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table order_region (
    order_region_id int(11) NOT NULL AUTO_INCREMENT,
    order_region varchar(60) DEFAULT NULL,
    order_state varchar(80) DEFAULT NULL,
    order_city varchar(80) DEFAULT NULL,
    order_country varchar(80) DEFAULT NULL,
    order_zipcode varchar(20) DEFAULT NULL,
    market varchar(60) DEFAULT NULL,
    PRIMARY KEY(order_region_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_region` WRITE;
/*!40000 ALTER TABLE `order_region` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/order_region.csv'
INTO TABLE order_region
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   order_region,
    order_state,
    order_city,
    order_country,
    order_zipcode,
    market
    )
Set order_region_id=null;

Select * from order_region;


