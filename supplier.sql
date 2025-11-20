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