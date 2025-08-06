USE AdventureWorks2022;
GO



SELECT TOP 10 
    soh.SalesOrderID,
    st.Name AS Territory,
    soh.Status,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID;



SELECT 
    st.Name AS Territory,
    soh.Status,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID;


SELECT *
FROM (
    SELECT 
        st.Name AS Territory,
        soh.Status,
        soh.TotalDue
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
) AS SourceData
PIVOT (
    SUM(TotalDue)
    FOR Status IN ([1], [2], [3], [4], [5], [6])
) AS PivotTable
ORDER BY Territory;