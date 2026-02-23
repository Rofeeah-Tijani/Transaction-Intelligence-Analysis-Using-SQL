--The Transaction Table
SELECT * FROM Opay_Transaction

---Total Credit
SELECT SUM(Credit) AS Total_Credit
FROM Opay_Transaction

---Total Debit
SELECT SUM(Debit) AS Total_Debit
FROM Opay_Transaction

---Total Credit Count
SELECT COUNT(Credit) AS Total_Credit 
FROM Opay_Transaction
WHERE Credit != 0 

---Total Debit Count
SELECT COUNT(Debit) AS Total_Debit 
FROM Opay_Transaction
WHERE Debit != 0 


--Total Credit_Amount
SELECT ROUND(SUM(Credit),2) AS Total_Credit
FROM Opay_Transaction 

 
 ---Total Debit_Amount
 SELECT ROUND(SUM(Debit),2) AS Total_Debit
 FROM Opay_Transaction 

 ---Sum of Credit Alert Per Month
 SELECT Trans_Month, SUM(Credit) AS Total_Credit, YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 ORDER BY SUM(Credit) DESC

 ---Sum of Debit Alert Per Month
 SELECT Trans_Month, SUM(Debit) AS Total_Debit, YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 ORDER BY SUM(Debit) DESC

 ---Count of transaction type
 SELECT Destination_Type,Trans_Type AS Trans_Type,
 COUNT(*) AS Num_Transaction
 FROM Opay_Transaction
 GROUP BY Destination_Type,Trans_Type
 ORDER BY Num_Transaction DESC

 ---Sum of Credit Alert Per Month
 SELECT Trans_Month, SUM(Credit) AS Total_Credit, YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 ORDER BY SUM(Credit) DESC

  ---Count of transaction type(Credit)
 SELECT Destination_Type,Trans_Type AS Trans_Type,
 COUNT(*) AS Num_Transaction
 FROM Opay_Transaction
 WHERE Debit = 0
 GROUP BY Destination_Type,Trans_Type
 ORDER BY Num_Transaction DESC

  ---Count of transaction type(Debit)
 SELECT Destination_Type,Trans_Type AS Trans_Type,
 COUNT(*) AS Num_Transaction
 FROM Opay_Transaction
 WHERE Credit = 0
 GROUP BY Destination_Type,Trans_Type
 ORDER BY Num_Transaction DESC

 ---Monthly Trend of income vs Expenses
 SELECT Trans_Month, SUM(Credit) AS Total_Credit, ROUND(SUM(Debit),1) AS Total_Debit,YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 ORDER BY SUM(Credit) DESC

 ---Months Where Expenses > Income
 SELECT Trans_Month, SUM(Credit) AS Total_Credit, ROUND(SUM(Debit),1) AS Total_Debit,YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 HAVING  SUM(Debit) > SUM(Credit)
 ORDER BY SUM(Credit) DESC

 ---Average Monthly Income And Expenditure
 SELECT Trans_Month, ROUND(AVG(Credit),2) AS Total_Credit, ROUND(AVG(Debit),1) AS Total_Debit,YEAR(Trans_Date) AS Year
 FROM Opay_Transaction
 GROUP BY Trans_Month,YEAR(Trans_Date) 
 ORDER BY SUM(Credit) DESC

 --Monthly Income Aggregration
 WITH monthly_income AS (
    SELECT 
        YEAR(Trans_Date) AS year,
        MONTH(Trans_Date) AS month,
        SUM(Credit) AS total_income
    FROM Opay_Transaction
    GROUP BY 
        YEAR(Trans_Date),
        MONTH(Trans_Date)
)
SELECT 
    AVG(total_income) AS avg_monthly_income,
    STDEV(total_income) AS income_volatility
FROM monthly_income
 
 ---Percentage Volatility
 WITH monthly_income AS (
    SELECT 
        YEAR(Trans_Date) AS year,
        MONTH(Trans_Date) AS month,
        SUM(credit) AS total_income
    FROM Opay_Transaction
    GROUP BY 
        YEAR(Trans_Date),
        MONTH(Trans_Date)
)
SELECT 
    (STDEV(total_income) / NULLIF(AVG(total_income),0)) * 100 
    AS income_volatility_percent
FROM monthly_income

