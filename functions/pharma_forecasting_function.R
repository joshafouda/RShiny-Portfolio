
# Ajouter les fonctions spécifiques à l'application ici

# Importation des données
productdb <- readRDS("data/productdb.rds")

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