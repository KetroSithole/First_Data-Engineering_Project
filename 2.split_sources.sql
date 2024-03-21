--1.source_Continent
SELECT DISTINCT [Continent]
FROM [computer_staging].[dbo].[pc_data];


--2.source_Country_State
SELECT DISTINCT [Country_or_State],[Continent]
FROM [computer_staging].[dbo].[pc_data];

--3.source_Province_City
SELECT DISTINCT [Province_or_City],[Country_or_State]
FROM [computer_staging].[dbo].[pc_data];


--4.source_Shop 
SELECT DISTINCT [Shop_Name]
FROM [computer_staging].[dbo].[pc_data];


--5.source_Pc_Type
SELECT DISTINCT  [PC_Model], [RAM], [Storage_Capacity], [Storage_Type],[pc_make]
FROM [computer_staging].[dbo].[pc_data];


--6.source_Customer
SELECT distinct [Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address]
FROM [computer_staging].[dbo].[pc_data];


--7.source_SalesPerson
SELECT DISTINCT [Sales_Person_Name]
FROM [computer_staging].[dbo].[pc_data];

--8.source_Sales_Person_Department
SELECT DISTINCT [Sales_Person_Department]
FROM [computer_shops].[dbo].[pc_data];




--9.source_Date
SELECT DISTINCT [Purchase_Date], [Ship_Date]
FROM [computer_staging].[dbo].[pc_data];


--10.source_Channel
SELECT DISTINCT [Channel]
FROM [computer_staging].[dbo].[pc_data];

--11.source_Priority
SELECT DISTINCT [Priority]
FROM [computer_staging].[dbo].[pc_data];

--12. Source Fact--------------------but you dont need this because u will join in the main fact table 
SELECT DISTINCT [Cost_of_Repairs], [Total_Sales_per_Employee], [PC_Market_Price], [Finance_Amount], [Credit_Score], [Cost_Price], [Sale_Price], [Shop_Age], [Discount_Amount],[Payment_Method]
FROM [computer_staging].[dbo].[pc_data];


--5.source_Pc_Make
SELECT DISTINCT [PC_Make]
FROM [computer_staging].[dbo].[pc_data];