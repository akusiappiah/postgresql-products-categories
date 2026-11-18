select 
	product_name as product,
	price as selling_price,
	stock_quantity as available_stock
from products;

select distinct
category_id
from products
order by category_id;	