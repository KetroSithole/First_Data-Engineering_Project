IF OBJECT_ID('Computers_dataware_house.dbo.FactSales', 'U') IS NOT NULL
      DROP TABLE Computers_dataware_house.dbo.FactSales;
  CREATE TABLE Computers_dataware_house.dbo.FactSales
  (
      FactSalesID INT IDENTITY(1,1) PRIMARY KEY,--1
      ChannelID INT,--2
     -- ContinentID INT,--3
     -- CountryStateID INT,--4
      CustomerID INT,--5
      --PCMakeID INT,--6
      PCTypeID INT,--7
      PriorityID INT,--8
      ProvinceCityID INT,--9
      SalesPersonID INT,--10
      SalesPersonDeptID INT,--11
      ShopID INT,--1
  	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  	  Purchase_Date nvarchar(255),
      Ship_Date nvarchar(255) ,
      ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      Cost_of_Repairs DECIMAL(18, 2) NULL,
      Total_Sales_per_Employee DECIMAL(18, 2) NULL,
      PC_Market_Price DECIMAL(18, 2) NULL,
      Finance_Amount DECIMAL(18, 2) NULL,
      Credit_Score INT NULL,
      Cost_Price DECIMAL(18, 2) NULL,
      Sale_Price DECIMAL(18, 2) NULL,
      Shop_Age INT NULL,
      Discount_Amount DECIMAL(18, 2) NULL,
      Payment_Method VARCHAR(50) NULL,
  ) ;
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  INSERT INTO Computers_dataware_house.dbo.FactSales
      (
      ChannelID,
      --ContinentID ,--3
      --CountryStateID ,--4
      CustomerID ,--5
     -- PCMakeID ,--6
      PCTypeID ,--7
      PriorityID ,--8
      ProvinceCityID ,--9
      SalesPersonID ,--10
      SalesPersonDeptID ,--11
      ShopID ,--1
      Cost_of_Repairs,
      Total_Sales_per_Employee,
      PC_Market_Price,
      Finance_Amount,
      Credit_Score,
      Cost_Price,
      Sale_Price,
      Shop_Age,
      Discount_Amount,
      Payment_Method,
  	--CAST(REPLACE(CONVERT(VARCHAR(8), [Purchase_Date], 112), '-', '') AS INT),
  	  [Purchase_Date] ,------------------------- What is the  best way to do this
      [Ship_Date]-------------------------------what is the best way to do this
      )
  --SELECT
  --    ChannelID,
  --    --ContinentID ,--3
  --    --CountryStateID ,--4
  --    CustomerID ,--5
  --   -- PCMakeID ,--6
  --    PCTypeID ,--7
  --    PriorityID ,--8
  --    prov.ProvinceCityID ,--9
  --    SalesPersonID ,--10
  --    SalesPersonDeptID ,--11
  --    ShopID ,--1
  --    Cost_of_Repairs,
  --    Total_Sales_per_Employee,
  --    PC_Market_Price,
  --    Finance_Amount,
  --    Credit_Score,
  --    Cost_Price,
  --    Sale_Price,
  --    Shop_Age,
  --    Discount_Amount,
  --    Payment_Method,
  --    [Purchase_Date],
  --    [Ship_Date]

SELECT
      PCTypeID,
      ChannelID,
     --ContinentID ,--3
     --CountryStateID ,--4
      CustomerID ,--5
     -- PCMakeID ,--6
     
      PriorityID ,--8
      prov.ProvinceCityID ,--9
      SalesPersonID ,--10
      SalesPersonDeptID ,--11
      ShopID ,--1
      Cost_of_Repairs,
      Total_Sales_per_Employee,
      PC_Market_Price,
      Finance_Amount,
      Credit_Score,
      Cost_Price,
      Sale_Price,
      Shop_Age,
      Discount_Amount,
      Payment_Method,
      [Purchase_Date],
      [Ship_Date]--,
	  ---------------------------------------------------------
	  --
	  --THI IS WHERE THE ISSUE START 
	  --
	  --,--7---------- this is where i get the issue 

	  ------------
	  --SELECT *
  	FROM [computer_staging].[dbo].[pc_data] pc
      -- Joining tables
      JOIN [Computers_dataware_house].[dbo].[Dim_Channel] AS chan
      ON chan.[Channel] = pc.[Channel]------
      JOIN [Computers_dataware_house].[dbo].[Dim_continent] AS conti
      ON conti.continent = pc.continent  --------FINE 

      JOIN [Computers_dataware_house].[dbo].[Dim_country_state] AS cont_state
      ON cont_state.Country_or_State = pc.Country_or_State-------FINE 
	 
	 

      JOIN [Computers_dataware_house].[dbo].[Dim_Priority] pr
  		ON pc.Priority = pr.Priority
      JOIN [Computers_dataware_house].[dbo].[Dim_Province_City] prov
  		ON prov.Province_or_City = pc.Province_or_City  and prov.CountryStateID=cont_state.CountryStateID --fine 



      JOIN [Computers_dataware_house].[dbo].[Dim_Sales_Person_Department] spd
  		ON pc.Sales_Person_Department = spd.Sales_Person_Department --fine 

      JOIN [Computers_dataware_house].[dbo].[Dim_SalesPerson] sp
  		ON pc.Sales_Person_Name = sp.Sales_Person_Name----- fine 

      JOIN [Computers_dataware_house].[dbo].[Dim_Shop] sh
  		ON pc.Shop_Name = sh.Shop_Name -----fine 





 --   -------THE ISSUE IS HERE 
      JOIN [Computers_dataware_house].[dbo].[Dim_Customer] cu
      ON pc.[Customer_Email_Address] = cu.[Customer_Email_Address]
      AND pc.Customer_Name = cu.Customer_Name
      AND pc.customer_surname = cu.customer_surname ------ fine 
		


     JOIN [Computers_dataware_house].[dbo].[Dim_PC_Make] pm
  	 ON pc.PC_Make = pm.PC_Make ----  FINE 

	 

      JOIN [Computers_dataware_house].[dbo].[Dim_PC_Type] pt    ON   pc.[Storage_Type] = pt.[Storage_Type]
	   AND   pc.PC_Model = pt.PC_Model
       AND   pc.ram = pt.ram
	   AND   pc.[Storage_Capacity] = pt.[Storage_Capacity]
       and  pm.PCMakeID = pt.PCMakeID 