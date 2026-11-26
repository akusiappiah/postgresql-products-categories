-- Day 11: GROUP BY and HAVING.

SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id
ORDER BY category_id;

SELECT category_id, ROUND(AVG(price), 2) AS average_price
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

SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id
HAVING COUNT(*) > 2;

SELECT
    category_id,
    COUNT(*) AS active_products,
    ROUND(AVG(price), 2) AS average_active_price
FROM products
WHERE is_active = TRUE
GROUP BY category_id
HAVING COUNT(*) >= 2
ORDER BY average_active_price DESC;

-- Exercises.

-- 1. Count the number of products in each category.
SELECT category_id, COUNT(*) AS total_count
FROM products
GROUP BY category_id
ORDER BY category_id;

-- 2. Calculate total stock quantity for each category.
SELECT category_id, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category_id
ORDER BY category_id;

-- 3. Calculate the average product price per category.
SELECT category_id, ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category_id
ORDER BY average_price DESC;

-- 4. Display only categories with more than two product records.
SELECT category_id, COUNT(*) AS category_count
FROM products
GROUP BY category_id
HAVING COUNT(*) > 2;

-- 5. Show active products grouped by category, retaining groups
-- with at least two active product records.
SELECT
    category_id,
    COUNT(*) AS total_active_products
FROM products
WHERE is_active = TRUE
GROUP BY category_id
HAVING COUNT(*) >= 2;
