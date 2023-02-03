use qlik_db;
select * from orders
order by order_id desc;

SELECT @max_order_items:= max(no_of_items) from (SELECT SUM(item_quantity) as no_of_items from order_item group by order_id) as no_of_items;
SELECT @min_order_items:= min(no_of_items) from (SELECT SUM(item_quantity) as no_of_items from order_item group by order_id) as no_of_items;

DELIMITER //
drop procedure if exists gen_order_item_data;
CREATE PROCEDURE gen_order_item_data()
BEGIN
	
	DECLARE n INT DEFAULT 1;
  
	SELECT @max_order:= max(order_id) FROM orders ;
    
    SELECT @max_product_id:= max(product_id) FROM products ;
    SELECT @min_product_id:= MIN(product_id) FROM products ;
    
    SELECT @max_discount_rate:= max(discount_rate) FROM order_item ;
    SELECT @min_discount_rate:= min(discount_rate) FROM order_item ;
    
    Select @product_id_inserted := @min_product_id + ceil(rand()*(@max_product_id - @min_product_id))
    ;
    
    #profit_ratio
    Select @min_profit_ratio := -0.5;
	Select @max_profit_ratio := max(profit_ratio) from (SELECT profit_ratio FROM order_item WHERE product_id=@product_id_inserted) as pr;
    
    
    if @product_id_inserted in (SELECT product_id from order_item WHERE order_id = @max_order) THEN
		#item_quantity
		UPDATE order_item
		set item_quantity = item_quantity + 1 where order_id = @max_order and product_id = @product_id_inserted;
	ELSE
    
		INSERT INTO order_item (order_id, product_id, discount_rate, profit_ratio, item_quantity)
		VALUES(
			@max_order,
			@product_id_inserted,
			@min_discount_rate + rand()*(@max_discount_rate - @min_discount_rate),
			@min_profit_ratio + rand()*(@max_profit_ratio - @min_profit_ratio),
			n
			);
		
		UPDATE order_item left join products on order_item.product_id = products.product_id
		SET 
			order_item.order_item_total = products.product_price*order_item.item_quantity,
			order_item.sales = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity,
			order_item.profits = products.product_price*(1-order_item.discount_rate)*order_item.item_quantity*order_item.profit_ratio
		where 
			order_id =@max_order;
   
   END IF;
   
END //

DELIMITER ;
Start transaction;
call gen_order_item_data;
select * from order_item
order by order_item_id desc;
rollback;