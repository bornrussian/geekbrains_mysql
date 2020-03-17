/*

Задача:

2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них.
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
При попытке присвоить полям NULL-значение необходимо отменить операцию.

*/



-- Готовим структуру таблиц:

CREATE DATABASE IF NOT EXISTS shop;
USE shop

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255)
);


-- Готовим триггеры:

DELIMITER //
DROP TRIGGER IF EXISTS control_products_on_insert//
CREATE TRIGGER control_products_on_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF (NEW.name IS NULL) THEN
    IF (NEW.description IS NULL) THEN
      SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'INSERT canceled because name and description both are NULL';
    END IF;
  END IF;
END//

DROP TRIGGER IF EXISTS control_products_on_update//
CREATE TRIGGER control_products_on_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF (NEW.name IS NULL) THEN
    IF (NEW.description IS NULL) THEN
      SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'UPDATE canceled because name and description both are NULL';
    END IF;
  END IF;
END//

DELIMITER ;


-- Вставляем тестовые записи:

INSERT INTO products (id, name, description) VALUES (NULL, 'name-1', 'descr-1');
INSERT INTO products (id, name, description) VALUES (NULL, 'name-2', NULL);
INSERT INTO products (id, name, description) VALUES (NULL, NULL, 'descr-3');
UPDATE products SET name = NULL WHERE name LIKE 'name-1' LIMIT 1;
UPDATE products SET name = 'name 1' WHERE description LIKE 'descr-1' LIMIT 1;


-- Эти запросы не должны выполниться, их отменит триггер:

INSERT INTO products (id, name, description) VALUES (NULL, NULL, NULL);
UPDATE products SET name = NULL WHERE name LIKE 'name-2' LIMIT 1;


-- Смотрим на содержимое тестовой таблицы, убеждаясь что там нет значений name=NULL одновременно с descr=NULL:

SELECT * FROM products;
