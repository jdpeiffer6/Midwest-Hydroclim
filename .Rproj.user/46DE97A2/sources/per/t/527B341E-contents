getAverages = function(wdata) {
  dailyavg = matrix(nrow = 366,
                    ncol = 5,
                    data = 0)   #makes a matrix with a column for every day +1 more for the number of days it was aquired over
  for (i in 1:dim(wdata$weath)[1]) {
    x1 = paste(wdata$weath$year[i],
               wdata$weath$month[i],
               wdata$weath$day[i],
               sep = '-') #converts date to a type readable by strftime
    x = as.numeric(strftime(x1, '%j'))   #converts that to a number
    leaps = c("2000|2004|2008|2012|2016")    #defines all the years with leaps in them. THis will need to be added to in bigger data sets
    if (grepl("-2-29", x1)) {
      #sets any leap day to day 366
      x = 366
    } else if (grepl(leaps, x1) &&
               x > 60) {
      #accounts for the offset from a leap day. In leap years, the leap day pushed every day back one which was annoying
      x = x - 1
    }
    dailyavg[x, 1:4] = as.numeric(wdata$weath[i, 4:7]) + dailyavg[x, 1:4]     #puts in the respective data
    dailyavg[x, 5] = dailyavg[x, 5] + 1    #adds a number for the total days averaged over
  }
  for (i in 1:366) {
    #divides the total by the number of data points that added to it
    dailyavg[i, 1:4] = dailyavg[i, 1:4] / dailyavg[i, 5]
  }
  return(dailyavg)
}