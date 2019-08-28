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

shape_camden <- readOGR(dsn = "data/camden_ward_boundary/geo_export_43237533-e0f3-4e84-9c11-3231b9f45a97.shp")
# convert to data frame
shape_camden_data <- fortify(model = shape_camden)

# Prepare Data for Chloropleth --------------------------------------------
centroids <- setNames(
  do.call("rbind.data.frame", 
          by(shape_camden_data, shape_camden_data$group, function(x) {Polygon(x[c('long', 'lat')])@labpt}))
  , c('long', 'lat')
) 

centroids$label <- shape_camden_data$id[match(rownames(centroids), shape_camden_data$group)]

theme_bare <- theme(
  axis.line = element_blank(), 
  axis.text.x = element_blank(), 
  axis.text.y = element_blank(),
  axis.ticks = element_blank(), 
  axis.title.x = element_blank(), 
  axis.title.y = element_blank(),
  legend.text=element_text(size=7),
  legend.title=element_text(size=8),
  panel.background = element_blank(),
  panel.border = element_rect(colour = "gray", fill=NA, size=0.5),
  plot.title = element_text(face = "bold", hjust = 0.5)
)

