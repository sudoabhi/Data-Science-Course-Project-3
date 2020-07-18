
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

data<-subset(data,data$fips=="24510")

sum_emissions<-tapply(data$Emissions,data$year,sum)
#baltcitymary.emissions<-summarise(group_by(filter(data, fips == "24510"), year), emissions=sum(Emissions))

#b_total_emissions <- data  %>%  filter(fips == "24510") %>%  group_by(year) %>%  summarise(Emissions = sum(Emissions))

png("plot2.png", width=600, height=450)
cols=c("Red","Green","Yellow","Blue")
p<-barplot(sum_emissions/1000,col = cols,xlab = "Year",ylim=c(0,4),
           ylab="Baltimore City Emissions (in Kilotons)",main = "Baltimore City, maryland PM2.5 Emissions in Kilotons")
text(x = p, y = round(sum_emissions/1000,2), label = round(sum_emissions/1000,2), pos = 3, cex = 1, col = "black")
dev.off()