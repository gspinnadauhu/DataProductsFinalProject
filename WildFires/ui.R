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
                                                            choices=unique(fires$FIRE_YEAR)),
                                         selectInput("StateInput",
                                                     "State(s)",
                                                     unique(fires$STATE),
                                                     selected=unique(fires$STATE),
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