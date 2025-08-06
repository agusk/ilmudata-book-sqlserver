CREATE SERVER AUDIT Audit_Read_Access
TO FILE (
    FILEPATH = 'C:\SQLAuditLogs\',  
    MAXSIZE = 10 MB,
    MAX_FILES = 10,
    RESERVE_DISK_SPACE = OFF
)
WITH (
    QUEUE_DELAY = 1000,
    ON_FAILURE = CONTINUE
);


ALTER SERVER AUDIT Audit_Read_Access
WITH (STATE = ON);


USE AlwaysEncryptedLab;
GO

CREATE DATABASE AUDIT SPECIFICATION Audit_Select_Customers
FOR SERVER AUDIT Audit_Read_Access
ADD (SELECT ON dbo.Customers BY PUBLIC)
WITH (STATE = ON);


SELECT * FROM dbo.Customers;


SELECT
    event_time,
    session_server_principal_name,
    database_name,
    object_name,
    statement,
    action_id,
    succeeded
FROM sys.fn_get_audit_file('C:\SQLAuditLogs\*.sqlaudit', DEFAULT, DEFAULT);


ALTER DATABASE AUDIT SPECIFICATION Audit_Select_Customers
WITH (STATE = OFF);
GO

ALTER DATABASE AUDIT SPECIFICATION Audit_Select_Customers
ADD (UPDATE ON dbo.Customers BY PUBLIC);
GO

ALTER DATABASE AUDIT SPECIFICATION Audit_Select_Customers
WITH (STATE = ON);
GO