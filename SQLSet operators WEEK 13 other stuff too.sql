select firstName as [First Name]
    , lastName as [Last Name]
    , Name as [Name]
    , Price as [Price]
from People p join Orders o
  on p.peopleid = o.employeeid
  join Order_Item oi
  on o.orderid = oi.orderid
  join Item i
  on i.itemid = oi.itemid
  join Item_Type it
  on it.itemtypeid = i.itemtypeid
where price <=
    (select max(MinPrice)
     from Item)
order by Name
;


select firstName as [First Name]
    , lastName as [Last Name]
    , Name as [Name]
    , Price as [Price]
from People p join Orders o
  on p.peopleid = o.employeeid
  join Order_Item oi
  on o.orderid = oi.orderid
  join Item i
  on i.itemid = oi.itemid
  join Item_Type it
  on it.itemtypeid = i.itemtypeid
where price <
    (select max(MinPrice)
     from Item)
 and Name like 'Toys%'
order by Name
;


select firstName as [First Name]
    , lastName as [Last Name]
    , Price
    ,(select avg(price) 
        from Order_Item) as [Average Price]
    ,(select avg(price)
        from Order_Item) - Price as [Difference]
from People p join Orders o
  on p.peopleid = o.customerid
  join Order_Item oi
  on o.OrderID = oi.OrderID
where city = 'Utica'
order by [Difference]
;

select lastName as [Last Name]
    , firstName as [First Name]
    , CustomerSince [Start Date]
    , 'Customer/Owner' as [People Type]
from people p join customer_owner co
  on p.peopleid = co.peopleid
where city = 'Sterling Heights'

UNION ALL

select lastName
    , firstName
    , HireDate
    , 'Employee'
from people p join workers w
  on p.peopleid = w.peopleid
where city = 'Sterling Heights'
order by [People Type]
;

select firstName
    , lastName
from people p join workers w
    on p.peopleid = w.peopleid

INTERSECT

select firstName
    , lastName
from people p join orders o
    on p.peopleid = o.customerid
order by lastName
;

select Name
    , Phone
from charity

EXCEPT

select Name
    , Phone
from charity c join donation d
    on c.charityid = d.charityid
order by Name
;