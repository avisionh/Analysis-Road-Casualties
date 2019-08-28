# ------------------ #
# 3_1_analysis_where #
# ------------------ #

# ------------------------------------------
# DESC: Analyses where road casualties in Camden are taking place
# SCRIPT DEPENDENCIES: none
# PACKAGE DEPENDENCIES:
# 1. 'dplyr'
# 2. 'rgdal'
# 3. 'ggplot2'


# NOTES: Guidance available here:
#         https://medium.com/@anjesh/step-by-step-choropleth-map-in-r-a-case-of-mapping-nepal-7f62a84078d9
# ------------------------------------------

library(dplyr)
library(rgdal)
library(ggplot2)

shape_camden <- readOGR(dsn = "data/camden_ward_boundary/geo_export_10000172-4451-416d-89b7-a10ff0869756.shp")
shape_camden_data <- fortify(model = shape_camden)

map <- ggplot(data = shape_camden_data, aes(x = long, y = lat, group = group))

map + 
  geom_polygon(mapping = aes(fill = id)) +
  coord_fixed(1.3) +
  guides(fill = FALSE)