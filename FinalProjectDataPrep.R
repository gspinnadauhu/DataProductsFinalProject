# SQLite Database was downloaded from https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/ and extracted in ./download
# Connecting to SQLite file containing data on wildfires in US
library(tidyverse)
library(RSQLite)
connection<-dbConnect(drv=RSQLite::SQLite(),"./download/FPA_FOD_20170508.sqlite")
tables <- dbListTables(connection)
## the only table needed is "Fires", writing query for fires
query<-dbSendQuery(connection, "SELECT * FROM Fires")
fires<-dbFetch(query,n=-1)
## closing the connection
dbClearResult(query)
dbDisconnect(connection)
## save fires in ./data as csv, excluding shape column which does not contain useful info
fires<-select(fires,STATE,FIRE_YEAR,FIRE_NAME,FIRE_SIZE_CLASS,FIPS_NAME,FIRE_SIZE,LATITUDE,LONGITUDE)
states<-as.character(unique(fires$STATE))
fire_year<-unique(fires$FIRE_YEAR)
saveRDS(states,file="./WildFires/data/states.rds")
saveRDS(fire_year,file="./WildFires/data/fire_year.rds")
saveRDS(fires,file="./WildFires/data/fires.rds")
