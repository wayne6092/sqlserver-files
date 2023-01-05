--display name and breed
use shelter;
go
select Name
	, Breed
from Dog d join dog_condition dc
	on d.dogid = dc.dogid
where conditionID in 
	(select conditionID 
	from Condition
	where ConditionName like '%eye%')
order by Breed;


select firstName
	, lastName
	, MaxAnimalsInHouse
from people p join foster f
	on p.peopleid = f.peopleid
	where MaxAnimalsInHouse in
	(select max(AnimalsInHouse)--this has to be compatible with column in WHERE clause
	from ADOPTER)
order by LastName;

	select orderkey
	, OrderDetailPriceCharged
	, OrderDetailQuantity
	, orderDetailPriceCharged * OrderDetailQuantity
from OrderDetail
where productkey in     --Use = for returning one column, use 'in' when returning multiple columns
	(select productkey
	 from product
	 where productname like '%Large%');


use pizza;
go

select productkey
	,avg(orderdetailpricecharged)
from orderdetail
group by productkey;

select orderkey, orderdetailpricecharged, productkey
from orderdetail outside
where OrderDetailPriceCharged >=
	(select avg(OrderDetailPriceCharged)
	from OrderDetail inside
	where outside.productkey = inside.ProductKey);


/*
Create query that will show a composite list of tutors and students. Include the first name and last name of the tutors and students, along with a column that will designate if that person is a student or a tutor. Sort your output by the person designation.
Use: Union All, we want all results
*/
use tutor;
go
select TutorFirstName
	, TutorLastName
	, 'Tutor'
from tutor
union all
select studentFirstName
	, studentLastName
	, 'Student'
from Student;

select TutorFirstName as [First Name]
	, TutorLastName as [Last Name]
	, 'Tutor' as [Tutor/Student]
from tutor
union all
select studentFirstName
	, studentLastName
	, 'Student'
from Student
order by [Tutor/Student];

/*
Create a list of courses that tutors can tutor and courses that students are getting tutored in. Include in output the name of the course along with the designation of student or tutor. Make sure your output suppresses or does not show duplicates
*/

select coursename
	, 'Tutor'
from TutorCourse tc join course c
	on tc.CourseKey = c.CourseKey
union
select coursename
	,'Student'
from StudentCourse sc join course c
	on sc.coursekey = c.CourseKey;

/*
Intersect -- looks for what is common between two result sets
We would like to find out if there are any students who are in wok force retraining that are also seeking retutoring. Display the first and last name of the student along with their phone number.
*/
select studentfirstname
	, studentlastname
from student
where StudentWorkforceRetraining = 1
intersect
select studentfirstname
	, studentlastname
from student s join session sn
	on s.studentkey = sn.StudentKey;

/*
Subtraction--Focus on PK first (Not REQUIRED)
Except shows us rows that are in one result set and not in the other 
Create query that shows students who have signed up for tutoring but have not booked an appointment yet. Include in query first and last name of the student along with their phone number. Sort output by the student last name. Title columns First Name, Last Name and Phone.
*/
select studentfirstname as [First Name]
	, studentlastname as [Last Name]
	, studentphone as [Phone]
from student
except
select studentfirstname
	, studentlastname
	, studentphone
from student s join session sn
	on s.studentkey = sn.StudentKey
order by [Last Name]
	;

use Dog_Owner;
go

select dogid
	, dogname
	, o.ownerid
	, lastname
from dog d full join owner o
	on d.ownerid = o.ownerid
;

use pizza;
go
select c.customerphonekey
	, customerlastname
	, orderkey
	, orderdate
from customer c left join customerorder o
	on c.CustomerPhoneKey = o.CustomerPhoneKey
	;

select c.customerphonekey
	, customerlastname
	, orderkey
	, orderdate
from customer c left join customerorder o
	on c.CustomerPhoneKey = o.CustomerPhoneKey
where c.CustomerPhoneKey != '0000000000' and orderkey is null	;

--Wrong way to use right
select c.customerphonekey
	, customerlastname
	, orderkey
	, orderdate
from customer c right join customerorder o
	on c.CustomerPhoneKey = o.CustomerPhoneKey
where c.CustomerPhoneKey != '0000000000' and orderkey is null;

--self join
select customer.customerphonekey
	, customer.CustomerLastName
	, customer.ReferredBy
	, referred.Customerlastname
from Customer referred join customer
	on customer.ReferredBy =
		referred.CustomerPhoneKey;

/*
Cant use order by on views
Syntax:
create view view_name
	(alternate column titles)
	as 
	select statement

go -- Must use go because this is DDL

Create view and then comment it out
create view to show the name of the customer along with the total they have spent. Include columns Last Name, and First Name
Customer -> customerOrder -> orderDetail
*/
use pizza;
go

create view totalView
	([Last Name], [Total Spent])
	as
select CustomerLastName
	, sum(orderDetailQuantity * orderDetailPriceCharged)
from customer c join customerOrder co
	on c.CustomerPhoneKey = co.CustomerPhoneKey
	join OrderDetail od
	on co.OrderKey = od.OrderKey
group by CustomerLastName;
go

select *
from totalView;

create view totalViewFormatted
	([Last Name], [Total Spent])
	as
select CustomerLastName
	, '$' + cast(sum(orderDetailQuantity * orderDetailPriceCharged) as varchar(10))
from customer c join customerOrder co
	on c.CustomerPhoneKey = co.CustomerPhoneKey
	join OrderDetail od
	on co.OrderKey = od.OrderKey
group by CustomerLastName;
go

select *
from totalViewFormatted;