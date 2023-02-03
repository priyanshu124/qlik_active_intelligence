Drop Table if exists products;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table products (
    product_id int(11) NOT NULL AUTO_INCREMENT,
    product_card_code Integer NOT NULL,
    product_image varchar(100) DEFAULT NULL,
    product_name varchar(80) DEFAULT NULL,
    department_id Integer DEFAULT NULL,
    department_name varchar(60) DEFAULT NULL,
    category_id Integer DEFAULT NULL,
    category_name varchar(60) DEFAULT NULL,
    product_price Decimal(10,5) DEFAULT NULL,
    PRIMARY KEY(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   
    product_image,
    product_name,
    department_id,
    department_name,
    category_id,
    category_name,
    product_price
    )
Set product_id=null;

Select * from products;


