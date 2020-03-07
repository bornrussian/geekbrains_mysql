/*

Задача:

1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
Используйте транзакции.

*/



-- Готовим структуру базы данных `shop`:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO users (id, name) VALUES (1, 'mr First');
INSERT INTO users (id, name) VALUES (2, 'mr Second');
INSERT INTO users (id, name) VALUES (3, 'mr Third');



-- Готовим структуру базы данных `sample`:

CREATE DATABASE IF NOT EXISTS sample;
USE sample

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255)
);



/* Содержимое таблиц до выполнения транзакции:

MariaDB [sample]> SELECT * FROM shop.users;
+----+-----------+
| id | name      |
+----+-----------+
|  1 | mr First  |
|  2 | mr Second |
|  3 | mr Third  |
+----+-----------+
3 rows in set (0.00 sec)

MariaDB [sample]> SELECT * FROM sample.users;
Empty set (0.00 sec)
*/



-- Перемещаем запись id = 1 из таблицы shop.users в таблицу sample.users :

START TRANSACTION;

INSERT INTO sample.users
SELECT *
FROM shop.users
WHERE id = 1;

DELETE
FROM shop.users 
WHERE id = 1;

COMMIT;



/* Содержимое таблиц после выполнения транзакции:

MariaDB [sample]> SELECT * FROM shop.users;
+----+-----------+
| id | name      |
+----+-----------+
|  2 | mr Second |
|  3 | mr Third  |
+----+-----------+
2 rows in set (0.00 sec)

MariaDB [sample]> SELECT * FROM sample.users;
+----+----------+
| id | name     |
+----+----------+
|  1 | mr First |
+----+----------+
1 row in set (0.00 sec)
*/
