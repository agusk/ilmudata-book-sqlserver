CREATE DATABASE DataMaskingLab;
GO

USE DataMaskingLab;
GO


CREATE TABLE Customers (
    CustomerId INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) MASKED WITH (FUNCTION = 'email()'),
    PhoneNumber NVARCHAR(20) MASKED WITH (FUNCTION = 'partial(2,"XXXXXXX",2)')
);


INSERT INTO Customers (FullName, Email, PhoneNumber)
VALUES
('Priya Sharma', 'priya.sharma@ilmudata.id', '08123456789'),
('Wei Zhang', 'wei.zhang@ilmudata.id', '08561234567'),
('Ananya Gupta', 'ananya.gupta@ilmudata.id', '08781239876');


SELECT * FROM Customers;


CREATE LOGIN ReadOnlyUser WITH PASSWORD = 'ReadOnlyPass!';
CREATE USER ReadOnlyUser FOR LOGIN ReadOnlyUser;
GRANT SELECT ON Customers TO ReadOnlyUser;


-- Test sign in as ReadOnlyUser
USE DataMaskingLab;
SELECT * FROM Customers;


GRANT UNMASK TO ReadOnlyUser;