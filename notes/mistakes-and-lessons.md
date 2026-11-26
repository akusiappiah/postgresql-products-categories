# Mistakes and Lessons Learned

This file records practical issues and important lessons from the PostgreSQL Products and Categories project.

## Day 2 – PostgreSQL Tables

### Lesson 1: Foreign key enforcement

**What I tested:**  
I attempted to insert a product with `category_id = 99999`, even though that category did not exist.

**What happened:**  
PostgreSQL rejected the `INSERT` operation.

**What I learned:**  
A foreign key prevents records from referencing nonexistent records in another table.

**Lesson:**  
Establish appropriate relationships and constraints when designing relational databases.

### Lesson 2: Automatically generated IDs

**What I learned:**  
Using `GENERATED ALWAYS AS IDENTITY` allows PostgreSQL to generate primary key values automatically.

**Lesson:**  
I do not need to manually assign IDs when inserting new categories or products.

## Day 3 – Repeated INSERT Statements and Duplicate Rows

### What happened

A count grouped by `product_name` showed repeated product names in the `products` table:

| Product name | Number of records |
|---|---:|
| Basketball | 5 |
| Bluetooth Speaker | 5 |
| Football | 1 |
| SQL for Beginners | 1 |
| USB-C Hub | 1 |
| Wireless Mouse | 1 |

The query used was:

```sql
SELECT
    product_name,
    COUNT(*) AS number_of_records
FROM products
GROUP BY product_name
ORDER BY product_name;
```

### What I learned

- Running the same `INSERT` statement multiple times can insert the same sample data more than once.
- A product name is not automatically unique unless a `UNIQUE` constraint is defined.
- `COUNT(*)` and `GROUP BY` help identify repeated values.

### Lesson

Before rerunning an insert script, check whether the records have already been added. For repeatable scripts, consider appropriate uniqueness rules and conflict handling. Do not delete apparent duplicates without first checking which records they are and deciding what should be retained.

**Data note:** The duplicate counts were observed during practice. No cleanup of those records is assumed here.

## Day 4 – DISTINCT Does Not Delete Data

### What I learned

`SELECT DISTINCT` removes repeated values from the query result, not from the underlying table.

### Lesson

Use `DISTINCT` when the goal is to display unique values. It is not a duplicate-cleanup operation.

## Day 5 – AND, OR and Text Matching

### What I learned

- `AND` returns rows only when every condition is true.
- `OR` returns rows when at least one condition is true.
- `ILIKE` performs case-insensitive pattern matching in PostgreSQL.
- `%` in a `LIKE` or `ILIKE` pattern matches any sequence of characters.

### Lesson

Check the logic of combined conditions carefully. Use parentheses when combining `AND` and `OR` so the intended logic is explicit.

## Day 6 – Sorting and LIMIT

### What I learned

- `ASC` means ascending order and `DESC` means descending order.
- Multiple sort keys are evaluated in the order written.
- `LIMIT` controls how many rows are returned.

### Lesson

Use `ORDER BY` with `LIMIT` when asking for the highest, lowest, newest or oldest records. Without `ORDER BY`, the rows returned by `LIMIT` are not guaranteed to be the rows you intended.

## Day 8 – Safe UPDATE and DELETE

### What I learned

- `UPDATE` changes existing rows.
- `DELETE` removes rows.
- `WHERE` determines which rows are affected.
- `RETURNING` displays rows affected by an `UPDATE` or `DELETE`.

### Lesson

1. Run a `SELECT` with the intended `WHERE` condition first.
2. Use a specific key such as `product_id` when targeting one record.
3. Be especially careful with statements that have no `WHERE` clause.
4. Use transactions when testing changes that may need to be undone.

## Day 9 – NULL and Text Handling

### Lesson 1: NULL is not an ordinary value

Use `IS NULL` or `IS NOT NULL` to test for missing values. Do not use `= NULL`.

### Lesson 2: Concatenation and NULL

The `||` operator can produce a NULL result when one of its inputs is NULL.

Use `COALESCE` to provide a fallback:

```sql
SELECT
    category_name || ' - ' || COALESCE(description, '') AS category_details
FROM categories;
```

### Lesson 3: COALESCE

`COALESCE(value, fallback)` returns `value` when it is not NULL; otherwise, it returns `fallback`.

### Lesson 4: Text functions

PostgreSQL provides useful text functions:

- `UPPER()` and `LOWER()` change letter case.
- `TRIM()` removes leading and trailing spaces.
- `LENGTH()` returns the character length of a string.
- `SUBSTRING()` extracts part of a string.
- `CONCAT()` combines values into a string.

### Lesson

Choose the right NULL-handling and text function for the output required. Remember that replacing NULL in a query result does not change the stored value in the table.


## Day 10 – Aggregate Functions

### What I learned

- `COUNT(*)` counts rows, including rows with duplicate values.
- `COUNT(column_name)` counts non-NULL values in that column.
- `COUNT(DISTINCT column_name)` counts unique, non-NULL values.
- `SUM()`, `AVG()`, `MIN()` and `MAX()` summarize numeric data.
- Inventory value can be calculated with `SUM(price * stock_quantity)`.

### Lesson

