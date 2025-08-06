CREATE DATABASE SaaSPerfDB;
GO

USE SaaSPerfDB;
GO

CREATE TABLE Tenant (
    TenantID INT PRIMARY KEY IDENTITY(1,1),
    TenantName NVARCHAR(100) NOT NULL
);

CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY IDENTITY(1000,1),
    TenantID INT NOT NULL,
    InvoiceDate DATE,
    CustomerName NVARCHAR(100),
    Amount DECIMAL(10,2),
    Status NVARCHAR(50),
    FOREIGN KEY (TenantID) REFERENCES Tenant(TenantID)
);


-- Add tenants
INSERT INTO Tenant (TenantName) VALUES ('RetailCorp'), ('HealthPlus');

-- Add invoices
INSERT INTO Invoice (TenantID, InvoiceDate, CustomerName, Amount, Status)
VALUES
(1, '2025-01-15', 'Pram Jatmiko', 1200, 'Paid'),
(1, '2025-02-10', 'Olga Ivanova', 1500, 'Pending'),
(1, '2025-03-05', 'John Miller', 1800, 'Paid'),
(2, '2025-01-12', 'Siti Aisyah', 980, 'Paid'),
(2, '2025-03-10', 'Ivan Petrov', 2150, 'Pending');


-- View for RetailCorp (TenantID = 1)
CREATE VIEW vw_RetailCorp_Invoices AS
SELECT * FROM Invoice WHERE TenantID = 1;
GO

-- View for HealthPlus (TenantID = 2)
CREATE VIEW vw_HealthPlus_Invoices AS
SELECT * FROM Invoice WHERE TenantID = 2;
GO


SELECT * FROM vw_RetailCorp_Invoices;



-- Index for RetailCorp
CREATE NONCLUSTERED INDEX IX_Invoice_Tenant1
ON Invoice (InvoiceDate)
WHERE TenantID = 1;

-- Index for HealthPlus
CREATE NONCLUSTERED INDEX IX_Invoice_Tenant2
ON Invoice (InvoiceDate)
WHERE TenantID = 2;



SELECT * FROM vw_HealthPlus_Invoices WHERE InvoiceDate >= '2025-01-01';