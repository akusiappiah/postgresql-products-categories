Lessons:
===============

-- Count all product records
SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(DISTINCT product_name) AS unique_products
FROM products;

--Calculate Totals
SELECT SUM(stock_quantity) AS total_stock
FROM products;

--calculate total inventory value
SELECT
    SUM(price * stock_quantity) AS inventory_value
FROM products;

--calculate Averages with Round function
SELECT
    ROUND(AVG(price), 2) AS average_price
FROM products;

--do MIN() and MAX()
SELECT
    MIN(price) AS cheapest_price,
    MAX(price) AS highest_price
FROM products;

--To retrieve the actual product with the highest price:
SELECT 
	product_id,
	product_name,
	price
FROM products
WHERE price = (SELECT MAX(price) from products);

--Combine aggregate functions
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_name) AS unique_products,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price,
    SUM(price * stock_quantity) AS inventory_value
FROM products;



Exercises:
===============
--1. Count all product records.
select count(*) as product_count
from products

-- 2.Count distinct product names.
select count(distinct(product_name)) as product_count
from products

-- 3. Calculate the total inventory value.
select sum(price) as total_value
from products

--4. Find the average, minimum and maximum product prices.
select 
	round(avg(price),2) as avg_price,
	min(price) as min_price,
	max(price) as max_price
from products

select * from products

--5. Create one summary query showing total products, unique products, total stock, average price and inventory value.
select 
	count(*) as total_products,
	count(distinct(product_name)) as total_products,
	sum(stock_quantity) as total_stock,
	round(avg(price),2) as avg_price,
	sum(price) as total_stockValue
from products

