
# Ajouter les sorties ici

# Load the dataset
data <- read_csv("data/Databel - Data.csv")

# Compute KPIs
total_customers <- nrow(data)
churned_customers <- sum(data$`Churn Label` == "Yes", na.rm = TRUE)
churn_rate <- churned_customers / total_customers * 100
average_monthly_charges <- mean(data$`Monthly Charge`, na.rm = TRUE)
average_tenure <- mean(data$`Account Length (in months)`, na.rm = TRUE)

# Metrics Outputs
output$totalCustomers <- renderValueBox({
  valueBox(total_customers, "Total Customers", icon = icon("users"))
})

output$churnedCustomers <- renderValueBox({
  valueBox(churned_customers, "# of Churned Customers", icon = icon("users"))
})

output$churnRate <- renderValueBox({
  valueBox(paste(round(churn_rate, 2), "%"), "Churn Rate", icon = icon("line-chart"))
})

output$avgMonthlyCharges <- renderValueBox({
  valueBox(paste(round(average_monthly_charges, 2), "$"), "Average Monthly Charges", icon = icon("usd"))
})


output$avgTenure <- renderValueBox({
  valueBox(paste(round(average_tenure, 1), ""), "Average Tenure (months)", icon = icon("calendar"))
})

# Plot Outputs
output$plotChurnReasons <- renderPlotly({
  # Calculate the percentage of customers based on Churn Reasons
  churn_reason_counts <- data %>%
    filter(!is.na(`Churn Reason`)) %>%
    group_by(`Churn Reason`) %>%
    summarize(Count = n()) %>%
    mutate(Percentage = Count / sum(Count) * 100)
  
  # Create a Plotly pie chart
  plot <- plot_ly(churn_reason_counts, 
                  x = ~Percentage, 
                  y = ~reorder(`Churn Reason`, Percentage), 
                  type = 'bar', 
                  orientation = 'h') %>%
    layout(title = "Percentage of Total Customers by Churn Reason",
           xaxis = list(title = "Percentage of Customers"),
           yaxis = list(title = "Churn Reason"))
  
  # Show the plot
  plot
})

