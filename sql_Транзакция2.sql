Транзакция 2

postgres=# begin transaction;
BEGIN
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
(3 ёЄЁюъш)


postgres=*# set session transaction isolation level read committed;
SET
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
(3 ёЄЁюъш)


postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
(4 ёЄЁюъш)


Повторяющееся чтение (repeatable read) 

postgres=# select * from books;
ОШИБКА:  отношение "books" не существует
СТРОКА 1: select * from books;
                        ^
postgres=#
postgres=# begin transaction;
BEGIN
postgres=*# set session transaction isolation level repeatable read;
SET
postgres=*# update books set price = 75 where name = 'book_4';
UPDATE 0
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
(3 ёЄЁюъш)


postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
(3 ёЄЁюъш)


postgres=*# update books set price = 100 where name = 'book_1';
ОШИБКА:  не удалось сериализовать доступ из-за параллельного изменения
postgres=!#



Сериализация (serializable)

begin transaction;
set session transaction isolation level serializable;

select sum(price) from books;-- транзакция 1
update books set price = 10 where name = 'book_1'; -- транзакция 1

select sum(price) from books;-- транзакция 2
update books set price = 10 where name = 'book_2'; -- транзакция 2



postgres=# begin transaction;
BEGIN
postgres=*# set session transaction isolation level serializable;
SET
postgres=*# select sum(count) from books;
 sum
-----
  37
(1 ёЄЁюър)


postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |   100
(4 ёЄЁюъш)


postgres=*# select sum(price) from books;
 sum
-----
 311
(1 ёЄЁюър)


postgres=*# update books set price = 10 where name = 'book_2';
UPDATE 1
postgres=*# select sum(price) from books;
 sum
-----
 289
(1 ёЄЁюър)


postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |   100
  2 | book_2 |    15 |    10
(4 ёЄЁюъш)


postgres=*# commit;
COMMIT
