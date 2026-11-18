SELECT product_name, price
FROM products
ORDER BY price ASC;


SELECT product_name, price
FROM products
ORDER BY price DESC;


SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;


SELECT
    product_name,
    category_id,
    price
FROM products
ORDER BY category_id ASC, price DESC;