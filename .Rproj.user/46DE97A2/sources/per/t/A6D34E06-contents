##this code I used to run the getParkData() function on all of the links and make sure it was returning the right data!
for(i in 1:39){
  path=createPath(stations,i)
  a=getParkData(path)
  cat(paste(round(100*i/39),'% '))
}

createPath=function(df,num){  
  #this function is used with the vatiable "stations" and creates the path
  return(paste(df$base[num],df$time[num],df$type[num],df$measures[num],sep=''))
}

for(i in 1:39){          #this is a useful test to see if things work
  browseURL(createPath(stations,i))
}

#useful to check what files contain NA
setwd('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')
for(i in dir('C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data')){
  name=load(i)
  print(i)
  print(sum(is.na(wdata$weath))/7)
  #for(i in 1:dim(wdata$weath)[1]){
    #if(sum(is.na(wdata$weath[i,]))>0){print(wdata$weath[i,])}}

}

