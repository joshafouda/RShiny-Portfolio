
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_customer_churn"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Customer Churn Dashboard", tabName = nom_tab, icon = icon("user-times"))), after = 1)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(
      column(8,
             fluidRow(
               valueBoxOutput("totalCustomers"),
               valueBoxOutput("churnedCustomers"),
               valueBoxOutput("churnRate")
             ),
             fluidRow(selectInput("account_length_plot_type", "Churn Rate by:", choices = c("Account Lenght", "Account Lenght and Contrat Type")), 
                      plotlyOutput("plotChurnRateAccountLength", height = "350px"))
      ),
      column(4, 
             fluidRow(valueBoxOutput("avgTenure", width = 6), valueBoxOutput("avgMonthlyCharges", width = 6)),
             selectInput("categ_var", "Churn Rate by:", 
                         choices = c("Churn Category", "Contract Type", "Payment Method", "Gender")), 
             plotlyOutput("plotChurnByCategVar", height = "345px")
             )
    ),
    br(), br(),
    fluidRow(
      column(4, plotlyOutput("plotChurnReasons")),
      column(4, leafletOutput("mapChurnRates")),
      column(4, plotlyOutput("plotDataUsage"))
    ),
    br(), br(),
    fluidRow(
      column(6, plotlyOutput("plotChurnAge")),
      column(6, plotlyOutput("plotChurnGroup"))
    ),
    br(), br(),
    fluidRow(
      box(width = 12, plotlyOutput("plotServiceCalls"))
    )
  )), after = 1)

