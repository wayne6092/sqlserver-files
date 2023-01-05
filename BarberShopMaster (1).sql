
/*
Project Info:

Project Contrubutors:
	Wayne Williams (Project Lead)
	Noah Meduvsky
	Hailey Fehn
	Andrew Majewski

To support referential integrity the PK's and FK's of the database must not be null. 
There are constraints between all PK to FK relationships between tables. The tables were 
inserted into the database in a specific order so that referential integrity is upheld, 
and so that it works correctly. 
The following order is: 
1. Person			Type: Domain-Supertype	(Create: Noah | Insert: Hailey)
2. Category			Type: Look-up			(Create: Hailey | Insert: Noah)
3. Service			Type: Domain			(Create: Hailey | Insert: Hailey)
4. Employee			Type: Domain-Subtype	(Create: Noah | Insert: Noah)
5. Customer			Type: Domain-Subtype	(Create: Noah | Insert: Hailey)
6. Vendor			Type: Domain-Subtype	(Create: Andrew | Insert: Noah)
7. Product			Type: Domain			(Create: Andrew | Insert: Noah)
8. CustomerOrder	Type: Domain			(Create: Wayne | Insert: Hailey)
9. Order_Services	Type: Linking			(Create: Wayne | Insert: Hailey)
10. Order_Products	Type: Linking			(Create: Wayne | Insert: Noah)

other constraints:
All tables have a primary constraint for the primary key, and a foreign key constraint 
that describes its relationship with another table that references the PK as a FK
Check constraint for price columns in each table it is mentioned
Check constraint for quantity column in each table it is mentioned
Check constraint for WholesalePrice and RetailPrice columns in Product
Unique constraint for SSN column of employee table

Business Case: 
A friend of ours needs a database created for their barbershop in Clinton Township. 
The barbershop provides different types of hair cutting/trimming services and they 
also provide products for hair that can be purchased when a customer comes in. 
Customers can be in the database without needing to place an order. 
When there are multiple people on one order, each person is recorded as a customer. 
In this DB we only have one person for each order. There can be multiple services on an order, 
and there can be multiple products on an order. There are categories for each service and product. 
*/

-- Drop and Recreate Database
use master;
go
drop database barbershop;
go
create database barbershop;
go 
use barbershop;

--Person Table (Noah)
--The code below creates the Supertype table PERSON, it has 3 default values for 3 different columns (State, Phone, and Email)
--Constraint for personid supports referential integrity, and this table must be entered into database first
create table Person (
    PeopleID    int            identity(1000,1),
    FirstName    char(15)    Not Null,
    LastName    char(15)    Not Null,
    Address        char(20)    Not Null,
    City        char(20)    Not Null,
    State        char(2)        Not Null        default 'MI',
    Zip            char(5)        Not Null,
    Phone        char(10)    Not Null        default 'No Email',
    Email        char(30)    Not Null        default 'No Phone',
    PeopleType    char(10)    Not Null,
    --constraints
    --primary key
    constraint person_personid_pk primary key(PeopleID),
);

--Person Data, (Hailey)
--Hailey turned the identity feature off for the PERSON table before inserting data
--Hailey inserted the following rows into the PERSON table
set identity_insert dbo.person off;--needed for personid
insert into Person
   ( FirstName, LastName, Address, City, State, Zip, Phone, Email, PeopleType )
