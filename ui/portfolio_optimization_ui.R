linebreaks <- function(n){HTML(strrep(br(), n))}

# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_portfolio_optimization"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Portfolio Optimization App", tabName = nom_tab, icon = icon("balance-scale"))), after = 5)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    # Mettre le titre en couleur
    h1("R SHINY WEB APP FOR FINANCIAL PORTFOLIO ANALYSIS",
       style = "font-family: 'Impact'; color: red; font-size: 32px;"),
    tags$a("Encourage me to further improve this app",
           href='https://www.paypal.me/aaajosue'),
    linebreaks(1),
    tags$a("Josué AFOUDA",href='https://www.linkedin.com/in/josu%C3%A9-afouda/'),
    
    tabsetPanel(
      tabPanel(
        "The App",
        icon = icon("cogs"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              'indice',
              'Choose a stock market index',
              choices = c('France (CAC 40)',
                          'USA (S&P 500)',
                          'Germany (DAX)',
                          'England (FTSE 100)',
                          'Japan (Nikkei 225)')
            ),
            numericInput("numInputs", "Number of Assets in Portfolio", 1, max = 10),
            
            # dynamic inputs
            uiOutput("inputGroup"),
            uiOutput("inputWeights"),
            
            dateRangeInput('period', 'Date range:',
                           '2015-01-01', '2020-12-31'),
            
            selectInput("rebalance",
                        'Rebalance on:',
                        choices = c("None",
                                    "Annualy" = "years",
                                    "Quartely" = "quarters",
                                    "Monthly" = "months",
                                    "Weekly" = "weeks",
                                    "Daily" = "days")),
            
            actionButton("go", icon = icon("linux"), "Submit"),
            
            helpText(' Subsequent figures will be drawn in an nr-by-nc array'),
            numericInput('nl', 'Select nr:', 1, min = 1, step = 1),
            numericInput('nc', 'Select nc:', 1, min = 1, step = 1)
            
          ),
          # show dynamic input values
          mainPanel(textOutput("message"), textOutput("inputValues"),
                    textOutput("message2"), textOutput("inputValues2"),
                    tabsetPanel(
                      
                      # Création des onglets et sous-onglets
                      tabPanel('Prices',
                               tabsetPanel(
                                 tabPanel('Data of Prices',
                                          icon = icon("table"),
                                          DTOutput('df'),
                                          downloadButton('save_price_data', label = 'Save to CSV :')),
                                 tabPanel('Prices Statistics', verbatimTextOutput("prices_stats")),
                                 tabPanel('Histograms of Prices', plotOutput('prices_hists', 1000, 650)),
                                 tabPanel('Plot of Prices', plotOutput('plot', 1000, 650)))),
                      
                      tabPanel('Returns',
                               tabsetPanel(
                                 tabPanel("Data of Returns",
                                          DTOutput('returns'),
                                          downloadButton('save_return_data', label = 'Save to CSV :')),
                                 tabPanel('Returns Statistics', verbatimTextOutput("returns_stats")),
                                 tabPanel('Hists of Returns', plotOutput('returns_hists', 1000, 650)),
                                 
                                 tabPanel('Plot of Returns', plotOutput('plot_returns', 1000, 650)),
                                 tabPanel('Beginning Of Period ', plotOutput('bop', 1000, 650)),
                                 tabPanel('End of Period ', plotOutput('eop', 1000, 650)))),
                      
                      tabPanel('Aggregated Returns',
                               tabsetPanel(
                                 tabPanel('Mean Aggregated Returns',
                                          selectInput('time_per',
                                                      'From Daily Returns to:',
                                                      choices = c('Montly Returns',
                                                                  'Weekly Returns',
                                                                  'Quarterly Returns',
                                                                  'Yearly Returns')),
                                          
                                          DTOutput('aggregated_returns'),
                                          downloadButton('save_return_agg', label = 'Save to CSV :')),
                                 tabPanel('Aggregated Returns Stats', verbatimTextOutput("agg_returns_stats")),
                                 tabPanel('Aggregatd Returns Plots', plotOutput('plot_agg_returns', 1000, 650))
                               )),
                      
                      tabPanel('Analyzing performance',
                               tabsetPanel(
                                 tabPanel('Correlation', plotOutput('returns_cor', 1000, 650)),
                                 
                                 tabPanel('Rolling annualized mean',
                                          numericInput('Width', 'length of the window (in months):', 12, min = 1, step = 1),
                                          plotOutput('rolling_mean', 1000, 650)),
                                 tabPanel('Rolling annualized Standard Deviation',
                                          plotOutput('rolling_std', 1000, 650)),
                                 tabPanel('Rolling annualized Sharpe Ratio',
                                          plotOutput('rolling_sharpe', 1000, 650)),
                                 tabPanel('Drawdowns',
                                          plotOutput('drawdown', 1000, 650))
                               )),
                      
                      ####ONGLET PORTOFOLIO OPTIMIZATION##############
                      tabPanel('Portfolio Optimization',
                               tabsetPanel(
                                 tabPanel('Mean-Variance Efficient',
                                          tabsetPanel(
                                            tabPanel('Results', verbatimTextOutput("opt1_print")),
                                            tabPanel('Visualization', plotOutput('opt1_weights', 1000, 650)))),
                                 
                                 tabPanel('Imposing Constraints',
                                          tabsetPanel(
                                            tabPanel('Results', sliderInput('max_w', 'Max weigh:', 0.5, min = 0.05, max = 1.0), verbatimTextOutput("opt2_print")),
                                            tabPanel('Visualization', plotOutput('opt2_weights', 1000, 650)))),
                                 
                                 tabPanel('Split-Sample evaluation',
                                          tabsetPanel(
                                            tabPanel('Estimation Sample',
                                                     dateRangeInput('window_estim', 'Date range for Estimation Sample:', '2015-01-01', '2020-12-31'),
                                                     verbatimTextOutput("opt3_print")),
                                            tabPanel('Evaluation Sample',
                                                     dateRangeInput('window_eval', 'Date range for Evaluation Sample:', '2015-01-01', '2020-12-31'),
                                                     verbatimTextOutput("opt4_print")),
                                            tabPanel('Visualization', plotOutput('opt3_weights', 1000, 650))))
                                 
                                 
                               ))
                    )
          )
        )
      ),
      tabPanel(
        "Read Me",
        icon = icon("book-open"),
        includeMarkdown("./readme/finance_portfolio_optimization.md")
      )
    )
    
  )), after = 5)

