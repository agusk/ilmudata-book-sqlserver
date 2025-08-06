CREATE DATABASE GDPRLab;
GO
USE GDPRLab;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) MASKED WITH (FUNCTION = 'email()'),
    Phone VARCHAR(20) MASKED WITH (FUNCTION = 'partial(0,"XXX-XXX-",4)'),
    SSN CHAR(11) MASKED WITH (FUNCTION = 'default()')
);



INSERT INTO Customers (CustomerID, FullName, Email, Phone, SSN)
VALUES
(1, 'Devi Johnson', 'devi.johnson@ilmudata.id', '555-123-4567', '123-45-6789'),
(2, 'Smith Lee', 'smith.lee@ilmudata.id', '555-987-6543', '987-65-4321'),
(3, 'Hans Müller', 'hans.mueller@ilmudata.id', '555-111-2222', '321-54-6789'),      
(4, 'Giulia Rossi', 'giulia.rossi@ilmudata.id', '555-333-4444', '654-32-1987'),     
(5, 'Pierre Dubois', 'pierre.dubois@ilmudata.id', '555-555-6666', '789-12-3456'),   
(6, 'Sven de Vries', 'sven.devries@ilmudata.id', '555-777-8888', '876-54-3210');   



CREATE LOGIN AnalystUser WITH PASSWORD = 'StrongPassword!123';
CREATE USER AnalystUser FOR LOGIN AnalystUser;
ALTER ROLE db_datareader ADD MEMBER AnalystUser;


EXECUTE AS USER = 'AnalystUser';
SELECT * FROM Customers;
REVERT;


GRANT UNMASK TO AnalystUser;