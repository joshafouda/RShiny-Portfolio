library(readr)
hospital <- read_csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")
hospital_clean <- hospital %>% filter(!is.na(total_costs) & total_costs > 0)
View(hospital)

############################## LOS Comparison ##############################
# Load necessary libraries
library(dplyr)

# Calculate Total Surgeons (Assuming 'operating_provider_license_number' represents individual surgeons)
total_surgeons <- hospital %>%
  select(operating_provider_license_number) %>%
  distinct() %>%
  nrow()

# Calculate Average Length of Stay (LOS) in Days
average_los_days <- hospital %>%
  summarize(avg_los = mean(length_of_stay, na.rm = TRUE)) %>%
  pull(avg_los)

# Calculate Total Hospitals (Assuming 'facility_id' represents unique hospitals)
total_hospitals <- hospital %>%
  select(facility_id) %>%
  distinct() %>%
  nrow()

# Calculate Total Discharges
total_discharges <- nrow(hospital)

# Print the results
cat("Total Surgeons:", total_surgeons, "\n")
cat("Average LOS Days:", average_los_days, "\n")
cat("Total Hospitals:", total_hospitals, "\n")
cat("Total Discharges:", total_discharges, "\n")



# Load necessary libraries
library(dplyr)
library(plotly)

# Summarize data by hospital and order by Total Discharges in descending order
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

# Create the plot
plot <- plot_ly(hospital_summary, x = ~facility_name, y = ~total_discharges, type = 'bar', name = 'Total Discharges') %>%
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


# Display the plot
plot



# Load necessary libraries
library(dplyr)
library(plotly)

# Summarize data by hospital
hospital_summary <- hospital %>%
  group_by(facility_name) %>%
  summarize(
    average_los_days = mean(length_of_stay, na.rm = TRUE)
  )

# Get the Top 3 Highest Avg LOS Days
top_3_highest_los <- hospital_summary %>%
  arrange(desc(average_los_days)) %>%
  slice(1:3)

# Get the Bottom 3 Lowest Avg LOS Days
bottom_3_lowest_los <- hospital_summary %>%
  arrange(average_los_days) %>%
  slice(1:3)

# Create the Top 3 Highest Avg LOS Days plot
# top_3_plot <- plot_ly(top_3_highest_los, x = ~facility_name, y = ~average_los_days, type = 'bar', name = 'Highest Avg LOS Days') %>%
#   layout(
#     title = "Top 3 Hospitals with Highest Avg LOS Days",
#     xaxis = list(title = "Hospital"),
#     yaxis = list(title = "Average LOS Days")
#   )

top_3_plot <- plot_ly(top_3_highest_los, 
                      x = ~average_los_days, 
                      y = ~reorder(facility_name, -average_los_days), 
                      type = 'bar', 
                      orientation = 'h', # flip the axes
                      name = 'Highest Avg LOS Days') %>%
  layout(
    title = "Top 3 Hospitals with Highest Avg LOS Days",
    xaxis = list(title = "Average LOS Days"),
    yaxis = list(title = "Hospital")
  )


# Create the Bottom 3 Lowest Avg LOS Days plot
# bottom_3_plot <- plot_ly(bottom_3_lowest_los, x = ~facility_name, y = ~average_los_days, type = 'bar', name = 'Lowest Avg LOS Days') %>%
#   layout(
#     title = "Bottom 3 Hospitals with Lowest Avg LOS Days",
#     xaxis = list(title = "Hospital"),
#     yaxis = list(title = "Average LOS Days")
#   )

bottom_3_plot <- plot_ly(bottom_3_lowest_los, 
                         x = ~average_los_days, 
                         y = ~reorder(facility_name, -average_los_days), 
                         type = 'bar', 
                         orientation = 'h',  # flip the axes
                         name = 'Lowest Avg LOS Days') %>%
  layout(
    title = "Bottom 3 Hospitals with Lowest Avg LOS Days",
    xaxis = list(title = "Average LOS Days"),
    yaxis = list(title = "Hospital")
  )


# Display the plots
top_3_plot
bottom_3_plot


######################################### Cost Comparison ######################################
# Step 1: Load the necessary libraries
library(dplyr)

data <- hospital

# Step 4: Clean the data (if necessary)
# Check for missing values in the total_costs column
summary(data$total_costs)

# Remove rows where total_costs is NA or zero
data_clean <- data %>% filter(!is.na(total_costs) & total_costs > 0)

# Step 5: Calculate the average cost per discharge
average_cost_per_discharge <- mean(data_clean$total_costs)

# Output the result
average_cost_per_discharge


# Calculate average cost per discharge by facility
average_cost_by_facility <- data_clean %>%
  group_by(facility_name) %>%
  summarize(avg_cost = mean(total_costs)) %>%
  arrange(desc(avg_cost))

# View the result
average_cost_by_facility


# Step 5: Identify Top 3 and Bottom 3 facilities
top_3_facilities <- head(average_cost_by_facility, 3)
bottom_3_facilities <- tail(average_cost_by_facility, 3)

# Step 6: Create the Plotly bar charts

