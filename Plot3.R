library(ggplot2)
## Set the WD
setwd("/Users/clintlehman/Documents/Coursera/EDA")

## Read in Data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
print("NEI loaded")
SCC <- readRDS("Source_Classification_Code.rds")
print("SCC loaded")

##Aggregate total emissions by year and type for Baltimore
tots.by.year.type <- aggregate(Emissions ~ year + type, NEI[NEI$fips=="24510",], sum)

## Change canvas
png('plot3.png', width = 480, height = 480)

## Create Plot
g <- ggplot(tots.by.year.type, aes(year, Emissions / 100, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab("Total PM2.5 Emissions (in hundreds of tons)") +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')

## Clear session and cleanup
dev.off()
rm(NEI, SCC, tots.by.year.type, g)