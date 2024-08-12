
# Ajouter les sorties ici

education_level <- read_csv("data/EducationLevel.csv")

employee_data <- read_csv("data/Employee.csv")
# Extract year
employee_data$Year <- format(as.Date(employee_data$HireDate, format = "%Y-%m-%d"), "%Y")
# Add an Age Group column
employee_data <- employee_data %>%
  mutate(AgeGroup = case_when(
    Age < 20 ~ "<20",
    Age >= 20 & Age <= 29 ~ "20-29",
    Age >= 30 & Age <= 39 ~ "30-39",
    Age >= 40 & Age <= 49 ~ "40-49",
    Age >= 50 ~ "50>"
  ))

# Add FullName column
employee_data <- employee_data %>%
  mutate(FullName = paste(FirstName, LastName, sep = " "))


performance_rating <- read_csv("data/PerformanceRating.csv")

# Join employee data with performance data
full_data <- employee_data %>%
  inner_join(performance_rating, by = "EmployeeID") 

# Assuming 'ReviewDate' is the date of the job satisfaction rating and 'JobSatisfaction' contains the rating
# Convert ReviewDate to Date type if it's not already
full_data$ReviewDate <- as.Date(full_data$ReviewDate, format = "%m/%d/%Y")

rating_level <- read_csv("data/RatingLevel.csv")
satisfied_level <- read_csv("data/SatisfiedLevel.csv")

total_employees <- nrow(employee_data)
total_active_employees <- sum(employee_data$Attrition == "No")
total_inactive_employees <- sum(employee_data$Attrition == "Yes")
attrition_rate <- total_inactive_employees / total_employees * 100

# Compute the age of the youngest and oldest employees
youngest_age <- min(employee_data$Age, na.rm = TRUE)
oldest_age <- max(employee_data$Age, na.rm = TRUE)

# Overview Metrics Outputs
output$TotalEmployees <- renderValueBox({
  valueBox(total_employees, "Total Employees", icon = icon("users"))
})

output$ActiveEmployees <- renderValueBox({
  valueBox(total_active_employees, "Active Employees", icon = icon("users"))
})

output$InactiveEmployees <- renderValueBox({
  valueBox(total_inactive_employees, "Inactive Employees", icon = icon("walking"))
})

output$GloablAttritionRate <- renderValueBox({
  valueBox(paste(round(attrition_rate, 2), "%"), "Gloabl Attrition Rate", icon = icon("percent"))
})

# EmployeeHiringTrends

output$EmployeeHiringTrends <- renderPlotly({
  
  # We'll extract the year from 'HireDate' and summarize the data
  employee_summary <- employee_data %>%
    group_by(Year, Attrition) %>%
    summarise(TotalEmployees = n(), .groups = 'drop')
  
  # Create the plot with Plotly
  plot_ly(employee_summary, x = ~Year, y = ~TotalEmployees, 
          color = ~Attrition, type = 'bar', 
          #text = ~paste("Total: ", TotalEmployees),
          hoverinfo = 'text', colors = c("green", "black")) %>%
    layout(yaxis = list(title = 'Total Employees'),
           barmode = 'stack',
           title = 'Employee Hiring Trends',
           xaxis = list(title = 'Year'),
           legend = list(title = list(text = 'Attrition'), orientation = "h"))
  
})

# ActiveEmployeesDepartment

output$ActiveEmployeesDepartment <- renderPlotly({
  
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
  
})

# ActiveEmployeesDepartmentJobRole

output$ActiveEmployeesDepartmentJobRole <- renderPlotly({
  
  # Filtering active employees (assuming 'Attrition' column has "No" for active employees)
  summary_table <- employee_data %>%
    filter(Attrition == "No") %>%
    group_by(Department, JobRole) %>%
    summarise(
      nb_employees = n(),
      .groups = 'drop'
    )
  
  plot_department_data(summary_table, input$department)
  
})

# TreeMap
output$TreeMap <- renderHighchart({
  
  # Calculate the attrition rate by state and Education Field
  attrition_data <- employee_data %>%
    group_by(State, EducationField) %>%
    summarise(
      TotalEmployees = n(),
      AttritionCount = sum(Attrition == "Yes"),
      AttritionRate = round((AttritionCount / TotalEmployees) * 100, 1),
      .groups = 'drop'
    )
  
  # Convert state codes to names
  attrition_data$State <- state_codes_to_names(attrition_data$State)
  
  # Transform State column to lowercase
  attrition_data$State <- tolower(attrition_data$State)
  
  # Make sure there are no NA values after conversion
  attrition_data <- attrition_data %>%
    filter(!is.na(State))
  
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
  
})

