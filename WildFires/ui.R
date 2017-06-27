library(shiny)
library(leaflet)
library(tidyverse)

# Define UI for application that shows and summarizes wildfire occurrences in the US
shinyUI(
    fluidPage(
        # Application title
        titlePanel("USDA Forestry Service Wild Fire Occurrences 1992-2015"),        
        tabsetPanel(
                tabPanel("Map",
                         sidebarLayout(
                                 #Side Panels to select Date Range & State
                                 sidebarPanel(
                                         checkboxGroupInput("DateInput",
                                                            "Years",
                                                            choices=sort(unique(fires$FIRE_YEAR),
                                                                         decreasing=FALSE),
                                                            inline=TRUE),
                                         selectInput("StateInput",
                                                     "State(s)",
                                                     sort(unique(fires$STATE),
                                                          decreasing = FALSE),
                                                     selected=NULL,
                                                     multiple = TRUE),
                                         submitButton("Apply Selection")
                                 ),
                                 #Main Panel to display a map with fire locations
                                 mainPanel(
                                         leafletOutput("firemap")
                                 )
                         )
                         ),
                tabPanel("Summary","Summarize & Download Wildfire Data")
        )
    )
)