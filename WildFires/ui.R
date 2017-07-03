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
                sidebarPanel(
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
                                         leafletOutput("firemap")),
                                tabPanel("Fire Size Summary",
                                         plotlyOutput("fireplot"),
                                         tableOutput("burntarea"))
                        )
                )
        )
    )
)