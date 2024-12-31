# Portfolio Optimization Dashboard

## Overview
The **Portfolio Optimization Dashboard** is an advanced R Shiny application designed for financial portfolio analysis and optimization. This app empowers users to analyze historical stock data, calculate portfolio returns, and perform portfolio optimization using techniques like mean-variance analysis, rolling performance metrics, and constraint-based optimization.

### Key Features
1. **Stock Market Analysis**:
   - Dynamic selection of assets from major stock indices (CAC 40, FTSE 100, DAX, Nikkei 225, and S&P 500).
   - Visualization of closing prices, returns, and their distributions.

2. **Portfolio Analysis**:
   - Compute daily returns and aggregate them by time periods (weekly, monthly, quarterly, yearly).
   - Analyze rolling performance metrics such as annualized mean returns, volatility, Sharpe ratios, and drawdowns.

3. **Portfolio Optimization**:
   - Mean-variance portfolio optimization with and without weight constraints.
   - Split-sample evaluation for robust portfolio performance analysis.

4. **Data Export**:
   - Download data tables for prices, returns, and aggregated returns in CSV format.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Designed an interactive and modular dashboard layout for scalability.
   - Integrated user-driven inputs to dynamically generate visualizations and outputs.

2. **Financial Data Analysis**:
   - Applied advanced techniques for portfolio analysis and optimization.
   - Incorporated rolling performance metrics and constraint-based optimization for robust financial modeling.

3. **Data Visualization**:
   - Created interactive plots using `plot.zoo`, `barplot`, and financial-specific charting libraries like `PerformanceAnalytics`.
   - Provided dynamic histogram and scatterplot visualizations for exploratory data analysis.

4. **Dynamic User Interaction**:
   - Built a fully customizable interface with dropdowns, sliders, and dynamically generated inputs.

## Application Structure
### User Interface (UI)
- **Sidebar Panel**:
  - Select stock indices, assets, portfolio weights, and analysis periods.
  - Choose rebalancing frequencies and other parameters for portfolio construction.

- **Main Panel**:
  - Tabs for exploring prices, returns, aggregated returns, performance metrics, and portfolio optimization results.

### Server Logic
- Dynamically generates inputs for asset selection and weight allocation.
- Retrieves and processes historical stock data for selected indices.
- Computes portfolio returns and optimizations based on user-defined parameters.
- Generates detailed visualizations for exploratory data analysis and optimization results.

## How to Use
1. **Select Assets**:
   - Choose a stock index and specify the number of assets to include in the portfolio.
   - Define the weights of assets dynamically using sliders.

2. **Analyze Prices and Returns**:
   - Explore closing prices, returns, and their statistics in tabular and graphical formats.

3. **Aggregate and Visualize Returns**:
   - Aggregate daily returns to higher time periods and visualize mean returns.
   - Download aggregated return data for offline analysis.

4. **Perform Portfolio Optimization**:
   - Optimize portfolios using mean-variance analysis.
   - Add weight constraints and evaluate portfolio performance using split-sample analysis.

5. **Download Data**:
   - Save analyzed data (prices, returns, and aggregated returns) in CSV format.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `PerformanceAnalytics`
  - `quantmod`
  - `DT`
  - `zoo`
  - `tseries`


## Author

[Josué A.](https://www.linkedin.com/in/josu%C3%A9-afouda/)  
[Support My Work](https://www.paypal.me/aaajosue)

## Conclusion
The **Portfolio Optimization Dashboard** is a robust tool for financial analysis and portfolio management. It showcases expertise in R programming, Shiny app development, and financial modeling. Whether you're an investor, analyst, or researcher, this application provides valuable insights and tools for decision-making. Feel free to reach out for collaboration or inquiries!

