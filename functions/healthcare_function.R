
# Ajouter les fonctions spécifiques à l'application ici

hospital <- read_csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# a function to generate the bar chart for a specific hospital
generate_severity_bar_chart <- function(data, hospital_name) {
  
  # Filter the data for the selected hospital
  hospital_data <- data %>% filter(facility_name == hospital_name)
  
  # Calculate the total discharges by severity of illness
  severity_summary <- hospital_data %>%
    group_by(apr_severity_of_illness_description) %>%
    summarize(total_discharges = n()) %>%
    arrange(desc(total_discharges))
  
  # Create the bar chart
  severity_bar_chart <- plot_ly(
    severity_summary,
    x = ~reorder(apr_severity_of_illness_description, -total_discharges),  # Order the bars
    y = ~total_discharges,
    type = 'bar',
    marker = list(color = 'blue')
  ) %>% layout(
    title = 'Total Discharges by Severity of Illness',
    xaxis = list(title = 'Severity of Illness'),
    yaxis = list(title = 'Total Discharges'),
    barmode = 'group'
  )
  
  # Return the plot
  return(severity_bar_chart)
}



generate_mortality_risk_bar_chart <- function(data, hospital_name) {
  
  # Filter the data for the selected hospital
  hospital_data <- data %>% filter(facility_name == hospital_name)
  
  # Calculate the total discharges by risk of mortality
  mortality_risk_summary <- hospital_data %>%
    group_by(apr_risk_of_mortality) %>%
    summarize(total_discharges = n()) %>%
    arrange(desc(total_discharges))
  
  # Create the bar chart
  mortality_risk_bar_chart <- plot_ly(
    mortality_risk_summary,
    x = ~reorder(apr_risk_of_mortality, -total_discharges),  # Order the bars
    y = ~total_discharges,
    type = 'bar',
    marker = list(color = 'purple')
  ) %>% layout(
    title = 'Total Discharges by Risk of Mortality',
    xaxis = list(title = 'Risk of Mortality'),
    yaxis = list(title = 'Total Discharges'),
    barmode = 'group'
  )
  
  # Return the plot
  return(mortality_risk_bar_chart)
}


# a function to generate the donut chart for a specific hospital
generate_diagnosis_donut_chart <- function(data, hospital_name) {
  
  # Filter the data for the selected hospital
  hospital_data <- data %>% filter(facility_name == hospital_name)
  
  # Calculate the total discharges by ccs_diagnosis_description
  diagnosis_summary <- hospital_data %>%
    group_by(ccs_diagnosis_description) %>%
    summarize(total_discharges = n()) %>%
    arrange(desc(total_discharges))
  
  # Create the donut chart
  diagnosis_donut_chart <- plot_ly(
    diagnosis_summary,
    labels = ~ccs_diagnosis_description,
    values = ~total_discharges,
    type = 'pie',
    hole = 0.4  # Create the donut effect
  ) %>% layout(
    title = 'Total Discharges by Diagnosis',
    showlegend = FALSE,
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
  
  # Return the plot
  return(diagnosis_donut_chart)
}


# Define a function to generate the donut chart for a specific hospital
generate_disposition_donut_chart <- function(data, hospital_name) {
  
  # Filter the data for the selected hospital
  hospital_data <- data %>% filter(facility_name == hospital_name)
  
  # Calculate the total discharges by patient_disposition
  disposition_summary <- hospital_data %>%
    group_by(patient_disposition) %>%
    summarize(total_discharges = n()) %>%
    arrange(desc(total_discharges))
  
  # Create the donut chart
  disposition_donut_chart <- plot_ly(
    disposition_summary,
    labels = ~patient_disposition,
    values = ~total_discharges,
    type = 'pie',
    hole = 0.4  # Create the donut effect
  ) %>% layout(
    title = 'Total Discharges by Patient Disposition',
    showlegend = FALSE,
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
  
  # Return the plot
  return(disposition_donut_chart)
}


# Define a function to calculate the required metrics for a specific hospital
calculate_hospital_metrics <- function(data, hospital_name) {
  
  # Filter the data for the selected hospital
  hospital_data <- data %>% filter(facility_name == hospital_name)
  
  # Calculate metrics for the selected hospital
  avg_los_hospital <- hospital_data %>%
    summarize(avg_los_days = mean(length_of_stay, na.rm = TRUE)) %>%
    pull(avg_los_days)
  
  avg_cost_hospital <- hospital_data %>%
    summarize(avg_cost_per_discharge = mean(total_costs, na.rm = TRUE)) %>%
    pull(avg_cost_per_discharge)
  
  # Calculate metrics across all hospitals
  avg_los_all <- data %>%
    summarize(avg_los_days_all = mean(length_of_stay, na.rm = TRUE)) %>%
    pull(avg_los_days_all)
  
  avg_cost_all <- data %>%
    summarize(avg_cost_per_discharge_all = mean(total_costs, na.rm = TRUE)) %>%
    pull(avg_cost_per_discharge_all)
  
  # Calculate mortality rate by hospital
  mortality_rates <- data %>%
    group_by(facility_name) %>%
    summarize(
      total_discharges = n(),
      total_expired = sum(patient_disposition == "Expired"),
      mortality_rate = (total_expired / total_discharges) * 100
    ) %>%
    arrange(desc(mortality_rate))
  
  mortality_rate_hospital <- mortality_rates %>% 
    filter(facility_name == hospital_name) %>% 
    pull(mortality_rate)
  
  mortality_rate_all <- mean(mortality_rates$mortality_rate, na.rm = TRUE)
  
  total_discharge_hospital <- mortality_rates %>% 
    filter(facility_name == hospital_name) %>% 
    pull(total_discharges)
  
  total_discharge_all <- sum(mortality_rates$total_discharges, na.rm = TRUE)
  
  set.seed(123)
  data$patient_id <- sample(1:1000, nrow(data), replace = TRUE)
  
  # Step 4a: Identify patients with multiple discharges (readmissions)
  readmission_data <- data %>%
    group_by(patient_id, facility_name) %>%
    mutate(readmission = ifelse(n() > 1, 1, 0)) %>%
    ungroup()
  
  # Step 4b: Calculate readmission rate by hospital
  readmission_rates <- readmission_data %>%
    group_by(facility_name) %>%
    summarize(
      total_discharges = n(),
      total_readmissions = sum(readmission),
      readmission_rate = (total_readmissions / total_discharges) * 100
    ) %>%
    arrange(desc(readmission_rate))
  
  readmission_rate_hospital <- readmission_rates %>% 
    filter(facility_name == hospital_name) %>% 
    pull(readmission_rate)
  
  readmission_rate_all <- mean(readmission_rates$readmission_rate, na.rm = TRUE)
  
  total_readmission_hospital <- readmission_rates %>% 
    filter(facility_name == hospital_name) %>% 
    pull(total_readmissions)
  
  total_readmission_all <- sum(readmission_rates$total_readmissions, na.rm = TRUE)
  
  # Return the calculated metrics as a list
  return(list(
    avg_los_hospital = avg_los_hospital,
    avg_los_all = avg_los_all,
    avg_cost_hospital = avg_cost_hospital,
    avg_cost_all = avg_cost_all,
    readmission_rate_hospital = readmission_rate_hospital,
    readmission_rate_all = readmission_rate_all,
    mortality_rate_hospital = mortality_rate_hospital,
    mortality_rate_all = mortality_rate_all,
    total_discharge_hospital = total_discharge_hospital,
    total_discharge_all = total_discharge_all,
    total_readmission_hospital = total_readmission_hospital,
    total_readmission_all = total_readmission_all
  ))
}


