
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_pharma_forecasting"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidPage(
      
      # Thème
      # themeSelector(),
      #theme = shinytheme("cyborg"),
      
      # Pour centrer les textes de h1 et h4
      tags$head(
        tags$style(HTML("
      h1, h3 {
        text-align: center;
      }
    "))
      ),
      
      # Titre de l'application
      h1("Forecaster Web App", style = "font-family: 'Jura'; 
     color: red; font-size: 80px;"),
      h3(tags$b("R Shiny web application for forecasting the Sales Revenue or the Quantity of Products in a pharmacy."), 
      style = "font-family: 'Jura'; color: green;"),
      br(),
      h4(tags$a("Author : Josué AFOUDA", 
                href = 'https://www.linkedin.com/in/josu%C3%A9-afouda/')),
      
      h4(tags$a("Learn R Shiny",href='https://youtu.be/4XGI_ye0y4M?si=_i7Zcpg91s8XavfU')),
      
      br(),
      
      fluidRow(column(12, wellPanel(
        radioButtons(
          "forecastmetric",
          label = "Forecasting Metric",
          choices = c("Sales Revenue", "Quantity"),
          inline = TRUE
        )
      ))), 
      
      fluidRow(column(2, wellPanel(
        selectizeInput("categ", 
                    label = "Categorie Name", 
                    choices = unique(productdb$CHEMSUB))
      )),
      column(10, wellPanel(plotlyOutput("top5plot")))), 
      
      # fluidRow(column(12, wellPanel(uiOutput('ProductControl')))),
      
      fluidRow(column(
        2,
        wellPanel(
          selectizeInput("prods", 
                      label = "Product Name", 
                      choices = unique(productdb$BNFNAME)),
          br(),
          checkboxInput("decompose", label = "Decompose ETS", value = TRUE),
          br(),
          selectInput(
            "forecastmodel",
            label = "Forecasting Model",
            choices = c(
              "ETS" = "auto",
              "Holt-Winters" = "hw",
              "TBATS" =
                "tbats",
              "Auto ARIMA" = "autoarima",
              "Facebook Prophet" =
                "fbpro"
            )
          )
        )
      ),
      column(5, plotlyOutput("actual_ts")),
      column(5, plotOutput("autoplotforecast"))), 
      
      fluidRow(column(12, 
                      numericInput(
                        "horizon", 
                        label = "Horizon of Prevision",
                        value = 6,
                        min = 1
                      ),
                      DTOutput("forecastdata")))
      
    )
  )), after = length(liste_tabitems))

