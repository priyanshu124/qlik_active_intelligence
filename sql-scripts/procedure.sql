use qlik_db;

DROP PROCEDURE IF EXISTS generate_data;
DELIMITER //
CREATE PROCEDURE generate_data()
BEGIN
	DECLARE item int DEFAULT 1;
    DECLARE i int DEFAULT 1;
	SELECT @min_customer_id:= min(customer_id)  FROM customers;
	SELECT @max_customer_id:= max(customer_id)  FROM customers;
    
    SELECT @min_order_region_id:= min(order_region_id)  FROM order_region;
	SELECT @max_order_region_id:= max(order_region_id)  FROM order_region;
    
    SELECT @min_order_status_id:= min(order_status_id)  FROM order_status;
	SELECT @max_order_status_id:= max(order_status_id)  FROM order_status;
    
    SELECT @min_product_id:= min(product_id)  FROM products;
	SELECT @max_product_id:= max(product_id)  FROM products;
    
    SELECT @min_shipping_mode_id:= min(shipping_mode_id)  FROM shipping_mode;
	SELECT @max_shipping_mode_id:= max(shipping_mode_id)  FROM shipping_mode;
    
    SELECT @min_store_id:= min(store_id)  FROM stores;
	SELECT @max_store_id:= max(store_id)  FROM stores;
    
    SELECT @min_tran_type_id:= min(tran_type_id)  FROM tran_type;
	SELECT @max_tran_type_id:= max(tran_type_id)  FROM tran_type;
    
   
    SELECT @latest_order_date:= max(order_date) FROM orders ;
    
    
    INSERT INTO orders (order_region_id, tran_type, customer_id, store_id, shipping_mode_id, order_date)
	VALUES(
		@min_order_region_id + ceil(rand()*(@max_order_region_id - @min_order_region_id)),
		@min_tran_type_id + ceil(rand()*(@max_tran_type_id - @min_tran_type_id)),
        @min_customer_id + ceil(rand()*(@max_customer_id - @min_customer_id)),
        @min_store_id + ceil(rand()*(@max_store_id - @min_store_id)),
		@min_shipping_mode_id + ceil(rand()*(@max_shipping_mode_id - @min_shipping_mode_id)),
		DATE_ADD(@latest_order_date, INTERVAL CEIL(RAND()*10) MINUTE)
        );
	SELECT @max_order_items:= 10;
	SELECT @min_order_items:= 1;

	set i = 1;
    WHILE i <= @min_order_items+ceil((@max_order_items-@min_order_items)*rand())
	DO	call gen_order_item_data();
		set i = i+1;
	END WHILE;
    
    
    
END //

DELIMITER ;

SET autocommit=0;


DELIMITER //
DROP PROCEDURE IF EXISTS call_generate;
CREATE procedure call_generate()
BEGIN
	DECLARE i int;
    set i = 1;
    WHILE i <= ceil(30*rand())
	DO	call generate_data();
		set i = i+1;
	END WHILE;
END //

START TRANSACTION;
DELIMITER ;
call call_generate;

    
SELECT * FROM orders 
where order_id > 65752
order by order_id desc;    

SELECT * FROM order_item
where order_item_id > 180519
order by order_id desc;    

delete  FROM orders 
where order_id > 65752;   

delete  FROM order_item
where order_item_id > 180519;    

SELECT * FROM products
where product_id = 57;