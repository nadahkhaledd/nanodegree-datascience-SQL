SELECT DATE_PART('month',rental.rental_date) rental_month, 
DATE_PART('year',rental.rental_date) rental_year,
store.store_id,
COUNT(rental.*)

FROM rental JOIN staff
ON rental.staff_id = staff.staff_id

JOIN store 
ON staff.store_id = store.store_id

GROUP BY 1,2,3
ORDER BY 2,1;

