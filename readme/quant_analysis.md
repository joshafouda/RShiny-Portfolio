# Technical Stock Charts Web App

## Overview
The **Technical Stock Charts Web App** is a comprehensive R Shiny application designed for quantitative analysis of financial markets. Built using the **shinydashboard** framework, this app provides interactive tools to analyze stock market data from the United States (S&P 500), France (CAC 40), Germany (DAX), England (FTSE 100), and Japan (Nikkei 225). It enables users to perform technical analysis through advanced visualizations and statistical summaries.

### Key Features
- **Interactive User Interface**: A responsive and user-friendly dashboard with customizable inputs for selecting indices, stocks, date ranges, and analysis parameters.
- **Data Integration**: Fetches real-time stock market data using the `quantmod` package and integrates seamlessly with Yahoo Finance.
- **Visualization Tools**:
  - Line charts for stock prices or returns with moving averages.
  - Boxplots and histograms for statistical insights.
  - Advanced technical charts with Bollinger Bands, RSI, EMA, and MACD indicators.
- **Customizable Parameters**: Options for:
  - Selecting a stock index and asset.
  - Specifying a date range for analysis.
  - Setting short and long moving averages.
  - Viewing raw data tables with adjustable row limits.
- **Downloadable Data**: Export stock data as CSV, Excel, or PDF directly from the app.

## Skills Demonstrated
1. **R Shiny Development**:
   - Designed an interactive application using modular `ui` and `server` components.
   - Leveraged reactive programming for dynamic updates and user-driven inputs.

2. **Data Visualization**:
   - Created visually appealing and interactive charts using `ggplot2`, `plotly`, and `quantmod`.
   - Enhanced user experience with customizable chart features and parameters.

3. **Technical Analysis Expertise**:
   - Implemented key technical indicators such as Bollinger Bands, RSI, EMA, and MACD.
   - Enabled in-depth analysis of stock market data.

4. **Integration with Financial APIs**:
   - Accessed and processed live data from Yahoo Finance using the `getSymbols` function.

5. **Dashboard Design**:
   - Built an elegant layout using `shinydashboard` with cohesive styling and intuitive navigation.

## Application Structure
### User Interface (UI)
The UI is designed with:
- **Dashboard Menu**: Organized into tabs for seamless navigation.
- **Input Panels**: Interactive widgets for user input, including dropdown menus, sliders, and action buttons.
- **Output Displays**: A combination of `plotly` charts, `datatable` tables, and advanced plots for technical analysis.

### Server Logic
The server logic processes user inputs and dynamically updates outputs. Key components include:
- Reactive expressions to handle data filtering and transformations.
- Event-driven outputs for rendering plots and tables.
- Conditional panels for optional data displays.

## How to Use
1. **Select a Stock Market Index**:
   Choose from CAC 40, S&P 500, DAX, FTSE 100, or Nikkei 225.

2. **Select a Stock**:
   Use the dropdown menu to choose an asset within the selected index.

3. **Specify Analysis Parameters**:
   - Set the date range for the analysis.
   - Choose to analyze either price or return data.
   - Adjust the short and long moving average parameters.

4. **View Results**:
   - Explore line charts, boxplots, and histograms.
   - Enable the data table display for raw stock data.

5. **Export Data**:
   Download the stock data in various formats using the export buttons.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `shinydashboard`
  - `quantmod`
  - `ggplot2`
  - `plotly`
  - `DT`

### Installation
1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Install the required R packages:
   ```R
   install.packages(c("shiny", "shinydashboard", "quantmod", "ggplot2", "plotly", "DT"))
   ```

3. Run the application:
   ```R
   shiny::runApp("path-to-app")
   ```

## Author
**Josué AFOUDA**  
[LinkedIn](https://www.linkedin.com/in/josu%C3%A9-afouda/)  
[Learn R Shiny](https://youtube.com/playlist?list=PLmJWMf9F8euStJ32KHOThQzJ7hub-JXA0)

## Screenshots
### Dashboard Overview
![Dashboard Screenshot](path/to/screenshot1.png)

### Line Chart Analysis
![Line Chart Screenshot](path/to/screenshot2.png)

### Boxplot and Histogram
![Boxplot Screenshot](path/to/screenshot3.png)

## Conclusion
This application demonstrates my advanced capabilities in financial data analysis, R programming, and dashboard development. It is an excellent showcase of technical skills and a valuable tool for investors, analysts, and financial enthusiasts.

Feel free to reach out for collaboration or inquiries!

