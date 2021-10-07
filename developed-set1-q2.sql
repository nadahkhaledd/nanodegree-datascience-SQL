WITH Q AS (SELECT film.title  AS film_title, 
           film.length AS film_length,
	category.name AS category_name,
	film.rental_duration ,
	NTILE(4) OVER (PARTITION BY film.rental_duration) AS standard_quartile
FROM film JOIN film_category 
	ON film.film_id = film_category.film_id
JOIN category 
	ON film_category.category_id = category.category_id 
	AND category.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1,2,3,4
ORDER BY 3,4)

SELECT film_title, category_name,
film_length,
CASE WHEN film_length = (MAX(film_length) OVER (PARTITION BY category_name)) THEN 'yes' ELSE null END AS has_the_max_length_in_category
FROM Q 
GROUP BY 1,2,3;