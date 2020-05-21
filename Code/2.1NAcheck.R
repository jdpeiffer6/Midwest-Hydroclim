#I want to be able to visualize how many missing dates are in our dataset
#depending on when we choose our start date! This script does that.

setwd("/home/jd/Documents/MWHC/Data")
library("ggplot2")     #library for plotting
load("allprcp.Rdata")   #loads our dataset
#View(allprcp)

allprcp=subset(allprcp,!is.na(allprcp$date))

# Count NAs ---------------------------------------------------------------
addNA=function(x){
  #this function adds up all of the NA values in a vector. in this case 
  #we will use it on every column (station) of the dataset!
  return(sum(is.na(x)))
}
missingDate=allprcp[,6:dim(allprcp)[2]]*0     #the matrix we will use to store
                                              #the number of missing values. same size
                                              #the orignal matrix, but without date info at the front

for(i in 1:dim(allprcp)[1]){       
  #this applies addNA function to every column but changes 
  #the amount of rows it operates on with each iteration of the for loop
  missingDate[i,]=apply(allprcp[i:dim(allprcp)[1],6:dim(allprcp)[2]],2,addNA)
  #print(i/18000)
}
save(missingDate,file="missingDate.Rdata")   #saves new data frame

lessThan=500 #this is what we will consider to be "too many" missing days
load("missingDate.Rdata")
sumgt=function(x){            #simply adds up number of stations with less than lessThan missing days
  return(sum(x<lessThan))
}
missings=apply(missingDate,1,sumgt)    #does this for each date down the rows
missings=data.frame(missings,date=as.Date(names(missings)))   #plots things
rownames(missings)=c()
ggplot(data=missings,aes(x=date,y=missings,group=1))+geom_line(col="blue",size=2)+scale_x_date(date_labels = "%Y")+
  labs(x="Date of cutoff", y=paste('Sites with less than', lessThan,'\nmissing days'),title="Cutoff date vs Missing Days")+
  theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
