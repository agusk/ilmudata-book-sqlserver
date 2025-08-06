SELECT TOP 10 SalesOrderID, OrderDate, TerritoryID, TotalDue
FROM Sales.SalesOrderHeader;


SELECT 
    h.SalesOrderID,
    h.OrderDate,
    t.Name AS Territory,
    h.TotalDue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory t ON h.TerritoryID = t.TerritoryID;



SELECT 
    h.SalesOrderID,
    h.OrderDate,
    t.Name AS Territory,
    h.TotalDue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory t ON h.TerritoryID = t.TerritoryID
WHERE 
    t.Name = 'Southwest'
    AND h.OrderDate BETWEEN '2013-01-01' AND '2013-12-31';


SELECT 
    h.SalesOrderID,
    h.OrderDate,
    t.Name AS Territory,
    h.TotalDue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory t ON h.TerritoryID = t.TerritoryID
WHERE 
    t.Name = 'Southwest'
    AND h.OrderDate BETWEEN '2013-01-01' AND '2013-12-31'
ORDER BY h.TotalDue DESC;