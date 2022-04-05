-- 1. How many rows are in the names table?
SELECT COUNT(*)
FROM names;
-- 1,957,046 rows


-- 2. How many total registered people appear in the dataset?
SELECT SUM(num_registered)
FROM names;
-- 351,653,025 total registrations


-- 3. Which name had the most appearances in a single year in the dataset?
SELECT *
FROM names
ORDER BY num_registered DESC
LIMIT 1;
-- Linda (99,689 registrations in 1947)


-- 4. What range of years are included?
SELECT MIN(year), MAX(year)
FROM names;
-- 1880 - 2018


-- 5. What year has the largest number of registrations?
SELECT year, SUM(num_registered) AS total_registered
FROM names
GROUP BY year
ORDER BY total_registered DESC
LIMIT 1;
-- 1957 (4,200,022 registrations)


-- 6. How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT name)
FROM names;
-- 98,400 different names


-- 7. Are there more males or more females registered?
SELECT gender, SUM(num_registered) AS total_registered
FROM names
GROUP BY gender
ORDER BY total_registered DESC;
-- Males (177,573,793 vs. 174,079,232 registrations)


-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT name, gender, SUM(num_registered) AS total_registered
FROM names
GROUP BY gender, name
ORDER BY total_registered DESC;
-- James (5,164,280 registrations), Mary (4,125,675 registrations)


-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT name, gender, SUM(num_registered) AS total_registered
FROM names
WHERE year BETWEEN 2000 and 2009
GROUP BY name, gender
ORDER BY total_registered DESC;
-- Jacob (273,844 registrations), Emily (223,690 registrations)


-- 10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT year, COUNT(DISTINCT name) as distinct_names
FROM names
GROUP BY year
ORDER BY distinct_names DESC;
-- 2008 (32,518 distinct names)


-- 11. What is the most popular name for a girl that starts with the letter X?
SELECT name, SUM(num_registered) AS total_registered
FROM names
WHERE gender = 'F' and name LIKE 'X%'
GROUP BY name
ORDER BY total_registered DESC;
-- Ximena (26,145 registrations)


-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?
SELECT COUNT(DISTINCT name)
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE '_u%';
-- 46 distinct names starting with a 'Q' but not 'Qu'.


-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered)
FROM names
WHERE name = 'Stephen' OR name = 'Steven'
GROUP BY name;
-- Steven (1,286,951 vs. 860,972 registrations)


-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?
SELECT ROUND(SUM(unisex) * 100.0 / COUNT(*), 2)
FROM (
	SELECT CASE 
		WHEN COUNT(DISTINCT gender) > 1 THEN 1 
	END AS unisex
	FROM names
	GROUP BY name) AS unisex_names;
-- 10.95% of names are unisex.


-- 15. How many names have made an appearance in every single year since 1880?
SELECT COUNT(*)
FROM (
	SELECT name, COUNT(DISTINCT year)
	FROM names
	GROUP BY name
	HAVING COUNT(DISTINCT year) = 139) AS names_appearance_in_every_year;
-- 921 names have made an appearance in every single year since 1880.


-- 16. How many names have only appeared in one year?
SELECT COUNT(*)
FROM (
	SELECT name, COUNT(DISTINCT year) AS distinct_years
	FROM names 
	GROUP BY name ) AS names_distinct_years
WHERE distinct_years = 1;
-- 21,123 names only appeared in one year.


-- 17. How many names only appeared in the 1950s?
SELECT COUNT(*)
FROM (
	SELECT name
	FROM names
	GROUP BY name
	HAVING MIN(year) >= 1950 
	AND MAX(year) <= 1959 ) AS names_only_appearance_in_1950s;
-- 661 names only appeared in the 1950s.


-- 18. How many names made their first appearance in the 2010s?
SELECT COUNT(*)
FROM (
	SELECT name, MIN(year)
	FROM names
	GROUP BY name
	HAVING MIN(year) >= 2010 ) AS names_first_appearance_in_2010s;
-- 11,270 names made their first appearance in the 2010s.


-- 19. Find the names that have not be used in the longest.
SELECT name, MAX(year) AS most_recent_year
FROM names
GROUP BY name
ORDER BY most_recent_year
LIMIT 10;
-- Roll and Zilpah have not been used since 1881.


-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.