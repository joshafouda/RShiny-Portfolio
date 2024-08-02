
# Ajouter les sorties ici

# Filter data based on selected neighbourhood in New York
nyc_filtered <- reactive({
  newyork %>% filter(neighbourhood == input$quartier)
})

# Render the Leaflet map for New York
output$nyc_map <- renderLeaflet({
  leaflet(data = nyc_filtered()) %>%
    addTiles() %>%
    addMarkers()
})

output$nyc_quartier_avg_price <- renderValueBox({
  valueBox(
    value = paste(round(mean(nyc_filtered()$price), 1), "$"),
    subtitle = " ", 
    icon = icon("money-bill-wave"), 
    color = "purple"
  )
})

# Render the average price plot for New York
output$nyc_price_chart <- renderPlotly({
  data <- nyc_filtered() %>% 
    group_by(room_type) %>%
    summarize(avg_price = mean(price))
  p <- ggplot(data, aes(x = room_type, y = avg_price, fill = room_type)) +
    geom_col(show.legend = FALSE) +
    ylab("Average Price ($)") +
    xlab("Room Type") +
    theme_minimal()
  ggplotly(p)
})

# Similar reactive expressions and rendering for San Francisco
san_filtered <- reactive({
  sanfrancisco %>% filter(neighbourhood == input$quartier_san)
})

output$sf_map <- renderLeaflet({
  leaflet(data = san_filtered()) %>%
    addTiles() %>%
    addMarkers()
})

output$sf_quartier_avg_price <- renderValueBox({
  valueBox(
    value = paste(round(mean(san_filtered()$price), 1), "$"),
    # value = prettyNum(mean(san_filtered()$price)),
    subtitle = " ", 
    icon = icon("money-bill-wave"), 
    color = "purple"
  )
})

output$sf_price_chart <- renderPlotly({
  data <- san_filtered() %>% 
    group_by(room_type) %>%
    summarize(avg_price = mean(price))
  p <- ggplot(data, aes(x = room_type, y = avg_price, fill = room_type)) +
    geom_col(show.legend = FALSE) +
    ylab("Average Price ($)") +
    xlab("Room Type") +
    theme_minimal()
  ggplotly(p)
})

# And for Amsterdam
ams_filtered <- reactive({
  amsterdam %>% filter(neighbourhood == input$quartier_ams)
})

output$ams_map <- renderLeaflet({
  leaflet(data = ams_filtered()) %>%
    addTiles() %>%
    addMarkers()
})

output$ams_quartier_avg_price <- renderValueBox({
  valueBox(
    value = paste(round(mean(ams_filtered()$price), 1), "$"),
    subtitle = " ", 
    icon = icon("money-bill-wave"), 
    color = "purple"
  )
})

output$ams_price_chart <- renderPlotly({
  data <- ams_filtered() %>% 
    group_by(room_type) %>%
    summarize(avg_price = mean(price))
  p <- ggplot(data, aes(x = room_type, y = avg_price, fill = room_type)) +
    geom_col(show.legend = FALSE) +
    ylab("Average Price ($)") +
    xlab("Room Type") +
    theme_minimal()
  ggplotly(p)
})