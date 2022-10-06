DROP TABLE Manages;
DROP TABLE FrontDeskEmployee;
DROP TABLE BooksGym;
DROP TABLE BooksClass;
DROP TABLE Class1;
DROP TABLE Class2;
DROP TABLE Customer2;
DROP TABLE Payment;
DROP TABLE Customer1;
DROP TABLE Lockers;
DROP TABLE GymTimeSlot;
DROP TABLE Gym;
DROP TABLE PersonalTrainer;

CREATE TABLE FrontDeskEmployee
(StaffID INTEGER,
 Name CHAR(25),
 PRIMARY  KEY(StaffID));

GRANT SELECT ON FrontDeskEmployee TO PUBLIC;

CREATE TABLE PersonalTrainer
(StaffID INTEGER,
 trainerName    CHAR(25),
 PRIMARY KEY (StaffID));

GRANT SELECT ON PersonalTrainer TO PUBLIC;

CREATE TABLE Lockers
(LockerNumber INTEGER,
 Type    CHAR(25),
 PRIMARY KEY (LockerNumber));

GRANT SELECT ON Lockers TO PUBLIC;

CREATE TABLE Class2
(ClassName        CHAR(20),
 classSize         INTEGER,
 PRIMARY KEY (ClassName));

GRANT SELECT ON Class2 TO PUBLIC;

CREATE TABLE Customer2
(UserName     CHAR(20),
 Password     CHAR(20),
 PRIMARY KEY (UserName));

GRANT SELECT ON Customer2 TO PUBLIC;

CREATE TABLE Gym
(Location    CHAR(30),
 GymName    CHAR(10),
 PRIMARY KEY (Location,GymName));

GRANT SELECT ON Gym TO PUBLIC;

CREATE TABLE Manages
( StaffID INTEGER,
  Location    CHAR(30)       NOT NULL,
  GymName    CHAR(10)        NOT NULL,
  FOREIGN KEY (StaffID)
      REFERENCES FrontDeskEmployee(StaffID),

  FOREIGN KEY (Location,GymName)
      REFERENCES Gym(Location,GymName)
    ON DELETE CASCADE);

GRANT SELECT ON Manages TO PUBLIC;

CREATE TABLE Class1
(ClassName        CHAR(20),
 classTime         INTEGER,
 classDate         INTEGER,
 PersonalTrainerID  INTEGER  NOT NULL,
 PRIMARY KEY (ClassName,classTime,classDate),
 FOREIGN KEY (ClassName) REFERENCES Class2(ClassName),
 FOREIGN KEY (PersonalTrainerID) REFERENCES PersonalTrainer(StaffID)
     ON DELETE CASCADE);

GRANT SELECT ON Class1 TO PUBLIC;

CREATE TABLE Customer1
(Email        CHAR(30),
 AccountType  CHAR(10),
 Address      CHAR(50),
 PhoneNumber  INTEGER,
 Name         CHAR(25),
 UserName     CHAR(20)  UNIQUE,
 PersonalTrainerID  INTEGER   NOT NULL,
 PRIMARY KEY (Email),
 FOREIGN KEY (PersonalTrainerID) REFERENCES PersonalTrainer(StaffID)
     ON DELETE CASCADE);

GRANT SELECT ON Customer1 TO PUBLIC;

CREATE TABLE Payment
(ReferenceNumber INTEGER,
 Amount          INTEGER,
 payDate            INTEGER,
 Email           CHAR(30) NOT NULL,
 PRIMARY KEY (ReferenceNumber),
 FOREIGN KEY (Email) REFERENCES Customer1(Email)
     ON DELETE CASCADE);

GRANT SELECT ON Payment TO PUBLIC;

CREATE TABLE BooksClass
(className         CHAR(20),
 ClassTime         INTEGER,
 bookDate         INTEGER,
 Email        CHAR(30),
 FOREIGN KEY (className,ClassTime,bookDate) REFERENCES Class1(className,ClassTime,classDate),
 FOREIGN KEY (Email) REFERENCES  Customer1(Email)
     ON DELETE CASCADE);

GRANT SELECT ON BooksClass TO PUBLIC;

CREATE TABLE GymTimeSlot
(Location    CHAR(30)  NOT NULL,
 GymName    CHAR(10)   NOT NULL,
 Time INTEGER,
 GymDate INTEGER,
 PRIMARY KEY (Location,GymName,Time,GymDate),
 FOREIGN KEY (Location,GymName)
     REFERENCES Gym(Location,GymName)
         ON DELETE CASCADE);

GRANT SELECT ON GymTimeSlot TO PUBLIC;


CREATE TABLE BooksGym
(Email        CHAR(30),
 LockerNumber INTEGER,
 Location     CHAR(30)    NOT NULL,
 GymName      CHAR(10)  NOT NULL,
 Time         INTEGER     NOT NULL,
 BookDate         INTEGER    NOT NULL,
 FOREIGN KEY (Email) REFERENCES Customer1(Email),
 FOREIGN KEY (LockerNumber) REFERENCES Lockers(LockerNumber),
 FOREIGN KEY (Location, GymName,Time,BookDate)
     REFERENCES GymTimeSlot(Location, GymName,Time,GymDate),
 FOREIGN KEY (Location,GymName)  REFERENCES Gym(Location,GymName)
     ON DELETE CASCADE);