output$plotChurnByCategVar <- renderPlotly({
  if (input$categ_var == "Churn Category") {
    # Calculate the count of churned customers by Churn Category
    churn_category_counts <- data %>%
      filter(`Churn Label` == "Yes") %>%
      group_by(`Churn Category`) %>%
      summarize(Count = n(), .groups = 'drop') %>%
      filter(!is.na(`Churn Category`))  # Filter out any NA values
    
    # Calculate total churned customers
    total_churned_customers <- sum(churn_category_counts$Count)
    
    # Calculate churn rate by churn category
    churn_category_counts <- churn_category_counts %>%
      mutate(Churn_Rate = (Count / total_churned_customers) * 100)
    
    # Create a Plotly pie chart for churn rate by churn category
    plot <- plot_ly(churn_category_counts, 
                    labels = ~`Churn Category`, 
                    values = ~Churn_Rate, 
                    type = 'pie',
                    textinfo = 'percent',
                    insidetextorientation = 'radial') %>%
      layout(title = "Churn Rate by Churn Category",
             showlegend = TRUE)
    
    # Show the plot
    plot
  } else if (input$categ_var == "Contract Type") {
    # Calculate the churn rate by Contract Type
    contract_type_churn_rates <- data %>%
      group_by(`Contract Type`) %>%
      summarize(
        Total_Customers = n(),
        Churned_Customers = sum(`Churn Label` == "Yes", na.rm = TRUE),
        Churn_Rate = (Churned_Customers / Total_Customers) * 100,
        .groups = 'drop'  # Ensures that the grouping is dropped after summarization
      )
    
    # Create a Plotly donut chart for churn rate by contract type
    plot <- plot_ly(contract_type_churn_rates, 
                    labels = ~`Contract Type`, 
                    values = ~Churn_Rate, 
                    type = 'pie', 
                    hole = 0.4) %>%
      layout(title = "Churn Rate by Contract Type",
             showlegend = TRUE,
             annotations = list(text = ' ', 
                                x = 0.5, 
                                y = 0.5, 
                                font = list(size = 20), 
                                showarrow = FALSE))
    
    # Show the plot
    plot
  } else if (input$categ_var == "Payment Method") {
    # Calculate churn rate by payment method
    churn_by_payment <- data %>%
      group_by(`Payment Method`) %>%
      summarize(
        Total_Customers = n(),
        Churned_Customers = sum(`Churn Label` == "Yes"),
        Churn_Rate = (Churned_Customers / Total_Customers) * 100,
        .groups = 'drop'  # Clean up the grouping
      )
    
    # Create a Plotly donut chart
    plot <- plot_ly(churn_by_payment, labels = ~`Payment Method`, values = ~Churn_Rate, type = 'pie',
                    textinfo = 'percent', insidetextorientation = 'radial', hole = 0.4) %>%
      layout(title = "Churn Rate by Payment Method",
             showlegend = TRUE)
    
    # Show the plot
    plot
  } else if (input$categ_var == "Gender") {
    # Calculate the churn rate by Gender
    gender_churn_rates <- data %>%
      group_by(Gender) %>%
      summarize(
        Total_Customers = n(),
        Churned_Customers = sum(`Churn Label` == "Yes", na.rm = TRUE),
        Churn_Rate = (Churned_Customers / Total_Customers) * 100,
        .groups = 'drop'  # Ensures that the grouping is dropped after summarization
      )
    
    # Create a Plotly donut chart for churn rate by gender
    plot <- plot_ly(gender_churn_rates, 
                    labels = ~Gender, 
                    values = ~Churn_Rate, 
                    type = 'pie', 
                    hole = 0.4) %>%
      layout(title = "Churn Rate by Gender",
             showlegend = TRUE,
             annotations = list(text = ' ', 
                                x = 0.5, 
                                y = 0.5, 
                                font = list(size = 20), 
                                showarrow = FALSE))
    
    # Show the plot
    plot
  }
})

output$plotChurnRateAccountLength <- renderPlotly({
  if (input$account_length_plot_type == "Account Lenght") {
    # Calculate churn rate by account length
    churn_rate_by_length <- data %>%
      group_by(`Account Length (in months)`) %>%
      summarize(
        Total_Customers = n(),
        Churned_Customers = sum(`Churn Label` == "Yes"),
        Churn_Rate = (Churned_Customers / Total_Customers) * 100,
        .groups = 'drop'  # Clean up the grouping
      ) %>%
      arrange(`Account Length (in months)`)
    
    # Create a Plotly line plot
    plot <- plot_ly(churn_rate_by_length, x = ~`Account Length (in months)`, y = ~Churn_Rate, type = 'scatter', mode = 'lines+markers',
                    line = list(color = 'blue')) %>%
      layout(
        title = "Churn Rate by Account Length",
        xaxis = list(title = "Account Length (in months)"),
        yaxis = list(title = "Churn Rate (%)")
      )
    
    # Show the plot
    plot
  } else if (input$account_length_plot_type == "Account Lenght and Contrat Type") {
    # Calculate churn rate by account length and contract type
    churn_rate_by_length_and_type <- data %>%
      group_by(`Account Length (in months)`, `Contract Type`) %>%
      summarize(
        Total_Customers = n(),
        Churned_Customers = sum(`Churn Label` == "Yes"),
        Churn_Rate = (Churned_Customers / Total_Customers) * 100,
        .groups = 'drop'  # Clean up the grouping
      ) %>%
      arrange(`Account Length (in months)`)
    
    # Create a Plotly line plot
    plot <- plot_ly() %>%
      add_trace(
        data = churn_rate_by_length_and_type,
        x = ~`Account Length (in months)`,
        y = ~Churn_Rate,
        type = 'scatter',
        mode = 'lines+markers',
        color = ~`Contract Type`,
        line = list(width = 2),
        marker = list(size = 6),
        hoverinfo = 'text',
        text = ~paste('Churn Rate:', Churn_Rate, '%<br>Contract Type:', `Contract Type`)
      ) %>%
      layout(
        title = "Churn Rate by Account Length and Contract Type",
        xaxis = list(title = "Account Length (in months)"),
        yaxis = list(title = "Churn Rate (%)"),
        hovermode = 'closest'
      )
    
    # Show the plot
    plot
  }
})


