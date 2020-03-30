setwd("/storage/hpc/data/jdp6n8/StateParks/Legit")
load("allprcp.Rdata")
#View(allprcp)

allprcp=subset(allprcp,!is.na(allprcp$date))

# Count NAs ---------------------------------------------------------------
addNA=function(x){
  return(sum(is.na(x)))
}
missingDate=allprcp[,6:dim(allprcp)[2]]*0

for(i in 1:dim(allprcp)[1]){
  missingDate[i,]=apply(allprcp[i:dim(allprcp)[1],6:dim(allprcp)[2]],2,addNA)
  #print(i/18000)
}
save(missingDate,file="missingDate.Rdata")