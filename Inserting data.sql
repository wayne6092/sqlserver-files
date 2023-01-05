use pamperedpup;
go
--DDL (Permanent, must be sure before making changes)
--Adding a column
--syntax
/*
alter table table_name
add column_name data type;
It is populated without data

Two steps:
To add data, use an update statement
Then add constraints

Example: Add a new column for owner email to owner
*/
alter table owner
add owner_email char(50);

/*
Dropping a column
Removes column and all data
Be careful and double check

1). Run a dependency check to make sure no other database objects are referencing the column you want to delete.
	Right click on on two tables

2). Fix any issues
3). Communicate with application programmers on dependencies.
4). Test test test

Syntax:
alter table table_name
drop column column_name;

Example: Remove the email column from owner
*/
--alter table owner 
--drop column owner_email;

/*
Changing data types
watch for 
1). Compatability (Char -> VarChar) (Int -> BigInt)
2). Size (If data row doesn't fit new data type, result is error)

Syntax:
alter table table_name
alter column column_name new data type;

Example: Change the data type of the dog breed column to varchar(20)
*/
alter table dog
alter column dogbreed varchar(20);

/*
Changing a NULL status
If set to not null-->DB checks all data is in column->before you do this check to see if data is there
For NOT NULL must make sure all rows comply with rules
Process of when there are rows that don't comply:
1). Run a SELECT statement to find rows that have no value
2). Issue UPDATE to add values to those rows
3). Issue your ALTER table statement to place the NOT NULL constraint on the column.

Syntax:
alter table table_name
alter column column_name datatype NULL/NOT NULL --Can make it NULL or NOT NULL

Example: Allow the dog breed column to be null in the dog table.
*/
alter table dog
alter column dogbreed varchar(20) null; --Nothing needs to be done


alter table dog
alter column dogbreed varchar(20) not null;

/*
Changing a Default value
No checks on this change

Syntax to add default value:
alter table table_name
add constraint constraint_name default default_value for column_name;

Syntax to delete a default value:
alter table table_name
drop constraint constraint_name;

Example: Add a default value to the phone column in OWNER of 'no phone'
*/
--Adding default
alter table owner
add constraint owner_phone_df default 'no phone' for phone;

--Deleting default
alter table owner 
drop constraint owner_phone_df;

/*
Changing constraint
No Data: Easy
Yes Data: Hard
Adding when data is present:
1). Run a SELECT statement to find rows that will violate the new constraint.
2). Fix rows that iolate the newconstraint
3). Issue the ALTER table statement
DB runs backwards check through data to see if it adheres to rules

NO EDIT/DISABLE Syntax for constraint
You have to drop it and re-add it

Syntax:
alter table table_name
add constraint constraint_name constraint_type constraint;

Example: Add a check constraint to the owner table that will only allow the user to enter Sterling Heights., Warren or Clinton Twp. as a city in the city column.
*/
alter table owner
add constraint owner_city_ck check (city in('Sterling Hts.', 'Warren', 'Clinton Twp'));

/*
Dropping a constraint
--Business Rule Disabled--
Syntax:
alter table table_name
drop constraint constraint_name;

Example: Delete the check constraint on the city column in the owner table.
Is not so easy in ORACLE
Lots of checking must be done before doing this
*/
alter table owner
drop constraint owner_city_ck;

/*
Changing a colum name
Must check the following:
1). Existing database object dependencies

2). Existing application dependencies

Once dependencies are identified then do the following:
3). In SQL Server issue the following:

exec sp_rename 'table_name.column_name', 'new_column_name', 'column';
4). In other databases you will do the following:
	a). Create a backup.
	b). Create a new column with the new name
	c). Copy existing data from old column into the new
	d). Drop the old column.

5). Fix all database dependencies

6). Fix all application dependencies

7). Test test test

Example: Change the name of the phone column in owner to ownerPhone
*/

exec sp_rename 'owner.phone', 'ownerPhone', 'column';

/*
Never do this
Changing Table name
Must check the following:
1). Existing database object dependencies

2). Existing application dependencies
Drop all constraints in other tables (FK)

Once dependencies are identified then do the following:
3). In SQL Server issue the following:

Syntax: 
exec sp_rename '[schema_name].table_name', 'new_table_name';

4). In other databases you will do the following:
	a). Create a backup.
	b). Create a new table with the new name
	c). Copy existing data from old table into the new table
	d). Drop the old table.

5). Fix all database dependencies
	Add back the constraints
6). Fix all application dependencies

7). Test test test

Example: Rename the OWNER table CUSTOMERS
*/
exec sp_rename '[dbo].[owner]', 'OWNER';

/*
Add data to tables
INSERT statement
1). Named column one row

Syntax:
insert into table_name
(column_name, column_name...)
values
('text', 12345, ...);
--Do not include primary keys with  identity(surrogate)
--Do not include default value columns unless you are using a value that is different.
--Do not include columns where nulls are allowed unless you have a value

*/
insert into owner
	(FirstName,LastName,Address,City,Zip, Phone, owner_email)
values
	('John', 'Smith', '231 Elm', 'Warren', '48092', '5862349870','johnsmith@gmail.com');

/*
2). Named column multiple rows
Syntax: 
insert into table_name
(column_name, column_name...)
values
('text', 12345, ...),
('text', 6789, ...); --Run them one at a time
*/
insert into owner
	(FirstName,LastName,Address,City,Zip, Phone, DriverLic, owner_email)
 values
	('Jane', 'Doe', '254 Maple', 'Clinton Twp.', '48749','5868972345', 'any number', 'janed@gmail.com'),
	('Harvey', 'Lanson', '387 Oak', 'Warren', '48759', '5860782345', 'anyothernumber', 'hlan@gmail.com');
	
select * 
from owner;
/*
3). Positional insert
Syntax:
insert into tablename
values
('text', 12345, ...)

Make sure you know the order of the columns
We can't include surrogate keys but must include defaults and nulls
-- add one row to the Dog Table
*/
insert into dog
values
('Bucky', null, '2008-12-23', 70.0, 1, 1000)

select * 
from dog;

/*
Update 
--used to update existing data
Syntax: 
update table_name
set column_name = new_value
WHERE some_condition;

Include WHERE unless you want to update the entire table.

Example: Change the breed for Bucky to Boxer Mix
*/
update dog
set DogBreed = 'Boxer Mix'
where dogname = 'Bucky';
select * 
from dog;

/*
DELETE
--deletes rows from a table
Syntax:
delete from table_name
WHERE some_condition;

Include WHERE unless you want to delete every row in the table

Example: Delete the record for Harvey Lanson
*/
delete
from owner
where firstname = 'Harvey'
	and lastname = 'Lanson';
--use pamperedpup
--go
/*
Indexes
Syntax:
create index index_name
on table_name(column_names);

--Creates a non clustered index on the last name column in owner
*/
create index owner_lastname
	on owner(lastname);

--Creates a non clustered index on the city and state columns in owner
create index ownercitystat
    on owner(city, state);
   
--Creates a unique non clustered index on the driver's license column in owner 
create unique index ownerDrivLic
    on owner(driverlic);
    
--Deletes the non clustered index on the last name column in the owner table
drop index owner_lastname
    on owner;

/*
Inserting values in dog_class
*/
select *
from dog;
select *
from class;

insert into DOG_CLASS
(DogID, ClassID, Status)
values
(2000, 3000, 'P'),
(2000, 3001, 'P'),
(2000, 3002, 'I');

select *
from DOG_CLASS;