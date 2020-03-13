/*

Задача:

2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: 
id, name, password, которые содержат первичный ключ, имя пользователя и его пароль. 

Создайте представление username таблицы accounts, предоставляющее доступ к столбцам id и name. 
Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password VARCHAR(255)
);


-- Вставляем тестовые записи:

INSERT INTO accounts (id, name, password) VALUES (NULL, 'user1', 'pass1');
INSERT INTO accounts (id, name, password) VALUES (NULL, 'user2', 'pass2');
INSERT INTO accounts (id, name, password) VALUES (NULL, 'user3', 'pass3');


-- Представление username таблицы accounts, предоставляющее доступ к столбцам id и name:

CREATE OR REPLACE VIEW username AS
SELECT id, name
FROM accounts;


-- Пользователь user_read, который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username:

DROP USER IF EXISTS 'user_read'@'%';
CREATE USER 'user_read'@'%' IDENTIFIED BY 'password111';
GRANT SELECT ON shop.username TO 'user_read'@'%';
