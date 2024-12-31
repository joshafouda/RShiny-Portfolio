# Pharmaceutical Forecasting Web Application

## Overview

The **Pharmaceutical Forecasting Web App** is a powerful R Shiny application designed for forecasting sales revenue and product quantities within the pharmaceutical domain. This application, built with the **shinydashboard** framework, demonstrates advanced data visualization, predictive analytics, and interactive user experiences.

## Features

- **Interactive Forecasting Metrics**: Choose between forecasting **Sales Revenue** or **Quantity** of products.
- **Category-Based Analysis**: Analyze the top 5 products within a selected pharmaceutical category.
- **Product-Specific Forecasting**: Drill down to specific products and forecast their metrics using advanced time series models.
- **Dynamic Model Selection**: Choose from multiple forecasting models, including:
  - ETS (Error, Trend, Seasonality)
  - Holt-Winters
  - TBATS
  - Auto ARIMA
  - Facebook Prophet
- **Decomposition of Time Series**: Visualize the components of a time series (trend, seasonality, and residuals).
- **Forecast Horizons**: Customize the forecast horizon for predictive analysis.
- **Data Visualization**: Leverage interactive plots powered by **Plotly** and static visualizations for forecasting results.
- **Tabular Forecast Output**: View forecast results in an interactive data table.

## Skills Demonstrated

1. **Data Analysis**: Proficient manipulation and filtering of datasets.
2. **Time Series Modeling**: Expertise in various forecasting techniques and model comparison.
3. **Data Visualization**: Integration of Plotly for dynamic visualizations.
4. **User-Centric Design**: Developing intuitive user interfaces with customizable options.
5. **Web Technologies**: Leveraging R Shiny and shinydashboard for scalable web applications.
6. **Data Integration**: Seamless integration with external data sources.

## How It Works

### Data Loading
The application reads its dataset from an external source:

```R
# Create a connection from the URL
url_connection <- url("https://raw.githubusercontent.com/joshafouda/data_formations/main/productdb.rds", "rb")

# Read the RDS file from the URL
productdb <- readRDS(url_connection)

# Close the connection
close(url_connection)
```

The dataset `productdb` contains pharmaceutical product information, including monthly sales, costs, and quantities.

### User Interface
The UI is designed with:
- A **dashboard layout** for intuitive navigation.
- Customizable widgets for selecting metrics, categories, products, models, and forecast horizons.
- Responsive plots and tables for real-time feedback.

### Server Logic
The server logic:
1. Processes user inputs to filter and manipulate data.
2. Generates dynamic visualizations for top products and individual product forecasts.
3. Employs advanced models for time series forecasting.
4. Outputs results in both graphical and tabular formats.

## How to Use

1. **Load the Application**: Start the R Shiny app in your R environment.
2. **Select Forecasting Metric**: Choose either "Sales Revenue" or "Quantity".
3. **Choose Category**: Pick a product category to analyze the top-performing products.
4. **Select Product**: Drill down to a specific product for detailed analysis.
5. **Choose Forecasting Model**: Experiment with different models for the most accurate predictions.
6. **Set Horizon**: Adjust the forecast horizon (number of months).
7. **View Results**: Explore interactive plots and data tables.


## About the Author

This application was developed by [Josué AFOUDA](https://www.linkedin.com/in/josu%C3%A9-afouda/). Passionate about data science and web development, Josué specializes in creating impactful and interactive data-driven applications.

## Resources

- [Learn R Shiny](https://youtu.be/4XGI_ye0y4M?si=_i7Zcpg91s8XavfU)
