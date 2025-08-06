USE AdventureWorks2022;
GO

SELECT 
    CustomerID,
    SUM(TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

-- CUME_DIST() and PERCENT_RANK()


WITH CustomerRevenue AS (
    SELECT 
        CustomerID,
        SUM(TotalDue) AS TotalRevenue
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
)
SELECT 
    CustomerID,
    TotalRevenue,
    CUME_DIST() OVER (ORDER BY TotalRevenue DESC) AS CumulativeDistribution,
    PERCENT_RANK() OVER (ORDER BY TotalRevenue DESC) AS PercentRank
FROM CustomerRevenue
ORDER BY TotalRevenue DESC;


-- Filter for High-Performing Customers
WITH CustomerRevenue AS (
    SELECT 
        CustomerID,
        SUM(TotalDue) AS TotalRevenue
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
)
SELECT *
FROM (
    SELECT 
        CustomerID,
        TotalRevenue,
        CUME_DIST() OVER (ORDER BY TotalRevenue DESC) AS CumulativeDistribution
    FROM CustomerRevenue
) AS RankedCustomers
WHERE CumulativeDistribution <= 0.10
ORDER BY TotalRevenue DESC;