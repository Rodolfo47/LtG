#Heatmap of CAZomes of 16 LtG assemblies
#Prior to run you must delete empty columns of `cazyMatrix.csv`
#and rename to `cazyMatrix.ed.csv`

#1rst plot if for figure 3, 2nd for supp mat

setwd('/Users/REAnAr/LtG/res/')

#get data from cvs and turn in numeric matrix
cazymes <- read.csv('cazyMatrix.ed.fam.dif4.csv', header = TRUE, row.names = 1)

#change saple names
names(cazymes)[names(cazymes) == "X10Lt.76"] <- "CA15-F10_76b"
names(cazymes)[names(cazymes) == "X10Lt.300"] <- "CA15-F10_300b"
names(cazymes)[names(cazymes) == "X10Lt.SR"] <- "CA15-F10_SRs"

names(cazymes)[names(cazymes) == "X11Lt.76"] <- "CA15-11_76b"
names(cazymes)[names(cazymes) == "X11Lt.300"] <- "CA15-11_300b"
names(cazymes)[names(cazymes) == "X11Lt.SR"] <- "CA15-11_SRs"
names(cazymes)[names(cazymes) == "X11Lt.Canu"] <- "CA15-11_LRs"
names(cazymes)[names(cazymes) == "X11Lt.PurgeHap"] <- "CA15-11_Hybrid"

names(cazymes)[names(cazymes) == "X36Lt.76"] <- "EF-36_76b"
names(cazymes)[names(cazymes) == "X36Lt.300"] <- "EF-36_300b"
names(cazymes)[names(cazymes) == "X36Lt.SR"] <- "EF-36_SRs"
names(cazymes)[names(cazymes) == "X36Lt.Canu"] <- "EF-36_LRs"
names(cazymes)[names(cazymes) == "X36Lt.PurgeHap"] <- "EF-36_Hybrid"

names(cazymes)[names(cazymes) == "X75Lt.76"] <- "CA15-75_76b"
names(cazymes)[names(cazymes) == "X75Lt.300"] <- "CA15-75_300b"
names(cazymes)[names(cazymes) == "X75Lt.SR"] <- "CA15-75_SRs"
#change data type
df <- as.matrix(cazymes)

#set color ramp with equql colors than heatmap values (22)
colfunc <- colorRampPalette(c("white", "blue3","darkorchid", "red"))
ramp <- colfunc(23)
#draw the color key
plot(rep(1,23),col=colfunc(23),pch=15,cex=6)
#plotting clustering by raw, scale, col by strainn
heatmap(df, scale="none", col=ramp, Colv=NA, cexRow=0.2,
        cexCol=0.6, margins = c(4, 15), revC = TRUE)

#END

#next heatmap use full cazy counts for supplementary figures

#get data from cvs and turn in numeric matrix
cazymes <- read.csv('cazyMatrix.ed2.csv', header = TRUE, row.names = 1)

#change saple names
names(cazymes)[names(cazymes) == "X10Lt.76"] <- "CA15-F10_76b"
names(cazymes)[names(cazymes) == "X10Lt.300"] <- "CA15-F10_300b"
names(cazymes)[names(cazymes) == "X10Lt.SR"] <- "CA15-F10_SRs"

names(cazymes)[names(cazymes) == "X11Lt.76"] <- "CA15-11_76b"
names(cazymes)[names(cazymes) == "X11Lt.300"] <- "CA15-11_300b"
names(cazymes)[names(cazymes) == "X11Lt.SR"] <- "CA15-11_SRs"
names(cazymes)[names(cazymes) == "X11Lt.Canu"] <- "CA15-11_LRs"
names(cazymes)[names(cazymes) == "X11Lt.PurgeHap"] <- "CA15-11_Hybrid"

names(cazymes)[names(cazymes) == "X36Lt.76"] <- "EF-36_76b"
names(cazymes)[names(cazymes) == "X36Lt.300"] <- "EF-36_300b"
names(cazymes)[names(cazymes) == "X36Lt.SR"] <- "EF-36_SRs"
names(cazymes)[names(cazymes) == "X36Lt.Canu"] <- "EF-36_LRs"
names(cazymes)[names(cazymes) == "X36Lt.PurgeHap"] <- "EF-36Hybrid"

names(cazymes)[names(cazymes) == "X75Lt.76"] <- "CA15-75_76b"
names(cazymes)[names(cazymes) == "X75Lt.300"] <- "CA15-75_300b"
names(cazymes)[names(cazymes) == "X75Lt.SR"] <- "CA15-75_SRs"

#change data type
df <- as.matrix(cazymes)
#set color ramp with equql colors than heatmap values (22)
colfunc <- colorRampPalette(c("white", "yellow", "green", "cyan3", "blue3", "orchid3", "red"))
ramp <- colfunc(36)
#draw the color key
plot(rep(1,36),col=colfunc(36),pch=15,cex=6)
#plotting clustering by raw, scale, col by strainn
heatmap(df, scale="none", col=ramp, Colv=NA, cexRow=0.2,
        cexCol=0.6, margins = c(4, 15), revC = TRUE)

#END

