--CREATE Customers
CREATE TABLE Customers(
    customerID int NOT NULL,
    customerName varchar(50),
    customerPhone varchar(50) NOT NULL,
    PRIMARY KEY (customerID)
);

--CREATE PrivateCustomers
CREATE TABLE PrivateCustomers(
    customerID int NOT NULL,
    pcName varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    snailMail varchar(50) NOT NULL,
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);

--CREATE Corporation
CREATE TABLE Corporation(
    customerID int NOT NULL,
    officeAddr varchar(50) NOT NULL,
    corporationName varchar(50) NOT NULL,
    organizationName varchar(50) NOT NULL,
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);

--CREATE AdvisorContact
CREATE TABLE AdvisorContact(
    customerID int NOT NULL,
    contactType varchar(50) NOT NULL,
    contactInfo varchar(50) NOT NULL,
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);

--CREATE Account
CREATE TABLE Account(
    customerID int NOT NULL,
    amountSpent double NOT NULL,
    MimingsMoney int NOT NULL,
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);

--CREATE schedule
CREATE TABLE schedule(
  shiftTime varchar(20) NOT NULL, 
  weekNum int NOT NULL,
  PRIMARY KEY(shiftTime, weekNum)
);

--CREATE workCrew
CREATE TABLE workCrew(
    shiftTime varchar(20) NOT NULL,
    currentDate Date,
    crewType INT NOT NULL,
    PRIMARY KEY(shiftTime, crewType, currentDate),
    FOREIGN KEY(shiftTime) REFERENCES schedule(shiftTime)
);

--CREATE employee
CREATE TABLE employee(
    EID INT NOT NULL,
    firstName VARCHAR(25),
    lastName VARCHAR(25),
    dateOfBirth DATE,
    email VARCHAR(75),
    shiftTime VARCHAR(20) NOT NULL,
    PRIMARY KEY(EID),
    FOREIGN KEY(shiftTime) REFERENCES schedule(shiftTime)
);

--CREATE chef
CREATE TABLE chef(
    EID INT NOT NULL,
    salary INT NOT NULL,
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES employee(EID)
);

--CREATE headChef
CREATE TABLE headChef(
    EID INT NOT NULL,
    numOfRecipes INT NOT NULL,
    PRIMARY KEY(EID),
    FOREIGN KEY (EID) REFERENCES chef(EID)
);

--CREATE recipe
CREATE TABLE recipe(
    EID INT NOT NULL,
    recipe VARCHAR(30),
    PRIMARY KEY (EID, recipe),
    FOREIGN KEY (EID) REFERENCES headChef(EID)
);

--CREATE dishwasher
CREATE TABLE dishwasher(
    EID INT NOT NULL,
    hours DOUBLE(2, 1),
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES employee(EID)
);

--CREATE sousChef
CREATE TABLE sousChef(
    EID INT NOT NULL,
    numOfLearnedDishes INT NOT NULL,
    PRIMARY KEY(EID),
    FOREIGN KEY (EID) REFERENCES chef(EID)
);

--CREATE menuCategory
CREATE TABLE menuCategory(
    categoryID int NOT NULL,
    category varchar(225) NOT NULL,
    PRIMARY KEY (categoryID)
);

--CREATE menuItem
CREATE TABLE menuItem(
    menuItemID int NOT NULL,
    itemName varchar(225) NOT NULL,
    ingredients varchar(225) NOT NULL,
    spiciness varchar(225) NOT NULL,
    PRIMARY KEY (menuItemID)
);

--CREATE menuDate
CREATE TABLE menuDate(
    menuItemID int NOT NULL,
    categoryID int NOT NULL,
    dateAdded date NOT NULL,
    PRIMARY KEY (menuItemID, categoryID),
    CONSTRAINT menudate_fk1 FOREIGN KEY (menuItemID) REFERENCES menuItem (menuItemID),
    CONSTRAINT menudate_fk2 FOREIGN KEY (categoryID) REFERENCES menuCategory (categoryID)
);

--CREATE mentoring
CREATE TABLE mentoring(
    EID INT NOT NULL,
    menuItemID INT NOT NULL,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY(EID, menuItemID, startDate),
    FOREIGN KEY (EID) REFERENCES sousChef(EID),
    FOREIGN KEY (menuItemID) REFERENCES menuItem(menuItemID)
);

--CREATE linecook
CREATE TABLE linecook(
    EID INT NOT NULL,
    numberOfTitles INT NOT NULL,
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES chef(EID)
);

--CREATE department
CREATE TABLE department(
    departmentName VARCHAR(25) NOT NULL,
    employeeCount INT,
    PRIMARY KEY(departmentName)
);

--CREATE lineshift
CREATE TABLE lineshift(
    EID INT NOT NULL,
    departmentName VARCHAR(25) NOT NULL,
    startTime TIMESTAMP,
    endTime TIMESTAMP,
    PRIMARY KEY (EID, departmentName, startTime, endTime),
    FOREIGN KEY (EID) REFERENCES linecook(EID),
    FOREIGN KEY (departmentName) REFERENCES department(departmentName)
);
--CREATE manager
CREATE TABLE manager(
    EID INT NOT NULL,
    hours DOUBLE(2, 1),
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES employee(EID)
);

--CREATE maitreD
CREATE TABLE maitreD(
    EID INT NOT NULL,
    hours DOUBLE(2, 1),
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES employee(EID)
);

--CREATE waitStaff
CREATE TABLE waitStaff(
    EID INT NOT NULL,
    hours DOUBLE(2, 1),
    tips DOUBLE(5, 2),
    PRIMARY KEY(EID),
    FOREIGN KEY(EID) REFERENCES employee(EID)
);

--CREATE restaurantTable
CREATE TABLE restaurantTable(
  EID INT NOT NULL,
  tableNum INT NOT NULL,
  numberOfSeats INT NOT NULL,
  PRIMARY KEY(EID, tableNum),
  FOREIGN KEY(EID) REFERENCES waitStaff(EID)
);

--CREATE Discounts
CREATE TABLE Discounts(
    discountType varchar(50) NOT NULL,
    rate int NOT NULL,
    PRIMARY KEY (discountType)
);

--CREATE Orders
CREATE TABLE Orders(
    customerID int NOT NULL,
    discountType varchar(50) NOT NULL,
    orderNum int NOT NULL,
    orderTime TIMESTAMP,
    total double NOT NULL,
    PRIMARY KEY (orderNum),
    FOREIGN KEY (discountType) REFERENCES Discounts (discountType),
    FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);

