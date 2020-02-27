/*

Задача:

4. 
(по желанию) 
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august')

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_3;
USE gb_mysql_3
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  birthday DATE
);

-- Вставляем тестовые записи:
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user1', '1980-01-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user2', '1980-02-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user3', '1980-03-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user4', '1980-04-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user5', '1980-05-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user6', '1980-06-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user7', '1980-07-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user8', '1980-08-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user9', '1980-09-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user10', '1980-10-01');

-- Родились в мае и августе:
SELECT * FROM users WHERE MONTHNAME(birthday) IN ('may', 'august');
