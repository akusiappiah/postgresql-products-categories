**# Mistakes and Lessons Learned**



**## Day 2 – PostgreSQL Tables**



**### Lesson 1: Foreign key enforcement**



**\*\*What I tested:\*\***



**I attempted to insert a product with category\_id = 99999, even though that category did not exist.**



**\*\*What happened:\*\***



**PostgreSQL rejected the INSERT operation.**



**\*\*What I learned:\*\***



**A foreign key prevents records from referencing nonexistent records in another table.**



**\*\*Lesson:\*\***



**Always establish appropriate relationships and constraints when designing relational databases.**



**### Lesson 2: Automatically generated IDs**



**\*\*What I learned:\*\***



**Using GENERATED ALWAYS AS IDENTITY allows PostgreSQL to generate primary key values automatically.**



**\*\*Lesson:\*\***



**I don't need to manually assign IDs when inserting new categories or products.**

