##      assume that the data is already unzipped to the working directory

## Q4   Across the United States, how have emissions from coal combustion-
##      related sources changed from 1999-2008?

NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal <- SCC[coal, ]
coal <- NeiData[NeiData$SCC %in% coal$SCC, ]

##      a different approach - using aggregate
coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")


##      setting up parameters for the plot

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## creating a plot using base package
plot(coalEmissions, type = "l", xlab = "year", main = "Total Emissions in US from\n Coal Combustion Sources - 1999 to 2008",
     ylab = "Total PM2.5 Emission")


##      close the plot
dev.off()