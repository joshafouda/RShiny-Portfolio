# Load necessary library
library(readr)    # For reading CSV files

# Import datasets
education_level <- read_csv("data/EducationLevel.csv")
employee <- read_csv("data/Employee.csv")
performance_rating <- read_csv("data/PerformanceRating.csv")
rating_level <- read_csv("data/RatingLevel.csv")
satisfied_level <- read_csv("data/SatisfiedLevel.csv")

# Display the first few rows of each dataframe to confirm import
View(education_level)
View(employee)
View(performance_rating)
View(rating_level)
View(satisfied_level)


# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)

# Check the structure to ensure we understand which columns to use
employee_data <- employee
glimpse(employee_data)

# Assuming 'HireDate' and 'Attrition' are available and relevant:
# We'll extract the year from 'HireDate' and summarize the data
employee_data$Year <- format(as.Date(employee_data$HireDate, format = "%Y-%m-%d"), "%Y")
employee_summary <- employee_data %>%
  group_by(Year, Attrition) %>%
  summarise(TotalEmployees = n(), .groups = 'drop')

# Create the plot with Plotly
plot_ly(employee_summary, x = ~Year, y = ~TotalEmployees, color = ~Attrition, type = 'bar', text = ~paste("Total: ", TotalEmployees),
        hoverinfo = 'text', colors = c("green", "black")) %>%
  layout(yaxis = list(title = 'Total Employees'),
         barmode = 'stack',
         title = 'Employee Hiring Trends',
         xaxis = list(title = 'Year'),
         legend = list(title = list(text = 'Attrition'), orientation = "h"))



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)



# Filtering active employees (assuming 'Attrition' column has "No" for active employees)
active_employees <- employee_data %>% 
  filter(Attrition == "No") %>%
  group_by(Department) %>%
  summarise(Count = n(), .groups = 'drop')

# Create the plot with Plotly with flipped axes
plot_ly(active_employees, x = ~Count, y = ~Department, type = 'bar', orientation = 'h',
        marker = list(color = 'green')) %>%
  layout(xaxis = list(title = 'Number of Active Employees'),
         yaxis = list(title = 'Department'),
         title = 'Active Employees by Department')



# Install and import necessary packages

library(highcharter)


# Filtering active employees (assuming 'Attrition' column has "No" for active employees)
summary_table <- employee_data %>%
  filter(Attrition == "No") %>%
  group_by(Department, JobRole) %>%
  summarise(
    nb_employees = n(),
    .groups = 'drop'
  )

# Creating the treemap with Highcharter
tree_map <- summary_table %>%
  hchart(
    "treemap",
    hcaes(x = JobRole, value = nb_employees, color = Department),
    layoutAlgorithm = 'squarified'
  )

tree_map



# Load necessary libraries
library(readr)
library(dplyr)

# Compute KPIs
total_employees <- nrow(employee_data)
total_active_employees <- sum(employee_data$Attrition == "No")
total_inactive_employees <- sum(employee_data$Attrition == "Yes")
attrition_rate <- total_inactive_employees / total_employees * 100

# Print KPIs
cat("Total Employees: ", total_employees, "\n")
cat("Total Active Employees: ", total_active_employees, "\n")
cat("Total Inactive Employees: ", total_inactive_employees, "\n")
cat("Attrition Rate (%): ", attrition_rate, "\n")


# Load necessary libraries
library(readr)
library(plotly)


# Plotting the histogram of Employee Ages
plot_ly(employee_data, x = ~Age, type = "histogram",
        histnorm = "percent", 
        marker = list(color = 'blue')) %>%
  layout(title = "Distribution of Employee Ages",
         xaxis = list(title = "Age"),
         yaxis = list(title = "Percentage"))



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Add an Age Group column
employee_data <- employee_data %>%
  mutate(AgeGroup = case_when(
    Age < 20 ~ "<20",
    Age >= 20 & Age <= 29 ~ "20-29",
    Age >= 30 & Age <= 39 ~ "30-39",
    Age >= 40 & Age <= 49 ~ "40-49",
    Age >= 50 ~ "50>"
  ))

# Summarize data to count the number of employees in each age group
age_distribution <- employee_data %>%
  group_by(AgeGroup) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  arrange(AgeGroup)

# Plotting the bar chart
plot_ly(age_distribution, x = ~AgeGroup, y = ~Count, type = 'bar',
        marker = list(color = 'rgba(55, 128, 191, 0.7)')
        #text = ~Count, textposition = 'auto'
        ) %>%
  layout(title = 'Employee Age Group Distribution',
         xaxis = list(title = 'Age Group'),
         yaxis = list(title = 'Number of Employees'))



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Summarize data to count the number of employees in each marital status category
marital_status_distribution <- employee_data %>%
  group_by(MaritalStatus) %>%
  summarise(Count = n(), .groups = 'drop')

