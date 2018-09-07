CREATE TABLE customers (
          cfirstname    VARCHAR(20) NOT NULL,
          clastname     VARCHAR(20) NOT NULL,
          cphone        VARCHAR(20) NOT NULL,
          cstreet       VARCHAR(50),
          czipcode      VARCHAR(5));


ALTER TABLE customers
          ADD CONSTRAINT customers_pk
          PRIMARY KEY (cfirstname, clastname, cphone);

INSERT INTO customers (cfirstname,clastname,cphone,cstreet,czipcode)
          VALUES ('Tom', 'Jewett', '714-555-1212', '10200 Slater', '92708');

INSERT INTO customers (cfirstname,clastname,cphone,cstreet,czipcode)
          VALUES ('Brian', 'Nguyen', '714-321-1112', '4234 Watt Str', '92358');

INSERT INTO customers (cfirstname,clastname,cphone,cstreet,czipcode)
          VALUES ('Benji', 'Nuguian', '417-321-1212', '1111 One Str', '1111');



CREATE TABLE orders (
          cfirstname    VARCHAR(20) NOT NULL,
          clastname     VARCHAR(20) NOT NULL,
          cphone        VARCHAR(20) NOT NULL,
          orderdate     DATE NOT NULL,
          soldby        VARCHAR(20));

ALTER TABLE orders
          ADD CONSTRAINT orders_pk
          PRIMARY KEY (cfirstname, clastname, cphone, orderdate);

ALTER TABLE orders
          ADD CONSTRAINT orders_customers_fk
          FOREIGN KEY (cfirstname, clastname, cphone)
          REFERENCES customers (cfirstname, clastname, cphone);


INSERT INTO orders (cfirstname,clastname,cphone,orderdate,soldby)
          VALUES ('Tom', 'Jewett', '714-555-1212', '2005-09-11', 'Patrick');

INSERT INTO orders (cfirstname,clastname,cphone,orderdate,soldby)
          VALUES ('Brian', 'Nguyen', '714-321-1112', '2017-09-11', 'Sketchy Person');

INSERT INTO orders (cfirstname,clastname,cphone,orderdate,soldby)
          VALUES ('Brian', 'Nguyen', '714-321-1112', '2018-10-12', 'Sketchy Person 2');


SELECT * FROM customers NATURAL JOIN orders;

SELECT * FROM customers;