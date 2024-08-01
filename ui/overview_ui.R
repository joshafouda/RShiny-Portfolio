
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_overview"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      valueBoxOutput("total_customers"),
      valueBoxOutput("total_movies"),
      valueBoxOutput("total_rentals")
    ),
    fluidRow(
      box(title = "Total Revenue by Time Period", status = "primary", solidHeader = TRUE, 
          selectInput("time_aggregate", "Select Aggregate Type:", 
                      choices = c("Day" = "day", "Month" = "month", "Year" = "year")),
          plotlyOutput("revenue_by_time_plot", height = 250)),
      box(title = "Revenue & Average Rating Distribution by Country", status = "primary", solidHeader = TRUE, 
          plotlyOutput("revenue_ratings_country_plot"))
      
    ),
    fluidRow(
      box(title = "Average Monthly Revenue", status = "primary", solidHeader = TRUE, 
          plotlyOutput("average_monthly_revenue_plot", height = 250)),
      box(title = "Ratings Distribution", status = "primary", solidHeader = TRUE, 
          plotlyOutput("ratings_distribution_plot"))
    )
  )), after = length(liste_tabitems))

