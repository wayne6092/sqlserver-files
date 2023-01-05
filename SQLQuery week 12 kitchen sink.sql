/*
How to put together a query with a multi-table join
1). Identify the columns for your output. Be careful with calculated fields. Find out what colums
	are involved in the calculation

2). Identify the tables. Study the primary key and foreign key relationaships. Map out how you plan
to join your tables

3). Test your join

4). Add your columns to the query

5). Add any WHERE clause conditions

6). Add the GROUP BY, if you need it

7). Add the HAVING, if you need it

8). Add your column headings, formatting and any sorting

Example: Create a query that will display the name of the customer along with the order key and orderdate. Sort your query
by the customer last name

jointing the tables using the WHERE clause
syntax:
SELECT column_name, ...
FROM table_name, table_name, ...
WHERE table_name.primarykey = table_name.foreignkey  -To restrict
	and other conditions as necessary 
Group BY column_name, column_name ...
HAVING some condition								 -To restrict
ORDER BY column_name, column_name ...

Test JOIN:
select *
*/
--Returns all customers who placed an order
use pizza;
select CustomerLastName
	, OrderKey
	, OrderDate
from customer, CustomerOrder
where customer.CustomerPhoneKey = CustomerOrder.CustomerPhoneKey --Without this, it is a cartesian product
order by customerLastName;
--We know its working when we have a low amount of records, no more than 62 rows for Pizza DB
--Based of relationship line, PK to FK, when joined, the result set should not be more than total # of rows in FK table

--Quick test
--select * 
--from Customer;

--select *
--from CustomerOrder;

/*
Joining tables in the FROM clause
syntax:
SELECT column_name, column_name ...
FROM table_name join table_name
	on table_name.primarykey = table_name.foreignkey
WHERE some_condition
GROUP BY column_name, column_name ...
HAVING some_condition
ORDER BY

Example: Create a query to show name of product, the product key, unit price, price the product sold for and the difference between the two. Sort output by name of product

select productName
	, productKey
	, productUnitPrice
	, orderDetailPriceCharged
	, productUnitPrice - orderDetailPriceCharged as [Difference]
*/
select productName
	, p.productKey
	, productUnitPrice
	, orderDetailPriceCharged
	, productUnitPrice - orderDetailPriceCharged as [Difference]
from Product p join OrderDetail od
	on p.ProductKey = OD.ProductKey
Order by ProductName;

--show name of customer, orderkey, quantity, price paid, total paid.
--Only show records for customers who paid more than $15 in line total.
--Name columns: Customer Name, Order Key, Price Charged, Quantity and Total
--Customer(c.CustomerPhoneKey)->CustomerOrder(co.CustomerPhoneKey)
--CustomerOrder(co.orderKey) -> OrderDetail(od.orderkey)

/*
Syntax for a 3 or more table join
SELECT column_name, column_name
FROM table_name join table_name
	on table_name.primarykey = table2_name.foreignkey
	join table_name
	on table2_name.primarykey = table3_name.foreignkey
WHERE some condition
GROUP BY column_name, column_name ...
HAVING some condition
ORDER BY column_name, column_name ...

select firstName
	, lastName
	, orderKey
	, orderDetailQuantity
	, orderDetailPriceCharged

*/
select CustomerLastName [Customer Name]
	, co.orderKey as [Order Key]
	, orderDetailQuantity as [Quantity]
	, orderDetailPriceCharged as [Price]
	, OrderDetailQuantity * OrderDetailPriceCharged as [Total Paid]
from customer c join customerorder co
	on c.CustomerPhoneKey = co.CustomerPhoneKey
	join OrderDetail od
	on co.OrderKey = od.OrderKey
where OrderDetailQuantity * OrderDetailPriceCharged > 15
order by orderdetailpricecharged asc;

/*
Example:
Create a query that will show the name of the customer along with the total they spent at the pizzeria. Name our columns, Customer Name and Total Spent. Sort our output to show the customer who spent the most.
*/
--Customer(c.customerphonekey) -> CustomerOrder(co.customerphonekey)
--CustomerOrder(co.orderkey) -> OrderDetail(od.orderkey)

select customerLastName
	, sum(orderDetailPriceCharged * orderDetailQuantity) as [Total]
	
from customer c join customerOrder co
	on c.CustomerPhoneKey = co.CustomerPhoneKey
	join OrderDetail od
	on co.OrderKey = od.OrderKey
group by customerLastName
order by [Total] desc;
--Look for words total/subtotal
--Examples of aggregate functions on a table
--select sum(orderdetailpricecharged) as [Total Prices]
--	, min(orderdetailpricecharged) as [Lowest Price]
--	, max(orderdetailpricecharged) as [Highest Price]
--	, count(orderdetailpricecharged) as [Number of Rows]
--	, avg(orderdetailpricecharged) as [Average Price]
--from OrderDetail;

/*
Create a query that will show the first and last name of the employee and the number of orders they took. Name your columns First Name, Last Name and Total Orders. Only include those employees who have a last name starting with L.
*/
--Employee(e.EmployeeKey) -> CustomerOrder(co.EmployeeKey)
select employeeFirstName
	, employeeLastName
	, count(orderKey)
from employee e join CustomerOrder co
	on e.employeekey = co.EmployeeKey
where EmployeeLastName like 'L%'
group by EmployeeLastName, EmployeeFirstName;
--Group by lastnames first because its more unique and faster/better

/*
Example:
Create a query that will show the name of the products sold along with the total that was sold for each product. Only include those products with the word pizza in it. Also restrict your result set to show those pizzas that totaled $20 or more. Sort output by the total sold with the highest amount first. Name your columns Product Name and Total Sold.
*/
--Product(p.ProductKey) -> OrderDetail(od.ProductKey)
select ProductName as [Product Name]
	, sum(orderdetailquantity * orderdetailpricecharged) as [Total Sold]
from product p join orderdetail od
	on p.productkey = od.ProductKey
where productname like '%Pizza%'
group by ProductName
having sum(orderdetailquantity * orderdetailpricecharged) >= 20
order by [Total Sold] desc;