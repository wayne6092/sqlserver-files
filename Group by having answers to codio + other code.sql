--select FirstName
--	, LastName
--	, HireDate
--	, TermDate
--from People join Workers
--     on people.peopleid = workers.peopleid
     
--where year(HireDate) = '2016' and TermDate = null;
--select *
--from ITEM_TYPE join Item
--    on Item_Type.ItemTypeid = Item.ItemTypeid
--    where Name in ('Toy') and minPrice >= 10
--    order by maxPrice;

--select CONCAT(ltrim(rtrim(firstName)), ' ', 
--ltrim(rtrim(lastName))) as [Employee Name]
--    , orderID
--    , orderDate
--from people join orders
--  on people.peopleID = orders.employeeid
--  where orderDate >= '2016-12-00' and OrderDate <= '2016-12-30'
--  order by lastName;
--select firstName
--    , lastName
--    , price
--    , orderDate
--from people join orders
--  on people.peopleid = orders.customerid
--  join order_item
--  on orders.orderid = order_item.orderid
--  where year(orderDate) = '2017' and price >= 10
--  order by price, LastName;

--select firstName
--    , lastName
--    , Name  --Name of charity
--    , DonationDate
--    , value --Value of item donated
--from people p join charity c
--  on PeopleID = ContactID
--  join donation d
--  on c.CharityID = d.CharityID
--  join Item_Donation id 
--  on d.DonationID = id.DonationID
--  order by DonationDate; 

--select lastName as [Last Name]
--    , firstName as [First Name]
--    , orderDate as [Order Date]
--    , price as [Price]
--    , price * 0.2 as [Fee]
--from people join item i
--  on PeopleID = OwnerID
--  join order_item oi
--  on i.ItemID = oi.ItemID
--  join orders o
--  on o.OrderID = oi.OrderID
--  where year(orderDate) = '2020'
--  order by orderDate, price;

--select firstName as [First Name]
--    , lastname as [Last Name]
--    , sum(price) as [Total Spent]

--from people p join orders o
--  on p.peopleid = o.customerid
--  join Order_Item oi
--  on o.orderid = oi.orderid
--group by lastname, firstName
--order by lastname;

--select year(customerSince) as [Year]
--    , count(peopleid) as [Number Joined]
--from customer_Owner
--group by year(customerSince)
--order by [Number Joined] desc
--;

--select city
--    , count(peopleid)
--from people
--where city = 'Roseville' or city = 'Utica' or city = 'Warren'
--group by city
--order by city;

--select firstName as [First Name]
--    , lastName as [Last Name]
--    , sum(price * .20) as [Total Paid]
--from people p join item i
--  on p.peopleid = i.ownerid
--  join Order_Item oi
--  on i.itemid = oi.itemid
--group by lastName, firstName
--having sum(price * .20) >= 20
--order by [Total Paid] desc
--;

--select Name
--    , Size
--    , sum(price) as [Total Sold]
--from item_type it join item i
--  on it.itemtypeid = i.itemtypeid
--  join Order_Item oi
--  on i.itemid = oi.itemid
--  where name like '%Clothes%'
--  group by name, size
--  having sum(price) >= 15
--  order by name, size;

--select year(orderDate) as [Year Sold]
--    , Name 
--    , sum(price) as [Total Sold]
--from item_type it join item i
--  on it.itemtypeid = i.itemtypeid 
--  join Order_Item oi
--  on i.itemid = oi.itemid
--  join Orders o
--  on o.orderid = oi.orderid
--where name like '%furniture%'
--group by name, year(orderDate)
--having sum(price) >= 80
--order by year(orderDate);