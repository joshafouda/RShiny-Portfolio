# RShiny Portfolio Dashboard

![myrshinyportfolio](https://github.com/user-attachments/assets/83fb8002-fb76-4f8c-a2f9-acec3ca0c9d7)

Welcome to my **RShiny Portfolio**, an advanced, multi-application dashboard built with the **shinydashboard** framework. This project is designed to showcase my expertise in developing scalable and impactful data-driven applications using R. Each menu represents a standalone application or dashboard, meticulously crafted to provide interactive and insightful solutions for various domains.

---

## 🚀 **Project Structure**

The project is organized into a modular structure for enhanced scalability and maintainability:

```
- data/                 # Data files used across applications
- ui/                   # Contains UI scripts for individual apps (e.g., pharma_forecasting_ui.R)
- server/               # Contains server scripts for individual apps (e.g., pharma_forecasting_server.R)
- functions/            # Contains helper functions (e.g., pharma_forecasting_function.R)
- readme/               # Individual README files for each app
- global.R              # Entry point for the entire application
- utils.R               # Utility functions shared across the portfolio
```

Dependency management is handled using the **`renv`** package, ensuring a reproducible environment.

---

## 🧩 **Applications Overview**

### 1. **Pharmaceutical Forecasting**
**Description:** Forecast sales revenue and product quantities in the pharmaceutical domain. This app empowers stakeholders to make data-driven decisions with advanced forecasting models and visualizations.

### 2. **Quantitative Analysis App**
**Description:** Analyze stock market data for indices including S&P 500, CAC 40, DAX, FTSE 100, and Nikkei 225. Perform technical analysis through interactive visualizations and statistical summaries.

### 3. **Customer Churn Dashboard**
**Description:** Visualize key metrics related to customer churn. This dashboard helps businesses identify churn drivers, understand customer behaviors, and guide retention strategies.

### 4. **Movie Rental Dashboard**
**Description:** Dive into detailed analyses with four interconnected dashboards:
- **Overview Dashboard:** Key business metrics and trends.
- **Customer Analysis Dashboard:** Insights into customer demographics and behavior.
- **Movie Analysis Dashboard:** Metrics and trends related to movies.
- **Tables and Trends Dashboard:** Top performers and tabular insights.

### 5. **Airbnb Business Dashboard**
**Description:** Explore Airbnb data from New York, San Francisco, and Amsterdam. Analyze property prices, types, and neighborhood distributions with an intuitive interface.

### 6. **Portfolio Optimization App**
**Description:** Analyze historical stock data, calculate portfolio returns, and optimize portfolios using advanced techniques like mean-variance analysis and constraint-based optimization.

### 7. **Healthcare Dashboard**
**Description:** Analyze hospital performance metrics, patient outcomes, and healthcare trends. This dashboard supports decision-making for healthcare administrators and analysts.

### 8. **HR Analytics Dashboard**
**Description:** Explore workforce data, including hiring trends, demographics, performance, and attrition metrics. Designed for HR teams to monitor and make data-driven decisions.

### 9. **My Website**
**Description:** A personal website, fully developed using RShiny, to showcase my professional portfolio and skills.

---

## 🎯 **Key Features**
- **Modular Architecture:** Individual UI, server, and function scripts for each app ensure scalability and maintainability.
- **Interactive Visualizations:** Rich, user-friendly interfaces leveraging `ggplot2`, `plotly`, `leaflet` and other visualization packages.
- **Advanced Analytics:** Integration of machine learning models, forecasting techniques, and portfolio optimization methods.
- **Reproducible Environment:** Dependency management with `renv` ensures consistent results across different systems.
- **Domain Expertise:** Applications span diverse domains including healthcare, HR, finance, and entertainment.

---

## 💡 **Getting Started**

### Prerequisites
- **R** (version >= 4.0)
- Required R packages: Listed in the `renv.lock` file

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/joshafouda/RShiny-Portfolio.git
   ```
2. Navigate to the project directory:
   ```bash
   cd RShiny-Portfolio
   ```
3. Restore the project environment:
   ```R
   library(renv)
   renv::restore()
   ```
4. Run the application:
   ```R
   shiny::runApp()
   ```

---

## 🌟 **Why This Portfolio?**
This portfolio demonstrates my ability to:
- Develop complex, modular RShiny applications that solve real-world problems.
- Integrate domain expertise with technical skills to create actionable insights.
- Deliver high-quality, user-focused solutions that drive decision-making.

---

## 📫 **Contact**
Feel free to reach out for collaboration or inquiries:
- **Email:** afouda.josue@gmail.com
- **LinkedIn:** [Josué A.](https://www.linkedin.com/in/josu%C3%A9-afouda/)
- **Book a Call:** [Calendly](https://calendly.com/afouda-josue)

---

Thank you for exploring my RShiny Portfolio! 🚀
