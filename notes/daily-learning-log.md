# Daily Learning Log

**Database:** `shop_practice`  
**Technology:** PostgreSQL 18  
**Interface:** pgAdmin 4

This log records the practical topics covered in the PostgreSQL Products and Categories project.

## Day 2 – Creating Tables and Relationships

### What I learned

1. How to create tables using `CREATE TABLE`.
2. How to define columns and data types.
3. How primary keys uniquely identify records.
4. How foreign keys establish relationships between tables.
5. How `NOT NULL`, `UNIQUE` and `DEFAULT` constraints work.
6. How PostgreSQL automatically generates identity values.
7. How to use `CURRENT_TIMESTAMP`.

### Practical work completed

- Created the `categories` table.
- Created the `products` table.
- Established a one-to-many relationship.
- Inserted category and product sample data.
- Tested foreign key enforcement.
- Saved the table-creation SQL script in the repository.

### Key takeaway

A foreign key ensures that a product cannot reference a category that does not exist. This helps maintain referential integrity in a relational database.

### File

`sql/01_create_tables.sql`

**Status:** Completed.

## Day 3 – Inserting and Retrieving Data

### What I learned

- How to insert records with `INSERT INTO`.
- How to retrieve records with `SELECT`.
- How to use `RETURNING` to see rows inserted by a statement.
- How a subquery can look up a category ID when inserting a product.

### Practical work completed

- Inserted product records into the `products` table.
- Used a subquery to find the relevant category ID.
- Used `RETURNING` to inspect inserted records.

### Key takeaway

`RETURNING` is useful for confirming exactly what an `INSERT` statement added. Running the same insert more than once can create duplicate records if the table does not prevent them.

**Status:** Completed.

## Day 4 – SELECT, Columns, Aliases and DISTINCT

### What I learned

- How to retrieve all columns with `SELECT *`.
- How to select only the columns needed.
- How to rename output columns with `AS`.
- How `DISTINCT` returns unique values.

### Example

```sql
SELECT
    product_name AS product,
    price AS selling_price,
    stock_quantity AS available_stock
FROM products;
```

```sql
SELECT DISTINCT category_id
FROM products
ORDER BY category_id;
```

### Key takeaway

Selecting only the required columns makes query results easier to read. `DISTINCT` removes repeated values from the result set; it does not delete duplicate records from the table.

**Status:** Completed.

## Day 5 – Filtering with WHERE

### What I learned

- How to filter records with `WHERE`.
- How to combine conditions using `AND` and `OR`.
- How to search text using `LIKE` and PostgreSQL's case-insensitive `ILIKE`.
- How to filter active products and products matching a text pattern.

### Practical work completed

- Queried active products with stock greater than zero.
- Searched for a product name containing `USB` using `ILIKE`.

### Key takeaway

`AND` requires all joined conditions to be true; `OR` requires at least one condition to be true. `ILIKE` is useful for case-insensitive text searches in PostgreSQL.

**Status:** Completed.

## Day 6 – Sorting and Limiting Results

### What I learned

- How `ORDER BY` sorts query results.
- How `ASC` sorts in ascending order and `DESC` in descending order.
- How `LIMIT` restricts the number of rows returned.
- How to sort by more than one column.

### Example

```sql
SELECT product_name, price
FROM products
ORDER BY category_id ASC, price DESC;
```

### Key takeaway

When sorting by multiple columns, PostgreSQL applies the later sort key when values in the earlier sort key are equal. `LIMIT` is useful for returning a small result set, such as the five most expensive products.

**Status:** Completed.

## Day 7 – Week 1 Checkpoint

### Topics practised

- Selecting all records and selected columns.
- Filtering records.
- Searching product names.
- Sorting results and returning a limited number of rows.

### Key takeaway

The checkpoint brought together the core retrieval skills covered during the first week.

**Status:** Completed.

## Day 8 – UPDATE and DELETE

### What I learned

- How to modify existing records with `UPDATE`.
- How to remove records with `DELETE`.
- How to use `RETURNING` to inspect affected rows.
- Why a specific `WHERE` condition is important when changing or deleting data.

### Practical work completed

- Updated a product's price.
- Updated a product's stock quantity.
- Practised deleting a deliberately created test record.

### Key takeaway

Always inspect the target record first with a `SELECT` query. Use a specific identifier such as `product_id` when the intention is to modify one record. An `UPDATE` or `DELETE` without a suitable `WHERE` condition can affect every row.

**Status:** Completed.

## Day 9 – NULL, COALESCE and Text Handling