---Percentage Income Spent Each Month
WITH monthly_summary AS (
    SELECT 
        YEAR(Trans_Date) AS year,
        MONTH(Trans_Date) AS month,
        SUM(Credit) AS total_income,
        SUM(Debit) AS total_expense
    FROM Opay_Transaction
    GROUP BY 
        YEAR(Trans_Date),
        MONTH(Trans_Date)
)
SELECT 
    year,
    month,
    total_income,
    total_expense,
    ROUND(
        (total_expense / NULLIF(total_income,0)) * 100,
        2
    ) AS percent_income_spent
FROM monthly_summary
ORDER BY year, month

---The highest transaction type
SELECT TOP 1
    Trans_Type,
    COUNT(*) AS Frequency
FROM Opay_Transaction
GROUP BY Trans_Type
ORDER BY Frequency DESC

---Trans_Bank Trend
SELECT Trans_Destination,COUNT(*) AS Frequency
FROM Opay_Transaction
GROUP BY Trans_Destination
ORDER BY Frequency DESC

---Outgoing Transactions Bank Trend 
SELECT Trans_Destination,COUNT(*) AS Frequency
FROM Opay_Transaction
WHERE Credit = 0
GROUP BY Trans_Destination
ORDER BY Frequency DESC

--Largest Single Debit Transaction
SELECT MAX(Debit) AS Highest_Single_Debit
FROM Opay_Transaction

---2025 Weekly Spending
SELECT Trans_Day,ROUND(SUM(Debit),2) AS Total_Debit 
FROM Opay_Transaction
WHERE YEAR(Trans_Date) = 2025 
GROUP BY Trans_Day
ORDER BY Total_Debit DESC

--Day of the week with the highest spending
SELECT TOP 1 Trans_Day,ROUND(SUM(Debit),2) AS Total_Debit 
FROM Opay_Transaction
GROUP BY Trans_Day
ORDER BY Total_Debit DESC

--- 2025 Weekly Income
SELECT Trans_Day,ROUND(SUM(Credit),2) AS Total_Credit 
FROM Opay_Transaction
WHERE YEAR(Trans_Date) = 2025
GROUP BY Trans_Day
ORDER BY Total_Credit DESC

--2026 Debit
SELECT Trans_Day,ROUND(SUM(Debit),2) AS Total_Debit 
FROM Opay_Transaction
WHERE YEAR(Trans_Date) = 2026
GROUP BY Trans_Day
ORDER BY Total_Debit DESC

--2026 Credit
SELECT Trans_Day,ROUND(SUM(Credit),2) AS Total_Credit 
FROM Opay_Transaction
WHERE YEAR(Trans_Date) = 2026
GROUP BY Trans_Day
ORDER BY Total_Credit DESC

---Transaction Time
SELECT TOP 10 Trans_Time, COUNT(*) AS Frequency 
FROM Opay_Transaction 
GROUP BY Trans_Time
ORDER BY Frequency DESC

--Bank with the highest total transfer
SELECT Trans_Destination, SUM(Debit) AS Total_Debit
FROM Opay_Transaction 
GROUP BY Trans_Destination
ORDER BY Total_Debit DESC

SELECT Trans_Type,SUM(Debit) AS Debit, Trans_Destination, COUNT(*) AS frequency
FROM Opay_Transaction
WHERE Trans_Destination = 'Unknown'
GROUP BY Trans_Destination, Debit, Trans_Type

--Average Transfer Per Bank
SELECT Trans_Destination, ROUND(AVG(Debit),2) AS Avg_Debit
FROM Opay_Transaction 
GROUP BY Trans_Destination
ORDER BY Avg_Debit DESC

--Avg Balance Before And After Credit
SELECT AVG(Balance_After) AS Avg_Balance
FROM Opay_Transaction
WHERE Credit = 0

SELECT AVG(Balance_After) AS Avg_Balance
FROM Opay_Transaction
WHERE Credit != 0

--Average Gap in Days Btw Transaction
WITH date_gaps AS (
    SELECT
        Trans_Date,
        LAG(Trans_Date) OVER (ORDER BY Trans_Date) AS previous_date
    FROM Opay_Transaction
)
SELECT 
    AVG(DATEDIFF(DAY, previous_date, Trans_Date) * 1.0) 
        AS avg_gap_in_days
