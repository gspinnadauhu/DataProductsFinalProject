library(shiny)
library(leaflet)

# Define UI for application that shows and summarizes wildfire occurrences in the US
shinyUI(
    fluidPage(
        # Application title
        titlePanel("USDA Forestry Service Wild Fire Occurrences 1992-2015"),        
        tabsetPanel(
                tabPanel("Map",
                         sidebarLayout(
                                 sidebarPanel(
                                         dateRangeInput("DateInput",
                                                        "Date Range",
                                                        start="1992-01-01",
                                                        end="2015-12-31",
                                                        min="1992-01-01",
                                                        max="2015-12-31"),
                                         selectInput("StateInput",
                                                     "State(s)",
                                                     unique(fires$STATE),
                                                     selected=unique(fires$STATE),
                                                     multiple = TRUE)
                                 ),
                                 mainPanel(
                                         leafletOutput("firemap")
                                 )
                         )
                         ),
                tabPanel("Summary","Summarize & Download Wildfire Data")
        )
    )
)