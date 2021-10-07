
WITH sub1 AS (SELECT customer.first_name || ' ' || customer.last_name AS full_name,
                   payment.amount, payment.payment_date , customer.customer_id
              FROM customer
                   JOIN payment
                    ON customer.customer_id = payment.customer_id),

     sub2 AS (SELECT customer_id
              FROM sub1
             GROUP BY 1
             ORDER BY SUM(amount) DESC
             LIMIT 10),

	sub3 AS ( SELECT DATE_TRUNC('month', sub1.payment_date) AS pay_date,
					sub1.full_name, COUNT (*), SUM(sub1.amount),
					LEAD(SUM(sub1.amount)) OVER(PARTITION BY sub1.full_name ORDER BY DATE_TRUNC('month', sub1.payment_date)) ,
					LEAD(SUM(sub1.amount)) OVER(PARTITION BY sub1.full_name ORDER BY DATE_TRUNC('month', sub1.payment_date)) - SUM(sub1.amount)  diff
				FROM sub1 JOIN sub2
				ON sub1.customer_id = sub2.customer_id
				WHERE sub1.payment_date BETWEEN '20070101' AND '20080101'
				GROUP BY 1,2
				ORDER BY 2)
				
	SELECT * , 
			CASE WHEN sub3.diff = ( SELECT MAX(sub3.diff) 
				FROM sub3 
				ORDER BY 1 DESC 
				LIMIT 1) THEN 'MAX DIFFERENCE' END max_value_of_difference
	FROM sub3 
	ORDER BY full_name;
			