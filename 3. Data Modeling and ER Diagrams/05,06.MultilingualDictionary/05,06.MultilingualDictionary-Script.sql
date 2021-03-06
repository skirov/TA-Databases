USE [master]
GO
/****** Object:  Database [MultiligualDictionary]    Script Date: 11.7.2013 г. 14:23:01 ******/
CREATE DATABASE [MultiligualDictionary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MultiligualDictionary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MultiligualDictionary.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MultiligualDictionary_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MultiligualDictionary_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MultiligualDictionary] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MultiligualDictionary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MultiligualDictionary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET ARITHABORT OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MultiligualDictionary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MultiligualDictionary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MultiligualDictionary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MultiligualDictionary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MultiligualDictionary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET RECOVERY FULL 
GO
ALTER DATABASE [MultiligualDictionary] SET  MULTI_USER 
GO
ALTER DATABASE [MultiligualDictionary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MultiligualDictionary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MultiligualDictionary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MultiligualDictionary] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MultiligualDictionary', N'ON'
GO
USE [MultiligualDictionary]
GO
/****** Object:  Table [dbo].[Antonyms]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Antonyms](
	[WordId] [int] NOT NULL,
	[AntonymId] [int] NOT NULL,
 CONSTRAINT [PK_Antonyms] PRIMARY KEY CLUSTERED 
(
	[WordId] ASC,
	[AntonymId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hyponyms]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hyponyms](
	[HyponymId] [int] NOT NULL,
	[WordId] [int] NOT NULL,
 CONSTRAINT [PK_Hyponyms] PRIMARY KEY CLUSTERED 
(
	[HyponymId] ASC,
	[WordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Languages]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PartOfWord]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartOfWord](
	[Id] [int] NOT NULL,
	[PartOfWord] [nvarchar](50) NULL,
 CONSTRAINT [PK_PartOfWord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Synonyms]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Synonyms](
	[WordId] [int] NOT NULL,
	[SynonymId] [int] NOT NULL,
 CONSTRAINT [PK_Synonyms] PRIMARY KEY CLUSTERED 
(
	[WordId] ASC,
	[SynonymId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Translations]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Translations](
	[TranslationId] [int] NOT NULL,
	[WordId] [int] NOT NULL,
 CONSTRAINT [PK_Translations] PRIMARY KEY CLUSTERED 
(
	[TranslationId] ASC,
	[WordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Words]    Script Date: 11.7.2013 г. 14:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Words](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Explanation] [nvarchar](100) NULL,
	[PartOfWordId] [int] NOT NULL,
	[HyponymId] [int] NOT NULL,
 CONSTRAINT [PK_Words] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Antonyms]  WITH CHECK ADD  CONSTRAINT [FK_Antonyms_Words] FOREIGN KEY([WordId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Antonyms] CHECK CONSTRAINT [FK_Antonyms_Words]
GO
ALTER TABLE [dbo].[Antonyms]  WITH CHECK ADD  CONSTRAINT [FK_Antonyms_Words1] FOREIGN KEY([AntonymId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Antonyms] CHECK CONSTRAINT [FK_Antonyms_Words1]
GO
ALTER TABLE [dbo].[Hyponyms]  WITH CHECK ADD  CONSTRAINT [FK_Hyponyms_Words] FOREIGN KEY([WordId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Hyponyms] CHECK CONSTRAINT [FK_Hyponyms_Words]
GO
ALTER TABLE [dbo].[Hyponyms]  WITH CHECK ADD  CONSTRAINT [FK_Hyponyms_Words1] FOREIGN KEY([HyponymId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Hyponyms] CHECK CONSTRAINT [FK_Hyponyms_Words1]
GO
ALTER TABLE [dbo].[Synonyms]  WITH CHECK ADD  CONSTRAINT [FK_Synonyms_Words] FOREIGN KEY([WordId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Synonyms] CHECK CONSTRAINT [FK_Synonyms_Words]
GO
ALTER TABLE [dbo].[Synonyms]  WITH CHECK ADD  CONSTRAINT [FK_Synonyms_Words1] FOREIGN KEY([SynonymId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Synonyms] CHECK CONSTRAINT [FK_Synonyms_Words1]
GO
ALTER TABLE [dbo].[Translations]  WITH CHECK ADD  CONSTRAINT [FK_Translations_Words] FOREIGN KEY([TranslationId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Translations] CHECK CONSTRAINT [FK_Translations_Words]
GO
ALTER TABLE [dbo].[Translations]  WITH CHECK ADD  CONSTRAINT [FK_Translations_Words1] FOREIGN KEY([WordId])
REFERENCES [dbo].[Words] ([id])
GO
ALTER TABLE [dbo].[Translations] CHECK CONSTRAINT [FK_Translations_Words1]
GO
ALTER TABLE [dbo].[Words]  WITH CHECK ADD  CONSTRAINT [FK_Words_Languages] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[Words] CHECK CONSTRAINT [FK_Words_Languages]
GO
ALTER TABLE [dbo].[Words]  WITH CHECK ADD  CONSTRAINT [FK_Words_PartOfWord] FOREIGN KEY([PartOfWordId])
REFERENCES [dbo].[PartOfWord] ([Id])
GO
ALTER TABLE [dbo].[Words] CHECK CONSTRAINT [FK_Words_PartOfWord]
GO
USE [master]
GO
ALTER DATABASE [MultiligualDictionary] SET  READ_WRITE 
GO