# Create a Plotly donut chart
plot_ly(marital_status_distribution, labels = ~MaritalStatus, values = ~Count, type = 'pie',
        hole = 0.4, textinfo = 'label+percent', insidetextorientation = 'radial',
        marker = list(line = list(color = '#FFFFFF', width = 1))) %>%
  layout(title = 'Employee Marital Status Distribution',
         showlegend = TRUE)


#### Autre graphique


# Summarize data to count the number of employees by Age Group and Gender
age_gender_distribution <- employee_data %>%
  group_by(AgeGroup, Gender) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  arrange(AgeGroup)

# Plotting the bar chart
plot_ly(age_gender_distribution, x = ~AgeGroup, y = ~Count, 
        color = ~Gender, type = 'bar') %>%
  layout(title = 'Employees by Age Group and Gender',
         xaxis = list(title = 'Age Group'),
         yaxis = list(title = 'Number of Employees'),
         barmode = 'stack',
         legend = list(title = list(text = 'Gender')))



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Summarize data to calculate total employees and average salary by ethnicity
ethnicity_summary <- employee_data %>%
  group_by(Ethnicity) %>%
  summarise(
    TotalEmployees = n(),
    AverageSalary = mean(Salary, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  arrange(desc(TotalEmployees))  # Order by Total Employees in descending order

# Ensure the ordering affects the x-axis on the plot by reordering the factor levels
ethnicity_summary$Ethnicity <- factor(ethnicity_summary$Ethnicity, levels = ethnicity_summary$Ethnicity)

# Plotting the bar chart for Total Employees and line plot for Average Salary
plot <- plot_ly() %>%
  add_bars(data = ethnicity_summary, x = ~Ethnicity, y = ~TotalEmployees, name = 'Total Employees',
           marker = list(color = 'rgba(55, 128, 191, 0.7)'), text = ~TotalEmployees, textposition = 'auto') %>%
  add_lines(data = ethnicity_summary, x = ~Ethnicity, y = ~AverageSalary, name = 'Average Salary',
            yaxis = 'y2', line = list(color = 'red', width = 2)) %>%
  layout(title = 'Employees and Average Salary by Ethnicity',
         xaxis = list(title = 'Ethnicity', tickangle = -45),
         yaxis = list(title = 'Total Employees', side = 'left', rangemode = "tozero"),
         yaxis2 = list(title = 'Average Salary ($)', overlaying = 'y', side = 'right', rangemode = "tozero"),
         legend = list(orientation = 'h', x = 0.3, y = 1.1))
plot



# Load necessary libraries
library(readr)


# Compute the age of the youngest and oldest employees
youngest_age <- min(employee_data$Age, na.rm = TRUE)
oldest_age <- max(employee_data$Age, na.rm = TRUE)

# Print the results
cat("Age of the youngest employee: ", youngest_age, "\n")
cat("Age of the oldest employee: ", oldest_age, "\n")




########################################### PERFORMANCE TRACK ###############################

# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


first_name = "Estelle" 
last_name = "Chung"

# Join employee data with performance data
full_data <- employee_data %>%
  inner_join(performance_rating, by = "EmployeeID") %>%
  filter(FirstName == first_name & LastName == last_name)

# Assuming 'ReviewDate' is the date of the job satisfaction rating and 'JobSatisfaction' contains the rating
# Convert ReviewDate to Date type if it's not already
full_data$ReviewDate <- as.Date(full_data$ReviewDate, format = "%m/%d/%Y")

# Plotting job satisfaction over time
plot <- plot_ly(full_data, x = ~ReviewDate, y = ~JobSatisfaction, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'blue')) %>%
  layout(title = 'Job Satisfaction Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Job Satisfaction Rating'))
plot


# Filter for Relationship Satisfaction data
relationship_data <- full_data %>%
  select(ReviewDate, RelationshipSatisfaction) %>%
  arrange(ReviewDate)  # Optional: arrange by date if not already sorted

# Plotting relationship satisfaction over time
plot <- plot_ly(relationship_data, x = ~ReviewDate, y = ~RelationshipSatisfaction, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'blue')) %>%
  layout(title = 'Relationship Satisfaction Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Relationship Satisfaction Rating'))
plot


# Filter for Self Rating data
self_rating_data <- full_data %>%
  select(ReviewDate, SelfRating) %>%
  arrange(ReviewDate)  # Optional: arrange by date if not already sorted

