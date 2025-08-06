USE AdventureWorks2022;
GO

SELECT TOP 10 OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;


SELECT 
    DATEPART(YEAR, OrderDate) AS OrderYear,
    DATEPART(MONTH, OrderDate) AS OrderMonth,
    SUM(TotalDue) AS MonthlyRevenue
FROM Sales.SalesOrderHeader
GROUP BY 
    DATEPART(YEAR, OrderDate), 
    DATEPART(MONTH, OrderDate)
ORDER BY 
    OrderYear, 
    OrderMonth;



SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS OrderPeriod,
    SUM(TotalDue) AS MonthlyRevenue
FROM Sales.SalesOrderHeader
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY OrderPeriod;



SELECT 
    FORMAT(OrderDate, 'yyyy-MM') AS OrderPeriod,
    SUM(TotalDue) AS MonthlyRevenue
FROM Sales.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = 2013
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY OrderPeriod;