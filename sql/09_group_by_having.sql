Lessons:
===============

SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id
ORDER BY category_id;

SELECT
    category_id,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category_id
ORDER BY average_price DESC;

SELECT
    category_id,
    COUNT(*) AS total_products,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    SUM(price * stock_quantity) AS inventory_value
FROM products
GROUP BY category_id
ORDER BY inventory_value DESC;

SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id
HAVING COUNT(*) > 2;


SELECT
    category_id,
    COUNT(*) AS total_products,
    Round(AVG(price),2) AS average_price
FROM products
WHERE is_active = TRUE
GROUP BY category_id
HAVING COUNT(*) > 1
ORDER BY average_price DESC;


Exercises:
=========================

--1. Count the number of products in each category.
SELECT 
	category_id,
	COUNT(*) as total_count
FROM products
GROUP BY category_id
ORDER BY category_id

--2. Calculate the total stock quantity for each category.
SELECT 
	category_id,
	SUM(stock_quantity) as total_stock
FROM products
GROUP BY category_id
ORDER BY category_id


--3. Calculate the average product price per category.
SELECT 
	category_id,
	round(AVG(price),3) as Avg_price
FROM products
GROUP BY category_id
ORDER BY Avg_price DESC

-- 4. Display only categories with more than two product records.
SELECT 
	category_id,
	count(*) as cat_count
FROM products
GROUP BY category_id
HAVING count(*)>2

/*5. Show active products grouped by category, 
displaying only groups with at least two active product records.
*/

SELECT 
	category_id,
	COUNT(is_Active) as total_active
FROM products
GROUP BY category_id
HAVING COUNT(is_Active) >=2