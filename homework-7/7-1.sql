/*

Задача:

1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
второму пользователю shop — любые операции в пределах базы данных shop.

*/



-- Готовим структуру базы данных `shop`:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS table1;
CREATE TABLE table1 (
  id BIGINT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO table1 (id, name) VALUES (1, 'First');
INSERT INTO table1 (id, name) VALUES (2, 'Second');
INSERT INTO table1 (id, name) VALUES (3, 'Third');



-- Создаём пользователя с правами на чтение БД shop:

DROP USER IF EXISTS 'shop_read'@'%';
CREATE USER 'shop_read'@'%' IDENTIFIED BY 'password111';
GRANT SELECT ON shop.* TO 'shop_read'@'%';


-- Создаём пользователя с полными правами в БД shop:

DROP USER IF EXISTS 'shop'@'%';
CREATE USER 'shop'@'%' IDENTIFIED BY 'password222';
GRANT ALL ON shop.* TO 'shop'@'%';
