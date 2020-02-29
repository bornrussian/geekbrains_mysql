/*

Задача:

3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.

*/

-- Подготавливаем структуру задания:
CREATE DATABASE IF NOT EXISTS gb_mysql_4;
USE gb_mysql_4
DROP TABLE IF EXISTS multiply;
CREATE TABLE IF NOT EXISTS multiply (
  id SERIAL PRIMARY KEY,
  value INT
);

-- Вставляем тестовые записи:
INSERT INTO multiply (id, value) VALUES (NULL, -1);
INSERT INTO multiply (id, value) VALUES (NULL, 2);
INSERT INTO multiply (id, value) VALUES (NULL, 3);
INSERT INTO multiply (id, value) VALUES (NULL, 4);
INSERT INTO multiply (id, value) VALUES (NULL, 5);

-- Отображаем исходные значения:
SELECT value FROM multiply WHERE 1 ORDER BY id;
/*
Результат:
+-------+
| value |
+-------+
|    -1 |
|     2 |
|     3 |
|     4 |
|     5 |
+-------+
*/

-- Способ №1, работающий только с положительными числами (изза логарифма) с некоторой погрешностью изза использования дробных чисел:
SELECT EXP(SUM(LOG(value))) AS mult
FROM multiply
WHERE 1;
/*
Результат:
+--------------------+
| mult               |
+--------------------+
| 119.99999999999997 |
+--------------------+
*/


-- Способ №2, с циклом и переменными, который будет работать и с отрицательными значениями тоже:
SELECT mult
FROM(
  SELECT @n:=@n+1 i, @mult:=@mult*t.value mult
  FROM multiply t, (SELECT @n:=0,@mult:=1) v
  ) p
WHERE i=@n;
/*
Результат:
+------+
| mult |
+------+
| -120 |
+------+
*/
