CREATE DATABASE AlwaysEncryptedLab;
GO
USE AlwaysEncryptedLab;
GO

-- Create table with sensitive data (unencrypted initially)
CREATE TABLE Customers (
    CustomerId INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    NationalID NVARCHAR(20),
    CreditCardNumber NVARCHAR(20),
    Salary DECIMAL(10,2)
);


INSERT INTO Customers (FullName, Email, NationalID, CreditCardNumber, Salary)
VALUES
('Thariq Akbar', 'thariq.akbar@ilmudata.id', '1234567890123456', '4532-1234-5678-9012', 75000.00),
('Zahra Zhafirah', 'zahra.zhafirah@ilmudata.id', '9876543210987654', '5678-9012-3456-7890', 85000.00),
('Ananda Putra', 'ananda.putra@ilmudata.id', '5555666677778888', '1234-5678-9012-3456', 95000.00);



SELECT * FROM Customers;


-- Check Column Master Keys
SELECT name, key_store_provider_name 
FROM sys.column_master_keys;

-- Check Column Encryption Keys  
SELECT name, column_encryption_key_id
FROM sys.column_encryption_keys;

-- Check encrypted columns
SELECT c.name, c.encryption_type_desc, c.encryption_algorithm_name
FROM sys.columns c
WHERE c.encryption_type IS NOT NULL;


USE AlwaysEncryptedLab;
SELECT * FROM Customers;


SELECT * FROM Customers 
WHERE NationalID = '1234567890123456';


SELECT * FROM Customers 
WHERE CreditCardNumber LIKE '4532%'; -- This will give an error