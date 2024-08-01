
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_customer_analysis"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      box(title = "Customer Distribution by Country", status = "primary", solidHeader = TRUE, 
          plotlyOutput("customer_country_plot")),
      box(title = "Customer Age Distribution", status = "primary", solidHeader = TRUE,
          selectInput("type_age_plot", "Select Plot:", choices = c("Customer Age Distribution", "Total Spending vs. Age of Customers")),
          plotlyOutput("customer_age_plot"))
    ),
    fluidRow(
      box(title = "Total Spending by Gender", status = "primary", solidHeader = TRUE, 
          selectInput("country_selection", "Select Country:", 
                      choices = c("All", execute_query("SELECT DISTINCT country FROM customers;") %>% pull())),
          plotlyOutput("customer_gender_plot")),
      box(title = "Customers by Account Start Year", status = "primary", solidHeader = TRUE, 
          plotlyOutput("customer_account_start_year_plot"))
    )
  )), after = length(liste_tabitems))

