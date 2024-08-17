
# Ajouter les sorties ici

# updateSelectInput(
#   session, 
#   inputId = "health_service_area",
#   label = "Health Service Area:",
#   choices = c("All", unique(hospital$health_service_area)),
#   selected = "All"
# )

output$TotalSurgeons <- renderValueBox({
  # Calculate Total Surgeons (Assuming 'operating_provider_license_number' represents individual surgeons)
  if (input$health_service_area == "All") {
    total_surgeons <- hospital %>%
      select(operating_provider_license_number) %>%
      distinct() %>%
      nrow()
  } else {
    total_surgeons <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      select(operating_provider_license_number) %>%
      distinct() %>%
      nrow()
  }
  
  valueBox(total_surgeons, "Total Surgeons", icon = icon("users"), color = "olive")
})

output$AverageLOSDays <- renderValueBox({
  # Calculate Average Length of Stay (LOS) in Days
  if (input$health_service_area == "All") {
    average_los_days <- hospital %>%
      summarize(avg_los = mean(length_of_stay, na.rm = TRUE)) %>%
      pull(avg_los)
  } else {
    average_los_days <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      summarize(avg_los = mean(length_of_stay, na.rm = TRUE)) %>%
      pull(avg_los)
  }
  
  valueBox(round(average_los_days, 2), "Average LOS Days", icon = icon("clock"), color = "olive")
})

output$TotalHospitals <- renderValueBox({
  # Calculate Total Hospitals (Assuming 'facility_id' represents unique hospitals)
  if (input$health_service_area == "All") {
    total_hospitals <- hospital %>%
      select(facility_id) %>%
      distinct() %>%
      nrow()
  } else {
    total_hospitals <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      select(facility_id) %>%
      distinct() %>%
      nrow()
  }
  
  valueBox(total_hospitals, "Total Hospitals", icon = icon("hospital"), color = "olive")
})

output$TotalDischarges <- renderValueBox({
  # Calculate Total Discharges
  if (input$health_service_area == "All") {
    total_discharges <- nrow(hospital)
  } else {
    total_discharges <- nrow(hospital %>% filter(health_service_area == input$health_service_area))
  }
  
  valueBox(total_discharges, "Total Discharges", icon = icon("outdent"), color = "olive")
})


hospital_summary_data <- reactive({
  
  # Summarize data by hospital and order by Total Discharges in descending order
  if (input$health_service_area == "All") {
    hospital_summary <- hospital %>%
      group_by(facility_name) %>%
      summarize(
        total_discharges = n(),
        average_los_days = mean(length_of_stay, na.rm = TRUE)
      ) %>%
      arrange(desc(total_discharges)) %>%
      slice(1:15)  # Select top 15 hospitals by total discharges
    
    # Reorder facility_name factor to maintain descending order in the plot
    hospital_summary$facility_name <- factor(hospital_summary$facility_name, levels = hospital_summary$facility_name)
  } else {
    hospital_summary <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      group_by(facility_name) %>%
      summarize(
        total_discharges = n(),
        average_los_days = mean(length_of_stay, na.rm = TRUE)
      ) %>%
      arrange(desc(total_discharges)) %>%
      slice(1:15)  # Select top 15 hospitals by total discharges
    
    # Reorder facility_name factor to maintain descending order in the plot
    hospital_summary$facility_name <- factor(hospital_summary$facility_name, levels = hospital_summary$facility_name)
  }
  hospital_summary
})

output$AvgLOSdaysTotalDischPlot <- renderPlotly({

  # Create the plot
  plot_ly(hospital_summary_data(), x = ~facility_name, y = ~total_discharges, type = 'bar', name = 'Total Discharges') %>%
    add_trace(y = ~average_los_days, type = 'scatter', mode = 'lines+markers', name = 'Average LOS Days', yaxis = 'y2') %>%
    layout(
      title = "Top 15 Hospitals: Total Discharges and Average LOS Days",
      xaxis = list(title = "Hospital"),
      yaxis = list(title = "Total Discharges"),
      yaxis2 = list(
        title = "Average LOS Days",
        overlaying = "y",
        side = "right"
      ),
      legend = list(x = 0.1, y = 0.9),
      barmode = 'group'
    )
  
})

