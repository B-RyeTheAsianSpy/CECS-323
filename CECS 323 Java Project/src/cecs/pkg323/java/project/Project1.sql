-- BY BRIAN NGUYEN

-- TABLES --

-- WritingGroup table
-- PK: GroupName
create table WritingGroup(
  GroupName varchar(30) NOT NULL, 
  HeadWriter varchar(15), 
  YearFormed int, 
  Subject varchar(20),
  CONSTRAINT pk_writinggroup PRIMARY KEY (GroupName)
);

-- Publishers talbe
-- PK: PublisherName
create table Publishers(
  PublisherName varchar(30) NOT NULL, 
  PublisherAddress varchar(50), 
  PublisherPhone varchar(12), 
  PublisherEmail varchar(50),
  CONSTRAINT pk_publishers PRIMARY KEY (PublisherName)
);

-- Books table
-- the association class of WritingGroup and Publishers
-- PK: GroupName, BookTitle
-- FK: GroupName, PublisherName
create table Books(
  GroupName varchar(30) NOT NULL, 
  BookTitle varchar(30) NOT NULL, 
  PublisherName varchar(30) NOT NULL, 
  YearPublished int, 
  NumberOfPages int, 
  CONSTRAINT pk_books PRIMARY KEY (GroupName, BookTitle)
);

ALTER TABLE Books
    ADD CONSTRAINT wrtinggroup_book_fk
    FOREIGN KEY (GroupName)
    REFERENCES WritingGroup(GroupName);

ALTER TABLE Books
    ADD CONSTRAINT publishers_book_fk
    FOREIGN KEY (PublisherName)
    REFERENCES Publishers(PublisherName);

-- VALUES --

-- WrtingGroup
INSERT INTO WritingGroup(GroupName, HeadWriter, YearFormed, Subject)
  VALUES('Benji Book Club', 'Benji', 1998, 'Sci-Fi');
  
INSERT INTO WritingGroup(GroupName, HeadWriter, YearFormed, Subject)
  VALUES('Jing Si Abode', 'Cheng Yen', 1960, 'Aphorisms');
  
INSERT INTO WritingGroup(GroupName, HeadWriter, YearFormed, Subject)
  VALUES('Lego Group', 'Alf', 1998, 'Lego Bricks');
  
INSERT INTO WritingGroup(GroupName, HeadWriter, YearFormed, Subject)
  VALUES('Upcoming Writers', 'Chelsea', 2018, 'Journalism');
  
-- Publishers
INSERT INTO Publishers(PublisherName, PublisherAddress, PublisherPhone, PublisherEmail)
  VALUES('49ers Publishing', '562 Bellflower St.', '562-421-4219', '49publishing@gmail.com');
  
INSERT INTO Publishers(PublisherName, PublisherAddress, PublisherPhone, PublisherEmail)
  VALUES('Jing Si Publishing', ' 7821 Hualien St.', '822-810-0481', 'jingsi@gmail.com');

INSERT INTO Publishers(PublisherName, PublisherAddress, PublisherPhone, PublisherEmail)
  VALUES('Marvel Comics', ' 4719 Albertson Blvd.', '901-233-1290', 'marvelcomics@gmail.com');

-- Books
INSERT INTO Books(GroupName, BookTitle, PublisherName, YearPublished, NumberOfPages)
  VALUES('Benji Book Club', 'The Biography of Benji', '49ers Publishing', 1998, 341);
  
INSERT INTO Books(GroupName, BookTitle, PublisherName, YearPublished, NumberOfPages)
  VALUES('Upcoming Writers', 'History CSULB', '49ers Publishing', 2020, 666);

