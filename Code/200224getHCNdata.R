setwd("C:\\Users\\Julia\\Documents\\StateParks\\Data\\HCN")
load("uptonow.Rdata")

setwd("C:\\Users\\Julia\\Documents\\StateParks\\Data\\HCN\\stationData")
library(rnoaa)
makeName= function(row,dataList){
  name=paste((dataList[row,1]),(dataList[row,6]), (dataList[row,9]),".Rdata", sep="_" )
  return(name)
}
for (i in 1:dim(uptonow)[1]) {
  station=ghcnd_search(uptonow[i,1])
  name=makeName(i,uptonow)
  save(station,file=name)
  print(100*i/dim(uptonow)[1])
}