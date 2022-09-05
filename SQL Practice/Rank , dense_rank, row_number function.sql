use ec;
desc myemp;
select * from myemp limit 10;
drop table temp;
create temporary table temp (emp_id decimal(6,0), first_name varchar(20), last_name varchar(25), salary decimal(8,2) , dep_id decimal(4,0));
insert into temp ( select emp_id, first_name, last_name , salary, dep_id from myemp limit 10 );
select * from temp;

-- for each dep_id execute where the rank is equal to 1
select * ,
rank () over(partition by(dep_id) order by salary desc)  as rnk ,
dense_rank () over(partition by(dep_id) order by salary desc)  as drnk ,
row_number () over(partition by(dep_id) order by salary desc)  as rn
from temp;

select * from
(select * ,
row_number () over(partition by(dep_id) order by salary desc)  as rn
from temp ) as a
where a.rn = 1;

-- fetch all the data of dep_id = 60 and rank it using rank, dense_rank, row number --
-- 1. Using row number --
select * from
(select * ,
row_number() over (partition by dep_id order by salary) as row_rk
from temp ) as trn where trn.dep_id = 60;

-- 2. using rank --
 select * from
( select *,
 rank() over (partition by dep_id order by salary desc) as rk
 from temp) as trnk where trnk.dep_id = 60;
 
 
-- 3. Using dense_rank --
select * from
(
select *,
dense_rank () over (partition by dep_id order by salary )as d_rnk
from temp ) as a where a.dep_id = 60;






