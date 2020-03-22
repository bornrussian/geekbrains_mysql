/*

Задача:

1. Создайте таблицу logs типа Archive.
Пусть при каждом создании записи в таблицах users, catalogs и products
в таблицу logs помещается время и дата создания записи, название таблицы,
идентификатор первичного ключа и содержимое поля name.

*/

-- Если у вас Ubuntu 18.04 и MariaDB, в котором сразу нет Engine=Archive, то:
-- MariaDB [shop]> INSTALL PLUGIN archive SONAME 'ha_archive.so';


-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  time_logged DATETIME,
  table_logged VARCHAR(255),
  table_value_id BIGINT,
  table_value_name VARCHAR(255)
) ENGINE=ARCHIVE;



-- Готовим триггеры:

DELIMITER //

DROP TRIGGER IF EXISTS log_users_on_insert//
CREATE TRIGGER log_users_on_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (id, time_logged, table_logged, table_value_id, table_value_name) VALUES (NULL, NOW(), 'users', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_catalogs_on_insert//
CREATE TRIGGER log_catalogs_on_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO logs (id, time_logged, table_logged, table_value_id, table_value_name) VALUES (NULL, NOW(), 'catalogs', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_products_on_insert//
CREATE TRIGGER log_products_on_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO logs (id, time_logged, table_logged, table_value_id, table_value_name) VALUES (NULL, NOW(), 'products', NEW.id, NEW.name);
END//

DELIMITER ;



-- Вставляем тестовые записи:

INSERT INTO users (id, name) VALUES (NULL, 'user1 name');
INSERT INTO users (id, name) VALUES (NULL, 'user2 name');
INSERT INTO catalogs (id, name) VALUES (NULL, 'catalog name');
INSERT INTO products (id, name) VALUES (NULL, 'product name');



-- Смотрим на содержимое logs:

SELECT * FROM logs;
/*
+----+---------------------+--------------+----------------+------------------+
| id | time_logged         | table_logged | table_value_id | table_value_name |
+----+---------------------+--------------+----------------+------------------+
|  1 | 2020-03-22 14:48:22 | users        |              1 | user1 name       |
|  2 | 2020-03-22 14:48:22 | users        |              2 | user2 name       |
|  3 | 2020-03-22 14:48:22 | catalogs     |              1 | catalog name     |
|  4 | 2020-03-22 14:48:22 | products     |              1 | product name     |
+----+---------------------+--------------+----------------+------------------+
4 rows in set (0.00 sec)
*/
