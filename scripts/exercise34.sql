CREATE DATABASE GDPRPseudonymLab;
GO
USE GDPRPseudonymLab;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone VARCHAR(20),
    EmailHash AS CONVERT(VARCHAR(100), HASHBYTES('SHA2_256', Email), 2) PERSISTED,
    PhoneHash AS CONVERT(VARCHAR(100), HASHBYTES('SHA2_256', Phone), 2) PERSISTED
);


INSERT INTO Customers (CustomerID, FullName, Email, Phone)
VALUES
(1, 'Hans Müller', 'hans.mueller@neuville.id', '555-123-4567'),
(2, 'Pierre Dubois', 'pierre.dubois@neuville.id', '555-987-6543');



SELECT CustomerID, Email, EmailHash, Phone, PhoneHash FROM Customers;


CREATE TABLE EmailCampaigns (
    CampaignID INT,
    TargetEmailHash VARCHAR(100)
);

INSERT INTO EmailCampaigns (CampaignID, TargetEmailHash)
VALUES
(1001, (SELECT EmailHash FROM Customers WHERE CustomerID = 1));


SELECT c.CustomerID, c.FullName, e.CampaignID
FROM Customers c
JOIN EmailCampaigns e ON c.EmailHash = e.TargetEmailHash;


CREATE INDEX IX_Customers_EmailHash ON Customers (EmailHash);