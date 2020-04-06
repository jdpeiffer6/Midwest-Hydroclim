setwd("C:\\Users\\JD\\Documents\\StateParks\\Data")
library("ggplot2")
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

lessThan=500
load("missingDate.Rdata")
sumgt=function(x){
  return(sum(x<lessThan))
}
missings=apply(missingDate,1,sumgt)
missings=data.frame(missings,date=as.Date(names(missings)))
rownames(missings)=c()
ggplot(data=missings,aes(x=date,y=missings,group=1))+geom_line(col="blue",size=2)+scale_x_date(date_labels = "%Y")+
  labs(x="Date of cutoff", y=paste('Sites with less than', lessThan,'missing days'),title="Cutoff date vs Missing Days")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))