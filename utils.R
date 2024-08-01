# Création de la database SQLite movies_rental
# Charger les bibliothèques nécessaires
# library(RSQLite)
# library(readr)
# # 
# # # Créer une connexion à une nouvelle base de données SQLite
# db <- dbConnect(SQLite(), dbname = "movies_rental.sqlite")
# # 
# # Lire les fichiers CSV
# actors <- read.csv("https://raw.githubusercontent.com/joshafouda/data_formations/main/actors.csv", colClasses = c(YEAR="character"))
# actsin <- read.csv("https://raw.githubusercontent.com/joshafouda/data_formations/main/actsin.csv")
# customers <- read.csv("https://raw.githubusercontent.com/joshafouda/data_formations/main/customers.csv",
#                       colClasses = c(DATE="character"),
#                       col.names = c("customer_id", "name", "country", "gender", "date_of_birth", "date_account_start"))
# movies <- read.csv("https://raw.githubusercontent.com/joshafouda/data_formations/main/movies.csv", colClasses = c(YEAR="character"))
# renting <- read.csv("https://raw.githubusercontent.com/joshafouda/data_formations/main/renting.csv", colClasses = c(DATE="character"))
# 
# # Écrire les dataframes dans la base de données SQLite
# dbWriteTable(db, "actors", actors, overwrite = TRUE)
# dbWriteTable(db, "actsin", actsin, overwrite = TRUE)
# dbWriteTable(db, "customers", customers, overwrite = TRUE)
# dbWriteTable(db, "movies", movies, overwrite = TRUE)
# dbWriteTable(db, "renting", renting, overwrite = TRUE)
# # 
# # # Vérifier les tables dans la base de données
# tables <- dbListTables(db)
# print(tables)
# # 
# # # Fermer la connexion à la base de données
# dbDisconnect(db)

# Créer la fonction execute_query
execute_query <- function(query) {
  db <- dbConnect(SQLite(), dbname = "data/movies_rental.sqlite")
  result <- dbGetQuery(db, query)
  dbDisconnect(db)
  return(result)
}


# Charger le fichier config.json
#config <- fromJSON("config.json")
# readRenviron(".Renviron")
# Vérifier si l'environnement est Docker
# if (Sys.getenv("DOCKER_ENV") != "") {
#   # Chargement des variables d'environnement depuis .env
#   dotenv::load_dot_env()
# } else {
#   # Chargement des variables d'environnement depuis .Renviron (local)
#   readRenviron(".Renviron")
# }


# Utiliser les variables d'environnement pour la connexion
# db_user <- Sys.getenv("DB_USER")
# db_password <- Sys.getenv("DB_PASSWORD")
# db_host <- Sys.getenv("DB_HOST")
# db_port <- as.integer(Sys.getenv("DB_PORT"))
# db_name <- Sys.getenv("DB_NAME")

# Ajout de messages de débogage
# print(paste("DB_USER:", db_user))
# print(paste("DB_PASSWORD:", db_password))
# print(paste("DB_HOST:", db_host))
# print(paste("DB_PORT:", db_port))
# print(paste("DB_NAME:", db_name))

# execute_query <- function(query) {
#   
#   # Charger le driver PostgreSQL
#   drv <- dbDriver("PostgreSQL")
#   
#   # Établir la connexion
#   con <- dbConnect(drv, dbname = db_name,
#                    host = db_host, port = db_port,
#                    user = db_user, password = db_password)
#   
#   # Exécuter la requête SQL
#   result <- dbGetQuery(con, query)
#   
#   # Fermer la connexion
#   dbDisconnect(con)
#   
#   # Retourner les résultats
#   return(result)
# }


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
