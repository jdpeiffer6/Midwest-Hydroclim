#uses complete dataset lprcp
setwd("/home/jd/Documents/MWHC/Data")
library(climdex.pcic)
library(ggplot2)
library(hydroTSM)
library(reshape2)
library(xlsx)
load("lprcp.Rdata")
load("names.Rdata")

cdr=function(prec,dates,base.range=c(1970,1971)){
  return(climdexInput.raw(prec=prec,prec.dates=as.PCICt(as.character(dates),cal="365_day"),base.range=base.range))
}

comp.cwd=function(data,date,base.range=c(1970,1971)){
  if(!require(climdex.pcic)){
    print("Must install/load climdex.pcic")
    return()
  }
  if(!is.null(dim(data))){           #matrix of stations
    arr=apply(data,2,FUN=cdr,dates=date,base.range=base.range)
    return(sapply(arr,2,FUN=climdex.cwd))
  }else if(length(data)==length(date)){     #only one station
    print("One station")
    dat=climdexInput.raw(prec=data,prec.dates=as.PCICt(as.character(date),cal="365_day"),base.range=base.range)
    return(climdex.cwd(dat))
  }else{
    print("Error: Data is not equal length")
  }
}
comp.climdex=function(FUNC,data,date,base.range=c(1970,1971)){
  if(!require(climdex.pcic)){
    print("Must install/load climdex.pcic")
    return()
  }
  if(!is.null(dim(data))){           #matrix of stations
    arr=apply(data,2,FUN=cdr,dates=date,base=base.range)
    return(sapply(arr,FUN=FUNC))
  }else if(length(data)==length(date)){     #only one station
    dat=climdexInput.raw(prec=data,prec.dates=as.PCICt(as.character(date),cal="365_day"),base.range=base.range)
    return(FUNC(dat))
  }else{
    print("Error: Data is not equal length")
  }
}  #this will probably be useful
comp.cdd=function(data,date,base.range=c(1970,1971)){
  if(!require(climdex.pcic)){
    print("Must install/load climdex.pcic")
    return()
  }
  if(!is.null(dim(data))){           #matrix of stations
    arr=apply(data,2,FUN=cdr,dates=date,base.range=base.range)
    return(sapply(arr,2,FUN=climdex.cdd))
  }else if(length(data)==length(date)){     #only one station
    print("One station")
    dat=climdexInput.raw(prec=data,prec.dates=as.PCICt(as.character(date),cal="365_day"),base.range=base.range)
    return(climdex.cdd(dat))
  }else{
    print("Error: Data is not equal length")
  }
}

#not sure what i was thinking here
#lcwd=apply(lprcp[,2:dim(lprcp)[2]],2,FUN=comp.cwd,date=lprcp$date)
#lcdd=apply(lprcp[,2:dim(lprcp)[2]],2,FUN=comp.cdd,date=lprcp$date)

lcwd=comp.cwd(lprcp[,2:dim(lprcp)[2]],lprcp$date)
lcdd=comp.cdd(lprcp[,2:dim(lprcp)[2]],lprcp$date)

cwdL=apply(lcwd,1,sum,na.rm=T)
cddL=apply(lcdd,1,sum,na.rm=T)

# Plots -------------------------------------------------------------------
d=data.frame(yr=yip("1970-01-01","2019-01-01"),wet.days=cwdL[1:50],dry.days=cddL[1:50])
ggplot(data=d,aes(x=yr,y=wet.days,group=1))+geom_point(col="blue",size=2)+scale_x_date(date_labels = "%Y")+
  labs(x="Year", y="Total Consecutive Wet Days\nacross 8 Missouri Stations",title="Consecutive Wet Days vs Time")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
setwd("/home/jd/Documents/MWHC/Figures")
#ggsave(paste(Sys.Date(),"CWD8",".png",sep=""))

ggplot(data=d,aes(x=dry.days,y=wet.days,group=1))+geom_point(col="blue",size=2)+
  labs(x="CDD", y="CWD",title="Consecutive Wet Days vs\nConsecutive Dry Days")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
#ggsave(paste(Sys.Date(),"CWDvsCDD",".png",sep=""))

dataA=data.frame(yr=yip("1970-01-01","2019-01-01"),USC00231773=lcwd[1:50,1])
ggplot(data=dataA,aes(yr))+geom_line(aes(y=USC00231773,colour="USC00231773"))+scale_x_date(date_labels = "%Y")+
  labs(x="Year", y="Total Yearly Wet Days",title="Total Wet Days")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
#ggsave(paste(Sys.Date(),"USC00231773","-CWD",".png",sep=""))

setwd("/home/jd/Documents/MWHC/Data")
lcwd = data.frame(date = rownames(lcwd), lcwd)
colnames(lcwd)=c("date",names)
save(lcwd,file="lcwd.Rdata")
write.csv(lcwd,file="lcwd.csv")

lcdd = data.frame(date = rownames(lcdd), lcdd)
colnames(lcdd)=c("date",names)
save(lcwd,file="lcdd.Rdata")
write.csv(lcdd,file="lcdd.csv")

lcwd.melted = melt(lcwd, id = "date")
lcwd.melted$date = as.numeric(lcwd.melted$date) + 1969
setwd("/home/jd/Documents/MWHC/Figures")
ggplot(lcwd.melted, aes(x = date, y = value, color = variable)) +
  geom_line() + facet_grid(variable ~ .) + labs(x = "Year", y = "Yearly Consecuetive Wet Days", title =
                                                  "Consecutive Wet Days vs Time")
ggsave(paste(Sys.Date(),"individualCWD8",".png",sep=""),width=9,height=7,units="in")
View(lcwd)
