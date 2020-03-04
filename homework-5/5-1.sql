/*

Задача:

1. Составьте список пользователей users,
которые осуществили хотя бы один заказ (orders) в интернет-магазине.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS gb_mysql_5;
USE gb_mysql_5

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255)
) COMMENT='Users list';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id BIGINT,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  comment VARCHAR(255)
) COMMENT='Orders list';



-- Вставляем тестовые записи:

INSERT INTO users (id, name) VALUES (1, 'mr First');
INSERT INTO users (id, name) VALUES (2, 'mr Second');
INSERT INTO users (id, name) VALUES (3, 'mr Third');

INSERT INTO orders (id, user_id, date, comment) VALUES (NULL, 1, DEFAULT, 'mr First order #1');
INSERT INTO orders (id, user_id, date, comment) VALUES (NULL, 1, DEFAULT, 'mr First order #2');
INSERT INTO orders (id, user_id, date, comment) VALUES (NULL, 1, DEFAULT, 'mr First order #3');
INSERT INTO orders (id, user_id, date, comment) VALUES (NULL, 2, DEFAULT, 'mr Second order #1');



-- Список пользователей users, которые осуществили хотя бы один заказ:

SELECT id, name FROM users WHERE id IN (
  SELECT DISTINCT user_id FROM orders WHERE 1
);
/*
Результат:
+----+-----------+
| id | name      |
+----+-----------+
|  1 | mr First  |
|  2 | mr Second |
+----+-----------+
*/



-- Список пользователей users, c подсчётом количества заказов, которые они сделали:

SELECT users.id as user_id, users.name as user_name, COUNT(*) as orders_total
FROM orders
LEFT JOIN users ON orders.user_id=users.id
GROUP BY orders.user_id
ORDER BY orders_total DESC;
/*
Результат:
+---------+-----------+--------------+
| user_id | user_name | orders_total |
+---------+-----------+--------------+
|       1 | mr First  |            3 |
|       2 | mr Second |            1 |
+---------+-----------+--------------+
*/
