WITH sub AS (SELECT film.title AS film_title, 
		category.name AS category_name,
		film.rental_duration,
		NTILE(4) OVER (ORDER BY film.rental_duration) AS standard_quartile

		FROM film JOIN film_category  
		ON film.film_id = film_category.film_id

		JOIN category  
		ON film_category.category_id = category.category_id 
		AND category.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
		)

	SELECT category_name,
		standard_quartile,
	COUNT(*) 
	FROM sub
	GROUP BY 1,2 
	ORDER BY 1, 2;