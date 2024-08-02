
# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_dim_reduction"

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidPage(
      
      # theme = shinytheme("flatly"),
      
      h1("R SHINY APP FOR K-MEANS CLUSTERING AND DIMENSIONALITY REDUCTION"),
      
      h2("Author : Josue AFOUDA"),
      
      tags$a("Follow me on Linkedin",href='https://www.linkedin.com/in/josu%C3%A9-afouda/'),
      
      sidebarLayout(
        sidebarPanel(
          textInput('file', "Entrez l'url du fichier CSV de vos donnees :",
                    value = 'https://raw.githubusercontent.com/JosueAfouda/Mes-Projets-R-Shiny/main/iris_num.csv'),
          
          
          checkboxInput("header", "Header", TRUE),
          
          helpText("Decochez ce bouton si votre fichier n'a pas de noms de colonnes"),
          
          selectInput('scaled_met', 'Normalisation ou Standardisation des donnees :',
                      c('None',
                        'Normalisation',
                        'Standardisation')),
          
          selectInput('dim_reduction', 'Dimensionnality Reduction:', 
                      c('PCA',
                        'T-SNE')),
          
          conditionalPanel(
            condition = "input.dim_reduction == 'T-SNE'",
            checkboxInput("pca_tsne", "T-SNE with PCA or not:", FALSE),
            numericInput('n_iter', 'Number of iterations:', 1000, min = 1000, step = 500)
          ),
          
          helpText("Le nombre de clusters est un entier naturel strictement positif"),
          
          numericInput('n_clusters', 
                       'Selectionnez le nombre de clusters :', 
                       value = 3, min = 1),
          
          helpText("Choisissez les 2 variables a representer dans un nuage de points"),
          
          numericInput('varx', 'Numero de la variable en Axe X :', 
                       value = 1, min = 1),
          
          numericInput('vary', 'Numero de la variable en Axe Y :', 
                       value = 2, min = 1),
          
          helpText("Cliquer sur 'Submit' après chaque changement de paramètre(s)"),
          
          actionButton(
            "go",
            "Submit",
            class = "btn btn-primary btn-lg", # Bootstrap classes for styling
            style = "color: white; background-color: #007BFF; border-color: #007BFF; margin-top: 20px; padding: 10px 20px;"
          )
          
        ),
        
        # Tableaux et Graphiques dans le panneau principal
        mainPanel(
          tabsetPanel(
            tabPanel('Cleaned Data', DTOutput('dataframe'), 
                     downloadButton('download_clean_data', label = 'Telechargez les donnees nettoyees :')),
            
            tabPanel('Norm/Stand Data', DTOutput('scaled'), 
                     downloadButton('download_stand_data', label = 'Telechargez les donnees standardisees ou nourmalisees :')),
            
            tabPanel('Dim. Reduction', 
                     conditionalPanel(condition = "input.dim_reduction == 'PCA'",
                                      plotOutput("pca_screeplot"), 
                                      plotOutput("pca_biplot"),
                                      numericInput('first_cp', 'How many first components do you want to choose ?', 2, min = 1, step = 1),
                                      DTOutput('table_pca'),
                                      downloadButton('save_pca_data', label = 'Save PCA Data :'),
                     ),
                     
                     conditionalPanel(condition = "input.dim_reduction == 'T-SNE'",
                                      plotOutput("tsne_costs_plot"),
                                      DTOutput("tsne_data"),
                                      downloadButton('save_tsne_data', label = 'Save TSNE Data :'),
                                      
                                      plotOutput('tsne_biplot'))
                     
            ), 
            
            tabPanel('Elbow Method', plotlyOutput('elbow', height = "550px")),
            
            tabPanel('Average Silhouette', plotlyOutput('silhouette', height = "550px")),
            
            tabPanel('Clusters Visualization', plotOutput("scatter_plot", 850, 600))
            
          )
          
        )
      )
    )
  )), after = length(liste_tabitems))

