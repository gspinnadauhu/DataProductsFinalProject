# SQLite Database was downloaded from https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/ and extracted in ./data
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
write.csv(fires[,-39],file="./WildFires/data/fires.csv",row.names=FALSE)
