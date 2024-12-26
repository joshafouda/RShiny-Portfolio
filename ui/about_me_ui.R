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
          style = "display: flex; flex-direction: column; align-items: center; text-align: center;",
          tags$img(
            src = "images/linkedin_profil.png", 
            style = "width: 150px; height: 150px; border-radius: 50%; margin-bottom: 1rem; border: 3px solid #FF8C00;"
          ),
          div(
            style = "max-width: 600px;",
            h2("Josué (Joshua) AFOUDA", style = "font-weight: bold; color: #2C3E50; margin-bottom: 1rem;"),
            p("Experienced Data Scientist with over 6 years of expertise in building data-driven solutions and innovative applications.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50; margin-bottom: 1rem;"),
            p("Passionate about data visualization, machine learning, and simplifying complex data processes for impactful results.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50; margin-bottom: 1rem;"),
            p("Connect with me on LinkedIn or subscribe to my YouTube channel for insightful content on data science.", style = "font-size: 18px; line-height: 1.5; color: #2C3E50; margin-bottom: 2rem;"),
            div(
              class = "social-links",
              style = "display: flex; justify-content: center; gap: 20px;",
              tags$a(href = "https://www.linkedin.com/in/josué-afouda", target = "_blank", icon("linkedin", lib = "font-awesome"), style = "font-size: 30px; color: #0077b5;"),
              tags$a(href = "https://www.youtube.com/c/JADATATECHCONSULTING", target = "_blank", icon("youtube", lib = "font-awesome"), style = "font-size: 30px; color: #ff0000;")
            )
          )
        )
      )
    )
  )
), after = 0)
