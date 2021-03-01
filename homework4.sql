SELECT *
FROM actor;

SELECT * 
FROM film;

SELECT *
FROM film_actor;

-- Multi-Join Table
SELECT first_name, last_name, title, release_year
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film.film_id = film_actor.film_id
ORDER BY film.film_id;

-- Subqueries
-- Find the customer_ids of the customers that have a sum amount greater than 175
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175;

SELECT * 
FROM customer;

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

SELECT * 
FROM film
WHERE film_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

SELECT district
FROM address
WHERE district = 'Texas';


-- Question 1:
SELECT *
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE address.district IN (
	SELECT district
	FROM address
	WHERE district = 'Texas'
);

-- Using Inner Join
SELECT customer.first_name, address.district
FROM customer
INNER JOIN address ON customer.address_id=address.address_id
WHERE district = 'Texas';


-- Question 2 / All payments above 6.99 & Customers Full Name:
SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
WHERE amount > 6.99
ORDER BY amount;


-- Question 3 / Show All Customers names who have paid over $175
SELECT first_name
FROM customer
WHERE customer_id IN (
	SELECT SUM(amount)
	FROM payment
	GROUP BY amount
	HAVING COUNT(amount) > 175
)
-- Not Sure about this one!!!!


-- Question 4 / List all customers who live in Nepal
SELECT customer.first_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
)


-- Question 5 / Staff Memby Transactions
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
	SELECT COUNT(amount)
	FROM payment
	GROUP BY amount
)


-- Question 6 / Film had most actors
SELECT COUNT (actor_id), film_id
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(actor_id) DESC;


-- Question 7 / All customers who made a single payment above 6.99 *use subqueries
SELECT first_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
)

-- Question 8 / Which category is most prevalent in films
SELECT COUNT (category.category_id), category.name, film_category.category_id, film_category.film_id
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name, film_category.category_id, film_category.film_id
ORDER BY COUNT (category.category_id);

