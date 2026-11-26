-- Day 3–6: INSERT, SELECT, filtering, sorting and limiting.
-- Run after the tables have been created and sample categories inserted.

SELECT product_name
FROM products;

SELECT product_name, price, stock_quantity
FROM products;

-- INSERT with RETURNING. Re-running this section inserts additional rows.
INSERT INTO products (product_name, category_id, price, stock_quantity)
VALUES
    ('Bluetooth Speaker',
        (SELECT category_id FROM categories WHERE category_name = 'Electronics'),
        450.00, 20),
    ('Basketball',
        (SELECT category_id FROM categories WHERE category_name = 'Sports'),
        220.00, 10)
RETURNING *;

-- Filter products by price.
SELECT product_name, price
FROM products
WHERE price > 200;

-- Sort products from highest to lowest price.
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Sort products from lowest to highest price.
SELECT product_name, price
FROM products
ORDER BY price ASC;

-- Return the three most expensive products.
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- Return distinct category IDs represented in products.
SELECT DISTINCT category_id
FROM products;

-- IN operator.
SELECT product_name, category_id, price
FROM products
WHERE category_id IN (1, 2);

-- BETWEEN operator.
SELECT product_name, price
FROM products
WHERE price BETWEEN 100 AND 500
ORDER BY price ASC;

-- LIKE operator.
SELECT product_name, price
FROM products
WHERE product_name LIKE 'B%';

-- Check for repeated product names.
SELECT product_name, COUNT(*) AS number_of_records
FROM products
GROUP BY product_name
ORDER BY product_name;
