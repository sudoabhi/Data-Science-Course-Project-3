
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
data<-subset(data,(data$fips=="24510" & data$type=="ON-ROAD"))
scc_data <- readRDS("Source_Classification_Code.rds")

sum_emissions<- summarise(group_by(data,year),emissions=sum(Emissions))
#sum_emissions<-tapply(data2$Emissions,data$year,sum)

png("plot5.png",width=600,height = 450)

p<-ggplot(sum_emissions, aes(x=factor(year), y=emissions/1000,fill=year, label = round(emissions/1000,3))) +
    geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    #facet_grid(. ~ year) +
    xlab("year") + ylab(expression("total PM"[2.5]*" emissions in kilotons")) + ggtitle("Emissions from motor vehicle sources in Baltimore City")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")

print(p)
dev.off()

