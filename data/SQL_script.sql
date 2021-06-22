-- Select

SELECT *
FROM Farms;

SELECT Country, A06_province, A07_district, A08_ward, A09_village
FROM Farms;

SELECT A*
FROM Farms;

SELECT *
FROM Farms
LIMIT 10;

-- Where

SELECT  Id, B16_years_liv
FROM Farms
WHERE B16_years_liv > 25
;

SELECT  Id, B17_parents_liv
FROM Farms
WHERE B17_parents_liv = 'yes'
;

SELECT  Id
FROM Farms
WHERE    B17_parents_liv = 'yes' 
     AND B18_sp_parents_liv = 'yes' 
     AND B19_grand_liv = 'yes' 
     AND B20_sp_grand_liv = 'yes' 
;

SELECT  Id
FROM Farms
WHERE (B17_parents_liv = 'yes' OR B18_sp_parents_liv = 'yes') AND B16_years_liv > 60
;

SELECT Id, B16_years_liv
FROM Farms
WHERE B16_years_liv > 50 AND B16_years_liv < 60
;

SELECT Id, B16_years_liv
FROM Farms
WHERE B16_years_liv BETWEEN 51 AND 59
;

SELECT Id, B16_years_liv
FROM Farms
WHERE B16_years_liv IN (51, 52, 53, 54, 55, 56, 57, 58, 59)
;

-- Sorting

SELECT Id, A09_village, A11_years_farm, B16_years_liv
FROM Farms
WHERE A09_village = 'God'
ORDER BY A11_years_farm
;

SELECT Id, A09_village, A11_years_farm, B16_years_liv
FROM Farms
WHERE A09_village = 'God'
ORDER BY A11_years_farm DESC
;

SELECT Id, A09_village, A11_years_farm, B16_years_liv
FROM Farms
WHERE A09_village = 'God'
ORDER BY A11_years_farm DESC , B16_years_liv ASC
;

-- Missing DATABASE

SELECT *
FROM Farms
WHERE F14_items_owned IS NULL
;

SELECT E01_water_use, E_no_group_count, E_yes_group_count
FROM Farms
;

UPDATE Farms
SET F14_items_owned = '[]'
WHERE F14_items_owned is NULL 
;

SELECT * from Farms
WHERE F14_items_owned IS NOT NULL
;

-- Creating New Columns

SELECT D02_total_plot * 2.4701
FROM Plots
;

SELECT D02_total_plot * 2.4701 AS D02_total_plot_converted
FROM Plots
;

SELECT ROUND(D02_total_plot * 2.4701, 2) as D02_total_plot_converted
FROM Plots
;

-- Dates

SELECT A01_interview_date, A04_start, A05_end
FROM Farms
;

SELECT A01_interview_date
FROM Farms
ORDER BY A01_interview_date
;

SELECT A01_interview_date, 
       date(A01_interview_date) AS converted_A01,
       A04_start,
       date(A04_start) AS coverted_A04
FROM Farms
;

SELECT A01_interview_date,
       substr(A01_interview_date,7,4) as year,
       substr(A01_interview_date,4,2) as month,
       substr(A01_interview_date,1,2) as day
FROM Farms
;

SELECT A01_interview_date,
       substr(A01_interview_date,7,4) || '-' ||
       substr(A01_interview_date,4,2) || '-' ||
       substr(A01_interview_date,1,2) as converted_date
FROM Farms
;

SELECT A01_interview_date,
       date(
       substr(A01_interview_date,7,4) || '-' ||
       substr(A01_interview_date,4,2) || '-' ||
       substr(A01_interview_date,1,2)
       ) as converted_date
FROM Farms
;

SELECT A01_interview_date,
       date(
       substr(A01_interview_date,7,4) || '-' ||
       substr(A01_interview_date,4,2) || '-' ||
       substr(A01_interview_date,1,2)
       ) as converted_date
