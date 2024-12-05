-- Task1: Get the list of customers who have placed orders in both 2022 and 2023 (use INTERSECT).
select customer_id, customer_name, email, phone_number, city from customers where customer_id in (select customer_id from orders where extract(year from order_date) = 2022
intersect
select customer_id from orders where extract(year from order_date) = 2023);


-- Task2: Find the products that were ordered in 2022 but not in 2023 (use EXCEPT).
select product_id, product_name, category, price from products 
	where product_id in (
		select product_id from order_items oi
		join orders o on oi.order_id = o.order_id
		where extract(year from order_date) = 2022
		except
		select product_id from order_items oi
		join orders o on oi.order_id = o.order_id
		where extract(year from order_date) = 2023
	);


-- Task3: Display the list of supplier_city from the products table that do not match any customer_city in the customers table (use EXCEPT).
select supplier_city from products
except
select city from customers;


-- Task4: Show a combined list of supplier_city from products and city from customers (use UNION).
select supplier_city from products
union
select city from customers;


-- Task5: Find the list of product_name from the products table that were ordered in 2023 (use INTERSECT with the orders and order_items tables).
select product_id, product_name from products
	where product_id in (
		select product_id from products
		intersect
		select product_id from order_items oi
		join orders o on oi.order_id = o.order_id
		where extract(year from order_date) = 2023
	);