# Top 3: Highest Avg Cost per Discharge
top_3_plot <- plot_ly(
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

# Bottom 3: Lowest Avg Cost per Discharge
bottom_3_plot <- plot_ly(
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

# Display the plots
top_3_plot
bottom_3_plot



# Step 1: Load the necessary libraries
library(dplyr)
library(plotly)

# Step 2: Load the dataset
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Clean the data (if necessary)
# Remove rows where total_costs, length_of_stay, or health_service_area is NA or zero
data_clean <- data %>% 
  filter(!is.na(total_costs) & total_costs > 0 & 
           !is.na(length_of_stay) & length_of_stay > 0 &
           !is.na(health_service_area))

# Step 4: Calculate average LOS and average cost per discharge by facility and health service area
hospital_summary <- data_clean %>%
  group_by(facility_name, health_service_area) %>%
  summarize(
    avg_los = mean(length_of_stay),
    avg_cost = mean(total_costs)
  )

# Step 5: Create the scatter plot with coloring by health service area
los_vs_cost_plot <- plot_ly(
  hospital_summary,
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

# Display the plot
los_vs_cost_plot

############################## Hospital Profile: Hospital for Special Surgey ######################
# Step 1: Load the necessary libraries
library(dplyr)
library(plotly)

# Step 2: Load the dataset
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Define a function to generate the bar chart for a specific hospital
generate_severity_bar_chart <- function(hospital_name) {
  
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
    title = paste('Total Discharges by Severity of Illness for', hospital_name),
    xaxis = list(title = 'Severity of Illness'),
    yaxis = list(title = 'Total Discharges'),
    barmode = 'group'
  )
  
  # Return the plot
  return(severity_bar_chart)
}

# Step 4: Store the hospital name in a variable
selected_hospital <- "Olean General Hospital"

# Step 5: Generate the plot for the selected hospital
plot <- generate_severity_bar_chart(selected_hospital)

# Display the plot
plot

generate_mortality_risk_bar_chart <- function(hospital_name) {
  
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
    title = paste('Total Discharges by Risk of Mortality for', hospital_name),
    xaxis = list(title = 'Risk of Mortality'),
    yaxis = list(title = 'Total Discharges'),
    barmode = 'group'
  )
  
  # Return the plot
  return(mortality_risk_bar_chart)
}

# Step 5: Generate the plot for the selected hospital
plot <- generate_mortality_risk_bar_chart(selected_hospital)

# Display the plot
plot


# Step 1: Load the necessary libraries
library(dplyr)
library(plotly)

# Step 2: Load the dataset
data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Define a function to generate the donut chart for a specific hospital
generate_diagnosis_donut_chart <- function(hospital_name) {
  
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
    title = paste('Total Discharges by Diagnosis for', hospital_name),
    showlegend = TRUE,
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
  
  # Return the plot
  return(diagnosis_donut_chart)
}

# Step 4: Store the hospital name in a variable
selected_hospital <- "Olean General Hospital"

# Step 5: Generate the plot for the selected hospital
plot <- generate_diagnosis_donut_chart(selected_hospital)

# Display the plot
plot

# Step 1: Load the necessary libraries
library(dplyr)
library(plotly)

# Step 2: Load the dataset
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Define a function to generate the donut chart for a specific hospital
generate_disposition_donut_chart <- function(hospital_name) {
  
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
    title = paste('Total Discharges by Patient Disposition for', hospital_name),
    showlegend = TRUE,
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
  )
  
  # Return the plot
  return(disposition_donut_chart)
}

# Step 4: Store the hospital name in a variable
selected_hospital <- "Olean General Hospital"

# Step 5: Generate the plot for the selected hospital
plot <- generate_disposition_donut_chart(selected_hospital)

# Display the plot
plot

# Step 1: Load the necessary libraries
library(dplyr)

# Step 2: Load the dataset
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Define a function to calculate the required metrics for a specific hospital
calculate_hospital_metrics <- function(hospital_name) {
  
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
  
  # Return the calculated metrics as a list
  return(list(
    avg_los_hospital = avg_los_hospital,
    avg_los_all = avg_los_all,
    avg_cost_hospital = avg_cost_hospital,
    avg_cost_all = avg_cost_all
  ))
}

# Step 4: Store the hospital name in a variable
selected_hospital <- "Olean General Hospital"

# Step 5: Calculate the metrics for the selected hospital
hospital_metrics <- calculate_hospital_metrics(selected_hospital)

# Print the metrics
print(paste("Average LOS Days for", selected_hospital, ":", hospital_metrics$avg_los_hospital))
print(paste("Average LOS Days for ALL Hospitals:", hospital_metrics$avg_los_all))
print(paste("Average Cost per Discharge for", selected_hospital, ":", hospital_metrics$avg_cost_hospital))
print(paste("Average Cost per Discharge for ALL Hospitals:", hospital_metrics$avg_cost_all))


################################### ChatGPT ###################################################

################## 1. Hospital Performance Comparison
# Step 1: Load the necessary libraries
library(dplyr)
library(plotly)

# Step 2: Load the dataset
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 3: Define a readmission metric
# Assuming the dataset has a patient identifier (e.g., patient_id)
# If the dataset does not have a patient_id, this step might need modification.

# Simulate a patient identifier column for this example
# (This step should be omitted if the actual dataset already contains a patient_id)
set.seed(123)
data$patient_id <- sample(1:1000, nrow(data), replace = TRUE)

# Step 4: Calculate readmission rates for each hospital
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
    readmission_rate = total_readmissions / total_discharges
  ) %>%
  arrange(desc(readmission_rate))

