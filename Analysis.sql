-- Summary statistics for numerical columns
SELECT
    AVG(Cost_of_Repairs) AS Avg_Cost_of_Repairs,
    AVG(Total_Sales_per_Employee) AS Avg_Total_Sales_per_Employee,
    AVG(PC_Market_Price) AS Avg_PC_Market_Price,
    AVG(Finance_Amount) AS Avg_Finance_Amount,
    AVG(Credit_Score) AS Avg_Credit_Score,
    AVG(Cost_Price) AS Avg_Cost_Price,
    AVG(Sale_Price) AS Avg_Sale_Price,
    AVG(Shop_Age) AS Avg_Shop_Age,
    SUM(Discount_Amount) AS Total_Discount_Amount
FROM
    FactSales;

-- Analyze sales trends over time (e.g., monthly, quarterly, yearly)
-- Calculate moving averages, seasonal decomposition, or growth rates
-- Example: Monthly sales trends
SELECT
    YEAR(Purchase_Date) AS Year,
    MONTH(Purchase_Date) AS Month,
    SUM(Sale_Price) AS Monthly_Sales
FROM
    FactSales
GROUP BY
    YEAR(Purchase_Date),
    MONTH(Purchase_Date)
ORDER BY
    Year,
    Month;

-- Identify frequently co-occurring products in sales transactions
-- Compute association rules to understand which products are often bought together
-- Example: Association rules
-- Calculate CLV to understand the total value a customer brings to the business over their entire relationship
-- Example: CLV calculation
SELECT
    CustomerID,
    SUM(Sale_Price) AS Total_Sales,
    COUNT(*) AS Total_Transactions,
    AVG(Sale_Price) AS Avg_Transaction_Value,
    (SUM(Sale_Price) / COUNT(*)) * AVG(Shop_Age) AS CLV
FROM
    FactSales
GROUP BY
    CustomerID;

-- Analyze sales patterns based on geographic locations (e.g., provinces, cities)
-- Visualize sales on a map and identify areas with high/low sales density
-- Example: Sales by ProvinceCityID
SELECT
    ProvinceCityID,
    COUNT(*) AS Sales_Count
FROM
    FactSales
GROUP BY
    ProvinceCityID;

-- Identify customers who have stopped purchasing from the company
-- Calculate churn rate and analyze factors contributing to churn
-- Example: Churn analysis
SELECT
    CustomerID,
    MAX(Purchase_Date) AS Last_Purchase_Date,
    DATEDIFF(MONTH, MAX(Purchase_Date), GETDATE()) AS Months_Since_Last_Purchase
FROM
    FactSales
GROUP BY
    CustomerID
HAVING
    DATEDIFF(MONTH, MAX(Purchase_Date), GETDATE()) >= 3;

-- Evaluate the performance of different products based on sales volume, revenue, and profitability
-- Identify top-selling products and analyze their contribution to overall sales
-- Example: Product performance analysis
SELECT
    [PCTypeID],
    COUNT(*) AS Sales_Count,
    SUM(Sale_Price) AS Total_Revenue
FROM
    FactSales
GROUP BY
    [PCTypeID]
ORDER BY
    Total_Revenue DESC;

-- Compare sales performance across different channels (e.g., online, offline)
-- Analyze channel effectiveness in reaching target customers and generating revenue
-- Example: Sales channel analysis
SELECT
    ChannelID,
    SUM(Sale_Price) AS Total_Sales
FROM
    FactSales
GROUP BY
    ChannelID;

-- Study the relationship between changes in product prices and corresponding changes in sales volume
-- Estimate price elasticity coefficients to understand price sensitivity of customers
-- Example: Price elasticity analysis
SELECT
    [PCTypeID],
    AVG(Sale_Price) AS Avg_Sale_Price,
    AVG(Discount_Amount) AS Avg_Discount_Amount
FROM
    FactSales
GROUP BY
    [PCTypeID];

-- Explore seasonal patterns in sales data and forecast future sales based on historical trends
-- Identify peak seasons and plan marketing campaigns or promotions accordingly
-- Example: Seasonality analysis
SELECT
    MONTH(Purchase_Date) AS Month,
    AVG(Sale_Price) AS Avg_Sale_Price
FROM
    FactSales
GROUP BY
    MONTH(Purchase_Date)
ORDER BY
    Month;

-- Measure the rate at which customers continue to purchase from the company over time
-- Analyze factors contributing to customer retention and implement strategies to improve it
-- Example: Customer retention analysis
SELECT
    YEAR(Purchase_Date) AS Year,
    COUNT(DISTINCT CustomerID) AS Retained_Customers
