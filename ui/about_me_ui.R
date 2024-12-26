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
      
      # Full-screen background section
      div(
        style = "background: linear-gradient(135deg, #FF8C00, #32CD32); height: 100vh; display: flex; align-items: center; justify-content: center; color: white; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8);",
        div(
          style = "background-color: rgba(255, 255, 255, 0.9); padding: 2rem; border-radius: 10px; display: flex; flex-direction: row; align-items: center; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);",
          tags$img(
            src = "images/linkedin_profil.png", 
            style = "width: 150px; height: 150px; border-radius: 50%; margin-right: 2rem; border: 3px solid #FF8C00;"
          ),
          div(
            style = "max-width: 600px; text-align: left;",
            h2("Josué AFOUDA", style = "font-weight: bold; color: #2C3E50;"),
            p("Experienced Data Scientist with over 6 years of expertise in building data-driven solutions and innovative applications.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50;"),
            p("Passionate about data visualization, machine learning, and simplifying complex data processes for impactful results.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50;"),
            p("Connect with me on LinkedIn or subscribe to my YouTube channel for insightful content on data science.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50;"),
            div(
              class = "social-links",
              style = "margin-top: 1rem;",
              tags$a(href = "https://www.linkedin.com/in/josué-afouda", target = "_blank", icon("linkedin", lib = "font-awesome"), style = "margin: 0 10px; font-size: 24px; color: #0077b5;"),
              tags$a(href = "https://www.youtube.com/c/JADATATECHCONSULTING", target = "_blank", icon("youtube", lib = "font-awesome"), style = "margin: 0 10px; font-size: 24px; color: #ff0000;")
            )
          )
        )
      )
    )
  )
), after = 0)
