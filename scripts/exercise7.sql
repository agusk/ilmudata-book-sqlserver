CREATE DATABASE ERDDesignDemo;
GO

USE ERDDesignDemo;
GO


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    HireDate DATE
);

CREATE TABLE EmployeeDetail (
    EmployeeID INT PRIMARY KEY,
    Address NVARCHAR(200),
    Phone NVARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100)
);

CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE OrgEmployee (
    EmpID INT PRIMARY KEY,
    EmpName NVARCHAR(100),
    ManagerID INT NULL,
    FOREIGN KEY (ManagerID) REFERENCES OrgEmployee(EmpID)
);



SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'ERDDesignDemo';