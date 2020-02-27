/*

Задача:

5. 
(по желанию) 
Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_3;
USE gb_mysql_3
DROP TABLE IF EXISTS catalogs;
CREATE TABLE IF NOT EXISTS catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

-- Вставляем тестовые записи:
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 1');
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 2');
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 3');
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 4');
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 5');
INSERT INTO catalogs (id, name) VALUES (NULL, 'cat 6');

-- Отсортируйте записи в порядке, заданном в списке IN (5, 1, 2): 
SELECT * FROM catalogs WHERE id IN (5,1,2) ORDER BY FIELD(id, 5,1,2);
