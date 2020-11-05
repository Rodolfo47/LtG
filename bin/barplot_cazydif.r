#Divergent barplot
#to indicate diferences in CAZy annotation
#wile using different reads and assembling
#rodolfo angeles 2020

#mine steps:
#1.-create df
#2.- plotting

#requeriments
library(ggplot2)
library(dplyr)

#set wd
setwd('/Users/REAnAr/LtG/res/')

##1.- create df to plott from cazyMatrix.csv

#load data
cazy <- read.csv('cazyMatrix.ed.csv', header = TRUE, row.names = 1)
#rename headers
names(cazy)[names(cazy) == "X10Lt.76"] <- "10Lt.76"
names(cazy)[names(cazy) == "X10Lt.300"] <- "10Lt.300"
names(cazy)[names(cazy) == "X10Lt.SR"] <- "10Lt.SR"
names(cazy)[names(cazy) == "X11Lt.76"] <- "11Lt.76"
names(cazy)[names(cazy) == "X11Lt.300"] <- "11Lt.300"
names(cazy)[names(cazy) == "X11Lt.SR"] <- "11Lt.SR"
names(cazy)[names(cazy) == "X11Lt.Canu"] <- "11Lt.LR"
names(cazy)[names(cazy) == "X11Lt.PurgeHap"] <- "11Lt.Hyb"
names(cazy)[names(cazy) == "X36Lt.76"] <- "36Lt.76"
names(cazy)[names(cazy) == "X36Lt.300"] <- "36Lt.300"
names(cazy)[names(cazy) == "X36Lt.SR"] <- "36Lt.SR"
names(cazy)[names(cazy) == "X36Lt.Canu"] <- "36Lt.LR"
names(cazy)[names(cazy) == "X36Lt.PurgeHap"] <- "36Lt.Hyb"
names(cazy)[names(cazy) == "X75Lt.76"] <- "75Lt.76"
names(cazy)[names(cazy) == "X75Lt.300"] <- "75Lt.300"
names(cazy)[names(cazy) == "X75Lt.SR"] <- "75Lt.SR"

#get counts of new cazys in new col 
cazy$'+10Lt.300' <- (cazy$"10Lt.300" - cazy$"10Lt.76")
cazy$'+10Lt.SR' <- (cazy$"10Lt.SR" - cazy$"10Lt.76")
cazy$'+11Lt.300' <- (cazy$"11Lt.300" - cazy$"11Lt.76")
cazy$'+11Lt.SR' <- (cazy$"11Lt.SR" - cazy$"11Lt.76")
cazy$'+11Lt.LR' <- (cazy$"11Lt.LR" - cazy$"11Lt.76")
cazy$'+11Lt.Hyb' <- (cazy$"11Lt.Hyb" - cazy$"11Lt.76")
cazy$'+36Lt.300' <- (cazy$"36Lt.300" - cazy$"36Lt.76")
cazy$'+36Lt.SR' <- (cazy$"36Lt.SR" - cazy$"36Lt.76")
cazy$'+36Lt.LR' <- (cazy$"36Lt.LR" - cazy$"36Lt.76")
cazy$'+36Lt.Hyb' <- (cazy$"36Lt.Hyb" - cazy$"36Lt.76")
cazy$'+75Lt.300' <- (cazy$"75Lt.300" - cazy$"75Lt.76")
cazy$'+75Lt.SR' <- (cazy$"75Lt.SR" - cazy$"75Lt.76")

#get counts of loosed cazy in new col
cazy$'-10Lt.300' <- (cazy$"10Lt.300" - cazy$"10Lt.76")
cazy$'-10Lt.SR' <- (cazy$"10Lt.SR" - cazy$"10Lt.76")
cazy$'-11Lt.300' <- (cazy$"11Lt.300" - cazy$"11Lt.76")
cazy$'-11Lt.SR' <- (cazy$"11Lt.SR" - cazy$"11Lt.76")
cazy$'-11Lt.LR' <- (cazy$"11Lt.LR" - cazy$"11Lt.76")
cazy$'-11Lt.Hyb' <- (cazy$"11Lt.Hyb" - cazy$"11Lt.76")
cazy$'-36Lt.300' <- (cazy$"36Lt.300" - cazy$"36Lt.76")
cazy$'-36Lt.SR' <- (cazy$"36Lt.SR" - cazy$"36Lt.76")
cazy$'-36Lt.LR' <- (cazy$"36Lt.LR" - cazy$"36Lt.76")
cazy$'-36Lt.Hyb' <- (cazy$"36Lt.Hyb" - cazy$"36Lt.76")
cazy$'-75Lt.300' <- (cazy$"75Lt.300" - cazy$"75Lt.76")
cazy$'-75Lt.SR' <- (cazy$"75Lt.SR" - cazy$"75Lt.76")

