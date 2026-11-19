Lessons:
===========
SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id;

SELECT
    p.product_name,
    c.category_name
FROM products p
RIGHT JOIN categories c
    ON p.category_id = c.category_id;

SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics';

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    ROUND(AVG(p.price), 2) AS average_price,
    SUM(p.stock_quantity) AS total_stock
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_products DESC;



Exercises
===============
--1. Display every product with its category name using INNER JOIN.
SELECT 
	p.product_id,
	p.product_name,
	c.category_name,
	p.category_id,
	p.price
from products as p
INNER JOIN categories as c
ON p.category_id = c.category_id
ORDER BY p.product_id 


--2. Display all categories and their products using LEFT JOIN.
SELECT 
	c.category_id,
	c.category_name,
	c.description,
	p.product_name
FROM categories as c
LEFT JOIN products as p
ON c.category_id=p.category_id
ORDER BY c.category_name

--3. Find categories that currently have no products.
SELECT 
	c.category_name 
FROM categories as c
LEFT JOIN products as p
ON c.category_id=p.category_id
WHERE p.product_id is null

--4. Calculate the number of products in each category.
SELECT 
	c.category_name,
	count(product_id) as total_products
FROM products as p
INNER JOIN categories as c
ON p.category_id = c.category_id
GROUP BY c.category_name

--5. Display category name, total products, average price and total inventory value in one report.
SELECT 
	c.category_name,
	count(p.product_id) as total_products,
	round(avg(p.price),2) as avg_price,
	sum(p.stock_quantity) as total_stock
FROM categories as c
INNER JOIN products as p
ON c.category_id=p.category_id
GROUP BY c.category_name
ORDER BY c.category_name
