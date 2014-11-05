#--project1, plot1
wd = '/home/steve/Courses/Coursera/5-ExploratoryDataAnalysis/projects/1'
setwd(wd)

#--test set True for quick plot testing
#--avoids reading and processing large 'household_power_consumption.txt'
test = F
if (test) {
  load(file='a.Data')
} else {  
  #--raw data
  r = read.table('household_power_consumption.txt',
                 sep=';',
                 stringsAsFactors=F,
                 header=T)
  
  save(r, file='r.Data')
  load(file='a.Data')
  
  #--analytical data, two days in Feb 2007
  a = r[which(r$Date == '1/2/2007' | r$Date == '2/2/2007'),]
  
  #--coerce to numeric
  for (i in 3:9) {
    a[,c(i)] = as.numeric(a[,c(i)])
  }
  
  #--convert date string to R date object
  #----"16/12/2006" 
  a$Date = as.Date(a$Date, format='%d/%m/%Y')
  
  #--release memory
  remove(r)
  save(a, file='a.Data')
}

png('plot1.png')
hist(a$Global_active_power,
     xlab='Global Active Power (kilowatts)',
     main='Global Active Power',
     col='red'
)
dev.off()
