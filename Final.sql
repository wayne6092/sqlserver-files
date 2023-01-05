use Shelter;
go

--Problem #1
create table BREED (
    BreedID    int            identity(1000,1),
    BreedName   char(15)    Not Null,
    Species    char(15)    Not Null,
    Size        char(15)    Not Null	default 'Medium',
    --constraints
    --primary key
    constraint breed_breedid_pk primary key(BreedID),
	constraint breed_size_ck check (size in ('Small', 'Medium', 'Large', 'Extra Large'))
);
drop table BREED;

go 

--Problem #2
--Where procedure_cost is null, update value to 0
update DOG_PROCEDURE
set procedure_cost = 0
where procedure_cost is null;
go
--ALter table to have default value 0 for procedure_cost for future data
alter table DOG_PROCEDURE
add constraint dogprocedure_procedurecost_df default 0 for procedure_cost;

alter table DOG_PROCEDURE
alter column procedure_cost decimal(10,2) not null;

go 

--Problem #3
select Name as [Dog Name]
	, Breed
from DOG d join ADOPTION a
on d.DogID = a.DogID
where d.DogID in
	(select DogID
	from ADOPTION
	where Breed in ('Golden Retriever', 'Rottweiler', 'Irish Setter', 'Boxer'))
order by Breed;

--Problem #4
--Attempt 1
select city as [Foster City]
	,(select count(DogID)
	 from ADOPTION
	 where ReturnDate is null) as [Total Adoptions]
from People p join Foster f
	on p.PeopleId = f.PeopleID
where (select count(DogID) from Adoption) >= 5
group by City
order by [Total Adoptions]
;

--Attempt 2
select city as [Foster City]
	,count(DogID) as [Total Adoptions]
from People p join Foster f
	on p.PeopleId = f.PeopleID
	join ADOPTION a 
	on p.PeopleId = a.AdopterID
where ReturnDate is null
group by City
order by [Total Adoptions];

--Attempt 3
select city as [Foster City]
	,count(DogID) as [Total Adoptions]
from People p join Adoption a
	on p.PeopleId = a.AdopterID
where ReturnDate is null
group by City
having count(DogID) >= 5
order by [Total Adoptions] desc
;
--Ran out of time!

--Problem #5 
select Name as [Dog Name]
	, 'Procedure' as [Condition/Procedure]
from Dog d join DOG_PROCEDURE dp
	on d.DogID = dp.DogID
union
select Name
	, 'Condition'
from Dog d join DOG_CONDITION dc
	on d.DogID = dc.DogID
order by Name;

--Problem #6
create view DogNoProcedure
	([Dog Name], [Procedure Date])
	as 
select Name
	, procedureDate
from Dog d left join DOG_PROCEDURE dp
	on d.DogID = dp.DogID
where ProcedureDate is null
--order by name
;
go 

select *
from DogNoProcedure
order by [Dog Name];