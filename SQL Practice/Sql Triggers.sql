-- In sql there are 3 Types og Triggers
-- 1. DDL Triggers
-- 2. DML Triggers
-- 3. Logon triggers

use ss;
create table emp
(id int, Name varchar(20), salary int, Gender varchar(2), DepartmentId int );
insert into emp values 
(1, 'John', 5000, 'M', 3),
(2, 'Mike', 3400, 'M', 2),
(3, 'Pam', 6000, 'F', 1),
(4, 'Tod', 4800, 'M', 4),
(5, 'Sara', 3200, 'F', 1),
(6, 'Ben', 4000, 'M', 3);
select * from emp;

