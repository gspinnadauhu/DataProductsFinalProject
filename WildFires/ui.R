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
                                         dateRangeInput(inputID,)
                                 )
                         )
                         ),
                
                
                
                
                
                
                tabPanel("Summary","Summarize & Download Wildfire Data")
        )
    )
)