Be clear about what is being counted. A count of rows is not necessarily a count of unique product names. Use `COUNT(DISTINCT ...)` only when the question is specifically about unique values.

## Day 11 – GROUP BY and HAVING

### What I learned

- Every selected column that is not aggregated generally needs to be included in the `GROUP BY` clause.
- `WHERE` filters individual rows before grouping.
- `HAVING` filters groups after aggregation.

### Lesson

Use `WHERE` for row-level conditions and `HAVING` for aggregate conditions, such as keeping only groups with more than two records.

## Day 12 – JOINs and Relationships

### What I learned

- `INNER JOIN` returns matching rows from both tables.
- `LEFT JOIN` preserves all rows from the left table, even when there is no matching row on the right.
- `RIGHT JOIN` preserves all rows from the right table.
- `FULL OUTER JOIN` preserves matched and unmatched rows from both tables.
- The `ON` clause specifies the relationship used to match rows.

### Important LEFT JOIN counting lesson

When counting child records after a `LEFT JOIN`, use the child table's primary key:

```sql
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_name;
```

`COUNT(*)` would count the preserved category row even when it has no matching product. `COUNT(p.product_id)` returns zero for that category because the product ID is NULL in the unmatched row.

### Lesson

Choose the join type based on which table's records must remain in the result. Pay attention to NULL values produced by outer joins, especially when counting related records.

## Day 13 – Constraints, Transactions and Views

### Lesson 1: CHECK constraints protect data

A `CHECK` constraint enforces a condition on values being inserted or updated.

Example:

```sql
ALTER TABLE products
ADD CONSTRAINT chk_stock_nonnegative
CHECK (stock_quantity >= 0);
```

PostgreSQL rejects an insert or update that violates this rule. A constraint protects the table even when data changes come from different queries or applications.

### Lesson 2: Transactions allow changes to be undone

- `BEGIN` starts a transaction.
- `COMMIT` makes the transaction's changes permanent.
- `ROLLBACK` cancels uncommitted changes.

Example:

```sql
BEGIN;

UPDATE products
SET price = price + 10
WHERE product_id = 1;

ROLLBACK;
```

After the rollback, the price change from that transaction is not retained.

### Lesson 3: A failed statement can leave a transaction aborted

In PostgreSQL, if a statement fails inside an explicit transaction, subsequent statements in that transaction will not run successfully until the transaction is rolled back.

**Lesson:** If a test violates a constraint inside a transaction, issue `ROLLBACK` before continuing with other work in that transaction.

### Lesson 4: Views are saved queries

A view stores a query definition and can be queried like a table:

```sql
CREATE VIEW active_products AS
SELECT product_id, product_name, price, stock_quantity
FROM products
WHERE is_active = TRUE;
```

Query it with:

```sql
SELECT *
FROM active_products;
```

Dropping a normal view removes the saved query definition, not the underlying product records.

### Lesson

Use constraints to enforce business rules, transactions to control changes, and views to reuse commonly needed queries. A normal view is based on its underlying tables; it is not a separate copy of the data.


## Day 14 – Mini-project and Reporting Lessons

### Lesson 1: JOINs depend on matching keys

The product catalogue report used `INNER JOIN` on `products.category_id = categories.category_id`. It returned 15 rows, and every product had a matching category.

**Lesson:** Use `INNER JOIN` when only matched records are required. Use `LEFT JOIN` when all rows from the left-hand table must remain in the result.

### Lesson 2: Aggregate inventory value correctly

The total inventory value was calculated as:

```sql
SUM(price * stock_quantity)
```

This calculates the value of each product record's stock before adding those values together. It is different from multiplying the sum of prices by the sum of stock quantities.

### Lesson 3: COUNT(*) and COUNT(child_key) differ after LEFT JOIN

For a category with no matching products, a `LEFT JOIN` still produces a row for the category. `COUNT(*)` counts that row, while `COUNT(p.product_id)` ignores the NULL product ID and returns zero.

### Lesson 4: LIMIT should be paired with ORDER BY

`LIMIT 5` returns five rows, but without an explicit `ORDER BY`, those rows are not guaranteed to be the five highest or lowest values.

### Lesson 5: Subqueries can provide dynamic comparison values

The price analysis used a subquery containing `AVG(price)`. The outer query compared each product price against the calculated average, avoiding a hard-coded threshold.

### Lesson 6: Views are reusable query definitions

The `product_details` view combined products and categories and calculated each record's inventory value. A normal view does not store a separate snapshot of the underlying rows; it runs its saved query when selected.

### Lesson 7: Verify transaction outcomes

A test changed product ID 23 from 885 to 935 inside a transaction. After `ROLLBACK`, a separate SELECT confirmed that the original price, 885, was restored.

**Lesson:** Use `BEGIN` to start a transaction, `COMMIT` to save intended changes, and `ROLLBACK` to cancel uncommitted changes.

### Follow-up verification

The category report in Task 4 was reported as ranking Electronics highest, while the later report based on the view was reported as ranking Books highest. Since both calculations should produce the same category totals when the underlying data is unchanged, compare the two query outputs if investigating or extending the project. Do not assume either ranking without rechecking the results.
