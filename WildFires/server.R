#loading libraries & the wildfire data file
library(shiny)
library(leaflet)
library(plotly)
library(tidyverse)
#fires<-read.csv("./data/fires.csv")

shinyServer(function(input, output) {
        mapset<-reactive({
                subset(fires, STATE %in% input$StateInput & FIRE_YEAR %in% input$DateInput)
                })
        output$firemap<-renderLeaflet({
                leaflet(mapset()) %>%
                        addProviderTiles(providers$CartoDB.Positron) %>%
                        addCircleMarkers(~LONGITUDE,
                                         ~LATITUDE,
                                         popup=~paste(sep="<br/>",
                                                      "<b>Fire Name:</b>",
                                                      as.character(FIRE_NAME),
                                                      "<b>Size Class:</b>",
                                                      as.character(FIRE_SIZE_CLASS),
                                                      "<b>FIPS Name:</b>",
                                                      as.character(FIPS_NAME)),
                                         clusterOptions=markerClusterOptions()
                                         )
        }
        )
        output$fireplot<-renderPlotly({
                plot_ly(mapset(),
                        y=~FIRE_SIZE,
                        x=~STATE,
                        color=~STATE,
                        type="box")
        }
        )
}
)