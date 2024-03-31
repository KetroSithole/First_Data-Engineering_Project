INSERT INTO
    Computers_dataware_house.dbo.FactSales (
        ChannelID,
        CustomerID,
        PCTypeID,
        PriorityID,
        ProvinceCityID,
        SalesPersonID,
        SalesPersonDeptID,
        ShopID,
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
        Purchase_Date,
        Ship_Date
    )
SELECT
    fs.ChannelID,
    fs.CustomerID,
    fs.PCTypeID,
    fs.PriorityID,
    fs.ProvinceCityID,
    fs.SalesPersonID,
    fs.SalesPersonDeptID,
    fs.ShopID,
    fs.Cost_of_Repairs,
    fs.Total_Sales_per_Employee,
    fs.PC_Market_Price,
    fs.Finance_Amount,
    fs.Credit_Score,
    fs.Cost_Price,
    fs.Sale_Price,
    fs.Shop_Age,
    fs.Discount_Amount,
    fs.Payment_Method,
    fs.Purchase_Date,
    fs.Ship_Date
FROM
    Computers_dataware_house.dbo.FactSales fs
    JOIN Computers_dataware_house.dbo.Dim_Province_City pc ON fs.ProvinceCityID = pc.ProvinceCityID
    JOIN Computers_dataware_house.dbo.Dim_Customer cu ON fs.CustomerID = cu.CustomerID
    JOIN Computers_dataware_house.dbo.Dim_PC_Type pt ON fs.PCTypeID = pt.PCTypeID
    JOIN Computers_dataware_house.dbo.Dim_Priority pr ON fs.PriorityID = pr.PriorityID
    JOIN Computers_dataware_house.dbo.Dim_SalesPerson sp ON fs.SalesPersonID = sp.SalesPersonID
    JOIN Computers_dataware_house.dbo.Dim_Sales_Person_Department spd ON fs.SalesPersonDeptID = spd.SalesPersonDeptID
    JOIN Computers_dataware_house.dbo.Dim_Shop sh ON fs.ShopID = sh.ShopID
    JOIN Computers_dataware_house.dbo.Dim_Channel ch ON fs.ChannelID = ch.ChannelID;