FROM
    FactSales
GROUP BY
    YEAR(Purchase_Date);

-- Analyze the performance of different products based on sales volume, revenue, and profitability
-- Identify top-selling products, slow-moving items, and opportunities for cross-selling
-- Example: Top-selling products
SELECT
    top 10 [PCTypeID],
    COUNT(*) AS Sales_Count
FROM
    FactSales
GROUP BY
    [PCTypeID]
ORDER BY
    Sales_Count DESC -- Calculate profit margin for each sale and analyze profitability across different products or customers
    -- Identify opportunities to optimize pricing and cost management
    -- Example: Profit margin calculation
SELECT
    [PCTypeID],
    Sale_Price - Cost_Price AS Avg_Profit_Margin
FROM
    FactSales
GROUP BY
    [PCTypeID];

-- Analyze sales performance by individual salesperson or sales team
-- Identify top-performing salespeople and areas for improvement
-- Example: Sales by SalesPersonID
SELECT
    SalesPersonID,
    SUM(Sale_Price) AS Total_Sales
FROM
    FactSales
GROUP BY
    SalesPersonID
ORDER BY
    Total_Sales DESC;

-- Computer shops analysis
SELECT
    --B.ShopID,
    B.Shop_Name,
    COUNT(*) AS Sales_Count,
    A.Sale_Price AS Avg_Sale_Price
FROM
    FactSales AS A
    JOIN Dim_Shop AS B ON A.ShopID = B.ShopID
GROUP BY
    B.ShopID,
    B.Shop_Name
ORDER BY
    Avg_Sale_Price DESC;

-------------------------------This is Profit Per Shop and  grouped by 
SELECT
    B.ShopID,
    B.Shop_Name,
    COUNT(*) AS Sales_Count,
    SUM(A.Sale_Price - A.Cost_Price) AS Total_Profit
FROM
    FactSales AS A
    JOIN Dim_Shop AS B ON A.ShopID = B.ShopID
GROUP BY
    B.ShopID,
    B.Shop_Name
ORDER BY
    Total_Profit DESC;

-- Query to compare sales performance between North America and Africa
SELECT
    DPC.CountryStateID,
    -- Select the region (North America or Africa)
    COUNT(*) AS Sales_Count,
    -- Count the number of sales
    AVG(FS.Sale_Price) AS Avg_Sale_Price -- Calculate the average sale price
FROM
    FactSales FS
    JOIN Dim_Province_City DPC ON FS.ProvinceCityID = DPC.ProvinceCityID -- Join sales data with region data
WHERE
    DPC.CountryStateID IN (1, 2) -- Filter sales from North America and Africa
GROUP BY
    DPC.CountryStateID;

-- Group results by region
-----------------------select top 10 sales people 
SELECT
    top 10 -- sp.SalesPersonID,
    sp.Sales_Person_Name,
    cs.Country_or_State AS Country,
    c.Continent,
    pc.Province_or_City AS Province,
    SUM(f.Sale_Price) AS Total_Sales
FROM
    FactSales f
    JOIN Dim_SalesPerson sp ON f.SalesPersonID = sp.SalesPersonID
    JOIN Dim_Province_City pc ON f.ProvinceCityID = pc.ProvinceCityID
    JOIN Dim_Country_State cs ON pc.CountryStateID = cs.CountryStateID
    JOIN Dim_Continent c ON cs.ContinentID = c.ContinentID
GROUP BY
    sp.SalesPersonID,
    sp.Sales_Person_Name,
    cs.Country_or_State,
    c.Continent,
    pc.Province_or_City
ORDER BY
    --Country,
    Total_Sales DESC;

-- Summary statistics for numerical columns
SELECT
    AVG(Cost_of_Repairs) AS Avg_Cost_of_Repairs,
    AVG(Total_Sales_per_Employee) AS Avg_Total_Sales_per_Employee,
    AVG(PC_Market_Price) AS Avg_PC_Market_Price,
    AVG(Finance_Amount) AS Avg_Finance_Amount,
    AVG(Credit_Score) AS Avg_Credit_Score,
    AVG(Cost_Price) AS Avg_Cost_Price,
    AVG(Sale_Price) AS Avg_Sale_Price,
    AVG(Shop_Age) AS Avg_Shop_Age,
    SUM(Discount_Amount) AS Total_Discount_Amount
FROM
    FactSales;

-- Analyze sales trends over time (e.g., monthly, quarterly, yearly)
-- Calculate moving averages, seasonal decomposition, or growth rates
-- Example: Monthly sales trends
SELECT
    YEAR(Purchase_Date) AS Year,
    MONTH(Purchase_Date) AS Month,
    SUM(Sale_Price) AS Monthly_Sales
