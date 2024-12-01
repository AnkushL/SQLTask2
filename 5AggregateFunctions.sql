-- Task1: Calculate the total number of orders placed by all customers.
select count(order_id) as total_orders from orders;

-- Task2: Find the total revenue generated from orders paid via 'UPI' from the orders table.
select sum(order_amount) from orders where payment_mode = 'UPI';

-- Task3: Get the average price of all products in the products table
select avg(price) as average_price from products;

-- Task4: Find the maximum and minimum total price of orders placed in 2023.
select max(oi.total_price), min(oi.total_price)
	from orders o
	join order_items oi on o.order_id = oi.order_id
	where extract(year from o.order_date) = 2023;

-- Task5: Calculate the total quantity of products ordered for each product_id using the order_items table.
select product_id, sum(quantity) as total_quantity_orders
	from order_items group by product_id;