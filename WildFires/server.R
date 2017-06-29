#loading libraries & the wildfire data file
library(shiny)
library(leaflet)
library(plotly)
library(tidyverse)
fires<-read.csv("./data/fires.csv")

shinyServer(function(input, output) {
        mapset<-reactive({
                subset(fires, STATE %in% input$StateInput & FIRE_YEAR %in% input$DateInput)
                })
        output$firemap<-renderLeaflet({
                leaflet(
                        mapset()
                        ) %>%
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
        statelist<-reactive({input$StateInput})
        output$fireplot<-renderPlotly({
                plot_ly(
                        mapset(),
                        x=~FIRE_SIZE,
                        y=~as.character(STATE),
                        color=~as.character(STATE),
                        type="box"
                        ) %>%
                layout(
                        title="Fire Size Distributions by State",
                        yaxis=list(title=FALSE,
                                   autotick=FALSE,
                                   autorange="reversed"),
                        xaxis=list(title="Area Burnt in Acres")
                        )
        }
        )
}
)