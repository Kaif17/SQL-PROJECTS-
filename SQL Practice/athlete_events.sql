create database project2;
use project2;
drop table supermart;
create table supermart
(Order_id  integer,
Customer_Name varchar(90),	
Category varchar(90),	
Sub_Category varchar(90),	
City varchar(90),
Order_Date varchar(90),
Region varchar(90),	
Sales integer,	
Discount float,	
Profit integer,	
State varchar(90));
select * from supermart ;

/*Q1 want city = ooty and yellore, perambalur and their sales? */
select city, sales from supermart where city in ("ooty", "vellore", "Perambalur") order by city;

/*Q2 find out all customer_name letter sart with H and their sales? */
select distinct Customer_name, sales from supermart where customer_name like "H%" ;

/*Q3 who the person whose sales is max and min?*/
select customer_name, max(sales) as Highest_sale, min(sales) as Minimum_sale from supermart;

/*Q4 who the person whose sales is max and person whose sale is min?*/