FROM Farms
ORDER BY converted_date
;

SELECT A01_interview_date,
       substr(A01_interview_date,7,4) as year,
       substr(A01_interview_date,4,2) as month,
       substr(A01_interview_date,1,2) as day
FROM Farms
ORDER BY year, month, day
;

SELECT A01_interview_date,
       substr(A01_interview_date,7,4) as year,
       substr(A01_interview_date,4,2) as month,
       substr(A01_interview_date,1,2) as day
FROM Farms
ORDER BY year DESC, month DESC, day DESC
;

SELECT Id, country,
       CASE country
           WHEN 'Moz' THEN 'Mozambique'
           WHEN 'Taz' THEN 'Tanzania'
       ELSE 'Unknown Country'
       END AS country_fullname
FROM Farms
;

SELECT Id, A11_years_farm,
       CASE
           WHEN  A11_years_farm BETWEEN 1 AND 10 THEN '1-10'
           WHEN  A11_years_farm BETWEEN 11 AND 20 THEN '11-20'
           WHEN  A11_years_farm BETWEEN 21 AND 30 THEN '21-30'
           WHEN  A11_years_farm BETWEEN 31 AND 40 THEN '31-40'
           WHEN  A11_years_farm BETWEEN 41 AND 50 THEN '41-50'
           WHEN  A11_years_farm BETWEEN 41 AND 50 THEN '51-60'
       ELSE '> 60'       
       END AS A11_years_farm_range
FROM Farms
;

-- Aggregations

select 
       min(A11_years_farm),
       max(A11_years_farm),
       avg(A11_years_farm)
from Farms; 

select distinct A06_province
from Farms;

select distinct A09_village
from Farms;

select A08_ward,
       count(*) as How_many
from Farms
group by A08_ward;

select A06_province, 
       A07_district,
       A08_ward,
       A09_village,
       count(*) as How_many
from Farms
Group By A06_province, A07_district, A08_ward, A09_village
;

select A08_ward,
       min(A11_years_farm) as min_years,
       max(A11_years_farm) as max_years,
       count(*) as how_many_farms
from Farms
group by A08_ward
having how_many_farms > 2;

-- Creating Tables and Views

SELECT Id, 
       Country, 
       A06_province, 
       A07_district,
       A08_ward, 
       A09_village
FROM Farms;

CREATE TABLE Farms_location AS
SELECT Id, 
       Country, 
       A06_province, 
       A07_district,
       A08_ward, 
       A09_village
FROM Farms;

CREATE TABLE crops_rice AS
SELECT *
FROM Crops
WHERE D_curr_crop = 'rice'
;

CREATE VIEW Farms_location AS
SELECT Id, 
       Country, 
       A06_province, 
       A07_district,
       A08_ward, 
       A09_village
FROM Farms;

-- Joins

-- how many crops of Maize?
select * 
from Crops
where D_curr_crop = 'maize'
;

-- Which farms have more than 12 in the Household
select Id, B_no_membrs 
from Farms
where B_no_membrs > 12
;

select a.Id, a.B_no_membrs,
       b.Id, b.D_curr_crop
from Farms as a
join Crops as b
on a.Id = b.Id and a.B_no_membrs > 12 and b.D_curr_crop = 'maize'
;

select a.Id as Farms_Id, a.B_no_membrs,
       b.Id as Crops_Id, b.D_curr_crop
from Farms as a
left outer join Crops_rice as b
on a.Id = b.Id 

select a.Id as Farms_Id, a.B_no_membrs,
       b.Id , b.plot_id as plot_id, b.D02_total_plot,
       c.Id as Crops_Id, c.plot_Id as crops_plot_id, c.D_curr_crop
from Farms as a
join Plots as b
join Crops  as c
on a.Id = b.Id and ( b.Id = c.Id and b.plot_id = c.plot_id) and a.B_no_membrs > 12 and c.D_curr_crop = 'maize'
;
