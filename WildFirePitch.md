Mapping & Exploring Spatial Wildfire Occurance Data for 1992-2015
========================================================
author: gspinnada uhu
date: July 5th, 2017
autosize: true

Data Source
========================================================

The data were compiled by Karen C. Short of the USDA Forest Service Research. </br>
Various spatial database formats can be downloaded here: </br>
<https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/>.

- Data accessed in June, 2017
- Script for data extraction available here: </br>
<https://github.com/gspinnadauhu/DataProductsFinalProject/blob/master/FinalProjectDataPrep.R>

Background
========================================================

### What?
- Access basic information on wild fires in the U.S. between 1992 and 2015
- Visualize wildfire locations by state(s) & year(s)
- Summary statistics on wildfire damage area

### Why?
- Data are currently only available as various geodatabase formats
- Without GIS knowledge, visualizing or extracting basic information would be prohibitively difficult to a layperson.

### How?
- Select 1 or more years and 1 or more states
- Zoom & Expore the map by clicking on the bubbles
- Zoom & Explore the distribution of fire size by state
- Calculate total area burnt based on selection

Sample Map Code: Wildfires in California 2005-07
========================================================

```r
library(leaflet)
library(webshot)
library(htmlwidgets)
firepitch<-readRDS("./WildFires/data/firepitch.rds")
map<-leaflet(firepitch) %>%
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
saveWidget(map, file = "./firepitch_map.html")
```

Sample Map: Wildfires in California 2005-07
========================================================
<iframe src="./firepitch_map.html" style="position:absolute;height:100%;width:100%"></iframe>
