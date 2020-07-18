
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url,destfile = "Data.zip")
#unzip(zipfile = "Data.zip")
list.files()

data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

coal_l<-grepl("Fuel Comb.*Coal",scc_data$EI.Sector)

ei.sector<-scc_data$EI.Sector[coal_l]

coal_sources<-subset(scc_data,scc_data$EI.Sector %in% ei.sector)
#coal_sources<-scc_data[coal_l,]

data2<-subset(data,data$SCC %in% coal_sources$SCC)
#data2 <- data[(data$SCC %in% coal_sources$SCC), ]

sum_emissions<- summarise(group_by(data2,year),emissions=sum(Emissions))
#sum_emissions<-tapply(data2$Emissions,data$year,sum)

png("plot4.png",width=600,height = 450)
cols=c("red","blue","green","yellow")
p<-barplot(sum_emissions$emissions/1000,col=cols,xlab = "Year",ylim=c(0,700), names.arg=sum_emissions$year,
           ylab="Total Emissions (in Kilotons)",main = "Total PM2.5 Emissions from coal combustion-related sources")
text(x = p, y = round(sum_emissions$emissions/1000,2), label = round(sum_emissions$emissions/1000,2), pos = 3, cex = 1, col = "black")
dev.off()


#p<-ggplot(sum_emissions, aes(x=factor(year), y=emissions/1000,fill=year, label = round(emissions/1000,2))) +
    #geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    # facet_grid(. ~ year) +
    #xlab("year") +
    #ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
    #ggtitle("Emissions from coal combustion-related sources in kilotons")+
    #geom_label(aes(fill = year),colour = "white", fontface = "bold")