VALUES
   ('Adam', 'James', '2345 Oak', 'Mt. Clemens', 'MI', '48043', '5865557469', 'adamjames@gmail.com', 'Customer'),
   ('William', 'Jameson', '245 Beaver', 'Armada', 'MI', '48005', '5865557468', 'williamjameson@gmail.com', 'Employee'),
   ('Juliet', 'Clarkson', '4762 N. River Rd', 'Clinton Twp.', 'MI', '48036', '5865554632', 'julietclarkson@gmail.com', 'Customer'),
   ('Bob', 'Dale', '5678 Red', 'Shelby Twp.', 'MI', '48317', '5864831237', 'bobdale@gmail.com', 'Customer'),
   ('Katelyn', 'Pipe', '443 Park', 'Macomb', 'MI', '48042', '5863489412', 'katelynpipe@gmail.com', 'Employee'),
   ('Luke', 'Mills', '432 Bloom Dr.', 'Richomnd', 'MI', '48062', '5967098004', 'lukemills@gmail.com', 'Customer'),
   ('Ava', 'Smith', '101 Lexington', 'Macomb', 'MI', '48044', '5862234441', 'avasmith@gmail.com', 'Employee'),
   ('Peter', 'Gills', '221 Clover', 'Clinton Twp', 'MI', '48035', '5864793201', 'petergills@gmail.com', 'Employee'),
   ('Maddie', 'Peters', '556 Pave', 'Richmond', 'MI', '48062', '5867724068', 'maddiepeters@gmail.com', 'Customer'),
   ('Bailey', 'Smith', '759 Roller', 'Armada.', 'MI', '48005', '5863325556', 'baileysmith@gmail.com', 'Employee'),
   ('Vince', 'Paul', '115 Bell Rd.', 'Clinton Twp.', 'MI', '48035', '5863350145', 'vincepaul@gmail.com', 'Employee'),
   ('Charlie', 'Owen', '221 Range Blvd.', 'Macomb', 'MI', '48044', '5869035899', 'charlieowne@gmail.com', 'Customer'),
   ('Zola', 'Grey', '889 Page Dr.', 'Shelby Twp.', 'MI', '48317', '5862078425', 'zolagrey@gmail.com', 'Employee'),
   ('Brittany', 'Grey', '889 Page Dr.', 'Shelby Twp.', 'MI', '48315', '5862078425', 'brittanygrey@gmail.com', 'Customer'),
   ('Ruth', 'Adams', '445 Jolly Dr.', 'Mt. Clemens', 'MI', '48043', '5860117833', 'ruthadams@gmail.com', 'Customer'),
   ('Steve', 'Rando', '789 Grey', 'Shelby Twp.', 'MI', '48315', '5863059743', 'steverando@gmail.com', 'Employee'),
   ('Taylor', 'Wayne', '223 School Rd.', 'Richmond','MI', '48062', '5862238899', 'taylorwayne', 'Employee'),
   ('Braden', 'Hunt', '987 Hollow Dr.', 'Armada', 'MI', '48005', '586667969', 'bradenhunt@gmail.com', 'Customer'),
   ('Ivan', 'Mell', '4005 Rose', 'Macomb', 'MI', '48044', '5869904477', 'ivanmell@gmail.com', 'Customer'),
   ('Billy', 'Jones', '443 Blossom Dr.', 'Clinton Twp.', 'MI', '48036', '5861138056', 'billyjones@gmail.com', 'Employee'),
   ('Shellys', 'Products', '403 Hollow Dr.', 'Armada', 'MI', '48005', '5869942689', 'shellybeauty@gmail.com', 'Vendor'),
   ('Fine', 'Cut', '1234 Highway Rd.', 'Richmond', 'MI', '48062', '5863349034', 'finecut@gmail.com', 'Vendor'),
   ('Maxs', 'Pomenade', '9734 Blue Rd.', 'Richmond', 'MI', '48062', '5869345726', 'maxpomenade@gmail.com', 'Vendor'),
   ('Hairspray', 'For Men', '773 Hair', 'Macomb', 'MI', '48044', '5867748056', 'hairsprayformen@gmail.com', 'Vendor'),
   ('Firm', 'Hold Gel', '8080 Smooth Blvd.', 'Mt. Clemens', 'MI', '48043', '586303679', 'firmholdgel@gmail.com', 'Vendor'),
   ('Natural', 'Shampoo Inc.', ' 678 Apple Creek Rd.', 'Selby Twp.', 'MI', '48317', '586883467', 'naturalshampooinc@gmail.com', 'Vendor'),
   ('Womans', 'Shampoo', ' 223 Brush Rd.', 'Armada', 'MI', '48005', '5862234456', 'womansshampoo@gmail.com', 'Vendor'),
   ('Melindas', 'Mousse', '098 Court', 'Shelby Twp.', 'MI', '48316', '5868990765', 'melindasmousse@gmail.com', 'Vendor'),
   ('Dry Scalp', 'Shampoo', '115 Leaf Rd.', 'Clinton Twp.', 'MI', '48036', '5863324567', 'dryscalpshampoo@gmail.com', 'Vendor'),
   ('Combs', 'for Kids', '3340 Kids Dr.', 'Macomb', 'MI', '48044', '5867075432', 'combsforkids@gmail.com', 'Vendor')
   ;
