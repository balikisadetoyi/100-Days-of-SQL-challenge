
--Show the Customer_ID, Gender, Age and City of all customers who churned.

SELECT 
	Customer_ID,
	Gender,
	Age,
	city
FROM Clean_churn_analysis
WHERE Churn_Label='Yes'

--Show Customer_ID, Age and City of all customers,
--sorted from oldest to youngest.

SELECT 
	Customer_ID,
	Age,
	city
FROM Clean_churn_analysis
ORDER BY Age DESC


--Show the Customer_ID, City and Total_Revenue of the
--top 5 customers by Total_Revenue.

SELECT TOP 5
	Customer_ID,
	City,
	Total_Revenue 
FROM Clean_churn_analysis
ORDER BY Total_Revenue DESC

--Show a list of all the distinct cities customers are located in.

SELECT DISTINCT
	City
FROM Clean_churn_analysis

--How many customers are there in total? Return a single number.
SELECT
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis

--What is the total Total_Revenue across all customers? 
SELECT
	SUM(Total_Revenue) AS total_customer_rev
FROM Clean_churn_analysis

--Show the average Monthly_Charge for customers, 
--broken down by Contract type.

SELECT 
Contract,
AVG(Monthly_Charge) AS avg_monthly_charge
FROM Clean_churn_analysis
GROUP BY 
	Contract

--Show each Contract type and the number of customers in each, 
--but only include contract types that have more than 5 customers.

SELECT 
	Contract,
	COUNT(Customer_ID) AS total_customers
FROM Clean_churn_analysis
GROUP BY
	Contract
HAVING COUNT(Customer_ID) >5

--Show Customer_ID, City and Age
--for customers who are aged between 40 and 60.

SELECT 
	Customer_ID,
	City,
	Age
FROM Clean_churn_analysis
WHERE Age BETWEEN 40 AND 60

--Show Customer_ID, City and Internet_Type 
--for customers whose Internet_Type is either 'Fiber Optic' or 'Cable'.

SELECT 
	Customer_ID,
	City,
	Internet_Type
FROM Clean_churn_analysis
WHERE Internet_Type IN ('Fiber Optic','Cable')

--Show-Customer_ID and City for all customers 
--whose City starts with the letter 'S'.
SELECT 
	Customer_ID,
	City
FROM Clean_churn_analysis
WHERE City LIKE 'S%'

--Show Customer_ID, City, Age and Senior_Citizen 
--for customers who are senior citizens AND aged over 70.

SELECT 
	Customer_ID,
	City,
	Age,
	Senior_Citizen
FROM Clean_churn_analysis
WHERE 
	Senior_Citizen='Yes' AND 
	Age >70

--Show Customer_ID, City and Internet_Type for 
--customers who do NOT have Fiber Optic internet.
SELECT 
	Customer_ID,
	City,
	Internet_Type
FROM Clean_churn_analysis
WHERE Internet_Type <> 'Fiber Optic'


--Show the Customer_ID and City with the City converted to UPPERCASE
SELECT
	Customer_ID,
	UPPER(City) AS city
FROM Clean_churn_analysis

--Show Customer_ID and a new column that combines City and 
--State together with a comma and space between them

SELECT
	Customer_ID,
	CONCAT(City, ', ', State) AS city_state
FROM Clean_churn_analysis

--Show Customer_ID, City and Total_Revenue, with Total_Revenue 
--rounded to the nearest whole number.
SELECT 
	Customer_ID,
	City,
	ROUND(Total_Revenue,0) AS total_revenue
FROM Clean_churn_analysis

--Show Customer_ID, City and 
--Tenure_in_Months for the customer(s) 
--with the longest tenure. 

SELECT 
	Customer_ID,
	City,
	Tenure_in_months
FROM Clean_churn_analysis
WHERE Tenure_in_Months=(
	SELECT 
		MAX(Tenure_in_months)
	FROM Clean_churn_analysis)

---Show each Contract type along with the total number of customers and 
--the average Monthly_Charge for each, sorted by total customers from 
--highest to lowest.
SELECT 
	Contract,
	COUNT(Customer_ID) AS total_customers,
	AVG(Monthly_charge) AS avg_monthlycharge
FROM Clean_churn_analysis
GROUP BY Contract
ORDER BY total_customers DESC

--For each customer, show Customer_ID, Monthly_Charge,
--and a column that ranks customers from highest to lowest
SELECT
	Customer_ID,
	Monthly_Charge,
	DENSE_RANK() OVER(
		ORDER BY Monthly_Charge DESC) AS customer_rank
FROM Clean_churn_analysis

--For each Contract type, show the Customer_ID, 
--Monthly_Charge and Contract, plus a column ranking customers
--by Monthly_Charge WITHIN each contract type

SELECT 
	Customer_ID,
	Monthly_Charge,
	Contract,
	RANK()OVER(
		PARTITION BY Contract ORDER BY
			Monthly_Charge DESC) AS contract_rank
FROM Clean_churn_analysis