### What I learned

- `NULL` represents a missing or unknown value; it is not the same as zero or an empty string.
- Use `IS NULL` and `IS NOT NULL` to test for missing values.
- `COALESCE` returns the first non-NULL argument.
- A NULL value can cause an expression using the `||` concatenation operator to return NULL.
- `CONCAT` can be used to combine text values.
- Text functions practised: `UPPER`, `LOWER`, `TRIM`, `LENGTH` and `SUBSTRING`.

### Examples

```sql
SELECT
    category_name,
    COALESCE(description, 'Description pending') AS description
FROM categories;
```

```sql
SELECT
    category_name || ' - ' || COALESCE(description, '') AS category_details
FROM categories;
```

### Key takeaway

Use `COALESCE` when a query needs a fallback value for NULL. Use `IS NULL` rather than `= NULL` when checking for missing values.

**Status:** Completed.

## Day 10 – Aggregate Functions

### What I learned

- `COUNT(*)` counts rows.
- `COUNT(DISTINCT column_name)` counts unique, non-NULL values in a column.
- `SUM()` calculates a total.
- `AVG()` calculates an average.
- `MIN()` and `MAX()` return the lowest and highest values.
- `ROUND()` can format numeric results to a chosen number of decimal places.
- Inventory value can be calculated using `SUM(price * stock_quantity)`.

### Example

```sql
SELECT
    COUNT(*) AS total_product_records,
    COUNT(DISTINCT product_name) AS unique_product_names,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price,
    SUM(price * stock_quantity) AS total_inventory_value
FROM products;
```

### Key takeaway

Aggregate functions summarize multiple rows into useful figures. `COUNT(*)` counts all rows, including rows with duplicate product names.

**Status:** Completed.

## Day 11 – GROUP BY and HAVING

### What I learned

- `GROUP BY` groups rows that share the same value.
- Aggregate functions can calculate totals and averages for each group.
- `HAVING` filters grouped results.
- `WHERE` filters individual rows before grouping, while `HAVING` filters groups after aggregation.

### Example

```sql
SELECT
    category_id,
    COUNT(*) AS total_products,
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(price), 2) AS average_price,
    SUM(price * stock_quantity) AS inventory_value
FROM products
GROUP BY category_id
ORDER BY inventory_value DESC;
```

### Key takeaway

Use `WHERE` to decide which rows enter the grouping operation. Use `HAVING` when the condition depends on an aggregate result, such as a group having more than two records.

**Status:** Completed.

## Day 12 – JOINs and Relationships

### What I learned

- A `JOIN` combines related rows from two or more tables.
- `INNER JOIN` returns rows with matching records in both tables.
- `LEFT JOIN` returns every row from the left table, including rows without a match on the right.
- `RIGHT JOIN` preserves every row from the right table.
- `FULL OUTER JOIN` returns matched and unmatched rows from both tables.
- Table aliases such as `p` and `c` make queries shorter and easier to read.
- The `ON` clause defines how the tables are related.

### Example

```sql
SELECT
    p.product_name,
    c.category_name,
    p.price
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;
```

### Finding categories without products

```sql
SELECT c.category_name
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
WHERE p.product_id IS NULL;
```

### Key takeaway

Choose the join type based on which table's rows must be preserved. With a `LEFT JOIN`, use `COUNT(child_table.primary_key)` rather than `COUNT(*)` when counting matching child records, so an unmatched parent is counted as zero.

**Status:** Completed.

## Day 13 – Constraints, Transactions and Views

### What I learned

- Constraints enforce data rules at database level.
- `CHECK` validates that a column value meets a condition.
- `BEGIN` starts a transaction.
- `COMMIT` saves transaction changes.
- `ROLLBACK` cancels uncommitted changes.
- A view is a saved query that can be queried like a table.
- `CREATE OR REPLACE VIEW` can replace a view definition.
- `DROP VIEW` removes a view without deleting the underlying table records.

### Examples

Add a constraint that prevents negative stock quantities:

```sql
ALTER TABLE products
ADD CONSTRAINT chk_stock_nonnegative
CHECK (stock_quantity >= 0);
```

A negative stock test value (for example, `-5`) must be rejected. The corrected lesson script catches the expected constraint violation so the remainder of the file can run.

Use a transaction to test a change and undo it:

```sql
BEGIN;

UPDATE products
SET price = price + 10
WHERE product_id = 1;

SELECT *
FROM products
WHERE product_id = 1;

ROLLBACK;
```

