IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_PC_Type', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_PC_Type;

IF OBJECT_ID ('Computers_dataware_house.dbo.Dim_PC_Make', 'U') IS NOT NULL DROP TABLE Computers_dataware_house.dbo.Dim_PC_Make;

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
    -- Dim_PC_Type
    CREATE TABLE Computers_dataware_house.dbo.Dim_PC_Type (
        PCTypeID int IDENTITY (1, 1) PRIMARY KEY,
        PCMakeID int FOREIGN KEY REFERENCES Computers_dataware_house.dbo.Dim_PC_Make(PCMakeID),
        PC_Model varchar(100),
        RAM varchar(50),
        Storage_Capacity varchar(50),
        Storage_Type varchar(50)
    );

-- Insert into Dim_PC_Type
INSERT INTO
    Computers_dataware_house.dbo.Dim_PC_Type (
        PCMakeID,
        PC_Model,
        RAM,
        Storage_Capacity,
        Storage_Type
    )
SELECT
    pc.PCMakeID,
    t.PC_Model,
    t.RAM,
    t.Storage_Capacity,
    t.Storage_Type
FROM
    [computer_staging].[dbo].Clean_PC_Type t
    INNER JOIN [Computers_dataware_house].[dbo].[Dim_PC_Make] pc ON t.PC_Make = pc.PC_Make;

GO