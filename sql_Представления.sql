CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	quantity INTEGER,
	price NUMERIC
);

INSERT INTO products (name, quantity, price)
VALUES
('шарик синий', 1000, 10.00),
('шарик красный', 990, 10.00),
('ручка шариковая', 1000, 50.00),
('ручка гелевая', 12, 50.00),
('блокнот', 500, 100.00),
('степлер', 49, 500.00),
('карандаш', 17, 15.00),
('фломастер', 300, 79.99),
('краски акриловые', 50, 399.00),
('краски гуашь', 64, 99.99),
('краски акварель', 123, 155.00),
('бумага А4', 10000, 200.00);


CREATE TABLE orderss (
	id SERIAL PRIMARY KEY,
	address TEXT NOT NULL,
	delivery_date DATE
);

INSERT INTO orderss (address, delivery_date)
VALUES
('адрес_1','2022.12.31'),
('адрес_2','2022.11.15'),
('адрес_3','2022.12.25'),
('адрес_1','2022.12.30'),
('адрес_4','2022.12.17'),
('адрес_5','2022.12.27'),
('адрес_1','2023.02.20'),
('адрес_4','2023.02.22'),
('адрес_2','2023.02.23'),
('адрес_3','2023.03.07'),
('адрес_5','2023.03.06'),
('адрес_5','2023.12.01');


CREATE TABLE orders_products (
	order_id INTEGER references orderss(id),
	product_id INTEGER references products(id),
	quantity INTEGER NOT NULL,
	PRIMARY KEY (order_id, product_id)
);



INSERT INTO orders_products (order_id, product_id, quantity)
VALUES
(1,1,10),
(1,2,10),
(1,5,5),
(3,5,10),
(3,3,10),
(4,8,5),
(5,5,12),
(5,7,555),
(6,11,1),
(7,3,200),
(8,4,12),
(9,3,100),
(9,5,100),
(9,10,11),
(9,2,100),
(10,9,50),
(11,11,8),
(12,6,3),
(12,7,1);


--Узнать сумму всех заказов, в декабре 2022. Сгруппировать по названию товара. Отобразить только те записи, в которых сумма не меньше 500

create view show_sum_orders_in_Dec_more_500
    as 
	SELECT p.name, SUM(p.price * op.quantity)
FROM orders_products op
	JOIN orderss o ON o.id = op.order_id
    JOIN products p ON p.id = op.product_id
WHERE o.delivery_date >= '2022.12.01' AND o.delivery_date <= '2022.12.31'
GROUP BY p.name
HAVING SUM(p.price * op.quantity) >= 500;

select * from show_sum_orders_in_Dec_more_500;

drop view show_sum_orders_in_Dec_more_500;

drop table orders_products;
drop table products;
drop table orderss;