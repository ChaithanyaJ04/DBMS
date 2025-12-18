create database bank;
use bank;
create table Branch (branch_name varchar(20) primary key,branch_city varchar(20),assets int(10) );
create table BankAccount(ACCNO int(10) primary key,branch_name varchar(20),balance int(20) ,foreign key(branch_name) references Branch(branch_name));
create table BankCustomer(customer_name varchar(20) primary key, customer_street varchar(20),customer_city varchar(20));
create table Depositor(customer_name varchar(20),ACCNO int(20),primary key(customer_name,ACCNO), foreign key(customer_name) references BankCustomer(customer_name),foreign key(ACCNO) references BankAccount(ACCNO));
create table Loan(loan_number int(20) primary key,branch_name varchar(30),amount int(20) ,foreign key(branch_name) references Branch(branch_name));
INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);
select*from Branch;

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParliamentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6,'SBI_ShivajiRoad',4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParlimentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);
select*from BankAccount;

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');
select*from BankCustomer;

INSERT INTO Depositor VALUES
('Avinash',1),
('Dinesh',2),
('Nikil',4),
('Ravi',5),
('Avinash',8),
('Nikil',9),
('Dinesh',10),
('Nikil',11);
select*from Depositor;

INSERT INTO Loan VALUES
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),
(5,'SBI_Jantarmantar',5000);
select*from Loan;

select d.customer_name
From Depositor d
Join BankAccount b on d.ACCNO=b.ACCNO
where b.branch_name='SBI_ResidencyRoad'
group by d.customer_name
having count(*)>=2;


Select * From LOAN Order BY Amount DESC;

(SELECT CUSTOMER_NAME FROM DEPOSITOR ) UNION (SELECT CUSTOMER_NAME FROM
BankCustomer);

CREATE VIEW BRANCH_TOTAL_LOAN (BRANCH_NAME, TOTAL_LOAN) AS SELECT
BRANCH_NAME, SUM(AMOUNT) FROM LOAN GROUP BY BRANCH_NAME;
select*from BRANCH_TOTAL_LOAN;

delete from BankAccount
where branch_name in(Select branch_name
from Branch
where branch_city='Bombay');
select*from BankAccount;

select branch_name,assets/100000 as
"assets in lakhs"
from Branch;