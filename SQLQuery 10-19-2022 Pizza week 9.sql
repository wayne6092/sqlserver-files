--use football;
--go
--select personid
	--, fee
	--, fee * .2
--	, fee + (fee * .2)
--from playerrec;
/*
Create a query that will display the order key and order date for all orders that were taken by clanglais
*/
/*
use pizza;
go
select OrderKey
	, OrderDate
from CustomerOrder
where EmployeeKey = 'clanglais'
;
*/
/*
Demonstrating implicit conversion -- create a query that will show the orderky, product key and the quantity ordered for those orders where the quantity is greater than or equal to 5.
*/
/*
select OrderKey	
	, ProductKey
	, OrderDetailQuantity
from OrderDetail
where OrderDetailQuantity >= '5';--Don't do this

--Do this instead
select OrderKey	
	, ProductKey
	, OrderDetailQuantity
from OrderDetail
where OrderDetailQuantity >= 5;
*/

/*
*BETWEEN -- allows us to look for rows of data that fall within a range. It is inclusive. 
-- Create a query that will show the order key, customer phone key and order date for all orders taken in June 2013
*/
/*

select OrderKey
	, CustomerPhoneKey
	, OrderDate
from CustomerOrder
where OrderDate between '2013-06-01' and '2013-06-30'

;

select productkey
	, productname
from product
where ProductName between 's' and 'z'
;


select productkey
	, productname
from product
order by ProductName
;

select productkey
	, productname
from product
where ProductName between 'Small Greek Salad' and 'XL Square Pizza'
;
*/

/*
*LIKE -- allows us to llok for patterns with our strings. this uses and _. 
Create a query that will show us those orders for greek salads. Display orderkey and product key.
*/
/*
select OrderKey
	, ProductKey
from OrderDetail
where productkey like '%greek%'
;

select orderkey
	, productkey
from OrderDetail
where productkey like '%sm_ll%' --Not the best for big databases, and searching with text
;
*/
-- * IN -- allows us to look for rows that fall into a set. 
-- Create a query that will show us all orders for small salads. Display in your query the order key and product key. Sort ---your results by the product key.

/*
select OrderKey
	, ProductKey
from OrderDetail
where productkey in ('greekSmall', 'cesarSmall')--Few rows, shows salads only
order by productkey;

select OrderKey
	, ProductKey
from OrderDetail
where productkey not in ('greekSmall', 'cesarSmall')--Lots of rows, everything but salads
order by productkey;
*/

/*
AND OR NOT
Order of Operations
1. ()
2. NOT
3. AND
4. OR
5. EMDAS
CREATE a query that will show the order key, employee key and order date for all orders taken in July 2013. Sort your result set by the order date.
*/
/*
select OrderKey
	, EmployeeKey
	, OrderDate
from CustomerOrder
where OrderDate >= '2013-07-01' and OrderDate <= '2013-07-31'
;
*/
/*
OrderKey   EmployeeKey OrderDate
---------- ----------- ----------
1011       emotter     2013-07-07
1012       eroeder     2013-07-09
1013       lhowe       2013-07-11
1014       pnewson     2013-07-13
1015       beatmon     2013-07-16
*/
/*


select OrderKey
	, EmployeeKey
	, OrderDate
from CustomerOrder
;
*/
/*
OrderKey   EmployeeKey OrderDate
---------- ----------- ----------
1000       cmanning    2013-10-08
1001       cmanning    2013-10-08
1002       cmanning    2013-10-08
1003       skristoph   2013-10-08
1004       btaylor     2013-10-10
1005       btaylor     2013-10-10
1006       clanglais   2013-08-03
1007       jballa      2013-09-02
1008       esteere     2013-09-10
1009       ccooke      2013-09-15
1010       gvalla      2013-09-29
1011       emotter     2013-07-07
1012       eroeder     2013-07-09
1013       lhowe       2013-07-11
1014       pnewson     2013-07-13
1015       beatmon     2013-07-16
1016       clanglais   2013-06-07
1017       jballa      2013-06-13
1018       esteere     2013-06-20
1019       ccooke      2013-06-19
1020       gvalla      2013-06-16
1021       emotter     2013-04-10
1022       eroeder     2013-04-15
1023       lhowe       2013-03-01
1024       pnewson     2013-01-02
1025       beatmon     2013-02-20
1026       clanglais   2013-02-21
*/

