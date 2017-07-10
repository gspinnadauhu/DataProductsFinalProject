library(shiny)
library(leaflet)
library(plotly)
library(tidyverse)
#loading variabes for inputs
states<-readRDS("./data/states.rds")
fire_year<-readRDS("./data/fire_year.rds")

# Define UI for application that shows and summarizes wildfire occurrences in the US
shinyUI(
    fluidPage(
        # Application title
        titlePanel("USDA Forestry Service Wild Fire Occurrences 1992-2015"),
        sidebarLayout(
                #Side Panels to select Date Range & State
                sidebarPanel(h4("Please select 1+ year(s) and 1+ state(s)."),
                                h4("Next, click 'Apply Selection'"),
                        checkboxGroupInput("DateInput",
                                           "Years",
                                           choices=sort(fire_year,
                                                        decreasing=FALSE),
                                           inline=TRUE),
                        selectInput("StateInput",
                                    "State(s)",
                                    sort(states,
                                         decreasing = FALSE),
                                    selected=NULL,
                                    multiple = TRUE),
                        submitButton("Apply Selection")
                        ),
                #Main Panel to display a map with fire locations
                mainPanel(
                        tabsetPanel(
                                tabPanel("Fire Locations",
                                         leafletOutput("firemap"),
                                         p("Click on clusters to zoom in further and/or click on fire locations to access Name, Size Class and County.")),
                                tabPanel("Fire Size Summary",
                                         plotlyOutput("fireplot"),
                                         p("Move/Hover cursor over plots to view 5-Number Summary."),
                                         p(""),
                                         h4("Summary of Damage in Acres per State & Year"),
                                         tableOutput("burntarea"))
                        )
                )
        )
    )
)