CREATE DATABASE SalesAnalysisDB;
GO

USE SalesAnalysisDB;
GO


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    Region NVARCHAR(50)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE SalesOrder (
    SalesOrderID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



-- Insert Customers
INSERT INTO Customer (FullName, Region)
VALUES ('Minji Kim', 'North'), ('Hiroshi Sato', 'South'), ('Priya Singh', 'East');

-- Insert Products
INSERT INTO Product (ProductName, Category, Price)
VALUES 
('Subscription A', 'Service', 15.00),
('Subscription B', 'Service', 25.00),
('Consulting Package', 'Consulting', 100.00);

-- Insert Sales Orders
INSERT INTO SalesOrder (CustomerID, ProductID, OrderDate, Quantity)
VALUES 
(1, 1, '2025-07-01', 2),
(2, 2, '2025-07-02', 1),
(3, 3, '2025-07-03', 3);


CREATE VIEW vw_SalesSummary AS
SELECT 
    so.SalesOrderID,
    c.FullName AS CustomerName,
    c.Region,
    p.ProductName,
    p.Category,
    so.Quantity,
    p.Price,
    (so.Quantity * p.Price) AS TotalAmount,
    so.OrderDate
FROM SalesOrder so
JOIN Customer c ON so.CustomerID = c.CustomerID
JOIN Product p ON so.ProductID = p.ProductID;



SELECT * FROM vw_SalesSummary
WHERE Region = 'North'
ORDER BY OrderDate DESC;


CREATE VIEW vw_TotalSalesByRegion AS
SELECT 
    c.Region,
    SUM(p.Price * so.Quantity) AS TotalSales,
    COUNT(DISTINCT so.SalesOrderID) AS OrdersCount
FROM SalesOrder so
JOIN Customer c ON so.CustomerID = c.CustomerID
JOIN Product p ON so.ProductID = p.ProductID
GROUP BY c.Region;



SELECT * FROM vw_TotalSalesByRegion
ORDER BY TotalSales DESC;