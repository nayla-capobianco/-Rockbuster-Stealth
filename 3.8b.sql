Select count(distinct G.customer_id) as all_customer_count, D.country, top_5_customers
from customer G
	inner join address B on G.address_id=B.address_id
	inner join city C on B.city_id=c.city_id
	inner join country D on C.country_id=D.country_id
	left join

			(SELECT 
				A.CUSTOMER_ID,
				A.FIRST_NAME, 
				A.LAST_NAME, 
				C.CITY, 
				D.COUNTRY,
				SUM(F.AMOUNT) AS TOTAL_AMOUNT_PAID
			FROM customer A
				INNER JOIN ADDRESS B ON A.ADDRESS_ID = B.ADDRESS_ID
				INNER JOIN CITY C ON B.CITY_ID = C.CITY_ID
				INNER JOIN COUNTRY D ON C.COUNTRY_ID = D.COUNTRY_ID
				INNER JOIN RENTAL E ON A.CUSTOMER_ID = E.CUSTOMER_ID
				INNER JOIN PAYMENT F ON E.RENTAL_ID = F.RENTAL_ID
				WHERE city in 
			 				('Aurora',
							'Atlixco',
							'Xintai',
							'Adoni',
							'Dhule(Dhulia)',
							'Kurashiki',
							'Pingxiang',
							'Sivas',
							'Celaya',
							'So Leopoldo')
        
				GROUP BY A.CUSTOMER_ID, A.FIRST_NAME, A.LAST_NAME, C.CITY, D.COUNTRY
				ORDER BY TOTAL_AMOUNT_PAID DESC
				LIMIT 5)
			as top_5_customers
			on D.country=top_5_customers.country
			group by (D.country, top_5_customers)
			order by (top_5_customers)