
#create Project Template
#install.packages('ProjectTemplate')
library(ProjectTemplate)
#install.packages("tidyverse")
#library(tidyverse)
library(dplyr)
library(tidyr)
library(reshape2)
library(ggplot2)
library(rgdal)
library(leaflet)
#library(broom)



#devtools to load Github tools and packages
#install.packages('devtools')
library(devtools)
devtools::install_github('johnmyleswhite/ProjectTemplate')

# 1. set working directory, 2. create project, 3. go to project, 4. load project
setwd("C:/Users/Hannah Bohle/Dropbox/R_wissen/berlinnames")
#create.project('berlinnames')
#setwd("C:/Users/Hannah Bohle/Dropbox/R_wissen/berlinnames")
getwd()
load.project()# funktioniert nicht - warum?
list.files()

# MAP Cloropleth https://www.r-graph-gallery.com/interactive-charts/

# Download .shp file on the web:
#download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="world_shape_file.zip")
# https://github.com/funkeinteraktiv/Berlin-Geodaten


# Die WD stimmt, shp lässt sich aber nur mit absolutem Pfad aufrufen, 
# File existiert, ich habe nichts verändert, trotzdem funktioniert obiger Befehl nun plötzlich :-/
getwd()
list.files()
setwd('./data/Berlin-Geodaten-master/')
list.files()
setwd("./berlin_bezirke_shp")
#list.files('../data/Berlin-Geodaten-master/berlin_bezirke_shp', pattern='\\.shp$')
list.files(pattern='\\.shp$')
file.exists('berliner_bezirke.shp')

library(leaflet)
library(rgdal)
berlin_spdf=readOGR(dsn= getwd(), layer="berliner_bezirke",use_iconv = TRUE, encoding = "UTF-8")

#I need to fix the encoding, to display the Umlaut in Neukölln correctly
#help(readOGR)

# Look at the info provided with the geospatial object
head(berlin_spdf@data)
summary(berlin_spdf@data)
print(berlin_spdf@data)
berlin_spdf$name # contains kiez name

#Plots Berlin with lightgreen background
par(mar=c(0,0,0,0))
plot(berlin_spdf, col="#f2f2f2", fill=TRUE, bg="lightgreen", lwd=0.25, mar=rep(0,4), border=0 )
library (ggplot2)
# https://medium.com/@anjesh/step-by-step-choropleth-map-in-r-a-case-of-mapping-nepal-7f62a84078d9
berlin<-ggplot(data = berlin_spdf, aes(x = long, y = lat, group = group))
berlin+geom_path() # plottet die outlines der kieze

berlin + 
  geom_polygon(aes(fill = id)) + # plottet die Kieze als Polygone
  coord_fixed(1.3) +
  guides(fill = FALSE) 

head(berlin_spdf)

#install.packages("dplyr")
#library(dplyr)
#berlin_spdf %>%
#  summarise(unique(,berlin_spdf$name)) %>% # not working somehow
 #write.csv("kieze.csv", row.names = FALSE)

#berlin_spdf2 <- merge(berlin_spdf, data, by ="id") # data fehlt noch, siehe unten


# Modify these info
#berlin_spdf@data$POP2005[ which(berlin_spdf@data$POP2005 == 0)] = NA
#berlin_spdf@data$POP2005 = as.numeric(as.character(berlin_spdf@data$POP2005)) / 1000000 %>% round(2)




# Basic choropleth with leaflet?
#leaflet(berlin_spdf) %>% 
#df  addTiles()  %>% 
#  setView( lat=10, lng=0 , zoom=2) %>%
 # addPolygons( fillColor = ~mypalette(POP2005), stroke=FALSE )

#Connection of CSV INformation and borders
#install.packages("dplyr")
#install.packages("readr")
