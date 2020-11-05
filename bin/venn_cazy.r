#VennDiag LtG CAZy aessem vs assem

#setwd
setwd('/Users/REAnAr/LtG/res/')
#dependences
library(venn)
library(ggplot2)
library(ggpolypath)

#data 10
x = read.csv('cazyMatrix/10Lt-cazyMatrix.csv', stringsAsFactors = FALSE, header = TRUE, row.names = 1)

names(x)[names(x) == "X10Lt.76"] <- "76 b"
names(x)[names(x) == "X10Lt.300"] <- "300 b"
names(x)[names(x) == "X10Lt.SR"] <- "SRs"

#plott of 3 assemblies of 10Lt
venn(x, ilab=TRUE,  zcolor = "style", ellipse = FALSE, ilcs = 1.5, sncs = 1.5, box = FALSE)


#data 11
x = read.csv('cazyMatrix/11Lt-cazyMatrix.csv', stringsAsFactors = FALSE, header = TRUE, row.names = 1)

names(x)[names(x) == "X11Lt.76"] <- "76 b"
names(x)[names(x) == "X11Lt.300"] <- "300 b"
names(x)[names(x) == "X11Lt.SR"] <- "SRs"
names(x)[names(x) == "X11Lt.Canu"] <- "LRs"
names(x)[names(x) == "X11Lt.PurgeHap"] <- "Hybrid"

#plott of 5 assemblies of 11
venn(x, ilab=TRUE,  zcolor = "style", ellipse = FALSE, ilcs = 1.5, sncs = 1.5, box = FALSE)

#data 36
x = read.csv('cazyMatrix/36Lt-cazyMatrix.csv', stringsAsFactors = FALSE, header = TRUE, row.names = 1)

names(x)[names(x) == "X36Lt.76"] <- "76 b"
names(x)[names(x) == "X36Lt.300"] <- "300 b"
names(x)[names(x) == "X36Lt.SR"] <- "SRs"
names(x)[names(x) == "X36Lt.Canu"] <- "LRs"
names(x)[names(x) == "X36Lt.PurgeHap"] <- "Hybrid"

#plott of 5 assemblies of 36
venn(x, ilab=TRUE,  zcolor = "style", ellipse = FALSE, ilcs = 1.5, sncs = 1.5, box = FALSE)

#data 75
x = read.csv('cazyMatrix/75Lt-cazyMatrix.csv', stringsAsFactors = FALSE, header = TRUE, row.names = 1)

names(x)[names(x) == "X75Lt.76"] <- "76 b"
names(x)[names(x) == "X75Lt.300"] <- "300 b"
names(x)[names(x) == "X75Lt.SR"] <- "SRs"

#plott of 3 assemblies of 75
venn(x, ilab=TRUE,  zcolor = "style", ellipse = FALSE, ilcs = 1.5, sncs = 1.5, box = FALSE)

