
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
      # Hero section with image and bio
      fluidRow(
        column(3, # Column for image
               tags$img(src = "images/linkedin_profil.png")
        ),
        column(9, # Column for text
               h2(tags$div("Josué AFOUDA", style = "text-align: center;")),
               h4(HTML("
                      <strong>Data Scientist Senior</strong> avec plus de 6 ans d'expériences professionnelles, j'accompagne les entreprises dans la prise de décisions basées sur l'analyse et la modélisation des données ainsi que le développement de <em>Data Products</em>.
                      <br>
                      Passionné par l'analyse de données, je suis spécialiste en DataViz, Machine Learning, Construction d'applications Data Science et Automatisation des processus Métier.
                      <br>
                      Mon parcours professionnel inclut des rôles variés tels que Data Scientist Python, R & SQL, Développeur R & R Shiny, Data Analyst SQL & R, Machine Learning Engineer PyTorch & Scikit-Learn, Développeur Python et Formateur indépendant pour des particuliers et aussi pour des professionnels dans de grandes entreprises.
                      <br>
                      J'ai eu l'opportunité de travailler en tant que Consultant pour diverses organisations telles que le PNUD (Programme des Nations Unies pour le Développement), EDF, Danone, Groupe Perspective, Groupe SII, etc.
                      <br>
                      Je suis également passionné par le partage du savoir, ce qui m'a conduit à créer une chaîne YouTube : <a href='https://www.youtube.com/c/JADATATECHCONSULTING' target='_blank'>JADATATECHCONSULTING</a>. Les professionnels et passionnés de data peuvent me contacter par mail : afouda.josue@gmail.com ou sur LinkedIn : <a href='https://www.linkedin.com/in/josué-afouda' target='_blank'>Josué Afouda</a>.
                      <br>
                      En outre, j'ai écrit et publié une dizaine de livres sur <a href='https://www.amazon.fr/stores/Josu%C3%A9-AFOUDA/author/B08F17S1V8?ref=sr_ntt_srch_lnk_1&qid=1722799080&sr=8-1&isDramIntegrated=true&shoppingPortalEnabled=true' target='_blank'>Amazon</a> sur des thématiques telles que R Shiny, Python, Machine Learning, Deep Learning, IA, etc.
                    "))
               
        )
      ),
      hr(), # Horizontal line for separation
      fluidRow(
        column(8, # Expériences Professionnelles
               h3("Expériences Professionnelles"),
               tags$ul(
                 tags$li(strong("Data Scientist-Développeur d'applications R Shiny"), " - Danone, Londres, Angleterre (Août 2024 - Aujourd'hui)"),
                 tags$li(strong("Data Analyst Concepteur-Développeur R Shiny"), " - EDF, Paris, Île-de-France, France (septembre 2023 - avril 2024)"),
                 tags$li(strong("Machine Learning Engineer"), " - Groupe SII, Paris, Île-de-France, France (mai 2023 - juin 2023)"),
                 tags$li(strong("Consultant Data Scientist - Développeur R"), " - EDF, Paris, Île-de-France, France (mai 2022 - mai 2023)"),
                 tags$li(strong("Auteur Indépendant"), " - Amazon Kindle Direct Publishing, France (juillet 2020 - 2023)"),
                 tags$li(strong("Formateur Freelance en Python, SQL et Machine Learning"), " - Clients: GROUPE PERSPECTIVE, STRAFORMATION, COURS ACADEMY, France (décembre 2021 - mai 2022)"),
                 tags$li(strong("Formateur en Maths, Physiques-Chimie et Informatique"), " - Education Nationale, France (septembre 2018 - avril 2021)"),
                 tags$li(strong("Data Scientist (Stage)"), " - Groupement Eau, Sol et Environnement (GRESE), France (février 2018 - juillet 2018)"),
                 tags$li(strong("Data Scientist"), " - HYDRO-JOB Sarl, Bénin (juin 2016 - août 2017)"),
                 tags$li(strong("Data Scientist Prévisionniste"), " - Programme des Nations Unies pour le Développement (PNUD), Bénin (décembre 2014 - mai 2016)"),
                 tags$li(strong("Data Scientist Prévisionniste (Stage)"), " - Laboratoire d'Hydrologie Appliquée, Bénin (juin 2014 - décembre 2014)")
               )
        ),
        column(4, # Technical Skills
               h3("Compétences Techniques"),
               p("Programmation : Python (Scikit-learn, Pandas, PySpark, ...), R (Tidyverse, Sparklyr, ...), SQL"),
               p("Visualisation des données : R Shiny, ggplot2, Plotly, Tableau, PowerBI"),
               p("Modélisation : Machine Learning, Deep Learning, modèles de séries temporelles"),
               p("Bases de données : PostgreSQL, Oracle, MongoDB, MySQL, InfluxDB"),
               p("Développement Web, APIs et Cloud : R Shiny, Shiny for Python, Streamlit, Flask, FastAPI, Azure")
        )
      )
    )
  )), after = 0)

