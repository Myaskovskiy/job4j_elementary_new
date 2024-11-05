транзакция 1


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
postgres=*# insert into books (name, count, price) VALUES ('book_4', 11, 64);
INSERT 0 1
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
(4 ёЄЁюъш)


postgres=*# commit;
COMMIT
postgres=# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
(4 ёЄЁюъш)

Повторяющееся чтение (repeatable read) 


postgres=# drop table books;
DROP TABLE
postgres=# create table books
postgres-# (
postgres(#     id       serial primary key,
postgres(#     name     varchar(50),
postgres(#     count    integer default 0,
postgres(#     price    integer
postgres(# );
CREATE TABLE
postgres=#
postgres=# insert into books (name, count, price)
postgres-# VALUES ('book_1', 3, 50);
INSERT 0 1
postgres=# insert into books (name, count, price)
postgres-# VALUES ('book_2', 15, 32);
INSERT 0 1
postgres=# insert into books (name, count, price)
postgres-# VALUES ('book_3', 8, 115);
INSERT 0 1
postgres=# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
(3 ёЄЁюъш)


postgres=#
postgres=# begin transaction;
BEGIN
postgres=*# set session transaction isolation level repeatable read;
SET
postgres=*# insert into books (name, count, price) VALUES ('book_4', 11, 64);
INSERT 0 1
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  1 | book_1 |     3 |    50
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
(4 ёЄЁюъш)


postgres=*# update books set price = 75 where name = 'book_1';
UPDATE 1
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |    75
(4 ёЄЁюъш)


postgres=*# commit;
COMMIT
postgres=#



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


postgres=*# update books set price = 10 where name = 'book_1';
UPDATE 1
postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |    10
(4 ёЄЁюъш)


postgres=*# select sum(price) from books;
 sum
-----
 221
(1 ёЄЁюър)


postgres=*# select sum(price) from books;
 sum
-----
 221
(1 ёЄЁюър)


postgres=*# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  2 | book_2 |    15 |    32
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |    10
(4 ёЄЁюъш)


postgres=*# commit;
ОШИБКА:  не удалось сериализовать доступ из-за зависимостей чтения/записи между транзакциями
ПОДРОБНОСТИ:  Reason code: Canceled on identification as a pivot, during commit attempt.
ПОДСКАЗКА:  Транзакция может завершиться успешно при следующей попытке.
postgres=# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |   100
  2 | book_2 |    15 |    10
(4 ёЄЁюъш)


postgres=# rollback;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
ROLLBACK
postgres=# commit;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
COMMIT
postgres=# commit;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
COMMIT
postgres=# select * from books;
 id |  name  | count | price
----+--------+-------+-------
  3 | book_3 |     8 |   115
  4 | book_4 |    11 |    64
  1 | book_1 |     3 |   100
  2 | book_2 |    15 |    10
(4 ёЄЁюъш)

