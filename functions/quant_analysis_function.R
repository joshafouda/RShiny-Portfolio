
# Ajouter les fonctions spécifiques à l'application ici

# Importation des dataframes des noms des actions
dax_ticker_name <- read_csv("data/dax_tickers_names.csv")
nikkei_ticker_name <- read_csv("data/nikkei_tickers_names.csv")
sp500_ticker_name <- read_csv("data/sp500_tickers_names.csv")
cac40_ticker_name <- read_csv("data/cac40_tickers_names.csv")
ftse100_ticker_name <- read_csv("data/ftse100_tickers_names.csv")


colors <- c("Close" = "blue", "Short MA" = "red", "Long MA" = "green")