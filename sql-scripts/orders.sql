use qlik_db;
Drop Table if exists orders;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table orders (
    order_id int(11) NOT NULL AUTO_INCREMENT,
    order_region_id Integer NOT NULL,
    tran_type Integer DEFAULT NULL,
    order_status Integer DEFAULT NULL,
    customer_id Integer DEFAULT NULL,
    store_id Integer DEFAULT NULL,
    shipping_mode_id Integer DEFAULT NULL,
    order_date DATETIME DEFAULT NULL,
    shipping_date DATETIME DEFAULT NULL,
    real_days_for_shipping Integer DEFAULT NULL,
    scheduled_days_for_shipping Integer DEFAULT NULL,
    PRIMARY KEY(order_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   
    order_region_id,
    tran_type,
    order_status,
    customer_id,
    store_id,
    shipping_mode_id,
    order_date,
    shipping_date,
    real_days_for_shipping,
    scheduled_days_for_shipping
    )
Set order_id=null;

Select * from orders;


update orders 
	set order_date = 
		Case 
			when position("/" in order_date)>0 then
			str_to_date(order_date, "%c/%e/%Y %T:%i")
			when position("-" in order_date)>0 then 
			str_to_date(order_date, "%m-%d-%Y %T:%i")
		end;
		
	set shipping_date = 
		Case 
			when position("/" in shipping_date)>0 then
			str_to_date(shipping_date, "%c/%e/%Y %T:%i")
			when position("-" in shipping_date)>0 then 
			str_to_date(shipping_date, "%m-%d-%Y %T:%i")
		end;
 ;   