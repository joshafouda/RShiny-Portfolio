# Import all libraries
library(RSQLite)
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)

library(tidyr)
library(TSstudio)
library(lubridate)
library(forecast)
library(prophet)

library(stringr)
library(quantmod)
library(readr)

# library(factoextra)
# library(Rtsne)

# library(caret)

library(rvest)
library(zoo)
library(xts)
library(PerformanceAnalytics)
library(tseries)
library(fontawesome)

library(leaflet)

library(shinyjs)
library(shinyBS)
library(shinyWidgets)

library(sf)
library(maps)

library(highcharter)

# Source function files
liste_functions <- list.files(path = "functions", pattern = "\\.R$", full.names = TRUE)
for (fichierFunction in liste_functions) {
  source(file = file.path(fichierFunction), encoding = "UTF-8", local = TRUE)
}

# Source utils.R (fonctions utilitaires)
source("utils.R")

################################### ui et server ####################

liste_menuitems = list()
liste_tabitems = list()

# Ajout du menuItem principal pour "Movie Rental Dashboard"
liste_menuitems <- append(liste_menuitems, list(
  menuItem("Movie Rental Dashboard", tabName = "dashboard", icon = icon("dashboard"), startExpanded = TRUE,
           menuSubItem("Overview", tabName = "tabItem_overview", icon = icon("dashboard")),
           menuSubItem("Customer Analysis", tabName = "tabItem_customer_analysis", icon = icon("users")),
           menuSubItem("Movie Analysis", tabName = "tabItem_movie_analysis", icon = icon("film")),
           menuSubItem("Tables", tabName = "tabItem_tables_trends", icon = icon("table"))
  )
), after = length(liste_menuitems))


# Source ui files
v_fichiersUI <- list.files(path = "ui", pattern = "\\.R$", full.names = TRUE)

for (fichierUI in v_fichiersUI) {
  source(file = file.path(fichierUI), encoding = "UTF-8", local = TRUE)
}

app_title = "My R Shiny Portfolio"

# Header
header <- dashboardHeader(
  title = app_title,
  tags$li(
    class = "dropdown",
    tags$a(
      href = "https://www.linkedin.com/in/josu%C3%A9-afouda",
      "Author: Josué AFOUDA",
      target = "_blank",
      style = "color: yellow;" # Add this line to set the text color to black
    )
  )
)

# Sidebar
sidebar <- dashboardSidebar(do.call(sidebarMenu, liste_menuitems))

# Body
body <- dashboardBody(do.call(tabItems, liste_tabitems))

# User Interface
ui <- dashboardPage(header, sidebar, body)

# Server
server <- function(input, output, session) {
  liste_servers <- list.files(path = "server", pattern = "\\.R$", full.names = TRUE)

  for (fichierServer in liste_servers) {
    source(file = file.path(fichierServer), encoding = "UTF-8", local = TRUE)
  }

}

# Définir l'application Shiny
shinyApp(ui = ui, server = server)