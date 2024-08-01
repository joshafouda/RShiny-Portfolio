# Ajouter les sorties ici

output$movies_genre_plot <- renderPlotly({
  query <- "SELECT genre, 
                   COUNT(*) AS count
            FROM movies
            GROUP BY genre
            ORDER BY COUNT(*) DESC;"
  
  movies_genre <- execute_query(query)
  
  ggplot(movies_genre, aes(x = reorder(genre, -count), y = count, fill = genre)) +
    geom_bar(stat = "identity") + 
    coord_flip() + 
    theme_minimal() + 
    labs(title = "Movies by Genre", x = "Genre", y = "Number of Movies")
})

output$avg_rating_genre_plot <- renderPlotly({
  query <- "
              -- Niveau d'agrégation pour country et genre
              SELECT 
                  c.country, 
                  m.genre, 
                  AVG(r.rating) AS avg_rating
              FROM renting AS r
              LEFT JOIN movies AS m ON m.movie_id = r.movie_id
              LEFT JOIN customers AS c ON r.customer_id = c.customer_id
              GROUP BY c.country, m.genre
              
              UNION ALL
              
              -- Niveau d'agrégation pour country seulement
              SELECT 
                  c.country, 
                  NULL AS genre, 
                  AVG(r.rating) AS avg_rating
              FROM renting AS r
              LEFT JOIN movies AS m ON m.movie_id = r.movie_id
              LEFT JOIN customers AS c ON r.customer_id = c.customer_id
              GROUP BY c.country
              
              UNION ALL
              
              -- Niveau d'agrégation pour genre seulement
              SELECT 
                  NULL AS country, 
                  m.genre, 
                  AVG(r.rating) AS avg_rating
              FROM renting AS r
              LEFT JOIN movies AS m ON m.movie_id = r.movie_id
              LEFT JOIN customers AS c ON r.customer_id = c.customer_id
              GROUP BY m.genre
              
              UNION ALL
              
              -- Niveau d'agrégation globale (aucun groupement)
              SELECT 
                  NULL AS country, 
                  NULL AS genre, 
                  AVG(r.rating) AS avg_rating
              FROM renting AS r
              LEFT JOIN movies AS m ON m.movie_id = r.movie_id
              LEFT JOIN customers AS c ON r.customer_id = c.customer_id;

              "
  avg_rating_genre <- execute_query(query)
  
  plot_ly(avg_rating_genre, x = ~genre, y = ~country, z = ~avg_rating, type = "heatmap", 
          colors = colorRamp(c("blue", "red"))) %>%
    layout(title = "Average Rating by Country and Genre",
           xaxis = list(title = "Genre"),
           yaxis = list(title = "Country"))
})

output$movies_year_plot <- renderPlotly({
  query <- "SELECT 
              m.year_of_releas,
              AVG(r.rating) AS avg_rating,
              AVG(m.renting_price) AS avg_renting_price,
              COUNT(renting_id) AS n_rentals
          FROM renting AS r
          LEFT JOIN movies AS m 
            ON m.movie_id = r.movie_id
          GROUP BY m.year_of_releas
          ORDER BY m.year_of_releas;"
  movies_release_year <- execute_query(query)
  
  if (input$type_plot_release == "Movie Release Year Distribution") {
    ggplot(execute_query("SELECT * FROM movies;"), aes(x = year_of_releas)) +
      geom_histogram(binwidth = 1, fill = "green", color = "black") + 
      theme_minimal() + 
      labs(title = "Movie Release Year Distribution", x = "Year of Release", y = "Number of Movies")
  } else if (input$type_plot_release == "Average Rating by Year of Release") {
    ggplot(movies_release_year, aes(x = year_of_releas, y = avg_rating)) +
      geom_line() + 
      theme_minimal() + 
      labs(title = "Average Rating by Year of Release", x = "Year of Release", y = "Average Rating")
  } else if (input$type_plot_release == "Average Renting Price by Year of Release") {
    ggplot(movies_release_year, aes(x = year_of_releas, y = avg_renting_price)) +
      geom_line() + 
      theme_minimal() + 
      labs(title = "Average Renting Price by Year of Release", x = "Year of Release", y = "Average Renting Price")
  } else if (input$type_plot_release == "Number of Rentals by Year of Release") {
    ggplot(movies_release_year, aes(x = year_of_releas, y = n_rentals)) +
      geom_bar(stat = "identity") + 
      theme_minimal() + 
      labs(title = "Number of Rentals by Year of Release", x = "Year of Release", y = "Number of Rentals")
  }
  
})

output$rentals_country_year_plot <- renderPlotly({
  query = "-- Sous-requête pour les films avec au moins 4 évaluations
            WITH movies_with_min_ratings AS (
                SELECT movie_id
                FROM renting
                GROUP BY movie_id
                HAVING COUNT(rating) >= 4
            )
            
            -- Niveau d'agrégation pour country et year_of_release
            SELECT 
                c.country,
                m.year_of_releas,
                COUNT(*) AS n_rentals,
                COUNT(DISTINCT r.movie_id) AS n_movies,
                AVG(r.rating) AS avg_rating
            FROM renting AS r
            LEFT JOIN customers AS c ON c.customer_id = r.customer_id
            LEFT JOIN movies AS m ON m.movie_id = r.movie_id
            WHERE r.movie_id IN (SELECT movie_id FROM movies_with_min_ratings)
            GROUP BY c.country, m.year_of_releas
            HAVING c.country IS NOT NULL
            
            UNION ALL
            
            -- Niveau d'agrégation pour country seulement
            SELECT 
                c.country,
                NULL AS year_of_releas,
                COUNT(*) AS n_rentals,
                COUNT(DISTINCT r.movie_id) AS n_movies,
                AVG(r.rating) AS avg_rating
            FROM renting AS r
            LEFT JOIN customers AS c ON c.customer_id = r.customer_id
            LEFT JOIN movies AS m ON m.movie_id = r.movie_id
            WHERE r.movie_id IN (SELECT movie_id FROM movies_with_min_ratings)
            GROUP BY c.country
            HAVING c.country IS NOT NULL
            
            UNION ALL
            
            -- Niveau d'agrégation globale (aucun groupement par country ou year_of_release)
            SELECT 
                NULL AS country,
                NULL AS year_of_releas,
                COUNT(*) AS n_rentals,
                COUNT(DISTINCT r.movie_id) AS n_movies,
                AVG(r.rating) AS avg_rating
            FROM renting AS r
            LEFT JOIN customers AS c ON c.customer_id = r.customer_id
            LEFT JOIN movies AS m ON m.movie_id = r.movie_id
            WHERE r.movie_id IN (SELECT movie_id FROM movies_with_min_ratings)
            
            ORDER BY country, year_of_releas;
            "
  movies_rental_country_year_df <- execute_query(query) %>% 
    mutate(avg_rating = round(avg_rating, 2))
  
  plot_ly(movies_rental_country_year_df, 
          x = ~year_of_releas, 
          y = ~country, 
          z = ~n_rentals, 
          type = 'heatmap', 
          colors = colorRamp(c("white", "blue"))) %>%
    layout(title = "Heatmap of Rentals by Country and Year of Release",
           xaxis = list(title = "Year of Release"),
           yaxis = list(title = "Country"))
  
})