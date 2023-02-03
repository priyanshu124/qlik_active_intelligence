use qlik_db;
Drop Table if exists tran_type;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table tran_type (
    tran_type_id int(11) NOT NULL AUTO_INCREMENT,
    tran_type varchar(60) DEFAULT NULL,
    PRIMARY KEY(tran_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tran_type` WRITE;
/*!40000 ALTER TABLE `tran_type` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/tran_type.csv'
INTO TABLE tran_type
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   tran_type
    )
Set tran_type_id=null;

Select * from tran_type;


