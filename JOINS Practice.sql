
-- DATABASE SETUP


CREATE DATABASE Practice;
USE Practice;


-- TABLES


CREATE TABLE Department (
    DepID INT PRIMARY KEY,
    DepName VARCHAR(20)
);

CREATE TABLE Student (
    StuID INT PRIMARY KEY,
    StuName VARCHAR(20),
    DepID INT,
    FOREIGN KEY (DepID) REFERENCES Department(DepID)
);


-- DATA INSERTION IN Tables


INSERT INTO Department VALUES
(101, 'CS'),
(102, 'DS');

INSERT INTO Student VALUES 
(1, 'Ali', 101),
(2, 'Uswa', 102),
(3, 'Alia', NULL),
(4, 'Rida', NULL);


-- SHOW DATA


SELECT * FROM Student;
SELECT * FROM Department;


-- LEFT JOIN: All students with departments


SELECT 
    Student.StuName, 
    Department.DepName
FROM Student
LEFT JOIN Department 
ON Student.DepID = Department.DepID;


-- LEFT JOIN: Students without departments


SELECT 
    Student.StuName, 
    Department.DepName
FROM Student
LEFT JOIN Department
ON Student.DepID = Department.DepID
WHERE Department.DepName IS NULL;


-- RIGHT JOIN: Departments without students


SELECT  
    Department.DepName, 
    Student.StuName
FROM Student
RIGHT JOIN Department
ON Department.DepID = Student.DepID
WHERE Student.DepID IS NULL;


-- COUNT: Students per department


SELECT 
    Department.DepName, 
    COUNT(Student.StuID) AS TotalStudents
FROM Department
LEFT JOIN Student
ON Department.DepID = Student.DepID
GROUP BY Department.DepName;


-- COUNT with condition


SELECT 
    Department.DepName, 
    COUNT(Student.StuID) AS TotalStudents
FROM Department
LEFT JOIN Student
ON Department.DepID = Student.DepID
GROUP BY Department.DepName
HAVING COUNT(Student.StuID) > 1;


-- ADD COLUMN MARKS 


ALTER TABLE Student
ADD Marks INT;


-- UPDATE/ADD MARKS


UPDATE Student SET Marks = 80 WHERE StuID = 1;
UPDATE Student SET Marks = 70 WHERE StuID = 2;
UPDATE Student SET Marks = 60 WHERE StuID = 3;
UPDATE Student SET Marks = 50 WHERE StuID = 4;


-- SHOW UPDATED DATA


SELECT * FROM Student;


-- SUM: Total marks per department


SELECT 
    Department.DepName, 
    SUM(Student.Marks) AS TotalMarks
FROM Department
LEFT JOIN Student
ON Department.DepID = Student.DepID
GROUP BY Department.DepName
HAVING SUM(Student.Marks) > 60;


-- COUNT + SUM COMBINED


SELECT 
    Department.DepName, 
    COUNT(Student.StuID) AS TotalStudents,
    SUM(Student.Marks) AS TotalMarks
FROM Department
LEFT JOIN Student
ON Department.DepID = Student.DepID
GROUP BY Department.DepName
HAVING COUNT(Student.StuID) >= 1 
   AND SUM(Student.Marks) >= 70;