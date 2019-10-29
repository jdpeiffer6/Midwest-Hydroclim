getPercipData=function(path){
#path="http://agebb.missouri.edu/weather/history/report.asp?station_prefix=alb&start_month=1&end_month=10&start_day=1&end_day=1&start_year=2000&end_year=2019&period_type=1&convert=1&field_elements=70"
data=readLines(path)
metastart=grep("Weather Station",data)
meta=list(station=strsplit(strsplit(data[metastart+1],'>')[[1]][3],'<')[[1]][1],description=strsplit(strsplit(data[metastart+3],'>')[[1]][3],'<')[[1]][1],begin=strsplit(strsplit(data[metastart+5],'>')[[1]][3],'<')[[1]][1],end=strsplit(strsplit(data[metastart+7],'>')[[1]][3],'<')[[1]][1])

title=grep("YEAR",data)
end=grep("Total:",data)
percip=data.frame(month=rep(NA,end-title-9),day=rep(NA,end-title-9),year=rep(NA,end-title-9),inches=rep(NA,end-title-9))
rownames(percip)=NULL
for(i in (title+3):(end-3)){
if(grepl("No Data",data[i])){next}
percip[i-2-title,]=as.numeric(strsplit(data[i],'      ')[[1]][2:5])
}
percip = percip[complete.cases(percip),] 
pdata=list(meta=meta,percip=percip)
c=getwd();setwd("C:\\Users\\JD\\Documents\\College\\StateParks\\Data")
save(pdata,file=paste(meta$station,'Rdata',sep='.'));setwd(c)
return(pdata)
}
