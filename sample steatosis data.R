#load packages
library(readxl)
library(dplyr)
library(ggplot2)

#Import excel data and name columns
WT_KO_MICE <- read_excel("Desktop/WT.KO MICE.xlsx")
colnames(WT_KO_MICE) <- c("sampleID", "animalID", "treatment", "bodyWT", "liverWT")

#Add new columns and create new table
HFD_WT <- WT_KO_MICE %>%
  select("animalID", "treatment", "bodyWT", "liverWT") %>%
  mutate("lvWTbwWTratio" = bodyWT / liverWT) %>%
  filter(animalID == "WT")

#Create new subset and plot data
HFD_WT_ctrl <- HFD_WT %>%
  filter(treatment == "Control")
ggplot(HFD_WT_ctrl, aes(bodyWT, liverWT)) + geom_point(xlim = c(29,32), ylim = c(.9, 1.1))

#Create new subset and plot data
HFD_WT_PFOA <- HFD_WT %>%
  filter(treatment == "PFOA 10")
ggplot(HFD_WT_PFOA, aes(bodyWT, liverWT)) + geom_point(xlim = c(29,32), ylim = c(2, 3))

#Create new subset table and add new column 
HFD_KO <- WT_KO_MICE %>%
  select("animalID", "treatment", "bodyWT", "liverWT") %>%
  mutate("lvWTbwWTratio" = bodyWT / liverWT) %>%
  filter(animalID == "KO")

#Create new subset and plot data
HFD_KO_ctrl <- HFD_WT %>%
  filter(treatment == "Control")
ggplot(HFD_KO_ctrl, aes(bodyWT, liverWT)) + geom_point(xlim = c(30,38), ylim = c(1, 1.4))

#Create new subset and plot data
HFD_KO_PFOA <- HFD_WT %>%
  filter(treatment == "PFOA 10")
ggplot(HFD_KO_PFOA, aes(bodyWT, liverWT)) + geom_point(xlim = c(35,39), ylim = c(2.6, 3.9))

#Visualizing treatment and body weight data in KO and WT
ggplot(HFD_KO, aes(treatment, bodyWT, color = treatment)) + geom_boxplot()
ggplot(HFD_WT, aes(treatment, bodyWT, color = treatment)) + geom_boxplot()


