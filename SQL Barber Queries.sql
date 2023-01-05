--NAVIGATE TO MASTER BEFORE USING DATABASE


--Need: 
/*
•	A WHERE clause DONE
•	A multi-table join DONE
•	A join with a set operator DONE
•	A subquery DONE
•	An outer join DONE
•	A group by statement. DONE
•	A having statement. DONE

Group:	 1
Section: ITCS-1170-C160
Class:	 DB Design & Implmnt w SQL
Project Contrubutors:
		 Wayne Williams (Project Lead) -- Queries & App
		 Noah Meduvsky				  -- Create & Insert
		 Hailey Fehn					  -- Create & Insert
		 Andrew Majewski				  -- Queries
*/
-----------------------------------------------------------------------------------------------------
--QUERY: #1	(Wayne)																					|
--Query to get total profits from products sold over the past 6 months, including how many products |
--Includes: Multi-Table Join + Where clause + Group by clause + having clause                       |
--Columns: ProductName, Total Sold (aggregate function-other columns go in group by), Quantity      |
--Tables: Product->Order_Product->CustomerOrder														|
--Condition: Where orderDate between '2022-01-01' and '2022-06-01'									|
--Order: Highest price shows first																	|
-----------------------------------------------------------------------------------------------------
use barbershop;
go
select productName as [Product Name]									
	, sum(price * quantity) as [Total Sold]
	, Quantity
from product p join order_products op
	on p.ProductID = op.ProductID
	join customerorder co
	on co.OrderID = op.OrderID
where orderDate between '2022-01-01' and '2022-06-01'
group by ProductName, Quantity
having sum(price * quantity) > 15
order by [Total Sold] desc;

-------------------------------------------------------------------------------
--QUERY: #2																	  |
--Set operator																  |
--Includes: Multi-Table Join with set operator								  |
--Query: Get employees who sold shampoo and cut hair						  |
--Columns: firstName, lastName, productName, Description (alias column name)  |
--Tables: Person->CustomerOrder->order_products->Product					  |
--Set Operator: Union (Addition)											  |
--Ordered by: Description													  |
-------------------------------------------------------------------------------

select op.OrderID
	, ltrim(rtrim(p.firstName + p.LastName)) as [Customer Name]
	, (op.Quantity * op.Price) as [Products/Service Total]
	, ProductName as [Product/Service Name]
	, op.Quantity
	, ltrim(rtrim((pp.firstName + ' ' + pp.lastName))) as [Employee Name]
	, 'Product' as [Type]
from Person p join customerorder co
	on p.peopleid = co.CustomerID
	join order_products op
	on co.OrderID = op.OrderID
	join product pr
	on pr.ProductID = op.ProductID
	join Person pp
	on pp.PeopleID = co.EmployeeID
union all
select os.OrderID
	, ltrim(rtrim((p.firstName + ' ' + p.lastName)))
	, (os.Quantity * os.Price)
	, ServiceName
	, os.Quantity
	, ltrim(rtrim((pp.firstName + ' ' + pp.lastName)))
	, 'Service'
from Person p join customerorder co
	on p.peopleid = co.CustomerID
	join order_services os
	on co.OrderID = os.OrderID
	join service s
	on s.ServiceID = os.ServiceID
	join Person pp
	on pp.PeopleID = co.EmployeeID



select firstName as [First Name]
	, lastName as [Last Name]
	, ProductName as [Product/Service Name]
	, 'Sold Shampoo' as [Description]
from person p join customerorder co
	on p.PeopleID = co.EmployeeID
	join order_products op
	on co.OrderID = op.OrderID
	join product pr
	on pr.productid = op.ProductID
union
select firstName 
	, lastName
	, ServiceName
	, 'Performed a Service'
from person p join customerorder co
	on p.PeopleID = co.EmployeeID
	join order_services os
	on co.OrderID = os.OrderID
	join service s
	on s.ServiceID = os.ServiceID
order by [Description];

-------------------------------------------------------------------------------------
--QUERY: #3																			|
--Get employees who sold products, and limit result set to show only orders			|
--where customers paid with credit/debit cards										|
--This query won't convert to C# because "Except" is a reserved keyword				|
--Includes: Multi-Table Join with set operator + Where clause						|
--Columns: First Name, Last Name, Product/Service Name, Payment, Price, Order Date	|
--Tables: Person->CustomerOrder->order_products->product							|
--Set Operator: Except (Subtraction)												|
-------------------------------------------------------------------------------------

select firstName as [First Name]
	, lastName as [Last Name]
	, ProductName as [Product/Service Name]
	, Payment
	, price as [Price]
	, OrderDate as [Order Date]
from person p join customerorder co
	on p.PeopleID = co.EmployeeID
	join order_products op
	on co.OrderID = op.OrderID
	join product pr
	on pr.productid = op.ProductID
Except
select firstName 
	, lastName
	, productName
	, Payment
	, Price
	, OrderDate
from person p join customerorder co
	on p.PeopleID = co.EmployeeID
	join order_products op
	on co.OrderID = op.OrderID
	join product pr
	on pr.productid = op.ProductID
where Payment = 'Check' or Payment = 'Cash'
order by [Product/Service Name];

-------------------------------------------------------------------------------------
--QUERY: #4																			|
--Outer join: Find customer orders for those who only purchased hair				|
--services and displays total for order, including order date						|
--Includes: Outer join																|
--Columns: First Name, Last Name, Payment, Total (Calculated Column), Order Date	|
--Tables: Person->CustomerOrder->Order_Services										|
--Outer Join: Right (Order_Services)												|
--Ordered by: Highest total															|
-------------------------------------------------------------------------------------