GRANT SELECT ON BooksGym TO PUBLIC;


insert into FrontDeskEmployee
values(1000,'Kevin Malone');
insert into FrontDeskEmployee
values(1001,'Michael Scott');
insert into FrontDeskEmployee
values(1002,'James Halpert');
insert into FrontDeskEmployee
values(1003,'Kelly Kapur');
insert into FrontDeskEmployee
values(1004,'Toby Flenderson');


insert into PersonalTrainer
values(1004,'Darryl Philban');
insert into PersonalTrainer
values(1005,'Dwight Schrute');
insert into PersonalTrainer
values(1006,'Mose Schrute');
insert into PersonalTrainer
values(1007,'Meredith Palmer');
insert into PersonalTrainer
values(1008,'Creed Braton');


insert into Customer1
values('user1@ubc.ca', 'Student', 'Main Mall 1', 1234567890,'Alice','user1',1004);
insert into Customer1
values('user2@ubc.ca', 'Student', 'Main Mall 2', 1234567891,'Ben','user2',1004);
insert into Customer1
values('user3@ubc.ca', 'Staff', 'Main Mall 2', 1234567892,'Chaz','user3',1005);
insert into Customer1
values('user4@ubc.ca', 'Staff', 'Main Mall 3', 1234567893,'Dagm','user4',1006);
insert into Customer1
values('user5@ubc.ca', 'Staff', 'Main Mall 4', 1234567894,'Eugene','user5',1007);


insert into Customer2
values('user1', 'password1');
insert into Customer2
values('user2', 'password2');
insert into Customer2
values('user3', 'password3');
insert into Customer2
values('user4', 'password4');
insert into Customer2
values('user5', 'password5');


insert into Gym
values('Life Building','ARC' );
insert into Gym
values('location2','Gym2' );
insert into Gym
values('location3','Gym3');
insert into Gym
values('location4','Gym4' );
insert into Gym
values('location5','Gym5' );


insert  into Lockers
values(100, 'Daily');
insert  into Lockers
values(101, 'Monthly');
insert  into Lockers
values(102, 'Daily');
insert  into Lockers
values(103, 'Daily');
insert  into Lockers
values(104, 'Monthly');

insert into Class2
values('Muscle Toning', 40);
insert into Class2
values('Zumba', 50);
insert into Class2
values('Aerobic', 30);
insert into Class2
values('Weight Training', 20);
insert into Class2
values('Aerobic 2', 40);

insert  into Class1
values('Muscle Toning', 2400, 10302021, 1004 );
insert  into Class1
values('Zumba', 0330, 10312021, 1005 );
insert  into Class1
values('Aerobic', 1000, 11012021, 1006 );
insert  into Class1
values('Weight Training', 2300, 11012021, 1008 );
insert  into Class1
values('Aerobic 2', 2200, 10302021, 1007 );



insert into Manages
values(1004,'Life Building','ARC');
insert into Manages
values(1001,'location5','Gym5');
insert into Manages
values(1002,'location2','Gym2');
insert into Manages
values(1003,'location3','Gym3');
insert into Manages
values(1004,'location4','Gym4');

insert into GymTimeSlot
values('Life Building', 'ARC', 1200, 10302021);
insert into GymTimeSlot
values('location2', 'Gym2', 2400, 10312021);
insert into GymTimeSlot
values('location3', 'Gym3', 0900, 11302021);
insert into GymTimeSlot
values('location5', 'Gym5', 1200, 10302021);
insert into GymTimeSlot
values('location4', 'Gym4', 1200, 12302021);


insert into BooksGym
values('user1@ubc.ca', 100, 'location2', 'Gym2', 2400, 10312021 );
insert into BooksGym
values('user2@ubc.ca', 101, 'location5', 'Gym5', 1200, 10302021);
insert into BooksGym
values('user3@ubc.ca', 102, 'location3', 'Gym3', 0900, 11302021);
insert into BooksGym
values('user4@ubc.ca', 104, 'location4', 'Gym4', 1200, 12302021);
insert into BooksGym
values('user5@ubc.ca', 103, 'Life Building', 'ARC', 1200, 10302021);


insert into BooksClass
values('Muscle Toning', 2400,10302021, 'user1@ubc.ca');
insert into BooksClass
values('Zumba', 0330,10312021, 'user2@ubc.ca');
insert into BooksClass
values('Aerobic', 1000,11012021, 'user3@ubc.ca');
insert into BooksClass
values('Weight Training', 2300,11012021, 'user4@ubc.ca');
insert into BooksClass
values('Aerobic 2', 2200,10302021, 'user5@ubc.ca');

insert into Payment
values(123456, 20, 10302021,'user1@ubc.ca');
insert into Payment
values(123457, 100, 10302021,'user2@ubc.ca');
insert into Payment
values(123458, 20, 10302021,'user3@ubc.ca');
insert into Payment
values(123459, 20, 10302022,'user4@ubc.ca');
insert into Payment
values(123460, 30, 11302021,'user5@ubc.ca');