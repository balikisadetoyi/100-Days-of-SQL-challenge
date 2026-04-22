-- Return all farmer names in uppercase
SELECT 
	UPPER(name) AS farmer_name
FROM farmers

-- Return all zones in lowercase
SELECT
	LOWER(zone) AS zones
FROM farmers

--Return farmer names with spaces removed
SELECT
	TRIM(name) AS farmer_name_clean
FROM farmers

-- Remove leading spaces from farmer names
SELECT
	LTRIM(name) AS farmer_names
FROM farmers

-- Remove trailing spaces from farmer names

SELECT 
	RTRIM(name) AS farmer_name
FROM farmers

-- Show the length of each farmer name
SELECT 
	name,
	LEN(name) AS name_length
FROM farmers
-- Return the first 3 characters of each farmer name

SELECT
LEFT(name,3) AS short_name
FROM farmers

-- Return the last 3 characters of each farmer name

SELECT
RIGHT(name,3) AS name_end
FROM farmers

--Extract characters 2 to 4 from each farmer name

SELECT 
	SUBSTRING(name,2,3) AS extracted_name
FROM farmers

-- Find the position of the letter 'a' in each farmer name
SELECT
	CHARINDEX('a',name) AS a_position
FROM farmers

--Replace 'Northfield' with 'North District' in the zone column
SELECT 
	REPLACE(zone,'Northfield', 'North District') AS new_zone
FROM farmers

--Combine farmer name and zone into one column separated by a dash
SELECT
	name,
	zone,
	CONCAT(name,'-',zone) AS name_zone
FROM farmers

--Combine farmer name, zone and gender separated by a comma
SELECT
	CONCAT_WS(',',name,zone,gender) AS demographics
FROM farmers

--Return each farmer name reversed
SELECT
	name,
	REVERSE(name) AS name_reversed
FROM farmers

--Repeat the letter 'X' 5 times

SELECT
REPLICATE('X',5) AS X

-- Convert farmer age to a string
SELECT
	CAST (age AS varchar) AS age_string
FROM farmers

--Find the pattern '%a%' in farmer names
SELECT
	PATINDEX('%a%',name) AS a_index
FROM farmers