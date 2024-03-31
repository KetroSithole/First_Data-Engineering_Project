--1 Stored procedure for cleaning Channel
CREATE PROCEDURE [dbo].[usp_Clean_Channel]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Channel', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Channel;

    CREATE TABLE [computer_staging].[dbo].[Clean_Channel]
    (
        [Channel] varchar(50)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Channel]
        ([Channel])
    SELECT DISTINCT TRIM([Channel]) AS TrimmedChannel
    FROM computer_staging.dbo.[source_Channel];
END;
GO

--2 Stored procedure for cleaning Continent
CREATE PROCEDURE [dbo].[usp_Clean_Continent]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Continent', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Continent;

    CREATE TABLE [computer_staging].[dbo].[Clean_Continent]
    (
        [Continent] varchar(50)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Continent]
        ([Continent])
    SELECT DISTINCT TRIM([Continent]) AS TrimmedContinent
    FROM computer_staging.dbo.[source_Continent];
END;
GO

--3 Stored procedure for cleaning Country or State
CREATE PROCEDURE [dbo].[usp_Clean_Country_State]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Country_State', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Country_State;

    CREATE TABLE [computer_staging].[dbo].[Clean_Country_State]
    (
        [Country_or_State] varchar(50),
        [Continent] varchar(50)
    );

    INSERT INTO computer_staging.dbo.[Clean_Country_State] ([Country_or_State], [Continent])
    SELECT DISTINCT TRIM([Country_or_State]) AS Country_State, Continent
    FROM computer_staging.dbo.[source_Country_State];
END;
GO

--4 Stored procedure for cleaning Customer
CREATE PROCEDURE [dbo].[usp_Clean_Customer]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Customer', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Customer;

    CREATE TABLE [computer_staging].[dbo].[Clean_Customer]
    (
        [Customer_Name] varchar(50),
        [Customer_Surname] varchar(50),
        [Customer_Contact_Number] varchar(50),
        -- Increased size
        [Customer_Email_Address] varchar(100)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Customer]
        ([Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address])
    SELECT --DISTINCT 
        [Customer_Name],
        [Customer_Surname],
        REPLACE(REPLACE(REPLACE([Customer_Contact_Number], '-', ''), '(', ''), ')', '') AS CleanedContactNumber,
        [Customer_Email_Address]
    FROM computer_staging.dbo.[source_Customer];
END;
GO

-- Stored procedure for cleaning PC Make
CREATE PROCEDURE [dbo].[usp_Clean_PC_Make]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_PC_Make', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_PC_Make;

    CREATE TABLE [computer_staging].[dbo].[Clean_PC_Make]
    (
        [PC_Make] varchar(100)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_PC_Make]
        ([PC_Make])
    SELECT DISTINCT TOP (1000)
        [PC_Make]
    FROM computer_staging.dbo.[source_Pc_Make];
END;
GO

--5 Stored procedure for cleaning PC Type
CREATE PROCEDURE [dbo].[usp_Clean_PC_Type]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_PC_Type', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_PC_Type;

    CREATE TABLE [computer_staging].[dbo].[Clean_PC_Type]
    (
        [PC_Make] varchar(100),
        [PC_Model] varchar(100),
        [RAM] varchar(50),
        [Storage_Capacity] varchar(50),
        [Storage_Type] varchar(50)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_PC_Type] ([PC_Make], [PC_Model], [RAM], [Storage_Capacity], [Storage_Type])
    SELECT DISTINCT [PC_Make], [PC_Model], [RAM], [Storage_Capacity], [Storage_Type]
    FROM [computer_staging].[dbo].[source_Pc_Type];
END;
GO


--6 Stored procedure for cleaning Priority
CREATE PROCEDURE [dbo].[usp_Clean_Priority]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Priority', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Priority;

    CREATE TABLE [computer_staging].[dbo].[Clean_Priority]
    (
        [Priority] varchar(50)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Priority]
        ([Priority])
    SELECT DISTINCT [Priority]
    FROM computer_staging.dbo.[source_Priority];
END;
GO

--7 Stored procedure for cleaning Province or City
CREATE PROCEDURE [dbo].[usp_Clean_Province_City]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Province_City', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Province_City;

    CREATE TABLE [computer_staging].[dbo].[Clean_Province_City]
    (
        [Province_or_City] varchar(100),
		[Country_or_State] varchar(100)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Province_City]
        ([Province_or_City],[Country_or_State])
    SELECT DISTINCT [Province_or_City],[Country_or_State]
    FROM computer_staging.dbo.[source_Province_City];
END;
GO

--8 Stored procedure for cleaning SalesPerson
CREATE PROCEDURE [dbo].[usp_Clean_SalesPerson]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_SalesPerson', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_SalesPerson;

    CREATE TABLE [computer_staging].[dbo].[Clean_SalesPerson]
    (
        [Sales_Person_Name] varchar(100)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_SalesPerson]
        ([Sales_Person_Name])
    SELECT DISTINCT [Sales_Person_Name]
    FROM computer_staging.dbo.[source_SalesPerson];
END;
GO

--9 Stored procedure for cleaning Sales Person Department
CREATE PROCEDURE [dbo].[usp_Clean_Sales_Person_Department]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Sales_Person_Department', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Sales_Person_Department;

    CREATE TABLE [computer_staging].[dbo].[Clean_Sales_Person_Department]
    (
        [Sales_Person_Department] varchar(100)
    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Sales_Person_Department]
        ([Sales_Person_Department])
    SELECT DISTINCT [Sales_Person_Department]
    FROM computer_staging.dbo.[source_Sales_Person_Department];
END;
GO
--9---------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_Clean_Shop]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('computer_staging.dbo.Clean_Shop', 'U') IS NOT NULL
        DROP TABLE computer_staging.dbo.Clean_Shop;

    CREATE TABLE [computer_staging].[dbo].[Clean_Shop]
    (

        Shop_Name varchar(100)

    ) ON [PRIMARY];

    INSERT INTO computer_staging.dbo.[Clean_Shop]
        ([Shop_Name])
    SELECT DISTINCT [Shop_Name]
    FROM [computer_staging].dbo.[source_Shop];
END;
