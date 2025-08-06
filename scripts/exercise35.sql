USE GDPRPseudonymLab;
GO

CREATE VIEW vCustomerExport AS
SELECT 
    CustomerID,
    FullName,
    Email,
    Phone
FROM Customers;


SELECT * FROM vCustomerExport WHERE CustomerID = 1;



SELECT 
    '"' + CAST(CustomerID AS VARCHAR) + '","' +
    FullName + '","' +
    Email + '","' +
    Phone + '"' AS CSVRow
FROM vCustomerExport
WHERE CustomerID = 1;

UPDATE Customers
SET 
    FullName = NULL,
    Email = NULL,
    Phone = NULL
WHERE CustomerID = 1;


SELECT * FROM Customers WHERE CustomerID = 1;


ALTER TABLE Customers ADD IsErased BIT DEFAULT 0;

-- Erase customer PII and flag it
UPDATE Customers
SET 
    FullName = NULL,
    Email = NULL,
    Phone = NULL,
    IsErased = 1
WHERE CustomerID = 2;


SELECT * FROM Customers WHERE IsErased = 1;