
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_airbnb_dashboard"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Airbnb Business Dashboard", tabName = nom_tab, icon = icon("home"))), after = 6)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      # Add the city selection tab or a title here if necessary
      tabsetPanel(
        tabPanel("New York", icon = icon("city"),
                 fluidRow(
                   box(width = 12, selectInput("quartier", "Choisis un quartier", choices = unique(newyork$neighbourhood))),
                   box(width = 7, title = "Emplacements des logements Airbnb", 
                       status = "primary", solidHeader = TRUE, leafletOutput("nyc_map", height = "690px")),
                   box(width = 5, 
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, valueBoxOutput("nyc_quartier_avg_price", width = 12))), 
                       br(),
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb par type de logement dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, plotlyOutput("nyc_price_chart", height = "450px")))
                   )
                 )
        ),
        tabPanel("San Francisco", icon = icon("city"),
                 fluidRow(
                   box(width = 12, selectInput("quartier_san", "Choisis un quartier", choices = unique(sanfrancisco$neighbourhood))),
                   box(width = 7, title = "Emplacements des logements Airbnb", 
                       status = "primary", solidHeader = TRUE, leafletOutput("sf_map", height = "690px")),
                   box(width = 5, 
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, valueBoxOutput("sf_quartier_avg_price", width = 12))), 
                       br(),
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb par type de logement dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, plotlyOutput("sf_price_chart", height = "450px")))
                       )
                 )
        ),
        tabPanel("Amsterdam", icon = icon("city"),
                 fluidRow(
                   box(width = 12, selectInput("quartier_ams", "Choisis un quartier", choices = unique(amsterdam$neighbourhood))),
                   box(width = 7, title = "Emplacements des logements Airbnb", 
                       status = "primary", solidHeader = TRUE, leafletOutput("ams_map", height = "690px")),
                   box(width = 5, 
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, valueBoxOutput("ams_quartier_avg_price", width = 12))), 
                       br(),
                       fluidRow(box(width = 12, title = "Prix moyen ($) d’un Airbnb par type de logement dans ce quartier", 
                                    status = "primary", solidHeader = TRUE, plotlyOutput("ams_price_chart", height = "450px")))
                   )
                 )
        ),
        tabPanel(
          "Read Me",
          icon = icon("book-open"),
          includeMarkdown("./readme/airbnb_dashboard.md")
        )
      )
    )
  )), after = 6)

