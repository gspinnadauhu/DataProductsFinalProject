#loading the wildfire data file
#fires<<-read.csv("./WildFires/data/fires.csv")
library(shiny)
library(leaflet)
library(tidyverse)

shinyServer(function(input, output) {
        output$firemap<-renderLeaflet({
                leaflet({mapset<-fires %>%
                                select(STATE,FIRE_YEAR,FIRE_NAME,FIRE_SIZE_CLASS,FIPS_NAME,FIRE_SIZE,LATITUDE,LONGITUDE) %>%
                                filter(STATE %in% input$StateInput & FIRE_YEAR %in% input$DateInput)
                        }
                        ) %>%
                        addProviderTiles(providers$CartoDB.Positron) %>%
                        addCircleMarkers(~mapset$LONGITUDE,
                                         ~mapset$LATITUDE,
                                         popup=~paste("Fire Name:",
                                                      as.character(mapset$FIRE_NAME),
                                                      "Size Class:",
                                                      as.character(mapset$FIRE_SIZE_CLASS),
                                                      "FIPS Name:",
                                                      as.character(mapset$FIPS_NAME)),
                                         clusterOptions=markerClusterOptions()
                                         )
        }
        )
}
)