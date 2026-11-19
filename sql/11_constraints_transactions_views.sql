-- 1. Add a CHECK constraint to ensure stock_quantity cannot be negative.
ALTER TABLE products
ADD CONSTRAINT chk_product_price
CHECK(price>0);

-- 2. Attempt to insert a product with a negative stock quantity and observe the error.
INSERT INTO products
(product_name,category_id,price,stock_quantity)
VALUES ('Books and Entertainment',2,885,99)


-- 3. Start a transaction, update a product price, then use ROLLBACK. Confirm the original price remains.
BEGIN;
	UPDATE products
	SET price = price + 35
	WHERE product_id =23;

	SELECT * FROM 
	products
	WHERE product_id=23;

ROLLBACK;


	SELECT * 
	FROM 
	products
	WHERE product_id=23;


-- 4. Create a view called active_products that displays only active products.
CREATE VIEW view_products AS
	SELECT 
		p.product_name,
		p.product_id,
		p.price,
		c.category_name,
		p.is_active,
		p.stock_quantity
	FROM products AS p
	INNER JOIN categories AS c
	ON p.category_id = c.category_id
	WHERE p.is_active = true
	ORDER BY p.product_id;


-- 5. Query the view, sorting products by price from highest to lowest.
SELECT *
FROM view_products
ORDER BY price;

-- 6. Drop the created view
DROP VIEW view_products;
