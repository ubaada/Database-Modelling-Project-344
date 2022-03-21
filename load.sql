DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE outlet CASCADE CONSTRAINTS;
DROP TABLE supplier CASCADE CONSTRAINTS;  
DROP TABLE supply_order CASCADE CONSTRAINTS; 
DROP TABLE supply_order_line CASCADE CONSTRAINTS;
DROP TABLE saleLine CASCADE CONSTRAINTS; 
DROP TABLE sale CASCADE CONSTRAINTS; 
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS; 
DROP TABLE review CASCADE CONSTRAINTS;

CREATE TABLE employee
        (irdnum NUMBER(10) PRIMARY KEY,
         outlet_id VARCHAR2(10) NOT NULL,
         name VARCHAR2(256) NOT NULL,
         email VARCHAR2(320) NOT NULL,
         phone NUMBER(15) NOT NULL,
         dob DATE,
         salary NUMBER(10) NOT NULL
       );

CREATE TABLE outlet
        (outlet_id VARCHAR2(10) PRIMARY KEY,
         manager_id NUMBER(10) NOT NULL,
         phone NUMBER(15),
         city VARCHAR2(20) NOT NULL,
         suburb VARCHAR2(20),
         post_code VARCHAR2(4) NOT NULL,
         addressline_1 VARCHAR2(20) NOT NULL,
         addressline_2 VARCHAR2(20),
         addressline_3 VARCHAR2(20)
        );

CREATE TABLE supplier 
       (nzbn NUMBER(13) PRIMARY KEY, 
             name VARCHAR2(256) NOT NULL, 
             website VARCHAR2(30), 
             addressline_1 VARCHAR2(20) NOT NULL,  
             addressline_2 VARCHAR2(20),  
             addressline_3 VARCHAR2(20), 
             suburb VARCHAR2(20),  
             city VARCHAR2(20) NOT NULL, 
             post_code NUMBER(4) NOT NULL, 
             phone NUMBER(15), 
             email VARCHAR2(320) 
); 

CREATE TABLE supply_order 
       (supply_order_id NUMBER(10) PRIMARY KEY, 
       supplier_nzbn NUMBER(13), 
       outlet_id VARCHAR2(10) NOT NULL, 
       order_date DATE NOT NULL, 
       delivery_date DATE 
); 

CREATE TABLE supply_order_line 
       (supply_order_id NUMBER(10), 
       product_id VARCHAR2(16), 
       quantity NUMBER(10) NOT NULL,
       PRIMARY KEY(supply_order_id, product_id)
);

CREATE TABLE customer (   
       customer_id VARCHAR2(10) PRIMARY KEY,   
       name VARCHAR2(50) NOT NULL,   
       email VARCHAR2(320) NOT NULL,   
       phone NUMBER(10) NOT NULL,
       city VARCHAR2(20) NOT NULL, 
       suburb VARCHAR2(20),   
       post_code VARCHAR2(4) NOT NULL,   
       addressline_1 VARCHAR2(20) NOT NULL,   
       addressline_2 VARCHAR2(20),   
       addressline_3 VARCHAR2(20),  
       dob DATE NOT NULL  
);   

CREATE TABLE sale (   
       sale_id VARCHAR2(10) PRIMARY KEY,   
       outlet_id VARCHAR2(10) NOT NULL,   
       customer_id VARCHAR2(10) NOT NULL,   
       employee_ird NUMBER(10) NOT NULL,   
       payment_method VARCHAR2(20) NOT NULL,   
       sale_date DATE NOT NULL  
);   



CREATE TABLE saleLine (   
       sale_id VARCHAR2(10),   
       product_id VARCHAR2(16),   
       quantity NUMBER(10) NOT NULL,
       PRIMARY KEY(sale_id, product_id)
);

CREATE TABLE product ( 
       product_id  VARCHAR2(16) PRIMARY KEY, -- Made longer to fit UPC and EAN 
       name        VARCHAR2(256) NOT NULL, 
       description CLOB, -- Allow lack of a description 
       type        VARCHAR2(256), -- Allow lack of a type 
       brand       VARCHAR2(256), -- Allow lack of a brand 
       unit_cost   NUMBER(*,2) CHECK (unit_cost >= 0), -- Allow lack of a unit cost, make sure cost is non-zero 
       unit_price  NUMBER(*,2) NOT NULL CHECK (unit_price >= 0) -- Make sure price is non-zero 
); 

CREATE TABLE review ( 
       product_id VARCHAR2(16) REFERENCES product(product_id), 
       reviewer VARCHAR2(256), 
       body CLOB NOT NULL, 
       rating NUMBER(2) NOT NULL CHECK (rating BETWEEN 0 AND 10), 
       post_date DATE NOT NULL, 
       PRIMARY KEY(product_id, reviewer) 
);

