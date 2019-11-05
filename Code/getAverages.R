dailyavg=matrix(nrow=366,ncol=5,data=0)
for(i in 1:10){
x=as.numeric(strftime(paste(pdata$percip$year[i],pdata$percip$month[i],pdata$percip$day[i],sep='-'),"%j"))
dailyavg[x,1:4]=as.numeric(pdata$percip[i,4:7])+dailyavg[x,1:4]
dailyavg[x,5]=dailyavg[x,5]+1
}





dim(pdata$percip)[1]