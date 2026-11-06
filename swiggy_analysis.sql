-- Data cleaning: build a clean table and keep the raw table untouched
DROP TABLE IF EXISTS swiggy_clean;

CREATE TABLE swiggy_clean AS
SELECT
  name AS restaurant_name,
  city,
  cuisine,
  CASE WHEN rating GLOB '[0-9]*' THEN CAST(rating AS REAL) END AS rating,
  CASE
    WHEN rating_count LIKE '%K+%'
      THEN CAST(SUBSTR(rating_count, 1, INSTR(rating_count, 'K') - 1) AS REAL) * 1000
    WHEN rating_count GLOB '[0-9]*'
      THEN CAST(rating_count AS INTEGER)
    ELSE 0
  END AS rating_count,
  CAST(SUBSTR(cost, 3) AS INTEGER) AS cost
FROM swiggy
WHERE CAST(SUBSTR(cost, 3) AS INTEGER) > 0;

-- Q1: How many restaurants are listed per area?
SELECT city, COUNT(*) AS total_restaurants
FROM swiggy_clean
GROUP BY city
ORDER BY total_restaurants DESC
LIMIT 10;

-- Q2: What are the most popular cuisines across India?
SELECT cuisine, COUNT(*) AS count
FROM swiggy_clean
GROUP BY cuisine
ORDER BY count DESC
LIMIT 10;

-- Q3: Which restaurant chains have the most branches?
SELECT restaurant_name, COUNT(*) AS branches
FROM swiggy_clean
GROUP BY restaurant_name
ORDER BY branches DESC
LIMIT 10;

-- Q4: Top 5 areas with highest average restaurant rating
SELECT city,
       ROUND(AVG(rating), 2) AS avg_rating,
       COUNT(*) AS total_restaurants
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY city
HAVING COUNT(*) > 50
ORDER BY avg_rating DESC
LIMIT 5;


-- Q5: What is the average cost for two across areas (50+ restaurants)?
SELECT city,
       ROUND(AVG(cost), 0) AS avg_cost,
       COUNT(*) AS total_restaurants
FROM swiggy_clean
GROUP BY city
HAVING COUNT(*) >= 50
ORDER BY avg_cost DESC
LIMIT 10;

-- Q6: Which cuisines have the highest average rating?
SELECT cuisine,
       ROUND(AVG(rating), 2) AS avg_rating,
       COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY cuisine
HAVING COUNT(*) > 100
ORDER BY avg_rating DESC
LIMIT 10;

-- Q7: Restaurants with rating of 4.5 or above and 1000+ ratings
SELECT restaurant_name, city, rating, rating_count, cost
FROM swiggy_clean
WHERE rating >= 4.5
  AND rating_count >= 1000
ORDER BY rating DESC
LIMIT 20;

-- Q8: Business insight: which city has the best value for money?
-- (high rating, low cost)
SELECT city,
       ROUND(AVG(rating), 2) AS avg_rating,
       ROUND(AVG(cost), 0) AS avg_cost
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY city
HAVING COUNT(*) > 30
ORDER BY avg_rating DESC, avg_cost ASC
LIMIT 10;

-- Extra: How many distinct locations are in the data?
SELECT COUNT(DISTINCT city) FROM swiggy_clean;