###################################### Demographics ########################

output$YoungestEmployee <- renderValueBox({
  valueBox(youngest_age, "Youngest Employee", icon = icon("child"))
})

output$OldestEmployee <- renderValueBox({
  valueBox(oldest_age, "Oldest Employee", icon = icon("user-tie"))
})

output$EmployeesByAge <- renderPlotly({
  
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
})

output$EmployeesByAgeAndGender <- renderPlotly({
  
  # Summarize data to count the number of employees by Age Group and Gender
  age_gender_distribution <- employee_data %>%
    group_by(AgeGroup, Gender) %>%
    summarise(Count = n(), .groups = 'drop') %>%
    arrange(AgeGroup)
  
  # Plotting the bar chart
  plot_ly(age_gender_distribution, x = ~Count, y = ~AgeGroup,
                  color = ~Gender, type = 'bar', orientation = 'h') %>%
    layout(title = 'Employees by Age Group and Gender',
           xaxis = list(title = 'Number of Employees'),
           yaxis = list(title = 'Age Group'),
           barmode = 'stack',
           legend = list(title = list(text = 'Gender')))
  
})

output$EmployeesByMarital <- renderPlotly({
  
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
  
})

output$EmployeesEthnicitySalary <- renderPlotly({
  
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
  plot_ly() %>%
    add_bars(data = ethnicity_summary, x = ~Ethnicity, y = ~TotalEmployees, name = 'Total Employees',
             marker = list(color = 'rgba(55, 128, 191, 0.7)'), text = ~TotalEmployees, textposition = 'auto') %>%
    add_lines(data = ethnicity_summary, x = ~Ethnicity, y = ~AverageSalary, name = 'Average Salary',
              yaxis = 'y2', line = list(color = 'red', width = 2)) %>%
    layout(title = 'Employees and Average Salary by Ethnicity',
           xaxis = list(title = 'Ethnicity', tickangle = -45),
           yaxis = list(title = 'Total Employees', side = 'left', rangemode = "tozero"),
           yaxis2 = list(title = 'Average Salary ($)', overlaying = 'y', side = 'right', rangemode = "tozero"),
           legend = list(orientation = 'h', x = 0.3, y = 1.1))
  
})

################################## Performance Tracker ################################

updateSelectInput(
  session, 
  inputId = "select_employee",
  label = "Select Employee",
  choices = unique(full_data$FullName),
  selected = "Estelle Chung"
)

full_selected_employee_data <- reactive({
  
  full_data %>% 
    filter(FullName == input$select_employee)
})

selected_employee_data <- reactive({
  
  employee_data %>% 
    filter(FullName == input$select_employee)
  
})

selected_employee_reviews <- reactive({
  
  reviews <- performance_rating %>% 
    filter(EmployeeID == selected_employee_data()$EmployeeID)
  
  # Convert ReviewDate to Date type assuming they are stored as numeric days since origin
  reviews$ReviewDate <- as.Date(reviews$ReviewDate, format = "%m/%d/%Y", origin = "1970-01-01")
  
  reviews
  
})

output$StartDate <- renderValueBox({
  start_date <- selected_employee_data()$HireDate
  print(start_date)
  valueBox(start_date, "Start Date", icon = icon("calendar-plus"))
})

output$LastReview <- renderValueBox({
  last_review <- max(selected_employee_reviews()$ReviewDate, na.rm = TRUE)
  valueBox(last_review, "Last Review", icon = icon("calendar-check"))
})

output$NextReview <- renderValueBox({
  last_review <- max(selected_employee_reviews()$ReviewDate, na.rm = TRUE)
  next_review <- last_review %m+% years(1)
  valueBox(next_review, "Next Review", icon = icon("clock"))
})

output$legend_perf_table <- renderTable({
  if (input$legend_perf == "Satisfaction") {
    satisfied_level
  } else if (input$legend_perf == "Rating") {
    rating_level
  }
})


output$JobSatisfaction <- renderPlotly({
  
  # Plotting job satisfaction over time
  plot_ly(full_selected_employee_data(), x = ~ReviewDate, y = ~JobSatisfaction, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'blue')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Job Satisfaction Rating'))
  
})

output$EnvironmentSatisfaction <- renderPlotly({
  
  # Filter for Environment Satisfaction data
  env_satisfaction_data <- full_selected_employee_data() %>%
    select(ReviewDate, EnvironmentSatisfaction) %>%
    arrange(ReviewDate)  # Optional: arrange by date if not already sorted
  
  # Plotting environment satisfaction over time
  plot_ly(env_satisfaction_data, x = ~ReviewDate, y = ~EnvironmentSatisfaction, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'green')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Environment Satisfaction Rating'))
  
})

