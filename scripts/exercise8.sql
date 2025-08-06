CREATE DATABASE SubscriptionDB;
GO

USE SubscriptionDB;
GO

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    JoinDate DATE DEFAULT GETDATE()
);


CREATE TABLE SubscriptionPlan (
    PlanID INT PRIMARY KEY IDENTITY,
    PlanName NVARCHAR(50) NOT NULL,
    MonthlyPrice DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(255)
);


CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY IDENTITY,
    CustomerID INT NOT NULL,
    PlanID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PlanID) REFERENCES SubscriptionPlan(PlanID)
);


CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY,
    SubscriptionID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentStatus NVARCHAR(50) CHECK (PaymentStatus IN ('Paid', 'Failed', 'Pending')),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);


SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'SubscriptionDB';