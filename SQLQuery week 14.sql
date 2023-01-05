go
create view CustomerSales
([First Name], [Last Name], [Total Sales])
as
select firstName
    , lastName
    , sum(price)
from people p join orders o
	on p.peopleid = o.customerid
	join order_item oi
	on o.orderid = oi.orderid
group by lastName, firstName;

go
select * 
from CustomerSales;


select name
    , sum(price)
from Item_Type it join Item i 
    on it.itemtypeid = i.itemtypeid
    join order_item oi
    on i.itemid = oi.itemid
group by name;