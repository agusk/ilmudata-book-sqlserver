USE SalesAnalysisDB;
GO

CREATE VIEW vw_SalesDetails AS
SELECT
    so.SalesOrderID,
    so.OrderDate,
    c.CustomerID,
    c.FullName AS CustomerName,
    c.Region,
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    so.Quantity,
    (so.Quantity * p.Price) AS TotalAmount
FROM SalesOrder so
JOIN Customer c ON so.CustomerID = c.CustomerID
JOIN Product p ON so.ProductID = p.ProductID;



SELECT * FROM vw_SalesDetails
ORDER BY OrderDate DESC;


SELECT
    CustomerName,
    Region,
    ProductName,
    Quantity,
    TotalAmount
FROM vw_SalesDetails
WHERE Region = 'South' AND Category = 'Service';