CREATE DATABASE RlsTenantLab;
GO

USE RlsTenantLab;
GO


CREATE TABLE CustomerOrders (
    OrderID INT IDENTITY PRIMARY KEY,
    TenantId INT NOT NULL,
    CustomerName NVARCHAR(100),
    OrderDate DATE,
    Amount DECIMAL(10,2)
);


INSERT INTO CustomerOrders (TenantId, CustomerName, OrderDate, Amount)
VALUES 
(1, 'Tata Industries', '2025-07-01', 1200.00),
(1, 'Tata Industries', '2025-07-15', 3000.00),
(2, 'Infosys Ltd', '2025-07-02', 1500.00),
(2, 'Infosys Ltd', '2025-07-20', 500.00);


CREATE FUNCTION fn_tenant_filter(@TenantId INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS result
WHERE @TenantId = CAST(SESSION_CONTEXT(N'TenantId') AS INT);



CREATE SECURITY POLICY TenantFilterPolicy
ADD FILTER PREDICATE dbo.fn_tenant_filter(TenantId)
ON dbo.CustomerOrders
WITH (STATE = ON);


-- Simulate Tenant 1 session
EXEC sp_set_session_context @key = N'TenantId', @value = 1;

SELECT * FROM CustomerOrders;
-- Returns only rows for TenantId = 1

-- Simulate Tenant 2 session
EXEC sp_set_session_context @key = N'TenantId', @value = 2;

SELECT * FROM CustomerOrders;
-- Returns only rows for TenantId = 2


-- Create login and user for Tenant1
CREATE LOGIN Tenant1User WITH PASSWORD = 'StrongP@ssword123!';
CREATE USER Tenant1User FOR LOGIN Tenant1User;

GRANT SELECT ON CustomerOrders TO Tenant1User;


-- Test
USE RlsTenantLab;
GO

EXEC sp_set_session_context @key = N'TenantId', @value = 1;
SELECT * FROM CustomerOrders;



