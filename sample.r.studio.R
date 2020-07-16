#Load packages
library(ggplot2)
library(readxl)

#Import excel data, name columns, and create subset
weather <- read_excel("~/Desktop/sample.xlsx")
colnames(weather) <- c("month", "season", "hightemp", "rainfall")
SS <- weather[3:9, 1:4]

#Create point plot using subset, adjust x,y limits 
ggplot(SS, aes(x = hightemp, y = rainfall, color = month)) + geom_point() + 
	xlim(50, 100) + ylim(0, 25)

#Create histogram using subset, adjust binwidth to fit data close in number
ggplot(SS, aes(x = hightemp, color = season)) + geom_histogram(binwidth = .5)

#Create text plot using months as labels 															   															   fill = "white")
ggplot(weather, aes(x = hightemp, y = rainfall, color = season)) + 
	geom_text(aes(label = month))

#Create bar graph of high temperature by month
ggplot(SS, aes(x=month, y= hightemp, color = season)) + 
	geom_bar(stat = "identity")
