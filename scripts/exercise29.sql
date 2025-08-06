CREATE DATABASE RLS_AuditLab;
GO
USE RLS_AuditLab;
GO


CREATE TABLE Invoices (
    InvoiceId INT PRIMARY KEY IDENTITY,
    TenantId INT,
    CustomerName NVARCHAR(100),
    Amount MONEY
);
GO

INSERT INTO Invoices (TenantId, CustomerName, Amount)
VALUES (1, 'Cecep', 1200.00),
       (1, 'Bambang', 890.00),
       (2, 'Ita', 455.50),
       (2, 'Diana', 310.75);
GO


CREATE FUNCTION fn_tenant_filter(@TenantId INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS result
WHERE @TenantId = CAST(SESSION_CONTEXT(N'TenantId') AS INT);
GO

CREATE SECURITY POLICY InvoiceTenantFilter
ADD FILTER PREDICATE dbo.fn_tenant_filter(TenantId)
ON dbo.Invoices
WITH (STATE = ON);
GO


CREATE TABLE InvoiceAccessLog (
    LogId INT IDENTITY PRIMARY KEY,
    TenantId INT,
    Username NVARCHAR(100),
    AccessedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    QueryType NVARCHAR(10)
);
GO


-- SQL Server does not support SELECT triggers; use an AFTER INSERT trigger for demonstration.
CREATE TRIGGER trg_log_invoice_access
ON Invoices
AFTER INSERT
AS
BEGIN
    DECLARE @tenantId INT = CAST(SESSION_CONTEXT(N'TenantId') AS INT);
    DECLARE @username NVARCHAR(100) = SYSTEM_USER;

    INSERT INTO InvoiceAccessLog (TenantId, Username, QueryType)
    SELECT DISTINCT @tenantId, @username, 'INSERT'
    FROM inserted;
END;
GO


-- Simulate access as Tenant 1
EXEC sp_set_session_context 'TenantId', 1;
INSERT INTO Invoices (TenantId, CustomerName, Amount) VALUES (1, 'Tenant1 Customer', 100.00);

-- Simulate access as Tenant 2
EXEC sp_set_session_context 'TenantId', 2;
INSERT INTO Invoices (TenantId, CustomerName, Amount) VALUES (2, 'Tenant2 Customer', 200.00);


-- Test
SELECT * FROM InvoiceAccessLog;

