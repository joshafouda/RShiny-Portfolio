# Movie Analysis Dashboard

## Overview
The **Movie Analysis Dashboard** is an R Shiny application designed to analyze and visualize trends in the movie industry. By leveraging interactive visualizations and aggregated data insights, this dashboard provides a detailed look into movie genres, ratings, release patterns, and rental behaviors.

### Key Features
- **Genre Analysis**:
  - Explore the distribution of movies by genre using a dynamic bar chart.
- **Rating Trends**:
  - Heatmaps illustrating average ratings segmented by country and genre.
- **Release Year Insights**:
  - Flexible visualizations for analyzing release year distributions, average ratings, rental prices, and rental counts.
- **Rental Patterns**:
  - Heatmaps detailing rental counts by country and year of release.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Built an intuitive and responsive user interface using modular components.
   - Incorporated dynamic inputs and outputs to cater to user-defined visualizations.

2. **SQL Query Integration**:
   - Executed complex SQL queries to aggregate and retrieve data efficiently.
   - Implemented multi-level aggregation for country, genre, and release year.

3. **Data Visualization**:
   - Created engaging and interactive plots using `plotly`.
   - Utilized heatmaps, bar charts, and line plots to represent multi-dimensional data.

4. **Data Wrangling**:
   - Processed large datasets with precision using `dplyr` for summarization and mutation.

5. **User-Centric Design**:
   - Developed a dashboard with a clear layout and customizable options, ensuring a seamless user experience.

## Application Structure
### User Interface (UI)
The UI features:
- **Genre and Rating Analysis**:
  - Plots showcasing movie counts by genre and average ratings segmented by country and genre.
- **Release Year Insights**:
  - Dropdown for selecting specific visualizations related to release years.
  - Plots analyzing release year distributions, ratings, and rental patterns.
- **Rental Patterns**:
  - Heatmaps for rentals across countries and release years.

### Server Logic
The server processes:
- SQL queries to retrieve and aggregate data dynamically based on user inputs.
- Plotly visualizations rendered reactively to reflect user selections.
- Advanced data aggregations, including unioned queries for multiple levels of granularity.

## How to Use
1. **Analyze Genres**:
   - View the number of movies categorized by genre.

2. **Explore Ratings**:
   - Analyze average ratings across countries and genres using a heatmap.

3. **Dive into Release Patterns**:
   - Select visualization types such as:
     - Movie release year distribution.
     - Average ratings by year.
     - Rental prices by release year.
     - Number of rentals by release year.

4. **Understand Rental Behaviors**:
   - Use heatmaps to view rental counts segmented by country and year.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `DBI`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "dplyr", "plotly", "DBI"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**[Your Name]**
[LinkedIn](https://www.linkedin.com/)

## Screenshots
### Genre Analysis
![Genre Analysis Screenshot](path/to/screenshot1.png)

### Rating Trends
![Rating Trends Screenshot](path/to/screenshot2.png)

### Release Year Insights
![Release Year Insights Screenshot](path/to/screenshot3.png)

## Conclusion
The **Movie Analysis Dashboard** showcases robust capabilities in data visualization and user interaction. It is an excellent demonstration of R Shiny's potential for creating data-driven applications and is a valuable tool for understanding movie industry trends. Feel free to reach out for collaboration or inquiries!

