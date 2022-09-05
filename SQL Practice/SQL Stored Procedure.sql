use ss;
select * from superstore;

alter procedure spemp
AS 
BEGIN
	select customer_name, round(sales,2)as sales from superstore;
END

execute spemp


exec spgetEmpNameandDept 'Claire Gute', 'Henderson'
alter proc spgetEmpNameandDept
 @Customer_name varchar(25),
 @city varchar(20)
 as 
 Begin
	select customer_name, city from superstore where customer_name = @Customer_name
	and city = @city
 End
	
	execute p1
	alter proc p1
	as 
	begin
		select category, round(sum(profit),2) as Total_profit from superstore 
		group by category order by category, Total_profit 
	end

	select * from superstore;


	ALTER procedure p2
	@city varchar(20),
	@state varchar(20)
	WITH ENCRYPTION
	as
	Begin
		select city , state, round(sum(sales),2) as total_sales
		from superstore group by city, state;
	End


	exec p2 @city = 'Los Angeles', @state = 'California' 
	

	drop proc spgetEmpNameandDept


p3
	alter proc p3
	with encryption
	as 
	begin
		select category, round(sum(sales),0) as Total_sales, round(sum(profit),0) as Total_profit, 
		round(sum(quantity),0) as Total_quantity from superstore
		group by category order by category
	end 


 sp_helptext p3


 exec sp1
 create procedure sp1
 as 
 begin
	select ship_mode, round(sum(sales),0) as total_sales from superstore
	group by ship_mode
 end