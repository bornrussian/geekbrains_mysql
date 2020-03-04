/*

Задача:

2. Выведите список товаров products и разделов catalogs, который соответствует товару.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS gb_mysql_5;
USE gb_mysql_5

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



-- Список товаров products и разделов catalogs, который соответствует товару:

SELECT p.id as product_id, p.name as product_name, c.name as catalogs_name
FROM products p
LEFT JOIN catalogs c ON p.cat_id=c.id
WHERE 1
ORDER BY p.cat_id, p.name
/*
Результат:
+------------+--------------+------------------+
| product_id | product_name | catalogs_name    |
+------------+--------------+------------------+
|          2 | Huawei       | Телефоны         |
|          1 | Samsung      | Телефоны         |
|          3 | Xiaomi       | Телефоны         |
|          4 | Marshall     | Наушники         |
+------------+--------------+------------------+
*/
