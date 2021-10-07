
WITH sub1 AS (SELECT customer.first_name || ' ' || customer.last_name AS fullname,
                   payment.amount, payment.payment_date , customer.customer_id
              FROM customer
                   JOIN payment
                    ON customer.customer_id = payment.customer_id),

     sub2 AS (SELECT customer_id
              FROM sub1
             GROUP BY 1
             ORDER BY SUM(amount) DESC
             LIMIT 10)

SELECT DATE_TRUNC('month', sub1.payment_date) AS pay_mon,
		sub1.fullname, COUNT (*) AS pay_countpermon, 
		SUM(sub1.amount) AS pay_amount
  FROM sub1 JOIN sub2
        ON sub1.customer_id = sub2.customer_id
 WHERE sub1.payment_date BETWEEN '20070101' AND '20080101'
 GROUP BY 1,2
 ORDER BY 2;