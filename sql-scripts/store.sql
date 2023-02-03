Drop Table if exists stores;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table stores (
    store_id int(11) NOT NULL AUTO_INCREMENT,
    store_street varchar(100) DEFAULT NULL,
    store_city varchar(80) DEFAULT NULL,
    store_state varchar(20) DEFAULT NULL,
    store_country varchar(60) DEFAULT NULL,
    order_zipcode varchar(20) DEFAULT NULL,
    latitude Decimal(8,6) DEFAULT NULL,
    longitude Decimal(9,6) DEFAULT NULL,
    PRIMARY KEY(store_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/store.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   
    store_street,
    store_city,
    store_state,
    store_country,
    order_zipcode,
    latitude,
    longitude
    )
Set store_id=null;

Select * from stores;


