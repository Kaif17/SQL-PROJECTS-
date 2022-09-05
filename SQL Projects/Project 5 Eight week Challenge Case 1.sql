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
  

-- Q1 What is the total amount each customer spent at the restaurant? --

select customer_id, sum(price) as Spent from sales s join menu m 
on s.product_id = m.product_id 
group by customer_id 
having customer_id in ('A','B','C') ;
 
-- Q2 How many days has each customer visited the restaurant? 

select customer_id, count(distinct (order_date))as Visited 
from sales group by customer_id ;
  
-- Q3 What was the first item from the menu purchased by each customer?

select distinct customer_id, product_id, product_name 
from (select customer_id,m.product_id, product_name ,
dense_rank() over (partition by customer_id order by order_date) as pt
from sales s join menu m
on s.product_id = m.product_id ) as p
where p.pt = 1 ;

 -- Q4 What is the most purchased item on the menu and how many times was it purchased by all customers?
 select distinct product_name, purchased_by_customer from
(
select customer_id , m.product_name ,
count(*) over (partition by product_name) purchased_by_customer
from sales as s
join menu as m on
s.product_id = m.product_id 
) as t1
where t1.product_name = 'ramen' ;

-- Q5 Which item was the most popular for each customer?

select customer_id, product_name, total_count  from 
(
select s.customer_id, s.product_id, m.product_name,
count(product_name) as total_count
from sales s join menu m  on s.product_id = m.product_id
group by customer_id, product_id  
) as a
order by customer_id;


with t2 as 
(select customer_id, product_id, count(product_id) as item_count
from sales 
group by customer_id, product_id
order by customer_id,item_count desc),
t3 as
(select customer_id, product_id, item_count , dense_rank() over (partition by customer_id
order by item_count desc) as item_rank
from t2)
select t3.customer_id, product_name as popular_item, t3.item_count
from t3 inner join menu 
on t3.product_id = menu.product_id
where item_rank = 1
order by customer_id;

-- Q6 Which item was purchased first by the customer after they became a member?

 select distinct customer_id, product_name from
(select s.customer_id, order_date, product_name,join_date, 
dense_rank() over (partition by s.customer_id order by order_date)  
from sales s
 join menu m on s.product_id = m.product_id
 join members me on s.customer_id = me.customer_id 
) as a
where a.order_date >= a.join_date
and product_name != 'ramen' ;

-- Q7 Which item was purchased just before the customer became a member?

select distinct customer_id, product_name from
(select s.customer_id, order_date, product_name,join_date, 
dense_rank() over (partition by s.customer_id order by order_date)  
from sales s
 join menu m on s.product_id = m.product_id
 join members me on s.customer_id = me.customer_id 
) as a
where a.order_date <= a.join_date;

-- Q8 What is the total items and amount spent for each member before they became a member?
select customer_id , items , spent from (
select s.customer_id, s.product_id, order_date, join_date,product_name, price ,count(product_name) as items ,sum(price) as spent
from sales s 
join members m on  m.customer_id = s.customer_id  
join menu mn on mn.product_id = s.product_id 
where s.order_date < m.join_date 
group by s.customer_id
order by customer_id ) as a;
 
-- Q9 for each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
select customer_id, product_name, sum(Points) Total_points from
(
select customer_id, product_name, price,
case when product_name in ('curry' , 'ramen') then price*10 else price*20 end as Points
 from sales s join menu m on 
s.product_id = m.product_id) as a
group by a.customer_id order by a.customer_id;



-- Q10 In the first week after a customer joins the program (including their join date) they earn 2x points on all items,
-- not just sushi - how many points do customer A and B have at the end of January?
 
select distinct customer_id, sum(total_points) from
(
select s.customer_id, product_name, price, order_date, join_date, datediff(order_date, join_date),
case 
when product_name = 'sushi' then price*20
when datediff(order_date, join_date) <= 6 and datediff(order_date, join_date) >=0 then price*20
when datediff(order_date,join_date) >= 7 and product_name in ('curry','ramen') then price*10
    when datediff(order_date,join_date) < 0 then price*10
	else price*10
end as total_points
from sales s 
inner join members m 
on s.customer_id = m.customer_id
inner join menu me on me.product_id = s.product_id
order by customer_id ) as a
where a.order_date < '2021-02-01'
group by customer_id;


