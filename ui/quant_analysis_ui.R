
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_quant_analysis"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Quantitative Analysis App", tabName = nom_tab, icon = icon("chart-line"))), after = 2)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidPage(
      
      # Titre de l'application
      h1("Technical Stock Charts Web App", style = "font-family: 'Jura'; 
     color: red; font-size: 80px;"),
      h4(tags$b("R Shiny web application for Quantitative Analysis of several financial markets (United States of America, France, Germany, England and Japan).")),
      h4(tags$b("This app may not display charts for some stocks due to their data unavailability on Yahoo Finance.")),
      
      # Thème
      #theme = shinytheme('sandstone'),
      
      h2(tags$a("Author : Josué AFOUDA", 
                href = 'https://www.linkedin.com/in/josu%C3%A9-afouda/')),
      
      h3(tags$a("Learn R Shiny",href='https://youtube.com/playlist?list=PLmJWMf9F8euStJ32KHOThQzJ7hub-JXA0')),
      
      br(),
      
      tabsetPanel(
        tabPanel(
          "The App",
          icon = icon("cogs"),
          fluidRow(
            column(12, 
                   wellPanel(radioButtons('indice', 'Choose a stock market index',
                                          choices = c('France (CAC 40)', 
                                                      'USA (S&P 500)',
                                                      'Germany (DAX)',
                                                      'England (FTSE 100)', 
                                                      'Japan (Nikkei 225)'),
                                          inline = T
                   ))  
            )
          ),
          
          fluidRow(
            column(12, wellPanel(uiOutput('MarketControl')))
          ),
          
          fluidRow(
            column(3, 
                   wellPanel(
                     
                     dateRangeInput('period', 'Date range:', 
                                    '2015-01-01', '2021-08-01'),
                     
                     radioButtons('parameter', 'Price or Return ?', 
                                  choices = c('Price', 'Return')),
                     
                     
                     sliderInput('short', 'Short Moving Average', 
                                 min = 0, max = 100, value = 10, step = 1),
                     
                     sliderInput('long', 'Long Moving Average', 
                                 min = 0, max = 200, value = 50, step = 1),
                     
                     checkboxInput('ShowData', 'Show the data', FALSE),
                     
                     actionButton(
                       "go",
                       "Submit",
                       class = "btn btn-primary btn-lg", # Bootstrap classes for styling
                       style = "color: white; background-color: #007BFF; border-color: #007BFF; margin-top: 20px; padding: 10px 20px;"
                     )
                     
                   )
            ),
            #column(9, plotlyOutput("boxplot")),
            column(4, plotlyOutput("hist", height = 440)),
            column(4, offset = 1, plotlyOutput("boxplot", height = 440))
          ),
          
          fluidRow(
            column(12, wellPanel(plotlyOutput("lineplot")))
          ),
          
          fluidRow(
            column(12, wellPanel(
              conditionalPanel(
                condition = "input.ShowData",
                numericInput("Nrows", "Number of lines to show", value = 10)
              ),
              DTOutput('StockData')
            ))
          ),
          
          
          fluidRow(
            column(3, 
                   wellPanel(
                     
                     numericInput('yearsubset', 
                                  'Specify a particular year of the serie to view (You must choose a year in the data period)', 
                                  value = 2017)
                   )
            ),
            column(9, plotOutput('Chart', height = 700))  
          )
        ),
        tabPanel(
          "Read Me",
          icon = icon("book-open"),
          includeMarkdown("./readme/quant_analysis.md")
        )
      )
      
      
      
    )
  )), after = 2)

