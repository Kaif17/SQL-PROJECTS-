use ec;
create table t1 (s1 int);
create table t2 (s1 int);
insert into t1 values (1);
insert into t1 values (1);

/*LEFT JOIN*/
select * from t1 left join t2 on (t1.s1= t2.s1);

select  * from t1;

select * from t1 LEFT JOIN t2 on (t1.s1 = t2.s1)
UNION
select * from t1  RIGHT JOIN t2 on (t1.s1=t2.s1);

drop table t1,t2;

create table loan(loanid integer, branch varchar(255), Amt integer);
insert into loan values (1, "B1", 1000);
insert into loan values (2, "B2", 2000);
insert into loan values (3, "B3", 1500);

create table borrower(Custname varchar(90), loanid integer primary key);
insert into borrower values ( "C1", 1);
insert into borrower values ( "C2", 2);
insert into borrower values ( "C3", 3);

update borrower set loanid = 4 where custname = "C3";

select * from loan;
select * from borrower;



/* LEFT OUTER JOIN*/

select * from loan 
LEFT OUTER JOIN borrower
ON  loan.loanid = borrower.loanid ;

/* we can use additional where caluse also to filter our data*/
select * from loan 
LEFT OUTER JOIN borrower
ON  loan.loanid = borrower.loanid 
where amt > 1500;

/* RIGHT OUTER JOIN */
select * from loan RIGHT OUTER JOIN borrower 
ON  
loan.loanid= borrower.loanid ;


/* FULL OUTER JOIN */
select * from loan FULL OUTER JOIN borrower 
ON  
loan.loanid= borrower.loanid;

USE PROJECT2;
select * from supermart ;

use ec;
desc employee;
desc details;
desc department;


select e_name, d_name, man, salary from employee E INNER JOIN details D ON E.eid = D.did
INNER JOIN department Dp ON Dp.d_id = D.did;

insert into employee values (1, "hary" ),(2, "karan"), (3, "pete");
insert into department values (1, "Engg", 2),(2, "pharma", 5), (3, "diploma", 10);

select * from employee;
select * from department;

insert into details (salary) values (20000);

truncate details;

drop table details;

create table details (eid integer, did integer, salary integer, 
foreign key (eid) REFERENCES employee(eid),
foreign key (did) references department (d_id)
ON DELETE CASCADE 
ON UPDATE CASCADE );


insert into details  values (1, 1, 20000);
insert into details  values (2, 2, 20000);
insert into details  values (3, 3, 20000);

SELECT * FROM DETAILS;

SELECT e_name, d_name, man , salary from employee e 
inner join details d on e.eid = d.eid
inner join department dp on dp.d_id = d.did;

SELECT e_name, d_name, man , salary from employee e 
left join details d on e.eid = d.eid
left join department dp on dp.d_id = d.did;

SELECT e_name, d_name, man , salary from employee e 
right join details d on e.eid = d.eid
right join department dp on dp.d_id = d.did;

SELECT e_name, d_name, man , salary from employee e 
left join details d on e.eid = d.eid
right join department dp on dp.d_id = d.did;

insert into employee values ( 4, null);
insert into department values (4, null, null );
insert into details values (4,4, null);

create database practice;
use practice;
create table duplicate (did integer, dname varchar(90), dplace varchar(90) );
insert into duplicate values (1, "dup1", "mumbai"),
(2, "dup2", "delhi"),(2, "dup2", "delhi"),
(3, "dup2", "delhi"),(3, "dup2", "pune"),
(3, "dup2", "delhi");
select * from duplicate;
use ec;
/* How to get duplicate values */ 
select did, dname, dplace, count(*) 
from duplicate 
group by did, dname, dplace 
having count(*) > 1;

use ec;    