FROM
    FactSales
GROUP BY
    YEAR(Purchase_Date),
    MONTH(Purchase_Date)
ORDER BY
    Year,
    Month;

-- Identify frequently co-occurring products in sales transactions
-- Compute association rules to understand which products are often bought together
-- Example: Association rules
-- Calculate CLV to understand the total value a customer brings to the business over their entire relationship
-- Example: CLV calculation
SELECT
    CustomerID,
    SUM(Sale_Price) AS Total_Sales,
    COUNT(*) AS Total_Transactions,
    AVG(Sale_Price) AS Avg_Transaction_Value,
    (SUM(Sale_Price) / COUNT(*)) * AVG(Shop_Age) AS CLV
FROM
    FactSales
GROUP BY
    CustomerID;

-- Analyze sales patterns based on geographic locations (e.g., provinces, cities)
-- Visualize sales on a map and identify areas with high/low sales density
-- Example: Sales by ProvinceCityID
SELECT
    ProvinceCityID,
    COUNT(*) AS Sales_Count
FROM
    FactSales
GROUP BY
    ProvinceCityID;

-- Identify customers who have stopped purchasing from the company
-- Calculate churn rate and analyze factors contributing to churn
-- Example: Churn analysis
SELECT
    CustomerID,
    MAX(Purchase_Date) AS Last_Purchase_Date,
    DATEDIFF(MONTH, MAX(Purchase_Date), GETDATE()) AS Months_Since_Last_Purchase
FROM
    FactSales
GROUP BY
    CustomerID
HAVING
    DATEDIFF(MONTH, MAX(Purchase_Date), GETDATE()) >= 3;

-- Evaluate the performance of different products based on sales volume, revenue, and profitability
-- Identify top-selling products and analyze their contribution to overall sales
-- Example: Product performance analysis
SELECT
    [PCTypeID],
    COUNT(*) AS Sales_Count,
    SUM(Sale_Price) AS Total_Revenue
FROM
    FactSales
GROUP BY                              
    [PCTypeID]
ORDER BY
    Total_Revenue DESC;

-- Compare sales performance across different channels (e.g., online, offline)
-- Analyze channel effectiveness in reaching target customers and generating revenue
-- Example: Sales channel analysis
SELECT
    ChannelID,
    SUM(Sale_Price) AS Total_Sales
FROM
    FactSales
GROUP BY
    ChannelID;

-- Study the relationship between changes in product prices and corresponding changes in sales volume
-- Estimate price elasticity coefficients to understand price sensitivity of customers
-- Example: Price elasticity analysis
SELECT
    [PCTypeID],
    AVG(Sale_Price) AS Avg_Sale_Price,
    AVG(Discount_Amount) AS Avg_Discount_Amount
FROM
    FactSales
GROUP BY
    [PCTypeID];

-- Explore seasonal patterns in sales data and forecast future sales based on historical trends
-- Identify peak seasons and plan marketing campaigns or promotions accordingly
-- Example: Seasonality analysis
SELECT
    MONTH(Purchase_Date) AS Month,
    AVG(Sale_Price) AS Avg_Sale_Price
FROM
    FactSales
GROUP BY
    MONTH(Purchase_Date)
ORDER BY
    Month;

-- Measure the rate at which customers continue to purchase from the company over time
-- Analyze factors contributing to customer retention and implement strategies to improve it
-- Example: Customer retention analysis
SELECT
    YEAR(Purchase_Date) AS Year,
    COUNT(DISTINCT CustomerID) AS Retained_Customers
FROM
    FactSales
GROUP BY
    YEAR(Purchase_Date);

-- Analyze the performance of different products based on sales volume, revenue, and profitability
-- Identify top-selling products, slow-moving items, and opportunities for cross-selling
-- Example: Top-selling products
SELECT
    top 10 [PCTypeID],
    COUNT(*) AS Sales_Count
FROM
    FactSales
GROUP BY
    [PCTypeID]
ORDER BY
    Sales_Count DESC -- Calculate profit margin for each sale and analyze profitability across different products or customers
    -- Identify opportunities to optimize pricing and cost management
    -- Example: Profit margin calculation
SELECT
    [PCTypeID],
    Sale_Price - Cost_Price AS Avg_Profit_Margin
FROM
    FactSales
GROUP BY
    [PCTypeID];

