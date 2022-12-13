--Creating own table for experinting SQL queries;

DROP TABLE sales;
CREATE TABLE sales(id integer, Product varchar(20), Quantity integer, price integer);
insert into sales values(1, 'Shirt', 3, 1200);
insert into sales values(2, 'Jeans', 2, 3200);
insert into sales values(3, 'Shoe', 1, 1500);
insert into sales values(4, 'watch', 2, 1800);
insert into sales values(5, 'Caps', 3, 1000);

--using CASE
SELECT id, Product,
CASE 
	 WHEN Product ='Shirt' THEN 'Clothes'
	 WHEN Product ='Jeans' THEN 'Clothes'
	 WHEN Product ='Shoe' THEN 'Shoes'
	 WHEN Product ='watch' THEN 'accesories'
	 WHEN Product ='Caps' THEN 'Hat'
	 ELSE NULL
	 END AS Catagory
	 FROM sales;

	 --order by, group by, aggregriate function(SUM,AVG),Alias
select * from sales;
select * from sales order by Quantity, price;--if you select more than one row for order by , 
											  --then priority will go to first row then second row like this.
select Product,(price/Quantity) AS Base_Price from sales;
select Product,(price/Quantity) AS Base_Price from sales order by Base_Price;
select Product, SUM(price) AS TOTAL_SALES FROM sales group by Product;

select Product, SUM(price/Quantity) AS Base_Price, SUM(price) AS TOTAL_SALES 
from sales
group by Product order by Base_Price;

select Product, SUM(price/Quantity) AS Base_Price, SUM(Quantity) AS Quantity, SUM(price) AS TOTAL_SALES 
from sales
group by Product order by Quantity, Base_Price;




--DROP TABLE purchaser ; --if exists
CREATE TABLE purchaser(id integer, Name varchar(20), Address varchar(20));
insert into purchaser values(1, 'Ashfaq', 'Lahore');
insert into purchaser values(2, 'Mubin', 'Hyderabad');
insert into purchaser values(3, 'Jahir', 'Bengaluru');
insert into purchaser values(4, 'Saiful', 'Multan');
insert into purchaser values(5, 'Rahat', 'Dhaka');


ALTER TABLE purchaser ADD type varchar(20);
UPDATE purchaser SET type='Member' WHERE id =1;
UPDATE purchaser SET type='Member' WHERE id =2;
UPDATE purchaser SET type='Guest' WHERE id =3;
UPDATE purchaser SET type='Member' WHERE id =4;
UPDATE purchaser SET type='Guest' WHERE id =5;

select * from purchaser;
--DELETE FROM purchaser where type = 'member';
--DELETE FROM purchaser where type= 'member';

select COUNT(*) AS member_type, type from purchaser GROUP BY type;
select * from purchaser;
select * from sales;

--using JOINS
select * from sales JOIN purchaser ON sales.id = purchaser.id;
select * from sales INNER JOIN purchaser ON sales.id = purchaser.id;
select * from sales FULL OUTER JOIN purchaser ON sales.id = purchaser.id;


select sales.id,Name,Address, Product, Quantity, price, (price/Quantity) AS Base_Price,
type from sales JOIN purchaser ON sales.id = purchaser.id;

select * , (sales.price/sales.Quantity) AS Base_Price from sales FULL JOIN purchaser ON sales.id = purchaser.id; 
select * , (sales.price/sales.Quantity) AS Base_Price from sales JOIN purchaser ON sales.id = purchaser.id;