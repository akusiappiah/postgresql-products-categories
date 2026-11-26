-- Day 12: JOINs and relationships.

-- INNER JOIN: return products with their matching category.
SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- LEFT JOIN: return all products, including any without a category match.
SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id;

-- RIGHT JOIN: return all categories, including those without products.
SELECT
    p.product_name,
    c.category_name
FROM products p
RIGHT JOIN categories c
    ON p.category_id = c.category_id;

-- Filter joined results to Electronics.
SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics';

-- Category summary. COUNT(product_id) returns zero for categories
-- that have no matching product rows.
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    ROUND(AVG(p.price), 2) AS average_price,
    COALESCE(SUM(p.stock_quantity), 0) AS total_stock
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_products DESC;

-- Exercises.

-- 1. Display every product with its category name using INNER JOIN.
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.category_id,
    p.price
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_id;

-- 2. Display all categories and their products using LEFT JOIN.
SELECT
    c.category_id,
    c.category_name,
    c.description,
    p.product_name
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
ORDER BY c.category_name;

-- 3. Find categories that currently have no products.
SELECT c.category_name
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
WHERE p.product_id IS NULL;

-- 4. Calculate the number of products in each category.
-- LEFT JOIN keeps categories even when they have no products.
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;

-- 5. Display category name, total products, average price,
-- total stock and total inventory value in one report.
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    ROUND(AVG(p.price), 2) AS average_price,
    COALESCE(SUM(p.stock_quantity), 0) AS total_stock,
    COALESCE(SUM(p.price * p.stock_quantity), 0) AS total_inventory_value
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;
