USE AdventureWorks2022;
GO

-- Preview Customers
SELECT TOP 5 CustomerID, PersonID, StoreID, TerritoryID
FROM Sales.Customer;

-- Preview Orders
SELECT TOP 5 SalesOrderID, CustomerID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader;

-- Preview Territories
SELECT TOP 5 TerritoryID, Name AS RegionName
FROM Sales.SalesTerritory;


SELECT 
    c.CustomerID,
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID;


SELECT 
    c.CustomerID,
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    st.Name AS Region
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesTerritory st 
    ON c.TerritoryID = st.TerritoryID
ORDER BY soh.OrderDate DESC;


SELECT 
    c.CustomerID,
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    st.Name AS Region
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesTerritory st 
    ON c.TerritoryID = st.TerritoryID
WHERE st.Name = 'Southwest'
ORDER BY soh.OrderDate DESC;