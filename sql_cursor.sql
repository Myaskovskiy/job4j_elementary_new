postgres=# create table products
postgres-# (
postgres(#     id    serial primary key,
postgres(#     name  varchar(50),
postgres(#     count integer default 0,
postgres(#     price integer
postgres(# );
CREATE TABLE
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_1', 1, 5);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_2', 2, 10);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_3', 3, 15);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_4', 4, 20);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_5', 5, 25);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_6', 6, 30);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_7', 7, 35);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_8', 8, 40);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_9', 9, 45);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_10', 10, 50);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_11', 11, 55);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_12', 12, 60);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_13', 13, 65);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_14', 14, 70);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_15', 15, 75);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_16', 16, 80);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_17', 17, 85);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_18', 18, 90);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_19', 19, 95);
INSERT 0 1
postgres=# insert into products (name, count, price)
postgres-# VALUES ('product_20', 20, 100);
INSERT 0 1
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


postgres=# MOVE FORWARD 20 FROM cursor_products;
ОШИБКА:  курсор "cursor_products" не существует
postgres=# BEGIN;
BEGIN
postgres=*# DECLARE
postgres-*# cursor_products cursor for
postgres-*# select * from products;
DECLARE CURSOR
postgres=*# MOVE FORWARD 20 FROM cursor_products;
MOVE 20
postgres=*# MOVE BACKWARD 6 FROM cursor_products;
MOVE 6
postgres=*# FETCH NEXT FROM cursor_products;
 id |    name    | count | price
----+------------+-------+-------
 15 | product_15 |    15 |    75
(1 ёЄЁюър)


postgres=*# MOVE BACKWARD 8 FROM cursor_products;
MOVE 8
postgres=*# FETCH NEXT FROM cursor_products;
 id |   name    | count | price
----+-----------+-------+-------
  8 | product_8 |     8 |    40
(1 ёЄЁюър)


postgres=*# MOVE PRIOR FROM cursor_products;
MOVE 1
postgres=*# MOVE BACKWARD 5 FROM cursor_products;
MOVE 5
postgres=*# MOVE PRIOR FROM cursor_products;
MOVE 1
postgres=*# MOVE PRIOR FROM cursor_products;
MOVE 0
postgres=*# FETCH NEXT FROM cursor_products;
 id |   name    | count | price
----+-----------+-------+-------
  1 | product_1 |     1 |     5
(1 ёЄЁюър)


postgres=*# CLOSE cursor_products;
CLOSE CURSOR
postgres=*# COMMIT;
COMMIT
postgres=#