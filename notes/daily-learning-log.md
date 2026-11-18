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

**Status:** Not yet completed.

Planned functions: `COUNT`, `SUM`, `AVG`, `MIN` and `MAX`.
