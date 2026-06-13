
-- FRAUD DETECTION IN BANKING TRANSACTIONS

CREATE DATABASE FraudDetectionDB;
USE FraudDetectionDB;

CREATE TABLE Customers(
 customer_id INT PRIMARY KEY,
 customer_name VARCHAR(100) NOT NULL,
 email VARCHAR(120) UNIQUE NOT NULL,
 phone VARCHAR(15) UNIQUE NOT NULL,
 city VARCHAR(50) NOT NULL,
 created_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Branches(
 branch_id INT PRIMARY KEY,
 branch_name VARCHAR(100) UNIQUE NOT NULL,
 city VARCHAR(50)
);

CREATE TABLE Accounts(
 account_id INT PRIMARY KEY,
 customer_id INT NOT NULL,
 branch_id INT NOT NULL,
 account_type VARCHAR(20) CHECK(account_type IN ('Savings','Current')),
 balance DECIMAL(12,2) CHECK(balance>=0),
 status VARCHAR(20) DEFAULT 'Active',
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
 FOREIGN KEY(branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE Locations(
 location_id INT PRIMARY KEY,
 city VARCHAR(50) UNIQUE
);

CREATE TABLE Transactions(
 transaction_id INT PRIMARY KEY,
 account_id INT NOT NULL,
 location_id INT,
 amount DECIMAL(12,2) CHECK(amount>0),
 transaction_type VARCHAR(30),
 transaction_date DATE,
 FOREIGN KEY(account_id) REFERENCES Accounts(account_id),
 FOREIGN KEY(location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Cards(
 card_id INT PRIMARY KEY,
 account_id INT UNIQUE,
 card_type VARCHAR(20),
 FOREIGN KEY(account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Devices(
 device_id INT PRIMARY KEY,
 customer_id INT,
 device_name VARCHAR(50),
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Login_History(
 login_id INT PRIMARY KEY,
 customer_id INT,
 login_status VARCHAR(20),
 login_time DATETIME,
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Fraud_Alerts(
 alert_id INT PRIMARY KEY,
 transaction_id INT,
 risk_level VARCHAR(20),
 created_date DATE,
 FOREIGN KEY(transaction_id) REFERENCES Transactions(transaction_id)
);

CREATE TABLE Risk_Score(
 score_id INT PRIMARY KEY,
 customer_id INT UNIQUE,
 score INT CHECK(score BETWEEN 1 AND 100),
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Employees(
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(100),
 branch_id INT,
 FOREIGN KEY(branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE Investigation(
 investigation_id INT PRIMARY KEY,
 alert_id INT,
 employee_id INT,
 result VARCHAR(50),
 FOREIGN KEY(alert_id) REFERENCES Fraud_Alerts(alert_id),
 FOREIGN KEY(employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Loans(
 loan_id INT PRIMARY KEY,
 customer_id INT,
 loan_amount DECIMAL(12,2),
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Notifications(
 notification_id INT PRIMARY KEY,
 customer_id INT,
 message VARCHAR(150),
 FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Audit_Log(
 log_id INT PRIMARY KEY,
 table_name VARCHAR(50),
 action_type VARCHAR(20),
 changed_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Branches VALUES
(1,'Branch_1','Chennai'),(2,'Branch_2','Coimbatore'),(3,'Branch_3','Madurai'),(4,'Branch_4','Salem'),(5,'Branch_5','Trichy'),(6,'Branch_6','Bengaluru'),(7,'Branch_7','Hyderabad'),(8,'Branch_8','Pune'),(9,'Branch_9','Mumbai'),(10,'Branch_10','Delhi');

INSERT INTO Locations VALUES
(1,'Chennai'),(2,'Coimbatore'),(3,'Madurai'),(4,'Salem'),(5,'Trichy'),(6,'Bengaluru'),(7,'Hyderabad'),(8,'Pune'),(9,'Mumbai'),(10,'Delhi');

INSERT INTO Customers VALUES
(1,'Pragathi','pragathi1@gmail.com','9100000001','Madurai','2026-01-02'),
(2,'Arun','arun2@gmail.com','9100000002','Coimbatore','2026-01-03'),
(3,'Karthik','karthik3@outlook.com','9100000003','Delhi','2026-01-04'),
(4,'Meena','meena4@yahoo.com','9100000004','Mumbai','2026-01-05'),
(5,'Divya','divya5@outlook.com','9100000005','Trichy','2026-01-06'),
(6,'Rahul','rahul6@gmail.com','9100000006','Mumbai','2026-01-07'),
(7,'Sneha','sneha7@outlook.com','9100000007','Trichy','2026-01-08'),
(8,'Priya','priya8@outlook.com','9100000008','Mumbai','2026-01-09'),
(9,'Vignesh','vignesh9@yahoo.com','9100000009','Salem','2026-01-10'),
(10,'Anitha','anitha10@yahoo.com','9100000010','Salem','2026-01-11'),
(11,'Surya','surya11@yahoo.com','9100000011','Coimbatore','2026-01-12'),
(12,'Nisha','nisha12@gmail.com','9100000012','Trichy','2026-01-13'),
(13,'Harish','harish13@outlook.com','9100000013','Coimbatore','2026-01-14'),
(14,'Keerthana','keerthana14@yahoo.com','9100000014','Bengaluru','2026-01-15'),
(15,'Rohit','rohit15@outlook.com','9100000015','Delhi','2026-01-16'),
(16,'Deepika','deepika16@gmail.com','9100000016','Hyderabad','2026-01-17'),
(17,'Ajay','ajay17@outlook.com','9100000017','Bengaluru','2026-01-18'),
(18,'Pooja','pooja18@yahoo.com','9100000018','Chennai','2026-01-19'),
(19,'Varun','varun19@gmail.com','9100000019','Salem','2026-01-20'),
(20,'Lakshmi','lakshmi20@gmail.com','9100000020','Trichy','2026-01-21'),
(21,'Abinaya','abinaya21@outlook.com','9100000021','Chennai','2026-01-22'),
(22,'Sanjay','sanjay22@outlook.com','9100000022','Bengaluru','2026-01-23'),
(23,'Kavin','kavin23@yahoo.com','9100000023','Salem','2026-01-24'),
(24,'Nandhini','nandhini24@outlook.com','9100000024','Chennai','2026-01-25'),
(25,'Vijay','vijay25@outlook.com','9100000025','Hyderabad','2026-01-26'),
(26,'Swetha','swetha26@outlook.com','9100000026','Bengaluru','2026-01-27'),
(27,'Ramesh','ramesh27@outlook.com','9100000027','Pune','2026-01-28'),
(28,'Aarthi','aarthi28@outlook.com','9100000028','Delhi','2026-01-01'),
(29,'Bharath','bharath29@outlook.com','9100000029','Delhi','2026-01-02'),
(30,'Dinesh','dinesh30@outlook.com','9100000030','Mumbai','2026-01-03'),
(31,'Gowtham','gowtham31@gmail.com','9100000031','Salem','2026-01-04'),
(32,'Ishwarya','ishwarya32@gmail.com','9100000032','Trichy','2026-01-05'),
(33,'Kishore','kishore33@yahoo.com','9100000033','Hyderabad','2026-01-06'),
(34,'Lavanya','lavanya34@gmail.com','9100000034','Salem','2026-01-07'),
(35,'Mohan','mohan35@outlook.com','9100000035','Bengaluru','2026-01-08'),
(36,'Neha','neha36@gmail.com','9100000036','Delhi','2026-01-09'),
(37,'Praveen','praveen37@gmail.com','9100000037','Bengaluru','2026-01-10'),
(38,'Rekha','rekha38@gmail.com','9100000038','Hyderabad','2026-01-11'),
(39,'Saravanan','saravanan39@yahoo.com','9100000039','Hyderabad','2026-01-12'),
(40,'Uma','uma40@gmail.com','9100000040','Hyderabad','2026-01-13'),
(41,'Yogesh','yogesh41@gmail.com','9100000041','Madurai','2026-01-14'),
(42,'Janani','janani42@yahoo.com','9100000042','Coimbatore','2026-01-15'),
(43,'Manoj','manoj43@gmail.com','9100000043','Coimbatore','2026-01-16'),
(44,'Preethi','preethi44@yahoo.com','9100000044','Delhi','2026-01-17'),
(45,'Akash','akash45@yahoo.com','9100000045','Pune','2026-01-18'),
(46,'Ritika','ritika46@outlook.com','9100000046','Delhi','2026-01-19'),
(47,'Sathish','sathish47@outlook.com','9100000047','Mumbai','2026-01-20'),
(48,'Naveen','naveen48@gmail.com','9100000048','Madurai','2026-01-21'),
(49,'Anu','anu49@yahoo.com','9100000049','Coimbatore','2026-01-22'),
(50,'Kavya','kavya50@gmail.com','9100000050','Hyderabad','2026-01-23');

INSERT INTO Accounts VALUES
(1001,1,8,'Savings',145512,'Active'),
(1002,2,4,'Savings',357798,'Active'),
(1003,3,1,'Current',389721,'Active'),
(1004,4,8,'Current',374682,'Active'),
(1005,5,9,'Savings',161810,'Active'),
(1006,6,8,'Current',155403,'Active'),
(1007,7,2,'Savings',147724,'Active'),
(1008,8,2,'Savings',458648,'Active'),
(1009,9,2,'Current',36008,'Active'),
(1010,10,4,'Current',34288,'Active'),
(1011,11,9,'Current',484423,'Active'),
(1012,12,4,'Current',324641,'Active'),
(1013,13,8,'Savings',58959,'Active'),
(1014,14,7,'Current',102224,'Active'),
(1015,15,10,'Savings',126836,'Active'),
(1016,16,7,'Savings',137378,'Active'),
(1017,17,6,'Current',152577,'Active'),
(1018,18,9,'Current',196256,'Active'),
(1019,19,5,'Current',67617,'Active'),
(1020,20,8,'Savings',438359,'Active'),
(1021,21,3,'Current',463542,'Active'),
(1022,22,4,'Savings',101899,'Active'),
(1023,23,1,'Current',44270,'Active'),
(1024,24,10,'Current',232926,'Active'),
(1025,25,9,'Current',254228,'Active'),
(1026,26,10,'Current',83752,'Active'),
(1027,27,7,'Savings',234109,'Active'),
(1028,28,4,'Savings',456234,'Active'),
(1029,29,9,'Current',121586,'Active'),
(1030,30,8,'Current',287941,'Active'),
(1031,31,9,'Savings',359113,'Active'),
(1032,32,2,'Savings',255624,'Active'),
(1033,33,6,'Savings',108446,'Active'),
(1034,34,8,'Savings',297833,'Active'),
(1035,35,2,'Savings',327828,'Active'),
(1036,36,3,'Savings',146152,'Active'),
(1037,37,4,'Current',467458,'Active'),
(1038,38,7,'Savings',162552,'Active'),
(1039,39,5,'Current',230100,'Active'),
(1040,40,8,'Current',205946,'Active'),
(1041,41,8,'Savings',427817,'Active'),
(1042,42,1,'Savings',340202,'Active'),
(1043,43,1,'Savings',63747,'Active'),
(1044,44,10,'Current',418825,'Active'),
(1045,45,8,'Current',386540,'Active'),
(1046,46,8,'Current',50143,'Active'),
(1047,47,10,'Current',151925,'Active'),
(1048,48,8,'Current',475537,'Active'),
(1049,49,8,'Current',240596,'Active'),
(1050,50,1,'Current',46627,'Active');

INSERT INTO Transactions VALUES
(5001,1048,7,33967,'Card Payment','2026-06-02'),
(5002,1046,8,19401,'Deposit','2026-06-03'),
(5003,1004,5,99680,'Transfer','2026-06-04'),
(5004,1004,2,24773,'Withdrawal','2026-06-05'),
(5005,1044,5,63040,'Card Payment','2026-06-06'),
(5006,1017,3,15096,'Card Payment','2026-06-07'),
(5007,1003,7,41217,'Deposit','2026-06-08'),
(5008,1045,5,79287,'Transfer','2026-06-09'),
(5009,1001,10,82394,'Withdrawal','2026-06-10'),
(5010,1044,1,95384,'Transfer','2026-06-11'),
(5011,1049,9,62329,'Deposit','2026-06-12'),
(5012,1036,6,67418,'Card Payment','2026-06-13'),
(5013,1050,2,99600,'Deposit','2026-06-14'),
(5014,1002,1,83236,'Transfer','2026-06-15'),
(5015,1048,9,79453,'Transfer','2026-06-16'),
(5016,1037,10,4569,'Transfer','2026-06-17'),
(5017,1016,7,93267,'Withdrawal','2026-06-18'),
(5018,1025,9,26666,'Withdrawal','2026-06-19'),
(5019,1049,3,57930,'Deposit','2026-06-20'),
(5020,1028,9,51406,'Withdrawal','2026-06-21'),
(5021,1030,9,19436,'Withdrawal','2026-06-22'),
(5022,1011,2,74537,'Transfer','2026-06-23'),
(5023,1002,8,96063,'Transfer','2026-06-24'),
(5024,1013,3,67818,'Card Payment','2026-06-25'),
(5025,1025,1,9951,'Deposit','2026-06-26'),
(5026,1005,9,20621,'Deposit','2026-06-27'),
(5027,1037,8,68227,'Card Payment','2026-06-28'),
(5028,1017,4,62946,'Card Payment','2026-06-01'),
(5029,1012,8,2612,'Withdrawal','2026-06-02'),
(5030,1029,5,83876,'Withdrawal','2026-06-03'),
(5031,1037,1,16146,'Transfer','2026-06-04'),
(5032,1013,2,77189,'Withdrawal','2026-06-05'),
(5033,1044,3,54180,'Card Payment','2026-06-06'),
(5034,1048,7,57521,'Withdrawal','2026-06-07'),
(5035,1039,7,17806,'Deposit','2026-06-08'),
(5036,1038,5,23281,'Card Payment','2026-06-09'),
(5037,1023,3,59433,'Card Payment','2026-06-10'),
(5038,1008,6,17296,'Withdrawal','2026-06-11'),
(5039,1015,1,32904,'Deposit','2026-06-12'),
(5040,1019,7,90033,'Withdrawal','2026-06-13'),
(5041,1044,5,27415,'Deposit','2026-06-14'),
(5042,1001,8,8814,'Withdrawal','2026-06-15'),
(5043,1009,1,70248,'Withdrawal','2026-06-16'),
(5044,1042,4,52538,'Card Payment','2026-06-17'),
(5045,1039,3,57841,'Deposit','2026-06-18'),
(5046,1026,5,81968,'Card Payment','2026-06-19'),
(5047,1009,9,74290,'Deposit','2026-06-20'),
(5048,1045,5,79093,'Deposit','2026-06-21'),
(5049,1018,6,66781,'Transfer','2026-06-22'),
(5050,1015,3,34467,'Transfer','2026-06-23'),
(5051,1023,10,3481,'Transfer','2026-06-24'),
(5052,1050,3,75315,'Deposit','2026-06-25'),
(5053,1024,4,64434,'Deposit','2026-06-26'),
(5054,1002,1,96977,'Card Payment','2026-06-27'),
(5055,1042,7,87404,'Deposit','2026-06-28'),
(5056,1011,2,24982,'Deposit','2026-06-01'),
(5057,1041,3,51376,'Withdrawal','2026-06-02'),
(5058,1044,8,48604,'Deposit','2026-06-03'),
(5059,1007,5,4863,'Card Payment','2026-06-04'),
(5060,1005,7,21676,'Deposit','2026-06-05'),
(5061,1047,1,52187,'Deposit','2026-06-06'),
(5062,1006,2,73570,'Transfer','2026-06-07'),
(5063,1025,6,52462,'Card Payment','2026-06-08'),
(5064,1043,4,52676,'Withdrawal','2026-06-09'),
(5065,1039,10,91456,'Deposit','2026-06-10'),
(5066,1019,7,66170,'Deposit','2026-06-11'),
(5067,1020,10,38724,'Withdrawal','2026-06-12'),
(5068,1015,9,91927,'Withdrawal','2026-06-13'),
(5069,1049,4,47057,'Transfer','2026-06-14'),
(5070,1002,9,27494,'Withdrawal','2026-06-15'),
(5071,1018,2,81757,'Withdrawal','2026-06-16'),
(5072,1049,1,10385,'Transfer','2026-06-17'),
(5073,1030,3,35462,'Withdrawal','2026-06-18'),
(5074,1048,7,2836,'Transfer','2026-06-19'),
(5075,1023,8,12286,'Withdrawal','2026-06-20'),
(5076,1049,2,68617,'Transfer','2026-06-21'),
(5077,1010,3,77311,'Deposit','2026-06-22'),
(5078,1008,3,10856,'Withdrawal','2026-06-23'),
(5079,1027,2,30992,'Deposit','2026-06-24'),
(5080,1025,6,25223,'Card Payment','2026-06-25'),
(5081,1020,10,36157,'Deposit','2026-06-26'),
(5082,1008,7,55793,'Card Payment','2026-06-27'),
(5083,1006,8,81622,'Deposit','2026-06-28'),
(5084,1009,9,2234,'Deposit','2026-06-01'),
(5085,1040,8,18134,'Deposit','2026-06-02'),
(5086,1037,10,21376,'Withdrawal','2026-06-03'),
(5087,1021,7,93022,'Transfer','2026-06-04'),
(5088,1009,8,3842,'Card Payment','2026-06-05'),
(5089,1028,8,18708,'Deposit','2026-06-06'),
(5090,1046,4,55817,'Deposit','2026-06-07'),
(5091,1028,3,56674,'Transfer','2026-06-08'),
(5092,1018,1,2505,'Transfer','2026-06-09'),
(5093,1034,10,75023,'Transfer','2026-06-10'),
(5094,1008,3,76829,'Transfer','2026-06-11'),
(5095,1010,1,96337,'Withdrawal','2026-06-12'),
(5096,1035,5,61505,'Deposit','2026-06-13'),
(5097,1006,5,85045,'Withdrawal','2026-06-14'),
(5098,1026,5,67768,'Withdrawal','2026-06-15'),
(5099,1012,5,93253,'Withdrawal','2026-06-16'),
(5100,1033,7,96906,'Deposit','2026-06-17'),
(5101,1032,1,96725,'Transfer','2026-06-18'),
(5102,1045,7,17844,'Transfer','2026-06-19'),
(5103,1015,6,71943,'Transfer','2026-06-20'),
(5104,1045,6,85570,'Transfer','2026-06-21'),
(5105,1047,3,69765,'Card Payment','2026-06-22'),
(5106,1013,5,98854,'Withdrawal','2026-06-23'),
(5107,1009,4,32941,'Withdrawal','2026-06-24'),
(5108,1026,4,98134,'Withdrawal','2026-06-25'),
(5109,1046,10,71209,'Deposit','2026-06-26'),
(5110,1029,7,40200,'Deposit','2026-06-27'),
(5111,1016,1,55545,'Transfer','2026-06-28'),
(5112,1042,10,2727,'Deposit','2026-06-01'),
(5113,1007,10,92711,'Withdrawal','2026-06-02'),
(5114,1005,10,41843,'Card Payment','2026-06-03'),
(5115,1008,1,29814,'Deposit','2026-06-04'),
(5116,1046,6,59583,'Transfer','2026-06-05'),
(5117,1024,3,3775,'Card Payment','2026-06-06'),
(5118,1024,4,59004,'Withdrawal','2026-06-07'),
(5119,1049,8,20475,'Deposit','2026-06-08'),
(5120,1015,5,69909,'Deposit','2026-06-09'),
(5121,1036,6,41815,'Deposit','2026-06-10'),
(5122,1016,3,44129,'Withdrawal','2026-06-11'),
(5123,1039,9,58418,'Deposit','2026-06-12'),
(5124,1016,2,60494,'Deposit','2026-06-13'),
(5125,1035,10,94540,'Card Payment','2026-06-14'),
(5126,1032,2,37241,'Transfer','2026-06-15'),
(5127,1041,2,72934,'Transfer','2026-06-16'),
(5128,1044,4,56564,'Card Payment','2026-06-17'),
(5129,1029,6,23734,'Card Payment','2026-06-18'),
(5130,1009,2,3601,'Transfer','2026-06-19'),
(5131,1023,7,10999,'Withdrawal','2026-06-20'),
(5132,1036,7,52535,'Transfer','2026-06-21'),
(5133,1031,5,61737,'Deposit','2026-06-22'),
(5134,1018,4,13850,'Card Payment','2026-06-23'),
(5135,1006,6,1371,'Deposit','2026-06-24'),
(5136,1039,2,25265,'Card Payment','2026-06-25'),
(5137,1007,7,54555,'Transfer','2026-06-26'),
(5138,1014,6,47625,'Deposit','2026-06-27'),
(5139,1028,6,64671,'Transfer','2026-06-28'),
(5140,1049,1,96219,'Transfer','2026-06-01'),
(5141,1027,5,96865,'Transfer','2026-06-02'),
(5142,1025,2,99337,'Transfer','2026-06-03'),
(5143,1049,4,65480,'Card Payment','2026-06-04'),
(5144,1045,7,97065,'Transfer','2026-06-05'),
(5145,1008,4,28573,'Card Payment','2026-06-06'),
(5146,1028,8,88939,'Deposit','2026-06-07'),
(5147,1027,9,88166,'Withdrawal','2026-06-08'),
(5148,1022,3,25199,'Deposit','2026-06-09'),
(5149,1040,5,23418,'Withdrawal','2026-06-10'),
(5150,1010,8,49641,'Card Payment','2026-06-11'),
(5151,1049,1,96315,'Withdrawal','2026-06-12'),
(5152,1002,7,48361,'Transfer','2026-06-13'),
(5153,1022,5,89393,'Card Payment','2026-06-14'),
(5154,1023,10,98507,'Deposit','2026-06-15'),
(5155,1023,7,98042,'Card Payment','2026-06-16'),
(5156,1010,6,61713,'Transfer','2026-06-17'),
(5157,1001,5,64789,'Card Payment','2026-06-18'),
(5158,1039,5,87722,'Card Payment','2026-06-19'),
(5159,1014,6,44614,'Deposit','2026-06-20'),
(5160,1044,8,19997,'Withdrawal','2026-06-21'),
(5161,1043,7,97557,'Deposit','2026-06-22'),
(5162,1050,7,41544,'Deposit','2026-06-23'),
(5163,1038,9,30513,'Card Payment','2026-06-24'),
(5164,1008,4,61841,'Card Payment','2026-06-25'),
(5165,1016,4,11766,'Deposit','2026-06-26'),
(5166,1015,10,46730,'Transfer','2026-06-27'),
(5167,1040,2,99246,'Card Payment','2026-06-28'),
(5168,1025,10,9966,'Transfer','2026-06-01'),
(5169,1033,6,21468,'Withdrawal','2026-06-02'),
(5170,1049,8,82448,'Deposit','2026-06-03'),
(5171,1007,5,94784,'Withdrawal','2026-06-04'),
(5172,1017,6,36816,'Transfer','2026-06-05'),
(5173,1028,6,48531,'Withdrawal','2026-06-06'),
(5174,1037,3,18253,'Card Payment','2026-06-07'),
(5175,1029,3,18844,'Withdrawal','2026-06-08'),
(5176,1030,9,58413,'Transfer','2026-06-09'),
(5177,1047,7,15063,'Card Payment','2026-06-10'),
(5178,1020,1,87704,'Deposit','2026-06-11'),
(5179,1015,4,29726,'Withdrawal','2026-06-12'),
(5180,1015,7,31549,'Deposit','2026-06-13'),
(5181,1010,3,32359,'Card Payment','2026-06-14'),
(5182,1023,3,13381,'Transfer','2026-06-15'),
(5183,1009,5,1256,'Withdrawal','2026-06-16'),
(5184,1008,10,40719,'Deposit','2026-06-17'),
(5185,1017,1,42508,'Withdrawal','2026-06-18'),
(5186,1024,3,24763,'Deposit','2026-06-19'),
(5187,1043,4,13683,'Withdrawal','2026-06-20'),
(5188,1005,8,40769,'Transfer','2026-06-21'),
(5189,1024,1,18071,'Card Payment','2026-06-22'),
(5190,1008,10,20971,'Transfer','2026-06-23'),
(5191,1030,3,85532,'Transfer','2026-06-24'),
(5192,1016,4,62165,'Deposit','2026-06-25'),
(5193,1040,8,61175,'Transfer','2026-06-26'),
(5194,1009,4,85503,'Withdrawal','2026-06-27'),
(5195,1004,3,88990,'Deposit','2026-06-28'),
(5196,1036,7,74295,'Transfer','2026-06-01'),
(5197,1016,10,90456,'Card Payment','2026-06-02'),
(5198,1034,3,1252,'Transfer','2026-06-03'),
(5199,1017,7,7805,'Transfer','2026-06-04'),
(5200,1004,3,91254,'Deposit','2026-06-05');

INSERT INTO Cards VALUES
(1,1001,'Credit'),
(2,1002,'Credit'),
(3,1003,'Credit'),
(4,1004,'Credit'),
(5,1005,'Debit'),
(6,1006,'Debit'),
(7,1007,'Debit'),
(8,1008,'Debit'),
(9,1009,'Credit'),
(10,1010,'Debit'),
(11,1011,'Credit'),
(12,1012,'Debit'),
(13,1013,'Debit'),
(14,1014,'Credit'),
(15,1015,'Debit'),
(16,1016,'Credit'),
(17,1017,'Credit'),
(18,1018,'Credit'),
(19,1019,'Credit'),
(20,1020,'Debit'),
(21,1021,'Debit'),
(22,1022,'Debit'),
(23,1023,'Credit'),
(24,1024,'Credit'),
(25,1025,'Credit'),
(26,1026,'Credit'),
(27,1027,'Credit'),
(28,1028,'Credit'),
(29,1029,'Credit'),
(30,1030,'Debit'),
(31,1031,'Debit'),
(32,1032,'Debit'),
(33,1033,'Debit'),
(34,1034,'Credit'),
(35,1035,'Debit'),
(36,1036,'Debit'),
(37,1037,'Debit'),
(38,1038,'Credit'),
(39,1039,'Debit'),
(40,1040,'Debit'),
(41,1041,'Debit'),
(42,1042,'Credit'),
(43,1043,'Debit'),
(44,1044,'Credit'),
(45,1045,'Debit'),
(46,1046,'Debit'),
(47,1047,'Credit'),
(48,1048,'Credit'),
(49,1049,'Credit'),
(50,1050,'Debit');

INSERT INTO Devices VALUES
(1,1,'Device_1'),
(2,2,'Device_2'),
(3,3,'Device_3'),
(4,4,'Device_4'),
(5,5,'Device_5'),
(6,6,'Device_6'),
(7,7,'Device_7'),
(8,8,'Device_8'),
(9,9,'Device_9'),
(10,10,'Device_10'),
(11,11,'Device_11'),
(12,12,'Device_12'),
(13,13,'Device_13'),
(14,14,'Device_14'),
(15,15,'Device_15'),
(16,16,'Device_16'),
(17,17,'Device_17'),
(18,18,'Device_18'),
(19,19,'Device_19'),
(20,20,'Device_20'),
(21,21,'Device_21'),
(22,22,'Device_22'),
(23,23,'Device_23'),
(24,24,'Device_24'),
(25,25,'Device_25'),
(26,26,'Device_26'),
(27,27,'Device_27'),
(28,28,'Device_28'),
(29,29,'Device_29'),
(30,30,'Device_30'),
(31,31,'Device_31'),
(32,32,'Device_32'),
(33,33,'Device_33'),
(34,34,'Device_34'),
(35,35,'Device_35'),
(36,36,'Device_36'),
(37,37,'Device_37'),
(38,38,'Device_38'),
(39,39,'Device_39'),
(40,40,'Device_40'),
(41,41,'Device_41'),
(42,42,'Device_42'),
(43,43,'Device_43'),
(44,44,'Device_44'),
(45,45,'Device_45'),
(46,46,'Device_46'),
(47,47,'Device_47'),
(48,48,'Device_48'),
(49,49,'Device_49'),
(50,50,'Device_50');

INSERT INTO Login_History VALUES
(1,1,'Success','2026-06-10 10:01:00'),
(2,27,'Failed','2026-06-10 10:02:00'),
(3,25,'Success','2026-06-10 10:03:00'),
(4,44,'Success','2026-06-10 10:04:00'),
(5,7,'Failed','2026-06-10 10:05:00'),
(6,38,'Success','2026-06-10 10:06:00'),
(7,38,'Success','2026-06-10 10:07:00'),
(8,38,'Success','2026-06-10 10:08:00'),
(9,40,'Success','2026-06-10 10:09:00'),
(10,28,'Failed','2026-06-10 10:10:00'),
(11,15,'Failed','2026-06-10 10:11:00'),
(12,11,'Success','2026-06-10 10:12:00'),
(13,14,'Success','2026-06-10 10:13:00'),
(14,42,'Failed','2026-06-10 10:14:00'),
(15,19,'Failed','2026-06-10 10:15:00'),
(16,40,'Failed','2026-06-10 10:16:00'),
(17,31,'Failed','2026-06-10 10:17:00'),
(18,35,'Failed','2026-06-10 10:18:00'),
(19,47,'Failed','2026-06-10 10:19:00'),
(20,41,'Failed','2026-06-10 10:20:00'),
(21,9,'Failed','2026-06-10 10:21:00'),
(22,14,'Success','2026-06-10 10:22:00'),
(23,6,'Success','2026-06-10 10:23:00'),
(24,17,'Failed','2026-06-10 10:24:00'),
(25,46,'Failed','2026-06-10 10:25:00'),
(26,46,'Failed','2026-06-10 10:26:00'),
(27,49,'Success','2026-06-10 10:27:00'),
(28,31,'Success','2026-06-10 10:28:00'),
(29,2,'Failed','2026-06-10 10:29:00'),
(30,29,'Success','2026-06-10 10:30:00'),
(31,1,'Success','2026-06-10 10:31:00'),
(32,16,'Success','2026-06-10 10:32:00'),
(33,46,'Success','2026-06-10 10:33:00'),
(34,11,'Success','2026-06-10 10:34:00'),
(35,13,'Success','2026-06-10 10:35:00'),
(36,31,'Failed','2026-06-10 10:36:00'),
(37,34,'Success','2026-06-10 10:37:00'),
(38,21,'Failed','2026-06-10 10:38:00'),
(39,39,'Failed','2026-06-10 10:39:00'),
(40,46,'Failed','2026-06-10 10:40:00'),
(41,22,'Success','2026-06-10 10:41:00'),
(42,26,'Success','2026-06-10 10:42:00'),
(43,20,'Failed','2026-06-10 10:43:00'),
(44,26,'Failed','2026-06-10 10:44:00'),
(45,37,'Success','2026-06-10 10:45:00'),
(46,6,'Failed','2026-06-10 10:46:00'),
(47,43,'Failed','2026-06-10 10:47:00'),
(48,35,'Success','2026-06-10 10:48:00'),
(49,43,'Success','2026-06-10 10:49:00'),
(50,42,'Failed','2026-06-10 10:50:00'),
(51,8,'Failed','2026-06-10 10:51:00'),
(52,12,'Success','2026-06-10 10:52:00'),
(53,1,'Failed','2026-06-10 10:53:00'),
(54,40,'Failed','2026-06-10 10:54:00'),
(55,33,'Success','2026-06-10 10:55:00'),
(56,17,'Success','2026-06-10 10:56:00'),
(57,15,'Success','2026-06-10 10:57:00'),
(58,1,'Success','2026-06-10 10:58:00'),
(59,11,'Success','2026-06-10 10:59:00'),
(60,26,'Failed','2026-06-10 10:00:00'),
(61,39,'Success','2026-06-10 10:01:00'),
(62,31,'Success','2026-06-10 10:02:00'),
(63,27,'Failed','2026-06-10 10:03:00'),
(64,32,'Success','2026-06-10 10:04:00'),
(65,25,'Success','2026-06-10 10:05:00'),
(66,15,'Failed','2026-06-10 10:06:00'),
(67,45,'Success','2026-06-10 10:07:00'),
(68,11,'Failed','2026-06-10 10:08:00'),
(69,47,'Failed','2026-06-10 10:09:00'),
(70,35,'Success','2026-06-10 10:10:00'),
(71,5,'Failed','2026-06-10 10:11:00'),
(72,30,'Failed','2026-06-10 10:12:00'),
(73,43,'Failed','2026-06-10 10:13:00'),
(74,35,'Failed','2026-06-10 10:14:00'),
(75,11,'Failed','2026-06-10 10:15:00'),
(76,1,'Success','2026-06-10 10:16:00'),
(77,36,'Failed','2026-06-10 10:17:00'),
(78,15,'Failed','2026-06-10 10:18:00'),
(79,31,'Failed','2026-06-10 10:19:00'),
(80,36,'Failed','2026-06-10 10:20:00'),
(81,32,'Success','2026-06-10 10:21:00'),
(82,18,'Failed','2026-06-10 10:22:00'),
(83,15,'Failed','2026-06-10 10:23:00'),
(84,41,'Failed','2026-06-10 10:24:00'),
(85,41,'Success','2026-06-10 10:25:00'),
(86,47,'Failed','2026-06-10 10:26:00'),
(87,46,'Success','2026-06-10 10:27:00'),
(88,3,'Failed','2026-06-10 10:28:00'),
(89,44,'Success','2026-06-10 10:29:00'),
(90,12,'Failed','2026-06-10 10:30:00'),
(91,6,'Success','2026-06-10 10:31:00'),
(92,39,'Success','2026-06-10 10:32:00'),
(93,8,'Failed','2026-06-10 10:33:00'),
(94,31,'Success','2026-06-10 10:34:00'),
(95,20,'Failed','2026-06-10 10:35:00'),
(96,22,'Success','2026-06-10 10:36:00'),
(97,20,'Success','2026-06-10 10:37:00'),
(98,49,'Success','2026-06-10 10:38:00'),
(99,41,'Failed','2026-06-10 10:39:00'),
(100,23,'Failed','2026-06-10 10:40:00');

INSERT INTO Fraud_Alerts VALUES
(1,5001,'Medium','2026-06-02'),
(2,5002,'Low','2026-06-03'),
(3,5003,'Low','2026-06-04'),
(4,5004,'Low','2026-06-05'),
(5,5005,'High','2026-06-06'),
(6,5006,'Low','2026-06-07'),
(7,5007,'Low','2026-06-08'),
(8,5008,'Medium','2026-06-09'),
(9,5009,'Medium','2026-06-10'),
(10,5010,'Medium','2026-06-11'),
(11,5011,'High','2026-06-12'),
(12,5012,'Medium','2026-06-13'),
(13,5013,'Low','2026-06-14'),
(14,5014,'Low','2026-06-15'),
(15,5015,'Medium','2026-06-16'),
(16,5016,'Low','2026-06-17'),
(17,5017,'Medium','2026-06-18'),
(18,5018,'High','2026-06-19'),
(19,5019,'High','2026-06-20'),
(20,5020,'Medium','2026-06-21'),
(21,5021,'Low','2026-06-22'),
(22,5022,'High','2026-06-23'),
(23,5023,'High','2026-06-24'),
(24,5024,'High','2026-06-25'),
(25,5025,'High','2026-06-26'),
(26,5026,'Low','2026-06-27'),
(27,5027,'High','2026-06-28'),
(28,5028,'Medium','2026-06-01'),
(29,5029,'Medium','2026-06-02'),
(30,5030,'High','2026-06-03'),
(31,5031,'Medium','2026-06-04'),
(32,5032,'Low','2026-06-05'),
(33,5033,'Medium','2026-06-06'),
(34,5034,'High','2026-06-07'),
(35,5035,'Low','2026-06-08'),
(36,5036,'High','2026-06-09'),
(37,5037,'Medium','2026-06-10'),
(38,5038,'Low','2026-06-11'),
(39,5039,'Medium','2026-06-12'),
(40,5040,'Medium','2026-06-13'),
(41,5041,'Low','2026-06-14'),
(42,5042,'Low','2026-06-15'),
(43,5043,'High','2026-06-16'),
(44,5044,'High','2026-06-17'),
(45,5045,'Low','2026-06-18'),
(46,5046,'Low','2026-06-19'),
(47,5047,'Medium','2026-06-20'),
(48,5048,'High','2026-06-21'),
(49,5049,'Medium','2026-06-22'),
(50,5050,'Medium','2026-06-23');

INSERT INTO Risk_Score VALUES
(1,1,2),
(2,2,79),
(3,3,98),
(4,4,12),
(5,5,76),
(6,6,94),
(7,7,9),
(8,8,9),
(9,9,24),
(10,10,69),
(11,11,6),
(12,12,33),
(13,13,88),
(14,14,90),
(15,15,38),
(16,16,83),
(17,17,67),
(18,18,85),
(19,19,13),
(20,20,89),
(21,21,44),
(22,22,67),
(23,23,89),
(24,24,56),
(25,25,48),
(26,26,50),
(27,27,58),
(28,28,67),
(29,29,8),
(30,30,58),
(31,31,24),
(32,32,40),
(33,33,32),
(34,34,35),
(35,35,47),
(36,36,24),
(37,37,75),
(38,38,10),
(39,39,38),
(40,40,9),
(41,41,8),
(42,42,13),
(43,43,8),
(44,44,68),
(45,45,23),
(46,46,38),
(47,47,84),
(48,48,86),
(49,49,14),
(50,50,51);

INSERT INTO Employees VALUES
(1,'Employee_1',10),
(2,'Employee_2',2),
(3,'Employee_3',8),
(4,'Employee_4',6),
(5,'Employee_5',5),
(6,'Employee_6',1),
(7,'Employee_7',5),
(8,'Employee_8',9),
(9,'Employee_9',4),
(10,'Employee_10',4),
(11,'Employee_11',9),
(12,'Employee_12',5),
(13,'Employee_13',9),
(14,'Employee_14',8),
(15,'Employee_15',7),
(16,'Employee_16',9),
(17,'Employee_17',6),
(18,'Employee_18',9),
(19,'Employee_19',9),
(20,'Employee_20',1);

INSERT INTO Investigation VALUES
(1,1,8,'Fraud Confirmed'),
(2,2,14,'Open'),
(3,3,1,'Fraud Confirmed'),
(4,4,3,'Open'),
(5,5,15,'Fraud Confirmed'),
(6,6,16,'Resolved'),
(7,7,18,'Open'),
(8,8,11,'Fraud Confirmed'),
(9,9,16,'Open'),
(10,10,12,'Open'),
(11,11,18,'Fraud Confirmed'),
(12,12,16,'Resolved'),
(13,13,14,'Resolved'),
(14,14,9,'Open'),
(15,15,12,'Resolved'),
(16,16,4,'Open'),
(17,17,19,'Resolved'),
(18,18,10,'Resolved'),
(19,19,17,'Fraud Confirmed'),
(20,20,9,'Fraud Confirmed'),
(21,21,18,'Resolved'),
(22,22,11,'Open'),
(23,23,4,'Fraud Confirmed'),
(24,24,11,'Resolved'),
(25,25,8,'Open'),
(26,26,10,'Fraud Confirmed'),
(27,27,4,'Fraud Confirmed'),
(28,28,11,'Resolved'),
(29,29,3,'Open'),
(30,30,17,'Open'),
(31,31,12,'Resolved'),
(32,32,16,'Fraud Confirmed'),
(33,33,4,'Open'),
(34,34,4,'Resolved'),
(35,35,19,'Fraud Confirmed'),
(36,36,12,'Fraud Confirmed'),
(37,37,7,'Fraud Confirmed'),
(38,38,12,'Fraud Confirmed'),
(39,39,5,'Resolved'),
(40,40,7,'Resolved'),
(41,41,3,'Open'),
(42,42,12,'Fraud Confirmed'),
(43,43,8,'Open'),
(44,44,2,'Fraud Confirmed'),
(45,45,5,'Open'),
(46,46,14,'Open'),
(47,47,13,'Fraud Confirmed'),
(48,48,2,'Fraud Confirmed'),
(49,49,16,'Open'),
(50,50,16,'Open');

INSERT INTO Loans VALUES
(1,27,472056),
(2,38,725404),
(3,4,633679),
(4,12,488708),
(5,41,648572),
(6,34,730787),
(7,24,349871),
(8,27,126296),
(9,38,804574),
(10,8,320071),
(11,7,605570),
(12,30,581749),
(13,6,755211),
(14,38,125013),
(15,46,862114),
(16,14,299620),
(17,45,251557),
(18,7,273695),
(19,43,237788),
(20,48,859847),
(21,30,236203),
(22,25,252913),
(23,9,117106),
(24,23,504987),
(25,5,554003),
(26,44,470586),
(27,24,810961),
(28,2,377903),
(29,32,711219),
(30,26,606000),
(31,30,722279),
(32,17,618534),
(33,10,562075),
(34,27,897568),
(35,2,857885),
(36,2,456946),
(37,40,760064),
(38,33,294015),
(39,42,556382),
(40,39,236488),
(41,15,413101),
(42,46,515612),
(43,15,160346),
(44,24,270262),
(45,49,376006),
(46,41,810558),
(47,9,416088),
(48,8,476889),
(49,45,695645),
(50,8,626089);

INSERT INTO Notifications VALUES
(1,4,'Suspicious activity notification'),
(2,38,'Suspicious activity notification'),
(3,48,'Suspicious activity notification'),
(4,27,'Suspicious activity notification'),
(5,8,'Suspicious activity notification'),
(6,15,'Suspicious activity notification'),
(7,9,'Suspicious activity notification'),
(8,26,'Suspicious activity notification'),
(9,5,'Suspicious activity notification'),
(10,44,'Suspicious activity notification'),
(11,4,'Suspicious activity notification'),
(12,36,'Suspicious activity notification'),
(13,50,'Suspicious activity notification'),
(14,14,'Suspicious activity notification'),
(15,15,'Suspicious activity notification'),
(16,4,'Suspicious activity notification'),
(17,23,'Suspicious activity notification'),
(18,25,'Suspicious activity notification'),
(19,48,'Suspicious activity notification'),
(20,32,'Suspicious activity notification'),
(21,11,'Suspicious activity notification'),
(22,34,'Suspicious activity notification'),
(23,46,'Suspicious activity notification'),
(24,11,'Suspicious activity notification'),
(25,20,'Suspicious activity notification'),
(26,22,'Suspicious activity notification'),
(27,15,'Suspicious activity notification'),
(28,39,'Suspicious activity notification'),
(29,33,'Suspicious activity notification'),
(30,42,'Suspicious activity notification'),
(31,35,'Suspicious activity notification'),
(32,45,'Suspicious activity notification'),
(33,6,'Suspicious activity notification'),
(34,24,'Suspicious activity notification'),
(35,17,'Suspicious activity notification'),
(36,40,'Suspicious activity notification'),
(37,10,'Suspicious activity notification'),
(38,44,'Suspicious activity notification'),
(39,28,'Suspicious activity notification'),
(40,31,'Suspicious activity notification'),
(41,44,'Suspicious activity notification'),
(42,23,'Suspicious activity notification'),
(43,27,'Suspicious activity notification'),
(44,32,'Suspicious activity notification'),
(45,36,'Suspicious activity notification'),
(46,4,'Suspicious activity notification'),
(47,42,'Suspicious activity notification'),
(48,31,'Suspicious activity notification'),
(49,36,'Suspicious activity notification'),
(50,26,'Suspicious activity notification'),
(51,31,'Suspicious activity notification'),
(52,50,'Suspicious activity notification'),
(53,14,'Suspicious activity notification'),
(54,13,'Suspicious activity notification'),
(55,15,'Suspicious activity notification'),
(56,1,'Suspicious activity notification'),
(57,18,'Suspicious activity notification'),
(58,33,'Suspicious activity notification'),
(59,32,'Suspicious activity notification'),
(60,5,'Suspicious activity notification'),
(61,7,'Suspicious activity notification'),
(62,6,'Suspicious activity notification'),
(63,8,'Suspicious activity notification'),
(64,1,'Suspicious activity notification'),
(65,20,'Suspicious activity notification'),
(66,10,'Suspicious activity notification'),
(67,4,'Suspicious activity notification'),
(68,40,'Suspicious activity notification'),
(69,30,'Suspicious activity notification'),
(70,42,'Suspicious activity notification'),
(71,25,'Suspicious activity notification'),
(72,21,'Suspicious activity notification'),
(73,19,'Suspicious activity notification'),
(74,2,'Suspicious activity notification'),
(75,45,'Suspicious activity notification'),
(76,6,'Suspicious activity notification'),
(77,14,'Suspicious activity notification'),
(78,25,'Suspicious activity notification'),
(79,48,'Suspicious activity notification'),
(80,25,'Suspicious activity notification');

INSERT INTO Audit_Log VALUES
(1,'Transactions','INSERT',CURRENT_TIMESTAMP),
(2,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(3,'Customers','DELETE',CURRENT_TIMESTAMP),
(4,'Accounts','DELETE',CURRENT_TIMESTAMP),
(5,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(6,'Accounts','INSERT',CURRENT_TIMESTAMP),
(7,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(8,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(9,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(10,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(11,'Accounts','DELETE',CURRENT_TIMESTAMP),
(12,'Transactions','INSERT',CURRENT_TIMESTAMP),
(13,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(14,'Customers','UPDATE',CURRENT_TIMESTAMP),
(15,'Transactions','INSERT',CURRENT_TIMESTAMP),
(16,'Transactions','INSERT',CURRENT_TIMESTAMP),
(17,'Fraud_Alerts','INSERT',CURRENT_TIMESTAMP),
(18,'Accounts','DELETE',CURRENT_TIMESTAMP),
(19,'Transactions','DELETE',CURRENT_TIMESTAMP),
(20,'Accounts','INSERT',CURRENT_TIMESTAMP),
(21,'Customers','DELETE',CURRENT_TIMESTAMP),
(22,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(23,'Customers','DELETE',CURRENT_TIMESTAMP),
(24,'Customers','INSERT',CURRENT_TIMESTAMP),
(25,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(26,'Accounts','DELETE',CURRENT_TIMESTAMP),
(27,'Customers','DELETE',CURRENT_TIMESTAMP),
(28,'Transactions','DELETE',CURRENT_TIMESTAMP),
(29,'Transactions','DELETE',CURRENT_TIMESTAMP),
(30,'Transactions','INSERT',CURRENT_TIMESTAMP),
(31,'Accounts','INSERT',CURRENT_TIMESTAMP),
(32,'Fraud_Alerts','INSERT',CURRENT_TIMESTAMP),
(33,'Transactions','UPDATE',CURRENT_TIMESTAMP),
(34,'Transactions','INSERT',CURRENT_TIMESTAMP),
(35,'Accounts','INSERT',CURRENT_TIMESTAMP),
(36,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(37,'Customers','UPDATE',CURRENT_TIMESTAMP),
(38,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(39,'Transactions','DELETE',CURRENT_TIMESTAMP),
(40,'Transactions','UPDATE',CURRENT_TIMESTAMP),
(41,'Customers','INSERT',CURRENT_TIMESTAMP),
(42,'Accounts','INSERT',CURRENT_TIMESTAMP),
(43,'Fraud_Alerts','DELETE',CURRENT_TIMESTAMP),
(44,'Transactions','UPDATE',CURRENT_TIMESTAMP),
(45,'Transactions','INSERT',CURRENT_TIMESTAMP),
(46,'Fraud_Alerts','UPDATE',CURRENT_TIMESTAMP),
(47,'Fraud_Alerts','INSERT',CURRENT_TIMESTAMP),
(48,'Customers','UPDATE',CURRENT_TIMESTAMP),
(49,'Transactions','INSERT',CURRENT_TIMESTAMP),
(50,'Fraud_Alerts','INSERT',CURRENT_TIMESTAMP);

SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM Accounts;
SELECT * FROM Locations;
SELECT * FROM Transactions;
SELECT * FROM Cards;
SELECT * FROM Devices;
SELECT * FROM Fraud_Alerts;
SELECT * FROM Risk_Score;
SELECT * FROM Employees;
SELECT * FROM Investigation;
SELECT * FROM Loans;
SELECT * FROM Notifications;
SELECT * FROM Audit_Log;

INSERT INTO Customers VALUES (51,'Vasuki','vasuki1@gmail.com','9107778901','Madurai','2026-02-02');
COMMIT;
DELETE FROM Customers WHERE customer_id=101;
ROLLBACK;

START TRANSACTION;

INSERT INTO Accounts VALUES(1051,50,1,'Current',40027,'Active')

SAVEPOINT A;

UPDATE Accounts SET balance=60000 WHERE account_id=2001;
ROLLBACK TO A;

-- ALL CUSTOMERS WITH ACCOUNT DETAILS
SELECT c.customer_id,c.customer_name,a.account_id,a.account_type,a.balance
FROM Customers c
JOIN Accounts A ON c.customer_id = a.customer_id;

-- FIND CUSTOMERS HAVING AMOUT GREATER THAN 200000
SELECT c.customer_id,c.customer_name,a.balance
FROM Customers as c
JOIN Accounts as a ON c.customer_id=a.customer_id where a.balance>200000;

-- COUNT TOTAL TRANSACTIONS FOR EACH CUSTOMER
SELECT c.customer_id,c.customer_name,count(t.transaction_id) as Total_Counts
FROM Customers c
JOIN Accounts as a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id GROUP BY c.customer_id,c.customer_name;

-- FIND CUSTOMERS WITH HIGHEST RISK SCORE
SELECT c.customer_name,r.score
FROM Customers c
JOIN Risk_Score r ON c.customer_id=r.customer_id
ORDER BY r.score DESC LIMIT 1;

-- FIND CUSTOMERS HAVING FRAUD ALERTS
SELECT c.customer_id,c.customer_name,f.risk_level
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id

-- FIND CUSTOMERS RECEIVING TRANSACTIONS FROM MULTIPLE LOCATIONS
SELECT c.customer_name,COUNT(DISTINCT t.location_id) sender_locations,SUM(t.amount) total_received
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name HAVING COUNT(DISTINCT t.location_id)>1
ORDER BY total_received DESC;

-- CUSTOMER ACCOUNT SUMMARY USING VIEW
CREATE VIEW Customer_Account_Summary AS
SELECT c.customer_id,c.customer_name,a.account_id,a.account_type,a.balance
FROM Customers c
JOIN Accounts a
ON c.customer_id=a.customer_id;

SELECT * FROM Customer_Account_Summary;

-- FRAUD DETECTION REPORT USING VIEW
CREATE VIEW Fraud_Report AS
SELECT f.alert_id,c.customer_name,t.transaction_id,t.amount,f.risk_level
FROM Fraud_Alerts f
JOIN Transactions t ON f.transaction_id=t.transaction_id
JOIN Accounts a ON t.account_id=a.account_id
JOIN Customers c ON a.customer_id=c.customer_id;

SELECT * FROM Fraud_Report;
-- DROP VIEW  Fraud_Report
DROP VIEW Fraud_Report;

-- WHENEVER ACCOUNT BALANCE IS UPDATED,STORE HISTORY
DELIMITER //

CREATE TRIGGER trg_account_update
AFTER UPDATE ON Accounts
FOR EACH ROW
BEGIN
INSERT INTO Audit_Log(table_name,action_type)VALUES
(
'Accounts',
'UPDATE'
);

END //

DELIMITER ;
UPDATE Accounts SET balance=150000 WHERE account_id=1001;
SELECT * FROM Audit_Log;

-- FIND TRANSACTIONS GREATER THAN THE GIVEN AMOUNT USING STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE DetectHighRiskTransactions(IN p_amount DECIMAL(12,2))
BEGIN

SELECT transaction_id,account_id,amount,transaction_type FROM Transactions WHERE amount > p_amount;

END //
DELIMITER ;
CALL DetectHighRiskTransactions(50000);

-- DISPLAY CUSTOMES WHOSE RISK SCORE EXCEEDS THE GIVEN THRESHOLD
DELIMITER //

CREATE PROCEDURE CustomerRiskReport(IN p_score INT)
BEGIN

SELECT c.customer_name,r.score 
FROM Customers c 
JOIN Risk_Score r ON c.customer_id=r.customer_id
WHERE r.score > p_score
ORDER BY r.score DESC;

END //

DELIMITER ;
CALL CustomerRiskReport(80);
DROP PROCEDURE IF EXISTS CustomerRiskReport;

-- RANK CUSTOMERS BASED ON THE HIGHEST ACCOUNT BALANCE USING WINDOWS FUNCTION
SELECT c.customer_name,a.balance,
RANK() OVER
(
ORDER BY a.balance DESC
)
AS balance_rank
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id;

-- FIND PREVIOUS AMOUNT FOR COMPARISION
SELECT transaction_id,account_id,amount,
LAG(amount)
OVER
(
PARTITION BY account_id
ORDER BY transaction_date
)
AS previous_transaction
FROM Transactions;

-- FREQUENTLY SEARCH FOR HIGH VALUE TRANSACTIONS USING INDEX
CREATE INDEX idx_transaction_amount 
ON Transactions(amount);

SELECT * FROM Transactions WHERE amount > 50000;

-- TO VIEW THE INDEX
SHOW INDEX FROM Transactions;

-- DROP THE INDEX
DROP INDEX idx_transaction_amount
ON Transactions;

-- CUSTOMERS WHOSE TOTAL TRANSACTION AMOUNT IS ABOVE AVERAGE  
SELECT c.customer_name,SUM(t.amount) AS total_amount
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name HAVING SUM(t.amount) >
(
SELECT AVG(total_amount)
FROM
(
SELECT SUM(amount) total_amount
FROM Transactions
GROUP BY account_id
) x
)
ORDER BY total_amount DESC;

-- FIND HIGHEST TRANSACTION CUSTOMER
SELECT c.customer_name,MAX(t.amount) AS highest_transaction
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name
HAVING MAX(t.amount)=(SELECT MAX(amount)FROM Transactions)
ORDER BY highest_transaction DESC;

-- BRANCH HAVING MAXIMUM AVERAGE BALANCE
SELECT branch_id,AVG(balance) avg_balance
FROM Accounts
GROUP BY branch_id HAVING AVG(balance)=
(
SELECT MAX(avg_bal)
FROM
(
SELECT AVG(balance) avg_bal
FROM Accounts
GROUP BY branch_id
) x
)
ORDER BY avg_balance DESC;

-- RISK SCORE ABOVE AVERAGE
SELECT c.customer_name,AVG(r.score) score
FROM Customers c
JOIN Risk_Score r ON c.customer_id=r.customer_id
GROUP BY c.customer_name HAVING AVG(r.score) >
(
SELECT AVG(score)
FROM Risk_Score
)
ORDER BY score DESC;

-- FIND TOP TRANSACTION CITY
SELECT city,COUNT(*) total_customers
FROM Customers
GROUP BY city
ORDER BY total_customers DESC;

-- FRAUD ALERTS ABOVE AVERAGE
SELECT risk_level,COUNT(*) total_alerts
FROM Fraud_Alerts
GROUP BY risk_level
HAVING COUNT(*) >
(
SELECT AVG(alert_count)
FROM
(
SELECT COUNT(*) alert_count
FROM Fraud_Alerts
GROUP BY risk_level
) x
)
ORDER BY total_alerts DESC;

-- MONTHLY TRANSACTION ANALYSIS
SELECT MONTH(transaction_date) month_number,SUM(amount) total_amount,AVG(amount) avg_amount
FROM Transactions
GROUP BY MONTH(transaction_date)
ORDER BY total_amount DESC;

-- DETECT SUSPICIOUS CUSTOMER USING CASE
SELECT c.customer_name,SUM(t.amount),
CASE

WHEN SUM(t.amount)>300000 THEN 'High Risk'
WHEN SUM(t.amount)>150000 THEN 'Medium Risk'
ELSE 'Low Risk'

END AS risk_category
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name
ORDER BY SUM(t.amount) DESC;

-- FIND CUSTOMERS WITH MORE THAN AVERAGE FAILED LOGIN ATTEMPTS
SELECT customer_id,COUNT(*) failed_logins
FROM Login_History WHERE login_status='Failed'
GROUP BY customer_id
HAVING COUNT(*) >
(
SELECT AVG(login_count)
FROM
(
SELECT COUNT(*) login_count FROM Login_History WHERE login_status='Failed'
GROUP BY customer_id
)x
)
ORDER BY failed_logins DESC;

-- DETECT ACCOUNTS HAVING MULTIPLE FRAUD ALERTS
SELECT a.account_id,COUNT(f.alert_id) total_alerts
FROM Accounts a
JOIN Transactions t ON a.account_id=t.account_id
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id
GROUP BY a.account_id HAVING COUNT(*)>1
ORDER BY total_alerts DESC;

-- FIND CUSTOMERS WHOSE TOTAL LOAN EXCEEDS AVERAGE LOAN
SELECT c.customer_name,SUM(l.loan_amount) total_loan
FROM Customers c
JOIN Loans l ON c.customer_id=l.customer_id
GROUP BY c.customer_name HAVING SUM(l.loan_amount) >
(
SELECT AVG(loan_amount) FROM Loans
)
ORDER BY total_loan DESC;

-- GENERATE CUSTOMER TRANSACTION PERFORMANCE REPORT
SELECT c.customer_name,COUNT(t.transaction_id) total_transactions,SUM(t.amount) total_amount,AVG(t.amount) average_amount,
MAX(t.amount) highest_transaction,MIN(t.amount) lowest_transaction
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name
ORDER BY total_amount DESC;

-- FIND CUSTOMERS WITH TRANSACTIONS IN MORE THAN ONE LOCATION
SELECT c.customer_name,COUNT(DISTINCT t.location_id) total_locations
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT t.location_id)>1
ORDER BY total_locations DESC;

-- FIND CUSTOMERS WITH NO FRAUD ALERTS
SELECT customer_name
FROM Customers WHERE customer_id NOT IN
(
SELECT a.customer_id
FROM Accounts a
JOIN Transactions t ON a.account_id=t.account_id
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id
)
ORDER BY customer_name;

-- CATEGORIZE CUSTOMERS BASED ON ACCOUNT BALANCE
SELECT customer_id,balance,
CASE

WHEN balance > 300000 THEN 'Premium'
WHEN balance > 150000 THEN 'Standard'
ELSE 'Regular'

END AS customer_type FROM Accounts
ORDER BY balance DESC;

-- FIND CUSTOMERS WITH BOTH FAILED LOGIN AND FRAUD ALERT
SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Login_History l ON c.customer_id=l.customer_id
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id WHERE l.login_status='Failed'
ORDER BY c.customer_name;

-- FIND TOP 5 CUSTOMERS WITH HIGHEST TRANSACTION AMOUNT AND CLASSIFY RISK
SELECT c.customer_id,c.customer_name,SUM(t.amount) total_amount,
CASE
WHEN SUM(t.amount)>500000 THEN 'High Risk'
WHEN SUM(t.amount)>250000 THEN 'Medium Risk'
ELSE 'Low Risk'
END risk_category
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_id,c.customer_name
HAVING SUM(t.amount)>
(
SELECT AVG(total)
FROM
(
SELECT SUM(amount) total
FROM Transactions
GROUP BY account_id
)x
)
ORDER BY total_amount DESC LIMIT 5;

-- DETECT CUSTOMERS WITH FAILED LOGINS AND FRAUD ALERTS
SELECT c.customer_name,COUNT(l.login_id) failed_attempts,COUNT(f.alert_id) fraud_count
FROM Customers c
JOIN Login_History l ON c.customer_id=l.customer_id
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id WHERE l.login_status='Failed'
GROUP BY c.customer_name HAVING COUNT(l.login_id)>=2
ORDER BY fraud_count DESC;

-- RANK CUSTOMERS BASED ON TOTAL TRANSACTIONS
SELECT customer_name,total_amount,
RANK() OVER(ORDER BY total_amount DESC) ranking
FROM
(
SELECT c.customer_name,SUM(t.amount) total_amount
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name
)x;

-- GENERATE FRAUD SEVERITY REPORT
SELECT f.risk_level,COUNT(*) total_cases,AVG(t.amount) avg_transaction
FROM Fraud_Alerts f
JOIN Transactions t ON f.transaction_id=t.transaction_id
GROUP BY f.risk_level
HAVING AVG(t.amount)>
(
SELECT AVG(amount)
FROM Transactions
)
ORDER BY total_cases DESC;

-- MONTHLY FRAUD TRANSACTION REPORT
SELECT MONTH(t.transaction_date) month_no,COUNT(f.alert_id) fraud_cases,SUM(t.amount) total_amount
FROM Transactions t
JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id
GROUP BY MONTH(t.transaction_date)
ORDER BY total_amount DESC;

-- DETECT CUSTOMERS WHOSE TRANSACTION SUDDENLY INCREASED BY MORE THAN 2x PREVIOUS STAGE
SELECT c.customer_name,
t.transaction_id,
t.amount
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
WHERE t.amount>
(
SELECT AVG(t2.amount)*2
FROM Transactions t2
WHERE t2.account_id=t.account_id
)
ORDER BY t.amount DESC;

-- CUSTOMER FRAUD SCORE DASHBOARD
SELECT c.customer_name,
AVG(r.score) risk_score,
SUM(t.amount) total_amount,
COUNT(f.alert_id) fraud_alerts,
CASE
WHEN AVG(r.score)>80 THEN 'Critical'
WHEN AVG(r.score)>60 THEN 'Watch'
ELSE 'Safe'
END status
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
LEFT JOIN Fraud_Alerts f ON t.transaction_id=f.transaction_id
JOIN Risk_Score r ON c.customer_id=r.customer_id
GROUP BY c.customer_name
ORDER BY risk_score DESC;

-- IDENTIFY CUSTOMERS WITH REPEATED FAILED LOGIN AND LARGE TRANSACTIONS
SELECT c.customer_name,COUNT(l.login_id) failed_count,SUM(t.amount) total_amount
FROM Customers c
JOIN Login_History l ON c.customer_id=l.customer_id
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id WHERE l.login_status='Failed'
GROUP BY c.customer_name HAVING COUNT(*)>=3 AND SUM(t.amount)>200000
ORDER BY total_amount DESC;

-- DETECT DORMANT ACCOUNTS WITH UNUSUALLY HIGH TRANSACTIONS 
SELECT c.customer_name,MAX(t.amount) highest_transaction
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name HAVING COUNT(t.transaction_id)<=2 AND MAX(t.amount)>
(
SELECT AVG(amount)
FROM Transactions
)
ORDER BY highest_transaction DESC;

-- DETECT CUSTOMERS WITH RAPID TRANSACTION GROWTH
SELECT customer_name,current_total,previous_total
FROM
(
SELECT c.customer_name,
SUM(t.amount) current_total,
LAG(SUM(t.amount))
OVER(ORDER BY c.customer_id)
previous_total
FROM Customers c
JOIN Accounts a ON c.customer_id=a.customer_id
JOIN Transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name,c.customer_id
)x
WHERE current_total>previous_total*2;
