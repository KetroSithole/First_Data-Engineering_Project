-- Dropping existing dimension tables if they exist-----------------------------
IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_Channel', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Channel;

IF OBJECT_ID (
    'Computers_dataware_house.dbo.Dim_Province_City',
    'U'
) IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Province_City;

IF OBJECT_ID (
    'Computers_dataware_house.dbo.Dim_Country_State',
    'U'
) IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Country_State;

IF OBJECT_ID (
    'Computers_dataware_house.dbo.Dim_Continent',
    'U'
) IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Continent;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_Customer', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Customer;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_PC_Type', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_PC_Type;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_PC_Make', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_PC_Make;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_Priority', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Priority;

IF OBJECT_ID (
    'Computers_dataware_house.dbo.Dim_SalesPerson',
    'U'
) IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_SalesPerson;

IF OBJECT_ID (
    'Computers_dataware_house.dbo.Dim_Sales_Person_Department',
    'U'
) IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Sales_Person_Department;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_Shop', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_Shop;

-----------------------------------------------------------------------------------------------------------------------------------------
-- Creation of Dimension Tables
-- Dim_Channel
CREATE TABLE Computers_dataware_house.dbo.Dim_Channel (
    ChannelID int IDENTITY (1, 1) PRIMARY KEY,
    Channel varchar(50)
);

-- Insert into Dim_Channel
INSERT INTO
    Computers_dataware_house.dbo.Dim_Channel (Channel)
SELECT
    DISTINCT Channel
FROM
    [computer_staging].[dbo].Clean_Channel;

GO
    -- Dim_Continent
    CREATE TABLE Computers_dataware_house.dbo.Dim_Continent (
        ContinentID int IDENTITY (1, 1) PRIMARY KEY,
        Continent varchar(50)
    );

-- Insert into Dim_Continent-------------------------CONTINENT----------------------------
INSERT INTO
    Computers_dataware_house.dbo.Dim_Continent (Continent)
SELECT
    DISTINCT Continent
FROM
    [computer_staging].[dbo].Clean_Continent;

GO
    -------------------------------------------------------------------------------------------------------
    -- Dim_Country_State-----------------------------------------------------------------------------------
    CREATE TABLE [Computers_dataware_house].[dbo].Dim_Country_State (
        CountryStateID int IDENTITY (1, 1) PRIMARY KEY,
        ContinentID int FOREIGN KEY REFERENCES [Computers_dataware_house].[dbo].Dim_Continent(ContinentID),
        Country_or_State varchar(50),
        --Continent varchar(50)
    );

-- Insert into Dim_Country_State
INSERT INTO
    [Computers_dataware_house].dbo.Dim_Country_State (Country_or_State, ContinentID)
SELECT
    DISTINCT A.[Country_or_State],
    ContinentID
FROM
    [computer_staging].[dbo].[Clean_Country_State] as A
    join [Computers_dataware_house].[dbo].[Dim_Continent] AS B ON A.[Continent] = B.[Continent]
GO
    --------------------------------------------------------------------------------------------------------------------------
    -- Dim_Province_City
    USE Computers_dataware_house;

--drop table  [Dim_Province_City]
-- Create Dim_Province_City table
CREATE TABLE dbo.Dim_Province_City (
    ProvinceCityID int IDENTITY(1, 1) PRIMARY KEY,
    CountryStateID int,
    Province_or_City varchar(100)
);

-- Insert into Dim_Province_City
INSERT INTO
    dbo.Dim_Province_City (CountryStateID, Province_or_City)
SELECT
    DISTINCT B.CountryStateID,
    A.Province_or_City
FROM
    [computer_staging].[dbo].Clean_Province_City AS A
    JOIN [Computers_dataware_house].[dbo].[Dim_Country_State] AS B ON A.Country_or_State = B.Country_or_State;

GO
    --------------------------------------------------------------------------------------------------------------------------
    -- Dim_Customer
    CREATE TABLE Computers_dataware_house.dbo.Dim_Customer (
        CustomerID int IDENTITY (1, 1) PRIMARY KEY,
        Customer_Name varchar(50),
        Customer_Surname varchar(50),
        Customer_Contact_Number varchar(50),
        Customer_Email_Address varchar(100)
    );