output$RelationshipSatisfaction <- renderPlotly({
  
  # Filter for Relationship Satisfaction data
  relationship_data <- full_selected_employee_data() %>%
    select(ReviewDate, RelationshipSatisfaction) %>%
    arrange(ReviewDate)  # Optional: arrange by date if not already sorted
  
  # Plotting relationship satisfaction over time
  plot_ly(relationship_data, x = ~ReviewDate, y = ~RelationshipSatisfaction, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'blue')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Relationship Satisfaction Rating'))
  
})

output$WorkLifeBalance <- renderPlotly({
  
  # Filter for Work Life Balance data
  work_life_data <- full_selected_employee_data() %>%
    select(ReviewDate, WorkLifeBalance) %>%
    arrange(ReviewDate)  # Arrange by date if not already sorted
  
  # Plotting work-life balance over time
  plot_ly(work_life_data, x = ~ReviewDate, y = ~WorkLifeBalance, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'purple')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Work Life Balance Rating'))
  
})

output$SelfRating <- renderPlotly({
  
  # Filter for Self Rating data
  self_rating_data <- full_selected_employee_data() %>%
    select(ReviewDate, SelfRating) %>%
    arrange(ReviewDate)  # Optional: arrange by date if not already sorted
  
  # Plotting self-rating over time
  plot_ly(self_rating_data, x = ~ReviewDate, y = ~SelfRating, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'red')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Self-Rating'),
           yaxis2 = list(title = 'Self-Rating Scale', overlaying = 'y', side = 'right'))
  
})

output$ManagerRating <- renderPlotly({
  
  # Filter for Manager Rating data
  manager_rating_data <- full_selected_employee_data() %>%
    select(ReviewDate, ManagerRating) %>%
    arrange(ReviewDate)  # Arrange by date if not already sorted
  
  # Plotting manager rating over time
  plot <- plot_ly(manager_rating_data, x = ~ReviewDate, y = ~ManagerRating, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'blue')) %>%
    layout(title = input$select_employee,
           xaxis = list(title = 'Review Date'),
           yaxis = list(title = 'Manager Rating'),
           yaxis2 = list(title = 'Rating Scale', overlaying = 'y', side = 'right'))
  plot
  
})

################################## Attrition ###############################################

output$GlobalAttrition2 <- renderValueBox({
  valueBox(paste(round(attrition_rate, 2), "%"), "% Attrition Rate", icon = icon("percent"))
})

output$AttritionByDepartJob <- renderPlotly({
  
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
  plot_ly(attrition_summary, x = ~reorder(DepartmentJobRole, -AttritionRate), y = ~AttritionRate, type = 'bar',
                  textposition = 'auto',
                  marker = list(color = 'rgba(255, 99, 71, 0.7)')) %>%
    layout(title = 'Attrition Rate by Department and Job Role',
           xaxis = list(title = 'Department - Job Role', tickangle = -45),
           yaxis = list(title = 'Attrition Rate (%)'))
  
})


output$AttritionByHireDate <- renderPlotly({
  
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
  plot_ly(attrition_rate_by_year, x = ~Year, y = ~AttritionRate, type = 'scatter', mode = 'lines+markers',
                  line = list(color = 'green')) %>%
    layout(title = 'Attrition Rate by Year of Hire Date',
           xaxis = list(title = 'Year of Hire'),
           yaxis = list(title = 'Attrition Rate (%)'))
  
})

output$AttritionByTravel <- renderPlotly({
  
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
  plot_ly() %>%
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
  
})

output$AttritionRequirement <- renderPlotly({
  
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
  plot_ly(overtime_summary, x = ~OverTime, y = ~AttritionRate, type = 'bar',
                  marker = list(color = 'rgba(55, 128, 191, 0.7)'),
                  textposition = 'auto') %>%
    layout(title = 'Attrition Rate by Overtime Requirement',
           xaxis = list(title = 'Overtime Requirement'),
           yaxis = list(title = 'Attrition Rate (%)'))
  
})

output$AttritionByTenure <- renderPlotly({
  
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
  plot_ly(tenure_summary, x = ~YearsAtCompany, y = ~AttritionRate, type = 'bar',
                  marker = list(color = 'rgba(55, 128, 191, 0.7)'),
                  #text = ~paste(round(AttritionRate, 2), "%"),
                  textposition = 'auto') %>%
    layout(title = 'Attrition Rate by Tenure (Years at Company)',
           xaxis = list(title = 'Years at Company'),
           yaxis = list(title = 'Attrition Rate (%)'),
           barmode = 'group')
  
})