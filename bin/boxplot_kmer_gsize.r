#plotting g. size by k-mer coverage
setwd("/Users/REAnAr/LtG/res/")

library(ggplot2)

data <- read.table("k-mer_g.size3.csv", sep=",", header=T)
ggplot(data=data,
       aes(x=data$Strain, y=data$Genome.size..Mbp.)) +
  geom_boxplot(color = "black") +
  labs(x="Strains",y="Genome size (Mbp)") +
  theme_bw() +
  theme(text = element_text(size = 18))

