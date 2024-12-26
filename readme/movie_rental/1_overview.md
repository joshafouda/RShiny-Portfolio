# Overview Dashboard

## Overview
The **Overview Dashboard** is an R Shiny application providing high-level insights into a movie rental business. It includes a summary of key metrics, revenue trends, and ratings distributions, allowing users to explore important business KPIs interactively.

### Key Features
- **Business KPIs**:
  - Total number of customers, movies, and rentals displayed in value boxes.
- **Revenue Analysis**:
  - Dynamic visualizations of total revenue aggregated by day, month, or year.
  - Average monthly revenue trends across the year.
- **Ratings and Revenue by Country**:
  - A detailed analysis of revenue and average ratings distribution across countries.
- **Ratings Distribution**:
  - A histogram displaying the distribution of ratings provided by customers.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Designed a clean, responsive dashboard interface.
   - Implemented modular and scalable code to support dynamic data visualizations.

2. **SQL Query Optimization**:
   - Crafted SQL queries to aggregate and retrieve data efficiently for various analyses.
   - Integrated multi-level groupings for insights by time and geography.

3. **Data Visualization**:
   - Leveraged `plotly` for interactive plots, including scatter plots, bar charts, and histograms.
   - Used `ggplot2` for visually appealing and customizable static visualizations.

4. **Business Analytics**:
   - Focused on actionable insights like revenue trends, customer ratings, and performance by country.

## Application Structure
### User Interface (UI)
The UI includes:
- **KPI Value Boxes**:
  - Summaries for total customers, movies, and rentals.
- **Revenue and Ratings Visualizations**:
  - Plots for revenue trends over time and country-wise analysis of revenue and ratings.
- **Ratings Distribution**:
  - A histogram to explore the distribution of customer ratings.

### Server Logic
The server processes:
- SQL queries to retrieve aggregated data based on user inputs.
- Dynamic visualizations with `plotly` and `ggplot2`.
- Logic to switch between different time granularities for revenue analysis.

## How to Use
1. **Explore Key Metrics**:
   - View total customers, movies, and rentals in the value boxes.

2. **Analyze Revenue Trends**:
   - Select a time aggregation level (day, month, or year) to visualize revenue trends dynamically.
   - Explore average monthly revenue trends in a bar chart.

3. **Revenue and Ratings by Country**:
   - Understand how revenue and average ratings vary across different countries.

4. **Ratings Distribution**:
   - Examine the distribution of customer ratings through an interactive histogram.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `DBI`
  - `ggplot2`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "dplyr", "plotly", "DBI", "ggplot2"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**[Your Name]**
[LinkedIn](https://www.linkedin.com/)

## Screenshots
### KPI Overview
![KPI Overview Screenshot](path/to/screenshot1.png)

### Revenue Trends
![Revenue Trends Screenshot](path/to/screenshot2.png)

### Ratings Distribution
![Ratings Distribution Screenshot](path/to/screenshot3.png)

## Conclusion
The **Overview Dashboard** provides a concise yet comprehensive analysis of a movie rental business, highlighting essential metrics and trends. It is a powerful tool for decision-making and demonstrates advanced R Shiny and data visualization skills. Feel free to reach out for collaboration or inquiries!

