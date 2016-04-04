library(ggplot2)

## Set the WD
setwd("/Users/clintlehman/Documents/Coursera/EDA")

## Read in Data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
print("NEI loaded")
SCC <- readRDS("Source_Classification_Code.rds")
print("SCC loaded")

##Subset SCC and NEI
vehicles.NEI <- NEI[NEI$SCC %in% SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]$SCC,]

## Subset the for Baltimore and LA
baltimore <- vehicles.NEI[vehicles.NEI$fips=="24510",]
la <- vehicles.NEI[vehicles.NEI$fips=="06037",]

##Add City Label
baltimore$city <- "Baltimore City"
la$city <- "Los Angeles County"

##Combine
combined <- rbind(baltimore, la)

##Aggregate total emissions by year
tots.by.year <- aggregate(Emissions ~ year + city, combined, sum)

## Change canvas
png('plot6.png', width = 480, height = 480)

## Create Plot
g <- ggplot(data=tots.by.year, aes(x=factor(year), y=Emissions/1000)) 
g <- g + facet_grid(. ~ city) +  
        geom_bar(aes(fill=year),stat="identity") +
       ggtitle('Total Emissions of Motor Vehicle Sources Los Angeles vs. Baltimore') +
       ylab('Total PM2.5 Emissions (in thousands of tons)') +
       xlab('Year') +
       theme(legend.position='none')
print(g)

## Clear session and cleanup
dev.off()
##rm(NEI, SCC, tots.by.year, vehicles.NEI, baltimore, la, combined, NEI.SCC)