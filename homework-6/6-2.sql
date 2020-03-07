/*

Задача:

2. Создайте представление, которое выводит название (name) товарной позиции
из таблицы products и соответствующее название (name) каталога из таблицы catalogs.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS gb_mysql_6;
USE gb_mysql_6

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  cat_id BIGINT,
  name VARCHAR(255)
);



-- Вставляем тестовые записи:

INSERT INTO catalogs (id, name) VALUES (1, 'Телефоны');
INSERT INTO catalogs (id, name) VALUES (2, 'Наушники');
INSERT INTO catalogs (id, name) VALUES (3, 'Батарейки');

INSERT INTO products (id, cat_id, name) VALUES (NULL, 1, 'Samsung');
INSERT INTO products (id, cat_id, name) VALUES (NULL, 1, 'Huawei');
INSERT INTO products (id, cat_id, name) VALUES (NULL, 1, 'Xiaomi');
INSERT INTO products (id, cat_id, name) VALUES (NULL, 2, 'Marshall');



-- Представление, которое выводит названия товаров и их каталогов:

CREATE OR REPLACE VIEW listproducts AS
SELECT p.name as product_name, c.name as catalogs_name
FROM products p
LEFT JOIN catalogs c ON p.cat_id=c.id
ORDER BY p.cat_id, p.name


/* Результат:

MariaDB [gb_mysql_6]> SELECT * FROM listproducts;
+--------------+------------------+
| product_name | catalogs_name    |
+--------------+------------------+
| Huawei       | Телефоны         |
| Samsung      | Телефоны         |
| Xiaomi       | Телефоны         |
| Marshall     | Наушники         |
+--------------+------------------+
4 rows in set (0.00 sec)

*/
