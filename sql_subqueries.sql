
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
-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
  SELECT address_id
  FROM address
  WHERE city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (
      SELECT country_id FROM country WHERE country = 'Canada'
    )
  )
);

-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT actor_id
  FROM film_actor
  GROUP BY actor_id
  ORDER BY COUNT(film_id) DESC
  LIMIT 1
);



-- Find the films rented by the most profitable customer in the Sakila database.
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
  SELECT customer_id
  FROM payment
  GROUP BY customer_id
  ORDER BY SUM(amount) DESC
  LIMIT 1
);


-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
  SELECT AVG(total_spent)
  FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
  ) AS customer_totals
);
