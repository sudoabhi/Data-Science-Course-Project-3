library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
data1<-subset(data,(data$fips=="24510" & data$type=="ON-ROAD"))

data2<-subset(data,(data$fips=="06037" & data$type=="ON-ROAD"))

scc_data <- readRDS("Source_Classification_Code.rds")

sum_emissions1<- summarise(group_by(data1,year),emissions=sum(Emissions))
sum_emissions2<- summarise(group_by(data2,year),emissions=sum(Emissions))
sum_emissions1$county<-"Baltimore"
sum_emissions2$county<-"Los Angeles"
sum_emissions<-rbind(sum_emissions1,sum_emissions2)


png("plot6.png",width=800,height = 450)

p<-ggplot(sum_emissions, aes(x=county, y=emissions/1000,fill=county, label = round(emissions/1000,3))) +
    geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    facet_grid(. ~ year) + xlab(" ") + 
    ylab(expression("total PM"[2.5]*" emissions in kilotons")) + ggtitle("Motor vehicle emission variation in Baltimore and Los Angeles")+
    geom_label(aes(fill = county),colour = "white", fontface = "bold")

print(p)
dev.off()

