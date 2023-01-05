use pizza;
go
select orderKey
from customerorder
where orderdate in ('2020-12-15', '2021-08-15', '2022-09-05'); 