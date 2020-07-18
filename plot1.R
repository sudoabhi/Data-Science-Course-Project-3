
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")
sum_emissions<-tapply(data$Emissions,data$year,sum)
#total.emissions <- summarise(group_by(data, year), emissions=sum(Emissions))
#total_annual_emissions <- aggregate(Emissions ~ year, data, FUN = sum)

png("plot1.png", width=600, height=450)
cols=c("Red","Green","Yellow","Blue")
p<-barplot(sum_emissions/1000,col = cols,xlab = "Year",ylim=c(0,8000),
        ylab="Total Emissions (in Kilotons)",main = "Total PM2.5 Emissions in Kilotons")
text(x = p, y = round(sum_emissions/1000,2), label = round(sum_emissions/1000,2), pos = 3, cex = 1, col = "black")
dev.off()