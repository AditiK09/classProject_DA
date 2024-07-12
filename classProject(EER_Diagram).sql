create database project;
use project;

create table productlines(
productline varchar(50) primary key,
textDescription VARCHAR(4000),
htmlDescription MEDIUMTEXT,
image MEDIUMBLOB
);

create table products(
 productCode VARCHAR(15) PRIMARY KEY,
 productName VARCHAR(70) NOT NULL,
 productLine VARCHAR(50),
 productScale VARCHAR(10) NOT NULL,
 productVendor VARCHAR(50) NOT NULL,
 productDescription TEXT NOT NULL,
 quantityInStock SMALLINT NOT NULL,
 buyPrice DECIMAL(10, 2) NOT NULL,
 MSRP DECIMAL(10, 2) NOT NULL,
 constraint fk_const foreign key (productLine)
 references productlines(productline)
 on update cascade
 on delete cascade
 );
 
create table offices(
 officeCode VARCHAR(10) PRIMARY KEY,
 city VARCHAR(50) NOT NULL,
 phone VARCHAR(50) NOT NULL,
 addressLine1 VARCHAR(50) NOT NULL,
 addressLine2 VARCHAR(50),
 state VARCHAR(50),
 country VARCHAR(50) NOT NULL,
 postalCode VARCHAR(15) NOT NULL,
 territory VARCHAR(10) NOT NULL
 );
 
 
create table employees(
 employeeNumber INT PRIMARY KEY,
 lastName VARCHAR(50) NOT NULL,
 firstName VARCHAR(50) NOT NULL,
 extension VARCHAR(10) NOT NULL,
 email VARCHAR(100) NOT NULL,
 officeCode VARCHAR(10),
 reportsTo INT,
 jobTitle VARCHAR(50) NOT NULL,
 constraint fk_constraint foreign key (officeCode)
 references offices(officeCode)
 on update cascade
 on delete cascade
 );

alter table employees 
add constraint fk_cons foreign key (reportsTo)
references employees(employeeNumber);

create table customer(
customerNumber INT PRIMARY KEY,
customerName VARCHAR(50) NOT NULL,
contactLastName VARCHAR(50) NOT NULL,
contactFirstName VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50),
city VARCHAR(50) NOT NULL,
state VARCHAR(50),
postalCode VARCHAR(15),
country VARCHAR(50) NOT NULL,
salesRepEmployeeNumber INT,
creditLimit DECIMAL(10, 2),
constraint FK_CON foreign key(salesRepEmployeeNumber)
references employees(employeeNumber)
on update cascade
on delete cascade
);

create table `order`
(
orderNumber INT PRIMARY KEY,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE,
status VARCHAR(15) NOT NULL,
comments TEXT,
customerNumber INT,
constraint const foreign key (customerNumber)
REFERENCES customer(customerNumber)
on update cascade
on delete cascade
);

create table payment(
customerNumber INT,
checkNumber VARCHAR(50) PRIMARY KEY,
paymentDate DATE NOT NULL,
amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY(customerNumber) REFERENCES customer(customerNumber)
on update cascade
on delete cascade
);


create table orderDetails(
orderNumber INT,
productCode VARCHAR(15), 
quantityOrdered INT NOT NULL,
priceEach DECIMAL(10, 2) NOT NULL,
orderLineNumber SMALLINT NOT NULL,
primary key(orderNumber, productCode),
constraint CONS FOREIGN KEY(orderNumber)  REFERENCES `order`(orderNumber),
CONSTRAINT fk FOREIGN KEY(productCode) REFERENCES products(productCode)
);
