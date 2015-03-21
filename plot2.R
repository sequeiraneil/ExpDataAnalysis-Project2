##      assume that the data is already unzipped to the working directory

## Q2   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
##      (fips == "24510") from 1999 to 2008? Use the base plotting system to make
##      a plot answering this question.

NeiData <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##      library dplyr used for summarising data
require(dplyr)


##      turn the data into a tbl_df for use with the dplry package
d <- tbl_df(NeiData)

##      select the data that is relevant to this question
subset <- d %>% filter(fips == "24510") %>% 
        group_by(year) %>%
        summarise(totEmissions = sum(Emissions))


##      summarise data that is to be plotted
totEmissions <-
        subset %>%
        group_by(year) %>%
        summarise(
                totEmissions = sum(Emissions))

##      using base package to plot
##      setting up parameters for the plot

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(totEmissions, type = "l", xlab = "Year", main = "Total Emissions in Baltimore - 1999 to 2008",
     ylab = "Total PM2.5 Emission")

##      close the plot
dev.off()