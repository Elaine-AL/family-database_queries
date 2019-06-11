-- what was the contribution of those with degree certificate?
SELECT F.educationStatus, SUM(C.amount)
	FROM family F 
    LEFT JOIN contribution C 
    ON F.id = C.idFam
    WHERE educationStatus LIKE "%degree%"
    GROUP BY F.educationStatus; 
    
-- what is the age of the family members today?
SELECT *, YEAR(curdate()) - YEAR(dateofBirth) AS CurAge
	FROM family;

-- what is the average of there ages now? 
-- 1. in one query?
SELECT AVG(YEAR(curdate()) - YEAR(dateofBirth)) 
	AS Average
    FROM family;
    
-- 2. Using a subquery?
SELECT (SELECT AVG(YEAR(curdate()) - YEAR(dateofBirth)))
	AS AverAge
    FROM family;
    
-- 2. CTE?
WITH Average_age (dateofBirth, CurrentD, AgeNow)
	AS
    (SELECT dateofBirth, curdate(), YEAR(curdate()) - YEAR(dateofBirth)
    FROM family)
    SELECT AVG(AgeNow) FROM Average_age;
    
-- 3. using temporary tables?
CREATE TEMPORARY TABLE Averageage 
	(dateofBirth DATETIME, CurrentDay DATETIME, Age_now INT);
INSERT INTO Averageage
	curdate() AS CurrentDay
    SELECT dateofBirth AS dateofBirth, YEAR(curdate()) - YEAR(dateofBirth) AS Age_now 
    FROM family);
 
 -- find the average, minimum and maximum age for each education status
SELECT educationStatus,
	AVG(YEAR(curdate()) - YEAR(dateofBirth)) AS AVG,
    MIN(YEAR(curdate()) - YEAR(dateofBirth)) AS MIN,
    MAX(YEAR(curdate()) - YEAR(dateofBirth)) AS MAX
    FROM family
    GROUP BY educationStatus;

-- who contributed the most from the family?
SELECT F.id, F.firstName, F.educationStatus, C.amount, YEAR(curdate()) - YEAR(dateofBirth) AS Age
	FROM family F
    LEFT JOIN contribution C 
    ON F.id = C.idFam
    ORDER BY C.amount DESC
    LIMIT 1;
    
-- How many contributers are not from the family and what was their contribution?
SELECT COUNT(C.idcontribution), SUM(C.amount) 
	FROM contribution C 
    LEFT JOIN family F 
    ON C.idFam = F.id
	WHERE C.idFam IS NULL ;

-- create a column that shows whether an individual requires an id or not depending on their level of education
SELECT *,
	CASE 
		WHEN schools.level LIKE '%primary%' THEN "YES"
        ELSE "NO"
	END AS requireID
    FROM schools;
    
WITH Average_age (dateofBirth, CurrentD, AgeNow)
	AS
    (SELECT dateofBirth, curdate(), YEAR(curdate()) - YEAR(dateofBirth)
    FROM family) 
    SELECT *,
		CASE 
			WHEN AgeNow < 20 THEN "under age"
            WHEN AgeNow BETWEEN 20 AND 30 THEN "mid age"
            ELSE "grown up"
		END AS age_category
        FROM Average_age;
    
