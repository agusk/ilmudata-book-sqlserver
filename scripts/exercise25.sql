USE SecureDataLab;
GO


CREATE SCHEMA PublicData;
GO
CREATE SCHEMA SensitiveData;
GO


-- General access table
CREATE TABLE PublicData.SalesSummary (
    Year INT,
    Region NVARCHAR(50),
    TotalSales DECIMAL(12,2)
);

-- Restricted access table
CREATE TABLE SensitiveData.EmployeeSalaries (
    EmployeeID INT,
    FullName NVARCHAR(100),
    Salary DECIMAL(10,2)
);

-- Insert example data
INSERT INTO PublicData.SalesSummary VALUES (2025, 'East', 150000.00);
INSERT INTO SensitiveData.EmployeeSalaries VALUES (1, 'Ahmad Smith', 90000.00);


GRANT SELECT ON SCHEMA::PublicData TO Analyst;



DENY SELECT ON SCHEMA::SensitiveData TO Analyst;


-- Impersonate
EXECUTE AS USER = 'analyst_user';

-- Should succeed
SELECT * FROM PublicData.SalesSummary;

-- Should fail
SELECT * FROM SensitiveData.EmployeeSalaries;
  
-- Revert session
REVERT;