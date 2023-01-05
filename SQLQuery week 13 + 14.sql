select firstName
    , lastName
    , itemID
from Item i right join People p 
  on p.peopleid = i.ownerid
where itemID is null and PeopleType = 'OC'
order by lastName;

select *
from people;

select firstName as [First Name]
    , lastName as [Last Name]
    , Name as [Charity Name]
from people p left join charity c
    on p.peopleid = c.contactid
where PeopleType = 'CHAR' and Name is null