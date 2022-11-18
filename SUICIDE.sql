--CHECKING THE SIZE OF DATASET
SELECT 
	COUNT(*) AS TOTAL_NUMBER_OF_RECORDS
FROM 
	Suicides;

--CHECKING FOR NULL VALUES
SELECT
	count(*) AS TOTAL_NULL_VALUES
FROM
	Suicides
WHERE 
	STATE IS NULL or YEAR IS NULL OR Type_code IS NULL OR Type IS NULL 
	OR Gender IS NULL OR Age_group IS NULL OR Total IS NULL;

--CHECKING THE TOTAL NUMBER OF SUICIDES STATE-WISE
SELECT 
	STATE,COUNT(STATE) AS TOTAL_COUNT
FROM
	Suicides 
	GROUP BY State
	ORDER BY COUNT(STATE) DESC;

--WE ARE ABLE TO SEE THAT THERE ARE CERTAIN VALUES SUCH AS Total(All India),Total(States),Total(Uts)
--THESE VALUES CAN BE REMOVED FROMT THE DATASET BEFORE FURTHER ANALYSIS.

SELECT 
	*
FROM
	Suicides 
	WHERE State LIKE 'Total%';

DELETE FROM 
	Suicides 
	WHERE State LIKE 'Total%';

--NOW WE DON'T HAVE THAT VALUES
--CHECKING THE TOTAL NUMBER OF SUICIDES TYPE_CODE-WISE

SELECT
	Type_code,COUNT(Type_code) AS TOTAL_NUMBER_OF_SUICIDES
FROM 
	Suicides
	GROUP BY Type_code
	ORDER BY COUNT(Type_code) DESC;

--Total number of people who has committed suicide from 2001-2012
SELECT 
	YEAR,SUM(CAST(Total AS int)) as total 
FROM 
	Suicides
	where Type_code='Causes'
	GROUP BY YEAR
	ORDER BY YEAR ASC;

--CHECKING TOP 5 STATES WHERE SUICIDES ARE MORE:
SELECT
	TOP (5) State,
	SUM(CAST(Total as int)) as Total_Deaths 
FROM 
	Suicides 
	GROUP BY State 
	ORDER BY Total_Deaths DESC;

--WHICH YEAR MORE SUICIDES HAPPENED
Select 
	Year,
	SUM(cast (Total as int))As Suicides,
	DENSE_RANK() over(order by SUM(cast (Total as int)) Desc ) AS Ranks
From 
	Suicides 
	Where Type_code='Causes' group by Year;

--IN 2007, CHECKING THE TENDS ACCORDING TO AGE GROUP
Select 
	Age_group,
	SUM(CAST (Total as int))As Suicides,
	DENSE_RANK() over(order by SUM(cast (Total as int)) Desc ) AS Ranks
From 
	Suicides 
	Where Type_code='Causes' and  Year='2007'group by Age_group;

--FINDING MAJOR CAUSE OF SUICIDE HAPPENED
Select 
	TOP(10) Type, 
	SUM(cast (Total as int)) As Suicides,
	DENSE_RANK() over(order by SUM(cast (Total as int)) Desc ) AS Ranks
From 
	Suicides 
	Where Type_code='Causes' group by Type;

--FINDING TOTAL NUMBER OF SUICIDES AS PER MARITAL STATUS: 
Select 
	Type,
	SUM(CAST (Total as int)) As Suicides,
	DENSE_RANK() over(order by SUM(cast (Total as int)) Desc ) AS Ranks
From 
	Suicides 
	Where Type_code='Social_status' group by Type;

--FINDING TOTAL NUMBER OF SUICIDES AS PER EDUCATION STATUS:
Select 
	TOP(10) Type, 
	SUM(CAST (Total as int))As Suicides,
	DENSE_RANK() over(order by SUM(cast (Total as int)) Desc ) AS Ranks
From 
	Suicides 
	Where Type_code='Education_Status' group by Type;

--FINDING TOTAL NUMBER OF SUICIDES AS PER AGE GROUP:
SELECT
	Age_group,
	SUM(CAST(Total as int)) as Total_Deaths 
FROM
	Suicides 
	GROUP BY Age_group 
	ORDER BY Total_Deaths DESC; 

--FINDING WHICH TYPE CODE IS MORE DANGEROUS FOR FEMALE
SELECT
	Type_code,
	SUM(CAST(Total as int)) as Total_Deaths
FROM
	Suicides
	where Gender='Female' 
	GROUP BY Type_code 
	ORDER BY Total_Deaths DESC;

--FINDING AGE GROUP GENERALLY HANG THEMSELVES
SELECT
	Age_group,
	SUM(CAST(Total as int)) as Total_Deaths 
FROM 
	Suicides 
	WHERE Type like '%Hanging%' 
	GROUP BY Age_group
	ORDER BY Total_Deaths DESC;

--FINDING TOP 3 REASON FOR FEMALE TO COMMIT SUICIDE
SELECT
	TOP(3) Type,
	SUM(CAST(Total as int)) as Total_Deaths
FROM 
	Suicides
	WHERE gender='Female' 
	GROUP BY Type 
	ORDER BY Total_Deaths DESC;

--CREATING FUNCTION TO GET AGE WISE SUICIDE TEND FOR PARTICULAR YEAR
CREATE FUNCTION Total_Suicides (
    @Year VARCHAR(4)
)
RETURNS TABLE AS
RETURN
SELECT 
	TOP(5) Age_group,
	SUM(CAST(Total as int)) AS Total_Suicides
FROM 
	Suicides
	WHERE YEAR = @year
	GROUP BY Age_group
	ORDER BY Total_Suicides desc;

SELECT * FROM Total_Suicides(2006)









	












