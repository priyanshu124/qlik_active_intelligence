use qlik_db;
Drop Table if exists order_item;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
Create table order_item (
    order_item_id int(11) NOT NULL AUTO_INCREMENT,
    order_id Integer NOT NULL,
    product_id Integer NOT NULL,
    discount_rate decimal(8,5) DEFAULT NULL,
    profit_ratio decimal(8,5) DEFAULT NULL,
    item_quantity Integer DEFAULT NULL,
    order_item_total decimal(12,5) DEFAULT NULL,
    sales decimal(12,5) DEFAULT NULL,
    profits decimal(12,5) DEFAULT NULL,
    PRIMARY KEY (order_item_id)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;

LOAD DATA INFILE '/var/lib/mysql-files/datasets/order_item.csv'
INTO TABLE order_item
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   
	order_id,
    product_id,
    discount_rate,
    profit_ratio,
    item_quantity
    )
Set order_item_id=null;

LOCK TABLES `order_item` WRITE, `products` READ;
UPDATE order_item left join products on order_item.product_id = products.product_id
    SET 
		order_item.order_item_total = products.product_price*order_item.item_quantity,
		order_item.sales = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity,
		order_item.profits = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity*order_item.profit_ratio;




DELIMITER //
CREATE TRIGGER populate_order_item
    AFTER INSERT
    ON order_item FOR EACH ROW
BEGIN 
	LOCK TABLES `order_item` WRITE, `products` READ;
	UPDATE order_item left join products on order_item.product_id = products.product_id
    SET 
		order_item.order_item_total = products.product_price*order_item.item_quantity,
		order_item.sales = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity,
		order_item.profits = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity*order_item.profit_ratio;

END//

DELIMITER ;
select * from order_item;

