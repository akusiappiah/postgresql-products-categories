-- 00a_drop_database.sql
-- Run this file in pgAdmin Query Tool while connected to the postgres database.
-- WARNING: This permanently deletes the shop_practice database and ALL its contents.
-- Ensure you have a backup and really intend to rebuild the practice database.
-- Run this statement on its own (DROP DATABASE cannot run inside a transaction).

DROP DATABASE IF EXISTS shop_practice WITH (FORCE);