select firstName as [First Name]
	, lastName as [Last Name]
	, Payment
	, Price * Quantity as [Total]
	, OrderDate as [Order Date]
from person p join CustomerOrder co 
	on p.peopleid = co.CustomerID
	right join order_services os
	on co.OrderID = os.OrderID
order by [Total] desc
;

-----------------------------------------------------------------------------
--QUERY: #5																	|
--Show employees who sold only 1 service on multiple days,					|
--provide total price of services sold by each employee						|
--Query to determine who is performing the poorest, since every				|
--employee has sold something, the query is designed in this way			|
--Includes: Outer join + where clause + group by clause						|
--Columns: First Name, Last Name, Total Sold (Aggregate function column)	|
--other columns included in group by										|
--Tables: Person->order_services											|
--Condition: Where Quantity = 1 && PeopleType = 'Employee'					|
--Outer Join: Left (Person)													|
-----------------------------------------------------------------------------

select distinct firstName as [First Name]
	, lastName as [Last Name]
	, sum(price) as [Total Sold]
from Person p left join order_services os
	on p.peopleid = os.EmployeeID
where Quantity = 1 and PeopleType = 'Employee'
group by lastName, firstName;

-----------------------------------------------------------------------------
--QUERY: #6																	|
--Show employees who have only sold one product								|
--Includes: Outer join + where clause + group by clause						|
--Columns: First Name, Last Name, Total Sold (Aggregate Function)			|
--other columns included in group by										|
--Tables: Person->order_products											|
--Condition: where Quantity = 1 && PeopleType = 'Employee'					|
-----------------------------------------------------------------------------

select distinct firstName as [First Name]
	, lastName as [Last Name]
	, sum(price) as [Total Sold]
from Person p left join order_products op
	on p.peopleid = op.EmployeeID
where Quantity = 1 and PeopleType = 'Employee'
group by lastName, firstName;

---------------------------------------------------------------------
--QUERY: #7															|
--Subquery: Find vendors in Macomb and Clinton Township				|
--Includes: Where clause + Subquery									|
--Columns: FirstName, lastName, phone, city							|
--Tables: Person													|
--Condition: where city = 'Macomb' && peopletype = 'Vendor' OR		|
--city = 'Clinton Twp.' && peopletype = 'Vendor'					|
--Subquery condition: Where PeopleID in subquery					|
--Subquery--> Column: VendorID - Table: Product						|
---------------------------------------------------------------------
use barbershop;
go
select FirstName
	, lastName
	, phone
	, city
from Person
where PeopleID in
	(select vendorID
	 from Product
	 where city in ('Clinton Twp.', 'Macomb') and peopleType = 'Vendor');

-------------------------------------------------------------------------------------------------
--QUERY: #8																						|
--Subquery: Compare possible profits to be made when purchasing wholesale from nearby			|
--vendors to save money on transportation of goods. Nearby cities are Macomb and Clinton Twp.	|
--Includes: Where clause + Subquery																|
--Columns: First Name, Last Name, Phone, City, Wholesale Price (Cast), Retail Price (Cast),		|
--Possible Profit (Cast) (Calculated Column)													|
--Tables: Person->Product																		|
--Condition: where city = 'Clinton Twp.' and PeopleType = 'Vendor' OR							|
--City = 'Macomb' and PeopleType = 'Vendor'														|
--Subquery condition: Where PeopleID in subquery												|
--Subquery--> Column: VendorID - Table: Product													|
-------------------------------------------------------------------------------------------------

select FirstName as [First Name]
	, lastName as [Last Name]
	, phone as [Phone]
	, city as [City]
	, ltrim('$' + cast(WholeSaleprice as char(10))) as [Wholesale Price]
	, ltrim('$' + cast(RetailPrice as char(10))) as [Retail Price]
	, ltrim('$' + cast((RetailPrice - WholeSaleprice) as char(10))) as [Possible Profit]
from Person p join product pr
	on p.PeopleID = pr.VendorID
where city = 'Clinton Twp.' and PeopleType = 'Vendor' or City = 'Macomb' and PeopleType = 'Vendor' and PeopleID in
	(select vendorID
	 from Product
	 );

-------------------------------------------------------------------------------------------------
--QUERY: #9																					|
--Subquery: Shows all vendors with wholesale price, retail price, and possible profits.			|
--Includes firstName, lastName, phone, and city of each vendor									|
--Includes: Where clause + Subquery																|
--Columns: First Name, Last Name, Phone, City, Wholesale Price (Cast), Retail Price (Cast),		|
--Possible Profit (Cast) (Calculated Column)													|
--Tables: Person->Product																		|
--Condition: where (RetailPrice - WholeSaleprice) >= 3.00 and PeopleType = 'Vendor'				|
--Subquery-> Column:  VendorID - Table: Product													|
--Ordered By: Highest Possible Profit															|
-------------------------------------------------------------------------------------------------

select FirstName as [First Name]
	, lastName as [Last Name]
	, phone as [Phone]
	, city as [City]
	, ltrim('$' + cast(WholeSaleprice as char(10))) as [Wholesale Price]
	, ltrim('$' + cast(RetailPrice as char(10))) as [Retail Price]
	, ltrim('$' + cast((RetailPrice - WholeSaleprice) as char(10))) as [Possible Profit]
from Person p join product pr
	on p.PeopleID = pr.VendorID
where (RetailPrice - WholeSaleprice) >= 3.00 and PeopleType = 'Vendor' and PeopleID in
	(select vendorID
	 from Product
	 )
order by [Possible Profit] desc;
