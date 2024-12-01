-- Creating table customers and inserting values
create table customers(
	customer_id serial primary key,
	customer_name varchar not null,
	city varchar not null,
	phone_number bigint unique,
	email varchar unique,
	registration_date date default current_date
)

copy customers (customer_id, customer_name, city, phone_number, email, registration_date)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/Data Analytics Course/SQL/task2/Table.1--customers.csv'
	delimiter ',' csv header;

-- Creating table orders and inserting values
create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date not null,
	order_amount numeric(10,2),
	delivery_city varchar not null,
	payment_mode varchar not null
)

copy orders (order_id, customer_id, order_date, order_amount, delivery_city, payment_mode)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/Data Analytics Course/SQL/task2/Table.2--orders.csv'
	delimiter ',' csv header;

-- Creating table products and inserting values
create table products(product_id serial primary key,
	product_name varchar not null,
	category varchar not null,
	price numeric(10,2),
	stock_quantity int,
	supplier_name varchar,
	supplier_city varchar,
	supply_date date
)

copy products(product_id, product_name, category, price, stock_quantity, supplier_name, supplier_city, supply_date)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/Data Analytics Course/SQL/task2/Table.3--products.csv'
	delimiter ',' csv header;

-- Creating table order_items and inserting values
create table order_items(
	order_item_id serial primary key,
	order_id int references orders(order_id),
	product_id int references products(product_id),
	quantity int default 1,
	total_price numeric(10,2)
)

copy order_items(order_item_id, order_id, product_id, quantity, total_price)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/Data Analytics Course/SQL/task2/Table.4--order_items.csv'
	delimiter ',' csv header;

-- task1: Retrive data who placed order in 2023
select c.customer_name, c.city, o.order_date
	from customers c
	join orders o on c.customer_id = o.customer_id
	where extract(year from o.order_date) = 2023;

-- task2: Retrive data ordered by customers living in Mumbai
select p.product_name, p.category, oi.total_price
	from customers c
	join orders o on c.customer_id = o.customer_id
	join order_items oi on o.order_id = oi.order_id
	join products p on oi.product_id = p.product_id
	where c.city = 'Mumbai';

-- task3: Find all orders where customers paid using 'Credit Card'
select c.customer_name, o.order_date, oi.total_price, o.payment_mode
	from customers c
	join orders o on c.customer_id = o.customer_id
	join order_items oi on o.order_id = oi.order_id
	where o.payment_mode = 'Credit Card';

--task4: Display products ordered in the first half of 2023 (January - June)
select p.product_name, p.category, oi.total_price
	from orders o
	join order_items oi on o.order_id = oi.order_id
	join products p on oi.product_id = p.product_id
	where extract(year from o.order_date) = 2023 and
	extract(month from o.order_date) between 1 and 6;

--task5: Show the total number of products ordered by each customer
select c.customer_name, sum(oi.quantity) as total_products_ordered
	from customers c
	join orders o on c.customer_id = o.customer_id
	join order_items oi on o.order_id = oi.order_id
	group by c.customer_name;