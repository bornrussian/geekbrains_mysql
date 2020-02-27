/*

Задача:

2.
Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_3;
USE gb_mysql_3
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name varchar(100),
  created_at varchar(100),
  updated_at varchar(100)
);

-- Вставляем тестовые записи:
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user1', '20.10.2017 8:00', '20.10.2017 8:00');
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user2', '20.10.2017 9:00', '20.10.2017 9:00');
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user3', '20.10.2017 10:00', '20.10.2017 10:00');

-- Смотрим на тестовые записи:
DESCRIBE users;
SELECT * FROM users;

-- Преобразовать поля к типу DATETIME, сохранив введеные ранее значения:
UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %h:%i");
UPDATE users SET updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %h:%i");
ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;

-- Смотрим на полученный результат:
DESCRIBE users;
SELECT * FROM users;
