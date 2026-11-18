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
