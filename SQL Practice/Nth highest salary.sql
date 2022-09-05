-- How to find the 2nd Highest salary from a Table -- 
-- How to find the nth Highest salary deom a Table -- 

use ec;
select distinct salary, emp_id from myemp order by salary desc;

# Method 1 to find 2nd Highest Salary.
select max(salary) from myemp where salary not in (select max(salary) from myemp);

# Method 2 to find nth Highest Salary 

# select emp_id, salary from myemp e1 where n-1 = (select count(distinct salary) from myemp e2 
--                                                    where e2.salary > e1.salary ) 
# suppose we want to see 6th highest salalry from myemp table 
-- > Simply have to replace n with 6
select emp_id, salary from myemp e1 where 6-1 = (select count(distinct salary) from myemp e2 
                                                  where e2.salary > e1.salary ) ;
                                                  
-- Get 2nd highest salary feom each department ---

select emp_id, first_name, salary, dep_id from
(select emp_id,first_name, salary, dep_id,
row_number() over (partition by dep_id order by salary desc ) as rn
 from myemp ) as r  where r.rn = 2;







