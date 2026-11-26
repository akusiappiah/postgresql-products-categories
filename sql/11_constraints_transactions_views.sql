-- Day 13: Constraints, transactions and views.
-- Run after the products and categories tables exist.

-- 1. Add a CHECK constraint to prevent negative stock quantities.
-- Drop it first so this lesson script can be rerun safely.
ALTER TABLE products
DROP CONSTRAINT IF EXISTS chk_stock_nonnegative;

ALTER TABLE products
ADD CONSTRAINT chk_stock_nonnegative
CHECK (stock_quantity >= 0);

-- 2. Demonstrate that a negative stock value is rejected.
-- The exception is caught so the full script can continue running.
DO $$
BEGIN
    INSERT INTO products (product_name, category_id, price, stock_quantity)
    VALUES (
        'Negative Stock Test - should not be inserted',
        (SELECT category_id FROM categories
         WHERE category_name = 'Electronics'),
        100.00,
        -5
    );

    RAISE EXCEPTION 'Test failed: negative stock was accepted.';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'Expected result: PostgreSQL rejected the negative stock value.';
END;
$$;

-- 3. Start a transaction, update one product found by name,
-- inspect the temporary change, then roll it back.
BEGIN;

UPDATE products
SET price = price + 35
WHERE product_id = (
    SELECT MIN(product_id)
    FROM products
    WHERE product_name = 'Bluetooth Speaker'
);

SELECT product_id, product_name, price
FROM products
WHERE product_id = (
    SELECT MIN(product_id)
    FROM products
    WHERE product_name = 'Bluetooth Speaker'
);

ROLLBACK;

-- Verify the original price after rollback.
SELECT product_id, product_name, price
FROM products
WHERE product_id = (
    SELECT MIN(product_id)
    FROM products
    WHERE product_name = 'Bluetooth Speaker'
);

-- 4. Create a view containing active products.
-- Keep ORDER BY out of the view definition; sort when querying it.
CREATE OR REPLACE VIEW active_products AS
SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name,
    p.is_active,
    p.stock_quantity
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE p.is_active = TRUE;

-- 5. Query the view from highest to lowest price.
SELECT *
FROM active_products
ORDER BY price DESC;
