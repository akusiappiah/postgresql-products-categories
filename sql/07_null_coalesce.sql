Main Lesson1:
=================
SELECT
    category_id,
    category_name,
    description
FROM categories;

INSERT into categories
(category_name,description)
VALUES ('Consumables',NULL)
RETURNING *;

USE IS NULL
============
SELECT *
FROM categories
WHERE description IS NULL;

USE COALESCE and CONACT
======================= 
SELECT
    category_name,
    COALESCE(description, 'No description available') AS description
FROM categories;

SELECT
    category_name || ' - ' || description AS category_details
FROM categories;

SELECT
    category_id, category_name || ' - ' ||
    COALESCE(description, '') AS category_details
FROM categories;

SELECT
    category_id, CONCAT(category_name, ' - ', description) AS category_details
FROM categories;


Main LESSON2:
================
-- Convert to uppercase
SELECT 
	product_id, UPPER(product_name)
FROM products
ORDER BY product_id;

-- Convert to lowercase
SELECT product_id,LOWER(product_name)
FROM products
ORDER BY product_id;

-- Remove leading and trailing spaces
SELECT product_id,TRIM(product_name)
FROM products
ORDER BY product_id;

SELECT
	product_id,
    product_name,
    LENGTH(product_name) AS character_count
FROM products;


-- Extract part of a string
SELECT product_id,SUBSTRING(product_name FROM 1 FOR 5) as subProduct_name
FROM products
order by product_id;


Exercises
==================

--Exercise 1: Display every category and replace NULL descriptions with 'Description pending'.
--=============================================================
SELECT 
 category_id, 
 category_name,
 COALESCE(description, 'Description pending' )
FROM categories
ORDER BY category_id;

--Exercise 2: Display product names and stock quantities, replacing NULL stock quantities with 0
--================================================================================================
SELECT 
	product_id,
	COALESCE(product_name, '') as prod_name,
	COALESCE(stock_quantity,0) as current_stock
FROM products

--Exercise 3: Concatenate product name and category ID into one column, ensuring NULL values don't break the result.
--==================================================================================================================
SELECT 
	product_id,
	CONCAT(product_name,'-',category_id) as product_category,
	COALESCE(stock_quantity,0) as current_stock
FROM products
ORDER BY product_id


--Exercise 4: Display all product names in uppercase.
--===================================================
SELECT 
	product_id,
	UPPER(product_name) as product_name,
	stock_quantity
FROM products
ORDER BY product_id

--Exercise 5: Display product names and their character lengths, ordered from longest to shortest.
--================================================================================================
SELECT 
	product_id,
	product_name,
	stock_quantity,
	LENGTH(product_name) as product_length
FROM products
ORDER BY product_length DESC

