CREATE DATABASE KroffleZ
GO
USE KroffleZ
GO
CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(75) NOT NULL,
	CustomerPhoneNumber VARCHAR(15) NOT NULL,
	CustomerGender VARCHAR(6) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerAddress VARCHAR(100) NOT NULL,
	CustomerEmail VARCHAR(50) NOT NULL
)
CREATE TABLE MsStaff(
	StaffID CHAR(5) PRIMARY KEY,
	StaffName VARCHAR(75) NOT NULL,
	StaffPhoneNumber VARCHAR(15) NOT NULL,
	StaffGender VARCHAR(6) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	StaffSalary INT NOT NULL
)
CREATE TABLE MsTopping(
	ToppingID CHAR(5) PRIMARY KEY,
	ToppingName VARCHAR(75) NOT NULL
)
CREATE TABLE MsCroffle(
	CroffleID CHAR(5) PRIMARY KEY,
	ToppingID CHAR(5) REFERENCES MsTopping ON UPDATE CASCADE ON DELETE CASCADE,
	CroffleName VARCHAR(75) NOT NULL,
	CrofflePrice INT NOT NULL,
	CroffleStock INT NOT NULL
)
CREATE TABLE TransactionHeader(
	TransactionID CHAR(5) PRIMARY KEY,
	CustomerID CHAR(5) REFERENCES MsCustomer ON UPDATE CASCADE ON DELETE CASCADE,
	StaffID CHAR(5) REFERENCES MsStaff ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL
)
CREATE TABLE TransactionDetail(
	TransactionID CHAR(5) REFERENCES TransactionHeader ON UPDATE CASCADE ON DELETE CASCADE,
	CroffleID CHAR(5) REFERENCES MsCroffle ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL,
	PRIMARY KEY (TransactionID, CroffleID)
)
INSERT INTO MsCustomer
VALUES ('CU001', 'Silver Nevada', '08291031921', 'Female', '2000-01-12', '8646 N. Lyme Lane Bountiful, UT 84010', 'silver@mail.com'),
('CU002', 'Gretta Joanne', '08372048291', 'Female', '2001-02-25', '557 Bayport Drive Belleville, NJ 07109', 'gretta@mail.com'),
('CU003', 'Eliott Randolf', '072293019134', 'Male', '2002-03-23', '98 Westport St.Butte, MT 59701', 'eliott@mail.com'),
('CU004', 'Mayson Gunner', '093001183643', 'Male', '2002-04-01', '7439 Country Club Street Athens, GA 30605', 'mayson@email.com'),
('CU005', 'Madilynn Lallie', '08201040932', 'Female', '2003-05-10', '806 Taylor Lane Suite 1 Skokie, IL 60076', 'madilynn@email.com'),
('CU006', 'Melantha Divina', '07492947294', 'Female', '2004-06-18', '55 Briarwood Dr.Thibodaux, LA 70301', 'melantha@email.com'),
('CU007', 'Jonathon Fraser', '034529103831', 'Male', '2004-07-20', '588 Nichols Rd.Nazareth, PA 18064', 'jonathon@email.co.id'),
('CU008', 'Dudley Raleigh', '0738203918398', 'Male', '2002-08-07', '17 Harrison Drive Culpeper, VA 22701', 'dudley@email.co.id'),
('CU009', 'Kasandra Blossom', '0845234867886', 'Female', '2005-09-07', '47 Temple Street Kingston, NY 12401', 'kasandra@gmail.co.id'),
('CU010', 'Lysette Julianna', '0766454254790', 'Female', '2006-10-13', '40 Gregory Lane Mentor, OH 44060', 'lysette@gmail.co.id')
INSERT INTO MsStaff
VALUES ('ST001', 'Alannis Pamila', '083927371932', 'Female', '2000-01-12', '320 S. Lancaster Street Silver Spring, MD 20901', 750),
('ST002', 'Natasha Alyson', '0628193010371', 'Female', '2001-02-22', '8 Golf St.Chevy Chase, MD 20815', 1000), 
('ST003', 'Lindsie Marlee', '0526830281927', 'Female', '2002-03-10', '524 Rose Street Ithaca, NY 14850', 500), 
('ST004', 'Zac Ashton', '0637183919031', 'Male', '2002-04-24', '435 Court Street Lapeer, MI 48446', 1250), 
('ST005', 'Jerald Leslie', '07416381920', 'Male', '2003-05-17', '40 Washington Street Hamden, CT 06514', 1500),
('ST006', 'Bill Quincey', '037738189391', 'Male', '2004-01-12', '5 3rd St.East Lansing, MI 48823', 1750),
('ST007', 'Aaron Melvyn', '037647166213', 'Male', '2004-02-22', '8428 Bay Meadows Ave. Elizabethtown, PA 17022', 2000), 
('ST008', 'Marcus Aldous', '03761732818', 'Male', '2005-03-10', '197 N. Marconi Street Leland, NC 28451', 1800), 
('ST009', 'Vianne Alisya', '08393971313', 'Female', '2006-04-24', '6 Rockcrest St.Graham, NC 27253', 1200), 
('ST010', 'Arienne Aubree', '083645813891', 'Female', '2006-05-17', '93 Hilltop St.Gwynn Oak, MD 21207', 2100)
INSERT INTO MsTopping
VALUES ('TO001', 'Almond Maple'), 
('TO002', 'Coco Crunch'), 
('TO003', 'Strawberry Jam'), 
('TO004', 'Strawberry Cream Cheese'),
('TO005', 'Blueberry Cream Cheese')
INSERT INTO MsCroffle
VALUES ('CR001', 'TO003', 'Mini Strawberry Croffle', 75, 75), 
('CR002', 'TO001', 'Icing Almond Sugar', 175, 100),
('CR003', 'TO002', 'Coco Croffle', 100, 60),
('CR004', 'TO005', 'Berry Blueberry Croffle', 225, 125),
('CR005', 'TO004', 'Berry Cheeze Croffle', 200, 100),
('CR006', 'TO003', 'Pinky Icing Croffle', 110, 50),
('CR007', 'TO002', 'Crunchy Croffle', 250, 123),
('CR008', 'TO004', 'Pinky Cheese Croffle', 275, 80),
('CR009', 'TO001', 'Royal Croffle', 300, 25),
('CR010', 'TO005', 'Blueming Croffle', 210, 40)
INSERT INTO TransactionHeader
VALUES ('TR001', 'CU001', 'ST001', '2021-11-01'),
('TR002', 'CU002', 'ST002', '2021-10-11'),
('TR003', 'CU003', 'ST002', '2021-09-18'),
('TR004', 'CU004', 'ST004', '2021-08-06'),
('TR005', 'CU005', 'ST005', '2021-08-20'),
('TR006', 'CU006', 'ST006', '2021-01-21'),
('TR007', 'CU007', 'ST007', '2021-02-25'),
('TR008', 'CU008', 'ST008', '2021-03-10'),
('TR009', 'CU009', 'ST009', '2021-04-05'),
('TR010', 'CU010', 'ST010', '2021-05-25')
INSERT INTO TransactionDetail
VALUES 
('TR001', 'CR001', 10),
('TR001', 'CR002', 5),
('TR001', 'CR009', 10),
('TR001', 'CR010', 5),
('TR002', 'CR001', 6),
('TR002', 'CR004', 8),
('TR002', 'CR005', 11),
('TR002', 'CR006', 7),
('TR003', 'CR001', 2),
('TR003', 'CR002', 4),
('TR004', 'CR001', 12),
('TR004', 'CR005', 4),
('TR004', 'CR007', 5),
('TR004', 'CR008', 8),
('TR004', 'CR009', 2),
('TR004', 'CR010', 10),
('TR005', 'CR001', 6),
('TR005', 'CR008', 6),
('TR006', 'CR006', 8),
('TR006', 'CR001', 15),
('TR006', 'CR002', 6),
('TR007', 'CR007', 5),
('TR007', 'CR003', 2),
('TR007', 'CR004', 9),
('TR008', 'CR001', 12),
('TR008', 'CR004', 2),
('TR008', 'CR007', 7),
('TR008', 'CR010', 9),
('TR009', 'CR001', 4),
('TR009', 'CR004', 10),
('TR009', 'CR005', 6),
('TR010', 'CR001', 10),
('TR010', 'CR005', 6),
('TR010', 'CR006', 11),
('TR010', 'CR010', 14)
EXEC sp_MSforeachtable 'SELECT * FROM ?'

