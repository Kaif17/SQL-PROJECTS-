-- Assume a table called mp2 having different columns emi_id, first_name and so on. --
-- I would like to add extra column as Hike_Salary and update it as per condition given below --
/* Problem Statement (DDl = DML) */
-- If salary is greater than 20000 then increase salary by 10% --
-- If salary is in between 10000 and 20000 than increase salary by 20% --
-- Tf salary is less than 10000 than increase salary by 30% --
use ec;

select * from mp2;

select *, 
case 
when (salary > 20000) then  (salary + salary*0.1) 
 when (salary between 10000 and 20000 ) then (salary + salary*0.2)
 when (salary < 10000) then (salary + salary*0.3)
 else salary end as Hike_salary
 from mp2;

select * from myemp limit 10;
desc myemp;
create table mp2 ( emp_id decimal(6,0), first_name varchar(20), salary decimal(8,2) );
insert into mp2 (select emp_id, first_name, salary from myemp limit 10);

commit;
select * from mp2 limit 5;
rollback;

alter table mp2 change column  