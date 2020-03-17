setwd("C:\\Users\\Julia\\Documents\\StateParks\\Data\\HCN")
library(rnoaa) 
library(hydroTSM)

makeName= function(row,dataList){
  name=paste((dataList[row,1]),(dataList[row,6]), (dataList[row,9]),".Rdata", sep="_" )
  return(name)
}


# make empty frame --------------------------------------------------------
start.date <- as.Date("1950-01-01")
end.date <- as.Date("2020-03-17")
date1 <- data.frame(date = dip(start.date, end.date))
date1$year <- as.numeric(format(date1$date, "%Y")) 
date1$month <- as.numeric(format(date1$date, "%m")) 
date1$day <- as.numeric(format(date1$date, "%d"))
date1$doy <- as.numeric(format(date1$date, "%j"))  
allprcp=data.frame(date=date1$date)
rownames(allprcp)=date1$date


# loop --------------------------------------------------------------------
#stations <- ghcnd_stations()  
#MOstations=subset(stations,state=='MO')
#uptonow=subset(MOstations,last_year>=2019 & (element=='PRCP'|element=='TMAX'|element=='TMIN'))
#save(uptonow, file="uptonow.Rdata")
load("uptonow.Rdata")

setwd("C:\\Users\\JD\\Documents\\StateParks\\Data\\HCN")
for (j in 1:dim(uptonow)[1]) {
  
  station=ghcnd_search(uptonow[j,1])
  if(any(grepl("prcp",names(station)))){
    dates=station$prcp$date
    rain=station$prcp$prcp
    for(i in 1:length(dates)){
      allprcp[toString(dates[i]),j+1]=rain[i]
    }
    colnames(allprcp)=c(colnames(allprcp)[1:dim(allprcp)[2]-1],station$prcp$id[1])
    #name=makeName(j,uptonow)
    #save(station,file=name)
  }
}
