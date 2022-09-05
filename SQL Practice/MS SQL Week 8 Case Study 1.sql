create database week8;
use week8;


CREATE TABLE sales ( 
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  select * from sales;
  select * from menu;
  select * from members;
  
  select s.customer_id, s.product_id, order_date, join_date,product_name, price 
from sales s 
join members m on  m.customer_id = s.customer_id 
join menu mn on mn.product_id = s.product_id 
order by customer_id;

--Q1 What is the total amount each customer spent at the restaurant? --

select customer_id, sum(price) as Spent from sales s join menu m 
on s.product_id = m.product_id 
group by customer_id 
having customer_id in ('A','B','C') ;
 
--Q2 How many days has each customer visited the restaurant? 

select customer_id, count(distinct (order_date))as Visited 
from sales group by customer_id ;
  
--Q3 What was the first item from the menu purchased by each customer?

select customer_id, product_id, product_name 
from (select customer_id,m.product_id, product_name ,
row_number() over (partition by customer_id order by customer_id) as pt
from sales s join menu m
on s.product_id = m.product_id ) as p
where p.pt = 1;

-- Q4 What is the most purchased item on the menu and how many times was it purchased by all customers?


--Q5 Which item was the most popular for each customer?

 select distinct customer_id , product_name, purchased_by_customer from
(
select customer_id , m.product_name ,
count(*) over (partition by product_name) purchased_by_customer
from sales as s
join menu as m on
s.product_id = m.product_id 
) as t1
where t1.product_name = 'ramen';