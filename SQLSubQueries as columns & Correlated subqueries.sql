--Correlated subqueries
use pizza;
select productkey
	, avg(orderdetailpricecharged)
from OrderDetail
group by productkey;

select orderkey	
	, orderdetailpricecharged
	, productkey
from orderdetail outside
where OrderDetailPriceCharged >=
	(select avg(orderdetailpricecharged)
	 from orderdetail inside
	 where outside.productkey = inside.productkey);


--Subqueries as column expressions
--The Wrong way:
select avg(orderdetailpricecharged)
from OrderDetail;

select orderkey
	, orderDetailPriceCharged
	, '11.13'
	, orderdetailpricecharged - 11.13
from OrderDetail

--The reason this is wrong is because it is not dynamic

--Create query that will show the order key, the price charged for an item, the
--average price of any item and the difference between the price and the 
--average
select orderkey
	, orderdetailpricecharged as [Price Charged]
	, (select avg(orderdetailpricecharged) from OrderDetail) as [Average Price]
	, OrderDetailPriceCharged - (select avg(orderdetailpricecharged) from OrderDetail) as [Difference]
from OrderDetail
where OrderDetailPriceCharged - (select avg(orderdetailpricecharged) from OrderDetail) < 0;
