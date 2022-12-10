/* 
Author: Francis Rinehart
Purpose: Mavenmovies Project
Language: SQL
Last Update: 8/15/2022 at 10:00 AM Eastern time
 */

-- Accessing maven movies database
use mavenmovies;

-- 1. Accessing staff members based on their first name, last name, email address, and store ID 

SELECT 
first_name,
last_name,
email,
store_id
FROM staff;

-- 2. Access seperated counts of inventory items based on user store 

SELECT * FROM inventory;

SELECT
store_id,
COUNT(inventory_id) AS inventory_count
FROM inventory
GROUP by store_id;

-- 3.	Count number of active customers from each stores seperately 

SELECT * FROM customer;

SELECT 
store_id,
COUNT(customer_id) AS active_customers
FROM customer
WHERE active = 1
GROUP BY
store_id;

-- 4.	Provide count of all customers email addresses store in the database.

SELECT 
COUNT(email) AS email_count
FROM customer;

-- 5.	Unique film titles based on store inventory and unique film categories

SELECT 
store_id,
COUNT(DISTINCT film_id) AS films
FROM inventory
GROUP BY
store_id;

SELECT * FROM film_category;

SELECT 
COUNT(DISTINCT name) AS category_films
FROM category;

-- 6.	Film replacement cost based on min, max, and average

SELECT
MIN(replacement_cost) AS least_expensive_film,
MAX(replacement_cost) AS most_expensive_film, 
AVG(replacement_cost) AS average_films 
FROM film;

-- 7. payment average and maximum payment based on payment process

SELECT 
AVG(amount) AS average_amount,
MAX(amount) AS Max_amount 
FROM payment;

-- 8. Customer ID values based on rentals and highest customer volume for rental

SELECT 
customer_id,
COUNT(rental_id) AS rental_count
FROM rental
GROUP BY
customer_id
ORDER BY
rental_count DESC;

-- 9. Managers name based on stores name and property address

SELECT 
staff.first_name,
staff.last_name,
address.address,
address.district,
address.city_id
FROM staff
INNER JOIN address
ON staff.address_Id = address.address_id;

-- 10. Inventory items based on stocks, film name, film rating, rental rate, and replacement cost

SELECT 
inventory.store_id,
inventory.inventory_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
FROM
inventory
INNER JOIN film
ON film.film_id = inventory.inventory_id;

-- 11. inventory items based on store ratings 

SELECT 
inventory.store_id,
inventory.inventory_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
FROM
inventory
LEFT JOIN film
ON film.film_id = inventory.inventory_id
ORDER BY
film.rating DESC;

-- 12. Number of films, average replacement cost, total replacement cost sliced by store and film category

SELECT 
COUNT(film_category.film_id) AS number_of_films,
AVG(replacement_cost) AS average_replacement_cost,
SUM(replacement_cost) AS total_replacement_cost
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id;

-- 13 Customer names, store based on customers, customer status, and full addresses

SELECT
customer.first_name,
customer.last_name,
customer.active,
address.address
FROM store
INNER JOIN customer
ON store.store_Id = customer.store_id
INNER JOIN address
ON customer.address_id = address.address_id;

/*
14 customers names, total lifetime renals, and the sum of all payments collected. Most valuable customers are
listed from highest to lowest.
*/

SELECT 
customer.first_name,
customer.last_name,
payment.rental_id,
SUM(payment.amount) AS sum_payment
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY
customer.first_name
ORDER BY 
customer.first_name;

-- 15. List of advisors and investors name based on the companies they work with

SELECT 
'advisor' AS TYPE,
first_name,
last_name,
NULL
FROM advisor

UNION

SELECT 
'investor' AS TYPE,
first_name,
last_name,
company_name
FROM investor;

-- 16. List of most-awarded actors to include multiple awards and single award

SELECT 
actor.first_name,
actor.last_name,
COUNT(actor_award.awards)
FROM actor
LEFT JOIN actor_award
ON actor.actor_id = actor_award.actor_id
GROUP BY
actor.first_name;