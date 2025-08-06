CREATE DATABASE SecureDataLab;
GO

USE SecureDataLab;
GO


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Region NVARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO Customers VALUES 
(1, 'Ahmad Smith', 'smith@ilmudata.id', 'East'),
(2, 'Laura Ave', 'ave@ilmudata.id', 'West');

INSERT INTO Orders VALUES 
(101, 1, '2025-01-15', 1500.00),
(102, 2, '2025-02-10', 2300.00);


-- Create SQL login
CREATE LOGIN analyst_user WITH PASSWORD = 'StrongP@ssword123!';
GO

-- Map login to database user
USE SecureDataLab;
GO
CREATE USER analyst_user FOR LOGIN analyst_user;



-- Create custom role
CREATE ROLE Analyst;
GO

-- Grant SELECT permissions to role
GRANT SELECT ON Customers TO Analyst;
GRANT SELECT ON Orders TO Analyst;
GO

-- Add user to the role
EXEC sp_addrolemember 'Analyst', 'analyst_user';


-- Impersonate analyst_user
EXECUTE AS USER = 'analyst_user';

-- This should succeed
SELECT * FROM Customers;

-- This should fail (no INSERT permission)
INSERT INTO Customers VALUES (3, 'Unauthorized', 'hack@fake.com', 'North');

-- Revert session
REVERT;