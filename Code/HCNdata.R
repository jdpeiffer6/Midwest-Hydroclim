setwd("C:\\Users\\Julia\\Documents\\StateParks\\Data\\HCN")
library(rnoaa) 

stations <- ghcnd_stations()  
MOstations=subset(stations,state=='MO')

over40=subset(MOstations,first_year<=1981)
uptonow=subset(MOstations,last_year>=2019 & (element=='PRCP'|element=='TMAX'|element=='TMIN'))
save(uptonow, file="uptonow.Rdata")

station <- ghcnd_search(uptonow[1,1])            

load("MOstations.Rdata")

makeName= function(row,dataList){
  name=paste((dataList[row,1]),(dataList[row,6]), (dataList[row,9]),".Rdata", sep="_" )
  return(name)
}

#need to search ghcnd for id
#make name 
setwd("C:\\Users\\Julia\\Documents\\StateParks\\Data\\HCN\\stationData")
for (i in 1:dim(uptonow)[1]) {
  
  stations=ghcnd_search(uptonow[i,1])
  name=makeName(i,uptonow)
  save(station,file=name)
  
  
}
 