#delete unused values
#only save positve values
cazy[, c(17:28)][cazy[, c(17:28)]< 0] <- 0
#only save negative values
cazy[, c(29:40)][cazy[, c(17:28)]> 0] <- 0
#View(cazy)

#create a new data frame to plotting
#get gains values
cazy.sus1<- select(cazy,
                  `+10Lt.300`, `+10Lt.SR`, 
                  `+11Lt.300`, `+11Lt.SR`, `+11Lt.LR`, `+11Lt.Hyb`,
                  `+36Lt.300`, `+36Lt.SR`, `+36Lt.LR`, `+36Lt.Hyb`,
                  `+75Lt.300`, `+75Lt.SR`)
#get gains values per assem
cazy.sus1.sum<- data.frame(colSums(cazy.sus1), c(rep("Gains", length (cazy.sus1))))
cazy.sus1.sum<- cbind(cazy.sus1.sum, 
                      Strain=c("10Lt", "10Lt",
                        "11Lt", "11Lt", "11Lt", "11Lt",
                        "36Lt", "36Lt", "36Lt", "36Lt",
                        "75Lt", "75Lt"), 
                      Assembly=c("300", "SR",
                        "300", "SR", "LR", "Hyb",
                        "300", "SR", "LR", "Hyb",
                        "300", "SR"),
                      Sample=c("10Lt.300", "10Lt.SR",
                                "11Lt.300", "11Lt.SR", "11Lt.LR", "11Lt.Hyb",
                                "36Lt.300", "36Lt.SR", "36Lt.LR", "36Lt.Hyb",
                                "75Lt.300", "75Lt.SR"))
#change some header names
names(cazy.sus1.sum)[names(cazy.sus1.sum) == "colSums.cazy.sus1."] <- "val"
names(cazy.sus1.sum)[names(cazy.sus1.sum) == "c.rep..Gains...length.cazy.sus1..."] <- "change"

#get losse val, same steps than above 
cazy.sus2<- select(cazy,
                   `-10Lt.300`, `-10Lt.SR`, 
                   `-11Lt.300`, `-11Lt.SR`, `-11Lt.LR`, `-11Lt.Hyb`,
                   `-36Lt.300`, `-36Lt.SR`, `-36Lt.LR`, `-36Lt.Hyb`,
                   `-75Lt.300`, `-75Lt.SR`)
#get losses values per assem
cazy.sus2.sum<- data.frame(colSums(cazy.sus2), c(rep("Losses", length (cazy.sus2))))
cazy.sus2.sum<- cbind(cazy.sus2.sum, 
                      Strain=c("10Lt", "10Lt",
                               "11Lt", "11Lt", "11Lt", "11Lt",
                               "36Lt", "36Lt", "36Lt", "36Lt",
                               "75Lt", "75Lt"), 
                      Assembly= c("300", "SR",
                                  "300", "SR", "LR", "Hyb",
                                  "300", "SR", "LR", "Hyb",
                                  "300", "SR"),
                      Sample=c("10Lt.300", "10Lt.SR",
                               "11Lt.300", "11Lt.SR", "11Lt.LR", "11Lt.Hyb",
                               "36Lt.300", "36Lt.SR", "36Lt.LR", "36Lt.Hyb",
                               "75Lt.300", "75Lt.SR"))
#change some col names
names(cazy.sus2.sum)[names(cazy.sus2.sum) == "colSums.cazy.sus2."] <- "val"
names(cazy.sus2.sum)[names(cazy.sus2.sum) == "c.rep..Losses...length.cazy.sus2..."] <- "change"

#merge df in to final df to plotting
cazy.ch<-rbind(cazy.sus1.sum, cazy.sus2.sum)
cazy.ch<- as.data.frame(cazy.ch)

#change labels for paper
cazy.ch$Strain<-replace(cazy.ch$Strain, c(1, 2, 13, 14), 'CA15-F10')
cazy.ch$Strain<-replace(cazy.ch$Strain, c(3, 4, 5, 6, 15, 16, 17, 18), 'CA15-11')
cazy.ch$Strain<-replace(cazy.ch$Strain, c(7,8,9,10, 19, 20, 21, 22), 'EF-36')
cazy.ch$Strain<-replace(cazy.ch$Strain, c(11, 12, 23, 24), 'CA15-75')

###2.- Plotting from cazy.ch

ggplot(cazy.ch, 
       aes(x=Assembly, y= val, fill = change))+
  geom_bar(stat = "identity")+
  theme_bw()+
  facet_grid( ~ Strain) +
  scale_fill_grey("", start=0.85, end=0.65)+
  labs(x="Assembly" , y="CAZyme numbers") +
  scale_x_discrete(limits=c("300", "SR", "LR", "Hyb"))+
  scale_y_continuous(limits=c(-20, 400), breaks=seq(-20, 400, 50))+
  geom_text(aes(label=val), size=3)
  
##End
#to move the values on the bars:
#geom_text(aes(label=val), vjust=-0.3, size=3)