--Category Table (Hailey)
--The code below creates the CATEGORY table, and uses identity(2000) so that PERSON and CATEGORY have different ID's
--There is a PK constraint on the categoryID column for the table
create table Category(
    CategoryID   int           identity(2000,1),
    Name         Char(30)      not null,
    Description  Varchar(250)   not null,
    --constraint 
    --primary key
    Constraint category_categoryid_pk primary key(CategoryID)
);
--NOAH
--Noah inserted data into the CATEGORY table for Name, and Description
set identity_insert dbo.category off; --Done to avoid an error
insert into category
	(Name, Description)
values
	('Hair Care', 'Top of the line  products to provide you with healthy vibrant hair.'),
	('Scissors', 'Top of the line scissors for in home hair care.'),
	('Pomenade', 'A creamy paste for effortless greaseless style.'),
	('Hairspray', 'Strong holding spray for all day style.'),
	('Gel', 'Strong hold gel to mold the hair for an aggressive style.'),
	('Mousse', 'A foaming product to add volume and light holding for the hair.'),
	('Combs', 'Fine tooth utensil to untangle and arrange the hair.'),
	('Touch Up', 'A quick bang/neck trim to keep your hair looking new!'),
	('Hair Dye', 'Hair dying taylored to your preferences.'),
	('Full Package', 'Men or womens hair cut with shampoo lathering and massage.'),
	('Custom', 'A special haircut for certain occassions.'),
	('Face-Frame', 'Haircut taylored to bring out the best qualities of your face.'),
	('Root Smudge', 'Darkness added to roots to add depth and volume.'),
	('Straightening/Curling', 'Flatten or curl your hair for a new fresh look.');

--Service Table (Hailey)
--Hailey created the SERVICE table
--This table has a PK constraint on the serviceID column, and a FK constraint on the CategoryID column
--it also has a check constraint for the price column in Services to make sure price is higher than 0
create table service(
    ServiceID    int            identity(3000,1),
    Description  Varchar(250)    not null,
    Price        decimal(9,2)   not null,
    ServiceName  Char(30)       not null,
    CategoryID   int            not null,
    --constraint
    --primary key
    Constraint services_serviceid_pk primary key (ServiceID),
    --foreign key
    constraint services_categoryid_fk foreign key (CategoryID) references Category(CategoryID)
    on update cascade
    on delete no action,
    --check constraint
    constraint services_price_ck check (price > 0)
);

--Service Data (Hailey)
--Hailey entered data into the Service table
--Price, ServiceName, and categoryID was entered
insert into service
	(Description, Price, ServiceName, CategoryID)
VALUES
	('For in between regular haircuts', 15.00, 'Bang/Neck Trim', 2007),
	('Color only painted where new hair growth is', 70.00, 'Color Retouch', 2008 ),
	('Men: shampoo, scalp massage, cut', 40.00, 'Men Cut', 2009),
	('Solid tone painted root to bottom of hair', 80.00, 'All Over Color', 2008),
	('Customized styling for special event', 65.00, 'Updo and Special Occasions', 2010),
	('Women: shampoo, scalp massage, cut and blowdry', 43.00, 'Women Cut', 2009),
	('Customized look for bride.', 75.00, 'Bridal Style', 2010),
	('Foil or painting, very front of hair around the face is lightened.', 75.00, 'Face Frame Highlights', 2011),
	('Formula used to add depth to the root area of lightened hair.', 35.00, 'Root Smudge', 2012),
	('Iron, wand, or flat iron, are used to create finished look.', 20.00, 'Flat Iron/Curl', 2013);



--Employee Table (Noah)
--Noah created the EMPLOYEE table
--Table has PK constraint on PeopleID in Employee table and FK constraint on PeopleID in Person table
--Also has a unique constraint on SSN column
create table Employee (
        PeopleID    int,
        SSN            char(11)        Not Null,
        DOB            date        Not Null,
        StartDate    date        Not Null,
        EndDate        date,
        --constraints
        --primary key
        constraint employee_personid_pk primary key(PeopleID),
        --foreign key
        constraint employee_personid_fk foreign key (PeopleID) references person(PeopleID)
        on update cascade
        on delete no action,
        constraint employee_ssn_uk unique (SSN)
);

