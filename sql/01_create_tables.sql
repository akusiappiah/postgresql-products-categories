-- Day 2: Create the categories and products tables.
-- Run this file in the shop_practice database.
-- If you need a clean rebuild with sample data, use 00_setup.sql instead.

CREATE TABLE categories (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT
);

-- Create the products table and link it to categories.
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
        REFERENCES categories(category_id)
);
