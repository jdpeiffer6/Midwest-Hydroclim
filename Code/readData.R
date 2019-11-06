##this code I used to run the getParkData() function on all of the links and make sure it was returning the right data!
for(i in 6){
  path=createPath(stations,i)
  a=getParkData(path)
  cat(paste(round(100*i/39),'% '))
}

createPath=function(df,num){  
  #this function is used with the vatiable "stations" and creates the path
  return(paste(df$base[num],df$time[num],df$type[num],df$measures[num],sep=''))
}

for(i in 31){          #this is a useful test to see if things work
  browseURL(createPath(stations,i))
}

#useful to check what files contain NA
a=matrix(nrow=39,ncol=2)
j=0
setwd('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')
for(i in dir('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')){
  j=j+1
  name=load(i)
  a[j,1]=wdata$meta$station
  a[j,2]=wdata$meta$description
}
write.xlsx(a,file=xcelpath,col.names = F,row.names = F,sheetName='metadata',append=T)


#this creates the excel file with all of the average data
library(xlsx)
setwd('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')
xcelpath='C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Documents\\avgData.xlsx'
for(i in dir('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')){
  name=load(i)
 #avg=getAverages(wdata)
 #colnames(avg)=c("Daily Percipation (mm)","Max Temp (C)","Min Temp (C)","Avg Temp (C)","Days in average")
 write.xlsx(avg,file=xcelpath,col.names=T,append=T,sheetName=i)
 save(file=i,wdata,avg)
}



