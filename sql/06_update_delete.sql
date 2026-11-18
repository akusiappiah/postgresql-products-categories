SELECT *
FROM products
WHERE product_id = 17;

UPDATE products
SET price = price +15,
    stock_quantity = stock_quantity + 10
WHERE product_id = 4
RETURNING *;


INSERT INTO products
(product_name, category_id,price,stock_quantity)
VALUES
('BasketTable',
	(SELECT category_id from categories 
	 WHERE category_name='Sports'),
	 580,75)
RETURNING *;


DELETE FROM products
WHERE product_id = 17
RETURNING *;