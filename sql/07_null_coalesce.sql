-- Day 9: NULL handling, COALESCE and text functions.

-- Main lesson 1: Inspect categories and nullable descriptions.
SELECT
    category_id,
    category_name,
    description
FROM categories;

-- Insert a category with a NULL description for practice.
-- Re-running this insert creates another category record.
INSERT INTO categories (category_name, description)
VALUES ('Consumables', NULL)
RETURNING *;

-- Use IS NULL to find categories without descriptions.
SELECT *
FROM categories
WHERE description IS NULL;

-- Use COALESCE to display a fallback for NULL descriptions.
SELECT
    category_name,
    COALESCE(description, 'No description available') AS description
FROM categories;

-- Concatenation with COALESCE prevents NULL from nullifying the result.
SELECT
    category_name || ' - ' || COALESCE(description, '') AS category_details
FROM categories;

SELECT
    category_id,
    CONCAT(category_name, ' - ', description) AS category_details
FROM categories;

-- Main lesson 2: Text functions.

-- Convert product names to uppercase.
SELECT product_id, UPPER(product_name) AS product_name_upper
FROM products
ORDER BY product_id;

-- Convert product names to lowercase.
SELECT product_id, LOWER(product_name) AS product_name_lower
FROM products
ORDER BY product_id;

-- Remove leading and trailing spaces.
SELECT product_id, TRIM(product_name) AS trimmed_product_name
FROM products
ORDER BY product_id;

-- Count characters in product names.
SELECT
    product_id,
    product_name,
    LENGTH(product_name) AS character_count
FROM products;

-- Extract the first five characters of each product name.
SELECT
    product_id,
    SUBSTRING(product_name FROM 1 FOR 5) AS subproduct_name
FROM products
ORDER BY product_id;

-- Exercises.

-- Exercise 1: Display every category and replace NULL descriptions.
SELECT
    category_id,
    category_name,
    COALESCE(description, 'Description pending') AS description
FROM categories
ORDER BY category_id;

-- Exercise 2: Display product names and stock, replacing NULL values.
SELECT
    product_id,
    COALESCE(product_name, '') AS product_name,
    COALESCE(stock_quantity, 0) AS current_stock
FROM products;

-- Exercise 3: Concatenate product name and category ID.
SELECT
    product_id,
    CONCAT(product_name, '-', category_id) AS product_category,
    COALESCE(stock_quantity, 0) AS current_stock
FROM products
ORDER BY product_id;

-- Exercise 4: Display all product names in uppercase.
SELECT
    product_id,
    UPPER(product_name) AS product_name,
    stock_quantity
FROM products
ORDER BY product_id;

-- Exercise 5: Display product names and character lengths,
-- ordered from longest to shortest.
SELECT
    product_id,
    product_name,
    stock_quantity,
    LENGTH(product_name) AS product_length
FROM products
ORDER BY product_length DESC;
