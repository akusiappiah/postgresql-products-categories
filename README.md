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
├── notes/
│   ├── daily-learning-log.md
│   └── mistakes-and-lessons.md
└── screenshots/
    └── .gitkeep
```

SQL scripts and screenshots are added as the learning exercises progress. The Day 14 mini-project consolidates the core skills in a set of reusable reporting queries.

## Day 14 mini-project

The final practical exercise uses the `products` and `categories` tables to produce a joined product catalogue, inventory summary, category performance report, stock-monitoring results and price analysis. It also creates and queries a reusable `product_details` view and demonstrates transaction safety with `ROLLBACK`.

See [`sql/12_mini_project_queries.sql`](sql/12_mini_project_queries.sql) for the project queries.

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
