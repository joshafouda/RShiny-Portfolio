
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_movie_analysis"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      box(title = "Movies by Genre", status = "primary", solidHeader = TRUE, 
          plotlyOutput("movies_genre_plot")),
      box(title = "Average Rating by Country and Genre", status = "primary", solidHeader = TRUE, 
          plotlyOutput("avg_rating_genre_plot"))
    ),
    fluidRow(
      box(title = "Movie Release Year Distribution", status = "primary", solidHeader = TRUE, 
          selectInput("type_plot_release", "Select Plot:", 
                      choices = c("Movie Release Year Distribution", "Average Rating by Year of Release", 
                                  "Average Renting Price by Year of Release", "Number of Rentals by Year of Release")),
          plotlyOutput("movies_year_plot")),
      box(title = "Rentals by Country and Year of Release", status = "primary", solidHeader = TRUE, 
          plotlyOutput("rentals_country_year_plot"))
    )
  )), after = length(liste_tabitems))