output$mapChurnRates <- renderLeaflet({
  # Convert state codes to full state names for consistency
  state_codes_to_names <- function(code) {
    state.name[match(tolower(code), tolower(state.abb))]
  }
  
  # Calculate the churn rate by state
  churn_rate_by_state <- data %>%
    group_by(State) %>%
    summarize(Total_Customers = n(),
              Churned_Customers = sum(`Churn Label` == "Yes", na.rm = TRUE),
              Churn_Rate = Churned_Customers / Total_Customers * 100) %>%
    ungroup()
  
  # Convert state codes to names
  churn_rate_by_state$State <- state_codes_to_names(churn_rate_by_state$State)
  
  # Transform State column to lowercase
  churn_rate_by_state$State <- tolower(churn_rate_by_state$State)
  
  # Make sure there are no NA values after conversion
  churn_rate_by_state <- churn_rate_by_state %>%
    filter(!is.na(State))
  
  # Check unique state names
  unique_states <- unique(churn_rate_by_state$State)
  # print(unique_states)
  
  # Load US state boundaries as an sf object
  us_states_sf <- st_as_sf(map("state", plot = FALSE, fill = TRUE))
  
  # Set correct CRS (Coordinate Reference System)
  st_crs(us_states_sf) <- st_crs("+proj=longlat +datum=WGS84")
  
  # Ensure state names in `us_states_sf` are lowercase to match the data
  us_states_sf$ID <- tolower(us_states_sf$ID)
  
  # Merge churn data with state boundaries
  state_churn_map <- us_states_sf %>%
    left_join(churn_rate_by_state, by = c("ID" = "State"))
  
  # Check the result of the join
  # print(state_churn_map)
  
  # Create a Leaflet map
  leaflet(data = state_churn_map) %>%
    addTiles() %>%
    addPolygons(
      fillColor = ~colorBin("YlOrRd", Churn_Rate, bins = 5, na.color = "transparent")(Churn_Rate),
      weight = 1,
      opacity = 1,
      color = "white",
      dashArray = "3",
      fillOpacity = 0.7,
      highlightOptions = highlightOptions(
        weight = 5,
        color = "#666",
        dashArray = "",
        fillOpacity = 0.7,
        bringToFront = TRUE
      ),
      label = ~paste0(ID, ": ", round(Churn_Rate, 2), "%")
    ) %>%
    addLegend(pal = colorBin("YlOrRd", domain = state_churn_map$Churn_Rate, bins = 5),
              values = ~Churn_Rate,
              opacity = 0.7,
              title = "Churn Rate (%)",
              position = "bottomright")
})

output$plotDataUsage <- renderPlotly({
  # Calculate churn rate by consumption and unlimited data plan
  churn_rate_data <- data %>%
    mutate(Consumption_Group = cut(`Avg Monthly GB Download`, breaks = quantile(`Avg Monthly GB Download`, probs = 0:4/4, na.rm = TRUE), include.lowest = TRUE, labels = c("Low", "Medium", "High", "Very High"))) %>%
    group_by(Consumption_Group, `Unlimited Data Plan`) %>%
    summarize(
      Total_Customers = n(),
      Churned_Customers = sum(`Churn Label` == "Yes"),
      Churn_Rate = (Churned_Customers / Total_Customers) * 100
    ) %>%
    ungroup()
  
  # Create a Plotly bar chart
  plot <- plot_ly(data = churn_rate_data, 
                  x = ~Consumption_Group, 
                  y = ~Churn_Rate, 
                  color = ~`Unlimited Data Plan`, 
                  type = 'bar',
                  barmode = 'group') %>%
    layout(title = "Churn Rate by Data Consumption and Unlimited Data Plan",
           xaxis = list(title = "Data Consumption Group"),
           yaxis = list(title = "Churn Rate (%)"),
           barmode = 'group')
  
  # Show the plot
  plot
})