FROM date_gaps
WHERE previous_date IS NOT NULL

--Longest Period With No Transaction
WITH date_gaps AS (
    SELECT
        Trans_Date,
        LAG(Trans_Date) OVER (ORDER BY Trans_Date) AS previous_date
    FROM Opay_Transaction
)
SELECT 
    MAX(DATEDIFF(DAY, previous_date, Trans_Date)) 
        AS longest_gap_in_days
FROM date_gaps
WHERE previous_date IS NOT NULL

---Longest 5 Period With No Transaction
WITH date_gaps AS (
    SELECT
        Trans_Date,
        LAG(Trans_Date) OVER (ORDER BY Trans_Date) AS previous_date,
        DATEDIFF(DAY, 
                 LAG(Trans_Date) OVER (ORDER BY Trans_Date), 
                 Trans_Date) AS gap_days
    FROM Opay_Transaction
)
SELECT TOP 5
    previous_date,
    Trans_Date,
    gap_days
FROM date_gaps
WHERE previous_date IS NOT NULL
ORDER BY gap_days DESC

--Usually High Transactions Compared To Historical Average
WITH stats AS (
    SELECT 
        AVG(Debit * 1.0) AS mean_amt,
        STDEV(Debit * 1.0) AS std_amt
    FROM Opay_Transaction
    WHERE Debit > 0
)
SELECT 
    o.Trans_Date,
    o.Debit
FROM Opay_Transaction o
CROSS JOIN stats s
WHERE o.Debit > s.mean_amt + s.std_amt

---Transactions Outside Two Standard Deviations
WITH stats AS (
    SELECT 
        AVG(Debit * 1.0) AS mean_amt,
        STDEV(Debit * 1.0) AS std_amt
    FROM Opay_Transaction
    WHERE Debit > 0
)
SELECT 
    o.Trans_Date,
    o.Debit
FROM Opay_Transaction o
CROSS JOIN stats s
WHERE ABS(o.Debit - s.mean_amt) > 2 * s.std_amt

--To Check if spending is increasing over time
WITH monthly_spend AS (
    SELECT 
        YEAR(Trans_Date) AS yr,
        MONTH(Trans_Date) AS mn,
        Trans_Type,
        SUM(Debit) AS total_spend
    FROM Opay_Transaction
    WHERE Debit > 0
    GROUP BY YEAR(Trans_Date), MONTH(Trans_Date),Trans_Type
),
monthly_total AS (
    SELECT 
        yr, mn,
        SUM(total_spend) AS month_total
    FROM monthly_spend
    GROUP BY yr, mn
)
SELECT 
    m.yr,
    m.mn,
    MAX(m.total_spend * 1.0 / t.month_total) * 100 
        AS top_category_percent
FROM monthly_spend m
JOIN monthly_total t
ON m.yr = t.yr AND m.mn = t.mn
GROUP BY m.yr, m.mn
ORDER BY m.yr, m.mn

---Percentage Of Income Transferred Out
WITH income_days AS (
    SELECT 
       Trans_Date,
        SUM(Credit) AS income_amt
    FROM Opay_Transaction
    WHERE Credit > 0
    GROUP BY Trans_Date
),
same_day_transfer AS (
    SELECT 
        i.Trans_Date,
        i.income_amt,
        SUM(o.Debit) AS transferred_amt
    FROM income_days i
    JOIN Opay_Transaction o
        ON i.Trans_Date = o.Trans_Date
        AND o.Debit > 0
    GROUP BY i.Trans_Date, i.income_amt
)
SELECT 
    AVG(transferred_amt * 1.0 / NULLIF(income_amt,0)) * 100 
        AS percent_income_transferred_same_day
FROM same_day_transfer

---Ratio Of Income To Transfers
WITH totals AS (
    SELECT
        SUM(CASE WHEN Credit > 0 THEN Credit ELSE 0 END) AS total_income,
        SUM(CASE WHEN Trans_Type = 'Transfer' AND Debit > 0 
                 THEN Debit ELSE 0 END) AS total_transfers
    FROM Opay_Transaction
)
SELECT
    total_transfers * 1.0 / NULLIF(total_income,0) * 100 
        AS percent_income_transferred
FROM totals

---Channel Dtbn
SELECT Channel, COUNT(*) AS Frequency
FROM Opay_Transaction
GROUP BY Channel