# Plotting self-rating over time
plot <- plot_ly(self_rating_data, x = ~ReviewDate, y = ~SelfRating, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'red')) %>%
  layout(title = 'Self-Rating Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Self-Rating'),
         yaxis2 = list(title = 'Self-Rating Scale', overlaying = 'y', side = 'right'))
plot


# Filter for Environment Satisfaction data
env_satisfaction_data <- full_data %>%
  select(ReviewDate, EnvironmentSatisfaction) %>%
  arrange(ReviewDate)  # Optional: arrange by date if not already sorted

# Plotting environment satisfaction over time
plot <- plot_ly(env_satisfaction_data, x = ~ReviewDate, y = ~EnvironmentSatisfaction, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'green')) %>%
  layout(title = 'Environment Satisfaction Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Environment Satisfaction Rating'))
plot


# Filter for Work Life Balance data
work_life_data <- full_data %>%
  select(ReviewDate, WorkLifeBalance) %>%
  arrange(ReviewDate)  # Arrange by date if not already sorted

# Plotting work-life balance over time
plot <- plot_ly(work_life_data, x = ~ReviewDate, y = ~WorkLifeBalance, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'purple')) %>%
  layout(title = 'Work Life Balance Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Work Life Balance Rating'))
plot


# Filter for Manager Rating data
manager_rating_data <- full_data %>%
  select(ReviewDate, ManagerRating) %>%
  arrange(ReviewDate)  # Arrange by date if not already sorted

# Plotting manager rating over time
plot <- plot_ly(manager_rating_data, x = ~ReviewDate, y = ~ManagerRating, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'blue')) %>%
  layout(title = 'Manager Rating Over Time for Estelle Chung',
         xaxis = list(title = 'Review Date'),
         yaxis = list(title = 'Manager Rating'),
         yaxis2 = list(title = 'Rating Scale', overlaying = 'y', side = 'right'))
plot


# Legende
satisfied_level

rating_level


# Extract Estelle Chung's employee data
estelle_data <- employee_data %>%
  filter(FirstName == first_name & LastName == last_name)

# Extract Estelle Chung's performance reviews
estelle_reviews <- performance_rating %>%
  filter(EmployeeID == estelle_data$EmployeeID)

# Convert ReviewDate to Date type assuming they are stored as numeric days since origin
estelle_reviews$ReviewDate <- as.Date(estelle_reviews$ReviewDate, format = "%m/%d/%Y", origin = "1970-01-01")

# Determine the Start Date, Last Review, and calculate the Next Review
start_date <- estelle_data$HireDate
last_review <- max(estelle_reviews$ReviewDate, na.rm = TRUE)
# Assuming reviews are annual for next review calculation
library(lubridate)
next_review <- last_review %m+% years(1)  # Adds one year to the last review date

# Output the dates
print(start_date)
print(last_review)
print(next_review)


#################################### ATTRITION #################################################
# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Concatenate Department and JobRole into a single variable
employee_data <- employee_data %>%
  mutate(DepartmentJobRole = paste(Department, JobRole, sep = " - "))

# Calculate the Attrition Rate by Department and Job Role
attrition_summary <- employee_data %>%
  group_by(DepartmentJobRole) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = (AttritionCount / TotalEmployees) * 100,
    .groups = 'drop'
  ) %>%
  arrange(desc(AttritionRate))  # Sort by attrition rate in descending order

# Plotting the bar chart
plot <- plot_ly(attrition_summary, x = ~reorder(DepartmentJobRole, -AttritionRate), y = ~AttritionRate, type = 'bar',
                #text = ~paste("Attrition Rate: ", round(AttritionRate, 2), "%"),
                textposition = 'auto',
                marker = list(color = 'rgba(255, 99, 71, 0.7)')) %>%
  layout(title = 'Attrition Rate by Department and Job Role',
         xaxis = list(title = 'Department - Job Role', tickangle = -45),
         yaxis = list(title = 'Attrition Rate (%)'))
plot


# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)

# Ensure HireDate is in the correct date format
#employee_data$HireDate <- as.Date(employee_data$HireDate, origin = "1970-01-01")

# Summarize data to calculate the attrition rate by year of hire date
attrition_rate_by_year <- employee_data %>%
  mutate(Year = year(HireDate)) %>%
  group_by(Year) %>%
  summarise(
    TotalHired = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = (AttritionCount / TotalHired) * 100,
    .groups = 'drop'
  ) %>%
  arrange(Year)  # Sort by Year

