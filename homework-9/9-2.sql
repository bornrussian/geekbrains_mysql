/*

Задача:

2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


-- Функция, которая вставит num записей в таблицу users вида user-0cb9e5718320

DELIMITER //
DROP PROCEDURE IF EXISTS insert_users;
CREATE PROCEDURE insert_users (IN num INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  IF (num > 0) THEN
    WHILE i < num DO
    INSERT INTO users (id, name) VALUES (NULL, CONCAT('user-', SUBSTRING(MD5(RAND()) FROM 1 FOR 12)));
    SET i = i + 1;
    END WHILE;
  ELSE
    SELECT 'Ошибочное значение параметра';
  END IF;
END//
DELIMITER ;



-- Вставляем тестовые записи, у меня на виртуалке выполнялось долго, 4 min 22.65 sec:

CALL insert_users(1000000);



-- Смотрим на содержимое logs:

SELECT * FROM users LIMIT 10;
/*
+----+-------------------+
| id | name              |
+----+-------------------+
|  1 | user-a6932bc3894f |
|  2 | user-64b747f80e8d |
|  3 | user-81209ffa3d1c |
|  4 | user-18b0069f8688 |
|  5 | user-541500be1ec5 |
|  6 | user-dcb3c99c4d73 |
|  7 | user-bfb31e49b788 |
|  8 | user-29f6dba80bef |
|  9 | user-427b872724dd |
| 10 | user-ad9c1cf0035e |
+----+-------------------+
*/


SELECT COUNT(*) FROM users;
/*
+----------+
| COUNT(*) |
+----------+
|  1000000 |
+----------+
*/