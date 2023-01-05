--use Dog_Owner;
--go
select DogName
	, d.OwnerID
	, firstName
	, lastName
	, o.ownerID
from dog d full outer join owner o
	on d.OwnerID = o.OwnerID;
--Shows us where dogs don't and do have owners and where people don't and do have dogs.
--shows inequalities that exists in both sides

--Right or left outer join
--producing a query that shows all customers in the customer table 
--including those that do not have orders
--use pizza;

select c.CustomerPhoneKey --matters where we take this from, choose table where we want to see all of them
	, CustomerLastName
	, OrderDate
from customer c left join CustomerOrder co
	on c.CustomerPhoneKey = co.CustomerPhoneKey
where OrderDate is null;
--Gets everything from Customer table left of CustomerOrder
--will get same results if you had:
--from CustomerOrder co right join customer c  

--Joins should never return more than 100 rows of data
--Cartesian product
select customer.CustomerPhoneKey
	, customerLastName
	, orderkey
	, orderdate
from Customer, CustomerOrder;

select *
from Customer;--produces 27 rows

select *
from CustomerOrder;--produces 27 rows
--27 * 27 = 729 rows

--self join demonstration
select customer.customerphonekey
   , customer.CustomerLastName
   , customer.referredby
   , referred.CustomerLastName
from Customer referred join customer --customer join customer with alias
     on customer.ReferredBy = referred.customerphonekey;

--customer referred is the copy

select *
from Customer;
go

create view EmployeeOrders
([First Name], [Last Name], orderkey, orderdate)
as
select EmployeeFirstName
       , EmployeeLastName
	   , orderkey
	   , orderdate
from employee e join customerorder o
     on e.EmployeeKey = o.EmployeeKey;

go

select [First Name]
	, [Last Name]
from EmployeeOrders

go

create view TotalCustomerOrders
(CustomerName, NumOrders, TotalSpent)
as
select ltrim(rtrim(CustomerLastName))
	, cast(count(*) as varchar(5))
	, '$' + cast (sum(OrderDetailPriceCharged * OrderDetailQuantity) as varchar(10)) -- If you use order by, it orders it by ASCII values
from customer c join CustomerOrder o
	on c.CustomerPhoneKey = o.CustomerPhoneKey
	join OrderDetail od 
	on o.OrderKey = od.OrderKey
group by CustomerLastName;

go

--Test view
select * 
from TotalCustomerOrders;


go

create view TotalCustomerOrders2
(CustomerName, NumOrders, TotalSpent)
as
select ltrim(rtrim(CustomerLastName))
	, count(*) 
	, sum(OrderDetailPriceCharged * OrderDetailQuantity) -- If you use order by, it orders it by ASCII values
from customer c join CustomerOrder o
	on c.CustomerPhoneKey = o.CustomerPhoneKey
	join OrderDetail od 
	on o.OrderKey = od.OrderKey
group by CustomerLastName;

go
select * 
from TotalCustomerOrders2;
--can find views under database folders

--To delete view
--Check dependency report before deleting view
drop view TotalCustomerOrders;