# Plotting the line plot for attrition rate by year of hire date
plot <- plot_ly(attrition_rate_by_year, x = ~Year, y = ~AttritionRate, type = 'scatter', mode = 'lines+markers',
                line = list(color = 'green')) %>%
  layout(title = 'Attrition Rate by Year of Hire Date',
         xaxis = list(title = 'Year of Hire'),
         yaxis = list(title = 'Attrition Rate (%)'))
plot



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Summarize data to calculate the attrition rate and total employees by Business Travel
travel_summary <- employee_data %>%
  group_by(BusinessTravel) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = (AttritionCount / TotalEmployees) * 100,
    .groups = 'drop'
  ) %>%
  arrange(desc(AttritionRate))  # Optional: sort by attrition rate

# Plotting the combined chart
plot <- plot_ly() %>%
  add_bars(data = travel_summary, x = ~BusinessTravel, y = ~AttritionRate, name = 'Attrition Rate (%)',
           marker = list(color = 'rgba(255, 99, 71, 0.6)')) %>%
  add_lines(data = travel_summary, x = ~BusinessTravel, y = ~TotalEmployees, name = 'Total Employees',
            line = list(color = 'blue'), yaxis = 'y2') %>%
  layout(title = 'Attrition and Total Employees by Business Travel Frequency',
         xaxis = list(title = 'Business Travel'),
         yaxis = list(title = 'Attrition Rate (%)', side = 'left'),
         yaxis2 = list(title = 'Total Employees', overlaying = 'y', side = 'right', showgrid = FALSE),
         barmode = 'group',
         legend = list(x = 0.1, y = 1.1, orientation = "h"))
plot


# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Summarize data to calculate the attrition rate by Overtime status
overtime_summary <- employee_data %>%
  group_by(OverTime) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = (AttritionCount / TotalEmployees) * 100,
    .groups = 'drop'
  ) %>%
  arrange(desc(AttritionRate))  # Sort by attrition rate in descending order

# Plotting the bar chart
plot <- plot_ly(overtime_summary, x = ~OverTime, y = ~AttritionRate, type = 'bar',
                marker = list(color = 'rgba(55, 128, 191, 0.7)'),
                #text = ~paste(round(AttritionRate, 2), "%"),
                textposition = 'auto') %>%
  layout(title = 'Attrition Rate by Overtime Requirement',
         xaxis = list(title = 'Overtime Requirement'),
         yaxis = list(title = 'Attrition Rate (%)'))
plot



# Load necessary libraries
library(readr)
library(dplyr)
library(plotly)


# Summarize data to calculate the attrition rate by years at the company
tenure_summary <- employee_data %>%
  group_by(YearsAtCompany) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = (AttritionCount / TotalEmployees) * 100,
    .groups = 'drop'
  ) %>%
  arrange(YearsAtCompany)  # Sort by years at company for better visualization

# Plotting the bar chart
plot <- plot_ly(tenure_summary, x = ~YearsAtCompany, y = ~AttritionRate, type = 'bar',
                marker = list(color = 'rgba(55, 128, 191, 0.7)'),
                #text = ~paste(round(AttritionRate, 2), "%"),
                textposition = 'auto') %>%
  layout(title = 'Attrition Rate by Tenure (Years at Company)',
         xaxis = list(title = 'Years at Company'),
         yaxis = list(title = 'Attrition Rate (%)'),
         barmode = 'group')
plot


library(dplyr)
library(highcharter)


# Calculate the attrition rate by state and department
attrition_data <- employee_data %>%
  group_by(State, Department) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = round((AttritionCount / TotalEmployees) * 100, 1),
    .groups = 'drop'
  )

# Creating the treemap with Highcharter
tree_map <- attrition_data %>%
  hchart(
    "treemap",
    hcaes(
      x = interaction(State, Department), 
      value = AttritionRate, 
      color = AttritionRate
    ),
    layoutAlgorithm = 'squarified'
  )

tree_map

# Print the treemap
treemap



# Calculate the attrition rate by state and education field
attrition_data <- employee_data %>%
  group_by(State, EducationField) %>%
  summarise(
    TotalEmployees = n(),
    AttritionCount = sum(Attrition == "Yes"),
    AttritionRate = round((AttritionCount / TotalEmployees) * 100, 1),
    .groups = 'drop'
  )

# Creating the treemap with Highcharter
tree_map <- attrition_data %>%
  hchart(
    "treemap",
    hcaes(
      x = interaction(State, EducationField), 
      value = AttritionRate, 
      color = AttritionRate
    ),
    layoutAlgorithm = 'squarified'
  )

tree_map

# Print the treemap
treemap
