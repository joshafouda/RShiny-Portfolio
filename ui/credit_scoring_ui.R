
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_credit_scoring"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("Credit Scoring App", tabName = nom_tab, icon = icon("file-invoice-dollar"))), after = 4)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidRow(box(valueBoxOutput("score_prediction", width = 12)),
             box(numericInput("var1", label = "Age du demandeur de credit", 
                              value = 20, min = 18))),
    
    # fluidRow(tableOutput("new_table")),
    
    fluidRow(box(numericInput("var2", label = "Revenu annuel demandeur de credit", 
                              value = 10000, min = 0)),
             box(selectInput("var3", 
                             label = "Propriété immobilière : (MORTGAGE : hypothèque, OWN : propriétaire, RENT : Locataire, OTHER : Autres cas)", 
                             choices = c('MORTGAGE', 'OWN', 'RENT', 'OTHER')))),
    
    fluidRow(box(numericInput("var4", 
                              label = "Depuis quand le demandeur est-il en activité professionnelle ? (Durée en nombre d'années)", 
                              value = 3, min = 0)),
             box(selectInput("var5", 
                             label = "Motif du prêt : (DEBTCONSOLIDATION : Rachat d'un crédit, HOMEIMPROVEMENT : Travaux de rénovation immobilière, VENTURE : Business)", 
                             choices = c('DEBTCONSOLIDATION', 'EDUCATION', 'HOMEIMPROVEMENT', 'MEDICAL', 'PERSONAL', 'VENTURE'))),),
    fluidRow(box(selectInput("var6", 
                             label = "Catégorie du crédit", 
                             choices = c('A', 'B', 'C', 'D', 'E', 'F', 'G'))),
             box(numericInput("var7", 
                              label = "Montant du crédit", 
                              value = 2000, min = 0))),
    
    fluidRow(box(numericInput("var8", 
                              label = "Taux d'intéret du crédit (en %)", 
                              value = 3.5, min = 0)),
             box(numericInput("var9", 
                              label = "Ratio Dette/Revenu du demandeur de crédit (valeur décimale entre 0 et 1)", 
                              value = 0.1, min = 0, max = 1, step = 0.1))),
    
    fluidRow(box(selectInput("var10", 
                             label = "Est-ce que le demandeur de credit est à découvert bancaire ? : (Y : Oui, N : Non):", 
                             choices = c('Y', 'N'))),
             box(numericInput("var11", 
                              label = "Echéance des crédits en cours (en nombre d'années)", 
                              value = 5, min = 0))),
    
    br(),
    
    fluidRow(
      actionButton(
        "go",
        "Calculate the Credit Score",
        class = "btn btn-primary btn-lg", # Bootstrap classes for styling
        style = "color: white; background-color: #007BFF; border-color: #007BFF; margin-top: 20px; padding: 10px 20px;"
      )
    )
    
  )), after = 4)

