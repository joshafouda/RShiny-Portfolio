
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_airbnb_dashboard"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      # Add the city selection tab or a title here if necessary
      tabsetPanel(
        tabPanel("New York", icon = icon("city"),
                 fluidRow(
                   column(8,  # 2/3 of the width for the map
                          box(
                            title = "Map of Airbnb Locations", 
                            status = "primary", 
                            solidHeader = TRUE, 
                            collapsible = TRUE,
                            selectInput("quartier", "Choisis un quartier", choices = unique(newyork$neighbourhood)),
                            # leafletOutput("nyc_map", height = "600px")
                            leafletOutput("nyc_map")
                          )
                   ),
                   column(4,  # 1/3 of the width for the bar chart
                          box(
                            title = "Average Price by Room Type", 
                            status = "info", 
                            solidHeader = TRUE, 
                            collapsible = TRUE,
                            # plotlyOutput("nyc_price_chart", height = "600px")
                            plotlyOutput("nyc_price_chart")
                          )
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
                   box(selectInput("quartier_ams", "Choisis un quartier", choices = unique(amsterdam$neighbourhood))),
                   box(width = 12, leafletOutput("ams_map"))
                 ),
                 fluidRow(
                   box(width = 6, plotlyOutput("ams_price_chart"))
                 )
        )
      )
    )
  )), after = length(liste_tabitems))

