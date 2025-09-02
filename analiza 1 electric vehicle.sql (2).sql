 -- Numri total i automjeteve elektrike
SELECT COUNT(*) AS Total_Vehicles
FROM Electric_Vehicle;

-- Shpërndarja sipas qarkut
SELECT County, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY County
ORDER BY Vehicle_Count DESC;

-- Shpërndarja sipas qytetit
SELECT 
City, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY City
ORDER BY Vehicle_Count DESC
limit 10

-- Markat më të zakonshme
SELECT 
Make AS Brand, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Make
ORDER BY Vehicle_Count DESC
 limit 10
 
-- Modelet më të zakonshme
SELECT 
Model, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Model
ORDER BY Vehicle_Count DESC
 limit 10
 
/*Shpërndarja sipas viteve të modelit*/
SELECT Model_Year AS Year, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Model_Year
ORDER BY Year;



/*Shpërndarja sipas periudhave gjeografike dhe viteve*/
SELECT Model_Year AS Year, County, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Model_Year, County
ORDER BY Year, Vehicle_Count DESC;

 
select *
from Electric_Vehicle



/*Analiza e distancës së mbulimit të automjeteve*/

 SELECT 
    CASE 
        WHEN Electric_Range < 100 THEN 'Below 100 miles'
        WHEN Electric_Range BETWEEN 100 AND 200 THEN '100-200 miles'
        WHEN Electric_Range BETWEEN 200 AND 300 THEN '200-300 miles'
        ELSE 'Above 300 miles'
    END AS Range_Category,
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Electric_Range
ORDER BY Vehicle_Count DESC;



/*Automjetet më të mira sipas distancës dhe markës*/
SELECT 
 Make, Model, MAX(Electric_Range) AS Max_Range
FROM Electric_Vehicle
GROUP BY Make, Model
ORDER BY Max_Range DESC
limit 10 

/*Qytetet dhe markat më të zakonshme për lloje specifike*/
 SELECT  
 City, Make, Electric_Vehicle_Type, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY City, Make,Electric_Vehicle_Type
ORDER BY Vehicle_Count DESC
 limit 10


select *
from Electric_Vehicle


/*Identifikimi i pikave të nxehta të regjistrimeve*/
SELECT 
vehicle_Location, COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY vehicle_Location
ORDER BY Vehicle_Count DESC
limit 10



/*Analiza e distancës mesatare sipas llojit të baterise*/
SELECT 
    Electric_Vehicle_Type
    AS FuelType, 
    AVG(Electric_Range) AS Avg_Range, 
    MAX(Electric_Range) AS Max_Range, 
    MIN(Electric_Range) AS Min_Range
FROM Electric_Vehicle
GROUP BY  Electric_Vehicle_Type
ORDER BY Avg_Range DESC;

select *
from Electric_Vehicle


/* Identifikimi i markave me më shumë diversitet modelesh*/
SELECT 
    Make AS Brand, 
    COUNT(DISTINCT Model) AS Unique_Models
FROM Electric_Vehicle
GROUP BY Make
ORDER BY Unique_Models DESC
 limit 10

-- Performanca sipas vitit dhe llojit të automjetit
SELECT 
    Model_Year AS Year, 
    Electric_Vehicle_Type AS FuelType, 
    AVG(Electric_Range) AS Avg_Range, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Model_Year, Electric_Vehicle_Type 
ORDER BY Year, FuelType;


select *
from  Electric_Vehicle

/*Qytetet kryesore për automjete elektrike me performancë të lartë*/
SELECT 
    City, 
    COUNT(*) AS Vehicle_Count, 
    AVG(Electric_Range) AS Avg_Range
FROM Electric_Vehicle
WHERE Electric_Range > 200
GROUP BY City
HAVING COUNT(*) > 10
ORDER BY Avg_Range DESC
 limit 10

 /*Shpërndarja e automjeteve sipas vitit dhe llojit të karburantit në qytetet kryesore*/
 SELECT 
    Model_Year AS Year, 
    City, 
    Electric_Vehicle_Type AS FuelType, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY  Model_Year, City, Electric_Vehicle_Type 
ORDER BY Vehicle_Count DESC
 limit 15

/*Identifikimi i zonave me regjistrime të dendur gjeografike*/
SELECT 
    Vehicle_Location, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Vehicle_Location
HAVING COUNT(*) > 5
ORDER BY Vehicle_Count DESC;

-- Automjetet me efikasitet më të ulët në secilën markë
SELECT 
    Make AS Brand, 
    Model, 
     Electric_Range
FROM Electric_Vehicle
WHERE  Electric_Range = (
    SELECT MIN( Electric_Range)
    FROM Electric_Vehicle AS EV2
    WHERE EV2.Make = Electric_Vehicle.Make
)
ORDER BY Brand, Electric_Range;

/*Lidhja midis regjistrimeve dhe demografisë së zonës*/
SELECT 
    Census_Tract, 
    COUNT(*) AS Vehicle_Count, 
    AVG(Electric_Range) AS Avg_Range
