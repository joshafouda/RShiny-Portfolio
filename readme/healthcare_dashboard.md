# Healthcare Dashboard

## Overview
The **Healthcare Dashboard** is an R Shiny application designed to analyze and visualize hospital performance metrics, patient outcomes, and healthcare trends. It enables users to explore hospital-specific and region-specific metrics, empowering healthcare administrators and analysts to make data-driven decisions.

### Key Features
1. **Hospital Profile Analysis**:
   - Select a hospital to view key metrics such as:
     - Average Length of Stay (LOS)
     - Average Cost per Discharge
     - Readmission Rate
     - Mortality Rate
     - Total Discharges and Readmissions
   - Visualizations of patient discharges by severity level, mortality risk, diagnostic description, and patient disposition.

2. **LOS and Cost Comparisons**:
   - Analyze average LOS and cost metrics for hospitals within selected health service areas.
   - Compare metrics like total discharges, average LOS, and cost per discharge across facilities.
   - Scatter plots and bar charts highlight trends and outliers.

3. **Dynamic Visualizations**:
   - Top hospitals by performance metrics (e.g., highest and lowest LOS or cost per discharge).
   - Interactive plots for patient trends and diagnostic insights.

## Skills Demonstrated
1. **Advanced R Shiny Development**:
   - Developed a responsive and user-friendly dashboard with dynamic inputs and outputs.
   - Incorporated modular components to streamline scalability.

2. **Data Visualization**:
   - Leveraged `plotly` for interactive visualizations, including bar charts, scatter plots, and donut charts.
   - Designed value boxes for concise summaries of critical metrics.

3. **Data Aggregation and Analysis**:
   - Used reactive expressions to compute metrics dynamically based on user inputs.
   - Implemented grouped summaries and top-level insights using `dplyr`.

4. **Healthcare Metrics Evaluation**:
   - Analyzed key performance indicators (KPIs) for hospitals, including LOS, cost, readmission rates, and mortality rates.
   - Provided granular insights into hospital performance and patient outcomes.

## Application Structure
### User Interface (UI)
- **Hospital Profile Tab**:
  - Dropdown to select a hospital.
  - Value boxes and visualizations summarizing key performance metrics.

- **LOS and Cost Comparison Tab**:
  - Dropdown to filter by health service area.
  - Charts comparing LOS, cost, and discharge metrics across hospitals.

### Server Logic
- **Reactive Data Summaries**:
  - Computes hospital-specific and region-specific KPIs dynamically.
  - Aggregates data to highlight trends in LOS, cost, and discharges.

- **Interactive Visualizations**:
  - Generates bar charts, scatter plots, and donut charts based on filtered data.

## How to Use
1. **Analyze Hospital Profiles**:
   - Select a hospital to view its performance metrics.
   - Explore visualizations for patient discharges by diagnostic and risk categories.

2. **Compare LOS and Costs**:
   - Filter hospitals by health service area to analyze trends.
   - View scatter plots and bar charts for LOS and cost comparisons.

3. **Explore Top and Bottom Performers**:
   - Identify hospitals with the highest and lowest LOS or costs per discharge.

## Requirements
### Prerequisites
- **R**: Version 4.0 or higher.
- **R Packages**:
  - `shiny`
  - `dplyr`
  - `plotly`
  - `DT`


## Author

[Josué A.](https://www.linkedin.com/in/josu%C3%A9-afouda/)  

## Conclusion
The **Healthcare Dashboard** is a powerful tool for analyzing hospital performance and patient outcomes. It demonstrates advanced data visualization, R Shiny development, and healthcare data analysis skills. Whether you're a healthcare administrator, analyst, or researcher, this application provides actionable insights for improving healthcare delivery. Feel free to reach out for collaboration or inquiries!