Create a view called `active_products` containing only active products. Keep sorting in the query that reads the view, not in the view definition:

```sql
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
```

Query the view from highest to lowest price:

```sql
SELECT *
FROM active_products
ORDER BY price DESC;
```

### Key takeaway

Constraints protect data integrity, transactions provide control over changes, and views make reusable queries easier to access.

### Practical exercises from this lesson

- Add a `CHECK` constraint to prevent negative stock quantities.
- Test that PostgreSQL rejects an invalid stock value.
- Use `ROLLBACK` to cancel a test update.
- Create and query a view containing active products.

**Status:** Lesson covered; exercises and the Day 13 SQL script should be verified before the final project.

**Suggested file:** `sql/11_constraints_transactions_views.sql`

## Day 14 – Mini-project and Review

### Practical project completed

The final exercise brought together the main PostgreSQL skills learned during the programme using the `products` and `categories` tables.

1. **Database inspection:** Confirmed 15 product records and 4 categories; inspected sample product rows and all categories.
2. **Product catalogue:** Used an `INNER JOIN` to combine product details with category names. The query returned 15 rows.
3. **Inventory summary:** Used aggregate functions to calculate:
   - Product records: 15
   - Total stock: 376 units
   - Total inventory value: 199,900.00
   - Average product price: 380.33
4. **Category performance:** Used `JOIN`, `GROUP BY`, `COUNT`, `SUM` and `AVG` to produce a category-level report.
5. **Stock monitoring:** Found no products with stock below 10. The highest stock shown was 99 units for Books and Entertainment; the lowest stock was 20 units for Bluetooth Speaker.
6. **Price analysis:** Identified a highest price of 885, a lowest price of 160, and 3 products priced above the overall average. Used a scalar subquery to calculate the average-price threshold.
7. **Views:** Created and queried `product_details`, then used it for category-level reporting.
8. **Transactions:** Tested a price update inside a transaction, selected the target product by name rather than assuming a fixed `product_id`, then used `ROLLBACK` to restore its original price.

### Key takeaways

- `INNER JOIN` returns rows with matching records in both tables.
- `GROUP BY` calculates aggregate results separately for each group.
- With an outer join, `COUNT(child_table.primary_key)` counts matched child records and returns zero for an unmatched parent; `COUNT(*)` counts the preserved parent row.
- `LIMIT` restricts the number of returned rows; use it with `ORDER BY` to make the selection meaningful.
- A subquery can calculate a value used by an outer query.
- A normal view stores a query definition, not a separate copy of the underlying data.
- `COMMIT` saves transaction changes; `ROLLBACK` cancels uncommitted changes.

### Result consistency note

The category-performance exercise was reported as showing Electronics with the highest inventory value, while the later report using `product_details` was reported as showing Books. Both reports use the same inventory-value calculation and should agree when run against unchanged data. Re-run and compare the two category reports if this project is extended.

### SQL file

`sql/12_mini_project_queries.sql`

**Status:** Practical mini-project exercises completed. Day 14 results and transaction rollback verified.


## Post-course Examiner Review – Script Corrections

The basic SQL scripts were reviewed and corrected after examiner feedback.

- Added SQL comments to explanatory headings and section labels so they are not interpreted as executable SQL.
- Added missing statement terminators and cleaned the affected lesson files so they can be run as SQL scripts.
- Corrected Day 12 category exercises to use `LEFT JOIN` from `categories` and `COUNT(p.product_id)`, preserving categories with no products.
- Added total inventory value using `SUM(p.price * p.stock_quantity)`.
- Corrected Day 13's stock constraint to `CHECK (stock_quantity >= 0)` and added a negative-stock test.
- Corrected the Day 13 view name to `active_products`; sorting is applied when querying the view with `ORDER BY price DESC`.
- Replaced the fixed product ID in transaction examples with a lookup by product name.
- Added `sql/00_setup.sql` to rebuild the practice tables and sample data from scratch. This reset script drops existing practice tables, so it must be run only when a reset is intended.

**Files:** `sql/00_setup.sql`, `sql/01_create_tables.sql`, `sql/02_insert_select_filter_sort.sql`, `sql/04_filtering.sql`, `sql/05_sorting_limit.sql`, `sql/06_week1_checkpoint.sql`, `sql/07_null_coalesce.sql`, `sql/08_aggregates.sql`, `sql/09_group_by_having.sql`, `sql/10_joins.sql`, `sql/11_constraints_transactions_views.sql` and `sql/12_mini_project_queries.sql`.
