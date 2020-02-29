/*

Задача:

1.
Подсчитайте средний возраст пользователей в таблице users.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_4;
USE gb_mysql_4
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday DATE
);

-- Вставляем тестовые записи:
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user1', '1980-01-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user2', '1981-02-03');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user3', '1982-05-06');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user4', '1985-01-03');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user5', '1986-05-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user6', '1987-09-30');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user7', '1991-03-31');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user8', '1993-12-12');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user9', '1996-09-01');
INSERT INTO users (id, name, birthday) VALUES (NULL, 'user10', '2001-07-26');

-- Считаем возраст каждого из пользователей:
SELECT id, name, birthday, TIMESTAMPDIFF(YEAR, birthday, CURDATE()) AS age
FROM users
WHERE 1
ORDER BY id;

-- Считаем средний возраст всех пользователей в таблице users
SELECT AVG(age)
  FROM (
    SELECT id, name, birthday, TIMESTAMPDIFF(YEAR, birthday, CURDATE()) AS age
    FROM users WHERE 1
  ) as AVG;

-- Считаем округлённый до целого значения средний возраст всех пользователей в таблице users
SELECT FLOOR(AVG(age))
  FROM (
    SELECT id, name, birthday, TIMESTAMPDIFF(YEAR, birthday, CURDATE()) AS age
    FROM users WHERE 1
  ) as AVG;
