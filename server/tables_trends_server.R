# Ajouter les sorties ici

output$movies_rental_country_year <- renderDT({
  query = "
            SELECT genre,
              	   AVG(rating) AS avg_rating,
              	   COUNT(rating) AS n_rating,
                     COUNT(*) AS n_rentals,     
              	   COUNT(DISTINCT m.movie_id) AS n_movies 
            FROM renting AS r
            LEFT JOIN movies AS m
            ON m.movie_id = r.movie_id
            WHERE r.movie_id IN ( 
            	SELECT movie_id
            	FROM renting
            	GROUP BY movie_id
            	HAVING COUNT(rating) >= 3)
            GROUP BY genre
            ORDER BY avg_rating DESC; -- Order the table by decreasing average rating
            "
  movies_rental_country_year_df <- execute_query(query) %>% 
    mutate(avg_rating = round(avg_rating, 2))
  
  datatable(movies_rental_country_year_df, options = list(pageLength = 5))
  
})

output$top_movies_table <- renderDT({
  query = "
        SELECT 
            m.title, 
            COUNT(*) AS rent_count, 
            AVG(r.rating) AS average_rating
        FROM renting AS r
        LEFT JOIN customers AS c ON c.customer_id = r.customer_id
        LEFT JOIN movies AS m ON m.movie_id = r.movie_id
        WHERE r.rating IS NOT NULL
        GROUP BY m.title
        HAVING COUNT(*) > 1  
        ORDER BY AVG(r.rating) DESC
        LIMIT 10;
    "
  
  top_movies <- execute_query(query) %>% 
    mutate(average_rating = round(average_rating, 2))
  
  datatable(top_movies, options = list(pageLength = 5))
})

output$top_customers_table <- renderDT({
  query <- "SELECT 
                  c.customer_id,
                  c.name,
                  c.country,
                  c.gender,
                  c.date_of_birth,
                  c.date_account_start,
                  SUM(m.renting_price) AS total_spent
              FROM customers AS c
              LEFT JOIN renting AS r
              ON c.customer_id = r.customer_id
              LEFT JOIN movies AS m
              ON r.movie_id = m.movie_id
              GROUP BY c.customer_id, c.name, c.country, c.gender, c.date_of_birth, c.date_account_start
              HAVING SUM(m.renting_price) IS NOT NULL
              ORDER BY total_spent DESC
              LIMIT 10;"
  
  top_customers <- execute_query(query)
  
  datatable(top_customers, options = list(pageLength = 5, autoWidth = TRUE),
            rownames = FALSE)
})


output$top_actors_table <- renderDT({
  query = "
            SELECT 
                a.name, 
                COUNT(*) AS number_views,
                AVG(r.rating) AS avg_rating
            FROM renting AS r
            LEFT JOIN customers AS c
            ON r.customer_id = c.customer_id
            LEFT JOIN actsin AS ai
            ON r.movie_id = ai.movie_id
            LEFT JOIN actors AS a
            ON ai.actor_id = a.actor_id
            WHERE r.rating IS NOT NULL
            GROUP BY a.name
            HAVING COUNT(*) > 1  
            ORDER BY avg_rating DESC
            LIMIT 10;
    "
  
  top_actors <- execute_query(query)
  
  datatable(top_actors, options = list(pageLength = 5))
})