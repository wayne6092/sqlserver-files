--create database test;
--go
--use test;
--go
create table test_table (
testid		int,
testname	char(15));

insert into test_table
(testid, testname)
values
(101, 'Test Data');

select *
from test_table

