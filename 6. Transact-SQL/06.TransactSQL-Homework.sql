--01. Create a database with two tables: Persons(Id(PK), FirstName, LastName, SSN) and Accounts(Id(PK), PersonId(FK), Balance).
-- Insert few records for testing. Write a stored procedure that selects the full names of all persons.
CREATE PROC usp_GetFullNames
AS
	SELECT FirstName + ' ' + LastName AS [Full name] FROM People
GO
EXEC usp_GetFullNames
GO

--02. Create a stored procedure that accepts a number as a parameter and returns all persons who have more money in their accounts
-- than the supplied number.
CREATE PROC usp_EvaluateMoneyAmount(@amount money = 1000)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full name] FROM People p
		JOIN Accounts a ON p.PersonID = a.PersonID
	WHERE a.Balance > @amount

GO
EXEC usp_EvaluateMoneyAmount 500
GO

--03. Create a function that accepts as parameters – sum, yearly interest rate and number of months.
-- It should calculate and return the new sum. Write a SELECT to test whether the function works as expected.
CREATE FUNCTION ufn_Calc(@amount money, @interestRate float, @numberOfMonths int)
RETURNS money
AS
BEGIN
	DECLARE @newAmount money;
	SET @newAmount = @amount * (1 + @interestRate * @numberOfMonths);

	RETURN @newAmount;
END
GO
SELECT dbo.ufn_Calc(1000, 5.5, 12) AS [New amount]
GO

--04. Create a stored procedure that uses the function from the previous example to give an interest to a person's account
-- for one month. It should take the AccountId and the interest rate as parameters.
CREATE PROC usp_CalcInterestForOneMonth(@interest float, @accountID int)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full name], dbo.ufn_Calc(a.Balance, @interest, 1) AS [Monthly Interest] FROM People p
		JOIN Accounts a ON p.PersonID = a.PersonID
	WHERE a.AccountID > @accountID

GO
EXEC usp_CalcInterestForOneMonth 5.5, 2
GO

--05. Add two more stored procedures WithdrawMoney( AccountId, money) and DepositMoney (AccountId, money) that operate in transactions.
CREATE PROC usp_WithdrawMoney(@accountID int, @money float)
AS
BEGIN TRAN
	UPDATE Accounts
	SET Balance -= @money
	WHERE AccountID = @accountID
COMMIT
GO

CREATE PROC usp_DepositMoney(@accountID int, @money float)
AS
BEGIN TRAN
	UPDATE Accounts
	SET Balance += @money
	WHERE AccountID = @accountID
COMMIT
GO

EXEC usp_WithdrawMoney 6, 500
EXEC usp_DepositMoney  6, 5000
GO

--06. Create another table – Logs(LogID, AccountID, OldSum, NewSum). Add a trigger to the Accounts table that enters a new entry
-- into the Logs table every time the sum on an account changes.
CREATE TRIGGER tr_onAccountChanges ON Accounts AFTER UPDATE
AS
	DECLARE @personId int, @balanceBefore money, @balanceAfter money
	SELECT @personId = del.AccountId, @balanceBefore = del.Balance FROM deleted del
	SELECT @balanceAfter = ins.Balance FROM inserted ins

	INSERT INTO Logs
	VALUES (@personId, @balanceBefore, @balanceAfter)
GO

EXEC usp_DepositMoney 5, 1000
GO

--08. Using database cursor write a T-SQL script that scans all employees and their addresses
CREATE PROC uspEmployeesInTown @results CURSOR VARYING OUTPUT
AS
BEGIN

	SET @results = CURSOR FOR

	SELECT emp.LastName, towns.Name FROM Employees emp
		JOIN Addresses addr ON emp.AddressID = addr.AddressID
		JOIN Towns towns ON addr.TownID = towns.TownID
	GROUP BY towns.TownID, towns.Name, emp.LastName

	OPEN @results
END

GO

DECLARE @employeesInTowns CURSOR
DECLARE @LastName varchar(20), @TownName varchar(20)

EXEC uspEmployeesInTown @results = @employeesInTowns OUTPUT