output$HighAvgLOSPlot <- renderPlotly({
  
  # Get the Top 3 Highest Avg LOS Days
  top_3_highest_los <- hospital_summary_data() %>%
    head(3)
  
  plot_ly(top_3_highest_los, 
          x = ~average_los_days, 
          y = ~reorder(facility_name, -average_los_days), 
          type = 'bar', 
          orientation = 'h', # flip the axes
          name = 'Highest Avg LOS Days') %>%
    layout(
      title = "Top 3: Hospitals with Highest Avg LOS Days",
      xaxis = list(title = "Average LOS Days"),
      yaxis = list(title = "Hospital")
    )
  
})

output$LowAvgLOSPlot <- renderPlotly({
  
  # Get the Bottom 3 Lowest Avg LOS Days
  bottom_3_lowest_los <- hospital_summary_data() %>%
    tail(3)
  
  plot_ly(bottom_3_lowest_los, 
          x = ~average_los_days, 
          y = ~reorder(facility_name, -average_los_days), 
          type = 'bar', 
          orientation = 'h', # flip the axes
          name = 'Highest Avg LOS Days') %>%
    layout(
      title = "Bottom 3: Hospitals with Lowest Avg LOS Days",
      xaxis = list(title = "Average LOS Days"),
      yaxis = list(title = "Hospital")
    )
  
})


hospital_summary_data2 <- reactive({
  
  if (input$health_service_area == "All") {
    # Calculate average LOS and average cost per discharge by facility and health service area
    hospital_summary <- hospital %>%
      group_by(facility_name, health_service_area) %>%
      summarize(
        avg_los = mean(length_of_stay),
        avg_cost = mean(total_costs)
      )
  } else {
    # Calculate average LOS and average cost per discharge by facility and health service area
    hospital_summary <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      group_by(facility_name, health_service_area) %>%
      summarize(
        avg_los = mean(length_of_stay),
        avg_cost = mean(total_costs)
      )
  }
  
  hospital_summary
  
})

output$ScatterPlot <- renderPlotly({
  
  # Create the scatter plot with coloring by health service area
  plot_ly(
    hospital_summary_data2(),
    x = ~avg_los,
    y = ~avg_cost,
    color = ~health_service_area,  # Color points by health service area
    text = ~facility_name,
    type = 'scatter',
    mode = 'markers',
    marker = list(size = 10)
  ) %>% layout(
    title = 'Average LOS vs Average Cost per Discharge by Hospital',
    xaxis = list(title = 'Average Length of Stay (Days)'),
    yaxis = list(title = 'Average Cost per Discharge ($)'),
    hovermode = 'closest'
  )
  
})

# Calculate average cost per discharge by facility
average_cost_by_facility <- reactive({
  
  if (input$health_service_area == "All") {
    rslt <- hospital %>%
      group_by(facility_name) %>%
      summarize(avg_cost = mean(total_costs)) %>%
      arrange(desc(avg_cost))
  } else {
    rslt <- hospital %>%
      filter(health_service_area == input$health_service_area) %>% 
      group_by(facility_name) %>%
      summarize(avg_cost = mean(total_costs)) %>%
      arrange(desc(avg_cost))
  }
  
  rslt
  
})


output$HighAvgCostPlot <- renderPlotly({
  
  top_3_facilities <- head(average_cost_by_facility(), 3)
  
  # Top 3: Highest Avg Cost per Discharge
  plot_ly(
    top_3_facilities,
    x = ~avg_cost,
    y = ~reorder(facility_name, avg_cost),
    type = 'bar',
    orientation = 'h',
    marker = list(color = 'red')
  ) %>% layout(
    title = 'Top 3 Facilities: Highest Avg Cost per Discharge',
    xaxis = list(title = 'Average Cost'),
    yaxis = list(title = 'Facility Name')
  )
  
})