--JAWABAN
--2440005031 / Christian Joseph Radithya

--1
SELECT CustomerName, CustomerGender, CustomerEmail
FROM MsCustomer
WHERE CustomerName LIKE 'M%'

--2
SELECT StaffName, TransactionDate
FROM MsStaff ms
JOIN TransactionHeader th ON ms.StaffID = th.StaffID
WHERE QUARTER(DATENAME(MONTH, TransactionDate) = 1)

--3
SELECT [First Name] = LEFT(CustomerName, CHARINDEX(' ', CustomerName)), [Total Transaction] = COUNT(Quantity)
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN MsStaff ms ON th.StaffID = ms.StaffID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
WHERE CustomerGender = 'Male'
GROUP BY CustomerName


--4
SELECT ToppingName, [Total Transaction] = COUNT(td.Quantity), [Average Croffle Price] = AVG(mcr.CrofflePrice)
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN MsCroffle mcr ON td.CroffleID = mcr.CroffleID
JOIN MsTopping mt ON mcr.ToppingID = mt.ToppingID
WHERE ToppingName LIKE '%berry%'
GROUP BY ToppingName
HAVING AVG(mcr.CrofflePrice) > 200
UNION
SELECT ToppingName, [Total Transaction] = COUNT(td.Quantity), [Average Croffle Price] = AVG(mcr.CrofflePrice)
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN MsCroffle mcr ON td.CroffleID = mcr.CroffleID
JOIN MsTopping mt ON mcr.ToppingID = mt.ToppingID
WHERE ToppingName LIKE '%pinky%'
GROUP BY ToppingName
HAVING AVG(mcr.CrofflePrice) > 200

