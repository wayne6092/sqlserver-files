/*use pizza;
go
select customerlastname
from customer;
*/
--This is a wild card character *
/*select *
from customer;
*/
--Distinct -- this command finds us unique values
/*Create a query that will show all of the unique product id's for those items that were purchased*/
/*select distinct productkey
from orderDetail;
*/
/*, (), exponent, *, /, +, -
*/
/*Create a query that will show the Orderkey, Productkey, and line total for all products sold
*/
select OrderKey
	, ProductKey
	--, OrderDetailPriceCharged * OrderDetailQuantity as [Line Total]
	--, OrderDetailPriceCharged * OrderDetailQuantity [Line Total]
	--, OrderDetailPriceCharged * OrderDetailQuantity as "Line Total"
	--, OrderDetailPriceCharged * OrderDetailQuantity linetotal
from OrderDetail;

/*order by allows us to sort our output. We can one column or many. Specify ascending or descending. Ascending is default.
*/

--Sort by line total and show the highest priced item, orderBy clause is the only clause where you can use alias
select OrderKey as [Order Key]
	, ProductKey as [Product Key]
	, OrderDetailPriceCharged * OrderDetailQuantity as [Line Total]
from OrderDetail
order by [Line Total] desc;

--sort by product key in aplpha order
select OrderKey as [Order Key]
	, ProductKey as [Product Key]
	, OrderDetailPriceCharged * OrderDetailQuantity as [Line Total]
from OrderDetail
order by ProductKey, OrderKey;

--Create a query that will show the order key and the order date for all orders. Sort output to show most recent day first.
select OrderKey
	, OrderDate
from CustomerOrder
order by OrderDate desc;

/*Concatenation combining strings together.
Create a query that will show the first and last name of all employees put together so that it looks like one field
r trim, blank spaces to right, l trim is blank spaces to left
*/
select EmployeeFirstName
	, EmployeeLastName
from Employee

select trim(EmployeeFirstName + EmployeeLastName) AS [Employee Name]
from Employee;

select trim(EmployeeFirstName) + ' ' + trim(EmployeeLastName) AS [Employee Name]
from Employee;
