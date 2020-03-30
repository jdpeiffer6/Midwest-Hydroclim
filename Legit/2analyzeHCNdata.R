setwd("C:\\Users\\JD\\Documents\\StateParks\\Legit")
load("allprcp.Rdata")
View(allprcp)

allprcp=subset(allprcp,!is.na(allprcp$date))

# Count NAs ---------------------------------------------------------------
addNA=function(x){
  return(sum(is.na(x)))
}
?is.na()
?apply
missing=apply(allprcp[,6:dim(allprcp)[2]],2,addNA)
sum(missing<1000)

plotNums=matrix(nrow=dim(allprcp)[1],ncol=2)
for(i in 1:dim(allprcp)[1]){
  plotNums[i,]=c(i,sum(missing<i))
}
plot(plotNums[,1],plotNums[,2],xlab='Days cut since 1970',
     ylab='Sites with less than x amount of missing days',
     main='Cutoff date vs Missing days'
     )

?matrix()
?plot

# Indicies ----------------------------------------------------------------
library(climdex.pcic)
?as.PCICt
pcictdates=as.PCICt(as.character(allprcp$date),cal="365_day")
inp=climdexInput.raw(prec=allprcp$USW00013995,prec.dates=pcictdates,base.range=c(1970,2019))
climdex.cwd(inp)