INSERT INTO employee VALUES (153456789, '192837465', 'Oliver Wallace', 'oliver@gmail.com', 02131249532, TO_DATE('09-01-1965','DD-MM-YYYY'), 1000000);
INSERT INTO employee VALUES (153456788, '192837465', 'Aaron Rumpler', 'aaronrumpler@gmail.com', 02704865213, TO_DATE('23-11-1999','DD-MM-YYYY'), 1231231);
INSERT INTO employee VALUES (153456787, '192837464', 'Hugo Baird', 'hugobaird@gmail.com', 02108120097, TO_DATE('12-03-1999','DD-MM-YYYY'), 10021);
INSERT INTO employee VALUES (153456786, '192837464', 'Connor Sullivan', 'connorsullivan@gmail.com', 02386402841, TO_DATE('06-04-2000','DD-MM-YYYY'), 132123);
INSERT INTO employee VALUES (153456785, '192837463', 'Ubaada Qureshi', 'ubaadaqureshi@gmail.com', 02502347291, TO_DATE('09-12-1997','DD-MM-YYYY'), 1232344);
INSERT INTO employee VALUES (153456784, '192837463', 'Mellissa Munroe', 'mellissamunroe@gmail.com', 02131485912, TO_DATE('14-05-1993','DD-MM-YYYY'), 65000);
INSERT INTO employee VALUES (153456783, '192837465', 'Stuart Ogilvie', 'stuartogilvie@gmail.com', 02212957839102, TO_DATE('09-10-1998','DD-MM-YYYY'), 902323);
INSERT INTO employee VALUES (153456782, '192837463', 'Husam Ali', 'husamali@gmail.com', 02923573180913,  TO_DATE('21-08-1997','DD-MM-YYYY'), 2133232);

INSERT INTO outlet VALUES ('192837465', 153456789, 02394532312, 'Auckland', 'North Shore',  '1233', '6', 'Oakwood St', 'Meadowlane');
INSERT INTO outlet VALUES ('192837464', 153456785, 02394532312, 'Wanaka', 'Meadowstone',  '9015', '10', 'Ace St', 'Devbort');
INSERT INTO outlet VALUES ('192837463', 153456782, 02394532312, 'Dunedin', 'South Dunedin',  '9016', '53B', 'Clyde St', 'Laneway');

INSERT INTO supplier VALUES (2341234567890, 'Ubaada Computing', 'ubaadacomputing.blog', '3', 'Computer', 'Street', 'North Dunedin', 'Dunedin', '9016', 0223453555, 'ubaadacomputing@gmail.com'); 
INSERT INTO supplier VALUES (5341343464843, 'Hugo Computing', 'hugocomputing.com', '4', 'Computer', 'Street', 'North Dunedin', 'Dunedin', '9016', 0271234567, 'hugocomputing@gmail.com'); 
INSERT INTO supplier VALUES (4437832573280, 'Aaron Computing', 'aaroncomputing.com', '5', 'Computer', 'Street', 'North Dunedin', 'Dunedin', '9016', 0212229999, 'aaroncomputing@facebook.com'); 
INSERT INTO supplier VALUES (4234234235555, 'Connor Electronics', 'connorelectronics.com', '6', 'Computer', 'Street', 'North Dunedin', 'Dunedin', '9016', 0279998882, 'connorelectronics@gmail.com'); 

INSERT INTO supply_order VALUES (12345678, 2341234567890, '192837465', TO_DATE('09-08-2020', 'DD-MM-YYYY') ,TO_DATE('16-08-2020', 'DD-MM-YYYY')); 
INSERT INTO supply_order VALUES (12345679, 5341343464843, '192837464', TO_DATE('09-08-2020', 'DD-MM-YYYY'), TO_DATE('15-08-2020', 'DD-MM-YYYY')); 
INSERT INTO supply_order VALUES (12345680, 4437832573280, '192837463', TO_DATE('09-08-2020', 'DD-MM-YYYY'), TO_DATE('17-08-2020', 'DD-MM-YYYY')); 
INSERT INTO supply_order VALUES (12345681, 4234234235555, '192837465', TO_DATE('02-08-2020', 'DD-MM-YYYY'), TO_DATE('09-08-2020', 'DD-MM-YYYY')); 

INSERT INTO supply_order_line VALUES (12345678, '2234335541', 3); 
INSERT INTO supply_order_line VALUES (12345679, '3435543538', 10); 
INSERT INTO supply_order_line VALUES (12345680, '8948989753', 78); 
INSERT INTO supply_order_line VALUES (12345681, '3475435432', 1);

INSERT INTO customer VALUES('9999999991','Donald Trump','dony@gmail.com',1234567890, 'Washington', 'Washington DC','0407','White House st','Main Building','Room1', TO_DATE('06-04-2000','DD-MM-YYYY')); 
INSERT INTO customer VALUES('9999999992','J Lenin','comm@gmail.com',9994567890, 'Arsuhda','Moscow Sub','1232','StPete st','apart 3','Room2', TO_DATE('06-04-1967','DD-MM-YYYY'));
INSERT INTO customer VALUES('9999999993','Martin L. King','martin@gmail.com',8744567890, 'Dunedin', 'Georgia Sub','1232','George st','plot 2','Building #2', TO_DATE('06-04-1903','DD-MM-YYYY'));  

