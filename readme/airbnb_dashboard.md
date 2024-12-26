# Airbnb Business Dashboard

The **Airbnb Business Dashboard** is a dynamic and interactive tool built using RShiny and the `shinydashboard` package. It allows users to explore Airbnb data from three major cities: **New York**, **San Francisco**, and **Amsterdam**. The dashboard provides an intuitive interface to analyze neighborhood-specific data, including property prices, types, and geographical distributions. This project highlights data visualization, interactivity, and analytical insights, demonstrating proficiency in R programming, reactive frameworks, and geospatial analysis.

------------------------------------------------------------------------

## Key Features

### 1. **City and Neighborhood Selection**

-   Users can explore data for:
    -   **New York**
    -   **San Francisco**
    -   **Amsterdam**
-   A dropdown menu allows selecting neighborhoods within the chosen city.

### 2. **Interactive Map**

-   Displays the geographical distribution of Airbnb listings within the selected neighborhood using **Leaflet**.
-   Features:
    -   Zoom and pan for a detailed view.
    -   Dynamic updates based on neighborhood selection.

### 3. **Price Analysis**

-   **Average Price:**
    -   Displays the average price of Airbnb listings in the selected neighborhood using a visually appealing **ValueBox**.
-   **Price by Room Type:**
    -   A bar chart, created with **ggplot2** and rendered interactively using **Plotly**, shows the average price for each room type (e.g., private room, shared room, entire home/apartment).

------------------------------------------------------------------------

## Technical Highlights

-   **Reactive Programming:** Utilizes `reactive` expressions for dynamic filtering of city and neighborhood-specific data.
-   **Geospatial Visualization:** Interactive maps generated using the **Leaflet** package.
-   **Data Aggregation and Visualization:**
    -   Aggregated price data by room type using `dplyr`.
    -   Plotted data with `ggplot2` and made it interactive using `Plotly`.
-   **Shiny Modules:** Organized and scalable structure using Shiny's reactivity and modularized components.

------------------------------------------------------------------------

## Code Overview

### UI Implementation

The `ui` script organizes the dashboard into a tabbed structure with separate panels for each city. Each panel includes:

-   A dropdown menu for selecting a neighborhood.
-   A Leaflet map output.
-   A ValueBox to display the average price.
-   A Plotly chart for analyzing price distribution by room type.

### Server Logic

The `server` script manages reactivity and rendering:

-   Filters data based on user input (selected neighborhood).
-   Dynamically updates the Leaflet map, average price ValueBox, and Plotly chart.
-   Modularized logic for each city to ensure scalability and maintainability.

------------------------------------------------------------------------

## Sample Datasets

### Amsterdam

| Unnamed: 0 | id    | neighbourhood                          | latitude  | longitude | room_type       | price | days_occupied_in_2018 | minimum_nights | number_of_reviews | reviews_per_month | availability_2019 |
|------|------|------|------|------|------|------|------|------|------|------|------|
| 0          | 2818  | Oostelijk Havengebied - Indische Buurt | 52.365755 | 4.941419  | Private room    | 59    | 296.0                 | 3              | 248               | 2.10              | 44                |
| 1          | 3209  | Westerpark                             | 52.390225 | 4.873924  | Entire home/apt | 160   | 309.0                 | 4              | 42                | 1.03              | 47                |
| 2          | 20168 | Centrum-Oost                           | 52.365087 | 4.893541  | Entire home/apt | 80    | 224.0                 | 1              | 233               | 2.18              | 198               |
| 3          | 25428 | Centrum-West                           | 52.373114 | 4.883668  | Entire home/apt | 125   | 208.0                 | 14             | 1                 | 0.09              | 141               |
| 4          | 27886 | Centrum-West                           | 52.386727 | 4.892078  | Private room    | 150   | 318.0                 | 2              | 171               | 2.03              | 199               |

### New York

| Unnamed: 0 | id   | neighbourhood      | latitude | longitude | room_type       | price  | days_occupied_in_2019 | minimum_nights | number_of_reviews | reviews_per_month | availability_2020 |
|------|------|------|------|------|------|------|------|------|------|------|------|
| 0          | 2595 | Midtown            | 40.75362 | -73.98377 | Entire home/apt | 225.00 | 15.0                  | 10             | 48                | 0.39              | 1                 |
| 1          | 3831 | Brooklyn           | 40.68514 | -73.95976 | Entire home/apt | 89.00  | 188.0                 | 1              | 295               | 4.67              | 1                 |
| 2          | 5099 | Manhattan          | 40.74767 | -73.97500 | Entire home/apt | 200.00 | 362.0                 | 3              | 78                | 0.60              | 19                |
| 3          | 5121 | Bedford-Stuyvesant | 40.68688 | -73.95596 | Private room    | 60.00  | 0.0                   | 29             | 49                | 0.38              | 365               |
| 4          | 5178 | Manhattan          | 40.76489 | -73.98493 | Private room    | 79.00  | 141.0                 | 2              | 454               | 3.52              | 242               |

### San Francisco

| Unnamed: 0 | id   | neighbourhood    | latitude  | longitude   | room_type       | price | days_occupied_in_2018 | minimum_nights | number_of_reviews | reviews_per_month | availability_2019 |
|------|------|------|------|------|------|------|------|------|------|------|------|
| 0          | 958  | Western Addition | 37.769310 | -122.433856 | Entire home/apt | 170   | 213.0                 | 1              | 172               | 1.51              | 74                |
| 1          | 5858 | Bernal Heights   | 37.745112 | -122.421018 | Entire home/apt | 235   | 0.0                   | 30             | 112               | 0.96              | 365               |
| 2          | 7918 | Haight Ashbury   | 37.766690 | -122.452505 | Private room    | 65    | 0.0                   | 32             | 17                | 0.15              | 365               |
| 3          | 8142 | Haight Ashbury   | 37.764872 | -122.451828 | Private room    | 65    | 0.0                   | 32             | 8                 | 0.15              | 365               |
| 4          | 8339 | Western Addition | 37.775249 | -122.436374 | Entire home/apt | 785   | 276.0                 | 7              | 27                | 0.24              | 89                |

------------------------------------------------------------------------

## Skills Demonstrated

-   **Data Visualization:**
    -   Interactive maps and charts.
    -   Summary statistics with intuitive displays.
-   **Data Manipulation:**
    -   Efficient filtering and aggregation with `dplyr`.
-   **Geospatial Analysis:**
    -   Location-based insights with Leaflet.
-   **UI/UX Design:**
    -   User-friendly interface with responsive components.
-   **R Programming:**
    -   Advanced reactivity and modularization in RShiny.

------------------------------------------------------------------------

This project reflects my ability to design and implement complex, interactive dashboards for data analysis and decision-making. Whether for business intelligence or public-facing applications, I bring expertise in RShiny, data visualization, and analytics to deliver impactful solutions.