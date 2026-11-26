-- Day 5: Filtering with WHERE, AND and text matching.

-- Search product names containing USB (case-insensitive).
SELECT
    product_name,
    price
FROM products
WHERE product_name ILIKE '%USB%';

-- Return active products that have stock, ordered by price.
SELECT
    product_name,
    price,
    stock_quantity,
    is_active
FROM products
WHERE is_active = TRUE
  AND stock_quantity > 0
ORDER BY price DESC;
