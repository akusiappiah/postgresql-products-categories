# PostgreSQL Products and Categories

A hands-on project documenting my practical journey learning SQL and PostgreSQL.

## Learning environment

- PostgreSQL 18
- pgAdmin 4
- Git and GitHub
- Practice database: `shop_practice`

## Project overview

The project uses a simple product catalogue database with two related tables:

- `categories` — stores product categories.
- `products` — stores products and references their categories.

The relationship is one-to-many: one category can be associated with multiple products.

## Database schema

### `categories`

| Column | Purpose |
|---|---|
| `category_id` | Identity column and primary key |
| `category_name` | Required, unique category name |
| `description` | Optional text description |

### `products`

| Column | Purpose |
|---|---|
| `product_id` | Identity column and primary key |
| `product_name` | Required product name |
| `category_id` | Required foreign key referencing `categories.category_id` |
| `price` | Required numeric price |
| `stock_quantity` | Required integer; defaults to `0` |
| `is_active` | Required Boolean; defaults to `TRUE` |
| `created_at` | Timestamp; defaults to `CURRENT_TIMESTAMP` |

## Learning objectives

- Create databases and tables, and define columns and data types.
- Use primary keys, foreign keys, identity columns and constraints.
- Insert records and retrieve data with `SELECT`.
- Select specific columns, use aliases and remove duplicates with `DISTINCT`.
- Filter records with `WHERE`, comparison operators, `AND`, `OR`, `IN`, `BETWEEN`, `LIKE` and `ILIKE`.
- Sort and limit query results with `ORDER BY` and `LIMIT`.
- Modify and delete records safely with `UPDATE` and `DELETE`.
- Handle missing values with `NULL`, `IS NULL` and `COALESCE`.
- Work with text using functions such as `CONCAT`, `UPPER`, `LOWER`, `TRIM`, `LENGTH` and `SUBSTRING`.
- Summarize data with aggregate functions.
- Group data and filter groups with `GROUP BY` and `HAVING`.
- Join related tables using `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` and `FULL OUTER JOIN`.
- Apply constraints, manage transactions and create views.
- Build practical inventory, category and price reports using joins, aggregates, subqueries and views.

## Progress

- [x] Day 1 — Database and project setup
- [x] Day 2 — Creating tables and relationships
- [x] Day 3 — Inserting sample data and retrieving records
- [x] Day 4 — `SELECT`, selected columns, aliases and `DISTINCT`
- [x] Day 5 — Filtering with `WHERE`
- [x] Day 6 — Sorting and limiting results
- [x] Day 7 — Week 1 checkpoint
- [x] Day 8 — `UPDATE` and `DELETE`
- [x] Day 9 — `NULL`, `COALESCE` and text handling
- [x] Day 10 — Aggregate functions
- [x] Day 11 — `GROUP BY` and `HAVING`
- [x] Day 12 — Joins and relationships
- [x] Day 13 — Constraints, transactions and views
- [x] Day 14 — Mini-project and review

## Repository structure

```text
postgresql-products-categories/
├── README.md
├── .gitignore
├── sql/
│   ├── 00a_drop_database.sql
│   ├── 00b_create_database.sql
│   ├── 00_setup.sql
│   ├── 01_create_tables.sql
│   ├── ...
│   ├── 10_joins.sql
│   ├── 11_constraints_transactions_views.sql
│   └── 12_mini_project_queries.sql
├── notes/
│   ├── daily-learning-log.md
│   └── mistakes-and-lessons.md
└── screenshots/
    └── .gitkeep
```

The SQL scripts are organised for practice and can be opened and run as files. Section headings and explanations are SQL comments, and statements are terminated with semicolons.

### Rebuilding the entire practice database

The database-level reset and table-level setup are separate because PostgreSQL does not allow a database to be dropped while connected to it, and `DROP DATABASE` cannot run inside a transaction.

1. In pgAdmin, open Query Tool connected to the maintenance database named `postgres`.
2. Open `sql/00a_drop_database.sql` and execute it. This drops `shop_practice` and all data in it. The `WITH (FORCE)` option terminates other connections to that database.
3. Still connected to `postgres`, open `sql/00b_create_database.sql` and execute it.
4. In pgAdmin, refresh the Databases list and connect Query Tool to the newly created `shop_practice` database.
5. Open `sql/00_setup.sql` and execute it. This creates the `categories` and `products` tables and inserts the sample records.
6. Verify the row counts and category report returned at the end of `00_setup.sql`.

**Important:** Steps 2 and 3 are destructive/rebuilding operations. Do not run them against a database containing work you want to keep. Take a backup first if there is any doubt. Run the DROP and CREATE statements separately, not as one transaction.

For learning the individual table-creation steps without resetting the database, use `01_create_tables.sql` on a database where those tables do not yet exist.

## Day 14 mini-project

The final practical exercise uses the `products` and `categories` tables to produce a joined product catalogue, inventory summary, category performance report, stock-monitoring results and price analysis. It also creates and queries a reusable `product_details` view and demonstrates transaction safety with `ROLLBACK`.

See [`sql/12_mini_project_queries.sql`](sql/12_mini_project_queries.sql) for the project queries.

The Day 13 lesson uses a `CHECK (stock_quantity >= 0)` constraint and an `active_products` view. The Day 12 category exercises use `LEFT JOIN` and calculate inventory value with `SUM(price * stock_quantity)`.

## Learning documentation

- [Daily learning log](notes/daily-learning-log.md) — topics covered, practical examples and key takeaways from each day.
- [Mistakes and lessons learned](notes/mistakes-and-lessons.md) — issues encountered, explanations and safe-practice reminders.

The learning log and lessons file are maintained alongside the SQL scripts so the repository captures both the practical work and the reasoning behind it.

## Working safely

- Check the target rows with a `SELECT` query before running an `UPDATE` or `DELETE`.
- Use a specific key such as `product_id` when modifying an individual product.
- Be careful when inserting sample data more than once; repeated `INSERT` statements can create duplicate rows unless uniqueness is enforced or the insert is designed to be repeat-safe.
- Use transactions to test changes that may need to be undone.
- Use constraints to enforce data rules at database level.
- Keep practice SQL scripts and learning notes in version control. Do not commit database passwords or other credentials.
