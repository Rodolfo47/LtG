#Obtener la correlación entre el tamaño de la lectura
#y el tamaño del ensamble genómico 
#para L. trichodermophora

#install.packages("ggpubr")
library("ggpubr")

setwd("/Users/REAnAr/LtG/res")

my_data <- read.csv("RLvsGS.csv", header = TRUE)

ggscatter(my_data, x = "Read_Length", y = "Genome_Size", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Read Length", ylab = "Genome Size (Mbp)")

cor.test(my_data$Read_Length, my_data$Genome_Size,  method="kendall")
#Kendall's rank correlation tau
#z = 2.9608, p-value = 0.003069
#alternative hypothesis: true tau is not equal to 0
#sample estimates: tau 0.6123724

cor.test(my_data$Read_Length, my_data$Genome_Size,  method="spearman")
#Spearman's rank correlation rho
#S = 184.54, p-value = 0.001368
#alternative hypothesis: true rho is not equal to 0
#sample estimates: rho 0.7286167

#now get correlation values between read length and cazome sizes
my_data <- read.csv("RLvsCS.csv", header = TRUE)

cor.test(my_data$Read_Length, my_data$CAZome_Size,  method="kendall")

#Kendall's rank correlation tau
#data:  my_data$Read_Length and my_data$CAZome_Size
#z = 2.9632, p-value = 0.003045
#alternative hypothesis: true tau is not equal to 0
#sample estimates:
#    tau: 0.61494 

cor.test(my_data$Read_Length, my_data$CAZome_Size,  method="spearman")

#Spearman's rank correlation rho
#data:  my_data$Read_Length and my_data$CAZome_Size
#S = 184.18, p-value = 0.001351
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#  rho: 0.7291531 


#