output$LowAvgCostPlot <- renderPlotly({
  
  bottom_3_facilities <- tail(average_cost_by_facility(), 3)
  
  # Bottom 3: Lowest Avg Cost per Discharge
  plot_ly(
    bottom_3_facilities,
    x = ~avg_cost,
    y = ~reorder(facility_name, avg_cost),
    type = 'bar',
    orientation = 'h',
    marker = list(color = 'green')
  ) %>% layout(
    title = 'Bottom 3 Facilities: Lowest Avg Cost per Discharge',
    xaxis = list(title = 'Average Cost'),
    yaxis = list(title = 'Facility Name')
  )
  
})


output$hospitalProfileText <- renderUI({
  HTML('<div style="text-align: center;">
            <h2><b>Hospital Profile: Hospital for Special Surgery</b></h1>
          </div>')
})


output$SeverityPlot <- renderPlotly({
  
  generate_severity_bar_chart(hospital, input$hospital_name)
  
})

output$MortalityRiskPlot <- renderPlotly({
  
  generate_mortality_risk_bar_chart(hospital, input$hospital_name)
  
})

output$DiagnosisPlot <- renderPlotly({
  
  generate_diagnosis_donut_chart(hospital, input$hospital_name)
  
})

output$PatientDispositionPlot <- renderPlotly({
  
  generate_disposition_donut_chart(hospital, input$hospital_name)
  
})

# Step 5: Calculate the metrics for the selected hospital
hospital_metrics <- reactive({
  
  calculate_hospital_metrics(hospital, input$hospital_name)
  
})


output$AvgLOS <- renderValueBox({
  
  valueBox(
    round(hospital_metrics()$avg_los_hospital, 2), "Average LOS Days", 
    icon = icon("outdent"), color = "aqua"
  )
  
})


output$AvgLOSAll <- renderValueBox({
  
  valueBox(
    round(hospital_metrics()$avg_los_all, 2), "Average LOS Days ALL", 
    icon = icon("outdent"), color = "aqua"
  )
  
})


output$AvgCost <- renderValueBox({
  
  valueBox(
    round(hospital_metrics()$avg_cost_hospital, 2), "Average Cost per Discharge", 
    icon = icon("usd"), color = "lime"
  )
  
})


output$AvgCostAll <- renderValueBox({
  
  valueBox(
    round(hospital_metrics()$avg_cost_all, 2), "Average Cost per Discharge ALL", 
    icon = icon("usd"), color = "lime"
  )
  
})


output$ReadmissionRate <- renderValueBox({
  
  valueBox(
    paste(round(hospital_metrics()$readmission_rate_hospital, 2), "%", ""), 
    "Readmission Rate", 
    icon = icon("redo-alt"), color = "teal"
  )
  
})

output$ReadmissionRateAll <- renderValueBox({
  
  valueBox(
    paste(round(hospital_metrics()$readmission_rate_all, 2), "%", ""), 
    "Readmission Rate ALL", 
    icon = icon("redo-alt"), color = "teal"
  )
  
})


output$MortalityRate <- renderValueBox({
  
  valueBox(
    paste(round(hospital_metrics()$mortality_rate_hospital, 2), "%", ""), 
    "Mortality Rate", 
    icon = icon("heartbeat"), color = "fuchsia"
  )
  
})


output$MortalityRateAll <- renderValueBox({
  
  valueBox(
    paste(round(hospital_metrics()$mortality_rate_all, 2), "%", ""), 
          "Mortality Rate ALL", 
    icon = icon("heartbeat"), color = "fuchsia"
  )
  
})


output$TotalDisch <- renderValueBox({
  
  valueBox(
    hospital_metrics()$total_discharge_hospital, 
    "Total Discharges", 
    icon = icon("outdent"), color = "yellow"
  )
  
})


output$TotalDischAll <- renderValueBox({
  
  valueBox(
    hospital_metrics()$total_discharge_all, 
    "Total Discharges ALL", 
    icon = icon("outdent"), color = "yellow"
  )
  
})


output$TotalReadmi <- renderValueBox({
  
  valueBox(
    hospital_metrics()$total_readmission_hospital, 
    "Total Readmission", 
    icon = icon("redo-alt"), color = "maroon"
  )
  
})


output$TotalReadmiAll <- renderValueBox({
  
  valueBox(
    hospital_metrics()$total_readmission_all, 
    "Total Readmission ALL", 
    icon = icon("redo-alt"), color = "maroon"
  )
  
})