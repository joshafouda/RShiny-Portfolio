# Load necessary libraries
library(plotly)
library(dplyr)
library(readr)

# Load the dataset
data <- read_csv("data/Databel - Data.csv")

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

##############################################################################

# Load necessary libraries
library(dplyr)
library(readr)
library(leaflet)
library(sf)
library(maps)
library(ggplot2)


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
print(unique_states)

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
print(state_churn_map)

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

############################################################################################

# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)


# Calculate the count of customers by Contract Type
contract_type_counts <- data %>%
  group_by(`Contract Type`) %>%
  summarize(Count = n())

# Create a Plotly donut chart
plot <- plot_ly(contract_type_counts, 
                labels = ~`Contract Type`, 
                values = ~Count, 
                type = 'pie', 
                hole = 0.4) %>%
  layout(title = "Count of Customers by Contract Type",
         showlegend = TRUE,
         annotations = list(text = 'Contract Type', 
                            x = 0.5, 
                            y = 0.5, 
                            font = list(size = 20), 
                            showarrow = FALSE))

# Show the plot
plot

#########################################################################

# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

# Calculate the count of customers by Churn Category
churn_category_counts <- data %>%
  group_by(`Churn Category`) %>%
  summarize(Count = n()) %>%
  filter(!is.na(`Churn Category`)) # Filter out any NA values

# Create a Plotly pie chart
plot <- plot_ly(churn_category_counts, 
                labels = ~`Churn Category`, 
                values = ~Count, 
                type = 'pie') %>%
  layout(title = "Count of Customers by Churn Category",
         showlegend = TRUE)

# Show the plot
plot

##########################################################################


# Load necessary libraries
library(dplyr)
library(readr)



# Calculate basic metrics
total_customers <- nrow(data)
churned_customers <- sum(data$`Churn Label` == "Yes", na.rm = TRUE)
churn_rate <- churned_customers / total_customers * 100

# Calculate additional metrics
average_monthly_charges <- mean(data$`Monthly Charge`, na.rm = TRUE)
average_tenure <- mean(data$`Account Length (in months)`, na.rm = TRUE)

# Calculate churn rate by contract type
churn_rate_by_contract <- data %>%
  group_by(`Contract Type`) %>%
  summarize(
    Total_Customers = n(),
    Churned_Customers = sum(`Churn Label` == "Yes", na.rm = TRUE),
    Churn_Rate = Churned_Customers / Total_Customers * 100
  )

# Display metrics
list(
  Total_Customers = total_customers,
  Churned_Customers = churned_customers,
  Churn_Rate = churn_rate,
  Average_Monthly_Charges = average_monthly_charges,
  Average_Tenure = average_tenure,
  Churn_Rate_by_Contract = churn_rate_by_contract
)

####################################################################

# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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

##########################################################################

# Load necessary libraries
library(dplyr)
library(readr)


# Compute the metrics
metrics <- data %>%
  summarise(
    Total_Customer_Service_Calls = sum(`Customer Service Calls`, na.rm = TRUE),
    Avg_Extra_International_Charges = mean(`Extra International Charges`, na.rm = TRUE),
    Avg_Customer_Service_Calls = mean(`Customer Service Calls`, na.rm = TRUE),
    Avg_Extra_Data_Charges = mean(`Extra Data Charges`, na.rm = TRUE)
  )

# Display the computed metrics
print(metrics)




# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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

###############################################################################

# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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


# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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
                textinfo = 'label+percent', insidetextorientation = 'radial', hole = 0.4) %>%
  layout(title = "Churn Rate by Payment Method",
         showlegend = TRUE)

# Show the plot
plot


# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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



# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)


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


# Load necessary libraries
library(dplyr)
library(readr)
library(plotly)

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


# # Load necessary libraries
# library(dplyr)
# library(readr)
# library(plotly)
# 
# 
# # Create a Plotly boxplot
# plot <- plot_ly(data, y = ~`Customer Service Calls`, x = ~`Churn Label`, type = 'box',
#                 color = ~`Churn Label`, boxpoints = 'all') %>%
#   layout(
#     title = "Customer Service Calls for Churned vs. Non-Churned Customers",
#     xaxis = list(title = "Churn Status", tickvals = c("Yes", "No")),
#     yaxis = list(title = "Number of Customer Service Calls")
#   )
# 
# # Show the plot
# plot

