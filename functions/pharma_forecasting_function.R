
# Ajouter les fonctions spécifiques à l'application ici

# Create a connection from the URL
url_connection <- url("https://raw.githubusercontent.com/joshafouda/data_formations/main/productdb.rds", "rb")

# Read the RDS file from the URL
productdb <- readRDS(url_connection)

# Close the connection
close(url_connection)


# Médicaments les plus prescrits en terme de quantité
productdb2 <- productdb %>%
  group_by(BNFNAME, CHEMSUB) %>%
  summarise(SUMQ = sum(QUANTITY), .groups = "drop") %>%
  arrange(desc(SUMQ))

# Fonction pour trouver les 5 premiers médicaments
# (en terme de qté prescrite) dans une même catégorie
getTop5 <- function(x) {
  # x : catégorie du produit
  result <- productdb2 %>%
    filter(CHEMSUB == x) %>%
    head(5) %>%
    pull(BNFNAME)
  
  return(result)
}