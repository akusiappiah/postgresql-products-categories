-- Day 10: Aggregate functions.
-- All statements in this file are read-only.

-- Count all product records.
SELECT COUNT(*) AS total_products
FROM products;

-- Count distinct product names.
SELECT COUNT(DISTINCT product_name) AS unique_products
FROM products;

-- Calculate total stock.
SELECT SUM(stock_quantity) AS total_stock
FROM products;

-- Calculate total inventory value.
SELECT SUM(price * stock_quantity) AS inventory_value
FROM products;

-- Calculate the average price.
SELECT ROUND(AVG(price), 2) AS average_price
FROM products;

-- Find the minimum and maximum prices.
SELECT
    MIN(price) AS cheapest_price,
    MAX(price) AS highest_price
FROM products;

-- Retrieve the product or products with the highest price.
SELECT product_id, product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- Combined aggregate summary.
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_name) AS unique_products,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price,
    SUM(price * stock_quantity) AS total_inventory_value
FROM products;

-- Exercises.

-- 1. Count all product records.
SELECT COUNT(*) AS product_count
FROM products;

-- 2. Count distinct product names.
SELECT COUNT(DISTINCT product_name) AS unique_product_count
FROM products;

-- 3. Calculate the total inventory value.
SELECT SUM(price * stock_quantity) AS total_inventory_value
FROM products;

-- 4. Find the average, minimum and maximum product prices.
SELECT
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products;

-- 5. Show total products, unique products, total stock, average price
-- and total inventory value in one summary.
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_name) AS unique_products,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    SUM(price * stock_quantity) AS total_inventory_value
FROM products;
