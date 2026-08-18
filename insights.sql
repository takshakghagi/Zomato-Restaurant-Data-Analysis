CREATE DATABASE zomato_db;

USE zomato_db;
SELECT * FROM zomato LIMIT 10;
SELECT COUNT(*) FROM zomato;

#1. top 10 locations with the highest average restaurant rating. Also display the total number of restaurants in each location.
SELECT location, ROUND(AVG(rate), 2) AS avg_rating, COUNT(*) AS total_restaurants
FROM zomato
GROUP BY location
ORDER BY avg_rating DESC
LIMIT 10;

#2.top 10 most popular cuisines based on the number of restaurants offering each cuisine.
SELECT cuisines, COUNT(*) AS restaurant_count
FROM zomato
GROUP BY cuisines
ORDER BY restaurant_count DESC
LIMIT 10;

#3. Compare restaurants that accept online orders vs. those that don't. Find the average rating and total number of restaurants for each category.
SELECT online_order, ROUND(AVG(rate), 2) AS avg_rating, COUNT(*) AS cnt
FROM zomato
GROUP BY online_order;

#4.Categorize restaurants into Budget, Mid-range, and Premium based on approximate cost for two people. Find the average rating and total restaurants in each segment.
SELECT
    CASE
        WHEN `approx_cost(for two people)` < 300 THEN 'Budget'
        WHEN `approx_cost(for two people)` BETWEEN 300 AND 700 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_segment,
    ROUND(AVG(rate), 2) AS avg_rating,
    COUNT(*) AS total
FROM zomato
GROUP BY price_segment;

SELECT VERSION();
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Takshakghagi123';
FLUSH PRIVILEGES;

#5. Analyze the relationship between restaurant type (rest_type) and rating. Find the average rating and number of restaurants for each restaurant type. Display the top 10 by restaurant count.
SELECT rest_type, ROUND(AVG(rate), 2) AS avg_rating, COUNT(*) AS total
FROM zomato
GROUP BY rest_type
ORDER BY total DESC
LIMIT 10;

#6. Compare restaurants based on table booking availability. Find the average rating and total number of restaurants for restaurants that offer and don't offer table booking.
SELECT book_table, ROUND(AVG(rate), 2) AS avg_rating, COUNT(*) AS cnt
FROM zomato
GROUP BY book_table;

#7. Find the top 10 restaurants with the highest number of votes. Display restaurant name, location, votes, and rating.
SELECT name, location, votes, rate
FROM zomato
ORDER BY votes DESC
LIMIT 10;

#8. Find restaurants that have more than 1,000 votes but a rating below 3.5. Display the top 10 based on votes
SELECT name, location, votes, rate
FROM zomato
WHERE votes > 1000 AND rate < 3.5
ORDER BY votes DESC
LIMIT 10;

/*9. Categorize restaurants based on their availability of online ordering and table booking into:
Both
Online Order Only
Table Booking Only
Neither
Then find the average rating and total restaurants in each category.*/
SELECT 
    CASE
        WHEN online_order = 'Yes' AND book_table = 'Yes' THEN 'Both'
        WHEN online_order = 'Yes' AND book_table = 'No' THEN 'Online Order Only'
        WHEN online_order = 'No' AND book_table = 'Yes' THEN 'Table Booking Only'
        ELSE 'Neither'
    END AS service_type,
    ROUND(AVG(rate), 2) AS avg_rating,
    COUNT(*) AS total
FROM zomato
GROUP BY service_type
ORDER BY avg_rating DESC;

#10. top 10 locations having at least 100 restaurants, and calculate their average rating. Sort them by average rating in descending order.
SELECT location, ROUND(AVG(rate), 2) AS avg_rating, COUNT(*) AS total
FROM zomato
GROUP BY location
HAVING COUNT(*) >= 100
ORDER BY avg_rating DESC
LIMIT 10;

