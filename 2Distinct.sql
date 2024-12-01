-- task1: Get a distinct list of cities where customers are located
select distinct city from customers;

-- task2: Retrieve distinct supplier_name from the products table.
select distinct supplier_name from products;

-- task3: Find distinct payment methods used in the orders table.
select distinct payment_mode from orders;

--task4: List all distinct product categories that have been ordered.
select distinct category from products;

--task5: Find distinct cities from which suppliers supply products by querying the products table
select distinct supplier_city from products;