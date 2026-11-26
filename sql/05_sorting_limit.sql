-- Day 6: Sorting and limiting query results.

-- Sort products from lowest to highest price.
SELECT product_name, price
FROM products
ORDER BY price ASC;

-- Sort products from highest to lowest price.
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Return the five most expensive products.
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Sort by category, then by price within each category.
SELECT
    product_name,
    category_id,
    price
FROM products
ORDER BY category_id ASC, price DESC;
