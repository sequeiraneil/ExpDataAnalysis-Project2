##      assume that the data is already unzipped to the working directory

## Q6   Compare emissions from motor vehicle sources in Baltimore City with 
##      emissions from motor vehicle sources in Los Angeles County, California 
##      (fips == "06037"). Which city has seen greater changes over time in
##      motor vehicle emissions?

##      required libraries dplyr & ggplot2
require(dplyr)
require(ggplot2)

NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

d <- tbl_df(NeiData)
s <- tbl_df(SCC)

##      Filter the dataset Baltimore & LA 
##      dim(subset) 
##      11416     6
subset <- d %>%
                filter(fips == "24510"| NeiData$fips == "06037")


##      merge the subset & classification codes to do further operations
##      dim(m)
##      [1] 11416    20
m <- merge(subset, s, by = "SCC")
m <- tbl_df(m)

##      filter out only the motor vehicle pollution in the subset
motorEmissions <- m %>%
                filter(grepl("motor", m$Short.Name, ignore.case = T) == T) %>%
                select(fips, year, Emissions) 


##      setting up parameters for the plot

par("mar"=c(5, 4, 4, 2))
png(filename = "plot6.png", width = 480, height = 480, units = "px")

g <- ggplot(motorEmissions, aes(year, Emissions, color = fips ))
g + geom_line(stat = "summary", fun.y = "sum") +
        ylab('Total PM 2.5 Emissions') +
        ggtitle("Total Emissions from Motor Vehicles\n in Baltimore City & LA County\n compared between
                1999-2008")+
        scale_color_discrete(name = "Group", label = c("Los Angeles", "Baltimore"))

dev.off()