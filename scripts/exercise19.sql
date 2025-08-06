USE AdventureWorks2022;
GO

SELECT *
INTO Sales.SalesOrderHeaderArchive
FROM Sales.SalesOrderHeader
WHERE OrderDate < '2013-01-01';

-- Active Orders
SELECT TOP 5 SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

-- Archived Orders
SELECT TOP 5 SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeaderArchive
ORDER BY OrderDate DESC;


-- Combine the Two Sources with UNION
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    'Active' AS Source
FROM Sales.SalesOrderHeader

UNION

SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    'Archive' AS Source
FROM Sales.SalesOrderHeaderArchive
ORDER BY OrderDate DESC;


-- UNION ALL to Preserve Duplicates
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    'Active' AS Source
FROM Sales.SalesOrderHeader

UNION ALL

SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    'Archive' AS Source
FROM Sales.SalesOrderHeaderArchive
ORDER BY OrderDate DESC;


-- Filter the Combined Result by Source

SELECT *
FROM (
    SELECT SalesOrderID, OrderDate, TotalDue, 'Active' AS Source
    FROM Sales.SalesOrderHeader
    UNION ALL
    SELECT SalesOrderID, OrderDate, TotalDue, 'Archive' AS Source
    FROM Sales.SalesOrderHeaderArchive
) AS CombinedOrders
WHERE Source = 'Archive';
