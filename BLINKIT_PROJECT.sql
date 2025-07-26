CREATE DATABASE blinkit;

USE blinkit;

CREATE TABLE blinkit_data(
Item_FatContent VARCHAR(50) NOT NULL,
Item_Weight TEXT NOT NULL,
Total_Sales FLOAT NOT NULL,
Outlet_Type VARCHAR(50) NOT NULL,
Rating FLOAT NOT NULL,
Outlet_Size VARCHAR(50) NOT NULL,
Outlet_LocationType VARCHAR(50) NOT NULL,
Outlet_Identifier VARCHAR(50) NOT NULL,
Item_Type VARCHAR(50) NOT NULL,
Item_Identifier VARCHAR(50) NOT NULL,
Outlet_EstablishmentYear INT NOT NULL,
Item_Visiblity FLOAT NOT NULL
);

SELECT * FROM blinkit_data;

SELECT COUNT(*) FROM blinkit_data;

SHOW COLUMNS FROM blinkit_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE blinkit_data
SET Item_FatContent =
CASE
    WHEN Item_FatContent IN ('LF', 'low fat', 'LowFat') THEN 'Low Fat'
    WHEN Item_FatContent = 'reg' THEN 'Regular'
    ELSE Item_FatContent
END;

SET SQL_SAFE_UPDATES = 1;  -- (Re-enable after the update)

SELECT DISTINCT(Item_FatContent) FROM blinkit_data;

SELECT SUM(Total_Sales) FROM blinkit_data;

SELECT SUM(Total_Sales) AS Total_Sales
FROM blinkit_data;

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions 
FROM blinkit_data;

SELECT AVG(Total_Sales) FROM blinkit_data;

SELECT AVG(Total_Sales) AS Avg_Sales FROM blinkit_data;

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales FROM blinkit_data;

SELECT COUNT(*) AS No_Of_Items FROM blinkit_data;

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions 
FROM blinkit_data
WHERE Outlet_EstablishmentYear = 2022;

SELECT CAST(AVG(Total_Sales)/1000000 AS DECIMAL(10,1)) AS Avg_Sales
FROM blinkit_data
WHERE Outlet_EstablishmentYear = 2022;

SELECT COUNT(*) AS No_Of_Items 
FROM blinkit_data
WHERE Outlet_EstablishmentYear = 2022;

SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating FROM blinkit_data;

SELECT Item_FatContent,
       CAST(SUM(Total_Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
       CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
	   CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
       FROM blinkit_data
       GROUP BY Item_FatContent
       ORDER BY Total_Sales_Thousands DESC;
       
       SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
	   CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
       FROM blinkit_data
       GROUP BY Item_Type
       ORDER BY Total_Sales DESC
       LIMIT 5;
       
        SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
        CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	   CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
       FROM blinkit_data
       GROUP BY Item_Type
       ORDER BY Total_Sales ASC
       LIMIT 5;
       
     SELECT 
    Outlet_LocationType,
    SUM(CASE WHEN Item_FatContent = 'Low Fat' THEN Total_Sales ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN Item_FatContent = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular
FROM blinkit_data
GROUP BY Outlet_LocationType
ORDER BY Outlet_LocationType;

SELECT Outlet_EstablishmentYear, 
  CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
  CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
   COUNT(*) AS No_Of_Items
FROM blinkit_data
GROUP BY Outlet_EstablishmentYear
ORDER BY Outlet_EstablishmentYear;

SELECT Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;
       
    SELECT Outlet_Type, 
        CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,   
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visiblity) AS DECIMAL(10,2)) AS Item_Visiblity
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
   
DROP TABLE blinkit_data;
