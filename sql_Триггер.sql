

create table products
(
    id       serial primary key,
    name     varchar(50),
    producer varchar(50),
    count    integer default 0,
    price    integer
);

insert into products (name, producer, count, price) VALUES ('product_1', 'pr_test6', 10, 1000);	
insert into products (name, producer, count, price) VALUES ('product_2', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_3', 'pr_test6', 2, 1000);	


--1)  Триггер должен срабатывать после вставки данных, для любого товара и просто насчитывать
-- налог на товар (нужно прибавить налог к цене товара). Действовать он должен не на каждый ряд,
-- а на запрос (statement уровень)


 create trigger nalog_trigger
    after insert
    on products
    referencing new table as
                    inserted
    for each statement
    execute procedure nalogAll();
	
create
or replace function nalogAll()
    returns trigger as
$$
    BEGIN
        update products
        set price = price + price * 0.2;       
        return new;
    END;
$$
LANGUAGE 'plpgsql';	

insert into products (name, producer, count, price) VALUES ('product_4', 'pr_test6', 2, 1000);	

--2) Триггер должен срабатывать до вставки данных и насчитывать налог на товар
-- (нужно прибавить налог к цене товара). Здесь используем row уровень.



create or replace function nalogRow()
    returns trigger as
$$
    BEGIN
        new.price = new.price + new.price * 0.2	;
        return NEW;
    END;
$$
LANGUAGE 'plpgsql';

create trigger nalogRow_trigger
    before insert
    on products
    for each row
    execute procedure nalogRow();


insert into products (name, producer, count, price) VALUES ('product_5', 'pr_test6', 2, 1000);


--3) Создайте таблицу:
--	  Нужно написать триггер на row уровне, который сразу после вставки
--	  продукта в таблицу products, будет заносить имя, цену и текущую дату
--	  в таблицу history_of_price.


create table history_of_price
(
    id    serial primary key,
    name  varchar(50),
    price integer,
    date  timestamp
);

create or replace function insertRow()
    returns trigger as
$$
    BEGIN
        insert into history_of_price (name, price, date)
		values (new.name, new.price, current_timestamp);
        return NEW;
    END;
$$
LANGUAGE 'plpgsql';

create trigger insertRow_trigger
    after insert
    on products
    for each row
    execute procedure insertRow();

