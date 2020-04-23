setwd("C:\\Users\\JD\\Documents\\MWHC\\Data")
library(climdex.pcic)
library(ggplot2)
library(hydroTSM)
load("allprcp.Rdata")


comp.cwd=function(data){
  dat=climdexInput.raw(prec=data,prec.dates=as.PCICt(as.character(allprcp$date),cal="365_day"),base.range=c(1970,1971))
  return(climdex.cwd(dat))
}
addNA=function(x){
  #this function adds up all of the NA values in a vector. in this case 
  #we will use it on every column (station) of the dataset!
  return(sum(is.na(x)))
}

cwd=apply(allprcp[,6:dim(allprcp)[2]],2,FUN=comp.cwd)
save(cwd,file="cwd.Rdata")

nas=apply(cwd,2,addNA)
sum(nas<=2)
cwdL=cwd[,nas<=2]
long=colnames(cwdL)
lprcp=allprcp[,long]
save(lprcp,file="lprcp.Rdata")

cwdL=apply(cwdL,1,sum,na.rm=T)
d=data.frame(yr=yip("1970-01-01","2019-01-01"),wet.days=cwdL[1:50])
ggplot(data=d,aes(x=yr,y=wet.days,group=1))+geom_point(col="blue",size=2)+scale_x_date(date_labels = "%Y")+
  labs(x="Year", y="Total Consecutive Wet Days\nacross 8 Missouri Stations",title="Consecutive Wet Days vs Time")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))