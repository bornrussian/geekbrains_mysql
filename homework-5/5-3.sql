/*

Задача:

3. (по желанию) Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов (flights) с русскими названиями городов.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS gb_mysql_5;
USE gb_mysql_5

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  cityfrom VARCHAR(255),
  cityto VARCHAR(255)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);



-- Вставляем тестовые записи:

INSERT INTO flights (id, cityfrom, cityto) VALUES (NULL, 'moscow', 'omsk');
INSERT INTO flights (id, cityfrom, cityto) VALUES (NULL, 'novgorod', 'kazan');
INSERT INTO flights (id, cityfrom, cityto) VALUES (NULL, 'irkutsk', 'moscow');
INSERT INTO flights (id, cityfrom, cityto) VALUES (NULL, 'omsk', 'irkutsk');
INSERT INTO flights (id, cityfrom, cityto) VALUES (NULL, 'moscow', 'kazan');

INSERT INTO cities (label, name) VALUES ('moscow', 'Москва');
INSERT INTO cities (label, name) VALUES ('irkutsk', 'Иркутск');
INSERT INTO cities (label, name) VALUES ('novgorod', 'Новгород');
INSERT INTO cities (label, name) VALUES ('kazan', 'Казань');
INSERT INTO cities (label, name) VALUES ('omsk', 'Омск');



-- Список рейсов (flights) с русскими названиями городов:

SELECT f.id as flight_id, city_from.name as city_from_name, city_to.name as city_to_name
FROM flights f
LEFT JOIN cities city_from ON f.cityfrom=city_from.label
LEFT JOIN cities city_to ON f.cityto=city_to.label
WHERE 1
ORDER BY f.id
/*
Результат:
+-----------+------------------+----------------+
| flight_id | city_from_name   | city_to_name   |
+-----------+------------------+----------------+
|         1 | Москва           | Омск           |
|         2 | Новгород         | Казань         |
|         3 | Иркутск          | Москва         |
|         4 | Омск             | Иркутск        |
|         5 | Москва           | Казань         |
+-----------+------------------+----------------+
*/
