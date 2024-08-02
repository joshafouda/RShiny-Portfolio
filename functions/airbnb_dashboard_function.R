
# Ajouter les fonctions spécifiques à l'application ici

newyork <- read.csv('data/new_york.csv')
sanfrancisco <- read.csv('data/san_francisco.csv')
amsterdam <- read.csv('data/amsterdam.csv')

newyork <- newyork %>%
  mutate(price = as.numeric(str_replace_all(price, ",", "")))