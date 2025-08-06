USE GDPRLab;
GO

-- Table to store user consent information
CREATE TABLE ConsentLog (
    ConsentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ConsentGiven BIT NOT NULL,
    ConsentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ConsentMethod NVARCHAR(100) NOT NULL, -- e.g., "Checkbox on registration form"
    Notes NVARCHAR(255)
);

-- Table to log data processing activity
CREATE TABLE DataProcessingLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Activity NVARCHAR(100) NOT NULL, -- e.g., "Email marketing", "Exported data"
    ProcessedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100), -- e.g., app/service/user
    ConsentID INT NULL,
    FOREIGN KEY (ConsentID) REFERENCES ConsentLog(ConsentID)
);


INSERT INTO ConsentLog (UserID, ConsentGiven, ConsentMethod, Notes)
VALUES (1001, 1, 'Checkbox on signup form', 'User agreed to receive promotional emails');


INSERT INTO DataProcessingLog (UserID, Activity, PerformedBy, ConsentID)
VALUES (
    1001,
    'Email campaign - August 2025',
    'MarketingSystemApp',
    (SELECT TOP 1 ConsentID FROM ConsentLog WHERE UserID = 1001 ORDER BY ConsentDate DESC)
);


SELECT 
    dp.UserID,
    dp.Activity,
    dp.ProcessedAt,
    dp.PerformedBy,
    cl.ConsentDate,
    cl.ConsentMethod,
    cl.Notes
FROM DataProcessingLog dp
JOIN ConsentLog cl ON dp.ConsentID = cl.ConsentID
ORDER BY dp.ProcessedAt DESC;