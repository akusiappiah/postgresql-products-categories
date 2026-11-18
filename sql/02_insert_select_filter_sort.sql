
SELECT product_name
FROM products;

SELECT
    product_name,
    price,
    stock_quantity
FROM products;

insert with returning
=========================

INSERT INTO products
    (product_name, category_id, price, stock_quantity)
VALUES
    ('Bluetooth Speaker',
        (SELECT category_id FROM categories
         WHERE category_name = 'Electronics'),
        450.00, 20),

    ('Basketball',
        (SELECT category_id FROM categories
         WHERE category_name = 'Sports'),
        220.00, 10)
RETURNING *;



SELECT
    product_name,
    price
FROM products
WHERE price > 200;


select with order by 
====================
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC;


SELECT
    product_name,
    price
FROM products
ORDER BY price ASC;


Limit Selection
==================
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 3;


select Distinct
==================
SELECT DISTINCT category_id
FROM products;


In operator 
====================

SELECT
    product_name,
    category_id,
    price
FROM products
WHERE category_id IN (1, 2);

Between operator
===============

SELECT
    product_name,
    price
FROM products
WHERE price BETWEEN 100 AND 500
ORDER BY price ASC;


Like Operator
==================
SELECT
    product_name,
    price
FROM products
WHERE product_name LIKE 'B%';



SELECT
    product_name,
    COUNT(*) AS number_of_records
FROM products
GROUP BY product_name
ORDER BY product_name;



