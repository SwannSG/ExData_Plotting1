#--project1, plot3
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

#--do the plot
len = length(a$Global_active_power)
png('plot3.png')
plot(a$Sub_metring_1,
     ylim=c(0,40),
     xlim=c(0, len),
     type='n',
     ann=F,                       
     xaxt='n',
     yaxt='n'
)
#--axis only works with correct ylim, xlim in plot()
axis(1, las=1, at=c(1, len/2, len), labels=c('Thu', 'Fri', 'Sat'))
axis(2, las=0, at=c(0, 10, 20, 30), labels=c('0', '10', '20', '30'))
title(main=NULL,
      xlab=NULL,
      ylab='Energy sub metering')
legend(x="topright", inset=.0, title=NULL,
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1,1,1),
       col = c('black', 'red', 'blue'),
       horiz=F)
lines(a$Sub_metering_1, col='black')
lines(a$Sub_metering_2, col='red')
lines(a$Sub_metering_3, col='blue')
dev.off()