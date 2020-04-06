setwd("C:\\Users\\JD\\Documents\\StateParks\\Data")
library(climdex.pcic)
load("allprcp.Rdata")

test=climdexInput.raw(prec=allprcp$US1MOAN0012,prec.dates=as.PCICt(as.character(allprcp$date),cal="365_day"),base.range=c(1970,2019))
climdex.cwd(test)
