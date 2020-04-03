setwd("C:\\Users\\JD\\Documents\\StateParks\\Data")
library(rnoaa)
library(hydroTSM)

stations <- ghcnd_stations()
MOstations = subset(stations, state == 'MO')
uptonow = subset(MOstations, last_year >= 2019 &
                   (element == 'PRCP'))

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
for (j in 1:dim(uptonow)[1]) {
  station = ghcnd_search(uptonow[j, 1])
  dates = station$prcp$date
  rain = station$prcp$prcp
  for (i in 1:length(dates)) {
    if (as.numeric(substr(dates[i], 1, 4)) >= 1970) {
      allprcp[toString(dates[i]), station$prcp$id[1]] = rain[i]
      print("match")
    }
    print(i)
  }
}
save(allprcp, file = "allprcp.Rdata")
