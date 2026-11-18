select with like
==================
SELECT
    product_name,
    price
FROM products
WHERE product_name ILIKE '%USB%';


select with filtering(where,and and order)
========================================
SELECT
    product_name,
    price,
    stock_quantity,
    is_active
FROM products
WHERE is_active = TRUE
AND stock_quantity > 0
ORDER BY price DESC;


