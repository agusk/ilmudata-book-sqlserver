USE AdventureWorks2022;
GO

SELECT 
    YEAR(OrderDate) AS SalesYear,
    COUNT(*) AS OrderCount,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;