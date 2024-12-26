# identification interne tabItem (ne pas modifier)
nom_tab <- "tabItem_about_me"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("About Me", tabName = nom_tab, icon = icon("user-circle"))), after = 0)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab, # identification interne du panneau
    fluidPage(
      # Load external CSS
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
      ),
      
      # Hero section with a professional and attractive design
      div(
        class = "jumbotron text-center",
        style = "background-color: #f4f4f4; padding: 2rem; border-radius: 8px;",
        fluidRow(
          column(3, 
                 tags$img(
                   src = "images/linkedin_profil.png", 
                   style = "width: 100%; border-radius: 50%; border: 5px solid #ddd;"
                 )
          ),
          column(9, 
                 h2("Josué AFOUDA", style = "text-align: center; font-weight: bold; color: #2C3E50;"),
                 p(
                   HTML(
                     "<strong>Data Scientist Senior</strong> with over 6 years of professional experience, specializing in data-driven decision-making, data modeling, and the development of <em>Data Products</em>. Passionate about data analysis, I am an expert in Data Visualization, Machine Learning, and Business Process Automation."
                   ),
                   style = "font-size: 16px; text-align: justify; line-height: 1.8;"
                 ),
                 div(
                   class = "social-links",
                   style = "text-align: center; margin-top: 1rem;",
                   tags$a(href = "https://www.linkedin.com/in/josué-afouda", target = "_blank", icon("linkedin", lib = "font-awesome"), style = "margin: 0 10px; font-size: 24px; color: #0077b5;"),
                   tags$a(href = "https://www.youtube.com/c/JADATATECHCONSULTING", target = "_blank", icon("youtube", lib = "font-awesome"), style = "margin: 0 10px; font-size: 24px; color: #ff0000;")
                 )
          )
        )
      ),
      
      hr(),
      
      # Professional experiences and skills section with styling
      fluidRow(
        column(8,
               h3("Professional Experiences", style = "color: #2C3E50; font-weight: bold;"),
               tags$ul(
                 class = "list-group",
                 style = "font-size: 16px; line-height: 1.8;",
                 tags$li(class = "list-group-item", strong("Data Scientist-Développeur d'applications R Shiny"), " - Danone, Londres, Angleterre (Août 2024 - Aujourd'hui)"),
                 tags$li(class = "list-group-item", strong("Data Analyst Concepteur-Développeur R Shiny"), " - EDF, Paris, Île-de-France, France (septembre 2023 - avril 2024)"),
                 tags$li(class = "list-group-item", strong("Machine Learning Engineer"), " - Groupe SII, Paris, Île-de-France, France (mai 2023 - juin 2023)"),
                 tags$li(class = "list-group-item", strong("Consultant Data Scientist - Développeur R"), " - EDF, Paris, Île-de-France, France (mai 2022 - mai 2023)"),
                 tags$li(class = "list-group-item", strong("Auteur Indépendant"), " - Amazon Kindle Direct Publishing, France (juillet 2020 - 2023)"),
                 tags$li(class = "list-group-item", strong("Formateur Freelance en Python, SQL et Machine Learning"), " - Clients: GROUPE PERSPECTIVE, STRAFORMATION, COURS ACADEMY, France (décembre 2021 - mai 2022)")
                 # Add additional experiences here
               )
        ),
        column(4,
               h3("Technical Skills", style = "color: #2C3E50; font-weight: bold;"),
               tags$ul(
                 class = "list-group",
                 tags$li(class = "list-group-item", "Programming: Python (Scikit-learn, Pandas, PySpark, ...), R (Tidyverse, Sparklyr, ...), SQL"),
                 tags$li(class = "list-group-item", "Data Visualization: R Shiny, ggplot2, Plotly, Tableau, PowerBI"),
                 tags$li(class = "list-group-item", "Modeling: Machine Learning, Deep Learning, Time Series Models"),
                 tags$li(class = "list-group-item", "Databases: PostgreSQL, Oracle, MongoDB, MySQL, InfluxDB"),
                 tags$li(class = "list-group-item", "Web Development & Cloud: R Shiny, Flask, FastAPI, Azure")
               )
        )
      )
    )
  )
), after = 0)
