/*

Задача:

3. 
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Нулевые запасы должны выводиться в конце, после всех записей.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_3;
USE gb_mysql_3
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE IF NOT EXISTS storehouses_products (
  id SERIAL PRIMARY KEY,
  name varchar(100),
  value int
);

-- Вставляем тестовые записи:
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 1', 0);
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 2', 2500);
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 3', 0);
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 4', 30);
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 5', 500);
INSERT INTO storehouses_products (id, name, value) VALUES (NULL, 'product 6', 1);

-- Отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
-- Нулевые запасы должны выводиться в конце, после всех записей :
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 1, 0) DESC, value ASC

