/*

Задача:

2.
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения.

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

-- Ищем, в какой день недели будет день рождения у каждого пользователя в этом году:
SELECT id, name, birthday, DAYNAME(CONCAT(YEAR(NOW()),'-',SUBSTRING(birthday, 6, 5))) as birthdayname_this_year
FROM users
WHERE 1
ORDER BY id;
/*
Результат:
+----+--------+------------+------------------------+
| id | name   | birthday   | birthdayname_this_year |
+----+--------+------------+------------------------+
|  1 | user1  | 1980-01-01 | Wednesday              |
|  2 | user2  | 1981-02-03 | Monday                 |
|  3 | user3  | 1982-05-06 | Wednesday              |
|  4 | user4  | 1985-01-03 | Friday                 |
|  5 | user5  | 1986-05-01 | Friday                 |
|  6 | user6  | 1987-09-30 | Wednesday              |
|  7 | user7  | 1991-03-31 | Tuesday                |
|  8 | user8  | 1993-12-12 | Saturday               |
|  9 | user9  | 1996-09-01 | Tuesday                |
| 10 | user10 | 2001-07-26 | Sunday                 |
+----+--------+------------+------------------------+
*/

-- Количество дней рождения, которые приходятся на каждый из дней недели:
SELECT COUNT(*), DAYNAME(CONCAT(YEAR(NOW()),'-',SUBSTRING(birthday, 6, 5))) as birthdayname_this_year
FROM users
WHERE 1
GROUP BY birthdayname_this_year;
/*
Результат:
+----------+------------------------+
| COUNT(*) | birthdayname_this_year |
+----------+------------------------+
|        2 | Friday                 |
|        1 | Monday                 |
|        1 | Saturday               |
|        1 | Sunday                 |
|        2 | Tuesday                |
|        3 | Wednesday              |
+----------+------------------------+
*/
