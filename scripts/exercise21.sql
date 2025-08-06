USE AdventureWorks2022;
GO


-- Aggregate Monthly Revenue per Customer
SELECT 
    CustomerID,
    FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(TotalDue) AS MonthlyTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM')
ORDER BY CustomerID, OrderMonth;

-- Apply LAG() and LEAD() 

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
    LAG(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS PreviousMonthRevenue,
    LEAD(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS NextMonthRevenue
FROM MonthlyRevenue
ORDER BY CustomerID, OrderMonth;

-- Calculate Month-over-Month Change


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
    LAG(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS PreviousMonthRevenue,
    MonthlyTotal - LAG(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS RevenueChange
FROM MonthlyRevenue
ORDER BY CustomerID, OrderMonth;


-- Filter Specific Customer


-- Example for CustomerID 11000
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
    LAG(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS PreviousMonthRevenue,
    MonthlyTotal - LAG(MonthlyTotal) OVER (PARTITION BY CustomerID ORDER BY OrderMonth) AS RevenueChange
FROM MonthlyRevenue
WHERE CustomerID = 11000
ORDER BY OrderMonth;