/*
Create a query to show those orders taken by clanglais or ccooke.
Display in your query the order key, order date and employee key. Sort results by employee key.
*/
/*
select OrderKey
	, OrderDate
	, EmployeeKey
from CustomerOrder
where EmployeeKey = 'clanglais' or EmployeeKey = 'ccooke'
order by EmployeeKey;
*/
/*
OrderKey   OrderDate  EmployeeKey
---------- ---------- -----------
1009       2013-09-15 ccooke    
1019       2013-06-19 ccooke    
1026       2013-02-21 clanglais 
1016       2013-06-07 clanglais 
1006       2013-08-03 clanglais 
*/
/*
Looking for null values---
Must use IS NULL in the where clause.
Create a query that will display the customer phone key, customer last name and state for those records that do not have a state listed. Distinguishes empty string from null. NULL IF. IS NOT NULL -- looking for values there. IS NULL -- looking for empty
*/
/*
select CustomerPhoneKey
	, CustomerLastName
	, CustomerState
from Customer
where CustomerState is null;
*/
/*
CustomerPhoneKey CustomerLastName CustomerState
---------------- ---------------- -------------
0000000000       No Referral      NULL
2065552123       Lamont           NULL
2065552963       Lewis            NULL
2065553213       Anderson         NULL
2065556623       Jimenenz         NULL
*/
/*
select CustomerPhoneKey
	, CustomerLastName
	, CustomerState
from Customer
where CustomerState is not null;
*/
/*
CustomerPhoneKey CustomerLastName CustomerState
---------------- ---------------- -------------
2061034733       Nickens          WA
2061346344       Quinto           WA
2062538594       Kuhlmann         WA
2062552345       Morphis          WA
2062633733       Demuth           WA
2062687960       Booe             WA
2062938475       Spero            WA
2063211234       Myres            WA
2063281946       Brewton          WA
2063942736       Doepke           WA
2063948563       Balk             WA
2063948571       Mayhue           WA
2064339614       Shumpert         WA
2064748292       Telford          WA
2064854857       Verret           WA
2065552217       Wong             WA
2065553252       johnston         WA
2066437181       Mccullen         WA
2067071346       Reinoso          WA
2067569135       Das              WA
2068762341       Schaner          WA
2069092383       Furtado          WA
*/
/*
select productunitPrice, cast(productunitprice as smallint)
from product;
--how to use cast and concatenate

select orderkey
	, '$' + cast(OrderDetailPriceCharged as varchar(10)) as [Price]
	, cast(OrderDetailQuantity as varchar(5)) as [Quantity]
from OrderDetail
order by [Price] desc; -- Where you can put column headings
*/
/*
select OrderDetailPriceCharged * 1000 as [Without Conversion]
	, cast((OrderDetailPriceCharged * 1000) as money) as [Converted to Money]
	, convert(varchar(15), cast((orderdetailpricecharged * 1000) as money), 1) -- Converts to money, has format mask (,)
from OrderDetail

*/
--TRIM FUNCTIONS
--LTRIM, RTRIM, TRIM
--Gets rid of blank spaces with text
/*

select trim(EmployeeFirstName)
+ ' ' + 
trim(EmployeeLastName)
from Employee
order by EmployeeLastName
*/
;
/*
OUTPUT:
-------------------------------
Joe Balla
Cathleen Cooke
Buster Eatmon
Luigi Howe
Stephen Kristopherson
Collin Langlais
Carol Manning
Emanuel Motter
Patrica Newson
Eda Roeder
Eladia Steere
Bob Taylor
Guillermina Valla
*/

--ROUND() -- rounds numbers to whatever we specify
--round(column_name, number of decimal places)
/*


select ProductKey
	, (OrderDetailPriceCharged * OrderDetailQuantity) * 100 as [Tax]
	, round(((OrderDetailPriceCharged * OrderDetailQuantity) * 100), 2) as [Round Tax]
	, cast(((OrderDetailPriceCharged * OrderDetailQuantity)) as decimal(5, 2)) as [Cast Tax]
from OrderDetail
order by OrderKey;
*/


--get table from teacher
/*
select CustomerPhoneKey
	, CustomerLastName
	, CustomerState
	,
from Customer
*/

