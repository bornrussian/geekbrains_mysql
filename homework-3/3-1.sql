/*

Задача:

1. 
Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_3;
USE gb_mysql_3
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  created_at DATETIME,
  updated_at DATETIME
);

-- Вставляем тестовые записи:
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user1', NULL, NULL);
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user2', NULL, NULL);
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user3', NULL, NULL);
INSERT INTO users (id, name, created_at, updated_at) VALUES (NULL, 'user4', '2020-02-27 10:25:01', '2020-02-27 10:25:01');

-- Смотрим на тестовые записи:
DESCRIBE users;
SELECT * FROM users;

-- Заполняем пустые поля created_at updated_at текущей датой:
UPDATE users SET created_at = NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL;

-- Смотрим на полученный результат:
DESCRIBE users;
SELECT * FROM users;
