-- Task1: Find the names of customers who placed orders with a total price greater than the average total price of all orders.
select customer_id, customer_name, city, phone_number, email from customers where customer_id in (
	select customer_id from orders o
	join order_items oi on o.order_id = oi.order_id
	group by customer_id having sum(total_price) > (select avg(total_price) from order_items)
);


-- Task2: Get a list of products that have been ordered more than once by any customer.
select product_id, product_name, category, price from products where product_id in (
	select product_id from order_items group by product_id having count(*) > 1
);


-- Task3: Retrieve the product names that were ordered by customers from Pune using a subquery.
select product_id, product_name, category, price from products
	where product_id in (
		select oi.product_id from order_items oi
			join orders o on oi.order_id = o.order_id
			join customers c on o.customer_id = c.customer_id
			where city = 'Pune'
	);
	

-- Task4: Find the top 3 most expensive orders using a subquery.
select order_id, customer_id, order_date, order_amount from orders
	where order_id in (
	    select oi.order_id from order_items oi
		    group by oi.order_id
		    order by sum(oi.total_price) desc
		    limit 3
	);
 

-- Task5: Get the customer names who placed orders for a product that costs more than ₹30,000 using a subquery.
select customer_id, customer_name from customers group by customer_id
	having customer_id in (
		select o.customer_id from orders o
			join order_items oi on o.order_id = oi.order_id
			join products p on oi.product_id = p.product_id
			where p.price > 30000
	) order by customer_id asc;