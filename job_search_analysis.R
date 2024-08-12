# Load necessary libraries
library(readr)

# Define the file path
file_path <- "data/job_postings.csv"

# Import the dataset
job_postings <- read_csv(file_path)

# Display the first few rows of the dataset
View(job_postings)


# Check for missing values
missing_values <- sapply(job_postings, function(x) sum(is.na(x)))
print(missing_values)


# Handle missing values
# For simplicity, let's fill NAs in numeric fields with zeros and text fields with "Unknown"
library(dplyr)
job_postings_clean <- job_postings %>%
  mutate(
    `Minimum Pay` = ifelse(is.na(`Minimum Pay`), 0, `Minimum Pay`),
    `Maximum Pay` = ifelse(is.na(`Maximum Pay`), 0, `Maximum Pay`),
    `Number of Applicants` = ifelse(is.na(`Number of Applicants`), 0, `Number of Applicants`),
    `Job Title Additional Info` = ifelse(is.na(`Job Title Additional Info`), "Unknown", `Job Title Additional Info`),
    `Pay Rate` = ifelse(is.na(`Pay Rate`), "Unknown", `Pay Rate`),
    `Company Name` = ifelse(is.na(`Company Name`), "Unknown", `Company Name`),
    `Company Industry` = ifelse(is.na(`Company Industry`), "Unknown", `Company Industry`),
    `Company Size` = ifelse(is.na(`Company Size`), "Unknown", `Company Size`),
    `Job Skills` = ifelse(is.na(`Job Skills`), "Unknown", `Job Skills`)
  )

# Standardize text fields by converting to lowercase
library(stringr)
job_postings_clean <- job_postings_clean %>%
  mutate(
    `Job Title` = str_to_lower(`Job Title`),
    `Job Location` = str_to_lower(`Job Location`),
    `Company Name` = str_to_lower(`Company Name`),
    `Company Industry` = str_to_lower(`Company Industry`),
    `Company Size` = str_to_lower(`Company Size`),
    `Job Skills` = str_to_lower(`Job Skills`),
    `Pay Rate` = str_to_lower(`Pay Rate`),
    `Job Title Additional Info` = str_to_lower(`Job Title Additional Info`)
  )

# Display the first few rows of the cleaned dataset
View(job_postings_clean)


# Load necessary libraries
library(plotly)
library(dplyr)

# Filter the dataset for relevant job titles
job_titles <- c('data analyst', 'data engineer', 'data scientist')

# Count the occurrences of each job title
job_counts <- job_postings_clean %>%
  filter(`Job Title` %in% job_titles) %>%
  count(`Job Title`)

# Create a donut chart using Plotly
fig <- plot_ly(
  data = job_counts,
  labels = ~`Job Title`,
  values = ~n,
  type = 'pie',
  hole = 0.4,
  textinfo = 'label+percent'
) %>%
  layout(
    title = 'Distribution of Data Analyst, Data Engineer, and Data Scientist Jobs',
    showlegend = TRUE
  )

# Display the chart
fig


# Load necessary libraries
library(plotly)
library(dplyr)

# Calculate average salary and prepare data for plotting
salary_data <- job_postings_clean %>%
  filter(`Minimum Pay` > 0 & `Maximum Pay` > 0) %>% # Filter out entries without pay info
  mutate(Average_Salary = (`Minimum Pay` + `Maximum Pay`) / 2) %>%
  group_by(`Job Position Level`, `Years of Experience`) %>%
  summarise(Average_Salary = mean(Average_Salary, na.rm = TRUE)) %>%
  ungroup()

# Create a plotly line chart
fig <- plot_ly(
  data = salary_data,
  x = ~`Years of Experience`,
  y = ~Average_Salary,
  color = ~`Job Position Level`,
  type = 'scatter',
  mode = 'lines+markers',
  text = ~paste('Level:', `Job Position Level`, '<br>Years of Experience:', `Years of Experience`, '<br>Average Salary:', round(Average_Salary, 2))
) %>%
  layout(
    title = "Average Salary Expectations Based on Years of Experience",
    xaxis = list(title = "Years of Experience"),
    yaxis = list(title = "Average Salary"),
    legend = list(title = list(text = '<b>Job Position Level</b>'))
  )

# Display the chart
fig


# Load necessary libraries
library(plotly)
library(dplyr)

# Calculate average years of experience per industry and job position level
experience_data <- job_postings_clean %>%
  group_by(`Company Industry`, `Job Position Level`) %>%
  summarise(Average_Years_of_Experience = mean(`Years of Experience`, na.rm = TRUE)) %>%
  ungroup()

# Create a plotly bar chart 8le graphique est trop compliqué à interpréter)
fig <- plot_ly(
  data = experience_data,
  x = ~`Company Industry`,
  y = ~Average_Years_of_Experience,
  color = ~`Job Position Level`,
  type = 'bar',
  text = ~paste('Industry:', `Company Industry`, '<br>Level:', `Job Position Level`, '<br>Avg. Years of Experience:', round(Average_Years_of_Experience, 2)),
  hoverinfo = 'text'
) %>%
  layout(
    title = "Average Years of Experience per Industry for Each Job Position Level",
    xaxis = list(title = "Industry", tickangle = -45),
    yaxis = list(title = "Average Years of Experience"),
    barmode = 'group',
    legend = list(title = list(text = '<b>Job Position Level</b>')),
    margin = list(b = 150)
  )

# Display the chart
fig


# Load necessary libraries
library(plotly)
library(dplyr)
library(lubridate) # for date manipulation

