#load required packages
library(tidyverse)

#read in gene abundance data
data <- read_delim("data/gene_abundance_centralia.txt", delim = "\t")

#read in site metadata
meta <- read_delim("data/Centralia_temperature.txt", delim = "\t")

#annotate and tidy data
data.annotated <- data %>%
  left_join(meta, by = "Site")

write.table(data.annotated, "output/gene_data_annotated.txt", sep = "\t", row.names = FALSE, quote = FALSE)

geneA <- data.annotated %>%
  subset(Gene == "arsM")

#plot data
ggplot(geneA)

#plot data with x and y
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance))

#Geometric layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, color = "red", width = 0.2) 

#Aesthetic layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) 

#Scale layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red")

#Coordinate layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  coord_flip()

#Facet layers
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y")

#Theme layers
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw()

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

#Additional aesthetics
(boxplot <- ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
    geom_boxplot() +
    geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
    scale_color_continuous(low = "yellow", high = "red") +
    facet_wrap(~Gene, scales = "free_y") +
    theme_bw(base_size = 10) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
    ylab("Normalized abundance") +
    xlab("Fire history") +
    labs(color = "Temperature (°C)"))

#Save a plot
ggsave(boxplot, filename = "figures/gene.boxplot.eps", units = "in", width = 6, height = 4)