--5
SELECT [Customer ID] = REPLACE(mc.CustomerID, 'CU', 'Customer '), CustomerName, CustomerGender, CustomerGender, CustomerEmail
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN MsCroffle mcr ON td.CroffleID = mcr.CroffleID
WHERE mcr.CroffleStock > 100 AND CroffleName LIKE '% % Croffle'

--6
SELECT CustomerName, [Phone Number] = STUFF(CustomerPhoneNumber, CHARINDEX('0', CustomerPhoneNumber), CHARINDEX('0', CustomerPhoneNumber), '+62')
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN MsStaff ms ON th.StaffID = ms.StaffID,
(SELECT AVG(StaffSalary) AS AverageStaffSalary
FROM MsCustomer mc
JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
JOIN MsStaff ms ON th.StaffID = ms.StaffID
) q
WHERE StaffSalary > q.AverageStaffSalary AND DAY(TransactionDate) = 25

--7
BEGIN TRAN
GO
CREATE VIEW [View Strawberry Croffle] AS
SELECT mcr.CroffleName, mcr.CrofflePrice, [Stock] = CAST(mcr.CroffleStock AS VARCHAR(10)), ' croffle(s)'  , mt.ToppingName
FROM MsCroffle mcr
JOIN MsTopping mt ON mcr.ToppingID = mt.ToppingID
WHERE mt.ToppingName LIKE 'Strawberry%' 

SELECT * FROM [View Strawberry Croffle]
ROLLBACK
DROP VIEW [View Strawberry Croffle]
CONCAT(CroffleStock ,' croffle(s)')

--8
CREATE VIEW [Total Purchase Croffle] AS
SELECT ToppingName, [Total Purchase] = CONCAT(SUM(Quantity), ' croffle(s)')
FROM MsTopping mt
JOIN MsCroffle mc ON mt.ToppingID = mc.ToppingID
JOIN TransactionDetail td ON mc.CroffleID = td.CroffleID
WHERE ToppingName LIKE '%c%' AND CrofflePrice > 225
GROUP BY ToppingName
SELECT * FROM [Total Purchase Croffle]

--9
BEGIN TRAN 
AlTER TABLE MsStaff
ADD StaffEmail VARCHAR(50)

SELECT * FROM MsStaff
COMMIT

ALTER TABLE MsStaff
ADD CONSTRAINT CE CHECK (StaffEmail LIKE '%krofflez.com')

--10
BEGIN TRAN
DELETE MsCustomer
FROM MsStaff ms
JOIN TransactionHeader th ON ms.StaffID = th.StaffID
JOIN MsCustomer mc ON th.CustomerID = mc.CustomerID
WHERE StaffSalary > 1000 AND RIGHT(ms.StaffID, 3) % 2 = 0

SELECT * FROM MsCustomer
ROLLBACK
COMMIT








