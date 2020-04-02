dateFormat=function(df){
  #correctly formats the dates for use in climdex and elimanates unnecessary columns
  df$percip$date=NA
  df$percip$date=paste(df$percip$year,df$percip$month,df$percip$day,sep="-")
  df$percip <- subset(df$percip, select = -c(day,month,year))
  return(df)
}