# Select data we are going to use
SELECT *
FROM world_life_expectancy
;

# Cheking minimum and maximum life expectancy over 15 years
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) as Life_Increase_15Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15Years DESC
;

# Cheking average life expectancy
SELECT year, ROUND(AVG(`Life expectancy`),2) as Year_average
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY year
ORDER BY year
;

SELECT *
FROM world_life_expectancy
;

# Comparing GDP and average life expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) as Life_Expect, ROUND(AVG(GDP),1) as GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expect > 0
AND GDP > 0
ORDER BY GDP DESC
;

# Checking if average life expectancy depends on GDP
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END),1) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END),1) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

# Checking average life expectancy between statuses 
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;

# Checking if average life expectancy depends on BMI
SELECT Country, ROUND(AVG(`Life expectancy`),1) as Life_Expect, ROUND(AVG(BMI),1) as BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expect > 0
AND BMI > 0
ORDER BY BMI DESC;

# Rolling total with life expectancy and adult mortality
SELECT Country, year, `Life expectancy`, `Adult Mortality`, SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY year) as Rolling_Total
FROM world_life_expectancy
#WHERE Country LIKE 'Norway'
;
