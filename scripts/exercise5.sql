SELECT 
    Name, 
    ListPrice, 
    ListPrice * 0.9 AS DiscountedPrice
FROM Production.Product
WHERE ListPrice > 0;


SELECT 
    FirstName + ' ' + LastName AS FullName, 
    EmailPromotion
FROM Person.Person;


SELECT 
    Name, 
    Color
FROM Production.Product
WHERE Color IS NULL;


SELECT 
    Name, 
    COALESCE(Color, 'Not Specified') AS ProductColor
FROM Production.Product;


SELECT 
    ProductID, 
    Weight, 
    COALESCE(Weight, 0) AS Weight_KG
FROM Production.Product;


SELECT 
    Name,
    ListPrice,
    COALESCE(Color, 'N/A') AS Color,
    ListPrice * 0.95 AS SalePrice
FROM Production.Product
WHERE ListPrice > 100
ORDER BY SalePrice DESC;



