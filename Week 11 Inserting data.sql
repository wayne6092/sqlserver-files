
--go
--use pamperedpup;
--Create the Owner table
--use master
--go
--drop database pamperedpup;
--go

--create database pamperedpup
--go
--use pamperedpup;
--go

--go
--use pamperedpup;
--Create the Owner table
create table owner (
OwnerID int identity(1000,1),
FirstName char(15) Not Null,
LastName char(15) Not Null,
Address char(20) Not Null,
City Char(15) Not Null,
State char(2) Not Null default 'MI',
Zip char(9) Not Null,
Phone char(10) Not Null, 
DriverLic char(15),
--constraints
--primary key
constraint owner_ownerid_pk primary key(OwnerID),
--Unique
constraint owner_drivlic_uk unique(DriverLic)
);
--Create the DOG table
create table DOG (
DogID int identity(2000,1),
DogName char(20) Not Null,
DogBreed char(20) Not Null,
DogDOB date Not Null,
DogWeight decimal(5,2),
    Fixed bit Not Null default 1,
OwnerID int Not Null,
--Constraints
--Primary key
constraint Dog_dogid_pk primary key(DogID),
--Foreign Key
constraint Dog_ownerid_fk foreign key(OwnerID) references Owner(OwnerID)
on update cascade
on delete no action
);
--Create the CLASS table
create table CLASS(
ClassID int identity(3000,1),
ClassName char(30) not null,
Length int not null,
Prereq char(30) not null,
--constraints
--primary key
constraint class_classid_pk primary key(ClassID)
);
--Create the DOG_CLASS table
create table DOG_CLASS (
DogID int,
ClassID int,
Status char(1) not null constraint dogclass_status_df --Create and drop databases
--use master;
--go
--drop database pamperedpup;
--go
--create database pamperedpup;
--go
--use pamperedpup;
--Create the Owner table

create table owner (
OwnerID int identity(1000,1),
FirstName char(15) Not Null,
LastName char(15) Not Null,
Address char(20) Not Null,
City Char(15) Not Null,
State char(2) Not Null default 'MI',
Zip char(9) Not Null,
Phone char(10) Not Null, 
DriverLic char(15),
--constraints
--primary key
constraint owner_ownerid_pk primary key(OwnerID),
--Unique
constraint owner_drivlic_uk unique(DriverLic)
);
--Create the DOG table
create table DOG (
DogID int identity(2000,1),
DogName char(20) Not Null,
DogBreed char(20) Not Null,
DogDOB date Not Null,
DogWeight decimal(5,2),
    Fixed bit Not Null default 1,
OwnerID int Not Null,
--Constraints
--Primary key
constraint Dog_dogid_pk primary key(DogID),
--Foreign Key
constraint Dog_ownerid_fk foreign key(OwnerID) references Owner(OwnerID)
on update cascade
on delete no action
);
--Create the CLASS table
create table CLASS(
ClassID int identity(3000,1),
ClassName char(30) not null,
Length int not null,
Prereq char(30) not null,
--constraints
--primary key
constraint class_classid_pk primary key(ClassID)
);
--Create the DOG_CLASS table
create table DOG_CLASS (
DogID int,
ClassID int,
Status char(1) not null constraint dogclass_status_df 
default 'C',
--constraints
--primary key
constraint dogclass_dogclassid_pk primary key(DogID, ClassID),
--foreign keys
constraint dogclass_dogid_fk foreign key (DogID) references Dog(DogID)
on update cascade
on delete no action,
constraint dogclass_classid_fk foreign key (ClassID) references 
Class(ClassID)
on update cascade
on delete no action,
--Check Constraint
constraint dogclass_status_ck check (status in ('F', 'P', 'I', 'C'))
);
drop table DOG_CLASS;