INSERT INTO sale VALUES('8888888881','192837465', '9999999991', 153456789,'Cash', TO_DATE('06-01-2015','DD-MM-YYYY')); 
INSERT INTO sale VALUES('8888888882','192837464', '9999999992', 153456789,'Card', TO_DATE('06-01-2020','DD-MM-YYYY'));
INSERT INTO sale VALUES('8888888883','192837464', '9999999993', 153456783,'Card', TO_DATE('07-06-2020','DD-MM-YYYY'));  

INSERT INTO saleline VALUES('8888888881','2234335541',4); 
INSERT INTO saleline VALUES('8888888882','3435543538',33);
INSERT INTO saleline VALUES('8888888883','2234335541',4); 
INSERT INTO saleline VALUES('8888888882','8948989753',7);  
INSERT INTO saleline VALUES('8888888883','3435543538',33);  
INSERT INTO saleline VALUES('8888888881','3475435432',9); 
INSERT INTO saleline VALUES('8888888882','2234335541',1);  
INSERT INTO saleline VALUES('8888888883','3475435432',3); 

-- Description copied from Noel Leeming 
INSERT INTO product(product_id, name, description, type, brand, unit_cost, unit_price) VALUES 
('2234335541', 'AirFly Pro', 'AirFly Pro is a wireless headphone adapter that lets you use your favorite wireless headphones or earbuds in places that only have a headphone jack.', 'Audio Dongle', 'Twelve South', 30.00, 89.99); 
-- Description copied from Noel Leeming 
INSERT INTO product(product_id, name, description, type, brand, unit_cost, unit_price) VALUES 
('3435543538', 'Tello Drone', 'Perform flying stunts, shoot quick videos with EZ Shots, and learn about drones with coding education. Get yourself a Tello to find out just how awesome flying a drone can be. Powered by DJI: Using DJI''s smart technology.', 'Drone', 'RYZE Tech', 80.00, 199.00); 
INSERT INTO product(product_id, name, description, type, brand, unit_cost, unit_price) VALUES 
('8948989753', 'Tello Battery', 'You''ll need this with the Tello drone''s short battery life!', 'Drone Battery', 'RYZE Tech', 5.00, 29.99); 
INSERT INTO product(product_id, name, description, type, brand, unit_cost, unit_price) VALUES 
('3475435432', 'Thunderbolt 3 Pro Cable (2 m)', 'This expensive cable supports everything you''d want in a USB-C cable: Thunderbolt 3, USB 3.1 Gen 2 (what a mouthful!), DisplayPort Alternate Mode and USB-PD up to 100W. And no, before you ask, there doesn''t seem to be anything else cheaper on the market.', 'Thunderbolt 3 Cable', 'Apple', 219.00, 219.00);

INSERT INTO review(product_id, reviewer, body, rating, post_date) VALUES  
('8948989753', 'Aaron Rumpler', 'Absolute must, buy at least 20 if you want to fly the thing for any reasonable length of time.', 9.8, TO_DATE('19-08-2020', 'DD-MM-YYYY')); 
INSERT INTO review(product_id, reviewer, body, rating, post_date) VALUES  
('3475435432', 'Apple-Hater', '$200 for a cable? Really? Absolute ripoff. I''m sure I could get this for $5 from AliExpress!', 0.2, TO_DATE('17-08-2020', 'DD-MM-YYYY')); 
INSERT INTO review(product_id, reviewer, body, rating, post_date) VALUES  
('3475435432', 'Apple Fanboy', 'Nothing else on the market that does what this cable does. Even cables that just do Thunderbolt 3 cost a similar amount.', 8.4, TO_DATE('18-08-2020', 'DD-MM-YYYY'));

ALTER TABLE employee ADD CONSTRAINT outletid_emp_cnst FOREIGN KEY(outlet_id) REFERENCES outlet(outlet_id);
ALTER TABLE outlet ADD CONSTRAINT managerid_emp_cnst FOREIGN KEY(manager_id) REFERENCES employee(irdnum);
ALTER TABLE supply_order ADD CONSTRAINT supplier_supplyorder_cnst FOREIGN KEY(supplier_NZBN) REFERENCES supplier(nzbn);
ALTER TABLE supply_order ADD CONSTRAINT outlet_supplyorder_cnst FOREIGN KEY(outlet_id) REFERENCES outlet(outlet_id);  
ALTER TABLE supply_order_line ADD CONSTRAINT supplyorder_supplyorderline_cnst FOREIGN KEY(supply_order_id) REFERENCES supply_order(supply_order_id);
ALTER TABLE Sale ADD CONSTRAINT sale_customer_fk FOREIGN KEY(customer_id) REFERENCES Customer(customer_id);   
ALTER TABLE Sale ADD CONSTRAINT sale_outlet_fk FOREIGN KEY(outlet_id) REFERENCES outlet(outlet_id);  
ALTER TABLE Sale ADD CONSTRAINT sale_employee_fk FOREIGN KEY(employee_ird) REFERENCES employee(irdnum);   
ALTER TABLE SaleLine ADD CONSTRAINT saleline_sale_fk FOREIGN KEY(sale_id) REFERENCES Sale(sale_id); 
ALTER TABLE SaleLine ADD CONSTRAINT saleline_product_fk FOREIGN KEY(product_id) REFERENCES product(product_id);   
