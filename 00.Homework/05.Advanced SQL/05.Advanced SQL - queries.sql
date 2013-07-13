USE TelerikAcademy

-- 1. Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company. Use a nested SELECT statement.
SELECT FirstName + ' ' + LastName AS Name, Salary AS Salary FROM Employees
WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees)

-- 2. Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher
-- than the minimal salary for the company.
SELECT FirstName + ' ' + LastName AS Name, Salary AS Salary FROM Employees
WHERE Salary <=
	(SELECT MIN(Salary) * 1.1 FROM Employees )

-- 3. Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department. Use a nested SELECT statement.
SELECT FirstName + ' ' + LastName AS Name, Salary AS Salary, d.Name AS [Department Name] FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = 
	(SELECT MIN(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID);

-- 4. Write a SQL query to find the average salary in the department #1.
SELECT AVG(Salary) AS [Average Salary in department #1] FROM Employees
WHERE DepartmentID = 1;

-- 5. Write a SQL query to find the average salary  in the "Sales" department.
SELECT AVG(Salary) AS [Average Salary in Sales] FROM Employees e
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.Name = 'Sales';

-- 6. Write a SQL query to find the number of employees in the "Sales" department.
SELECT Count(*) AS [Average Salary in Sales] FROM Employees e
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
WHERE d.Name = 'Sales';

-- 7. Write a SQL query to find the number of all employees that have manager.
SELECT Count(*) AS [Employees with a manager] FROM Employees
WHERE ManagerID IS NOT NULL

-- 8. Write a SQL query to find the number of all employees that have no manager.
SELECT Count(*) AS [Employees with a manager] FROM Employees
WHERE ManagerID IS NULL

-- 9. Write a SQL query to find all departments and the average salary for each of them.
SELECT Name AS [Department name], AVG(e.Salary) AS [Average salary] FROM Departments d
	JOIN Employees e ON e.DepartmentID = d.DepartmentID
GROUP BY name

-- 10. Write a SQL query to find the count of all employees in each department and for each town.
SELECT  d.Name AS DeptName, t.Name AS TownName, COUNT(e.EmployeeID) FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON t.TownID = a.TownID
GROUP BY d.Name, t.Name

-- 11. Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.
SELECT m.FirstName + ' ' + m.LastName AS [Managers Names], COUNT(e.EmployeeID) AS [Number of Employees] FROM Employees e
	JOIN Employees m ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) = 5

-- 12. Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
SELECT e.FirstName + ' ' + e.LastName AS Employees, ISNULL(m.FirstName + ' ' + m.LastName, 'asd')
	FROM Employees e
	LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID

-- 13. Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) function.
SELECT FirstName + ' ' + LastName AS Employees FROM Employees
WHERE LEN(LastName) = 5

-- 14. Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds".
-- Search in  Google to find how to format dates in SQL Server.
SELECT convert(varchar, getdate(), 113)

-- 15. Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
-- Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
-- Define the primary key column as identity to facilitate inserting records.
-- Define unique constraint to avoid repeating usernames.
-- Define a check constraint to ensure the password is at least 5 characters long.
USE TelerikAcademy;

CREATE TABLE Users(
	UserID int IDENTITY,
	Username nvarchar(25) NOT NULL,
	Password nvarchar(40) NOT NULL,
	FullName nvarchar(50), 
	LastLogin date NOT NULL,
	CONSTRAINT PK_USERID PRIMARY KEY(UserID),
	CONSTRAINT UNIQUE_USERNAME UNIQUE (Username),
	CONSTRAINT LEN_PASSWORD CHECK (LEN(Password) > 5)
);
GO

-- 16. Write a SQL statement to create a view that displays the users from the Users table that have been in the system today.
-- Test if the view works correctly.
CREATE VIEW [Users logged today] AS
	SELECT FullName FROM Users WHERE LastLogin = CONVERT(date, GETDATE())
GO
--TEST
INSERT INTO Users(Username, Password, FullName, LastLogin)
VALUES ('kirenceto', '79dc2a59c341fe5cebeada5d29d606d7863c90fe', 'kiro skalUta', GETDATE())

INSERT INTO Users(Username, Password, FullName, LastLogin)
VALUES ('peshenecto', '79dc2a59c341fe5cebeada5d29d606d7863c90fe', 'pesho skalUta', '01.01.2013')

SELECT * FROM [Users logged today]

