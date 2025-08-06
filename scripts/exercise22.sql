USE AdventureWorks2022;
GO


SELECT 
    CustomerID,
    FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(TotalDue) AS MonthlyTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM');


-- Moving Average with a Window Frame
WITH MonthlyRevenue AS (
    SELECT 
        CustomerID,
        FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
        SUM(TotalDue) AS MonthlyTotal
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM')
)
SELECT 
    CustomerID,
    OrderMonth,
    MonthlyTotal,
    AVG(MonthlyTotal) OVER (
        PARTITION BY CustomerID
        ORDER BY OrderMonth
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3Months
FROM MonthlyRevenue
ORDER BY CustomerID, OrderMonth;


-- Filter a Specific Customer
WITH MonthlyRevenue AS (
    SELECT 
        CustomerID,
        FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
        SUM(TotalDue) AS MonthlyTotal
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM')
)
SELECT 
    CustomerID,
    OrderMonth,
    MonthlyTotal,
    AVG(MonthlyTotal) OVER (
        PARTITION BY CustomerID
        ORDER BY OrderMonth
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3Months
FROM MonthlyRevenue
WHERE CustomerID = 11000
ORDER BY OrderMonth;