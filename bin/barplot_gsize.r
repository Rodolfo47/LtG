#bar plot of genome comparison
#fig 2 LtG

library(ggplot2)
library(RColorBrewer)
library(dplyr)

setwd("/Users/REAnAr/LtG/res")

#View(data2)

data2 <- read.table("gsize2plot5.csv", sep=",", header=T)

#Plotting
data2 %>% ggplot() +
  geom_bar(aes(y = Values, x = Assembly, fill = Sequence_type) ,
           stat="identity" ,
           position='stack') +
  theme_bw() +
  theme(axis.text.x=element_text(size=rel(.85))) +
  facet_grid( ~ Strain) +
  labs(x="Strain/Library" , y="Genome size (Mbp)") +
  scale_fill_grey("", start=0.85, end=0.65) +
  scale_x_discrete(limits=c("76", "300", "SR", "LR", "Hyb")) +
  scale_y_continuous(limits=c(0, 125), breaks=seq(0, 125, 20))
  

#export plot as bar_g.size.pdf in /LtG/res/
