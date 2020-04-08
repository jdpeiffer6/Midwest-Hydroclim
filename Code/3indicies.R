setwd("C:\\Users\\JD\\Documents\\StateParks\\Data")
library(climdex.pcic)
load("allprcp.Rdata")


comp.cwd=function(data){
  dat=climdexInput.raw(prec=data,prec.dates=as.PCICt(as.character(allprcp$date),cal="365_day"),base.range=c(1970,1971))
  return(climdex.cwd(dat))
}
cwd=apply(allprcp[,6:dim(allprcp)[2]],2,FUN=comp.cwd)
save(cwd,file="cwd.Rdata")



#start.date <- as.Date("2017-01-01")
#end.date <- as.Date("2020-03-17")
#dates = dip(start.date, end.date)
#data=rnorm(length(dates),10,1)
#test=climdexInput.raw(prec=data,prec.dates = as.PCICt(as.character(dates),cal="365_day"),base.range=c(2017,2018))
#climdex.cwd(test)
