# Movie Rental Analysis Dashboard

## Overview
The **Movie Rental Analysis Dashboard** is a comprehensive R Shiny application designed to provide actionable insights into the operations and trends of a movie rental business. This dashboard is divided into four interconnected sub-dashboards:

1. **Overview Dashboard**: High-level business metrics and trends.
2. **Customer Analysis Dashboard**: Insights into customer demographics and behavior.
3. **Movie Analysis Dashboard**: In-depth exploration of movie-related metrics and trends.
4. **Tables and Trends Dashboard**: Top performers and detailed tabular insights.

This application is a powerful tool for business decision-making, demonstrating advanced R Shiny development, data visualization, and SQL integration.

---

## Key Features

### 1. Overview Dashboard
- **Business KPIs**: Display total customers, movies, and rentals.
- **Revenue Analysis**: Visualize revenue trends by day, month, or year.
- **Ratings and Revenue by Country**: Analyze revenue and average ratings geographically.
- **Ratings Distribution**: Interactive histogram of customer ratings.

### 2. Customer Analysis Dashboard
- **Customer Distribution by Country**: Bar charts showing customers by country.
- **Age-Based Analysis**: Correlate age with spending using scatter plots and histograms.
- **Spending by Gender**: Pie charts to analyze spending patterns by gender.
- **Account Start Year Trends**: Bar charts displaying customer registration trends over time.

### 3. Movie Analysis Dashboard
- **Genre Analysis**: Explore movie distribution by genre.
- **Rating Trends**: Heatmaps of average ratings segmented by country and genre.
- **Release Year Insights**: Visualize release year trends, ratings, and rental behaviors.
- **Rental Patterns**: Heatmaps of rental counts by country and year of release.

### 4. Tables and Trends Dashboard
- **Film Genre Metrics**: Performance metrics for each genre, such as average ratings and rentals.
- **Top Movies**: Top 10 movies by rating with rental counts.
- **Top Actors**: Top 10 actors by ratings and appearances.
- **Top Customers**: Highest-spending customers with demographic details.

---

## Skills Demonstrated

1. **Advanced R Shiny Development**:
   - Modular, scalable design for ease of maintenance and updates.
   - Responsive and intuitive user interface.

2. **SQL Optimization**:
   - Efficient data aggregation and retrieval using complex SQL queries.
   - Multi-level groupings for granular insights.

3. **Data Visualization**:
   - Interactive and engaging visualizations with `plotly` and `ggplot2`.
   - Clear and informative plots for business storytelling.

4. **Data Analysis and Wrangling**:
   - Aggregation and transformation of large datasets.
   - Creation of actionable insights from raw data.

---

## Application Structure

### User Interface (UI)
- **Dynamic Visualizations**: Interactive plots, heatmaps, and pie charts.
- **KPI Boxes and Tables**: Summarized metrics and sortable, searchable tables.
- **Filters and Options**: Dropdowns and toggles for user-driven customization.

### Server Logic
- **Data Retrieval**: SQL queries to fetch and process data dynamically.
- **Reactive Components**: Visualizations and tables update based on user input.
- **Scalability**: Modular architecture for smooth integration of new features.

---

## How to Use

1. **Start the Application**:
   ```R
   shiny::runApp("path-to-app")
   ```

2. **Navigate Between Sub-Dashboards**:
   - Use the menu to switch between "Overview," "Customer Analysis," "Movie Analysis," and "Tables and Trends."

3. **Explore Insights**:
   - Interact with filters and visualizations to analyze specific metrics.
   - Dive into granular details using the tables and heatmaps.

4. **Export and Share**:
   - Export insights for presentations or reporting.

---

## Requirements

### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`, `dplyr`, `plotly`, `ggplot2`, `DT`, `DBI`

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required packages:
   ```R
   install.packages(c("shiny", "dplyr", "plotly", "ggplot2", "DT", "DBI"))
   ```

3. Run the application as described above.

---

## Screenshots
Include representative screenshots for each sub-dashboard to illustrate key features. For example:
- **Overview Dashboard**: KPI boxes and revenue trends.
- **Customer Analysis Dashboard**: Spending by gender pie chart.
- **Movie Analysis Dashboard**: Genre analysis bar chart.
- **Tables and Trends Dashboard**: Top customers table.

---

## Author

[Josué A.](https://www.linkedin.com/in/josu%C3%A9-afouda/)  

---

## Conclusion
The **Movie Rental Analysis Dashboard** is a feature-rich application designed to provide a 360-degree view of a movie rental business. It highlights proficiency in R Shiny, data visualization, SQL integration, and analytics. Whether you are a business looking for actionable insights or a professional seeking innovative R Shiny solutions, this dashboard demonstrates exceptional capability and versatility.

Feel free to reach out for collaboration or inquiries!

