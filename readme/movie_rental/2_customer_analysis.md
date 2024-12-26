# Customer Analysis Dashboard

## Overview
The **Customer Analysis Dashboard** is an R Shiny application designed to provide detailed insights into customer demographics, spending patterns, and account histories. It enables businesses to understand their customer base and uncover trends that can inform targeted strategies for growth and retention.

### Key Features
- **Customer Distribution by Country**:
  - Bar charts showing the distribution of customers across different countries.
- **Age-Based Analysis**:
  - Analyze customer age distribution using histograms.
  - Scatter plots correlating total spending with customer age.
- **Spending by Gender**:
  - Pie charts displaying total spending by gender, with the option to filter by country.
- **Account Start Year Trends**:
  - Bar charts showing the number of customers by the year their accounts were started.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Developed a user-friendly interface with modular components for scalability.
   - Implemented dynamic plots that react to user selections and inputs.

2. **Data Visualization**:
   - Created interactive visualizations using `plotly` and `ggplot2`.
   - Designed histograms, scatter plots, pie charts, and bar charts to communicate insights effectively.

3. **Data Wrangling and Analysis**:
   - Aggregated and processed customer data using SQL queries.
   - Applied advanced filtering and grouping techniques for detailed analysis.

4. **User Interaction Design**:
   - Provided dropdowns and filtering options for customized analysis.
   - Enhanced interactivity with tooltips and hover information in plots.

## Application Structure
### User Interface (UI)
The UI is structured as:
- **Country and Age Analysis**:
  - Distribution of customers by country.
  - Age-related visualizations, including spending correlations.
- **Gender-Based Spending Analysis**:
  - Interactive pie charts for analyzing spending by gender.
- **Account History Trends**:
  - Bar charts showing customer account start year distribution.

### Server Logic
The server:
- Executes SQL queries to retrieve aggregated customer data.
- Processes user inputs to filter data dynamically for visualizations.
- Generates interactive plots with `plotly` for an engaging experience.

## How to Use
1. **Explore Customer Distribution**:
   - View the number of customers across countries using the bar chart.

2. **Analyze Age Trends**:
   - Select "Customer Age Distribution" or "Total Spending vs. Age of Customers" to explore age-related patterns.

3. **Examine Gender-Based Spending**:
   - Select a country or analyze spending for all customers to see the distribution of spending by gender.

4. **Understand Account Start Year Trends**:
   - Explore the distribution of customers by the year they started their accounts.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `ggplot2`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "dplyr", "plotly", "ggplot2"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**[Your Name]**
[LinkedIn](https://www.linkedin.com/)

## Screenshots
### Customer Distribution by Country
![Customer Distribution Screenshot](path/to/screenshot1.png)

### Spending Analysis by Gender
![Spending by Gender Screenshot](path/to/screenshot2.png)

### Account Start Year Trends
![Account Start Year Screenshot](path/to/screenshot3.png)

## Conclusion
The **Customer Analysis Dashboard** is a comprehensive tool for understanding customer behavior and demographics. It demonstrates advanced data visualization, R Shiny development, and data analysis skills, making it a valuable resource for data-driven decision-making. Feel free to reach out for collaboration or inquiries!

