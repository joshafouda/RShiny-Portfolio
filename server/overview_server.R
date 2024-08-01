
# Ajouter les sorties ici

output$total_customers <- renderValueBox({
  valueBox(value = execute_query("SELECT COUNT(*) FROM customers") %>% pull(), 
           subtitle = "Total Customers", icon = icon("users"), color = "blue")
})

output$total_movies <- renderValueBox({
  valueBox(value = execute_query("SELECT COUNT(*) FROM movies") %>% pull(), 
           subtitle = "Total Movies", icon = icon("film"), color = "green")
})

output$total_rentals <- renderValueBox({
  valueBox(value = execute_query("SELECT COUNT(*) FROM renting") %>% pull(), 
           subtitle = "Total Rentals", icon = icon("shopping-cart"), color = "purple")
})

output$revenue_by_time_plot <- renderPlotly({
  aggregate_type <- input$time_aggregate
  query <- switch(aggregate_type,
                  "day" = "SELECT DATE(date_renting) as period, SUM(renting_price) as revenue
                            FROM renting as r
                            LEFT JOIN movies as m
                            ON r.movie_id = m.movie_id
                            GROUP BY DATE(date_renting)
                            ORDER BY DATE(date_renting);
                            ",
                  "month" = "SELECT strftime('%Y-%m', date_renting) as period, SUM(renting_price) as revenue
                              FROM renting as r
                              LEFT JOIN movies as m
                              ON r.movie_id = m.movie_id
                              GROUP BY strftime('%Y-%m', date_renting)
                              ORDER BY strftime('%Y-%m', date_renting);
                              ",
                  "year" = "SELECT strftime('%Y', date_renting) as period, SUM(renting_price) as revenue
                            FROM renting as r
                            LEFT JOIN movies as m
                            ON r.movie_id = m.movie_id
                            GROUP BY strftime('%Y', date_renting)
                            ORDER BY strftime('%Y', date_renting);"
  )
  
  revenue_by_time <- execute_query(query)
  
  if (aggregate_type == "year") {
    ggplot(revenue_by_time, aes(x = period, y = revenue, fill = period)) +
      geom_bar(stat = "identity") +
      labs(title = "Revenue by Year", x = "Year", y = "Revenue") +
      theme_minimal() +
      theme(legend.position = "none") # Supprime la légende
  } else {
    plot_ly(revenue_by_time, x = ~period, y = ~revenue, type = 'scatter', mode = 'lines') %>%
      layout(title = paste("Revenue by", aggregate_type), 
             xaxis = list(title = "Date"), 
             yaxis = list(title = "Revenue"))
  }
  
})

output$revenue_ratings_country_plot <- renderPlotly({
  query <- "
            SELECT 
            	c.country,                      
            	COUNT(*) AS number_renting,   
            	AVG(r.rating) AS average_rating,  
            	SUM(m.renting_price) AS revenue  
            FROM renting AS r
            LEFT JOIN customers AS c
            ON c.customer_id = r.customer_id
            LEFT JOIN movies AS m
            ON m.movie_id = r.movie_id
            GROUP BY c.country
            ORDER BY revenue DESC;
            "
  revenue_ratings_country <- execute_query(query) %>% 
    mutate(average_rating = round(average_rating, 2))
  plot_ly(revenue_ratings_country, labels = ~country, values = ~revenue, type = 'pie', textinfo = 'label+percent',
          hoverinfo = 'text', text = ~paste("Revenue:", revenue, "<br>Avg Rating:", average_rating)) %>%
    layout(title = "Revenue & Average Rating Distribution by Country")
})


output$average_monthly_revenue_plot <- renderPlotly({
  query <- "SELECT month, AVG(monthly_revenue) AS average_revenue
            FROM (
                SELECT strftime('%Y', date_renting) AS year, 
                       strftime('%m', date_renting) AS month, 
                       SUM(renting_price) AS monthly_revenue
                FROM renting AS r
                LEFT JOIN movies AS m
                ON r.movie_id = m.movie_id
                GROUP BY strftime('%Y', date_renting), strftime('%m', date_renting)
            ) AS monthly_revenue_data
            GROUP BY month
            ORDER BY month;
            "
  
  average_monthly_revenue <- execute_query(query) 
  
  ggplot(
    average_monthly_revenue, 
    aes(x = factor(as.integer(month), levels = 1:12, labels = month.name), y = average_revenue, fill = month)
  ) +
    geom_bar(stat = "identity") +
    labs(title = "Average Monthly Revenue", x = "Month", y = "Average Revenue") +
    theme_minimal() +
    theme(legend.position = "none") # Supprime la légende
  
})


output$ratings_distribution_plot <- renderPlotly({
  ggplot(execute_query("SELECT * FROM renting;"), aes(x = rating)) +
    geom_histogram(binwidth = 1, fill = "purple", color = "black") + 
    theme_minimal() + 
    labs(title = "Ratings Distribution", x = "Rating", y = "Number of Ratings")
})