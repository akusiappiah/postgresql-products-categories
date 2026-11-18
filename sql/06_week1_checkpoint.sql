SELECT *
FROM products;

SELECT product_name, price
FROM products;


SELECT *
FROM products
WHERE is_active = TRUE;

SELECT *
FROM products
WHERE product_name ILIKE '%mouse%';


SELECT product_name, price
FROM products
ORDER BY price ASC
LIMIT 3;