--CREATE ToGo
CREATE TABLE ToGo(
    orderNum int NOT NULL,
    timeReadied TIMESTAMP,
    timePickedUp TIMESTAMP,
    PRIMARY KEY (orderNum)
);

--CREATE Phone
CREATE TABLE Phone(
    orderNum int NOT NULL,
    timeCalled TIMESTAMP,
    PRIMARY KEY (orderNum)
);

--CREATE PhonePay
CREATE TABLE PhonePay(
    orderNum int NOT NULL,
    payType varchar(50),
    phoneAmount double,
    PRIMARY KEY (orderNum)
);

--CREATE Web
CREATE TABLE Web(
    orderNum int NOT NULL,
    creditNumber varchar(50),
    webAmount double,
    PRIMARY KEY (orderNum)
);

--CREATE Dine
CREATE TABLE Dine(
    orderNum int NOT NULL,
    EID int NOT NULL,
    timeArrived TIMESTAMP,
    PRIMARY KEY (orderNum),
    FOREIGN KEY (EID) REFERENCES restaurantTable (EID)
);

--CREATE DinePay
CREATE TABLE DinePay(
    orderNum int NOT NULL,
    payType varchar(50),
    tableAmount double
);

--CREATE menu
CREATE TABLE menu(
    menuID int NOT NULL,
    menuName varchar(225) NOT NULL,
    PRIMARY KEY (menuID)
);

--CREATE orderSelect
CREATE TABLE orderSelect(
    menuID int NOT NULL,
    menuItemID int NOT NULL,
    orderSize varchar(225) NOT NULL,
    price double,
    PRIMARY KEY (menuID, menuItemID),
    CONSTRAINT orderselect_fk1 FOREIGN KEY (menuID) REFERENCES menu (menuID),
    CONSTRAINT orderselect_fk2 FOREIGN KEY (menuItemID) REFERENCES menuItem (menuItemID)
);

--CREATE orderTrack
CREATE TABLE orderTrack(
    orderNum int NOT NULL,
    menuID int NOT NULL,
    menuItemID int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY (orderNum, menuID, menuItemID),
    CONSTRAINT ordertrack_fk1 FOREIGN KEY (orderNum) REFERENCES Orders (orderNum),
    CONSTRAINT ordertrack_fk2 FOREIGN KEY (menuID) REFERENCES orderSelect (menuID),
    CONSTRAINT ordertrack_fk3 FOREIGN KEY (menuItemID) REFERENCES orderSelect (menuItemID)
);

--INSERT INTO Customers
insert into Customers(customerID,customerName,customerPhone) values 
(1000,'Tom','+1 714 837 0825'),
(1001,'Josh','+1 714 230 1234'),
(1002,NULL,'+1 714 333 5434'),
(1003,'Henry','+1 714 543 4324'),
(1004,'Daniel','+1 714 431 8537'),
(1005,'Denver','+1 714 754 8883'),
(1006,'Edward','+1 714 222 3334'),
(1007,'Elizabeth','+1 714 127 2543'),
(1008,'Steven','+1 714 189 2323'),
(1009,'Eric','+1 714 643 5475'),
(1010,'Bean','+1 714 777 8888'),
(1011,'Edison','+1 714 231 4234');

--INSERT INTO PrivateCustomers
insert into PrivateCustomers(customerID,pcName,email,snailMail) values
(1000,'Tom','Tom1998@yahoo.com','1003 Garo Place'),
(1003,'Henry','HenryLikesPie@hotmail.com','4332 Hay Lane'),
(1009,'Eric','ILikeSchool@gmail.com','7224 Apple Street');

--INSERT INTO Corporation
insert into Corporation(customerID,officeAddr,corporationName,organizationName) values
(1001,'1234 Alphabet Street','Apple','Sales'),
(1004,'5332 Soup Place','Orange','Fabrication'),
(1007,'5674 Spinach Street','Banana','Engineering'),
(1010,'6574 University Street','Bread','Sales'),
(1011,'8653 Plane Lane','Cherry','Advertisment');

--INSERT INTO AdvisorContact
insert into AdvisorContact(customerID,contactType,contactInfo) values
(1001,'Phone','+1 714 230 1234'),
(1004,'Email','Daniel2343@yahoo.com'),
(1007,'Phone','+1 714 340 3532'),
(1010,'Phone','+1 714 235 3214'),
(1011,'Email','SpamMail@gmail.com');

--INSERT INTO Account
insert into Account(customerID,amountSpent,MimingsMoney) values
(1000,103.32,10),
(1001,342.00,32),
(1003,120.65,12),
(1004,230.34,23),
(1005,50.00,5),
(1006,16.25,0),
(1007,174.79,12),
(1008,24.12,0),
(1009,53.30,1),
(1010,203.00,10),
(1011,270.04,15);

--INSERT INTO schedule
INSERT INTO schedule(shiftTime, weekNum)
    VALUES ('Evening', 3);
INSERT INTO schedule(shiftTime, weekNum)
    VALUES ('Lunch', 3);

--INSERT INTO workCrew
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Evening', '2018-12-01', 54);   
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Lunch', '2018-12-02', 1);   
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Evening', '2018-12-18', 2);   
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Lunch', '2018-12-18', 1);    
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Lunch', '2018-12-20', 1);
INSERT INTO workCrew(shiftTime, currentDate, crewType)
    VALUES ('Evening', '2018-12-20', 2);

