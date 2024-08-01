# Ajouter les sorties ici

query <- "
            SELECT 
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
            ORDER BY total_spent DESC;
          "

best_customers <- execute_query(query)
best_customers$age <- as.numeric(difftime(Sys.Date(), as.Date(best_customers$date_of_birth), units = "weeks")) / 52.25

output$customer_country_plot <- renderPlotly({
  query = "SELECT country, COUNT(*) AS count
            FROM customers
            GROUP BY country
            ORDER BY count DESC;"
  
  customer_country <- execute_query(query)
  
  ggplot(customer_country, aes(x = reorder(country, -count), y = count)) +
    geom_bar(stat = "identity") + 
    coord_flip() +
    theme_minimal() + 
    labs(title = "Customers by Country", x = "Country", y = "Number of Customers") +
    theme(legend.position = "none")
})

output$customer_age_plot <- renderPlotly({
  
  if (input$type_age_plot == "Customer Age Distribution") {
    ggplot(best_customers, aes(x = age)) +
      geom_histogram(binwidth = 5, fill = "blue", color = "black") + 
      theme_minimal() + 
      labs(title = "Customer Age Distribution", x = "Age", y = "Number of Customers")
  } else if (input$type_age_plot == "Total Spending vs. Age of Customers") {
    plot_ly(
      best_customers, 
      x = ~age, 
      y = ~total_spent, 
      type = 'scatter', 
      mode = 'markers',
      marker = list(size = 10, color = 'rgba(0, 123, 255, 0.8)'),
      text = ~paste("Name:", name, "<br>Total Spent:", total_spent, "<br>Country:", country)
    ) %>%
      layout(
        title = "Total Spending vs. Age of Customers",
        xaxis = list(title = "Age"),
        yaxis = list(title = "Total Spent")
      )
  }
  
})

output$customer_gender_plot <- renderPlotly({
  
  if (input$country_selection == "All") {
    plot_ly(
      best_customers, 
      labels = ~gender, 
      values = ~total_spent, 
      type = 'pie', 
      marker = list(colors = c('rgba(0, 123, 255, 0.8)', 'rgba(220, 53, 69, 0.8)')) # Vous pouvez définir les couleurs pour chaque segment
    ) %>%
      layout(
        title = "Total Spending by Gender"
      )
  } else {
    plot_ly(
      best_customers %>% filter(country == input$country_selection),
      labels = ~gender, 
      values = ~total_spent, 
      type = 'pie', 
      marker = list(colors = c('rgba(0, 123, 255, 0.8)', 'rgba(220, 53, 69, 0.8)')) # Vous pouvez définir les couleurs pour chaque segment
    ) %>%
      layout(
        title = paste("Total Spending by Gender in", input$country_selection)
      )
  }
  
})

output$customer_account_start_year_plot <- renderPlotly({
  
  customers_by_year <- best_customers %>% 
    mutate(account_start_year = as.numeric(format(as.Date(date_account_start), "%Y"))) %>%
    group_by(account_start_year) %>%
    summarise(count = n()) 
  
  ggplot(customers_by_year, aes(x = account_start_year, y = count, fill = account_start_year)) +
    geom_bar(stat = "identity") +
    labs(title = "Customers by Account Start Year", x = "Year", y = "Number of Customers") +
    theme_minimal() +
    theme(legend.position = "none") # Supprime la légende
})