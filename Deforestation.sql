CREATE DATABASE DEFORESTATION;

USE DEFORESTATION;


SELECT * FROM LAND_AREA;
SELECT * FROM FOREST_AREA;
SELECT * FROM REGION;

-- Question 1: What are the total number of countries involved in deforestation? 
SELECT COUNT(DISTINCT country_name) AS TOTAL_NO_OF_COUNTRIES FROM Land_Area;
/* This does nothing more than to show the total number of countries that were in the table,
in order to be able to show the countries involved in deforestation, we must see the difference between the forest area in 1990 and 2016
*/
SELECT COUNT(DISTINCT FA.COUNTRY_CODE) AS deforestation_country_count
FROM Forest_area AS FA
JOIN Land_area AS LA ON FA.COUNTRY_CODE = LA.COUNTRY_CODE
WHERE FA.forest_area_sqkm < 
  (SELECT MAX(FA_2.forest_area_sqkm) 
   FROM Forest_area AS FA_2
   WHERE FA_2.COUNTRY_CODE = FA.COUNTRY_CODE);

-- Question 2: Show the income groups of countries having total area ranging from 75,000 to 150,000 square meter?
SELECT L.country_name, income_group, total_area_sq_mi FROM Region AS R
JOIN Land_Area AS L
ON R.country_code = L.country_code
WHERE total_area_sq_mi BETWEEN 75000 AND 150000;

-- Question 3: Calculate average area in square miles for countries in the 'upper middle income region'. Compare the result with the rest of the income categories.
SELECT AVG(L.total_area_sq_mi) AS avg_total_area_sq_mi
FROM Region AS R
JOIN Land_Area AS L
ON R.country_code = L.country_code
WHERE R.income_group = 'Upper middle income';

SELECT AVG(L.total_area_sq_mi) AS avg_total_area_sq_mi
FROM Region AS R
JOIN Land_Area AS L
ON R.country_code = L.country_code
WHERE R.income_group != 'Upper middle income';

-- Question 4: Determine the total forest area in square km for countries in the 'high income' group. Compare result with the rest of the income categories.
SELECT SUM(forest_area_sqkm) AS total_forest_sqkm
FROM Region AS R
JOIN Forest_Area AS F
ON R.country_code = F.country_code
WHERE income_group = 'High income';

SELECT SUM(forest_area_sqkm) AS total_forest_sqkm
FROM Region AS R
JOIN Forest_Area AS F
ON R.country_code = F.country_code
WHERE income_group != 'High income';

-- Question 5: Show countries from each region(continent) having the highest total forest areas. 
WITH ForestArea AS 
(SELECT r.REGION, fa.COUNTRY_NAME, SUM(fa.forest_area_sqkm) AS total_forest_area,
	   ROW_NUMBER() OVER (PARTITION BY r.region ORDER BY SUM(fa.forest_area_sqkm) DESC) AS ranking
    FROM Forest_area AS fa
    JOIN REGION AS r ON fa.COUNTRY_CODE = r.COUNTRY_CODE
    GROUP BY r.region, fa.COUNTRY_NAME)
SELECT region, COUNTRY_NAME, total_forest_area
FROM ForestArea
WHERE ranking = 1;
