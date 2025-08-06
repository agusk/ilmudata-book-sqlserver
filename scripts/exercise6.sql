SELECT 
    Name,
    ListPrice,
    CASE 
        WHEN ListPrice = 0 THEN 'Free'
        WHEN ListPrice < 100 THEN 'Low Price'
        WHEN ListPrice BETWEEN 100 AND 500 THEN 'Mid Range'
        WHEN ListPrice > 500 THEN 'Premium'
        ELSE 'Unknown'
    END AS PriceCategory
FROM Production.Product
ORDER BY ListPrice;


SELECT 
    FirstName + ' ' + LastName AS FullName,
    EmailPromotion,
    CASE 
        WHEN EmailPromotion = 0 THEN 'No Promotions'
        WHEN EmailPromotion = 1 THEN 'Subscribed - Basic'
        WHEN EmailPromotion = 2 THEN 'Subscribed - Advanced'
        ELSE 'Unknown'
    END AS PromotionStatus
FROM Person.Person;


SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    CASE 
        WHEN TotalDue >= 10000 THEN 'High Value'
        WHEN TotalDue BETWEEN 5000 AND 9999.99 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS OrderCategory
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2013-01-01'
ORDER BY TotalDue DESC;