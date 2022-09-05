-- Query to find out the top 15 salary of employee without using there column name
select * from myemp  group by 1 order by 7 desc limit 15;


desc myemp;

call Show_top_10_slalry_of_emp();


use practice;
select * from new_table;
use ec;
create table emp as 
select emp_id, first_name , salary from myemp order by emp_id limit 10;
select * from emp;

create trigger salary_diff 
before insert or delete or update on emp 
for each row 
declare salary_diff number;


select * from passenger;
use practice;
create table passenger (
name varchar(90) , id int(10), address varchar(20), charges int(10), primary key (id) );

insert into passenger values ("Gaurav", 450, 'Bamglore', 5000);
insert into passenger values ("Manish", 550, 'pune', 6000);
insert into passenger values ("Gaurav", 650, 'Mumbai', 7000);
insert into passenger values ("Gaurav", 750, 'Hyderabad', 8000);


select * from passenger;


-- BEFORE INSERT TRIGGER --
create trigger flight 
before insert 
on passenger 
for each row 
set new.charges = new.charges - 2000;

insert into passenger values ('Mishra', 850, 'Jaipur', 8000);

select * from passenger;

-- AFTER INSERT TRIGGER --

create table college_student (
name varchar(10), 
id int(10), 
age int(10), primary key(id) );

select * from college_student;

create table college_audit (
id int(10),
audit_description varchar(1000),
primary key(id) );

select * from college_audit;

create trigger afterinsert
after insert on college_student
for each row 
insert into college_audit values ( 1, concat("A new row is inserted", date_format(now(),'%d %m %y %h:%i:%s %p')));


insert into college_student values ("akmal", 150, 26);
select * from college_student;
select * from college_audit;