
--Create subquery
select orderkey
	, OrderDetailPriceCharged
	, OrderDetailQuantity
	, orderDetailPriceCharged * OrderDetailQuantity
from OrderDetail
where productkey in     --Use = for returning one column, use 'in' when returning multiple columns
	(select productkey
	 from product
	 where productname like '%Large%');

--Example 2: Get customer name for those who ordered Basic M (Bottom up design) Look at ERD
--Bottom Inner query gets orderkeys for those orders that are for Basic M
--Next layer gives customer phone keys
select customerLastName
from customer
where customerPhoneKey in
	(select customerPhoneKey
	from CustomerOrder
	where OrderDate between '2013-01-01' and '2013-12-31'
		and orderkey in
		(select orderkey
		from OrderDetail
		where productkey = 'basicM'));

--Example 3:
--Aggregate functions
--*applied to groups of data
--*min, max, sum, count, average
--What products are selling higher than the highest priced item
select orderkey
	, productkey
	, OrderDetailPriceCharged
from OrderDetail
where OrderDetailPriceCharged >=
	(select max(productunitprice)
	from Product);

--Above is dynamic data, dynamic data is wanted more often where there are a lot of changes

--Don't do this: Static data
select max(productunitprice)
from product;

select orderkey
from OrderDetail
where OrderDetailPriceCharged >= 16.99;

select distinct (orderkey) --suppress duplicates
		, productkey
from OrderDetail
where ProductKey not in --looks for orders with productname not like pizza
	(select productkey
	 from product
	 where productname like '%pizza%');

--Any and All
--All
--Less than or greater than all of the values
--translates as grabbing the highest priced item
select orderkey
	, ProductKey
	, OrderDetailPriceCharged
from OrderDetail
where OrderDetailPriceCharged >= all
	(select max(productunitprice)
	 from product);

--Reversing the sign
select orderkey
	, ProductKey
	, OrderDetailPriceCharged
from OrderDetail
where OrderDetailPriceCharged <= all
	(select max(productunitprice)
	 from product);
	 --Gets nothing, nothing less than the minimum priced item

--Any
--Another way to look at table
select orderkey
	, ProductKey
	, OrderDetailPriceCharged
from OrderDetail
where OrderDetailPriceCharged > any
	(select productunitprice
	 from product);

--Any Reversing sign
select orderkey
	, ProductKey
	, OrderDetailPriceCharged
from OrderDetail
where OrderDetailPriceCharged < any
	(select productunitprice
	 from product);

--Another way to write this
select orderkey
	, productkey
	, orderdetailpricecharged
from OrderDetail
where OrderDetailPriceCharged <
	(select max(productunitprice)
	 from Product);