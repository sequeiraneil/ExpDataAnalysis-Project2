##      assume that the data is already unzipped to the working directory

## Q5   How have emissions from motor vehicle sources changed from 1999-2008 
##      in Baltimore City?


NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NeiData[NeiData$fips == "24510",]


vehicles <- grep("motor", SCC$Short.Name, ignore.case = T)
vehicles <- SCC[vehicles, ]
vehicles <- baltimore[baltimore$SCC %in% vehicles$SCC, ]

##      a different approach - using aggregate
vehicleEmissions <- aggregate(vehicles$Emissions, list(vehicles$year), FUN = "sum")


##      setting up parameters for the plot

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot5.png", width = 480, height = 480, units = "px")

## creating a plot using base package
plot(vehicleEmissions, type = "l", xlab = "year", main = "Total Emissions from Vehicles in Baltimore City - 1999 to 2008",
     ylab = "Total PM2.5 Emission")


##      close the plot
dev.off()