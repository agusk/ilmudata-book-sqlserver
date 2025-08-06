USE SubscriptionDB;
GO


INSERT INTO SubscriptionPlan (PlanName, MonthlyPrice, Description)
VALUES 
('Basic Plan', 9.99, 'Access to standard features'),
('Premium Plan', 19.99, 'Access to all features including analytics'),
('Enterprise Plan', 49.99, 'Custom enterprise support and reporting');


INSERT INTO Customer (FirstName, LastName, Email)
VALUES 
('Linda', 'Alice', 'linda.alice@ilmudata.id'),
('Ujang', 'Smith', 'ujang.smith@ilmudata.id'),
('Cindy', 'Lee', 'cindy.lee@ilmudata.id');


-- Linda subscribes to Basic
INSERT INTO Subscription (CustomerID, PlanID, StartDate)
VALUES (1, 1, '2025-07-01');

-- Ujang subscribes to Premium
INSERT INTO Subscription (CustomerID, PlanID, StartDate)
VALUES (2, 2, '2025-07-01');

-- Cindy subscribes to Enterprise
INSERT INTO Subscription (CustomerID, PlanID, StartDate)
VALUES (3, 3, '2025-07-01');


INSERT INTO Payment (SubscriptionID, PaymentDate, Amount, PaymentStatus)
VALUES 
(1, '2025-07-05', 9.99, 'Paid'),
(2, '2025-07-05', 19.99, 'Paid'),
(3, '2025-07-05', 49.99, 'Pending');



-- List subscriptions with customer and plan info
SELECT 
    s.SubscriptionID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    sp.PlanName,
    sp.MonthlyPrice,
    s.StartDate,
    s.IsActive
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN SubscriptionPlan sp ON s.PlanID = sp.PlanID;

-- Show payment history with customer info
SELECT 
    p.PaymentID,
    c.FirstName + ' ' + c.LastName AS Customer,
    sp.PlanName,
    p.PaymentDate,
    p.Amount,
    p.PaymentStatus
FROM Payment p
JOIN Subscription s ON p.SubscriptionID = s.SubscriptionID
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN SubscriptionPlan sp ON s.PlanID = sp.PlanID;