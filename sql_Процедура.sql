--2. За основу возьмите таблицу, с которой мы работали в описании.
--В описании мы рассмотрели вариант вставки данных, изменения данных.
--Добавьте процедуру и функцию, которая будет удалять записи.
--Условия выбирайте сами – удаление по id, удалить если количество товара равно 0 и т.п.


create table products
(
    id       serial primary key,
    name     varchar(50),
    producer varchar(50),
    count    integer default 0,
    price    integer
);

-- удалить записи с нужным producer
delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test7', 8, 1000);	


select count (name) from products;
select * from products;
select f_delete_date ('pr_test6'); -- выведет 1 (pr_test7)
select * from products where producer like 'pr_test6';
  

create or replace
function f_delete_date (prod varchar)
returns integer
language 'plpgsql'
as $$
    declare 
	result integer;	  
    BEGIN	 
	  delete from products where producer like prod;	  
	  select into result count (name)
	  from products;	 
	  return result;
  END;
$$;

-- удалить записи с ценой больше нужной

delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

select * from products;

insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 500);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 600);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test7', 8, 700);


select  count (name) from products  where price <= 500;	

select f_delete_producer_date (100); -- выведет 2 (строки)
select f_delete_producer_date (600); -- выведет 1 (строку)

create or replace
function  f_delete_producer_date (i_price integer)
returns integer
language 'plpgsql'
as $$
    declare 
	result integer;	  
    BEGIN
	if i_price > 500 then
	  delete from products where price > 500;	  
	  select into result count (name)
	  from products
	  where price <= 500;	
	  end if;	  
	if i_price <= 500 then
	select into result count (name)
	  from products
	  where price > 500;	
	  end if;
	return result;  	  
  END;
$$;

--- создание процедуры

select * from products;

call delete_name_data('product_12');

delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test7', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_1', 'pr_test7', 8, 1000);	


create
or replace procedure delete_name_data(u_name varchar)
language 'plpgsql'
as $$
    BEGIN       
            delete from products       
            where name like u_name;        
    END;
$$;



select * from products;



delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 2000);	
insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test7', 7, 3000);	


call delete_tax_data(2, 200, 2); -- ничего не произойдет, условия не сработают
call delete_tax_data(7, 200, 2); -- удалится запись с count = 7
call delete_tax_data(7, 1200, 2); -- удалится запись с id = 2

create
or replace procedure delete_tax_data(u_count integer, tax float, u_id integer)
language 'plpgsql'
as $$
    BEGIN
        if u_count > 5 THEN
            delete from products       
            where count = u_count; 
        end if;
        if
            tax > 1000 THEN
            delete from products  
			where id = u_id;
        end if;
    END;
$$;


-- вызов функции в процедуре

delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

insert into products (name, producer, count, price) VALUES ('product_12', 'pr_test6', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_13', 'pr_test8', 8, 1000);	
insert into products (name, producer, count, price) VALUES ('product_124', 'pr_test7', 8, 1000);	

select * from products;
select f_return_id_producer_date ('pr_test6'); -- выведет 1 (pr_test6)
call delete_producer_data ('pr_test6'); -- удалит 1 (pr_test6)


create or replace
function f_return_id_producer_date (prod varchar)
returns integer
language 'plpgsql'
as $$
    declare 
	result integer;	  
    BEGIN	 
	  select into result id
	  from products where producer like prod;	  	 	 
	  return result;
  END;
$$;



create
or replace procedure delete_producer_data(u_name varchar)
language 'plpgsql'
as $$
    BEGIN    	  
	        delete from products 
			where id = (select f_return_id_producer_date (u_name));   
    END;
$$;