-- 17. Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint).
-- Define primary key and identity column.
CREATE TABLE Groups(
	GroupID int IDENTITY,
	GroupName nvarchar(30) NOT NULL,
	CONSTRAINT PK_GROUPID PRIMARY KEY(GroupID)
)

-- 18. Write a SQL statement to add a column GroupID to the table Users. Fill some data in this new column and as well in the Groups table.
-- Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
ALTER TABLE Users 
	ADD GroupID int
	ADD CONSTRAINT FK_Users_Groups FOREIGN KEY(GroupID)
		REFERENCES Groups(GroupID)


-- 19. Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups(GroupName) 
	VALUES ('Mega Qka Group')

INSERT INTO Users(Username, Password, FullName, LastLogin, GroupID)
	VALUES ('petenceto', '79dc2a59c341fe5cebeada5d29d606d7863c90fe', 'petio skalUta', GETDATE(), 1)

INSERT INTO Users(Username, Password, FullName, LastLogin, GroupID)
	VALUES ('mitenceto', '79dc2a59c341fe5cebeada5d29d606d7863c90fe', 'mitio skalUta', '02.01.2013', 1)

-- 20. Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET FullName = 'mitio pishtovcheto'
WHERE FullName = 'mitio skalUta';

UPDATE Groups
SET GroupName = 'Super Duper Qka Chalga Grupa'
WHERE GroupName = 'Mega Qka Group';

-- 21. Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Users
WHERE Username = 'kirenceto';

-- 22. Write SQL statements to insert in the Users table the names of all employees from the Employees table.
-- Combine the first and last names as a full name. For username use the first letter of the first name + the last name (in lowercase).
-- Use the same for the password, and NULL for last login time.
TRUNCATE TABLE users;
INSERT INTO Users(Username, Password, FullName, LastLogin)
	SELECT (FirstName + '' + LastName),
		   ( SUBSTRING(FirstName, 0, 3) + '' + LastName + 'Primerno'),
		   (FirstName + ' ' + LastName),
		   ('1.1.1')
	FROM Employees
	
-- 23. Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010.
UPDATE Users
SET Password = 'NULLLL'
WHERE LastLogin < CONVERT(date,'10.03.2010')

-- 24. Write a SQL statement that deletes all users without passwords (NULL password).
DELETE FROM Users
WHERE Password = 'NULLLL'

-- 25. Write a SQL query to display the average employee salary by department and job title.
SELECT d.Name, JobTitle, AVG(e.Salary) FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, JobTitle

-- 26. Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
SELECT d.Name, e.JobTitle, MIN(e.Salary) FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, JobTitle

-- 27. Write a SQL query to display the town where maximal number of employees work.
SELECT TOP 1 t.Name, COUNT(e.EmployeeID) AS EmplCount FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
		JOIN Towns t ON t.TownID = a.TownID
GROUP BY t.Name
ORDER BY COUNT(e.EmployeeID) DESC

-- 28. Write a SQL query to display the number of managers from each town.
SELECT t.Name, COUNT(e.ManagerID) AS EmplCount FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
		JOIN Towns t ON t.TownID = a.TownID
WHERE e.EmployeeID IN (SELECT DISTINCT ManagerID FROM Employees)
GROUP BY t.Name

-- 29. Write a SQL to create table WorkHours to store work reports for each employee (employee id, date, task, hours, comments).
-- Don't forget to define  identity, primary key and appropriate foreign key. 
--	 	Issue few SQL statements to insert, update and delete of some data in the table.
--		Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
--		For each change keep the old record data, the new record data and the command (insert / update / delete).

CREATE TABLE WorkHours(
	EmployeeID int IDENTITY NOT NULL,
	Date Date NOT NULL,
	Task nvarchar(50) NOT NULL,
	Hours int,
	Comments nvarchar(200),
	CONSTRAINT PK_WorkHours PRIMARY KEY(EmployeeID),
	CONSTRAINT FK_WordHours_Employees FOREIGN KEY(EmployeeID)
		REFERENCES Employees(EmployeeID)
)

CREATE TABLE WorkHoursLogs(
	LogID int IDENTITY NOT NULL,
	Action nvarchar(200) NOT NULL,
	CONSTRAINT PK_WorkHoursLogs PRIMARY KEY(LogID)
)

INSERT INTO WorkHours(Date, Task, Hours, Comments)
VALUES (GETDATE(), 'Develop Chalga App', 8, 'Make the chalga app, Hasan!');

