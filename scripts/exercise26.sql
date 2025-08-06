CREATE DATABASE SecurityAuditDemo;
GO
USE SecurityAuditDemo;
GO



CREATE TABLE Sales (
    SaleId INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100),
    Amount MONEY
);

INSERT INTO Sales (ProductName, Amount)
VALUES ('Widget A', 1500), ('Widget B', 2400), ('Widget C', 720);
GO


CREATE LOGIN reportuser WITH PASSWORD = 'ComplexPass123!';
CREATE USER reportuser FOR LOGIN reportuser;

GRANT SELECT ON dbo.Sales TO reportuser;
GO

--- test
USE SecurityAuditDemo;
GO

SELECT * FROM Sales;


REVOKE SELECT ON dbo.Sales FROM reportuser;
GO


-- Custom Role and Grant Permission

CREATE ROLE analyst_role;
EXEC sp_addrolemember 'analyst_role', 'reportuser';

GRANT SELECT ON dbo.Sales TO analyst_role;
GO

--  Audit Role Membership

SELECT 
    r.name AS RoleName,
    m.name AS MemberName
FROM 
    sys.database_role_members drm
JOIN 
    sys.database_principals r ON drm.role_principal_id = r.principal_id
JOIN 
    sys.database_principals m ON drm.member_principal_id = m.principal_id;


-- Audit Object-Level Permissions
SELECT 
    dp.name AS PrincipalName,
    dp.type_desc AS PrincipalType,
    o.name AS ObjectName,
    p.permission_name,
    p.state_desc AS PermissionState
FROM 
    sys.database_permissions p
JOIN 
    sys.objects o ON p.major_id = o.object_id
JOIN 
    sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
WHERE 
    o.type = 'U'; -- U = User table