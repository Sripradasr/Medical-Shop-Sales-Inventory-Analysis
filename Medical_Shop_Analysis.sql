 MEDICAL SHOP SALES & INVENTORY ANALYSIS
 Tools  : MY SQL
   
 1. KPI ANALYSIS
  -- Total Revenue
SELECT SUM(Revenue) AS TotalRevenue
FROM MedicalShopSales;

-- Total Profit
SELECT SUM(Profit) AS TotalProfit
FROM MedicalShopSales;

-- Total Bills
SELECT COUNT(DISTINCT BillNo) AS TotalBills
FROM MedicalShopSales;

-- Average Bill Value
SELECT SUM(Revenue) / COUNT(DISTINCT BillNo) AS AverageBillValue
FROM MedicalShopSales;

---Total Medicine Sold
SELECT SUM(Quantity) AS TOTALQUANTITY FROM MEDICALSHOPSALES;

====================================================
 2. SALES ANALYSIS

-- Monthly Revenue Trend
SELECT MONTH([Date]) AS MonthNo,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY MONTH([Date])
ORDER BY MonthNo;

-- Revenue by Category
SELECT Category,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY Category
ORDER BY Revenue DESC;

-- Revenue by Brand
SELECT Brand,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY Brand
ORDER BY Revenue DESC;
===================================================
 3. MEDICINE ANALYSIS
  
-- Top 10 Medicines
SELECT TOP 10 MedicineName,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY MedicineName
ORDER BY Revenue DESC;

-- Least Selling Medicines
SELECT TOP 10 MedicineName,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY MedicineName
ORDER BY Revenue ASC;
====================================================
 4. PROFIT ANALYSIS
  
-- Profit by Category
SELECT Category,
       SUM(Profit) AS Profit
FROM MedicalShopSales
GROUP BY Category
ORDER BY Profit DESC;

-- Most Profitable Medicine
SELECT TOP 1 MedicineName,
       SUM(Profit) AS Profit
FROM MedicalShopSales
GROUP BY MedicineName
ORDER BY Profit DESC;
===================================================
 5. CUSTOMER ANALYSIS
  
-- Revenue by Gender
SELECT CustomerGender,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY CustomerGender;

-- Revenue by Age Group
SELECT
CASE
 WHEN CustomerAge BETWEEN 18 AND 30 THEN '18-30'
 WHEN CustomerAge BETWEEN 31 AND 45 THEN '31-45'
 WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
 ELSE '60+'
END AS AgeGroup,
SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY
CASE
 WHEN CustomerAge BETWEEN 18 AND 30 THEN '18-30'
 WHEN CustomerAge BETWEEN 31 AND 45 THEN '31-45'
 WHEN CustomerAge BETWEEN 46 AND 60 THEN '46-60'
 ELSE '60+'
END;
===================================================
 6. PAYMENT ANALYSIS
  
-- Revenue by Payment Mode
SELECT PaymentMode,
       SUM(Revenue) AS Revenue
FROM MedicalShopSales
GROUP BY PaymentMode;


====================================================
 7. INVENTORY ANALYSIS
  
-- Medicines Expiring Within 90 Days
SELECT *
FROM MedicalShopSales
WHERE ExpiryDate BETWEEN GETDATE()
AND DATEADD(DAY,90,GETDATE());

===================================================
 8. WINDOW FUNCTIONS

-- Rank Medicines by Revenue
SELECT MedicineName,
       SUM(Revenue) AS Revenue,
       RANK() OVER(ORDER BY SUM(Revenue) DESC) AS RevenueRank
FROM MedicalShopSales
GROUP BY MedicineName;

-- Dense Rank Categories by Profit
SELECT Category,
       SUM(Profit) AS Profit,
       DENSE_RANK() OVER(ORDER BY SUM(Profit) DESC) AS ProfitRank
FROM MedicalShopSales
GROUP BY Category;

===================================================
 9. VIEWS
  
CREATE VIEW VW_MonthlySales AS
SELECT MONTH([Date]) AS MonthNo,
       SUM(Revenue) AS MonthlyRevenue
FROM MedicalShopSales
GROUP BY MONTH([Date]);

==================================================
 10. STORED PROCEDURES

CREATE PROCEDURE GetTopMedicines
AS
BEGIN
    SELECT TOP 10 MedicineName,
           SUM(Revenue) AS Revenue
    FROM MedicalShopSales
    GROUP BY MedicineName
    ORDER BY Revenue DESC;
END;
