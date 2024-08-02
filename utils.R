# Créer la fonction execute_query
execute_query <- function(query) {
  db <- dbConnect(SQLite(), dbname = "data/movies_rental.sqlite")
  result <- dbGetQuery(db, query)
  dbDisconnect(db)
  return(result)
}


create_app_files <- function(app_name, menu_item, icon_name = "star", order) {
  # Define file paths
  ui_file <- file.path("ui", paste0(app_name, "_ui.R"))
  server_file <- file.path("server", paste0(app_name, "_server.R"))
  function_file <- file.path("functions", paste0(app_name, "_function.R"))
  
  # Create UI file
  ui_content <- sprintf('
# identification interne tabItem (ne pas modifier)
nom_tab <- "%s"

# Ajout menu ITEM
liste_menuitems <- append(liste_menuitems, list(menuItem("%s", tabName = nom_tab, icon = icon("%s"))), after = %d - 1)

# Ajout TABITEM avec contenu du panneau
liste_tabitems <- append(liste_tabitems, list(
  tabItem(
    tabName = nom_tab # identification interne du panneau
  )), after = %d - 1)
', paste0("tabItem_", app_name), menu_item, icon_name, order, order)
  
  writeLines(ui_content, con = ui_file)
  
  # Create server file
  server_content <- '
# Ajouter les sorties ici
'
  writeLines(server_content, con = server_file)
  
  # Create function file
  function_content <- '
# Ajouter les fonctions spécifiques à l\'application ici
'
  writeLines(function_content, con = function_file)
  
  message(sprintf("Files created:\n%s\n%s\n%s", ui_file, server_file, function_file))
}

#create_app_files("overview", "Overview", "dashboard", 1)
#create_app_files("customer_analysis", "Customer Analysis", "users", 2)
