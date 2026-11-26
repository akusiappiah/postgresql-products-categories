-- 00_setup.sql
-- Rebuilds the practice schema and sample data from scratch.
-- WARNING: This script DROPS the existing products and categories tables,
-- along with their data. Run only when you intend to reset the practice project.
-- Connect to the shop_practice database before running this file.

DROP VIEW IF EXISTS active_products;
DROP VIEW IF EXISTS product_details;

DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category_id INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),
    CONSTRAINT chk_stock_nonnegative
        CHECK (stock_quantity >= 0)
);

INSERT INTO categories (category_name, description)
VALUES
    ('Electronics', 'Electronic devices and accessories'),
    ('Sports', 'Sports equipment and accessories'),
    ('Books and Entertainment', 'Books and learning materials'),
    ('Home and Kitchen', 'Home and kitchen products');

INSERT INTO products (product_name, category_id, price, stock_quantity, is_active)
VALUES
    ('Bluetooth Speaker',
        (SELECT category_id FROM categories WHERE category_name = 'Electronics'),
        450.00, 20, TRUE),
    ('USB-C Hub',
        (SELECT category_id FROM categories WHERE category_name = 'Electronics'),
        320.00, 35, TRUE),
    ('Wireless Mouse',
        (SELECT category_id FROM categories WHERE category_name = 'Electronics'),
        160.00, 45, TRUE),
    ('Basketball',
        (SELECT category_id FROM categories WHERE category_name = 'Sports'),
        220.00, 10, TRUE),
    ('Football',
        (SELECT category_id FROM categories WHERE category_name = 'Sports'),
        180.00, 25, TRUE),
    ('SQL for Beginners',
        (SELECT category_id FROM categories WHERE category_name = 'Books and Entertainment'),
        885.00, 12, TRUE),
    ('PostgreSQL Practice Guide',
        (SELECT category_id FROM categories WHERE category_name = 'Books and Entertainment'),
        260.00, 8, FALSE);

-- Verify the reset and sample data.
SELECT COUNT(*) AS total_categories FROM categories;
SELECT COUNT(*) AS total_products FROM products;
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;
