-- Find the employees who salary is greater than average salary of all unique employees --
-- Use Common Table Expression (CTE) as well --
-- Using myemp Table --
use ec;
-- Step 1  find the total salary of all each employee
select emp_id, sum(salary) as total_sal_per_emp
from myemp m 
group by m.emp_id;


-- Step 2 find avg salary with respect to all total salary --
select avg(salary) as avg_tot_sal from myemp ;
 
 
 -- Step 3 find the total salary of all employee whose total salary is greater than avg salary of emp_id
 -- using sub query --

select * 
from (select emp_id, sum(salary) as total_sal_per_emp
from myemp m 
group by m.emp_id ) as tol_sal
join (select avg(salary) as avg_sal_per_emp from myemp) as avg_tot_sal
ON tol_sal.total_sal_per_emp > avg_tot_sal.avg_sal_per_emp ;


-- with cte ---
with total_sal (emp_id, total_salary)
  as (select emp_id, sum(salary) as total_salary
from myemp 
group by emp_id),
avg_total_sal(avg_sal_per_emp)
as (select avg(total_salary) as avg_sal_per_emp from total_sal)

select * from total_sal ts 
join avg_total_sal as ats 
on 
ts.total_salary > ats.avg_sal_per_emp;

select emp_id, sum(salary) as tot_sal from myemp  group by emp_id ;
select avg(salary) as avg_tot_sal from myemp limit 10;

with ts (emp_id,tot_sal)
as (select emp_id, sum(salary) as tot_sal from myemp  group by emp_id ),
avg_ts(avg_tot_sal) 
as (select avg(tot_sal) as avg_tot_sal from ts)

select * from ts inner join avg_ts 
on   ts.tot_sal > avg_ts.avg_tot_sal  ;

select 

