DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Channel];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Continent];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Country_State];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Customer];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_PC_Make];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_PC_Type];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Priority];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Province_City];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_SalesPerson];

DROP PROCEDURE IF EXISTS [computer_staging].[dbo].[usp_Clean_Sales_Person_Department];

EXEC [computer_staging].[dbo].[usp_Clean_Channel];

EXEC [computer_staging].[dbo].[usp_Clean_Continent];

EXEC [computer_staging].[dbo].[usp_Clean_Country_State];

EXEC [computer_staging].[dbo].[usp_Clean_Customer];

EXEC [computer_staging].[dbo].[usp_Clean_PC_Make];

EXEC [computer_staging].[dbo].[usp_Clean_PC_Type];

EXEC [computer_staging].[dbo].[usp_Clean_Priority];

EXEC [computer_staging].[dbo].[usp_Clean_Province_City];

EXEC [computer_staging].[dbo].[usp_Clean_SalesPerson];

EXEC [computer_staging].[dbo].[usp_Clean_Sales_Person_Department];