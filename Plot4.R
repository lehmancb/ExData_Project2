## Set the WD
setwd("/Users/clintlehman/Documents/Coursera/EDA")

## Read in Data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
print("NEI loaded")
SCC <- readRDS("Source_Classification_Code.rds")
print("SCC loaded")

## merge the two data sets 
NEI.SCC <- merge(NEI, SCC, by="SCC")
print("data sets merged")

##Subset for coal records
COAL.NEI.SCC <- NEI.SCC[grepl("coal", NEI.SCC$Short.Name, ignore.case=TRUE), ]


##Aggregate total emissions by year
tots.by.year <- aggregate(Emissions ~ year, COAL.NEI.SCC, sum)

## Change canvas
png('plot4.png', width = 480, height = 480)

## Create Plot
barplot(
  (tots.by.year$Emissions)/100000,
  names.arg = tots.by.year$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (in hundreds of thousands of tons)",
  main = "Total PM2.5 Emissions From Coal Combustion Sources"
)

## Clear session and cleanup
dev.off()
rm(NEI, SCC, tots.by.year, COAL.NEI.SCC)