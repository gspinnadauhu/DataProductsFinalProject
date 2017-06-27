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
                                         popup=~paste(sep="<br/>",
                                                      "<b>Fire Name:</b>",
                                                      as.character(mapset$FIRE_NAME),
                                                      "<b>Size Class:</b>",
                                                      as.character(mapset$FIRE_SIZE_CLASS),
                                                      "<b>FIPS Name:</b>",
                                                      as.character(mapset$FIPS_NAME)),
                                         clusterOptions=markerClusterOptions()
                                         )
        }
        )
        output$FireSummary<-renderTable()
}
)