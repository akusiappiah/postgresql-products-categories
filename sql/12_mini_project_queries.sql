-- Day 14: PostgreSQL Products and Categories mini-project
-- Database: shop_practice
-- Run each section independently where indicated.

-- 1. Inspect the tables
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_categories FROM categories;
SELECT * FROM products LIMIT 5;
SELECT * FROM categories;

-- 2. Product catalogue: products with their category names
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity,
    p.is_active
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_name ASC;

-- 3. Overall inventory summary
SELECT
    COUNT(*) AS total_products,
    SUM(stock_quantity) AS total_stock,
    SUM(price * stock_quantity) AS total_inventory_value,
    ROUND(AVG(price), 2) AS average_product_price
FROM products;

-- 4. Category performance report
SELECT
    c.category_name,
    COUNT(p.product_id) AS number_of_products,
    SUM(p.stock_quantity) AS total_stock,
    ROUND(AVG(p.price), 2) AS average_price,
    SUM(p.price * p.stock_quantity) AS inventory_value
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY inventory_value DESC;

-- 5a. Products with fewer than 10 units in stock
SELECT product_id, product_name, stock_quantity, price
FROM products
WHERE stock_quantity < 10
ORDER BY stock_quantity ASC;

-- 5b. Five products with the highest stock
SELECT product_id, product_name, stock_quantity
FROM products
ORDER BY stock_quantity DESC
LIMIT 5;

-- Optional stock range check
SELECT
    MIN(stock_quantity) AS lowest_stock,
    MAX(stock_quantity) AS highest_stock
FROM products;

-- 6a. Five most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 6b. Five cheapest products
SELECT product_name, price
FROM products
ORDER BY price ASC
LIMIT 5;

-- 6c. Products priced above the overall average
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;

-- 7. Create a reusable product details view
CREATE OR REPLACE VIEW product_details AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity,
    p.is_active,
    (p.price * p.stock_quantity) AS inventory_value
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- Query the view
SELECT *
FROM product_details
ORDER BY inventory_value DESC;

-- Category report using the view
SELECT
    category_name,
    COUNT(*) AS total_products,
    SUM(inventory_value) AS total_inventory_value
FROM product_details
GROUP BY category_name
ORDER BY total_inventory_value DESC;

-- 8. Transaction safety demonstration
-- Check the current price first.
SELECT product_id, product_name, price
FROM products
WHERE product_id = 23;

-- Run this transaction as a unit to test an update and undo it.
BEGIN;

UPDATE products
SET price = price + 50
WHERE product_id = 23;

SELECT product_id, product_name, price
FROM products
WHERE product_id = 23;

ROLLBACK;

-- Verify that the original price has been restored.
SELECT product_id, product_name, price
FROM products
WHERE product_id = 23;

-- Use COMMIT instead of ROLLBACK only when you intend to keep
-- the changes made within a transaction.
