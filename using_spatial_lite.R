# sqlite & spatiallite

# https://www.gaia-gis.it/fossil/spatialite_gui/index
# https://www.bostongis.com/PrinterFriendly.aspx?content_name=spatialite_tut01
# https://live.osgeo.org/en/quickstart/spatialite_quickstart.html
# https://simonwillison.net/2017/Dec/12/location-time-zone-api/

library(sf)
library(RSQLite)
library(dplyr)
#library(DBI)

# CREATE NEW SQLITE DB WITH SPATIALITE ------------------------------------

# in command line:
# spatialite test_spatialite_db.sqlite

# Connect to existing db --------------------------------------------------

# using dplyr
# sf_db <- src_sqlite("sfbay.sqlite", create = F) 
# src_tbls(sf_db) # see tables in DB

# using RSQlite
db <- "sfbay.sqlite"
dbcon <- dbConnect(dbDriver("SQLite"), db)
dbListTables(dbcon) # list all tables in DB

# get shapes from db ------------------------------------------------------

# use sf to read shapes from db
watersheds <- st_read(db, "watersheds")
flowlines <- st_read(db, "flowlines")
centroids <- st_read(db, "centroids")

dbDisconnect(dbcon)

# Plot with sf ------------------------------------------------------------

# plot
plot(watersheds$geom)
plot(flowlines$geom, add=T, col="blue")
plot(centroids$geom, add=T, pch = 16, col="orange")

# library(mapview)
# mapview(flowlines)

# add shps w spatialite ---------------------------------------------------

# CAN use spatialite in shell:
# spatialite sfbay.sqlite
# .loadshp data/gis/CA_dams CA_dams UTF-8 3310
# add EPSG code at end to ensure projection

# Re-read and check -------------------------------------------------------

# using RSQlite
db <- "sfbay.sqlite"
dbcon <- dbConnect(dbDriver("SQLite"), db)
dbListTables(dbcon) # list all tables in DB


watersheds <- st_read(db, "watersheds")

plot(watersheds$geom, lwd=2)

# disconnect
dbDisconnect(dbcon)
