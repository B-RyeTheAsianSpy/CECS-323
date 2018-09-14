CREATE TABLE state(
    stateName VARCHAR(20) NOT NULL,
    dateJoinedUS int,
    governor VARCHAR(20));
    
    
INSERT INTO state(stateName, dateJoinedUS, governor)
    VALUES ('California', 1800, 'Jerry Brown');
    
CREATE TABLE city(
    cityName VARCHAR(20) NOT NULL,
    stateName VARCHAR(20) NOT NULL,
    population int,
    mayor VARCHAR(20));
    
    
INSERT INTO city (cityName, stateName, population, mayor)
    VALUES ('Huntington Beach', 'California', 666666, 'Rouda');
    
select * from state natural join city;

select * from state;

select * from city;

drop table city;

drop table state;