-- Insert into Dim_Customer
INSERT INTO
    Computers_dataware_house.dbo.Dim_Customer (
        Customer_Name,
        Customer_Surname,
        Customer_Contact_Number,
        Customer_Email_Address
    )
SELECT
    DISTINCT Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
FROM
    [computer_staging].[dbo].Clean_Customer;

GO
    -- Dim_PC_Make
    CREATE TABLE Computers_dataware_house.dbo.Dim_PC_Make (
        PCMakeID int IDENTITY (1, 1) PRIMARY KEY,
        PC_Make varchar(100)
    );

-- Insert into Dim_PC_Make
INSERT INTO
    Computers_dataware_house.dbo.Dim_PC_Make (PC_Make)
SELECT
    DISTINCT PC_Make
FROM
    [computer_staging].[dbo].Clean_PC_Make;

GO
    -- Dim_PC_Type--------------------------------------------------------------------
    CREATE TABLE Computers_dataware_house.dbo.Dim_PC_Type (
        PCTypeID int IDENTITY (1, 1) PRIMARY KEY,
        PCMakeID int FOREIGN KEY REFERENCES Computers_dataware_house.dbo.Dim_PC_Make(PCMakeID),
        PC_Model varchar(100),
        PC_Make varchar(100),
        RAM varchar(50),
        Storage_Capacity varchar(50),
        Storage_Type varchar(50)
    );

-- Insert into Dim_PC_Type
INSERT INTO
    Computers_dataware_house.dbo.Dim_PC_Type (
        ------------------
        PC_Model,
        PCMakeID,
        RAM,
        Storage_Capacity,
        Storage_Type -------------------------------------------
    )
SELECT
    DISTINCT PC_Model,
    RAM,
    Storage_Capacity,
    Storage_Type
FROM
    [computer_staging].[dbo].Clean_PC_Type as A
    JOIN [Computers_dataware_house].[dbo].Dim_PC_Make as B ON A.PC_Make = B.PC_Make ------you have to join this to the pc make to make it  work on the PCMakeID -------
GO
    ---------------------------------------------------------------------------------------------------
    -- Dim_Priority
    CREATE TABLE Computers_dataware_house.dbo.Dim_Priority (
        PriorityID int IDENTITY (1, 1) PRIMARY KEY,
        Priority varchar(50)
    );

-- Insert into Dim_Priority
INSERT INTO
    Computers_dataware_house.dbo.Dim_Priority (Priority)
SELECT
    DISTINCT Priority
FROM
    [computer_staging].[dbo].Clean_Priority;

GO
    ---------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    -- Dim_SalesPerson
    CREATE TABLE Computers_dataware_house.dbo.Dim_SalesPerson (
        SalesPersonID int IDENTITY (1, 1) PRIMARY KEY,
        Sales_Person_Name varchar(100)
    );

-- Insert into Dim_SalesPerson
INSERT INTO
    Computers_dataware_house.dbo.Dim_SalesPerson (Sales_Person_Name)
SELECT
    DISTINCT Sales_Person_Name
FROM
    [computer_staging].[dbo].Clean_SalesPerson;

GO
    ---------------------------------------------------------------------------------------------------
    -- Dim_Sales_Person_Department
    CREATE TABLE Computers_dataware_house.dbo.Dim_Sales_Person_Department (
        SalesPersonDeptID int IDENTITY (1, 1) PRIMARY KEY,
        Sales_Person_Department varchar(100)
    );

-- Insert into Dim_Sales_Person_Department
INSERT INTO
    Computers_dataware_house.dbo.Dim_Sales_Person_Department (Sales_Person_Department)
SELECT
    DISTINCT Sales_Person_Department
FROM
    [computer_staging].[dbo].Clean_Sales_Person_Department;

GO
    ---------------------------------------------------------------------------------------------------
    -- Dim_Shop
    CREATE TABLE Computers_dataware_house.dbo.Dim_Shop (
        ShopID int IDENTITY (1, 1) PRIMARY KEY,
        Shop_Name varchar(100)
    );

-- Insert into Dim_Shop
INSERT INTO
    Computers_dataware_house.dbo.Dim_Shop (Shop_Name)
SELECT
    DISTINCT Shop_Name
FROM
    [computer_staging].[dbo].Clean_Shop;

