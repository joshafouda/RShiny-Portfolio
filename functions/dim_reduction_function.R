# 
# # Ajouter les fonctions spécifiques à l'application ici
# 
# # S'assurer de la reproductibilité des résultats de l'algorithme t-SNE qui est un processus aléatoire
# 
# seed = 111
# 
# set.seed(seed)
# 
# # Fonction pour normaliser les donnees entre 0 et 1
# 
# normalize <- function(x) {
#   return ((x - min(x)) / (max(x) - min(x)))
# }