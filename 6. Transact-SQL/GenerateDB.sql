USE [master]
GO
/****** Object:  Database [Bank]    Script Date: 15.7.2013 ã. 23:14:51 ******/
CREATE DATABASE [Bank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Bank.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Bank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Bank_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Bank] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bank] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bank] SET RECOVERY FULL 
GO
ALTER DATABASE [Bank] SET  MULTI_USER 
GO
ALTER DATABASE [Bank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bank] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bank', N'ON'
GO
USE [Bank]
GO
/****** Object:  StoredProcedure [dbo].[usp_CalcInterestForOneMonth]    Script Date: 15.7.2013 ã. 23:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_CalcInterestForOneMonth](@interest float, @accountID int)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full name], dbo.ufn_Calc(a.Balance, @interest, 1) AS [Monthly Interest] FROM People p
		JOIN Accounts a ON p.PersonID = a.PersonID
	WHERE a.AccountID > @accountID


GO
/****** Object:  StoredProcedure [dbo].[usp_DepositMoney]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_DepositMoney](@accountID int, @money float)
AS
BEGIN TRAN
	UPDATE Accounts
	SET Balance += @money
	WHERE AccountID = @accountID
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_EvaluateMoneyAmount]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_EvaluateMoneyAmount](@amount money = 1000)
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Full name] FROM People p
		JOIN Accounts a ON p.PersonID = a.PersonID
	WHERE a.Balance > @amount


GO
/****** Object:  StoredProcedure [dbo].[usp_GetFullNames]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_GetFullNames]
AS
	SELECT FirstName + ' ' + LastName AS [Full name] FROM People

GO
/****** Object:  StoredProcedure [dbo].[usp_WithdrawMoney]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_WithdrawMoney](@accountID int, @money float)
AS
BEGIN TRAN
	UPDATE Accounts
	SET Balance -= @money
	WHERE AccountID = @accountID
COMMIT

GO
/****** Object:  UserDefinedFunction [dbo].[CheckIfHasLetters]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckIfHasLetters] (@word nvarchar(20), @letters nvarchar(20))
RETURNS BIT
AS
BEGIN

DECLARE @lettersLen int = LEN(@letters),
@matches int = 0,
@currentChar nvarchar(1)

WHILE(@lettersLen > 0)
BEGIN
	SET @currentChar = SUBSTRING(@letters, @lettersLen, 1)
	IF(CHARINDEX(@currentChar, @word, 0) > 0)
		BEGIN
			SET @matches += 1
			SET @lettersLen -= 1
		END
	ELSE
		SET @lettersLen -= 1
END

IF(@matches >= LEN(@word) OR @matches >= LEN(@letters))
	RETURN 1

RETURN 0
END


GO
/****** Object:  UserDefinedFunction [dbo].[NamesAndTowns]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[NamesAndTowns](@letters nvarchar(20))
RETURNS @ResultTable TABLE
(
Name varchar(50) NOT NULL
)
AS
BEGIN

INSERT INTO @ResultTable
SELECT LastName  FROM Employees

INSERT INTO @ResultTable
SELECT FirstName FROM Employees

INSERT INTO @ResultTable
SELECT towns.Name FROM Towns towns

DELETE FROM @ResultTable
WHERE dbo.CheckIfHasLetters(Name, @letters) = 0

RETURN
END


GO
/****** Object:  UserDefinedFunction [dbo].[ufn_Calc]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufn_Calc](@amount money, @interestRate float, @numberOfMonths int)
RETURNS money
AS
BEGIN
	DECLARE @newAmount money;
	SET @newAmount = @amount * (1 + @interestRate * @numberOfMonths);

	RETURN @newAmount;
END
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NOT NULL,
	[Balance] [money] NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Logs]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[OldSum] [money] NOT NULL,
	[NewSum] [money] NOT NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[People]    Script Date: 15.7.2013 ã. 23:14:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[SSN] [nvarchar](50) NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountID], [PersonID], [Balance]) VALUES (2, 1, 5000.0000)
INSERT [dbo].[Accounts] ([AccountID], [PersonID], [Balance]) VALUES (5, 2, 200.0000)
INSERT [dbo].[Accounts] ([AccountID], [PersonID], [Balance]) VALUES (6, 3, 10500.0000)
INSERT [dbo].[Accounts] ([AccountID], [PersonID], [Balance]) VALUES (7, 4, 0.0000)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([LogID], [AccountID], [OldSum], [NewSum]) VALUES (1, 5, 100.0000, 200.0000)
SET IDENTITY_INSERT [dbo].[Logs] OFF
SET IDENTITY_INSERT [dbo].[People] ON 

INSERT [dbo].[People] ([PersonID], [FirstName], [LastName], [SSN]) VALUES (1, N'Kiro', N'Kireto', N'6565465698')
INSERT [dbo].[People] ([PersonID], [FirstName], [LastName], [SSN]) VALUES (2, N'Misho', N'Misheto', N'8456653228')
INSERT [dbo].[People] ([PersonID], [FirstName], [LastName], [SSN]) VALUES (3, N'Petkancho', N'Petenceto', N'6564522899')
INSERT [dbo].[People] ([PersonID], [FirstName], [LastName], [SSN]) VALUES (4, N'Kolio', N'Terorista', N'0000000000')
SET IDENTITY_INSERT [dbo].[People] OFF
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_People] FOREIGN KEY([PersonID])
REFERENCES [dbo].[People] ([PersonID])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_People]
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD  CONSTRAINT [FK_Logs_Accounts] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Logs] CHECK CONSTRAINT [FK_Logs_Accounts]
GO
USE [master]
GO
ALTER DATABASE [Bank] SET  READ_WRITE 
GO