--Dates
--Math with dates
--datepart(time_period, column)
--time_period -- 'yyyy', 'mm', 'dd'
--Other functions to use: month(column), year(column), day(column)
--datediff(interval, start date, end date)
--current_timestamp -- obtains system clock date
--getdate()
/*
select orderkey
	, orderdate
	, month(orderdate) as [Display Month]
	, year(getdate()) - year(orderdate) as [Year Difference]
	, datediff(Day, orderdate, getdate()) as [Day Difference]
from CustomerOrder;
*/
/*
orderkey   orderdate  Display Month Year Difference Day Difference
---------- ---------- ------------- --------------- --------------
1000       2013-10-08            10               9           3298
1001       2013-10-08            10               9           3298
1002       2013-10-08            10               9           3298
1003       2013-10-08            10               9           3298
1004       2013-10-10            10               9           3296
1005       2013-10-10            10               9           3296
1006       2013-08-03             8               9           3364
1007       2013-09-02             9               9           3334
1008       2013-09-10             9               9           3326
1009       2013-09-15             9               9           3321
1010       2013-09-29             9               9           3307
1011       2013-07-07             7               9           3391
1012       2013-07-09             7               9           3389
1013       2013-07-11             7               9           3387
1014       2013-07-13             7               9           3385
1015       2013-07-16             7               9           3382
1016       2013-06-07             6               9           3421
1017       2013-06-13             6               9           3415
1018       2013-06-20             6               9           3408
1019       2013-06-19             6               9           3409
1020       2013-06-16             6               9           3412
1021       2013-04-10             4               9           3479
1022       2013-04-15             4               9           3474
1023       2013-03-01             3               9           3519
1024       2013-01-02             1               9           3577
1025       2013-02-20             2               9           3528
1026       2013-02-21             2               9           3527
*/

/*
select orderkey
	, orderdate
	, convert(varchar(15), orderdate, 107) as [Formatted]
from CustomerOrder;

*/
/*
orderkey   orderdate  Formatted
---------- ---------- ---------------
1000       2013-10-08 Oct 08, 2013
1001       2013-10-08 Oct 08, 2013
1002       2013-10-08 Oct 08, 2013
1003       2013-10-08 Oct 08, 2013
1004       2013-10-10 Oct 10, 2013
1005       2013-10-10 Oct 10, 2013
1006       2013-08-03 Aug 03, 2013
1007       2013-09-02 Sep 02, 2013
1008       2013-09-10 Sep 10, 2013
1009       2013-09-15 Sep 15, 2013
1010       2013-09-29 Sep 29, 2013
1011       2013-07-07 Jul 07, 2013
1012       2013-07-09 Jul 09, 2013
1013       2013-07-11 Jul 11, 2013
1014       2013-07-13 Jul 13, 2013
1015       2013-07-16 Jul 16, 2013
1016       2013-06-07 Jun 07, 2013
1017       2013-06-13 Jun 13, 2013
1018       2013-06-20 Jun 20, 2013
1019       2013-06-19 Jun 19, 2013
1020       2013-06-16 Jun 16, 2013
1021       2013-04-10 Apr 10, 2013
1022       2013-04-15 Apr 15, 2013
1023       2013-03-01 Mar 01, 2013
1024       2013-01-02 Jan 02, 2013
1025       2013-02-20 Feb 20, 2013
1026       2013-02-21 Feb 21, 2013
*/
/*
select productkey
	,cast((OrderDetailPriceCharged * 100 + OrderDetailPriceCharged) as decimal(9,2))
from OrderDetail;

select productkey
	,cast((OrderDetailPriceCharged * 100 + OrderDetailPriceCharged) as money)
from OrderDetail;

select productkey
	,convert(money, (OrderDetailPriceCharged * 100 + OrderDetailPriceCharged), 2)
from OrderDetail;

select productkey
	, round((OrderDetailPriceCharged * 0.06 + OrderDetailPriceCharged), 2)
from OrderDetail;
*/
use football
--Almost answer to number 3
select month(gameDate) as [Game Month]
	, convert(varchar(11), gameTime, 22) as [Game Time]
	, score as [Score]
from game
order by gameDate;

--answer number 2
GO
select CONCAT(ltrim(rtrim(locationname)), ' ', 
ltrim(rtrim(City))) as [Location/City]
from location
order by locationname;
GO

--answer number 1
select personid
  , '$' + cast(fee as varchar(10)) as [fee]
from playerrec
where fee > 0
order by personid;

--answer to number 4
select personid as [PersonID]
  , datediff(MM, startdate, enddate) as [Months of Service]
from coach
where enddate is not null
order by [Months of Service] desc

--answer to number 5
select personid as [Person ID]
  , convert(varchar(12), startdate, 107) as [Start Date]
from Player
where healthcon = 'none'
order by [Start Date];
