-- Drop the existing Dim_PC_Type table if needed
IF OBJECT_ID('Computers_dataware_house.dbo.Dim_PC_Type', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_PC_Type;

-- Create the Dim_PC_Type table
CREATE TABLE Computers_dataware_house.dbo.Dim_PC_Type (
    PCTypeID int IDENTITY (1, 1) PRIMARY KEY,
    PCMakeID int FOREIGN KEY REFERENCES Computers_dataware_house.dbo.Dim_PC_Make(PCMakeID),
    PC_Model varchar(100),
    RAM varchar(50),
    Storage_Capacity varchar(50),
    Storage_Type varchar(50)
);

-- Insert data into Dim_PC_Type from Clean_PC_Type and Dim_PC_Make
INSERT INTO
    Computers_dataware_house.dbo.Dim_PC_Type (
        PCMakeID,
        PC_Model,
        RAM,
        Storage_Capacity,
        Storage_Type
    )
SELECT
    DISTINCT B.PCMakeID,
    A.PC_Model,
    A.RAM,
    A.Storage_Capacity,
    A.Storage_Type
FROM
    [computer_staging].[dbo].Clean_PC_Type as A
    JOIN [Computers_dataware_house].[dbo].Dim_PC_Make as B ON A.PC_Make = B.PC_Make;