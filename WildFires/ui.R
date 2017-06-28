library(shiny)
library(leaflet)
library(tidyverse)
#loading variabes for inputs
states<-read.csv("./data/states.csv")
fire_year<-read.csv("./data/fire_year.csv")

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
                                           choices=sort(fire_year$x,
                                                        decreasing=FALSE),
                                           inline=TRUE),
                        selectInput("StateInput",
                                    "State(s)",
                                    sort(states$x,
                                         decreasing = FALSE),
                                    selected=NULL,
                                    multiple = TRUE),
                        submitButton("Apply Selection")
                        ),
                #Main Panel to display a map with fire locations
                mainPanel(
                        tabsetPanel(
                                tabPanel("Fire Locations",leafletOutput("firemap")),
                                tabPanel("Fire Size Summary",plotlyOutput("fireplot"))
                        )
                )
        )
    )
)