-- Analyze sales performance by individual salesperson or sales team
-- Identify top-performing salespeople and areas for improvement
-- Example: Sales by SalesPersonID
SELECT
    SalesPersonID,
    SUM(Sale_Price) AS Total_Sales
FROM
    FactSales
GROUP BY
    SalesPersonID
ORDER BY
    Total_Sales DESC;

-- Computer shops analysis
SELECT
    --B.ShopID,
    B.Shop_Name,
    COUNT(*) AS Sales_Count,
    A.Sale_Price AS Avg_Sale_Price
FROM
    FactSales AS A
    JOIN Dim_Shop AS B ON A.ShopID = B.ShopID
GROUP BY
    B.ShopID,
    B.Shop_Name
ORDER BY
    Avg_Sale_Price DESC;

-------------------------------This is Profit Per Shop and  grouped by 
SELECT
    B.ShopID,
    B.Shop_Name,
    COUNT(*) AS Sales_Count,
    SUM(A.Sale_Price - A.Cost_Price) AS Total_Profit
FROM
    FactSales AS A
    JOIN Dim_Shop AS B ON A.ShopID = B.ShopID
GROUP BY
    B.ShopID,
    B.Shop_Name
ORDER BY
    Total_Profit DESC;

-- Query to compare sales performance between North America and Africa
SELECT
    DPC.CountryStateID,
    -- Select the region (North America or Africa)
    COUNT(*) AS Sales_Count,
    -- Count the number of sales
    AVG(FS.Sale_Price) AS Avg_Sale_Price -- Calculate the average sale price
FROM
    FactSales FS
    JOIN Dim_Province_City DPC ON FS.ProvinceCityID = DPC.ProvinceCityID -- Join sales data with region data
WHERE
    DPC.CountryStateID IN (1, 2) -- Filter sales from North America and Africa
GROUP BY
    DPC.CountryStateID;

-- Group results by region
-----------------------select top 10 sales people 
SELECT
    top 10 -- sp.SalesPersonID,
    sp.Sales_Person_Name,
    cs.Country_or_State AS Country,
    c.Continent,
    pc.Province_or_City AS Province,
    SUM(f.Sale_Price) AS Total_Sales
FROM
    FactSales f
    JOIN Dim_SalesPerson sp ON f.SalesPersonID = sp.SalesPersonID
    JOIN Dim_Province_City pc ON f.ProvinceCityID = pc.ProvinceCityID
    JOIN Dim_Country_State cs ON pc.CountryStateID = cs.CountryStateID
    JOIN Dim_Continent c ON cs.ContinentID = c.ContinentID
GROUP BY
    sp.SalesPersonID,
    sp.Sales_Person_Name,
    cs.Country_or_State,
    c.Continent,
    pc.Province_or_City
ORDER BY
    --Country,
    Total_Sales DESC;

----------------------------
SELECT
    SPT.PC_Make,
    SPT.PC_Model,
    SPT.RAM,
    SPT.Storage_Capacity,
    SPT.Storage_Type,
    SPM.Count_Models
FROM
    [computer_staging].[dbo].[source_Pc_Type] AS SPT
    INNER JOIN (
        SELECT
            PC_Make,
            COUNT(PC_Model) AS Count_Models
        FROM
            [computer_staging].[dbo].[source_Pc_Type]
        GROUP BY
            PC_Make
    ) AS SPM ON SPT.PC_Make = SPM.PC_Make
ORDER BY
    SPT.PC_Make,
    SPT.PC_Model;

--------------------------------------------------
WITH ModelCounts AS (
    SELECT
        PC_Make,
        COUNT(PC_Model) AS Count_Models
    FROM
        [computer_staging].[dbo].[source_Pc_Type]
    GROUP BY
        PC_Make
)
SELECT
    SPM.PC_Make,
    SPT.PC_Model,
    SPT.RAM,
    SPT.Storage_Capacity,
    SPT.Storage_Type,
    MC.Count_Models,
    AVG(CAST(SPT.RAM AS DECIMAL)) OVER(PARTITION BY SPM.PC_Make) AS Avg_RAM_Per_Make,
    AVG(CAST(SPT.Storage_Capacity AS DECIMAL)) OVER(PARTITION BY SPM.PC_Make) AS Avg_Storage_Capacity_Per_Make
FROM
    [computer_staging].[dbo].[source_Pc_Type] AS SPT
    INNER JOIN ModelCounts AS MC ON SPT.PC_Make = MC.PC_Make
    INNER JOIN [computer_staging].[dbo].[source_Pc_Make] AS SPM ON SPT.PC_Make = SPM.PC_Make
ORDER BY
    SPM.PC_Make,
    SPT.PC_Model;