CREATE DATABASE NormalizationDemo;
GO

USE NormalizationDemo;
GO

-- First Normal Form (1NF)

CREATE TABLE Orders_Unnormalized (
    OrderID INT,
    CustomerName NVARCHAR(100),
    CustomerPhone NVARCHAR(20),
    Product1 NVARCHAR(100),
    Product2 NVARCHAR(100),
    Product3 NVARCHAR(100)
);


INSERT INTO Orders_Unnormalized VALUES
(1, 'Nadia', '1234567890', 'Laptop', 'Mouse', 'Keyboard'),
(2, 'Marcel', '0987654321', 'Monitor', NULL, NULL);


CREATE TABLE Orders_1NF (
    OrderID INT,
    CustomerName NVARCHAR(100),
    CustomerPhone NVARCHAR(20),
    Product NVARCHAR(100)
);

INSERT INTO Orders_1NF VALUES
(1, 'Zahra', '1234567890', 'Laptop'),
(1, 'Zahra', '1234567890', 'Mouse'),
(1, 'Zahra', '1234567890', 'Keyboard'),
(2, 'Thariq', '0987654321', 'Monitor');


-- Second Normal Form (2NF)

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    CustomerPhone NVARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    Product NVARCHAR(100),
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


INSERT INTO Customers VALUES
(1, 'Zahra', '1234567890'),
(2, 'Thariq', '0987654321');

INSERT INTO Orders VALUES
(1, 1),
(2, 2);

INSERT INTO OrderDetails VALUES
(1, 'Laptop'),
(1, 'Mouse'),
(1, 'Keyboard'),
(2, 'Monitor');


-- Third Normal Form (3NF)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100)
);

CREATE TABLE OrderDetails_3NF (
    OrderID INT,
    ProductID INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Products VALUES
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard'),
(4, 'Monitor');

INSERT INTO OrderDetails_3NF VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4);