-- How to delete the duplicate records from the table --
use practice;
select * from dup order by id;

select id,name,place, 
row_number() over(partition by name order by id) as part_name from dup
where part_name >1;

select id, name,place
from
(select id,name,place, 
row_number() over(partition by name order by id) as part_name,
row_number() over(partition by place order by id) as part_place
from dup order by id ) as d1
where d1.part_name > 1 ;

-- how to remove all the duplicate values from dup table ? --
select  distinct id,name , place from
(select id, name ,place, 
row_number() over(partition by name order by id) as part_name
from dup order by id ) as p1
where p1.part_name > 1 ;

--  From the dup table, fetched the users who logged in consecuently more than 3 times ?
select *,
    case when name = lead (name) over(order by id)
    and name = lead(name, 2) over (order by id)
    then name
    else null
    end as repeated_users
    from dup ;


