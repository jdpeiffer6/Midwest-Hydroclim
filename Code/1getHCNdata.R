#This script makes a matrix with dates 1970-2020 as the rows and all data from HCN
#all stations in missouri in the columns. There are about 600 stations, so 
#the matrix will have about 600 columns. Don't try to run this for too long
#unless you are using the HPC! The matrix that is created is saved in 
#Data/allprcp.Rdata for you to use!

setwd("C:\\Users\\JD\\Documents\\StateParks\\Data")    #maybe change your path
library(rnoaa)         #if this fails, try install.packages("rnoaa","hydroTSM") first
library(hydroTSM)

stations <- ghcnd_stations()  #generates a list of all avaliable HCN Stations
MOstations = subset(stations, state == 'MO')     #We only want missouri ones
uptonow = subset(MOstations, last_year >= 2019 & (element == 'PRCP')) #missouri stations that go up to 2019 and are percipitation

# make empty frame --------------------------------------------------------
start.date <- as.Date("1970-01-01")
end.date <- as.Date("2020-03-17")
date1 <- data.frame(date = dip(start.date, end.date))
date1$year <- as.numeric(format(date1$date, "%Y"))
date1$month <- as.numeric(format(date1$date, "%m"))
date1$day <- as.numeric(format(date1$date, "%d"))
date1$doy <- as.numeric(format(date1$date, "%j"))
allprcp = data.frame(
  date = date1$date,
  year = date1$year,
  month = date1$month,
  day = date1$day,
  doy = date1$doy
)
rownames(allprcp) = date1$date

# loop --------------------------------------------------------------------
for (j in 1:dim(uptonow)[1]) {         #loops through all HCN stations we want
  station = ghcnd_search(uptonow[j, 1])    #gets HCN data
  dates = station$prcp$date
  rain = station$prcp$prcp
  for (i in 1:length(dates)) {    #loops through every entry
    if (as.numeric(substr(dates[i], 1, 4)) >= 1970) {     #if entry is in our date range
      allprcp[toString(dates[i]), station$prcp$id[1]] = rain[i]   #put it in the matrix
      print("match")
    }
    print(i)    #to moniter progress of loop
  }
}
save(allprcp, file = "allprcp.Rdata") #saves our matrix