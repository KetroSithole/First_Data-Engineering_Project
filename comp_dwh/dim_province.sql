USE Computers_dataware_house;

drop table [Dim_Province_City] -- Create Dim_Province_City table
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