INSERT INTO WorkHours(Date, Task, Hours)
VALUES (GETDATE(), 'Develop TODO App', 10);

DELETE FROM WorkHours
WHERE EmployeeID = 5;

UPDATE WorkHours
SET Comments = 'UPDATE THE CHALGA APP'
WHERE EmployeeID = 3
GO

CREATE TRIGGER tr_WorkHoursInsert ON WorkHours FOR INSERT
AS
	DECLARE @empl_id int, @date date, @task nvarchar(50), @hours int, @comment nvarchar(200);

	SET @empl_id = (SELECT EmployeeID FROM deleted);
	SET @date = (SELECT Date FROM deleted);
	SET @task = (SELECT Task FROM deleted);
	SET @hours = (SELECT Hours FROM deleted);
	SET @comment = (SELECT Comments FROM deleted);


	INSERT INTO WorkHoursLogs(Action) VALUES 
	(
		CONCAT('INSERTED: ', @empl_id,' | ' , @date,' | ' , @task,' | ' , @hours,' | ' , @comment)
	)
GO

CREATE TRIGGER tr_WorkHoursDelete ON WorkHours FOR DELETE
AS
	DECLARE @empl_id int, @date date, @task nvarchar(50), @hours int, @comment nvarchar(200);

	SET @empl_id = (SELECT EmployeeID FROM deleted);
	SET @date = (SELECT Date FROM deleted);
	SET @task = (SELECT Task FROM deleted);
	SET @hours = (SELECT Hours FROM deleted);
	SET @comment = (SELECT Comments FROM deleted);


	INSERT INTO WorkHoursLogs(Action) VALUES 
	(
		CONCAT('DELETED: ', @empl_id,' | ' , @date,' | ' , @task,' | ' , @hours,' | ' , @comment)
	)
GO

CREATE TRIGGER tr_WorkHoursUpdate ON WorkHours FOR UPDATE
AS
	DECLARE @empl_id int, @date date, @task nvarchar(50), @hours int, @comment nvarchar(200);

	SET @empl_id = (SELECT EmployeeID FROM deleted);
	SET @date = (SELECT Date FROM deleted);
	SET @task = (SELECT Task FROM deleted);
	SET @hours = (SELECT Hours FROM deleted);
	SET @comment = (SELECT Comments FROM deleted);

	INSERT INTO WorkHoursLogs(Action) VALUES 
	(
		CONCAT('OLD UPDATED RECORD: ', @empl_id,' | ' , @date,' | ' , @task,' | ' , @hours,' | ' , @comment)
	)

	SET @empl_id = (SELECT EmployeeID FROM inserted);
	SET @date = (SELECT Date FROM inserted);
	SET @task = (SELECT Task FROM inserted);
	SET @hours = (SELECT Hours FROM inserted);
	SET @comment = (SELECT Comments FROM inserted);

	INSERT INTO WorkHoursLogs(Action) VALUES 
	(
		CONCAT('NEW UPDATED RECORD: ', @empl_id,' | ' , @date,' | ' , @task,' | ' , @hours,' | ' , @comment)
	)
GO

-- 30. Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother tables.
-- At the end rollback the transaction.
BEGIN TRAN
	DELETE FROM Employees
	WHERE EmployeeID IN 
	(
		SELECT e.EmployeeID FROM Employees e
			JOIN Departments d ON e.DepartmentID = d.DepartmentID
		WHERE d.Name = 'Sales'
	)
ROLLBACK TRAN

-- 31. Start a database transaction and drop the table EmployeesProjects. Now how you could restore back the lost table data?

-- Create a SnapShot
USE TelerikAcademy
CREATE DATABASE TelerikAcademy_SS
ON
(NAME=TelerikAcademy,
FILENAME='E:\TEST_SS.ss'
)
AS SNAPSHOT OF TelerikAcademy

-- DROP Table
DROP TABLE EmployeesProjects

-- Restore from Snapshot
SELECT * INTO EmployeesProjects
FROM  TelerikAcademy_SS.dbo.EmployeesProjects

-- 32. Find how to use temporary tables in SQL Server.
-- Using temporary tables backup all records from EmployeesProjects and restore them back after dropping and re-creating the table.
SELECT * INTO #EmployeesProjects_TMP
FROM EmployeesProjects;

DROP TABLE EmployeesProjects;

SELECT * INTO EmployeesProjects
FROM #EmployeesProjects_TMP;

DROP TABLE #EmployeesProjects_TMP