output$plotChurnAge <- renderPlotly({
  # Prepare age bins
  data <- data %>%
    mutate(Age_Bins = cut(Age, breaks = seq(0, 100, by = 10), right = FALSE, labels = paste(seq(10, 100, by = 10) - 10, "-", seq(10, 100, by = 10) - 1)))
  
  # Calculate metrics by age bins
  age_metrics <- data %>%
    group_by(Age_Bins) %>%
    summarize(
      Number_of_Customers = n(),
      Churned_Customers = sum(`Churn Label` == "Yes"),
      Churn_Rate = (Churned_Customers / Number_of_Customers) * 100
    ) %>%
    ungroup()
  
  # Create a Plotly plot
  plot <- plot_ly() %>%
    add_bars(data = age_metrics, x = ~Age_Bins, y = ~Number_of_Customers, name = "Number of Customers") %>%
    add_lines(data = age_metrics, x = ~Age_Bins, y = ~Churn_Rate, name = "Churn Rate", yaxis = "y2", line = list(color = 'red')) %>%
    layout(title = "Number of Customers and Churn Rate by Age",
           xaxis = list(title = "Age Bins"),
           yaxis = list(title = "Number of Customers"),
           yaxis2 = list(title = "Churn Rate (%)", overlaying = "y", side = "right", showgrid = FALSE),
           barmode = 'group')
  
  # Show the plot
  plot
})

output$plotChurnGroup <- renderPlotly({
  # Prepare data by grouping by the number of customers in a group
  group_metrics <- data %>%
    group_by(`Number of Customers in Group`) %>%
    summarize(
      Avg_Monthly_Charge = mean(`Monthly Charge`, na.rm = TRUE),
      Churned_Customers = sum(`Churn Label` == "Yes"),
      Total_Customers = n(),
      Churn_Rate = (Churned_Customers / Total_Customers) * 100,
      .groups = 'drop'
    )
  
  # Create a Plotly plot
  plot <- plot_ly() %>%
    add_bars(data = group_metrics, x = ~`Number of Customers in Group`, y = ~Avg_Monthly_Charge, name = "Average Monthly Charge", marker = list(color = 'blue')) %>%
    add_lines(data = group_metrics, x = ~`Number of Customers in Group`, y = ~Churn_Rate, name = "Churn Rate", yaxis = "y2", line = list(color = 'red')) %>%
    layout(
      title = "Average Monthly Charge and Churn Rate by Number of Customers in Group",
      xaxis = list(title = "Number of Customers in Group"),
      yaxis = list(title = "Average Monthly Charge"),
      yaxis2 = list(title = "Churn Rate (%)", overlaying = "y", side = "right", showgrid = FALSE),
      barmode = 'group'
    )
  
  # Show the plot
  plot
})


output$plotServiceCalls <- renderPlotly({
  # Calculate the average customer service calls by state and churn label
  avg_service_calls <- data %>%
    group_by(State, `Churn Label`) %>%
    summarize(Avg_Service_Calls = mean(`Customer Service Calls`, na.rm = TRUE))
  
  # Create a Plotly bar plot
  plot <- plot_ly(avg_service_calls, 
                  x = ~State, 
                  y = ~Avg_Service_Calls, 
                  color = ~`Churn Label`, 
                  type = 'bar',
                  barmode = 'group') %>%
    layout(title = "Average Customer Service Calls by State and Churn Label",
           xaxis = list(title = "State", tickangle = 45),
           yaxis = list(title = "Average Customer Service Calls"),
           legend = list(title = list(text = "<b> Churn Label </b>")))
  
  # Show the plot
  plot
})