--Employee data (Noah)

Insert into Employee
	(PeopleID, SSN, DOB, StartDate, Enddate)
Values
	(1001, '458-65-7258', '1988-08-16', '2010-06-22', '2014-01-15'),
	(1004, '785-47-6258', '1987-06-15', '2012-05-24', null),
	(1006, '568-24-8154', '1989-05-19', '2011-12-10', null),
	(1007, '247-65-7246', '1990-01-16', '2010-10-15', '2012-05-14'),
	(1009, '875-69-3458', '1983-02-08', '2011-11-04', null),
	(1010, '749-89-6587', '1988-06-29', '2011-01-25', null),
	(1012, '145-78-8945', '1990-03-10', '2010-02-10', '2014-02-05'),
	(1015, '548-88-4785', '1991-04-21', '2011-05-05', '2013-08-06'),
	(1016, '478-48-7842', '1989-12-22', '2010-01-15', '2013-08-20'),
	(1019, '192-89-7482', '1990-11-24', '2009-02-12', '2015-09-27');



--Customer Table (Noah)
--Noah created CUSTOMER table
--table has PK constraint on personID in customer table and FK constraint on personID in PEOPLE table
create table Customer (
        PeopleID        int, 
        FirstEncounter    date    Not Null,
        DOB                date    Not Null,
        --constraints
        --primary key
        constraint customer_personid_pk primary key(PeopleID),
        --foreign key
        constraint customer_personid_fk foreign key (PeopleID) references Person(PeopleID)
        on update cascade
        on delete no action,
);

--Customer Data, (Hailey)
--Hailey inserted data, she inserted data for columns: PeopleID, FirstEncounter, and DOB

insert into Customer 
 (PeopleID, FirstEncounter, DOB)
VALUES
(1000, '2001-10-07', '1980-05-09'),
(1002, '2010-09-29', '1990-12-15'),
(1003, '2020-01-23', '2000-04-02'),
(1005, '2005-07-01', '1987-02-02'),
(1008, '2022-11-01', '1999-04-22'),
(1011, '2018-10-15', '1988-05-20'),
(1013, '2012-06-07', '1979-09-04'),
(1014, '2009-12-20', '1991-01-10'),
(1017, '2003-05-07', '1984-06-12'),
(1018, '2022-10-10', '2000-07-21');

--Vendor Table (Andrew)
--Andrew created the VENDOR table
--Table has PK constraint on personID in VENDOR table, and FK constraint on personID in PEOPLE table
CREATE TABLE Vendor(
        PeopleID     int            NOT NULL, 
        VendorName     CHAR(26)     NOT NULL, 
        -- Constraints 
        -- Primary Key
        constraint vendor_personid_pk PRIMARY KEY (PeopleID),
        -- Foreign Key
        constraint vendor_personid_fk foreign key (PeopleID) references person(PeopleID)
			on update cascade
			on delete no action
    );

--Vendor Data (Noah)
--Noah entered data into the VENDOR table
--Columns entered are the PeopleID, and VendorName

Insert into Vendor
	(PeopleID, VendorName)
Values
	(1019, 'Shelly’s Haircare Products'),
	(1020, 'Fine Cut Scissors Inc.'),
	(1021, 'Max’s Pomenade Products'),
	(1022, 'Hairspray for Men'),
	(1023, 'Firm Hold Gel'),
	(1024, 'Natural Shampoo Inc.'),
	(1025, 'Woman’s Softening Shampoo'),
	(1026, 'Melindas Mystical Mousse'), 
	(1027, 'Dry Scalp Shampoo'),
	(1028, 'Combs for Kids');


