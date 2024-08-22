# Deforestation Analysis with sql
![san-francisco-presidio-m](https://github.com/user-attachments/assets/01d27395-0934-43cc-827e-27e3cab2e882)

## Project Description
This project analyzes deforestation trends across various countries using SQL. The objective is to identify countries experiencing deforestation, analyze regional trends, and understand the relationship between land area and forest area over time.

## Objectives and Questions
The project aims to answer the following questions:
1. **What are the total number of countries involved in deforestation?**
2. **Show the income groups of countries having total area ranging from 75,000 to 150,000 square meter?**
3. **Calculate average area in square miles for countries in the 'upper middle income region'. Compare the result with the rest of the income categories.**
4. **Determine the total forest area in square km for countries in the 'high income' group. Compare result with the rest of the income categories.**
5. **Show countries from each region(continent) having the highest total forest areas.**

## Data Sources
The data used in this project includes:
- **Forest Area Data**: Contains information on forest area (in square kilometers) for each country across different years.
- **Land Area Data**: Provides the total land area (in square miles) for each country.
- **Regional Data**: Classifies countries into regions and income groups.

The data was provided by the institution I train with.

## Database Schema
The database consists of the following tables:
- **Forest_area**: Contains columns `COUNTRY_CODE`, `COUNTRY_NAME`, `YEAR`, and `forest_area_sqkm`.
- **Land_area**: Contains columns `COUNTRY_CODE`, `COUNTRY_NAME`, `YEAR`, and `total_area_sq_mi`.
- **Regions**: Contains columns `COUNTRY_CODE`, `COUNTRY_NAME`, `REGION`, and `INCOME_GROUP`.

![Entity Relationship Diagram](https://github.com/user-attachments/assets/263ffc8e-f227-4fff-8b42-baa6ae851670)

## SQL Queries

### 1. What are the total number of countries involved in deforestation?
```sql
SELECT COUNT(DISTINCT FA.COUNTRY_CODE) AS deforestation_country_count
FROM Forest_area AS FA
JOIN Land_area AS LA ON FA.COUNTRY_CODE = LA.COUNTRY_CODE
WHERE FA.forest_area_sqkm < 
  (SELECT MAX(FA_2.forest_area_sqkm) 
   FROM Forest_area AS FA_2
   WHERE FA_2.COUNTRY_CODE = FA.COUNTRY_CODE);

