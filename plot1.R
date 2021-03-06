##      assume that the data is already unzipped to the working directory

## Q1   Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##      Using the base plotting system, make a plot showing the total PM2.5 emission from all
##      sources for each of the years 1999, 2002, 2005, and 2008.

## A    Yes, it shows a distinct downward trend over the decade.

NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##      library dplyr used for summarising data
require(dplyr)


##      turn the data into a tbl_df for use with the dplry package
d <- tbl_df(NeiData)

##      summarise data that is to be plotted
totEmissions <-
        d %>%
        group_by(year) %>%
        summarise(
                totEmissions = sum(Emissions))

##      using base package to plot
##      setting up parameters for the plot

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(totEmissions, type = "l", xlab = "Year", main = "Total Emissions in the US - 1999 to 2008",
     ylab = "Total PM2.5 Emission")

##      close the plot
dev.off()