--Product Table (Andrew)
--Andrew created the PRODUCT table with the identity function starting at 4000
--Table has PK constraint on ProductID in Product table
--Also has FK constraint on CategoryID in Category table
--Also has FK constraint on VendorID in Person table
--Also has two check constraints on both WholesalePrice and RetailPrice to be > 0
CREATE TABLE product(
    ProductID        INT             identity(4000,1), --pk
    CategoryID         INT             NOT NULL, --fk
    VendorID        INT              NOT NULL, --fk
    ProductName        CHAR(30)         NOT NULL,
    WholeSaleprice    DECIMAL(9,2)     NOT NULL,
    RetailPrice     DECIMAL(9,2)      NOT NULL,
    Description     VARCHAR(50)     NOT NULL,

    -- Constraints 
    -- Primary Key
    constraint product_productid_pk PRIMARY KEY (ProductID),
    -- Foreign Key
    constraint product_categoryid_fk  foreign key (CategoryID) references Category(CategoryID)
		on update cascade
		on delete no action,
    constraint product_vendorid_fk  foreign key (VendorID) references person(PeopleID)
        on update cascade
        on delete no action,
    --Check
    constraint product_wholesaleprice_ck check(wholesaleprice > 0),
    constraint product_retailprice_ck check(retailprice > 0)
    );

-- Product Data (Noah)
--Noah inserted data into PRODUCT table
--Columns entered are the CategoryID, VendorID, ProductName, WholeSaleprice, RetailPrice, and Description
set identity_insert dbo.product off; --Done to avoid error
insert into Product
	(CategoryID, VendorID, ProductName, WholeSaleprice, RetailPrice, Description)
Values
	(2000, 1019, 'Shellys Tea Tree Conditioner', 7.50, 10.00, 'This is a product Item'),
	(2001, 1020, 'Close Cut Scissors', 8.00, 15.00, 'This is a product Item'),
	(2002, 1021, 'Pomenade', 3.00, 5.00, 'This is a product Item'),
	(2003, 1022, 'Hairspray', 2.50, 4.00, 'This is a product Item'),
	(2004, 1023,'Gel', 3.00, 6.00, 'This is a product Item'),
	(2000, 1024, 'Coconut Shampoo', 6.00, 10.00, 'This is a product Item'),
	(2000, 1025, 'Moisturizing Shampoo', 7.00, 10.00, 'This is a product Item'),
	(2005, 1026, 'Volumizing Mousse', 2.75, 5.00, 'This is a product Item'),
	(2000, 1027, 'Rejuvinating Shampoo', 3.25, 5.50, 'This is a product Item'),
	(2006, 1028, 'Fine Tooth Comb', 5.00, 8.00,'This is a product Item');

--Customer_Order Table (Wayne)
--Wayne created the Customer_Order table with identity function starting at 5000
--Table has PK constraint on OrderID in Customer_Order table
--Has FK constraint on CustomerID in PERSON table
--has FK constraint on EmployeeID in PERSON table
create table customerorder(
    OrderID            int                identity(5000, 1),    --PK
    CustomerID        int                not null,            --FK
    EmployeeID        int                not null,            --FK
    OrderDate        date            not null,
    Payment         char(6)    not null,
    Comments        varchar(200)    null,
    
    --Constraints
    --Primary Key
    constraint customerorder_orderid_pk primary key(OrderID),
    --Foreign Key
    constraint customerorder_customerid_fk foreign key(CustomerID) references person(PeopleID)
        on update cascade
        on delete no action,
    constraint customerorder_employeeid_fk foreign key(EmployeeID) references Person(PeopleID) 
        on update no action
        on delete no action
);

--CustomerOrder data (Hailey)
--Hailey inserted data into the CustomerOrder
--Columns entered are CustomerID, EmployeeID, OrderDate, Payment, and Comments
insert into CustomerOrder
	(CustomerID, EmployeeID, OrderDate, Payment, Comments)
VALUES
	(1000, 1004, '2022-01-10', 'check', null),
	(1002, 1006, '2022-02-02', 'cash', null),
	(1003, 1009, '2022-07-22', 'card', null),
	(1005, 1010, '2022-10-11', 'cash', null),
	(1008, 1009, '2022-06-09', 'card', null),
	(1011, 1006, '2022-03-28', 'cash', null),
	(1013, 1004, '2022-05-13', 'card', null),
	(1014, 1010, '2022-09-04', 'check', null),
	(1017, 1004, '2022-04-25', 'cash', null),
	(1018, 1010, '2022-08-06', 'card', null),
	(1003, 1004, '2022-01-31', 'credit', null),
	(1013, 1006, '2022-02-06', 'cash', null),
	(1008, 1009, '2022-03-11', 'debit', null),
	(1011, 1010, '2022-04-05', 'cash', null),
	(1018, 1009, '2022-05-09', 'credit', null),
	(1013, 1006, '2022-06-16', 'debit', null),
	(1005, 1004, '2022-07-12', 'debit', null),
	(1013, 1010, '2022-08-16', 'credit', null),
	(1014, 1004, '2022-09-25', 'debit', null),
	(1017, 1010, '2022-10-16', 'cash', null);				  