FROM Electric_Vehicle
GROUP BY Census_Tract
HAVING COUNT(*) > 10
ORDER BY Vehicle_Count DESC;


/*Automjetet më të vjetra të regjistruara në baza vjetore*/
SELECT 
    Model_Year AS Year, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
WHERE Model_Year < 2015
GROUP BY Model_Year
ORDER BY Year;


/*Krahasimi i performancës midis BEV dhe PHEV*/
SELECT 
    Electric_Vehicle_Type, 
    AVG(Electric_Range) AS Avg_Range, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
WHERE Electric_Vehicle_Type IN ('Battery Electric Vehicle (BEV)', 'Plug-in Hybrid Electric Vehicle (PHEV)')
GROUP BY  Electric_Vehicle_Type
ORDER BY Avg_Range DESC;

/*Identifikimi i qarqeve me përqindjen më të lartë të automjeteve elektrike*/
SELECT 
    County, 
    COUNT(*) AS Vehicle_Count, 
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Electric_Vehicle), 2) AS Percentage
FROM Electric_Vehicle
GROUP BY County
ORDER BY Percentage DESC
 limit 10
 
/* Automjetet më të përparuara në qarqet kryesore*/
SELECT 
    County, 
    Make, 
    Model, 
    MAX(Electric_Range) AS Max_Range
FROM Electric_Vehicle
GROUP BY County, Make, Model
ORDER BY County, Max_Range DESC;

/*Evolucioni i Automjeteve Elektrike me Kalimin e Kohës*/
SELECT 
    Model_Year AS Year, 
    COUNT(*) AS Vehicle_Count, 
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Electric_Vehicle), 2) AS Percentage
FROM Electric_Vehicle
GROUP BY Model_Year
ORDER BY Year;

/*Shpërndarja e automjeteve të reja sipas llojit të karburantit*/
SELECT 
    Model_Year AS Year, 
    Electric_Vehicle_Type AS FuelType, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY Model_Year, Electric_Vehicle_Type 
ORDER BY Year, Vehicle_Count DESC;

/*Numri total i automjeteve me emetime zero*/
 SELECT 
    COUNT(*) AS Zero_Emission_Vehicles
FROM Electric_Vehicle
WHERE Emissions_grams_per_mile = 0;

/*Automjetet me emetime zero sipas markës*/
SELECT 
    Make AS Brand, 
    COUNT(*) AS Zero_Emission_Count
FROM Electric_Vehicle
WHERE Emissions_grams_per_mile  = 0
GROUP BY Make
ORDER BY Zero_Emission_Count DESC
 limit 10
 
 /*Distanca maksimale mesatare për çdo lloj */
SELECT 
    Electric_Vehicle_Type AS FuelType, 
    AVG(Electric_Range) AS Avg_Range, 
    MAX(Electric_Range) AS Max_Range, 
    MIN(Electric_Range) AS Min_Range
FROM Electric_Vehicle
GROUP BY Electric_Vehicle_Type
ORDER BY Avg_Range DESC;

/*Performanca e markave sipas rangut të automjeteve*/
SELECT 
    Make AS Brand, 
    ROUND(AVG(Electric_Range), 2) AS Avg_Range, 
    MAX(Electric_Range) AS Max_Range
FROM Electric_Vehicle
GROUP BY Make
ORDER BY Avg_Range DESC;

/*Numri i automjeteve sipas kategorive të distancës*/
SELECT 
    CASE 
        WHEN Electric_Range < 100 THEN 'Below 100 miles'
        WHEN Electric_Range BETWEEN 100 AND 200 THEN '100-200 miles'
        WHEN Electric_Range BETWEEN 200 AND 300 THEN '200-300 miles'
        ELSE 'Above 300 miles'
    END AS Model,
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY 
    CASE 
        WHEN Electric_Range < 100 THEN 'Below 100 miles'
        WHEN Electric_Range BETWEEN 100 AND 200 THEN '100-200 miles'
        WHEN Electric_Range BETWEEN 200 AND 300 THEN '200-300 miles'
        ELSE 'Above 300 miles'
    END
ORDER BY Vehicle_Count DESC;

/*Markat me automjete në kategorinë më të lartë të distancës*/
SELECT 
    Make AS Brand, 
    Model, 
    Electric_Range
FROM Electric_Vehicle
WHERE Electric_Range > 300
ORDER BY Electric_Range DESC
 limit 10
 
/* Identifikimi i rajoneve me përdorimin më të madh të modeleve specifike*/
SELECT 
    City, 
    Make, 
    Model, 
    COUNT(*) AS Vehicle_Count
FROM Electric_Vehicle
GROUP BY City, Make, Model
ORDER BY Vehicle_Count DESC
 limit 15

/*Identifikimi i modeleve që regjistrohen më shpesh në një rajon të vetëm*/
SELECT 
    Make, 
    Model, 
    COUNT(DISTINCT County) AS County_Count, 
    COUNT(*) AS Total_Count
FROM Electric_Vehicle
GROUP BY Make, Model
HAVING COUNT(DISTINCT County) = 1
ORDER BY Total_Count DESC;


select *
from Electric_Vehicle