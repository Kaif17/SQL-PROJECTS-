use ss;
select * from superstore;
-- Q1 What is the total number of order ?
select count(order_id) as total_order from 
superstore;

--Q2 What is total order region wise --
select count(order_id) as total_order_region_wise,
region from superstore group by region ;

-- Q3 Name of the region who has maximum number of order?
select region, max(total_order_region_wise) as max from
(
select (count(order_id)) as total_order_region_wise,
region from superstore group by region) as temp
group by region order by max desc
offset 0 rows
fetch first 1 rows only ;

-- Q4 Get the total slaes an total pefit by region 
select region, round(sum(sales),2)as tot_sal_region_wise,
round( sum(profit),2)as tot_prof_region_wise from superstore group by region ;

-- Q5 Which region has maximum sales ?
select region, round(sum(sales),2) as max_sales 
from superstore group by region order by max_sales desc 
offset 0 rows
fetch first 1 rows only;

-- Q6 find out the 3rd highest sales from the table?
select region ,round( sales,0) from superstore 
order by sales desc 
offset 2 rows 
fetch first 1 row only;

-- Q7 Get Total quantity region wise?
select region, sum(quantity) from superstore 
group by region;

-- Q8 Get the name of that state which has max number of quantity of products?
select state, count(quantity) as total_quantity
from superstore group by state order by total_quantity desc
offset 0 rows 
fetch first 1 row only;

-- Q9 How many registered customers during the year 2016 - 2018?
select count(*) as registered_customer from
(
select year(order_date) as year, order_id from superstore) as temp
where temp.year between 2016 and 2018;

--Q10 Calculate frequency of each order_id by each customer_name in descending order?
select distinct order_id, customer_name, count(order_id) as total_order from superstore
group by order_id,customer_name order by total_order desc;

-- Q11 Display total customers in each region in descending order?
select count(distinct customer_name) as total_customer, region from superstore
group by region order by region desc;

-- Q12 Calculate Total sales of each customer ?
select Customer_Name ,round(sum(sales),0) as Total_sales from superstore
group by customer_name ;

-- Q13 Display Number of customer in each region in descing order?
select count(distinct customer_name) as Total_customer, region from superstore
group by region order by Total_customer desc;

-- Q14 Find sum of Total sales of superstore?
select round(sum(sales),0) as total_sales from superstore;
select * from superstore;

-- Q15 Find out the total quantity of each customer?

select customer_name, sum(quantity) as Total_quantity
from superstore group by customer_name;

-- Q16 Find the region having maximum number of distinct customer?
select count(distinct customer_name) as Total_customer, region from superstore
group by region order by region
offset 0 rows
fetch first 1 row only;

-- Q17 Display for record for customers who live
-- in california and postal code 90032
select * from superstore 
where state = 'California' and postal_code = 90032;

-- Q17 Display all the records where the difference of days between
-- order_date and ship_date should greater than 5 ?

select * from superstore
where datediff(day,order_date, ship_date) >5;

-- Q18 create a table name new_table and 
-- Enter the top 10 customer who done max sales using select statement?

select distinct customer_name,round(sales, 0) as sales 
into new_table
from superstore order by sales desc
offset 0 rows
fetch first 10 rows only;
select * from new_table;

-- Q19 Find out the each year sales from each region wise?
select year(Order_Date) as years, region, round(sum(Sales),0)
as total_sales
from superstore
group by year(order_date), region order by total_sales desc;

-- Q20 Which category is most selled in each state order by year? 
select * from superstore;
select distinct state, count(category)as Total_count  from superstore
group by state; 



-- Q21 Which category is most selled in each state 
-- and get the details of every year?

select * from superstore;

select 
		count(category) as total_sold,
		category,
		state,
		year(order_date) as year,
		row_number () over (partition by state order by count(category) desc )rn
		from superstore
group by 
		category, 
		state,
		count(category);

-- Q22 How are the sales and profit throughout the years
select round(sum(Sales),0) as Total_sales, round(sum(profit),0) as total_profit,
year(order_date) as year
from superstore
group by year(order_date) order by total_sales desc,year(order_date);



-- Q23 Get the total monthly sales in year 2019 ?


select round(sum(sales),0) as total_sales, month(order_date), year(order_date) 
from superstore
group by month(order_date)
having year(order_date) = 2019;







