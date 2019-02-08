create table WritingGroup(
  GroupName varchar(30) PRIMARY KEY, 
  HeadWriter varchar(15), 
  YearFormed int, 
  Subject varchar(20)
);
create table Publishers(
  PublisherName varchar(30) PRIMARY KEY, 
  PublisherAddress varchar(50), 
  PublisherPhone varchar(12), 
  PublisherEmail varchar(50)
);
create table Books(
  -- the association class
  GroupName varchar(30), 
  BookTitle varchar(30), 
  PublisherName varchar(20) NOT NULL, 
  YearPublished int, 
  NumberOfPages int, 
  FOREIGN KEY (GroupName) REFERENCES WritingGroup(GroupName), 
  FOREIGN KEY (PublisherName) REFERENCES Publishers(PublisherName)
);
INSERT INTO WritingGroup(
  GroupName, HeadWriter, YearFormed, 
  Subject
) 
VALUES 
  (
    'Benji Book Club', 'Benji', 1998, 
    'Sci-Fi'
  );
INSERT INTO WritingGroup(
  GroupName, HeadWriter, YearFormed, 
  Subject
) 
VALUES 
  (
    'Jing Si Abode', 'Cheng Yen', 1960, 
    'Aphorisms'
  );
INSERT INTO WritingGroup(
  GroupName, HeadWriter, YearFormed, 
  Subject
) 
VALUES 
  (
    'Lego Group', 'Alf', 1998, 'Lego Bricks'
  );
INSERT INTO WritingGroup(
  GroupName, HeadWriter, YearFormed, 
  Subject
) 
VALUES 
  (
    'Upcoming Writers', 'Chelsea', 2018, 
    'Journalism'
  );
INSERT INTO Publishers(
  PublisherName, PublisherAddress, 
  PublisherPhone, PublisherEmail
) 
VALUES 
  (
    '49ers Publishing', '562 Bellflower St.', 
    '562-421-4219', '49publishing@gmail.com'
  );
INSERT INTO Publishers(
  PublisherName, PublisherAddress, 
  PublisherPhone, PublisherEmail
) 
VALUES 
  (
    'Jing Si Publishing', ' 7821 Hualien St.', 
    '822-810-0481', 'jingsi@gmail.com'
  );
INSERT INTO Books(
  GroupName, BookTitle, PublisherName, 
  YearPublished, NumberOfPages
) 
VALUES 
  (
    'Benji Book Club', 'The Biography of Benji', 
    '49ers Publishing', 1998, 341
  );
INSERT INTO Books(
  GroupName, BookTitle, PublisherName, 
  YearPublished, NumberOfPages
) 
VALUES 
  (
    'Upcoming Writers', 'History CSULB', 
    '49ers Publishing', 2020, 666
  );
