library(readxl)
library(plotly)

# Load the specific sheet 'Orders' from the Excel file
orders_df <- read_excel("data/Data_Superstore-Start.xlsx", sheet = "Orders")

# Count unique customers in each region
customer_counts <- orders_df %>%
  distinct(`Customer ID`, Region) %>%
  group_by(Region) %>%
  summarize(Customer_Count = n())

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = customer_counts, 
        x = ~Customer_Count, 
        y = ~reorder(Region, Customer_Count),  # Reorder regions based on customer count
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Number of Customers for Each Region',
         xaxis = list(title = 'Number of Customers'),
         yaxis = list(title = 'Region'))

# Data Manipulation: Calculate total sales for each region
sales_by_region <- orders_df %>%
  group_by(Region) %>%
  summarize(Total_Sales = sum(Sales, na.rm = TRUE)) %>%
  arrange(desc(Total_Sales))  # Order by total sales descending

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = sales_by_region, 
        x = ~Total_Sales, 
        y = ~reorder(Region, Total_Sales),  # Reorder regions based on total sales
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Total Sales by Region',
         xaxis = list(title = 'Total Sales'),
         yaxis = list(title = 'Region'))


# Data Manipulation: Calculate total quantity for each region
quantity_by_region <- orders_df %>%
  group_by(Region) %>%
  summarize(Total_Quantity = sum(Quantity, na.rm = TRUE)) %>%
  arrange(desc(Total_Quantity))  # Order by total quantity descending

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = quantity_by_region, 
        x = ~Total_Quantity, 
        y = ~reorder(Region, Total_Quantity),  # Reorder regions based on total quantity
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Total Quantity by Region',
         xaxis = list(title = 'Total Quantity'),
         yaxis = list(title = 'Region'))



# Data Manipulation: Calculate total sales and unique customer count for each region
sales_customer_data <- orders_df %>%
  group_by(Region) %>%
  summarize(Total_Sales = sum(Sales, na.rm = TRUE), 
            Customer_Count = n_distinct(`Customer ID`)) %>%
  mutate(Sales_Per_Customer = Total_Sales / Customer_Count) %>%
  arrange(desc(Sales_Per_Customer))  # Order by sales per customer descending

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = sales_customer_data, 
        x = ~Sales_Per_Customer, 
        y = ~reorder(Region, Sales_Per_Customer),  # Reorder regions based on sales per customer
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Sales per Customer by Region',
         xaxis = list(title = 'Sales per Customer'),
         yaxis = list(title = 'Region'))



# Data Manipulation: Calculate total profit for each region
profit_by_region <- orders_df %>%
  group_by(Region) %>%
  summarize(Total_Profit = sum(Profit, na.rm = TRUE)) %>%
  arrange(desc(Total_Profit))  # Order by total profit descending

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = profit_by_region, 
        x = ~Total_Profit, 
        y = ~reorder(Region, Total_Profit),  # Reorder regions based on total profit
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Total Profit by Region',
         xaxis = list(title = 'Total Profit'),
         yaxis = list(title = 'Region'))


# Data Manipulation: Calculate total profit and total sales for each region, then compute the profit ratio in percentage
profit_ratio_by_region <- orders_df %>%
  group_by(Region) %>%
  summarize(Total_Profit = sum(Profit, na.rm = TRUE), 
            Total_Sales = sum(Sales, na.rm = TRUE)) %>%
  mutate(Profit_Ratio_Percentage = (Total_Profit / Total_Sales) * 100) %>%
  arrange(desc(Profit_Ratio_Percentage))  # Order by profit ratio percentage descending

# Create a Horizontal Bar Chart with Ordered Bars
plot_ly(data = profit_ratio_by_region, 
        x = ~Profit_Ratio_Percentage, 
        y = ~reorder(Region, Profit_Ratio_Percentage),  # Reorder regions based on profit ratio percentage
        type = 'bar', 
        orientation = 'h',  # Flip coordinates for horizontal bars
        marker = list(color = 'rgba(55, 83, 109, 0.7)',
                      line = list(color = 'rgba(55, 83, 109, 1.0)', width = 2))) %>%
  layout(title = 'Profit Ratio by Region',
         xaxis = list(title = 'Profit Ratio (%)'),
         yaxis = list(title = 'Region'))



# Data Manipulation: Aggregate sales and profit by customer and calculate profit ratio
customer_sales_profit <- orders_df %>%
  group_by(`Customer ID`, `Customer Name`) %>%
  summarize(Total_Sales = sum(Sales, na.rm = TRUE),
            Total_Profit = sum(Profit, na.rm = TRUE)) %>%
  mutate(Profit_Ratio = Total_Profit / Total_Sales * 100)  # Calculate profit ratio in percentage

# Create a Scatter Plot
plot_ly(data = customer_sales_profit, 
        x = ~Total_Sales, 
        y = ~Total_Profit, 
        type = 'scatter', 
        mode = 'markers',
        color = ~Profit_Ratio,  # Color by profit ratio
        colors = colorRamp(c("red", "yellow", "green")),  # Color gradient from red to green
        marker = list(size = 10, opacity = 0.7),  # Size and opacity of dots
        text = ~paste(`Customer Name`, "<br>Profit Ratio:", round(Profit_Ratio, 2), "%")) %>%
  layout(title = 'Sales and Profit by Customer',
         xaxis = list(title = 'Total Sales'),
         yaxis = list(title = 'Total Profit'),
         colorbar = list(title = "Profit Ratio (%)"),
         hovermode = 'closest')




# Data Manipulation: Aggregate sales and profit by customer, calculate profit ratio
customer_sales_profit <- orders_df %>%
  group_by(`Customer ID`, `Customer Name`) %>%
  summarize(Total_Sales = sum(Sales, na.rm = TRUE),
            Total_Profit = sum(Profit, na.rm = TRUE)) %>%
  mutate(Profit_Ratio = (Total_Profit / Total_Sales) * 100)  # Calculate profit ratio in percentage

# Filter to include only the top 10 and bottom 10 customers by total sales
top_30_customers <- customer_sales_profit %>%
  arrange(desc(Total_Sales)) %>%
  head(30)

bottom_10_customers <- customer_sales_profit %>%
  arrange(Total_Sales) %>%
  head(10)

# Combine top 10 and bottom 10 customers
selected_customers <- bind_rows(top_10_customers, bottom_10_customers)

# Create a Horizontal Bar Chart
plot_ly(data = top_30_customers, 
        x = ~Total_Sales, 
        y = ~reorder(`Customer Name`, Total_Sales),  # Reorder customer names by total sales
        type = 'bar', 
        orientation = 'h',  # Set orientation to horizontal
        marker = list(color = ~Profit_Ratio, colorscale = 'RdYlGn', showscale = TRUE),  # Color by Profit Ratio
        text = ~paste("Profit Ratio: ", round(Profit_Ratio, 2), "%", "<br>Total Sales: ", round(Total_Sales, 2)),  # Hover information
        hoverinfo = 'text') %>%
  layout(title = 'Top 30 Customers by Total Sales',
         xaxis = list(title = 'Total Sales'),
         yaxis = list(title = 'Customer Name', automargin = TRUE),
         colorbar = list(title = "Profit Ratio (%)"),
         showlegend = FALSE)
