create table books
(
    id       serial primary key,
    name     varchar(50),
    count    integer default 0,
    price    integer
);

insert into books (name, count, price)
VALUES ('book_1', 3, 50);
insert into books (name, count, price)
VALUES ('book_2', 15, 32);
insert into books (name, count, price)
VALUES ('book_3', 8, 115);

begin transaction;
set session transaction isolation level read uncommitted;
set session transaction isolation level read committed;

insert into books (name, count, price) VALUES ('book_4', 11, 64);

begin transaction;
set session transaction isolation level repeatable read;

insert into books (name, count, price) VALUES ('book_4', 11, 64); -- транзакция 1
update books set price = 75 where name = 'book_4'; -- транзакция 2
UPDATE 0

update books set price = 75 where name = 'book_1'; -- транзакция 1
update books set price = 100 where name = 'book_1'; -- транзакция 2

commit; -- транзакция 1
ОШИБКА:  не удалось сериализовать доступ из-за параллельного изменения -- транзакция 2

begin transaction;
set session transaction isolation level repeatable read;


update books set price = 175 where name = 'book_1'; -- транзакция 1
update books set price = 100 where name = 'book_1'; -- транзакция 2


Сериализация (serializable)

begin transaction;
set session transaction isolation level serializable;

select sum(price) from books;-- транзакция 1
update books set price = 10 where name = 'book_1'; -- транзакция 1

select sum(price) from books;-- транзакция 2
update books set price = 10 where name = 'book_2'; -- транзакция 2