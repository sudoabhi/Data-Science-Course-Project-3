library(ggplot2)
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

data<-subset(data,data$fips=="24510")


sum_emissions<-tapply(data$Emissions,list(data$year,data$type),sum)
sum_emissions<-as.data.frame(as.table(sum_emissions))
names(sum_emissions)<-c("year","type","emissions")

#baltcitymary.emissions.byyear<-summarise(group_by(filter(data, fips == "24510"), year,type), emissions=sum(Emissions))
#b_emissions <- data %>% filter(fips == "24510") %>% group_by(year, type) %>% summarise(emissions=sum(Emissions))

png("plot3.png", width=1000, height=750)

p<-ggplot(sum_emissions, aes(x=factor(year), y=emissions, fill=type,label = round(emissions,2)))+geom_bar(stat="identity") + 
    facet_grid(. ~ type) + ylab("Baltimore City emissions in kilotons") + ggtitle("Baltimore City PM2.5 Emissions acc to type") +
    geom_label(aes(fill = type), colour = "white", fontface = "bold",size=3) +
    guides(fill=guide_legend(override.aes = aes(label="")))

print(p)
dev.off()





