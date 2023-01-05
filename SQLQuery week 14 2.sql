--views
/*
create view table_name
(alternate column names)
as
Select column_name(s)
from table(s)
where(opt)
group by(opt)
having(opt)
;
go
*/
--must have unique name
--use order by clause when running the view, not when 
--creating view
/*
How to create and Run a view
1. Join your tables and test the join.
2. Add the columns your query needs to display.
3. Add any filters in the WHERE clause.
4. Add any groupings in the GROUP BY clause and add your aggregate functions to the SELECT statement.
5. Add any grouping filters to the HAVING clause.
6. Add your ORDER BY clause.
7. Add any formatting or column titles, if needed.

Avoid issues with views
--EmployeeSales View, we are listing the first and the last name of 
--each employee who completed a sale
--View further adds up all of the sales for each employee and shows the total
use auntieb;
go
create view EmployeeSales
([First Name], [Last Name], [Total Sales])
as
select firstname
     , lastname
     , sum(price)
from people p join orders o
     on p.peopleid = o.EmployeeID
     join ORDER_ITEM oi
     on o.OrderID = oi.OrderID
group by lastname, firstname;
go
select *
from EmployeeSales;
go

--This is missing column headings
use auntieb;
select ltrim(rtrim([First Name])) + ' ' + ltrim(rtrim([Last Name]))
     , '$' + cast([Total Sales] as char(10))
from EmployeeSales;

--The statements below add column headings
use auntieb;
select ltrim(rtrim([First Name])) + ' ' + ltrim(rtrim([Last Name])) as [Name]
     , '$' + cast([Total Sales] as char(10)) as [Sales]
from EmployeeSales;

--Filter: show sales over $150 ->Utilize [Total Sales] column
use auntieb;
select ltrim(rtrim([First Name])) + ' ' + ltrim(rtrim([Last Name])) as [Name]
     , '$' + cast([Total Sales] as char(10)) as [Total Sales]
from EmployeeSales
where [Total Sales] >= 150;

--Add sorting -> use columns from view
use auntieb;
select ltrim(rtrim([First Name])) + ' ' + ltrim(rtrim([Last Name])) as [Name]
     , '$' + cast([Total Sales] as char(10)) as [Total Sales]
from EmployeeSales
where [Total Sales] >= 150
order by [Total Sales] desc;

**************ALTERING A VIEW***************
/*
Make changes to the view object
1. run dependency report first 
2. ensure change doesn't negatively effect other objects that use view
alter view table_name
(alternate column names)
as
select column_name(s)
from table(s)
where
group by
having
;
go

change employeeSales view to include having that shows employees who have more than $50 
in sales.
*/
use auntieb;
go
alter view EmployeeSales
([First Name], [Last Name], [Total Sales])
as
select firstname
     , lastname
     , sum(price)
from people p join orders o
     on p.peopleid = o.EmployeeID
     join ORDER_ITEM oi
     on o.OrderID = oi.OrderID
group by lastname, firstname;
having sales >= 50
go
select *
from EmployeeSales;
go

*/
