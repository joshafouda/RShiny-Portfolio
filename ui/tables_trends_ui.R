
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_tables_trends"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      box(title = "Film Genre Performance Metrics", status = "primary", solidHeader = TRUE, 
          DTOutput("movies_rental_country_year")),
      box(title = "Top 10 Movies by Rating", status = "primary", solidHeader = TRUE, 
          DTOutput("top_movies_table"))
    ),
    fluidRow(
      box(title = "Top 10 Actors by Rating", status = "primary", solidHeader = TRUE, 
          DTOutput("top_actors_table")),
      box(title = "Top 10 Customers by Revenue", status = "primary", solidHeader = TRUE, 
          DTOutput("top_customers_table"))
    )
  )), after = length(liste_tabitems))

