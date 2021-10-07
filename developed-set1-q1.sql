WITH Q AS (SELECT film.title AS film_title, 
		category.name AS category_name, 
		COUNT(rental.rental_id) AS  rental_count
	FROM film JOIN film_category 
		ON film.film_id = film_category.film_id
	JOIN category 
		ON film_category.category_id = category.category_id 
		AND category.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	JOIN inventory 
		ON film.film_id  = inventory.film_id
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	GROUP BY 1, 2
	ORDER BY 2, 1)
SELECT category_name, 
SUM(rental_count) AS total_count,
COUNT(film_title) AS count_film_title
FROM Q 
GROUP BY 1
ORDER BY 1;