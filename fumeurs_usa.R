library(leaflet)
library(dplyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

states <- ne_states(country = "United States of America", returnclass = "sf")

set.seed(123)  # Pour la reproductibilité
states$fumeurs <- runif(nrow(states), min = 9.7, max = 29.2) %>% round(1)

pal <- colorBin(palette = c("#ccece6", "#99d8c9", "#66c2a4", "#2ca25f", "#006d2c"), 
                domain = states$fumeurs, bins = c(9.7, 13.6, 17.5, 21.4, 25.3, 29.2))

# Créer la carte avec Leaflet
leaflet(data = states) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%  # Vue centrée sur les USA
  addPolygons(fillColor = ~pal(fumeurs),
              fillOpacity = 0.7,
              color = "#BDBDC3",
              weight = 1,
              popup = ~paste(name, ":", fumeurs, "% de fumeurs"),
              label = ~paste(round(fumeurs, 1), "%"),  # Afficher les pourcentages sur la carte
              labelOptions = labelOptions(style = list("font-weight" = "normal", color = "#FFFFFF"),
                                          textOnly = TRUE)) %>%
  addLegend("bottomright", pal = pal, values = ~fumeurs,
            title = "Pourcentage de fumeurs",
            labFormat = labelFormat(suffix = "%"))