--Order_Services (Wayne)
--Wayne created the Order_services table
--Table has PK constraint on OrderID and ServiceID (Composite Key) from CustomerOrder and Services table
--Has FK constraint on EmployeeID from PERSON table
--Has check constraint on both price and quantity in Order_Services table to be > 0
	create table order_services(
	OrderID			int		not null,		  --PKFK
	ServiceID		int		not null,		  --PKFK
	EmployeeID		int		not null,		  --FK
	Price			decimal(9,2)	not null,		--Check
	Quantity		int		not null,		--Check
	Comments		varchar(250) 	null,
	
	--Constraints
	--Primary Key
	constraint orderservices_orderservicesid_pk primary key(OrderID, ServiceID),
	--Foreign Key
	constraint orderservices_employeeid_fk foreign key(EmployeeID) references person(PeopleID)
		on update cascade
		on delete no action,
		--Check
	constraint orderservices_price_ck check(price > 0),
	constraint orderservices_quantity_ck check(quantity > 0)
);

-- order_services Data (Hailey)
--Hailey inserted data into the Order_Services table
--Columns entered are OrderID, ServiceId, EmployeeID, Price, Quantity, and Comments
insert into order_services  
	(OrderID, ServiceId, EmployeeID, Price, Quantity, Comments)

VALUES
	(5000, 3005, 1004, 44.00, '1', null),
	(5001, 3003, 1006, 80.00, '1', null),
	(5002, 3009, 1009, 20.00, '2', null),
	(5003, 3004, 1010, 67.00, '1', null),
	(5004, 3000, 1009, 15.00, '3', null),
	(5005, 3002, 1006, 40.00, '1', null),
	(5006, 3008, 1004, 12.00, '2', null),
	(5007, 3006, 1010, 75.00, '1', null),
	(5008, 3001, 1004, 70.00, '1', null),
	(5009, 3007, 1010, 75.00, '2', null);

-- Order_Products (Wayne)
--Wayne Created the order_products table
--Table has PK constraint on OrderID and ProductID (Composite Key)
--Has FK constraint on EmployeeID in PERSON table
--Has two check constraints, one on Price and the other is on Quantity from Order_Products table ensuring 
--the columns are more than 0
create table order_products(
	OrderID			int		not null,				--PKFK
	ProductID		int		not null,				--PKFK
	EmployeeID		int		not null,				--FK
	Price			decimal(9,2)	not null,		--Check
	Quantity		int		not null				--Check

	--Constraints
	--Primary Key
	constraint orderproducts_orderproductsid_pk primary key(OrderID, ProductID),
	--Foreign Key
	constraint orderproducts_employeeid_fk foreign key(EmployeeID) references person(PeopleID)
		on update cascade
		on delete no action,
	--Check
	constraint orderproducts_price_ck check(price > 0),
	constraint orderproducts_quantity_ck check(quantity > 0)
);
--orderproducts data (NOAH)
--Noah inserted data into the Order_products table
--Columns entered are OrderID, ProductID, EmployeeID, Price, and Quantity
insert into order_products
	(OrderID, ProductID, EmployeeID, Price, Quantity)
VALUES
	(5010, 4002, 1004, 10.00, 2),
	(5011, 4000, 1006, 9.50, 1),
	(5012, 4006, 1009, 10.00,1),
	(5013, 4008, 1010, 15.00, 3),
	(5014, 4003, 1009, 4.50, 1), 
	(5015, 4005, 1006, 20.00, 2),
	(5016, 4000, 1006, 10.00, 1),
	(5017, 4001, 1009, 15.00, 1),
	(5018, 4008, 1010, 4.00, 1),
	(5019, 4007, 1006, 10.00, 1);						 
select *
from person
