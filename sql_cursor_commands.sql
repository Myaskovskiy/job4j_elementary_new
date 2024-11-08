psql --username=postgres

create table books
(
    id       serial primary key,
    name     varchar(50),
    count    integer default 0,
    price    integer
);

insert into products (name, count, price)
VALUES ('product_1', 1, 5);
insert into products (name, count, price)
VALUES ('product_2', 2, 10);
insert into products (name, count, price)
VALUES ('product_3', 3, 15);
insert into products (name, count, price)
VALUES ('product_4', 4, 20);
insert into products (name, count, price)
VALUES ('product_5', 5, 25);
insert into products (name, count, price)
VALUES ('product_6', 6, 30);
insert into products (name, count, price)
VALUES ('product_7', 7, 35);
insert into products (name, count, price)
VALUES ('product_8', 8, 40);
insert into products (name, count, price)
VALUES ('product_9', 9, 45);
insert into products (name, count, price)
VALUES ('product_10', 10, 50);
insert into products (name, count, price)
VALUES ('product_11', 11, 55);
insert into products (name, count, price)
VALUES ('product_12', 12, 60);
insert into products (name, count, price)
VALUES ('product_13', 13, 65);
insert into products (name, count, price)
VALUES ('product_14', 14, 70);
insert into products (name, count, price)
VALUES ('product_15', 15, 75);
insert into products (name, count, price)
VALUES ('product_16', 16, 80);
insert into products (name, count, price)
VALUES ('product_17', 17, 85);
insert into products (name, count, price)
VALUES ('product_18', 18, 90);
insert into products (name, count, price)
VALUES ('product_19', 19, 95);
insert into products (name, count, price)
VALUES ('product_20', 20, 100);


postgres=# select * from products;
 id |    name    | count | price
----+------------+-------+-------
  1 | product_1  |     1 |     5
  2 | product_2  |     2 |    10
  3 | product_3  |     3 |    15
  4 | product_4  |     4 |    20
  5 | product_5  |     5 |    25
  6 | product_6  |     6 |    30
  7 | product_7  |     7 |    35
  8 | product_8  |     8 |    40
  9 | product_9  |     9 |    45
 10 | product_10 |    10 |    50
 11 | product_11 |    11 |    55
 12 | product_12 |    12 |    60
 13 | product_13 |    13 |    65
 14 | product_14 |    14 |    70
 15 | product_15 |    15 |    75
 16 | product_16 |    16 |    80
 17 | product_17 |    17 |    85
 18 | product_18 |    18 |    90
 19 | product_19 |    19 |    95
 20 | product_20 |    20 |   100
(20 ёЄЁюъ)


BEGIN;
DECLARE
cursor_products cursor for
select * from products;

FETCH NEXT FROM cursor_products;

-- перейдите на последнюю запись в таблице
MOVE FORWARD 20 FROM cursor_products;

--затем перейдите на 15 запись
MOVE BACKWARD 6 FROM cursor_products;

--с 15 на 7
MOVE BACKWARD 8 FROM cursor_products;

--с 7 на 2
MOVE BACKWARD 5 FROM cursor_products;

--затем на 1

MOVE PRIOR FROM cursor_products;

CLOSE cursor_products;
COMMIT;


