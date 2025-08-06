USE AdventureWorks2022;
GO

SELECT TOP 5 SalesOrderID, CustomerID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

-- Aggregate Sales Monthly Per Customer

SELECT 
    CustomerID,
    FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(TotalDue) AS MonthlyTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM');


-- Apply RANK() 

WITH MonthlyCustomerTotals AS (
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
    RANK() OVER (PARTITION BY OrderMonth ORDER BY MonthlyTotal DESC) AS RevenueRank
FROM MonthlyCustomerTotals
ORDER BY OrderMonth, RevenueRank;

-- Filter to Top 3 Customers Per Month

WITH MonthlyCustomerTotals AS (
    SELECT 
        CustomerID,
        FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
        SUM(TotalDue) AS MonthlyTotal
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID, FORMAT(OrderDate, 'yyyy-MM')
)
SELECT *
FROM (
    SELECT 
        CustomerID,
        OrderMonth,
        MonthlyTotal,
        RANK() OVER (PARTITION BY OrderMonth ORDER BY MonthlyTotal DESC) AS RevenueRank
    FROM MonthlyCustomerTotals
) AS RankedData
WHERE RevenueRank <= 3
ORDER BY OrderMonth, RevenueRank;

