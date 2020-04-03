setwd("/home/jd/Documents/StateParks/Data")
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


load("missingDate.Rdata")
sumgt=function(x){
  return(sum(x<100))
}
missings=apply(missingDate,1,sumgt)

plot(1:18339,missings,xlab='Days cut since 1970',
     ylab='Sites with less than 100 missing days',
     main='Cutoff date vs Missing days'
)
