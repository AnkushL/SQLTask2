-- Task1: List all customers sorted by customer_name in ascending order.
select customer_name from customers order by customer_name;

-- Task2: Display all orders sorted by total_price in descending order.
select o.*, oi.total_price from orders o 
	join order_items oi on o.order_id = oi.order_id
	order by oi.total_price desc;

	-- By Left Join
	--select o.*, oi.total_price from orders o 
	--left join order_items oi on o.order_id = oi.order_id
	--order by oi.total_price desc;


-- Task3: Retrieve a list of products sorted by price in ascending order and then by category in descending order.
select product_name, category, price from products order by price, category desc;

-- Task4: Sort all orders by order_date in descending order and display the order_id, customer_id, and order_date.
select order_id, customer_id, order_date from orders order by order_date desc;

-- Task5: Get the list of cities where orders were placed, sorted in alphabetical order, and display the total number of orders placed in each city.
select c.city, count(o.order_id) as total_orders from customers c
	left join orders o on c.customer_id = o.customer_id
	group by c.city order by c.city asc;