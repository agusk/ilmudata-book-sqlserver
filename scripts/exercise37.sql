USE master;
GO

CREATE SERVER AUDIT GDPR_Data_Access_Audit
TO FILE (
    FILEPATH = 'C:\SQLAuditLogs\',  -- Ensure this folder exists
    MAXSIZE = 10 MB,
    MAX_ROLLOVER_FILES = 5,
    RESERVE_DISK_SPACE = OFF
)
WITH (ON_FAILURE = CONTINUE);
GO

ALTER SERVER AUDIT GDPR_Data_Access_Audit
WITH (STATE = ON);



USE GDPRLab;
GO

CREATE DATABASE AUDIT SPECIFICATION GDPR_Customers_Access_Spec
FOR SERVER AUDIT GDPR_Data_Access_Audit
ADD (SELECT ON OBJECT::dbo.Customers BY PUBLIC)
WITH (STATE = ON);


USE GDPRLab;
GO

SELECT * FROM dbo.Customers;

SELECT
    event_time,
    server_principal_name,
    database_name,
    object_name,
    statement
FROM sys.fn_get_audit_file(
    'C:\SQLAuditLogs\*', NULL, NULL);