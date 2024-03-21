-- Query 1: Average RAM size for North America and Africa
SELECT 
    AVG(CASE WHEN Continent = 'North America' THEN RAM END) AS Average_RAM_North_America,
    AVG(CASE WHEN Continent = 'Africa' THEN RAM END) AS Average_RAM_Africa
FROM 
    computer_staging.dbo.pc_data;

-- Query 2: Total sales amount per continent and payment method
SELECT 
    Continent,
    Payment_Method,
    SUM(Sale_Price) AS Total_Sales_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Continent, Payment_Method;

-- Query 3: Number of sales per PC make and model
SELECT 
    PC_Make,
    PC_Model,
    COUNT(*) AS Sales_Count
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    PC_Make, PC_Model
	order by PC_Make
	
	;

-- Query 4: Average sales price per PC make and model
SELECT 
    PC_Make,
    PC_Model,
    AVG(Sale_Price) AS Average_Sale_Price
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    PC_Make, PC_Model;

-- Query 5: Total sales amount by channel
SELECT 
    Channel,
    SUM(Sale_Price) AS Total_Sales_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Channel;

-- Query 6: Total finance amount per continent
SELECT 
    Continent,
    SUM(Finance_Amount) AS Total_Finance_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Continent;

-- Query 7: Average credit score per continent
SELECT 
    Continent,
    AVG(Credit_Score) AS Average_Credit_Score
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Continent;

-- Query 8: Total sales amount by priority
SELECT 
    Priority,
    SUM(Sale_Price) AS Total_Sales_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Priority;

-- Query 9: Total sales amount by shop age
SELECT 
    Shop_Age,
    SUM(Sale_Price) AS Total_Sales_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Shop_Age;

-- Query 10: Total sales amount by storage type
SELECT 
    Storage_Type,
    SUM(Sale_Price) AS Total_Sales_Amount
FROM 
    computer_staging.dbo.pc_data
GROUP BY 
    Storage_Type;