--INSERT INTO employee
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(1, 'Bob', 'Sagat', '1994-04-20', 'bobsagat@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(2, 'Bilbo', 'Baggins', '1990-02-01', 'bagginsbilbo@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(3, 'Brian', 'Nguyen', '1998-10-02', 'briannguyen@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(4, 'Jonathan', 'Young', '1991-03-05', 'johnnyy@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(5, 'Martha', 'Palmer', '2000-11-12', 'ilikepalmtrees@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(6, 'Aleister', 'Black', '1994-10-05', 'fadetoblack@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(7, 'Johnny', 'Gargano', '1989-01-10', 'johnnywrestling@yahoo.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(8, 'Candice', 'LeRae', '1990-09-05', 'candylerae@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(9, 'Adam', 'Cole', '1989-07-11', 'adamcolebaybay@gmail.com', 'Evening');    
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(10, 'Kyle', "O'Reiley", '1990-02-21', 'korcombat@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(11, 'Bobby', 'Fish', '1987-11-28', 'bobbyfisher@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(12, 'Roderick', 'Strong', '1986-09-07', 'roddyvstheworld@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(13, 'Trevor', 'Mann', '1989-06-15', 'oneandonly@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(14, 'Pete', 'Dunne', '1996-08-19', 'bruiserweight@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(15, 'Becky', 'Lynch', '1994-03-19', 'irishlasskicker@gmail.com', 'Lunch');   
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(16, 'Charlotte', 'Flair', '1989-01-25', 'charlottewooo@yahoo.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(17, 'Toni', 'Storm', '1994-10-05', 'tonitime@gmail.com', 'Evening');   
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(18, 'Rhea', 'Ripley', '1998-12-26', 'moshpitking@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(19, 'Tyler', 'Bate', '1997-08-01', 'batemaster@yahoo.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(20, 'Trent', 'Seven', '1969-11-11', 'moustacheboi@yahoo.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(21, 'Drew', 'McIntyre', '1975-02-28', 'scottishdomination@gmail.com', 'Evening');    
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(22, 'Tomasso', 'Ciampa', '1975-02-28', 'blackheart@gmail.com', 'Evening');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(23, 'Io', 'Shirai', '1990-09-19', 'queenofthesky@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(24, 'Kairi', 'Sane', '1993-10-11', 'pirateprincess@gmail.com', 'Lunch');
INSERT INTO employee(EID, firstName, lastName, dateOfBirth, email, shiftTime)
    VALUES(25, 'Shayna', 'Bazler', '1983-12-09', 'queenofspades@gmail.com', 'Evening');

--INSERT INTO chef
INSERT INTO chef(EID, salary)
    VALUES(3, 40000);   
INSERT INTO chef(EID, salary)
    VALUES(9, 32000);
INSERT INTO chef(EID, salary)
    VALUES(10, 32000);
INSERT INTO chef(EID, salary)
    VALUES(11, 28000);
INSERT INTO chef(EID, salary)
    VALUES(12, 28000);
INSERT INTO chef(EID, salary)
    VALUES(17, 40000);
INSERT INTO chef(EID, salary)
    VALUES(21, 28000);
INSERT INTO chef(EID, salary)
    VALUES(22, 28000);
INSERT INTO chef(EID, salary)
    VALUES(23, 28000);
INSERT INTO chef(EID, salary)
    VALUES(24, 32000);
INSERT INTO chef(EID, salary)
    VALUES(25, 32000);

--HEAD INTO headChef
INSERT INTO headChef(EID, numOfRecipes)
    VALUES(3, 4);
INSERT INTO headChef(EID, numOfRecipes)
    VALUES(17, 2);
    
--HEAD INTO recipe
INSERT INTO recipe(EID, recipe)
    VALUES(3, 'Orange Chicken Mix');
INSERT INTO recipe(EID, recipe)
    VALUES(3, 'Vegan Fried Rice');
INSERT INTO recipe(EID, recipe)
    VALUES(3, 'Chow Mein Special');
INSERT INTO recipe(EID, recipe)
    VALUES(3, 'Vegan Special');
INSERT INTO recipe(EID, recipe)
    VALUES(17, 'Wong Fu Beef');  
INSERT INTO recipe(EID, recipe)
    VALUES(17, 'Duck Noodle');

--INSERT INTO dishwasher
INSERT INTO dishwasher(EID, hours)
    VALUES(16, 8.0);
INSERT INTO dishwasher(EID, hours)
    VALUES(5, 7.5);

--INSERT INTO sousChef
INSERT INTO sousChef(EID, numOfLearnedDishes)
    VALUES
        (9, 2),
        (10, 2);
INSERT INTO sousChef(EID, numofLearnedDishes)
    VALUES 
        (24, 5),
        (25, 10);

--INSERT INTO linecook
INSERT INTO linecook(EID, numberOfTitles)
    VALUES (21, 2);
INSERT INTO linecook(EID, numberOfTitles)
    VALUES (22, 3);
INSERT INTO linecook(EID, numberOfTitles)
    VALUES (11, 3);
INSERT INTO linecook(EID, numberOfTitles)
    VALUES  (12, 4);
INSERT INTO linecook(EID, numberOfTitles)
    VALUES  (23, 2);

--INSERT INTO department
INSERT INTO department(departmentName, employeeCount)
    VALUES
        ('Butcher', 2),
        ('Fry Cook', 2),
        ('Grill', 2),
        ('Pantry', 1),
        ('Pastry', 1),
        ('Roast', 1),
        ('Vegetable', 1);

--INSERT INTO lineshift
INSERT INTO lineshift(EID, departmentName, startTime, endTime)
    VALUES (11, 'Fry Cook', '2018-12-20 13:00:00', '2018-12-20 17:00:00');   
INSERT INTO lineshift(EID, departmentName, startTime, endTime)
    VALUES (12, 'Vegetable', '2018-12-20 13:00:00', '2018-12-20 17:00:00'); 
INSERT INTO lineshift(EID, departmentName, startTime, endTime)
    VALUES (21, 'Pantry', '2018-12-20 17:00:00', '2018-12-20 21:00:00');    
INSERT INTO lineshift(EID, departmentName, startTime, endTime)
    VALUES (22, 'Butcher', '2018-12-20 17:00:00', '2018-12-20 21:00:00'); 
INSERT INTO lineshift(EID, departmentName, startTime, endTime)
    VALUES (23, 'Fry Cook', '2018-12-20 13:00:00', '2018-12-20 17:00:00'); 

--INSERT INTO manager
INSERT INTO manager(EID, hours)
    VALUES(6, 9.0);

--INSERT INTO maitreD
INSERT INTO maitreD(EID, hours)
    VALUES
        (4, 8.0),
        (5, 8.0);

--INSERT INTO waitStaff
INSERT INTO waitStaff(EID, hours, tips)
    VALUES
        (7, 6.5, 102.05),
        (8, 6.0, 120.10),
        (2, 7.0, 32.21),
        (13, 8.0, 3);

--INSERT INTO restaurantTable
INSERT INTO restaurantTable(EID, tableNum, numberOfSeats)
    VALUES
        (7, 1, 4),
        (8, 2, 8),
        (2, 3, 5),
        (13, 4, 4);

--INSERT INTO Discounts
insert into Discounts(discountType,rate) values 
('0 percent',0),
('5 percent',5),
('10 percent',10),
('15 percent', 15);

--INSERT INTO Orders
insert into Orders(customerID,discountType,orderNum,orderTime,total) values
(1000,'0 percent',0001,'2016-11-08 13:00:00',12),
(1000,'5 percent',0002,'2016-12-11 13:35:14',15),
(1001,'0 percent',0003,'2017-01-23 15:13:12',201),
(1002,'0 percent',0004,'2017-01-09 07:50:50',20),
(1003,'0 percent',0005,'2017-01-11 08:30:20',43),
(1004,'0 percent',0006,'2017-02-10 14:30:13',104),
(1005,'0 percent',0007,'2017-02-10 15:14:15',43),
(1006,'0 percent',0008,'2017-05-01 15:20:15',45),
(1006,'0 percent',0009,'2017-12-20 16:00:00',20),
(1007,'0 percent',0010,'2018-01-11 17:32:53',80),
(1008,'0 percent',0011,'2018-05-12 18:00:32',32),
(1009,'0 percent',0012,'2018-06-12 09:32:53',37),
(1010,'0 percent',0013,'2018-09-03 10:13:23',132),
(1011,'0 percent',0014,'2018-12-11 13:34:32',123);

--INSERT INTO ToGo
insert into ToGo(orderNum,timeReadied,timePickedUp) values
(0004,'2017-01-09 08:23:00','2017-01-09 08:33:10'),
(0005,'2017-01-11 09:00:33','2017-01-11 09:10:02'),
(0011,'2018-05-12 18:20:30','2018-05-12 18:42:31'),
(0012,'2018-12-11 10:01:33','2018-12-11 10:4:31');

--INSERT INTO Phone
insert into Phone(orderNum,timeCalled) values
(0004,'2017-01-09 07:50:50'),
(0012,'2018-12-11 09:32:43');

--INSERT INTO PhonePay
insert into PhonePay(orderNum,payType,phoneAmount) values
(0004,'CreditCard',43),
(0012,'DebitCard',37);

--INSERT INTO Web
insert into Web(orderNum,creditNumber,webAmount) values
(0005,'5191 2312 3456 7890',43),
(0011,'5529 4203 5061 5465',32);

--INSERT INTO Dine
INSERT INTO Dine(orderNum,EID,timeArrived) values
(0001,2,'2016-11-08 12:30:00'),
(0002,7,'2016-12-11 13:11:00'),
(0003,8,'2017-01-23 15:02:00'),
(0006,2,'2017-02-10 14:15:00'),
(0007,2,'2017-02-10 15:00:00'),
(0008,13,'2017-05-01 15:02:00'),
(0009,2,'2017-12-20 15:47:00'),
(0010,7,'2018-01-11 17:51:00'),
(0013,2,'2018-09-03 9:59:00'),
(0014,8,'2018-12-11 13:20:00');

--INSERT INTO DinePay
INSERT INTO DinePay(orderNum,payType,tableAmount) values
(0001,'CreditCard',12),
(0002,'Cash',15),
(0003,'DebitCard',201),
(0006,'CreditCard',104),
(0007,'DebitCard',43),
(0008,'Cash',45),
(0009,'Cash',20),
(0010,'CreditCard',80),
(0013,'DebitCard',132),
(0014,'DebitCard',123);

--INSERT INTO menuCategory
insert into menuCategory(categoryID, category) values
(010, 'Appetizer'),
(011, 'Soup'),
(012, 'Meat Entrees'),
(013, 'Chow Mein'),
(014, 'Egg Foo Young'),
(015, 'Chop Suey');

--INSERT INTO menuItem
insert into menuItem(menuItemID, itemName, ingredients, spiciness) values

--Appetizer
(100, 'Small Chicken Wings', 'Chicken, Miming-Special Marinated Sauce', 'Mild'),
(101, 'Medium Chicken Wings', 'Chicken, Miming-Special Marinated Sauce', 'Mild'),
(102, 'Large Chicken Wings', 'Chicken, Miming-Special Marinated Sauce', 'Mild'),


(110, 'Small Flaming Chicken Wings', 'Chicken, Miming-Special Marinated Sauce EX', 'Hot'),
(111, 'Medium Flaming Chicken Wings', 'Chicken, Miming-Special Marinated Sauce EX', 'Hot'),
(112, 'Large Flaming Chicken Wings', 'Chicken, Miming-Special Marinated Sauce EX', 'Hot'),


(120, 'Small Volcanic Chicken Wings', 'Chicken, Miming-Special MArinated Sauce EX+', 'Oh My God'),
(121, 'Medium Volcanic Chicken Wings', 'Chicken, Miming-Special MArinated Sauce EX+', 'Oh My God'),
(122, 'Large Volcanic Chicken Wings', 'Chicken, Miming-Special MArinated Sauce EX+', 'Oh My God'),


--Soup
(200, 'Small Curry', 'Curry Paste, Assorted Vegetables, Assorted Meats', 'Mild'),
(201, 'Medium Curry', 'Curry Paste, Assorted Vegetables, Assorted Meats', 'Mild'),
(202, 'Large Curry', 'Curry Paste, Assorted Vegetables, Assorted Meats', 'Mild'),


(210, 'Small Curry+', 'Curry Paste, Assorted Vegetables, Assorted Meats, Chilli Peppers', 'Tangy'),
(211, 'Medium Curry+', 'Curry Paste, Assorted Vegetables, Assorted Meats, Chilli Peppers', 'Tangy'),
(212, 'Large Curry+', 'Curry Paste, Assorted Vegetables, Assorted Meats, Chilli Peppers', 'Tangy'),

--Meat Entrees
(300, 'Small Chef Special Orange Chicken', 'Miming-Special Marinated Sauce, Chicken, Various Spices', 'Mild'),
(301, 'Medium Chef Special Orange Chicken', 'Miming-Special Marinated Sauce, Chicken, Various Spices', 'Mild'),
(302, 'Large Chef Special Orange Chicken', 'Miming-Special Marinated Sauce, Chicken, Various Spices', 'Mild'),

(310, 'Small Pork Chops', 'Prepared Pork', 'Mild'),
(311, 'Medium Pork Chops', 'Prepared Pork', 'Mild'),
(312, 'Large Pork Chops', 'Prepared Pork', 'Mild'),


(320, 'Small Miming Fried Chicken', 'Miming-Special Marinated Sauce, Chicken', 'Tangy'),
(321, 'Medium Miming Fried Chicken', 'Miming-Special Marinated Sauce, Chicken', 'Tangy'),
(322, 'Large Miming Fried Chicken', 'Miming-Special Marinated Sauce, Chicken', 'Tangy'),


(330, 'Small Miming Signature Steak', 'Prepared New York Steak, Various Spices', 'Mild'),
(331, 'Medium Miming Signature Steak', 'Prepared New York Steak, Various Spices', 'Mild'),
(332, 'Large Miming Signature Steak', 'Prepared New York Steak, Various Spices', 'Mild'),


(340, 'Small Honey Baked Shrimp', 'Marinated Shrimp', 'Mild'),
(341, 'Medium Honey Baked Shrimp', 'Marinated Shrimp', 'Mild'),
(342, 'Large Honey Baked Shrimp', 'Marinated Shrimp', 'Mild'),


(350, 'Small Steamed Vegetables', 'Brocolli, Carrots, Cabbage', 'Mild'),
(351, 'Medium Steamed Vegetables', 'Brocolli, Carrots, Cabbage', 'Mild'),
(352, 'Large Steamed Vegetables', 'Brocolli, Carrots, Cabbage', 'Mild'),

--Chow Mein
(400, 'Small Regular Chow Mein', 'Homemade Stir-Fried Noodles', 'Mild'),
(401, 'Medium Regular Chow Mein', 'Homemade Stir-Fried Noodles', 'Mild'),
(402, 'Large Regular Chow Mein', 'Homemade Stir-Fried Noodles', 'Mild'),


(410, 'Small Pork Chow Mein', 'Homemade Stir-Fried Noodles, Pork', 'Mild'),
(411, 'Medium Pork Chow Mein', 'Homemade Stir-Fried Noodles, Pork', 'Mild'),
(412, 'Large Pork Chow Mein', 'Homemade Stir-Fried Noodles, Pork', 'Mild'),


(420, 'Small Chicken Chow Mein', 'Homemade Stir-Fried Noodles, Chicken', 'Mild'),
(421, 'Medium Chicken Chow Mein', 'Homemade Stir-Fried Noodles, Chicken', 'Mild'),
(422, 'Large Chicken Chow Mein', 'Homemade Stir-Fried Noodles, Chicken', 'Mild'),

(430, 'Small Beef Chow Mein', 'Homemade Stir-Fried Noodles, Beef', 'Mild'),
(431, 'Medium Beef Chow Mein', 'Homemade Stir-Fried Noodles, Beef', 'Mild'),
(432, 'Large Beef Chow Mein', 'Homemade Stir-Fried Noodles, Beef', 'Mild'),

(440, 'Small Seafood Chow Mein', 'Homemade Stir-Fried Noodles, Assorted Seafood', 'Mild'),
(441, 'Medium Seafood Chow Mein', 'Homemade Stir-Fried Noodles, Assorted Seafood', 'Mild'),
(442, 'Large Seafood Chow Mein', 'Homemade Stir-Fried Noodles, Assorted Seafood', 'Mild'),

(450, 'Small Vegetable Chow Mein', 'Homemade Stir-Fried Noodles, Stir-Fried Vegetables', 'Mild'),
(451, 'Medium Vegetable Chow Mein', 'Homemade Stir-Fried Noodles, Stir-Fried Vegetables', 'Mild'),
(452, 'Large Vegetable Chow Mein', 'Homemade Stir-Fried Noodles, Stir-Fried Vegetables', 'Mild'),

--Egg Foo Young

(500, 'Small Pork Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Pork', 'Mild'),
(501, 'Medium Pork Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Pork', 'Mild'),
(502, 'Large Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Pork', 'Mild'),

(510, 'Small Chicken Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Chicken', 'Mild'),
(511, 'Medium Chicken Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Chicken', 'Mild'),
(512, 'Large Chicken Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Chicken', 'Mild'),

(520, 'Small Beef Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Beef', 'Mild'),
(521, 'Medium Beef Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Beef', 'Mild'),
(522, 'Large Beef Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Beef', 'Mild'),

(530, 'Small Seafood Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Assorted Seafood', 'Mild'),
(531, 'Medium Seafood Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Assorted Seafood', 'Mild'),
(532, 'Large Seafood Egg Foo Young', 'Eggs, Rice, Assorted Vegetables, Assorted Seafood', 'Mild'),

(540, 'Small Vegetables Egg Foo Young', 'Eggs, Rice, More Assorted Vegetables', 'Mild'),
(541, 'Medium Vegetables Egg Foo Young', 'Eggs, Rice, More Assorted Vegetables', 'Mild'),
(542, 'Large Vegetables Egg Foo Young', 'Eggs, Rice, More Assorted Vegetables', 'Mild'),

--Chop Suey 
(600, 'Small Pork Chop Suey', 'Eggs, Pork, Assorted Vegetables', 'Mild'),
(601, 'Medium Pork Chop Suey', 'Eggs, Pork, Assorted Vegetables', 'Mild'),
(602, 'Large Pork Chop Suey', 'Eggs, Pork, Assorted Vegetables', 'Mild'),

(610, 'Small Chicken Chop Suey', 'Eggs, Chicken, Assorted Vegetables', 'Mild'),
(611, 'Medium Chicken Chop Suey', 'Eggs, Chicken, Assorted Vegetables', 'Mild'),
(612, 'Large Chicken Chop Suey', 'Eggs, Chicken, Assorted Vegetables', 'Mild'),

(620, 'Small Beef Chop Suey', 'Eggs, Beef, Assorted Vegetables', 'Mild'),
(621, 'Medium Beef Chop Suey', 'Eggs, Beef, Assorted Vegetables', 'Mild'),
(622, 'Large Beef Chop Suey', 'Eggs, Beef, Assorted Vegetables', 'Mild'),

(630, 'Small Seafood Chop Suey', 'Eggs, Assorted Seafood, Assorted Vegetables', 'Mild'),
(631, 'Medium Seafood Chop Suey', 'Eggs, Assorted Seafood, Assorted Vegetables', 'Mild'),
(632, 'Large Seafood Chop Suey', 'Eggs, Assorted Seafood, Assorted Vegetables', 'Mild'),

(640, 'Small Vegetable Chop Suey', 'Eggs, More Assorted Vegetables', 'Mild'),
(641, 'Medium Vegetable Chop Suey', 'Eggs, More Assorted Vegetables', 'Mild'),
(642, 'Large Vegetable Chop Suey', 'Eggs, More Assorted Vegetables', 'Mild');

--INSERT INTO menuDate
insert into menuDate(menuItemID, categoryID, dateAdded) values
(100, 010, '2010-01-12'),
(101, 010, '2010-01-13'),
(102, 010, '2010-01-12'),

(110, 010, '2010-01-12'),
(111, 010, '2010-01-13'),
(112, 010, '2010-01-12'),

(120, 010, '2010-01-12'),
(121, 010, '2010-01-13'),
(122, 010, '2010-01-12'),

(200, 011, '2010-01-15'),
(201, 011, '2010-01-12'),
(202, 011, '2010-01-12'),

(210, 011, '2010-01-15'),
(211, 011, '2010-01-12'),
(212, 011, '2010-01-12'),

(300, 012, '2010-01-17'),
(301, 012, '2010-01-01'),
(302, 012, '2010-01-11'),

(310, 012, '2010-01-10'),
(311, 012, '2010-01-20'),
(312, 012, '2010-01-30'),

(320, 012, '2010-01-10'),
(321, 012, '2010-01-20'),
(322, 012, '2010-01-30'),

(330, 012, '2010-01-10'),
(331, 012, '2010-01-20'),
(332, 012, '2010-01-30'),

(340, 012, '2010-01-10'),
(341, 012, '2010-01-20'),
(342, 012, '2010-01-30'),

(350, 012, '2010-01-10'),
(351, 012, '2010-01-20'),
(352, 012, '2010-01-30'),

(400, 013, '2010-01-10'),
(401, 013, '2010-01-20'),
(402, 013, '2010-01-30'),

(410, 013, '2010-01-10'),
(411, 013, '2010-01-20'),
(412, 013, '2010-01-30'),

(420, 013, '2010-01-10'),
(421, 013, '2010-01-20'),
(422, 013, '2010-01-30'),

(430, 013, '2010-01-10'),
(431, 013, '2010-01-20'),
(432, 013, '2010-01-30'),

(440, 013, '2010-01-10'),
(441, 013, '2010-01-20'),
(442, 013, '2010-01-30'),

(450, 013, '2010-01-10'),
(451, 013, '2010-01-20'),
(452, 013, '2010-01-30'),

(500, 014, '2010-01-10'),
(501, 014, '2010-01-20'),
(502, 014, '2010-01-30'),

(510, 014, '2010-01-10'),
(511, 014, '2010-01-20'),
(512, 014, '2010-01-30'),

(520, 014, '2010-01-10'),
(521, 014, '2010-01-20'),
(522, 014, '2010-01-30'),

(530, 014, '2010-01-10'),
(531, 014, '2010-01-20'),
(532, 014, '2010-01-30'),

(540, 014, '2010-01-10'),
(541, 014, '2010-01-20'),
(542, 014, '2010-01-30'),

(600, 015, '2010-01-10'),
(601, 015, '2010-01-20'),
(602, 015, '2010-01-30'),

(610, 015, '2010-01-10'),
(611, 015, '2010-01-20'),
(612, 015, '2010-01-30'),

(620, 015, '2010-01-10'),
(621, 015, '2010-01-20'),
(622, 015, '2010-01-30'),

(630, 015, '2010-01-10'),
(631, 015, '2010-01-20'),
(632, 015, '2010-01-30'),

(640, 015, '2010-01-10'),
(641, 015, '2010-01-20'),
(642, 015, '2010-01-30');

--INSERT INTO menu
insert into menu(menuID, menuName) values
(01, 'Lunch'),
(02, 'Evening'),
(03, 'Sunday Brunch Buffet'),
(04, 'Children');

--INSERT INTO orderSelect
insert into orderSelect(menuID, menuItemID, orderSize, price) values
--Appetizer
--Lunch
(01, 100, 'Small', 2.00),
(01, 101, 'Medium', 2.50),

(01, 110, 'Small', 2.00),
(01, 111, 'Medium', 2.50),

(01, 120, 'Small', 2.00),
(01, 121, 'Medium', 2.50),


--Evening
(02, 100, 'Small' , 3.00),
(02, 101, 'Medium', 3.50),
(02, 102, 'Large', 4.00),

(02, 110, 'Small', 3.50),
(02, 111, 'Medium', 4.00),
(02, 112, 'Large', 4.50),

(02, 120, 'Small', 5.00),
(02, 121, 'Medium', 5.50),
(02, 122, 'Large', 6.00),

--Buffet
(03, 100, 'Small', 0),
(03, 101, 'Medium', 0),
(03, 102, 'Large', 0),

(03, 110, 'Small', 0),
(03, 111, 'Medium', 0),
(03, 112, 'Large', 0),

(03, 120, 'Small', 0),
(03, 121, 'Medium', 0),
(03, 122, 'Large', 0),

--Childrens
(04, 100, 'Small', 1.00),
(04, 110, 'Small', 1.50),

--Soup
--Lunch
(01, 200, 'Small', 1.00),
(01, 201, 'Medium', 1.50),

(01, 210, 'Small', 1.50),
(01, 211, 'Medium', 2.00),

--Evening
(02, 200, 'Small' , 2.00),
(02, 201, 'Medium', 2.50),
(02, 202, 'Large', 3.00),

(02, 210, 'Small', 2.50),
(02, 211, 'Medium', 3.00),
(02, 212, 'Large', 3.50),

--Buffet
(03, 200, 'Small', 0),
(03, 201, 'Medium', 0),
(03, 202, 'Large', 0),

(03, 210, 'Small', 0),
(03, 211, 'Medium', 0),
(03, 212, 'Large', 0),

--Childrens
(04, 200, 'Small', 0.50),

--MeatEntrees
--Lunch
(01, 300, 'Small', 2.00),
(01, 301, 'Medium', 2.50),

(01, 310, 'Small', 1.50),
(01, 311, 'Medium', 2.00),

(01, 320, 'Small', 1.50),
(01, 321, 'Medium', 2.00),

(01, 330, 'Small', 2.00),
(01, 331, 'Medium', 3.00),

(01, 340, 'Small', 3.00),
(01, 341, 'Medium', 4.00),

(01, 350, 'Small', 4.00),
(01, 351, 'Medium', 5.00),

--Evening
(02, 300, 'Small', 2.10),
(02, 301, 'Medium', 2.30),
(02, 302, 'Large', 3.20),

(02, 310, 'Small', 1.50),
(02, 311, 'Medium', 2.20),
(02, 312, 'Large', 2.40),

(02, 320, 'Small', 1.40),
(02, 321, 'Medium', 2.40),
(02, 322, 'Large', 2.30),

(02, 330, 'Small', 2.20),
(02, 331, 'Medium', 3.10),
(02, 332, 'Large', 3.80),

(02, 340, 'Small', 3.30),
(02, 341, 'Medium', 4.20),
(02, 342, 'Large', 4.40),

(02, 350, 'Small', 4.10),
(02, 351, 'Medium', 5.40),
(02, 352, 'Large', 5.55),

--Buffet
(03, 300, 'Small', 0),
(03, 301, 'Medium', 0),
(03, 302, 'Large', 0),

(03, 310, 'Small', 0),
(03, 311, 'Medium', 0),
(03, 312, 'Large', 0),

(03, 320, 'Small', 0),
(03, 321, 'Medium', 0),
(03, 322, 'Large', 0),

(03, 330, 'Small', 0),
(03, 331, 'Medium', 0),
(03, 332, 'Large', 0),

(03, 340, 'Small', 0),
(03, 341, 'Medium', 0),
(03, 342, 'Large', 0),

(03, 350, 'Small', 0),
(03, 351, 'Medium', 0),
(03, 352, 'Large', 0),

--Childrens
(04, 300, 'Small', 1.50),
(04, 310, 'Small', 2.00),
(04, 320, 'Small', 2.50),
(04, 330, 'Small', 3.00),
(04, 340, 'Small', 3.50),
(04, 350, 'Small', 4.00),

--Chow Mein
--Lunch
(01, 400, 'Small', 3.00),
(01, 401, 'Medium', 3.50),

(01, 410, 'Small', 2.50),
(01, 411, 'Medium', 3.00),

(01, 420, 'Small', 2.50),
(01, 421, 'Medium', 3.00),

(01, 430, 'Small', 4.00),
(01, 431, 'Medium', 5.00),

(01, 440, 'Small', 3.00),
(01, 441, 'Medium', 4.00),

(01, 450, 'Small', 5.00),
(01, 451, 'Medium', 6.00),

--Evening
(02, 400, 'Small', 2.00),
(02, 401, 'Medium', 2.50),
(02, 402, 'Large', 3.00),

(02, 410, 'Small', 1.50),
(02, 411, 'Medium', 2.00),
(02, 412, 'Large', 2.50),

(02, 420, 'Small', 1.50),
(02, 421, 'Medium', 2.00),
(02, 422, 'Large', 2.50),

(02, 430, 'Small', 2.00),
(02, 431, 'Medium', 3.00),
(02, 432, 'Large', 3.50),

(02, 440, 'Small', 3.00),
(02, 441, 'Medium', 4.00),
(02, 442, 'Large', 4.50),

(02, 450, 'Small', 4.00),
(02, 451, 'Medium', 5.00),
(02, 452, 'Large', 5.50),

--Buffet
(03, 400, 'Small', 0),
(03, 401, 'Medium', 0),
(03, 402, 'Large', 0),

(03, 410, 'Small', 0),
(03, 411, 'Medium', 0),
(03, 412, 'Large', 0),

(03, 420, 'Small', 0),
(03, 421, 'Medium', 0),
(03, 422, 'Large', 0),

(03, 430, 'Small', 0),
(03, 431, 'Medium', 0),
(03, 432, 'Large', 0),

(03, 440, 'Small', 0),
(03, 441, 'Medium', 0),
(03, 442, 'Large', 0),

(03, 450, 'Small', 0),
(03, 451, 'Medium', 0),
(03, 452, 'Large', 0),

--Childrens
(04, 400, 'Small', 1.50),
(04, 410, 'Small', 2.00),
(04, 420, 'Small', 2.50),
(04, 430, 'Small', 3.00),
(04, 440, 'Small', 3.50),
(04, 450, 'Small', 4.00),

--EggFooYoung
--Lunch
(01, 500, 'Small', 2.00),
(01, 501, 'Medium', 2.50),

(01, 510, 'Small', 1.50),
(01, 511, 'Medium', 2.00),

(01, 520, 'Small', 1.50),
(01, 521, 'Medium', 2.00),

(01, 530, 'Small', 2.00),
(01, 531, 'Medium', 3.00),

(01, 540, 'Small', 3.00),
(01, 541, 'Medium', 4.00),

--Evening
(02, 500, 'Small', 2.00),
(02, 501, 'Medium', 2.50),
(02, 502, 'Large', 3.00),

(02, 510, 'Small', 1.50),
(02, 511, 'Medium', 2.00),
(02, 512, 'Large', 2.50),

(02, 520, 'Small', 1.50),
(02, 521, 'Medium', 2.00),
(02, 522, 'Large', 2.50),

(02, 530, 'Small', 2.00),
(02, 531, 'Medium', 3.00),
(02, 532, 'Large', 3.50),

(02, 540, 'Small', 3.00),
(02, 541, 'Medium', 4.00),
(02, 542, 'Large', 4.50),


--Buffet
(03, 500, 'Small', 0),
(03, 501, 'Medium', 0),
(03, 502, 'Large', 0),

(03, 510, 'Small', 0),
(03, 511, 'Medium', 0),
(03, 512, 'Large', 0),

(03, 520, 'Small', 0),
(03, 521, 'Medium', 0),
(03, 522, 'Large', 0),

(03, 530, 'Small', 0),
(03, 531, 'Medium', 0),
(03, 532, 'Large', 0),

(03, 540, 'Small', 0),
(03, 541, 'Medium', 0),
(03, 542, 'Large', 0),

--Childrens
(04, 500, 'Small', 1.50),
(04, 510, 'Small', 2.00),
(04, 520, 'Small', 2.50),
(04, 530, 'Small', 3.00),
(04, 540, 'Small', 3.50),
--FINE CODE ABOVE

--Lunch
--ChopSuey
(01, 600, 'Small', 2.00),
(01, 601, 'Medium', 2.50),

(01, 610, 'Small', 1.50),
(01, 611, 'Medium', 2.00),

(01, 620, 'Small', 1.50),
(01, 621, 'Medium', 2.00),

(01, 630, 'Small', 2.00),
(01, 631, 'Medium', 3.00),

(01, 640, 'Small', 3.00),
(01, 641, 'Medium', 4.00),

--Evening
(02, 600, 'Small', 2.00),
(02, 601, 'Medium', 2.50),
(02, 602, 'Large', 3.00),

(02, 610, 'Small', 1.50),
(02, 611, 'Medium', 2.00),
(02, 612, 'Large', 2.50),

(02, 620, 'Small', 1.50),
(02, 621, 'Medium', 2.00),
(02, 622, 'Large', 2.50),

(02, 630, 'Small', 2.00),
(02, 631, 'Medium', 3.00),
(02, 632, 'Large', 3.50),

(02, 640, 'Small', 3.00),
(02, 641, 'Medium', 4.00),
(02, 642, 'Large', 4.50),


--Buffet
(03, 600, 'Small', 0),
(03, 601, 'Medium', 0),
(03, 602, 'Large', 0),

(03, 610, 'Small', 0),
(03, 611, 'Medium', 0),
(03, 612, 'Large', 0),

(03, 620, 'Small', 0),
(03, 621, 'Medium', 0),
(03, 622, 'Large', 0),

(03, 630, 'Small', 0),
(03, 631, 'Medium', 0),
(03, 632, 'Large', 0),

(03, 640, 'Small', 0),
(03, 641, 'Medium', 0),
(03, 642, 'Large', 0),

--Childrens
(04, 600, 'Small', 1.50),
(04, 610, 'Small', 2.00),
(04, 620, 'Small', 2.50),
(04, 630, 'Small', 3.00),
(04, 640, 'Small', 3.50);

--INSERT INTO orderTrack
insert into orderTrack(orderNum,menuID,menuItemID,quantity) values
(0001, 01, 100, 2),
(0002, 01, 200, 2),
(0003, 02, 300, 1),
(0004, 02, 400, 1),
(0005, 01, 500, 1),
(0006, 01, 600, 1),
(0007, 01, 540, 1),
(0008, 01, 530, 1),
(0009, 02, 440, 1),
(0010, 01, 300, 1),
(0011, 01, 410, 1),
(0012, 01, 420, 2),
(0013, 04, 430, 2),
(0014, 02, 420, 1);

--INSERT INTO mentoring
INSERT INTO mentoring(EID, menuItemID, startDate, endDate)
    VALUES
        (9, 100, '2018-09-12', '2018-09-20'),
        (10, 100, '2018-09-12', '2018-09-20'),
        (9, 410, '2018-03-20', '2018-03-26'),
        (10, 410, '2018-03-20', '2018-03-26'),

        (24, 410, '2018-04-29', '2018-05-11'),
        (10, 410, '2018-04-29', '2018-05-11'),

        (24, 100, '2016-01-12', '2016-01-20'),
        (25, 100, '2016-01-12', '2016-01-20'),

        (24, 100, '2016-010-12', '2016-10-20'),
        (25, 100, '2016-010-12', '2016-10-20'),

        (24, 440, '2017-05-21', '2017-05-28'),
        (25, 440, '2017-05-21', '2017-05-28'),

        (24, 540, '2017-06-01', '2017-06-03'),
        (25, 540, '2017-06-01', '2017-06-03'),

        (24, 300, '2015-11-15', '2015-11-19'),
        (25, 300, '2015-11-15', '2015-11-19'),
 
        (24, 200, '2016-01-27', '2016-01-29'),
        (25, 200, '2016-01-27', '2016-01-29'),

        (24, 100, '2016-03-09', '2016-03-19'),
        (25, 100, '2016-03-09', '2016-03-19'),

        (24, 120, '2016-05-18', '2015-05-29'),
        (25, 120, '2016-05-18', '2015-05-29'),

        (24, 520, '2016-08-13', '2016-08-19'),
        (25, 520, '2016-08-13', '2016-08-19'),

        (24, 520, '2018-01-13', '2018-01-19'),
        (9, 520, '2018-01-13', '2018-01-19'),

        (10, 300, '2015-01-04', '2018-01-10'),
        (25, 300, '2018-01-04', '2018-01-10'),
        
        (25, 300, '2017-12-24', '2017-12-24'),
        (10, 300, '2017-12-28', '2017-12-28'),
      
        (9, 440, '2018-11-21', '2018-11-28'),
        (25, 440, '2018-11-21', '2018-11-28'),
         
        (25, 440, '2019-01-20', '2019-01-28'),
        (10, 440, '2019-01-20', '2019-01-28'),

        (25, 440, '2019-02-01', '2019-02-05'),
        (10, 440, '2019-02-01', '2019-02-05');


--VIEWS
--1
CREATE VIEW MenuItem_v AS 
SELECT itemName, menuName, ingredients, spiciness FROM menuItem NATURAL JOIN menu;
SELECT * FROM MenuItem_v;

--2 
--CREATE VIEW Customer_Addresses_v AS
SELECT DISTINCT c.customerID, s.customerID, customerName, customerPhone FROM Customers c
INNER JOIN PrivateCustomers s 
ON c.customerID = s.customerID;

--3


--4
CREATE VIEW Customer_Sales_v AS
SELECT customerName, amountSpent FROM Customers NATURAL JOIN Account amountSpent;
SELECT * FROM Customer_Sales_v;

--5
CREATE VIEW Customer_Value_v AS 
SELECT c.customerName, sum(o.total) AS Total FROM 
Customers c LEFT OUTER JOIN Orders o
ON c.customerID = o.customerID
GROUP BY c.customerName
ORDER BY o.total DESC; 
SELECT * FROM Customer_Value_v;


--QUERIES

--2
SELECT c.customerName, sum(o.total) AS Total FROM 
Customers c LEFT OUTER JOIN Orders o
ON c.customerID = o.customerID
GROUP BY c.customerName;


--8 
SELECT customerName AS "Customer Name", MimingsMoney AS "Miming's Money" FROM Customers NATURAL JOIN Account 
ORDER BY MimingsMoney DESC;

--11
SELECT customerName AS "Customer Name", amountSpent AS "Amount Spent" FROM Customers NATURAL JOIN Account
ORDER BY amountSpent DESC LIMIT 3;

--15


--16
SELECT menuName, itemName, price FROM ((menu m INNER JOIN orderSelect o 
ON m.menuID = o.menuID) INNER JOIN menuItem i ON m.menuID = i.menuItemID);

SELECT menuName, itemName, price, spiciness FROM menu NATURAL JOIN orderSelect NATURAL JOIN menuItem;  
