#Load packages
library(ggplot2)
library(gapminder)
library(dplyr)
library(readxl)

#Import excel data and name columns
orders <- read_excel("~/Desktop/order data.xlsx")
colnames(orders) <- c("date", "region", "rep", "item", "units", "total")

#Create point plot, adjust x,y limits 
ggplot(orders, aes(x = units, y = total)) + geom_point() + 
	xlim(0, 100) + ylim(0, 1500)

#Trying out different visualizations with ggplot2:

#Create histogram, adjust binwidth to fit data close in number
ggplot(orders, aes(total, color = region)) + geom_histogram(binwidth = .5)

#Create text plot using item as labels 															   															   fill = "white")
ggplot(orders, aes(x = units, y = total, color = region)) + 
	geom_text(aes(label = item))

#Select and arrange data in descending order by total
orders_selected <- orders %>%
	select(item, units, total)
	arrange(desc(total))

#Filter by item type and total price > 100
orders_selected %>%
	filter(item == "Desk", total > 100)

#Add a new column unit_price and Create new variable orders_selected_2
orders_selected_2 <- orders_selected %>%
	mutate("unit_price" = total / units)
glimpse(orders_selected_2)

#Create plot using orders_selected_2 showing relationship btwn unit price and number of units
ggplot(orders_selected_2, aes(x = unit_price, y = units, color = item)) + geom_point() + 
	xlim(0, 150) + ylim(0, 150)

#Sum of item units by type
orders_selected_2 %>%
	group_by(item) %>%
	summarise(units = sum(units))

#Create plot using orders_selected_2 of items and units
ggplot(orders_selected_2, aes(x = item, y = units)) +
	geom_boxplot(outlier.colour = "hotpink") +
	geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)
