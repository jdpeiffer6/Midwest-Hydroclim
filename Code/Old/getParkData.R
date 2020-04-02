getParkData = function(path) {
  #path="http://agebb.missouri.edu/weather/history/report.asp?station_prefix=alb&start_month=1&end_month=10&start_day=1&end_day=1&start_year=2000&end_year=2019&period_type=1&convert=1&field_elements=70"
  data = readLines(path) #this grabs the text from the html connection
  metastart = grep("Weather Station", data)   #finds the start of the metadata
  #makes the metadata list
  meta = list(
    station = strsplit(strsplit(data[metastart + 1], '>')[[1]][3], '<')[[1]][1],
    description = strsplit(strsplit(data[metastart + 3], '>')[[1]][3], '<')[[1]][1],
    begin = strsplit(strsplit(data[metastart + 5], '>')[[1]][3], '<')[[1]][1],
    end = strsplit(strsplit(data[metastart + 7], '>')[[1]][3], '<')[[1]][1]
  )
  start = F       #the start date is not always the true start, this will be used later to find it
  title = grep("YEAR", data)   #this line and the next define where the data starts to be listed and ends
  end = grep("Total:", data)
  #makes a data frame of specific length
  weath = data.frame(
    month = rep(NA, end - title - 9),
    day = rep(NA, end - title - 9),
    year = rep(NA, end - title - 9),
    weath = rep(NA, end - title - 9),
    maxtemp = rep(NA, end - title - 9),
    mintemp = rep(NA, end - title - 9),
    avgtemp = rep(NA, end - title - 9)
  )
  rownames(weath) = NULL
  #this goes through every line, if there is no data, it skips that line and records where the data starts
  for (i in (title + 3):(end - 3)) {
    if (grepl("No Data", data[i])) {
      next
    } #skips, below line records date of data start
    if (start == F) {
      meta$begin = paste(
        gsub(" ", "", strsplit(data[i], '      ')[[1]][2]),
        gsub(" ", "", strsplit(data[i], '      ')[[1]][3]),
        gsub(" ", "", strsplit(data[i], '      ')[[1]][4]),
        sep = '/'
      )
      start = T
    }
    data[i] = gsub('     ', ' ', data[i])     #gets all the annoying spaces out of the data
    data[i] = gsub('    ', ' ', data[i])
    data[i] = gsub('   ', ' ', data[i])
    data[i] = gsub('  ', ' ', data[i])
    data[i] = trimws(data[i])     #gets the first and last space out
    weath[i - 2 - title,] = as.double(strsplit(data[i], ' ')[[1]][1:7])  #puts data into data frame
  }
  weath = na.omit(weath)   #leaves out NA rows. these are caused by years without data
  wdata = list(meta = meta, weath = weath)    #output dataframe
  c = getwd()
  setwd("C:\\Users\\JD\\Documents\\GitHub\\StateParks\\Data\\Location Data")
  save(wdata, file = paste(meta$station, 'Rdata', sep = '.'))
  setwd(c)
  return(wdata)
}
