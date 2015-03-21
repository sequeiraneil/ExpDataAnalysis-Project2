##      assume that the data is already unzipped to the working directory

## Q3   Of the four types of sources indicated by the type (point, nonpoint, 
##      onroad, nonroad) variable, which of these four sources have seen decreases
##      in emissions from 1999-2008 for Baltimore City? Which have seen increases 
##      in emissions from 1999-2008? 
##      Use the ggplot2 plotting system to make a plot answer this question.

NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##      library dplyr used for summarising data
require(dplyr)
require (ggplot2)

##      turn the data into a tbl_df for use with the dplry package
d <- tbl_df(NeiData)

##      select the data pertinent, & summarise data  to be plotted
BaltEmissions <-
        d %>% 
        filter(fips == "24510") %>%
        group_by(year, type) %>%
        summarise(
                tot = sum(Emissions))

##      using ggplot2 package to plot
##      setting up parameters for the plot

par("mar"=c(5, 4, 4, 2))
png(filename = "plot3.png", width = 480, height = 480, units = "px")

g <- ggplot(BaltEmissions, aes(x = year, y = tot, color = type))
g + geom_line(stat = "identity") + ylab( "Total PM2.5 Emissions") +
        ggtitle("Total Emissions by type in Baltimore City 1999 - 2008")

##      close the plot
dev.off()