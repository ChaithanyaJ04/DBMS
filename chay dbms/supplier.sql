create database if not exists Supplier;
use Supplier;

create table suppliers(sid integer(5) primary key, sname varchar(20), city
varchar(20));
desc suppliers;

create table parts(pid integer(5) primary key, pname varchar(20), color varchar(10));
desc parts;

create table catalog(sid int(5), pid int(5), foreign key(sid)
references SUPPLIERS(sid), foreign key(pid) references PARTS(pid), cost
float(6), primary key(sid, pid));
desc catalog;

insert into suppliers values
(10001, 'Acme Widget','Bangalore'),
(10002, 'Johns','Kolkata'),
(10003, 'Vimal','Mumbai'),
(10004, 'Reliance','Delhi'),
(10005, 'Mahindra','Mumbai');
select*from suppliers;
commit;

insert into parts values
(20001,'Book','Red'),
(20002,'Pen','Red'),
(20003,'Pencil','Green'),
(20004,'Mobile','Green'),
(20005,'Charger','Black');
select*from parts;

insert into catalog values
(10001, 20001,10),
(10001, 20002,10),
(10001, 20003,30),
(10001, 20004,10),
(10001, 20005,10),
(10002, 20001,10),
(10002, 20002,20),
(10003, 20003,30),
(10004, 20003,40);
select*from catalog;


SELECT DISTINCT P.pname
FROM Parts P, Catalog C
WHERE P.pid = C.pid;


SELECT S.sname
FROM suppliers S
WHERE
(( SELECT count(P.pid)
FROM parts P ) =
( SELECT count(C.pid)
FROM catalog C
WHERE C.sid = S.sid ));


SELECT S.sname
FROM suppliers S
WHERE
(( SELECT count(P.pid)
FROM Parts P where color='Red') =
( SELECT count(C.pid)
FROM catalog C, parts P
WHERE C.sid = S.sid AND
C.pid = P.pid AND P.color = 'Red'));


SELECT P.pname
FROM parts P, catalog C, suppliers S
WHERE P.pid = C.pid AND C.sid = S.sid
AND S.sname = 'Acme Widget'
AND NOT EXISTS ( SELECT *
FROM catalog C1, suppliers S1
WHERE P.pid = C1.pid AND C1.sid = S1.sid AND
S1.sname!='Acme Widget');

SELECT DISTINCT C.sid FROM catalog C
WHERE C.cost > ( SELECT AVG (C1.cost)
FROM catalog C1
WHERE C1.pid = C.pid );


SELECT P.pid, S.sname
FROM parts P, suppliers S, catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT max(C1.cost) 
FROM catalog C1
WHERE C1.pid = P.pid);




select s.sname
from suppliers s,catalog c
where s.sid=c.sid and cost =(select max(cost) 
                              from catalog );

select s.sname
from suppliers s
where s.sid not in (select distinct c.sid
                    from catalog c join parts p
                    on p.pid=c.pid 
                    where p.color="Red");
                    
select s.sid,s.sname ,sum(c.cost) as total_cost
from suppliers s join catalog c
on s.sid=c.sid 
group by s.sid,s.sname;

select sid
from catalog
where cost<20
group by sid
having count(*)>=2;

select c.pid,c.sid,c.cost
from catalog c
where c.cost=(select min(c2.cost)
              from catalog c2
              where c2.pid=c.pid);
 
 CREATE VIEW SupplierPartCount AS 
 SELECT S.SID, S.SName, COUNT(C.PID) AS TotalParts
 FROM Suppliers S LEFT JOIN Catalog C 
 ON S.SID = C.SID GROUP BY S.SID, S.SName; 
 select *from SupplierPartCount;
 
create view MaxCostSupplierPart as 
select c.sid,c.pid,c.cost
from catalog c
where c.cost=(select max(c2.cost)
               from catalog c2
               where c2.pid=c.pid);
select* from MaxCostSupplierPart;


DELIMITER $$
CREATE TRIGGER Check_Cost
BEFORE INSERT ON Catalog
FOR EACH ROW
BEGIN
    IF NEW.Cost < 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cost cannot be below 1';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
Create Trigger Default_cost
before insert on catalog
for each row
begin
if NEW.cost=NULL then
set NEW.cost=1;
end if;
end$$
DELIMITER ;







