show databases;
create database IF NOT exists insurance;
use insurance;
create table person (driver_id varchar(10), name varchar(20), address varchar(30), primary key (driver_id));
insert into person (driver_id,name,address) values
 ('A01','RICHARD', 'SRINIVAS NAGAR'),
('A02','PRADEEP', 'RAJAJINAGAR'),
('A03','SMITH','ASHOK NAGAR'),
('A04','VENU', 'N R COLONY'),
('A05','JHON', 'HANUMANTH NAGAR');
select*from person;

create table car (reg_num varchar(10), model varchar(10), year int, primary key(reg_num));
insert into car values ('KA052250','INDICA',1990),
('KA031181','LANCER',1957),
('KA095477','TOYOTA',1998),
('KA053408','HONDA',2008),
('KA041702','AUDI',2005);
select*from car;

CREATE TABLE accident (report_num INT PRIMARY KEY, accident_date varchar(30) , location VARCHAR(20));
INSERT INTO accident (report_num, accident_date, location) VALUES
(11, '01-JAN-03', 'MYSORE ROAD'),
(12,'02-FEB-04', 'SOUTH END CIRCLE'),
(13,'21-JAN-03', 'BULL TEMPLE ROAD'),
(14,'17-FEB-08', 'MYSORE ROAD'),
(15,'04-MAR-05', 'KANAKPURA ROAD');
select*from accident;

CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num)
);
INSERT INTO owns (driver_id, reg_num) VALUES
('A01', 'KA052250'),   
('A02', 'KA053408'),  
('A03', 'KA031181'),  
('A04', 'KA095477'),   
('A05', 'KA041702');   
SELECT*from owns;

CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num),
    FOREIGN KEY (report_num) REFERENCES accident(report_num)
);
INSERT INTO participated (driver_id, reg_num, report_num, damage_amount) VALUES
('A01', 'KA052250', 11, 10000), 
('A02', 'KA053408', 12, 50000),  
('A03', 'KA095477', 13, 25000),  
('A04', 'KA031181', 14, 30000),
('A05', 'KA041702', 15, 50000);  
SELECT*from participated;

update participated set damage_amount=25000
 where reg_num="KA053408" AND report_num=12;
 
 select count(distinct driver_id)
 from participated a join accident b 
 where a.report_num=b.report_num & b.accident_date like'%08';

 
 Select *
 from participated
 order by damage_amount DESC;
 
 select avg(damage_amount)
 from participated;
 
 select*from participated; 
 
delete from participated
where damage_amount < (select avg(damage_amount)
from (select avg(damage_amount) as avg_amount from participated)as a);
 
 select name
 from person p join participated p1
 where p.driver_id=p1.driver_id and damage_amount > (select avg(damage_amount)
 from participated);
 
select max(damage_amount)
from participated;
 
 

 