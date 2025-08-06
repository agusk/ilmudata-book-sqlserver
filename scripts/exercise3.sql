SELECT Name, ListPrice
FROM Production.Product;



SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > 0;



SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'Red';


SELECT Name, Color, ListPrice
FROM Production.Product
WHERE (Color = 'Red' OR Color = 'Black')
  AND ListPrice > 500;


SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31';