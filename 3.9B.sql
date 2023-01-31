explain WITH top_5_customers(CUSTOMER_ID, FIRST_NAME, LAST_NAME, CITY, COUNTRY,TOTAL_AMOUNT_PAID)
	as
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
			LIMIT 5) ,
			
    customer_count  (all_customer_count, country)
	as
		(SELECT count (distinct G.customer_id) as all_customer_count, H.country 
         FROM  customer G
			inner JOIN address B ON G.address_id = B.address_id
			INNER JOIN city C ON B.city_id = C.city_id
			INNER JOIN COUNTRY H ON C.country_id = H.country_id
		GROUP BY (H.COUNTRY))
		
	select  CUSTOMER_ID, FIRST_NAME, LAST_NAME, CITY, T.COUNTRY,TOTAL_AMOUNT_PAID, all_customer_count
	from top_5_customers T
	left join customer_count J
		ON T.COUNTRY=J.COUNTRY
		ORDER BY all_customer_count DESC
	
			