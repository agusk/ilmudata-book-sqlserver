CREATE DATABASE GDPRLab;
GO
USE GDPRLab;
GO

CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(50),
    RegisteredDate DATE,
    IsDeleted BIT DEFAULT 0
);
GO

INSERT INTO Customers (FullName, Email, Phone, RegisteredDate)
VALUES 
('Ujang Johnson', 'ujang.johnson@ilmudata.id', '555-1234', '2024-05-10'),
('James Turner', 'james.turner@neuville.id', '555-1122', '2024-04-18'),        
('Sophie Evans', 'sophie.evans@ilmudata.id', '555-3344', '2024-03-22'),         
('Lucía García', 'lucia.garcia@ilmudata.id', '555-5566', '2024-02-14'),         
('Carlos Martínez', 'carlos.martinez@neuville.id', '555-7788', '2024-01-30'),  
('Giulia Rossi', 'giulia.rossi@ilmudata.id', '555-9900', '2024-05-25'),       
('Marco Bianchi', 'marco.bianchi@neuville.id', '555-2233', '2024-06-05');     

SELECT * FROM Customers;


UPDATE Customers
SET 
    FullName = CONCAT('DeletedUser_', CustomerID),
    Email = NULL,
    Phone = NULL,
    IsDeleted = 1
WHERE CustomerID = 2;



CREATE PROCEDURE AnonymizeAndSoftDeleteCustomer
    @CustomerID INT
AS
BEGIN
    UPDATE Customers
    SET 
        FullName = CONCAT('DeletedUser_', @CustomerID),
        Email = NULL,
        Phone = NULL,
        IsDeleted = 1
    WHERE CustomerID = @CustomerID;
END;



EXEC AnonymizeAndSoftDeleteCustomer @CustomerID = 3;


SELECT * FROM Customers;