GO
    ---------------------------------------------------------------------------------------------------
    --------------This is the Final  Step of the Code_--------------------------------------------------
    -- IF OBJECT_ID('Computers_dataware_house.dbo.FactSales', 'U') IS NOT NULL
    --     DROP TABLE Computers_dataware_house.dbo.FactSales;
    -- CREATE TABLE Computers_dataware_house.dbo.FactSales
    -- (
    --     FactSalesID INT IDENTITY(1,1) PRIMARY KEY,--1
    --     ChannelID INT,--2
    --     ContinentID INT,--3
    --     CountryStateID INT,--4
    --     CustomerID INT,--5
    --     PCMakeID INT,--6
    --     PCTypeID INT,--7
    --     PriorityID INT,--8
    --     ProvinceCityID INT,--9
    --     SalesPersonID INT,--10
    --     SalesPersonDeptID INT,--11
    --     ShopID INT,--1
    -- 	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 	Purchase_Date nvarchar(255),
    --     Ship_Date nvarchar(255) ,
    --     ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --     Cost_of_Repairs DECIMAL(18, 2) NULL,
    --     Total_Sales_per_Employee DECIMAL(18, 2) NULL,
    --     PC_Market_Price DECIMAL(18, 2) NULL,
    --     Finance_Amount DECIMAL(18, 2) NULL,
    --     Credit_Score INT NULL,
    --     Cost_Price DECIMAL(18, 2) NULL,
    --     Sale_Price DECIMAL(18, 2) NULL,
    --     Shop_Age INT NULL,
    --     Discount_Amount DECIMAL(18, 2) NULL,
    --     Payment_Method VARCHAR(50) NULL,
    -- );
    -- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- INSERT INTO Computers_dataware_house.dbo.FactSales
    --     (
    --     ChannelID,
    --     ContinentID ,--3
    --     CountryStateID ,--4
    --     CustomerID ,--5
    --     PCMakeID ,--6
    --     PCTypeID ,--7
    --     PriorityID ,--8
    --     ProvinceCityID ,--9
    --     SalesPersonID ,--10
    --     SalesPersonDeptID ,--11
    --     ShopID ,--1
    --     Cost_of_Repairs,
    --     Total_Sales_per_Employee,
    --     PC_Market_Price,
    --     Finance_Amount,
    --     Credit_Score,
    --     Cost_Price,
    --     Sale_Price,
    --     Shop_Age,
    --     Discount_Amount,
    --     Payment_Method,
    -- 	--CAST(REPLACE(CONVERT(VARCHAR(8), [Purchase_Date], 112), '-', '') AS INT),
    -- 	[Purchase_Date] ,------------------------- What is the  best way to do this
    --     [Ship_Date]-------------------------------what is the best way to do this
    --     )
    -- SELECT
    --     ChannelID,
    --     --ContinentID ,--3
    --     --CountryStateID ,--4
    --     CustomerID ,--5
    --    -- PCMakeID ,--6
    --     PCTypeID ,--7
    --     PriorityID ,--8
    --     ProvinceCityID ,--9
    --     SalesPersonID ,--10
    --     SalesPersonDeptID ,--11
    --     ShopID ,--1
    --     Cost_of_Repairs,
    --     Total_Sales_per_Employee,
    --     PC_Market_Price,
    --     Finance_Amount,
    --     Credit_Score,
    --     Cost_Price,
    --     Sale_Price,
    --     Shop_Age,
    --     Discount_Amount,
    --     Payment_Method,
    --     [Purchase_Date] as Purchase_DATE_ID,------------------------- What is the  best way to do this
    --     [Ship_Date]-------------------------------what is the best way to do this
    -- 	FROM [computer_shops].[dbo].[pc_data] pc
    --     -- Joining tables
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Channel] AS chan
    --     ON chan.[Channel] = pc.[Channel]
    --     JOIN [Computers_dataware_house].[dbo].[Dim_continent] AS conti
    --     ON conti.continent = pc.continent
    --     JOIN [Computers_dataware_house].[dbo].[Dim_country_state] AS cont_state
    --     ON cont_state.Country_or_State = pc.Country_or_State
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Customer] cu
    --     ON pc.[Customer_Email_Address] = cu.[Customer_Email_Address]
    --         AND pc.Customer_Name = cu.Customer_Name
    --         AND pc.customer_surname = cu.customer_surname
    --     JOIN [Computers_dataware_house].[dbo].[Dim_PC_Make] pm
    -- 		ON pc.PC_Make = pm.PC_Make
    --     JOIN [Computers_dataware_house].[dbo].[Dim_PC_Type] pt
    -- 		ON pc.PC_Model = pt.PC_Model
    --         AND pc.ram = pt.ram
    --         AND pc.[Storage_Type] = pt.[Storage_Type]
    --         AND pc.[Storage_Capacity] = pt.[Storage_Capacity]
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Priority] pr
    -- 		ON pc.Priority = pr.Priority
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Province_City] prov
    -- 		ON prov.Province_or_City = pc.Province_or_City
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Sales_Person_Department] spd
    -- 		ON pc.Sales_Person_Department = spd.Sales_Person_Department
    --     JOIN [Computers_dataware_house].[dbo].[Dim_SalesPerson] sp
    -- 		ON pc.Sales_Person_Name = sp.Sales_Person_Name
    --     JOIN [Computers_dataware_house].[dbo].[Dim_Shop] sh
    -- 		ON pc.Shop_Name = sh.Shop_Name;
    -------------There is a code here Expand to see  -----------------------------------------------------------------------------------------------------
    --FROM [computer_shops].[dbo].[pc_data] pc
    --    --------------Join these tables now -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --    join [Computers_dataware_house].[dbo].[Dim_Channel] as chan
    --    on  chan.[Channel]=pc.[Channel]
    --    join [Computers_dataware_house].[dbo].[Dim_continent] as conti
    --    on conti.continent=pc.continent
    --    join [Computers_dataware_house].[dbo].[Dim_country_state] as cont_state
    --    on cont_state.Country_or_State=pc.Country_or_State
    --    JOIN [Computers_dataware_house].[dbo].[Dim_Customer] cu
    --    on pc.[Customer_Email_Address]=cu.[Customer_Email_Address]
    --        and pc.Customer_Name = cu.Customer_Name
    --        and pc.customer_surname=cu.customer_surname
    --    --and pc.Customer_Contact_Number=cu.Customer_Contact_Number
    --    JOIN [Computers_dataware_house].[dbo].[Dim_PC_Make] pm
    --    ON pc.PC_Make = pm.PC_Make
    --    JOIN [Computers_dataware_house].[dbo].[Dim_PC_Type] pt
    --    ON pc.PC_Model = pt.PC_Model
    --        and pc.ram=pt.ram
    --        and pc.[Storage_Type]=pt.[Storage_Type]
    --        and pc.[Storage_Capacity]=pt.[Storage_Capacity]
    --    JOIN [Computers_dataware_house].[dbo].[Dim_Priority] pr
    --    ON pc.Priority = pr.Priority
    --    JOIN [Computers_dataware_house].[dbo].[Dim_Province_City] prov
    --    ON prov.Province_or_City = pc.Province_or_City
    --    JOIN [Computers_dataware_house].[dbo].[Dim_Sales_Person_Department] spd
    --    ON pc.Sales_Person_Department = spd.Sales_Person_Department
    --    JOIN [Computers_dataware_house].[dbo].[Dim_SalesPerson] sp
    --    ON pc.Sales_Person_Name = sp.Sales_Person_Name
    --    JOIN [Computers_dataware_house].[dbo].[Dim_Shop] sh
    --    ON pc.Shop_Name = sh.Shop_Name;
    -- UPDATE Computers_dataware_house.DBO.FactSales
    -- SET [Purchase_Date] = REPLACE([Purchase_Date], '-', '');
    -- ALTER TABLE Computers_dataware_house.dbo.FactSales
    -- ADD Purchase_DATE_ID nvarchar(255);
    -- -- Update the new column with values from the existing column
    -- UPDATE Computers_dataware_house.dbo.FactSales
    -- SET Purchase_DATE_ID = REPLACE(Purchase_Date, '-', '');
    -- UPDATE Computers_dataware_house.dbo.FactSales
    -- SET Ship_Date = NULLIF(REPLACE(Ship_Date, '-', ''), 'N/A');
    ---------------------------just make sure u bring the date here also the  is  good for Joining
    ---------------------------------------------------------------------------------
    ----On the Snowflake u need to link these things suying