# Prepare the data for plotting
time_series_data <- job_postings_clean %>%
  group_by(`Job Position Level`, Month = floor_date(`Job Posting Date`, "month")) %>%
  summarise(Number_of_Jobs = n(), .groups = 'drop') %>%
  arrange(Month)

# Create a plotly line chart
fig <- plot_ly(
  data = time_series_data,
  x = ~Month,
  y = ~Number_of_Jobs,
  color = ~`Job Position Level`,
  type = 'scatter',
  mode = 'lines+markers',
  hoverinfo = 'text',
  text = ~paste('Date:', Month, '<br>Level:', `Job Position Level`, '<br>Number of Jobs:', Number_of_Jobs)
) %>%
  layout(
    title = "Number of Available Jobs Over Time by Job Position Level",
    xaxis = list(title = "Time"),
    yaxis = list(title = "Number of Jobs"),
    legend = list(title = list(text = '<b>Job Position Level</b>'))
  )

# Display the chart
fig


# reprendre le mèème graphique pour le type d'industrie

# Prepare the data for plotting
time_series_data2 <- job_postings_clean %>%
  group_by(`Company Industry`, Month = floor_date(`Job Posting Date`, "month")) %>%
  summarise(Number_of_Jobs = n(), .groups = 'drop') %>%
  arrange(Month)

# Create a plotly line chart
fig <- plot_ly(
  data = time_series_data2,
  x = ~Month,
  y = ~Number_of_Jobs,
  color = ~`Company Industry`,
  type = 'scatter',
  mode = 'lines+markers',
  hoverinfo = 'text',
  text = ~paste('Date:', Month, '<br>Level:', `Company Industry`, '<br>Number of Jobs:', Number_of_Jobs)
) %>%
  layout(
    title = "Number of Available Jobs Over Time by Company Industry",
    xaxis = list(title = "Time"),
    yaxis = list(title = "Number of Jobs"),
    legend = list(title = list(text = '<b>Company Industry</b>'))
  )

# Display the chart
fig


# Load necessary libraries
library(plotly)
library(dplyr)
library(tidyr)
library(stringr)
library(tidyr)

# Data preparation
# Assuming 'job_postings' is your dataframe and 'Job Skills' is the column with skills listed, separated by commas
skills_data <- job_postings_clean %>%
  # Pull out the skills column, separate each skill, and make sure everything is counted individually
  mutate(Skills = str_to_lower(`Job Skills`)) %>% # Convert to lower case to ensure consistency
  separate_rows(Skills, sep = ',\\s*') %>%
  count(Skills, sort = TRUE) %>%
  filter(n > 50) # Filter to show only skills mentioned more than 50 times for better visualization

# Create a Plotly bar chart
fig <- plot_ly(
  data = skills_data,
  x = ~n,
  y = ~Skills,
  type = 'bar',
  orientation = 'h', # Horizontal bars
  hoverinfo = 'x+y',
  marker = list(color = 'rgba(50, 171, 96, 0.6)')
) %>%
  layout(
    title = "Most Demanded Skills in the Job Market",
    xaxis = list(title = "Frequency of Mention"),
    yaxis = list(title = "Skills", automargin = TRUE),
    hovermode = 'closest'
  )

# Display the chart
fig


# Load necessary libraries
library(plotly)
library(dplyr)
library(tidyr)
library(stringr)

# Data preparation by industry
industry_skills_data <- job_postings_clean %>%
  select(`Company Industry`, `Job Skills`) %>%
  mutate(`Job Skills` = str_to_lower(`Job Skills`)) %>%
  separate_rows(`Job Skills`, sep = ',\\s*') %>%
  count(`Company Industry`, `Job Skills`, sort = TRUE) %>%
  group_by(`Company Industry`) %>%
  top_n(5, n) %>%
  ungroup()

# Create a Plotly bar chart
fig_industry <- plot_ly(
  data = industry_skills_data,
  x = ~`Job Skills`,
  y = ~n,
  color = ~`Company Industry`,
  type = 'bar',
  hoverinfo = 'y+text',
  text = ~paste('Industry:', `Company Industry`, '<br>Count:', n)
) %>%
  layout(
    title = "Top Demanded Skills by Industry",
    xaxis = list(title = "Skills"),
    yaxis = list(title = "Frequency of Mention"),
    barmode = 'group',
    legend = list(title = list(text = '<b>Industry</b>'))
  )

# Display the chart
fig_industry



# Data preparation by job title
title_skills_data <- job_postings_clean %>%
  select(`Job Title`, `Job Skills`) %>%
  mutate(`Job Skills` = str_to_lower(`Job Skills`)) %>%
  separate_rows(`Job Skills`, sep = ',\\s*') %>%
  count(`Job Title`, `Job Skills`, sort = TRUE) %>%
  group_by(`Job Title`) %>%
  top_n(5, n) %>%
  ungroup()

# Create a Plotly bar chart
fig_title <- plot_ly(
  data = title_skills_data,
  x = ~`Job Skills`,
  y = ~n,
  color = ~`Job Title`,
  type = 'bar',
  hoverinfo = 'y+text',
  text = ~paste('Job Title:', `Job Title`, '<br>Count:', n)
) %>%
  layout(
    title = "Top Demanded Skills by Job Title",
    xaxis = list(title = "Skills"),
    yaxis = list(title = "Frequency of Mention"),
    barmode = 'group',
    legend = list(title = list(text = '<b>Job Title</b>'))
  )

# Display the chart
fig_title
