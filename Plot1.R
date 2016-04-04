## Set the WD
setwd("/Users/clintlehman/Documents/Coursera/EDA")

## Read in Data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
print("NEI loaded")
SCC <- readRDS("Source_Classification_Code.rds")
print("SCC loaded")

##Aggregate total emissions by year
tots.by.year <- aggregate(Emissions ~ year, NEI, sum)

## Change canvas
png('plot1.png', width = 480, height = 480)

## Create Plot
barplot(
  (tots.by.year$Emissions)/1000000,
  names.arg = tots.by.year$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (in Millions of Tons)",
  main = "Total PM2.5 Emissions From All US Sources"
)

## Clear session and cleanup
dev.off()
rm(NEI, SCC, tots.by.year)