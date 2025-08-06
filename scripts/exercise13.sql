CREATE DATABASE SaaSAppDB;
GO

USE SaaSAppDB;
GO


-- Tenant registration table
CREATE TABLE Tenant (
    TenantID INT PRIMARY KEY IDENTITY(1,1),
    TenantName NVARCHAR(100) NOT NULL
);

-- Shared Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1000,1),
    TenantID INT NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),
    FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID)
);


-- Insert two tenants
INSERT INTO Tenant (TenantName) VALUES ('Ilmu Data.'), ('Neuville Ltd.');

-- Insert customers for each tenant
INSERT INTO Customer (TenantID, FullName, Email)
VALUES
(1, 'Amina Okoro', 'amina@ilmudata.id'),
(1, 'Jeroen van Dijk', 'jeroen@ilmudata.id'),
(1, 'Élodie Martin', 'elodie@ilmudata.id'),
(1, 'Niran Chaiyawat', 'niran@ilmudata.id'),
(1, 'Lucas Silva', 'lucas@ilmudata.id'),
(2, 'Kwame Mensah', 'kwame@neuville.id'),
(2, 'Sanne de Vries', 'sanne@neuville.id'),
(2, 'Julien Dubois', 'julien@neuville.id'),
(2, 'Anong Srisuk', 'anong@neuville.id'),
(2, 'Bruna Costa', 'bruna@neuville.id');


-- View for Ilmu Data (TenantID = 1)
CREATE VIEW vw_IlmuData_Customers AS
SELECT * FROM Customer WHERE TenantID = 1;


SELECT FullName, Email, CreatedAt
FROM vw_IlmuData_Customers;


CREATE PROCEDURE GetCustomersByTenant
    @TenantID INT
AS
BEGIN
    SELECT FullName, Email, CreatedAt
    FROM Customer
    WHERE TenantID = @TenantID;
END;
GO

-- Usage
EXEC GetCustomersByTenant @TenantID = 2;