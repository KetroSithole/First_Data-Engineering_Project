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

-- Dim_Continent
CREATE TABLE Computers_dataware_house.dbo.Dim_Continent (
    ContinentID int IDENTITY (1, 1) PRIMARY KEY,
    Continent varchar(50)
);

CREATE TABLE Computers_dataware_house.dbo.Dim_Country_State (
    CountryStateID int IDENTITY (1, 1) PRIMARY KEY,
    ContinentID int FOREIGN KEY REFERENCES [Computers_dataware_house].[dbo].Dim_Continent(ContinentID),
    Country_or_State varchar(50)
);

CREATE TABLE Computers_dataware_house.dbo.Dim_Province_City (
    ProvinceCityID int IDENTITY (1, 1) PRIMARY KEY,
    CountryStateID int FOREIGN KEY REFERENCES Computers_dataware_house.dbo.Dim_Country_State(CountryStateID),
    Province_or_City varchar(100)
);

-------------------------------------------------
INSERT INTO
    Computers_dataware_house.dbo.Dim_Continent (Continent)
SELECT
    DISTINCT Continent
FROM
    [computer_staging].[dbo].Clean_Continent;

--------------------------------------------------------------
INSERT INTO
    [Computers_dataware_house].dbo.Dim_Country_State (Country_or_State, ContinentID)
SELECT
    DISTINCT [Country_or_State],
    [ContinentID]
FROM
    [computer_staging].[dbo].[Clean_Country_State] as A
    join [Computers_dataware_house].[dbo].[Dim_Continent] as B ON A.Country_or_State =.B.continent ---------------------------------------------------------------------
INSERT INTO
    Computers_dataware_house.dbo.Dim_Province_City (Province_or_City)
SELECT
    DISTINCT Province_or_City
FROM
    [computer_staging].[dbo].Clean_Province_City as a