# Step 5: Create a Plotly bar chart to visualize the readmission rates
readmission_plot <- plot_ly(
  readmission_rates,
  x = ~reorder(facility_name, -readmission_rate),  # Order by readmission rate
  y = ~readmission_rate,
  type = 'bar',
  text = ~paste('Readmission Rate:', round(readmission_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'orange')
) %>% layout(
  title = 'Hospital Readmission Rates',
  xaxis = list(title = 'Hospital', tickangle = -45),
  yaxis = list(title = 'Readmission Rate', tickformat = '.0%'),
  barmode = 'group'
)

# Display the plot
readmission_plot


# Step 4: Extract the top 10 hospitals with the highest and lowest readmission rates
top_10_highest <- readmission_rates %>%
  head(10)

top_10_lowest <- readmission_rates %>%
  tail(10)

# Step 5: Create the Plotly bar charts

# Plot for Top 10 Hospitals with Highest Readmission Rates
plot_highest <- plot_ly(
  top_10_highest,
  x = ~reorder(facility_name, -readmission_rate),  # Order by readmission rate
  y = ~readmission_rate,
  type = 'bar',
  text = ~paste('Readmission Rate:', round(readmission_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'red')
) %>% layout(
  title = 'Top 10 Hospitals with Highest Readmission Rates',
  xaxis = list(title = 'Hospital', tickangle = -45),
  yaxis = list(title = 'Readmission Rate', tickformat = '.0%'),
  barmode = 'group'
)

# Plot for Top 10 Hospitals with Lowest Readmission Rates
plot_lowest <- plot_ly(
  top_10_lowest,
  x = ~reorder(facility_name, readmission_rate),  # Order by readmission rate
  y = ~readmission_rate,
  type = 'bar',
  text = ~paste('Readmission Rate:', round(readmission_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Top 10 Hospitals with Lowest Readmission Rates',
  xaxis = list(title = 'Hospital', tickangle = -45),
  yaxis = list(title = 'Readmission Rate', tickformat = '.0%'),
  barmode = 'group'
)

# Display the plots
plot_highest
plot_lowest

# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Calculate mortality rate by hospital
mortality_rates <- data %>%
  group_by(facility_name) %>%
  summarize(
    total_discharges = n(),
    total_expired = sum(patient_disposition == "Expired"),
    mortality_rate = total_expired / total_discharges
  ) %>%
  arrange(desc(mortality_rate))

# Step 2: Visualize the mortality rates across hospitals

# Create a bar chart for mortality rates
mortality_plot <- plot_ly(
  head(mortality_rates, 10),
  x = ~reorder(facility_name, -mortality_rate),  # Order by mortality rate
  y = ~mortality_rate,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = "Top 10 Hospitals with Highest Mortality Rates",
  xaxis = list(title = 'Hospital', tickangle = -45),
  yaxis = list(title = 'Mortality Rate', tickformat = '.0%'),
  barmode = 'group'
)

# Display the plot
mortality_plot


# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Set the selected hospital name (you can change this variable to analyze different hospitals)
selected_hospital <- "Olean General Hospital"  # Replace with the actual hospital name

# Step 1: Filter data for the selected hospital
filtered_data <- data %>%
  filter(facility_name == selected_hospital)

# Step 2: Calculate average cost per discharge by severity of illness for the selected hospital
cost_by_severity <- filtered_data %>%
  group_by(apr_severity_of_illness_description) %>%
  summarize(
    avg_cost_per_discharge = mean(total_costs, na.rm = TRUE),
    total_discharges = n()
  ) %>%
  filter(total_discharges > 0) %>%
  ungroup()

# Step 3: Calculate average cost per discharge by risk of mortality for the selected hospital
cost_by_mortality_risk <- filtered_data %>%
  group_by(apr_risk_of_mortality) %>%
  summarize(
    avg_cost_per_discharge = mean(total_costs, na.rm = TRUE),
    total_discharges = n()
  ) %>%
  filter(total_discharges > 0) %>%
  ungroup()

# Step 4: Visualize the average cost per discharge by severity of illness for the selected hospital
plot_severity <- plot_ly(
  cost_by_severity,
  x = ~apr_severity_of_illness_description,
  y = ~avg_cost_per_discharge,
  type = 'bar',
  text = ~paste('Avg Cost per Discharge:', round(avg_cost_per_discharge, 2)),
  hoverinfo = 'text',
  marker = list(color = 'Set1')
) %>% layout(
  title = paste('Average Cost per Discharge by Severity of Illness for', selected_hospital),
  xaxis = list(title = 'Severity of Illness'),
  yaxis = list(title = 'Average Cost per Discharge'),
  barmode = 'group'
)

# Step 5: Visualize the average cost per discharge by risk of mortality for the selected hospital
plot_mortality <- plot_ly(
  cost_by_mortality_risk,
  x = ~apr_risk_of_mortality,
  y = ~avg_cost_per_discharge,
  type = 'bar',
  text = ~paste('Avg Cost per Discharge:', round(avg_cost_per_discharge, 2)),
  hoverinfo = 'text',
  marker = list(color = 'Set2')
) %>% layout(
  title = paste('Average Cost per Discharge by Risk of Mortality for', selected_hospital),
  xaxis = list(title = 'Risk of Mortality'),
  yaxis = list(title = 'Average Cost per Discharge'),
  barmode = 'group'
)

# Display the plots
plot_severity
plot_mortality


###################### 2. Patient Demographics Analysis

# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by age group and calculate metrics

# Calculate average length of stay, average cost, and mortality rate by age group
age_group_analysis <- data %>%
  group_by(age_group) %>%
  summarize(
    avg_los = mean(length_of_stay, na.rm = TRUE),
    avg_cost = mean(total_costs, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_cost))

# Step 2: Visualize the average length of stay by age group
plot_avg_los <- plot_ly(
  age_group_analysis,
  x = ~age_group,
  y = ~avg_los,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = 'Average Length of Stay by Age Group',
  xaxis = list(title = 'Age Group'),
  yaxis = list(title = 'Average Length of Stay (Days)')
)

# Step 3: Visualize the average cost per discharge by age group
plot_avg_cost <- plot_ly(
  age_group_analysis,
  x = ~age_group,
  y = ~avg_cost,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Average Cost per Discharge by Age Group',
  xaxis = list(title = 'Age Group'),
  yaxis = list(title = 'Average Cost ($)')
)

# Step 4: Visualize the mortality rate by age group
plot_mortality_rate <- plot_ly(
  age_group_analysis,
  x = ~age_group,
  y = ~mortality_rate,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'red')
) %>% layout(
  title = 'Mortality Rate by Age Group',
  xaxis = list(title = 'Age Group'),
  yaxis = list(title = 'Mortality Rate (%)'),
  yaxis = list(tickformat = '.0%')
)

# Display the plots
plot_avg_los
plot_avg_cost
plot_mortality_rate


# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by gender and calculate metrics

# Calculate average length of stay, average cost, and mortality rate by gender
gender_analysis <- data %>%
  group_by(gender) %>%
  summarize(
    avg_los = mean(length_of_stay, na.rm = TRUE),
    avg_cost = mean(total_costs, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_cost))

# Step 2: Visualize the average length of stay by gender using a donut plot
plot_avg_los_gender <- plot_ly(
  gender_analysis,
  labels = ~gender,
  values = ~avg_los,
  type = 'pie',
  hole = 0.4,  # Donut hole to create the donut effect
  textinfo = 'label+percent',
  hoverinfo = 'text',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days')
) %>% layout(
  title = 'Average Length of Stay by Gender',
  showlegend = TRUE
)

# Step 3: Visualize the average cost per discharge by gender using a donut plot
plot_avg_cost_gender <- plot_ly(
  gender_analysis,
  labels = ~gender,
  values = ~avg_cost,
  type = 'pie',
  hole = 0.4,  # Donut hole to create the donut effect
  textinfo = 'label+percent',
  hoverinfo = 'text',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$')
) %>% layout(
  title = 'Average Cost per Discharge by Gender',
  showlegend = TRUE
)

# Step 4: Visualize the mortality rate by gender using a donut plot
# For Mortality Rate, we may need to adjust the values to better reflect the distribution
plot_mortality_rate_gender <- plot_ly(
  gender_analysis,
  labels = ~gender,
  values = ~mortality_rate,
  type = 'pie',
  hole = 0.4,  # Donut hole to create the donut effect
  textinfo = 'label+percent',
  hoverinfo = 'text',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%')
) %>% layout(
  title = 'Mortality Rate by Gender',
  showlegend = TRUE
)

# Display the plots
plot_avg_los_gender
plot_avg_cost_gender
plot_mortality_rate_gender


# Load necessary libraries
# library(dplyr)
# library(plotly)
# 
# # Assuming the dataset is already loaded in 'data'
# data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")
# 
# # Step 1: Group data by ethnicity and race and calculate metrics
# 
# # Calculate average length of stay, average cost, and mortality rate by ethnicity and race
# ethnicity_race_analysis <- data %>%
#   group_by(ethnicity, race) %>%
#   summarize(
#     avg_los = mean(length_of_stay, na.rm = TRUE),
#     avg_cost = mean(total_costs, na.rm = TRUE),
#     mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
#     total_patients = n()
#   ) %>%
#   arrange(desc(avg_cost))
# 
# # Step 2: Visualize the average length of stay by ethnicity and race
# plot_avg_los_ethnicity_race <- plot_ly(
#   ethnicity_race_analysis,
#   x = ~interaction(ethnicity, race),
#   y = ~avg_los,
#   type = 'bar',
#   text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
#   hoverinfo = 'text',
#   marker = list(color = 'blue')
# ) %>% layout(
#   title = 'Average Length of Stay by Ethnicity and Race',
#   xaxis = list(title = 'Ethnicity and Race', tickangle = -45),
#   yaxis = list(title = 'Average Length of Stay (Days)')
# )
# 
# # Step 3: Visualize the average cost per discharge by ethnicity and race
# plot_avg_cost_ethnicity_race <- plot_ly(
#   ethnicity_race_analysis,
#   x = ~interaction(ethnicity, race),
#   y = ~avg_cost,
#   type = 'bar',
#   text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
#   hoverinfo = 'text',
#   marker = list(color = 'green')
# ) %>% layout(
#   title = 'Average Cost per Discharge by Ethnicity and Race',
#   xaxis = list(title = 'Ethnicity and Race', tickangle = -45),
#   yaxis = list(title = 'Average Cost ($)')
# )
# 
# # Step 4: Visualize the mortality rate by ethnicity and race
# plot_mortality_rate_ethnicity_race <- plot_ly(
#   ethnicity_race_analysis,
#   x = ~interaction(ethnicity, race),
#   y = ~mortality_rate,
#   type = 'bar',
#   text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
#   hoverinfo = 'text',
#   marker = list(color = 'red')
# ) %>% layout(
#   title = 'Mortality Rate by Ethnicity and Race',
#   xaxis = list(title = 'Ethnicity and Race', tickangle = -45),
#   yaxis = list(title = 'Mortality Rate (%)'),
#   yaxis = list(tickformat = '.0%')
# )
# 
# # Display the plots
# plot_avg_los_ethnicity_race
# plot_avg_cost_ethnicity_race
# plot_mortality_rate_ethnicity_race

##################### 3. Length of Stay (LOS) Analysis
# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by severity of illness and risk of mortality and calculate average length of stay
severity_mortality_analysis <- data %>%
  group_by(apr_severity_of_illness_description, apr_risk_of_mortality) %>%
  summarize(
    avg_los = mean(length_of_stay, na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_los))

# Step 2: Visualize the average length of stay by severity of illness and risk of mortality
plot_avg_los_severity <- plot_ly(
  severity_mortality_analysis,
  x = ~apr_severity_of_illness_description,
  y = ~avg_los,
  color = ~apr_risk_of_mortality,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  barmode = 'group'
) %>% layout(
  title = 'Average Length of Stay by Severity of Illness and Risk of Mortality',
  xaxis = list(title = 'Severity of Illness'),
  yaxis = list(title = 'Average Length of Stay (Days)'),
  legend = list(title = list(text = 'Risk of Mortality'))
)

# Step 3: Visualize the length of stay distribution using a box plot for further insights
plot_los_boxplot <- plot_ly(
  data,
  x = ~apr_severity_of_illness_description,
  y = ~length_of_stay,
  color = ~apr_risk_of_mortality,
  type = 'box',
  text = ~paste('Length of Stay:', length_of_stay, 'days'),
  hoverinfo = 'text'
) %>% layout(
  title = 'Length of Stay Distribution by Severity of Illness and Risk of Mortality',
  xaxis = list(title = 'Severity of Illness'),
  yaxis = list(title = 'Length of Stay (Days)'),
  legend = list(title = list(text = 'Risk of Mortality'))
)

# Display the plots
plot_avg_los_severity
plot_los_boxplot # difficile a interpreter donc graphique ci-dessous :

# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by severity of illness and risk of mortality and calculate average length of stay
severity_mortality_analysis <- data %>%
  group_by(apr_severity_of_illness_description, apr_risk_of_mortality) %>%
  summarize(
    avg_los = mean(length_of_stay, na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_los))

# Step 2: Create a facet grid plot using plotly
facet_grid_plot <- plot_ly(
  severity_mortality_analysis,
  x = ~apr_risk_of_mortality,
  y = ~avg_los,
  color = ~apr_risk_of_mortality,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text'
) %>% layout(
  title = 'Average Length of Stay by Severity of Illness and Risk of Mortality',
  xaxis = list(title = 'Risk of Mortality'),
  yaxis = list(title = 'Average Length of Stay (Days)'),
  facet = list(rows = ~apr_severity_of_illness_description)
)

# Display the facet grid plot
facet_grid_plot

################### 4. **Geographic Analysis**
# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by health service area and calculate metrics
hsa_analysis <- data %>%
  group_by(health_service_area, facility_name) %>%
  summarize(
    avg_cost = mean(total_costs, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
    avg_age = mean(length_of_stay, na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_cost))

# Step 2: Visualize the average cost per discharge by health service area and facility
plot_avg_cost_hsa <- plot_ly(
  hsa_analysis,
  x = ~facility_name,
  y = ~avg_cost,
  color = ~health_service_area,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  barmode = 'group'
) %>% layout(
  title = 'Average Cost per Discharge by Health Service Area and Facility',
  xaxis = list(title = 'Facility', tickangle = -45),
  yaxis = list(title = 'Average Cost ($)'),
  legend = list(title = list(text = 'Health Service Area'))
)

# Step 3: Visualize the mortality rate by health service area and facility
plot_mortality_rate_hsa <- plot_ly(
  hsa_analysis,
  x = ~facility_name,
  y = ~mortality_rate,
  color = ~health_service_area,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  barmode = 'group'
) %>% layout(
  title = 'Mortality Rate by Health Service Area and Facility',
  xaxis = list(title = 'Facility', tickangle = -45),
  yaxis = list(title = 'Mortality Rate (%)'),
  yaxis = list(tickformat = '.0%'),
  legend = list(title = list(text = 'Health Service Area'))
)

# Step 4: Visualize the average age of patients by health service area and facility
plot_avg_age_hsa <- plot_ly(
  hsa_analysis,
  x = ~facility_name,
  y = ~avg_age,
  color = ~health_service_area,
  type = 'bar',
  text = ~paste('Average Age:', round(avg_age, 2), 'years'),
  hoverinfo = 'text',
  barmode = 'group'
) %>% layout(
  title = 'Average Age of Patients by Health Service Area and Facility',
  xaxis = list(title = 'Facility', tickangle = -45),
  yaxis = list(title = 'Average Age (Years)'),
  legend = list(title = list(text = 'Health Service Area'))
)

# Display the plots
plot_avg_cost_hsa
plot_mortality_rate_hsa
plot_avg_age_hsa


# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Group data by health service area and calculate average LOS and cost
region_analysis <- data %>%
  group_by(health_service_area) %>%
  summarize(
    avg_los = mean(length_of_stay, na.rm = TRUE),
    avg_cost = mean(total_costs, na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_cost))

# Step 2: Visualize the average length of stay by health service area
plot_avg_los_region <- plot_ly(
  region_analysis,
  x = ~health_service_area,
  y = ~avg_los,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = 'Average Length of Stay by Health Service Area',
  xaxis = list(title = 'Health Service Area', tickangle = -45),
  yaxis = list(title = 'Average Length of Stay (Days)')
)

# Step 3: Visualize the average cost per discharge by health service area
plot_avg_cost_region <- plot_ly(
  region_analysis,
  x = ~health_service_area,
  y = ~avg_cost,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Average Cost per Discharge by Health Service Area',
  xaxis = list(title = 'Health Service Area', tickangle = -45),
  yaxis = list(title = 'Average Cost ($)')
)

# Step 4: Visualize the regional differences using a heatmap
heatmap_plot <- plot_ly(
  region_analysis,
  x = ~health_service_area,
  y = ~factor(1),  # Placeholder to keep the plot in a single row
  z = ~avg_los,
  type = 'heatmap',
  colors = colorRamp(c("white", "red")),
  text = ~paste('Average LOS:', round(avg_los, 2), 'days', '<br>Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text'
) %>% layout(
  title = 'Heatmap of Average Length of Stay and Costs by Health Service Area',
  xaxis = list(title = 'Health Service Area', tickangle = -45),
  yaxis = list(showticklabels = FALSE)  # Hide y-axis labels as it's a single row
)

# Display the plots
plot_avg_los_region
plot_avg_cost_region
heatmap_plot

########################################## 5. **Diagnosis and Procedure Analysis**
# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Identify the most common diagnoses and procedures
top_diagnoses <- data %>%
  group_by(ccs_diagnosis_description) %>%
  summarize(
    count = n(),
    avg_cost = mean(total_costs, na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE)
  ) %>%
  arrange(desc(count)) %>%
  slice_head(n = 10)  # Get the top 10 most common diagnoses

top_procedures <- data %>%
  group_by(ccs_procedure_description) %>%
  summarize(
    count = n(),
    avg_cost = mean(total_costs, na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE)
  ) %>%
  arrange(desc(count)) %>%
  slice_head(n = 10)  # Get the top 10 most common procedures

# Step 2: Visualize the associated costs for the top diagnoses
plot_top_diagnoses_cost <- plot_ly(
  top_diagnoses,
  x = ~reorder(ccs_diagnosis_description, avg_cost),
  y = ~avg_cost,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Top 10 Diagnoses by Average Cost',
  xaxis = list(title = 'Diagnosis', tickangle = -45),
  yaxis = list(title = 'Average Cost ($)')
)

# Step 3: Visualize the associated length of stay for the top diagnoses
plot_top_diagnoses_los <- plot_ly(
  top_diagnoses,
  x = ~reorder(ccs_diagnosis_description, avg_los),
  y = ~avg_los,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = 'Top 10 Diagnoses by Average Length of Stay',
  xaxis = list(title = 'Diagnosis', tickangle = -45),
  yaxis = list(title = 'Average Length of Stay (Days)')
)

# Step 4: Visualize the mortality rate for the top diagnoses
plot_top_diagnoses_mortality <- plot_ly(
  top_diagnoses,
  x = ~reorder(ccs_diagnosis_description, mortality_rate),
  y = ~mortality_rate,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'red')
) %>% layout(
  title = 'Top 10 Diagnoses by Mortality Rate',
  xaxis = list(title = 'Diagnosis', tickangle = -45),
  yaxis = list(title = 'Mortality Rate (%)'),
  yaxis = list(tickformat = '.0%')
)

# Step 5: Visualize the associated costs for the top procedures
plot_top_procedures_cost <- plot_ly(
  top_procedures,
  x = ~reorder(ccs_procedure_description, avg_cost),
  y = ~avg_cost,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Top 10 Procedures by Average Cost',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Average Cost ($)')
)

# Step 6: Visualize the associated length of stay for the top procedures
plot_top_procedures_los <- plot_ly(
  top_procedures,
  x = ~reorder(ccs_procedure_description, avg_los),
  y = ~avg_los,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = 'Top 10 Procedures by Average Length of Stay',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Average Length of Stay (Days)')
)

# Step 7: Visualize the mortality rate for the top procedures
plot_top_procedures_mortality <- plot_ly(
  top_procedures,
  x = ~reorder(ccs_procedure_description, mortality_rate),
  y = ~mortality_rate,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'red')
) %>% layout(
  title = 'Top 10 Procedures by Mortality Rate',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Mortality Rate (%)'),
  yaxis = list(tickformat = '.0%')
)

# Display the plots
plot_top_diagnoses_cost
plot_top_diagnoses_los
plot_top_diagnoses_mortality
plot_top_procedures_cost
plot_top_procedures_los
plot_top_procedures_mortality


# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Identify high-cost diagnoses
high_cost_diagnoses <- data %>%
  group_by(ccs_diagnosis_description) %>%
  summarize(
    avg_cost = mean(total_costs, na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
    readmission_rate = mean(ifelse(n() > 1, 1, 0), na.rm = TRUE),
    total_patients = n()
  ) %>%
  arrange(desc(avg_cost)) %>%
  slice_head(n = 10)  # Select top 10 high-cost diagnoses

# Step 2: Visualize the costs vs mortality rate for high-cost diagnoses
plot_cost_vs_mortality <- plot_ly(
  high_cost_diagnoses,
  x = ~avg_cost,
  y = ~mortality_rate,
  type = 'scatter',
  mode = 'markers+text',
  text = ~ccs_diagnosis_description,
  hoverinfo = 'text+x+y',
  marker = list(size = 10, color = 'red')
) %>% layout(
  title = 'Costs vs Mortality Rate for High-Cost Diagnoses',
  xaxis = list(title = 'Average Cost ($)'),
  yaxis = list(title = 'Mortality Rate (%)', tickformat = '.0%')
)

# Step 3: Visualize the costs vs readmission rate for high-cost diagnoses
plot_cost_vs_readmission <- plot_ly(
  high_cost_diagnoses,
  x = ~avg_cost,
  y = ~readmission_rate,
  type = 'scatter',
  mode = 'markers+text',
  text = ~ccs_diagnosis_description,
  hoverinfo = 'text+x+y',
  marker = list(size = 10, color = 'blue')
) %>% layout(
  title = 'Costs vs Readmission Rate for High-Cost Diagnoses',
  xaxis = list(title = 'Average Cost ($)'),
  yaxis = list(title = 'Readmission Rate (%)', tickformat = '.0%')
)

# Step 4: Visualize the costs vs average length of stay for high-cost diagnoses
plot_cost_vs_los <- plot_ly(
  high_cost_diagnoses,
  x = ~avg_cost,
  y = ~avg_los,
  type = 'scatter',
  mode = 'markers+text',
  text = ~ccs_diagnosis_description,
  hoverinfo = 'text+x+y',
  marker = list(size = 10, color = 'green')
) %>% layout(
  title = 'Costs vs Length of Stay for High-Cost Diagnoses',
  xaxis = list(title = 'Average Cost ($)'),
  yaxis = list(title = 'Average Length of Stay (Days)')
)

# Display the plots
plot_cost_vs_mortality
plot_cost_vs_readmission
plot_cost_vs_los

### 8. **Outcome Prediction Models**
# Load necessary libraries
library(tidymodels)
library(dplyr)

# Assuming the dataset is already loaded in 'data'
data <- read.csv("data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Data Preparation
# Selecting relevant features and outcome variable
data_clean <- data %>%
  select(age_group, gender, length_of_stay, total_costs, 
         apr_severity_of_illness_description, apr_risk_of_mortality, 
         health_service_area, facility_name, patient_disposition) %>%
  mutate(mortality = factor(ifelse(patient_disposition == "Expired", 1, 0), levels = c(0, 1))) %>%
  select(-patient_disposition) %>% 
  drop_na()  # Removing rows with missing values

# Splitting the data into training and testing sets
set.seed(123)
data_split <- initial_split(data_clean, prop = 0.8, strata = mortality)
train_data <- training(data_split)
test_data <- testing(data_split)

# Step 2: Define the Model with Regularization (Ridge Regression)
library(glmnet)
ridge_model <- logistic_reg(penalty = 0.1, mixture = 0) %>%
  set_engine("glmnet") %>%
  set_mode("classification")

# Step 3: Define the Recipe with `step_zv()` to remove zero-variance columns
mortality_recipe <- recipe(mortality ~ ., data = train_data) %>%
  step_novel(all_nominal(), -all_outcomes()) %>%  # Handle unseen levels
  step_dummy(all_nominal(), -all_outcomes()) %>%
  step_zv(all_predictors()) %>%  # Remove zero-variance predictors
  step_normalize(all_numeric(), -all_outcomes())

# Step 4: Create the Workflow
mortality_workflow <- workflow() %>%
  add_model(ridge_model) %>%
  add_recipe(mortality_recipe)

# Step 5: Train the Model
mortality_fit <- mortality_workflow %>%
  fit(data = train_data)

# Step 6: Evaluate the Model
# Predicting on the test set
mortality_predictions <- predict(mortality_fit, test_data, type = "prob") %>%
  bind_cols(test_data) 

# Calculate the ROC AUC
roc_auc <- roc_auc(mortality_predictions, truth = mortality, .pred_1)
roc_auc

# Confusion Matrix
# confusion <- conf_mat(mortality_predictions, truth = mortality, estimate = .pred_class)
# confusion

# Step 7: Visualize the ROC Curve
roc_curve_plot <- mortality_predictions %>%
  roc_curve(mortality, .pred_1) %>%
  autoplot()

# Display the ROC Curve
roc_curve_plot



########################### 9. **Utilization of Resources**
# Load necessary libraries
library(dplyr)
library(ggplot2)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Calculate the average and standard deviation for cost and LOS
cost_stats <- data %>%
  summarize(
    mean_cost = mean(total_costs, na.rm = TRUE),
    sd_cost = sd(total_costs, na.rm = TRUE),
    mean_los = mean(length_of_stay, na.rm = TRUE),
    sd_los = sd(length_of_stay, na.rm = TRUE)
  )

# Step 2: Identify cases that deviate significantly from the average
outliers <- data %>%
  mutate(
    cost_z = (total_costs - cost_stats$mean_cost) / cost_stats$sd_cost,
    los_z = (length_of_stay - cost_stats$mean_los) / cost_stats$sd_los,
    cost_outlier = abs(cost_z) > 2,  # Mark as outlier if beyond 2 standard deviations
    los_outlier = abs(los_z) > 2     # Mark as outlier if beyond 2 standard deviations
  )

# Filter outliers
cost_outliers <- outliers %>% filter(cost_outlier)
los_outliers <- outliers %>% filter(los_outlier)

# Step 3: Investigate the characteristics of the outliers
# We can investigate by examining the distribution of some key variables
summary_cost_outliers <- cost_outliers %>%
  group_by(ccs_diagnosis_description, apr_severity_of_illness_description) %>%
  summarize(
    count = n(),
    avg_cost = mean(total_costs, na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE)
  )

summary_los_outliers <- los_outliers %>%
  group_by(ccs_diagnosis_description, apr_severity_of_illness_description) %>%
  summarize(
    count = n(),
    avg_cost = mean(total_costs, na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE)
  )

# Step 4: Visualize the outliers

# Visualize cost outliers with a scatter plot
plot_cost_outliers <- plot_ly(
  cost_outliers,
  x = ~ccs_diagnosis_description,
  y = ~total_costs,
  color = ~apr_severity_of_illness_description,
  type = 'scatter',
  mode = 'markers',
  text = ~paste('Cost:', round(total_costs, 2), '<br>Diagnosis:', ccs_diagnosis_description),
  hoverinfo = 'text'
) %>% layout(
  title = 'Outliers in Cost',
  xaxis = list(title = 'Diagnosis', tickangle = -45),
  yaxis = list(title = 'Total Costs ($)'),
  showlegend = TRUE
)

# Visualize LOS outliers with a scatter plot
plot_los_outliers <- plot_ly(
  los_outliers,
  x = ~ccs_diagnosis_description,
  y = ~length_of_stay,
  color = ~apr_severity_of_illness_description,
  type = 'scatter',
  mode = 'markers',
  text = ~paste('LOS:', round(length_of_stay, 2), 'days<br>Diagnosis:', ccs_diagnosis_description),
  hoverinfo = 'text'
) %>% layout(
  title = 'Outliers in Length of Stay',
  xaxis = list(title = 'Diagnosis', tickangle = -45),
  yaxis = list(title = 'Length of Stay (Days)'),
  showlegend = TRUE
)

# Display the plots
plot_cost_outliers
plot_los_outliers


# Load necessary libraries
library(dplyr)
library(plotly)

# Assuming the dataset is already loaded in 'data'
# data <- read.csv("/mnt/data/hospital_inpatient_discharges_totalhipreplacement.csv")

# Step 1: Identify the most frequent and high-cost procedures
procedure_analysis <- data %>%
  group_by(ccs_procedure_description) %>%
  summarize(
    frequency = n(),
    avg_cost = mean(total_costs, na.rm = TRUE),
    mortality_rate = mean(patient_disposition == "Expired", na.rm = TRUE),
    avg_los = mean(length_of_stay, na.rm = TRUE),
    readmission_rate = mean(ifelse(n() > 1, 1, 0), na.rm = TRUE)
  ) %>%
  arrange(desc(avg_cost))  # Sorting by average cost

# Step 2: Visualize the frequency of procedures
plot_procedure_frequency <- plot_ly(
  procedure_analysis,
  x = ~reorder(ccs_procedure_description, -frequency),
  y = ~frequency,
  type = 'bar',
  text = ~paste('Frequency:', frequency),
  hoverinfo = 'text',
  marker = list(color = 'blue')
) %>% layout(
  title = 'Frequency of Procedures',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Frequency'),
  showlegend = FALSE
)

# Step 3: Visualize the average cost of procedures
plot_procedure_cost <- plot_ly(
  procedure_analysis,
  x = ~reorder(ccs_procedure_description, -avg_cost),
  y = ~avg_cost,
  type = 'bar',
  text = ~paste('Average Cost:', round(avg_cost, 2), '$'),
  hoverinfo = 'text',
  marker = list(color = 'green')
) %>% layout(
  title = 'Average Cost of Procedures',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Average Cost ($)'),
  showlegend = FALSE
)

# Step 4: Visualize the mortality rate associated with procedures
plot_procedure_mortality <- plot_ly(
  procedure_analysis,
  x = ~reorder(ccs_procedure_description, -mortality_rate),
  y = ~mortality_rate,
  type = 'bar',
  text = ~paste('Mortality Rate:', round(mortality_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'red')
) %>% layout(
  title = 'Mortality Rate of Procedures',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Mortality Rate (%)'),
  yaxis = list(tickformat = '.0%'),
  showlegend = FALSE
)

# Step 5: Visualize the average length of stay associated with procedures
plot_procedure_los <- plot_ly(
  procedure_analysis,
  x = ~reorder(ccs_procedure_description, -avg_los),
  y = ~avg_los,
  type = 'bar',
  text = ~paste('Average LOS:', round(avg_los, 2), 'days'),
  hoverinfo = 'text',
  marker = list(color = 'orange')
) %>% layout(
  title = 'Average Length of Stay for Procedures',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Average Length of Stay (Days)'),
  showlegend = FALSE
)

# Step 6: Visualize the readmission rate associated with procedures
plot_procedure_readmission <- plot_ly(
  procedure_analysis,
  x = ~reorder(ccs_procedure_description, -readmission_rate),
  y = ~readmission_rate,
  type = 'bar',
  text = ~paste('Readmission Rate:', round(readmission_rate * 100, 2), '%'),
  hoverinfo = 'text',
  marker = list(color = 'purple')
) %>% layout(
  title = 'Readmission Rate for Procedures',
  xaxis = list(title = 'Procedure', tickangle = -45),
  yaxis = list(title = 'Readmission Rate (%)'),
  yaxis = list(tickformat = '.0%'),
  showlegend = FALSE
)

# Display the plots
plot_procedure_frequency
plot_procedure_cost
plot_procedure_mortality
plot_procedure_los
plot_procedure_readmission


