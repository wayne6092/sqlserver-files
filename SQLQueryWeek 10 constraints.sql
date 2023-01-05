--Create and drop databases
/*
use master;
go
drop database pamperedpup;
go
create database pamperedpup;
go 
use pamperedpup;

--PK = Primary Key
--FK = Foreign Key
--UK = Unique
--CK = Check
--DF = Default
--Create owner table
create table owner(
	OwnerID int identity(1000,1),--Column level constraint
	FirstName char(15) Not null,
	LastName char(15) Not null,
	Address char(20) Not null,
	City char(15) Not null,
	State char(2) Not null default 'MI',
	Zip char(9) Not null,
	Phone char(10) Not null,
	DriverLic char(15),
	--Constraints
	--Primary Key
	constraint owner_ownerid_pk primary key(OwnerID),
	--Unique
	constraint owner_driverlic_uk unique(DriverLic)
);
*/

--Create the DOG table
--If primary keys use identity, use different starting values
--create table DOG (
--	DogID		int				identity(2000,1),
--	DogName		char(20)		Not Null,
--	DogBreed	char(20)		Not Null,
--	DogDOB		date			Not Null,
--	DogWeight	decimal(5,2),
--    Fixed		bit				Not Null default 1,
--	OwnerID		int				Not Null,
--	--Constraints
--	--Primary key
--	constraint Dog_dogid_pk primary key(DogID),
--	--Foreign Key
--	constraint Dog_ownerid_fk foreign key(OwnerID) references Owner(OwnerID)
--		on update cascade
--		on delete no action
--);

--Create the CLASS table
--create table CLASS(
--	ClassID		int		identity(3000,1),
--	ClassName	char(30)		not null,
--	Length		int				not null,
--	Prereq		char(30)		not null,
--	--constraints
--	--primary key
--	constraint class_classid_pk primary key(ClassID)
--);

--Create the DOG_CLASS table
create table DOG_CLASS (
	DogID		int,
	ClassID		int,
	Status		char(1)	not null	constraint dogclass_status_df default 'C',--naming default constraint on column
	--constraints
	--primary key
	constraint dogclass_dogclassid_pk primary key(DogID, ClassID),--Compostie Key
	--foreign keys
	constraint dogclass_dogid_fk foreign key (DogID) references Dog(DogID)
		on update cascade
		on delete no action,
	constraint dogclass_classid_fk foreign key (ClassID) references Class(ClassID)
		on update cascade
		on delete no action,	--Check Constraint
	constraint dogclass_status_ck check (status in ('F', 'P', 'I', 'C'))
);

update DOG_CLASS
set status = 'F'
where status = 'f';

-- column_b INT CONSTRAINT DF_Doc_Exz_Column_B DEFAULT 50);

--Be very careful with *Drop*-Which will delete everything you are targeting, including its corresponding data
--DBA's usually don't allow people like us access to dropping DB objects, tables, and data.
drop table DOG_CLASS;