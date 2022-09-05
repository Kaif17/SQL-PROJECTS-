use practice;
insert into dup values (2, "pete", "Delhi", 15001);
select * from dup ;
--  From the dup table, fetched the users who logged in consecuently more than 3 times ?
select *,
    case when name = lead (name) over(order by id)
    and name = lead(name, 2) over (order by id)
    then name
    else null
    end as repeated_users
    from dup ;

select * from
(select *,
    case when name = lead (name) over(order by id)
    and name = lead(name, 2) over (order by id)
    then name
    else null
    end as repeated_users
    from dup) as fn where
    fn.repeated_users is not null;
    
    select id, name, place, 
    case when name = lead(name) over(order by id)
    and name = lead(name,2) over (order by id)
    then name 
    else null end as ru from dup;
