# HR Analytics Dashboard

## Overview
The **HR Analytics Dashboard** is an advanced R Shiny application that provides insights into employee data, hiring trends, demographics, performance, and attrition. This application is designed to assist HR teams in making data-driven decisions and monitoring key metrics related to workforce management.

### Key Features
1. **Overview Tab**:
   - Visualize total employees, active employees, inactive employees, and global attrition rates.
   - Analyze employee hiring trends over time.
   - Explore active employees by department and job role.
   - Discover attrition trends through a treemap visualization by state and education field.

2. **Demographics Tab**:
   - Analyze the age distribution of employees.
   - View metrics such as the youngest and oldest employees.
   - Study employee breakdown by marital status and ethnicity, with salary comparisons.
   - Explore demographic trends by age group and gender.

3. **Performance Tracker Tab**:
   - Monitor individual employee performance metrics including:
     - Job satisfaction.
     - Work-life balance.
     - Relationship and environment satisfaction.
   - View employee-specific data such as start date, last review, and next review dates.

4. **Attrition Tab**:
   - Analyze attrition rates by department, job role, hire date, travel frequency, overtime requirements, and tenure.
   - Identify key factors contributing to employee turnover.
   - Interactive visualizations for better insights.

## Skills Demonstrated
1. **R Shiny Development**:
   - Designed an intuitive and interactive dashboard with dynamic input fields and real-time data updates.
   - Implemented modular components for scalability.

2. **Data Visualization**:
   - Leveraged `plotly` and `highcharter` for interactive visualizations.
   - Created bar charts, treemaps, donut charts, and scatter plots to visualize workforce trends.

3. **Data Analysis**:
   - Performed statistical analysis to compute metrics such as attrition rate, age distribution, and satisfaction levels.
   - Utilized grouped summaries and conditional calculations using `dplyr`.

4. **HR Metrics Insights**:
   - Analyzed workforce data to provide actionable insights for HR decision-making.
   - Designed visuals to highlight critical factors like attrition and performance.

## Application Structure
### User Interface (UI)
- **Overview Tab**:
  - Display value boxes for employee totals and attrition rates.
  - Interactive charts for hiring trends and employee distributions.

- **Demographics Tab**:
  - Metrics on employee age groups, marital status, and ethnicity.
  - Charts displaying the relationship between demographic factors and salary.

- **Performance Tracker Tab**:
  - Visualize employee satisfaction and performance over time.
  - Provide employee-specific data for monitoring and reviews.

- **Attrition Tab**:
  - Detailed insights into factors affecting employee attrition.
  - Visualizations for attrition trends by tenure, travel frequency, and more.

### Server Logic
- **Reactive Summaries**:
  - Dynamic calculations for metrics like attrition rates, hiring trends, and demographic breakdowns.
  - Reactive inputs to update charts and tables in real-time.

- **Interactive Visualizations**:
  - Bar charts, scatter plots, and treemaps for intuitive data exploration.
  - Interactive features like hover info and filtering by attributes.

## How to Use
1. **Explore Workforce Data**:
   - View employee counts and trends in the Overview tab.
   - Analyze demographic data for insights into workforce composition.

2. **Monitor Employee Performance**:
   - Select individual employees to track their performance metrics.
   - Use satisfaction charts to identify potential areas for improvement.

3. **Analyze Attrition Trends**:
   - Explore factors contributing to attrition.
   - Use visualizations to uncover patterns by department, job role, and tenure.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `highcharter`

## Author

[Josué A.](https://www.linkedin.com/in/josu%C3%A9-afouda/)  


## Conclusion
The **HR Analytics Dashboard** empowers HR teams with actionable insights into workforce trends, performance, and attrition. This dashboard showcases advanced data visualization, interactive analytics, and robust R programming skills. Feel free to reach out for collaboration or inquiries!

