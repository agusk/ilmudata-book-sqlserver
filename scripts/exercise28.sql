USE RlsTenantLab;
GO

-- Confirm table
SELECT * FROM sys.tables WHERE name = 'CustomerOrders';

-- Confirm security policy
SELECT * FROM sys.security_policies WHERE name = 'TenantFilterPolicy';


-- Tenant 1
CREATE LOGIN Tenant1User1 WITH PASSWORD = 'Tenant1Pass!';
CREATE USER Tenant1User1 FOR LOGIN Tenant1User1;
GRANT SELECT ON dbo.CustomerOrders TO Tenant1User1;

-- Tenant 2
CREATE LOGIN Tenant2User1 WITH PASSWORD = 'Tenant2Pass!';
CREATE USER Tenant2User1 FOR LOGIN Tenant2User1;
GRANT SELECT ON dbo.CustomerOrders TO Tenant2User1;


CREATE OR ALTER TRIGGER trg_SetTenantContext
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @tenantId INT;

    IF ORIGINAL_LOGIN() = 'Tenant1User1'
        SET @tenantId = 1;
    ELSE IF ORIGINAL_LOGIN() = 'Tenant2User1'
        SET @tenantId = 2;

    EXECUTE AS LOGIN = ORIGINAL_LOGIN();
    EXEC sp_set_session_context @key = N'TenantId', @value = @tenantId;
    REVERT;
END;


-- Connect using SQL login: Tenant1User1
USE RlsTenantLab;
SELECT * FROM dbo.CustomerOrders;

-- Connect using SQL login: Tenant2User1
USE RlsTenantLab;
SELECT * FROM dbo.CustomerOrders;


-- update
CREATE OR ALTER TRIGGER trg_SetTenantContext
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @tenantId INT;

    IF ORIGINAL_LOGIN() = 'Tenant1User1'
        SET @tenantId = 1;
    ELSE IF ORIGINAL_LOGIN() = 'Tenant2User1'
        SET @tenantId = 2;

    EXECUTE AS LOGIN = ORIGINAL_LOGIN();
    EXEC sp_set_session_context @key = N'TenantId', @value = @tenantId, @readonly = 1;
    REVERT;
END;


-- Attempt to impersonate Tenant2 as Tenant1User1 (run as Tenant1User1)
USE RlsTenantLab;

EXEC sp_set_session_context @key = N'TenantId', @value = 2;
SELECT * FROM dbo.CustomerOrders;



