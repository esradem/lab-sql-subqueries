
SELECT 
  f.title, 
  COUNT(i.inventory_id) AS num_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT 
  title, 
  length
FROM film
WHERE length > (
  SELECT AVG(length) FROM film
);
 
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
  a.first_name,
  a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';
-- Identify all movies categorized as family films

SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
