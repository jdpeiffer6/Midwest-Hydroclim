setwd("C:\\Users\\JD\\Documents\\StateParks\\Data\\HCN")
library(rnoaa)

stations <- ghcnd_stations()
MOstations=subset(stations,state=='MO')

over40=subset(MOstations,first_year<=1981)
uptonow=subset(MOstations,last_year>=2019 & (element=='PRCP'|element=='TMAX'|element=='TMIN'))

View(ghcnd_search(uptonow[1,1]))               
