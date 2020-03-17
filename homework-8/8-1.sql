/*

Задача:
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер",
с 00:00 до 6:00 — "Доброй ночи".

*/

DELIMITER //
DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello ()
RETURNS TEXT NOT DETERMINISTIC
BEGIN
  DECLARE curhour INT DEFAULT 0;
  SET curhour = HOUR(NOW());
  IF (curhour >= 18) THEN
    RETURN "Добрый вечер";
  ELSEIF (curhour >= 12) THEN
    RETURN "Добрый день";
  ELSEIF (curhour >= 6) THEN
    RETURN "Доброе утро";
  ELSE
    RETURN "Доброй ночи";
  END IF;
END//
DELIMITER ;



-- Смотрим на результат выполнения функции :

CREATE DATABASE IF NOT EXISTS shop;
USE shop
SELECT hello();
/*
+-------------------------+
| hello()                 |
+-------------------------+
| Добрый вечер            |
+-------------------------+
*/
