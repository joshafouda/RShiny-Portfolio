
# Ajouter les sorties ici

newyork <- read.csv('data/new_york.csv')
sanfrancisco <- read.csv('data/san_francisco.csv')
amsterdam <- read.csv('data/amsterdam.csv')

newyork <- newyork %>%
  mutate(price = as.numeric(str_replace_all(price, ",", "")))

# Convert prices to numeric (assuming price column might have "$" or commas)
# newyork$price <- as.numeric(gsub("[,$]", "", newyork$price))
# sanfrancisco$price <- as.numeric(gsub("[,$]", "", sanfrancisco$price))
# amsterdam$price <- as.numeric(gsub("[,$]", "", amsterdam$price))

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
    icon = icon("money-bill-wave"), color = "blue"
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