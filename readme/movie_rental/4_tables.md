# Tables and Trends Dashboard

## Overview
The **Tables and Trends Dashboard** is an R Shiny application designed to showcase key performance metrics, top performers, and trends in movie rentals. By displaying data in interactive tables, the dashboard provides actionable insights into the movie rental business, including genre performance, customer behavior, and star power.

### Key Features
- **Film Genre Performance Metrics**:
  - Analyze average ratings, number of ratings, rentals, and unique movies by genre.
- **Top 10 Movies by Rating**:
  - View the most highly rated movies with their rental counts and average ratings.
- **Top 10 Actors by Rating**:
  - Discover the top-rated actors based on customer ratings and their number of appearances.
- **Top 10 Customers by Revenue**:
  - Identify the highest spending customers with details like total revenue generated, country, and account start date.

## Skills Demonstrated
1. **Advanced SQL Querying**:
   - Designed complex queries to aggregate data from multiple tables, including `JOIN` operations and filtering by business rules.
   - Utilized `HAVING` clauses to ensure high-quality results, such as ratings with sufficient counts.

2. **R Shiny Development**:
   - Implemented dynamic table outputs using `DT` for interactive data exploration.
   - Designed a clean, modular dashboard layout for an intuitive user experience.

3. **Data Transformation and Analysis**:
   - Summarized data to highlight top performers by key metrics, such as average rating and revenue.
   - Rounded and formatted metrics for better readability and presentation.

4. **User Interaction Design**:
   - Created paginated, searchable, and sortable tables to allow users to focus on specific data subsets.

## Application Structure
### User Interface (UI)
The UI comprises:
- **Film Genre Performance**:
  - A table displaying performance metrics like average ratings, number of rentals, and unique movies by genre.
- **Top Performers**:
  - Tables for:
    - Top-rated movies.
    - Top-rated actors.
    - Top customers by revenue.

### Server Logic
The server processes:
- SQL queries to dynamically retrieve and aggregate data based on specific metrics.
- `DT` tables to render interactive outputs, enabling sorting, searching, and pagination for better data exploration.

## How to Use
1. **Explore Genre Performance**:
   - View metrics such as average ratings, rental counts, and unique movie counts by genre in the table.

2. **Analyze Top Movies**:
   - Check out the top 10 movies by average rating, including their rental counts.

3. **Discover Top Actors**:
   - Examine the top 10 actors based on ratings and their number of views.

4. **Identify Top Customers**:
   - Explore the highest spending customers with details about their demographics and total spending.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `DT`
  - `dplyr`
  - `DBI`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "DT", "dplyr", "DBI"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**[Your Name]**
[LinkedIn](https://www.linkedin.com/)

## Screenshots
### Film Genre Performance Metrics
![Film Genre Performance Screenshot](path/to/screenshot1.png)

### Top Movies and Actors
![Top Movies Screenshot](path/to/screenshot2.png)
![Top Actors Screenshot](path/to/screenshot3.png)

### Top Customers
![Top Customers Screenshot](path/to/screenshot4.png)

## Conclusion
The **Tables and Trends Dashboard** demonstrates expertise in data querying, analysis, and visualization using R Shiny. By highlighting top performers and trends, this dashboard provides valuable insights for strategic decision-making. Feel free to reach out for collaboration or inquiries!

