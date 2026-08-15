-- ============================================
-- BANK LOAN ANALYSIS
-- SQL Server Analysis
-- ============================================

-- 1. View all loan data
SELECT *
FROM bank_loan_data;


-- 2. Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data;


-- 3. MTD Loan Applications - December 2021
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;


-- 4. MTD Total Funded Amount - December 2021
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
  AND YEAR(issue_date) = 2021;


-- 5. Previous Month Total Funded Amount - November 2021
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11
  AND YEAR(issue_date) = 2021;


-- 6. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data;


-- 7. Average Interest Rate
SELECT ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate
FROM bank_loan_data;


-- 8. Average Debt-to-Income Ratio
SELECT ROUND(AVG(dti) * 100, 2) AS Average_Debt_to_Income_Ratio
FROM bank_loan_data;


-- 9. Loan Status Categories
SELECT DISTINCT loan_status
FROM bank_loan_data;


-- 10. Total Amount Received from Good Loans
SELECT SUM(total_payment) AS Good_Loan_Total_Amount_Received
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');


-- 11. Good Loan Percentage
SELECT
    ROUND(
        COUNT(CASE
            WHEN loan_status IN ('Fully Paid', 'Current')
            THEN id
        END) * 100.0 / COUNT(id),
        2
    ) AS Good_Loan_Percentage
FROM bank_loan_data;


-- 12. Monthly Loan Performance
SELECT
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH, issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY
    MONTH(issue_date),
    DATENAME(MONTH, issue_date)
ORDER BY
    MONTH(issue_date);
