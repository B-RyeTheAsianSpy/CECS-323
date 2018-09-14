CREATE TABLE state(
    stateName VARCHAR(20) NOT NULL,
    dateJoinedUS int,
    governor VARCHAR(20));
    
ALTER TABLE state
    ADD CONSTRAINT state_pk
    PRIMARY KEY(stateName);
    
INSERT INTO state(stateName, dateJoinedUS, governor)
    VALUES ('California', 1800, 'Jerry Brown');
    
CREATE TABLE city(
    cityName VARCHAR(20) NOT NULL,
    stateName VARCHAR(20) NOT NULL,
    population int,
    mayor VARCHAR(20));
    
    
ALTER TABLE city
    ADD CONSTRAINT city_pk
    PRIMARY KEY (cityName, stateName);
    
ALTER TABLE city
    ADD CONSTRAINT city_state_fk
    FOREIGN KEY (stateName)
    REFERENCES state (stateName);
    
INSERT INTO city (cityName, stateName, population, mayor)
    VALUES ('Huntington Beach', 'California', 666666, 'Rouda');
    
select * from state natural join city;

select * from state;

select * from city;

drop table city;

drop table state;