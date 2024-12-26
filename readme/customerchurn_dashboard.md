# Customer Churn Dashboard

## Overview
The **Customer Churn Dashboard** is an advanced R Shiny application designed to analyze and visualize key metrics related to customer churn. This interactive dashboard helps businesses understand customer behaviors, identify reasons for churn, and uncover trends that can guide retention strategies.

### Key Features
- **Key Performance Indicators (KPIs)**: Real-time metrics such as total customers, churned customers, churn rate, average tenure, and average monthly charges.
- **Dynamic Visualizations**:
  - Churn analysis by account length, contract type, payment method, and demographic factors.
  - Interactive maps showing churn rates by state.
  - Detailed breakdowns of churn reasons and data usage patterns.
- **Comprehensive Data Insights**:
  - Pie charts, bar graphs, and line plots for deep-dive analysis.
  - Dual-axis plots for correlating metrics like churn rate and customer behavior.
- **Geospatial Analysis**: Visualize churn rates across the United States with an interactive map.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Developed an intuitive and responsive dashboard layout.
   - Implemented modular `ui` and `server` components for scalability.

2. **Data Visualization**:
   - Created visually engaging and interactive charts using `plotly` and `leaflet`.
   - Represented complex relationships using multi-dimensional visualizations.

3. **Data Wrangling and Analysis**:
   - Cleaned, transformed, and aggregated data using `dplyr`.
   - Computed essential KPIs and grouped data for meaningful analysis.

4. **Geospatial Mapping**:
   - Developed choropleth maps for state-level churn analysis.
   - Used `sf` and `leaflet` for geospatial visualizations.

5. **Customer Behavior Analysis**:
   - Explored churn factors such as contract type, payment method, and demographics.
   - Highlighted customer service interaction trends with state-wise analysis.

## Application Structure
### User Interface (UI)
The UI features a clean and structured layout with:
- **Metrics Display**: Value boxes summarizing key statistics.
- **Dropdown Menus**: Enable customization of analyses based on selected categories.
- **Graphical Outputs**: Interactive plots and maps for data exploration.

### Server Logic
The server processes inputs and dynamically generates outputs:
- Reactive expressions to handle user-driven data filtering.
- Interactive plots rendered using `plotly` and `ggplot2`.
- Leaflet integration for geospatial mapping.

## How to Use
1. **Explore Key Metrics**:
   - View overall customer statistics, churn rates, and averages using value boxes.

2. **Analyze Churn Factors**:
   - Select a category (e.g., contract type, payment method) to analyze churn distribution.
   - Customize visualizations using dropdowns for specific insights.

3. **View Detailed Visualizations**:
   - Explore reasons for churn, data usage, and age-related trends using charts.
   - Compare churn rates by contract type and account length.

4. **Geospatial Insights**:
   - Visualize churn rates across states with an interactive map.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `leaflet`
  - `ggplot2`
  - `sf`
  - `readr`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "dplyr", "plotly", "leaflet", "ggplot2", "sf", "readr"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**[Your Name]**
[LinkedIn](https://www.linkedin.com/)

## Screenshots
### Dashboard Overview
![Dashboard Screenshot](path/to/screenshot1.png)

### Churn Analysis
![Churn Analysis Screenshot](path/to/screenshot2.png)

### Geospatial Insights
![Geospatial Insights Screenshot](path/to/screenshot3.png)

## Conclusion
The **Customer Churn Dashboard** is a powerful tool for identifying trends and patterns in customer churn. It demonstrates proficiency in data visualization, geospatial analysis, and dashboard development. This project is a great example of using R Shiny for actionable business insights.

Feel free to reach out for collaboration or inquiries!

