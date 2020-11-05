# 4.- *K*-mer coverage

Estimating the four *Laccaria trichodermophora* strains genomic sizes by *k*-mer depth coverage following [this](https://bioinformatics.uconn.edu/genome-size-estimation-tutorial/#) gide.



**Work flow:**

4.1.- Jellyfish

4.2.- k-mer coverage



## 4.1.- Jellyfish

[link]( http://www.cbcb.umd.edu/ software/jellyfish) [git](https://github.com/gmarcais/Jellyfish/tree/master/doc)

**Instal:**

```
tar -xvf jellyfish-2.3.0.tar.gz
cd jellyfish-2.3.0/
./configure
make
make install
make check
./bin/jellyfish --version
		jellyfish 2.3.0
```

**Run:**

Counting occurrences of the 19-mers of the mi-seq clean data of the 36Lt.

(to re-run repalce the path to the jellyfish script in the next lines)

```
./../../bin/jellyfish-2.3.0/bin/jellyfish count -C -m 19 -s 10G -t 8 -o 36Lt.300.19-mer ../../data/36Lt.300.R1.val.fastq ../../data/36Lt.300.R2.val.fastq
```

Do the histogram.

```
./../../bin/jellyfish-2.3.0/bin/jellyfish histo -o 36Lt.300.19-mer.histo 36Lt.300.19-mer
```

Identify total number of kmers.

```
wc -l 36Lt.300.19-mer.histo
```

6020 36Lt.300.19mer.histo



`15_run_jellyfish.sh` 4 strains, 2 sr lib and 5 k-mer (19 - 27)



## 4.2.- k-mer coverage

Display the histogram in R, and identify the k-mer number of the beginning and the end of the curve, also the mean coverage

```
#load the table
dataframe19 <- read.table("36Lt.300.19-mer.histo")

#plotting the k-mer frequencies with accurate points
plot(dataframe19[8:100,], type="l")
points(dataframe19[9:70,])
```

The single copy region must be visually detected and plotted excluding some first data with extremely high frequencies to get the poison distribution



To calculate the total k-mers in the distribution use start point and the total k-mers (ej. 9, 6020)

```
> sum(as.numeric(dataframe19[9:6020,1]*dataframe19[9:6020,2]))
[1] 2244897209
```



Determine peak position by looking into the region of the data frame

```
> dataframe19[30:45,]
   V1      V2
30 30 1318028
31 31 1416044
32 32 1507041
33 33 1577398
34 34 1627650
35 35 1658616
36 36 1673637
37 37 1667767
38 38 1636966
39 39 1594912
40 40 1533818
41 41 1461336
42 42 1379639
43 43 1282576
44 44 1187431
45 45 1086416
```

Is the 36 wit a freq value of 1673637

So the Genome Size can be estimated as:

```
> sum(as.numeric(dataframe19[9:6020,1]*dataframe19[9:6020,2]))/36
[1] 6235825
```

So the genome size of this sample calculated with k 19 must be near to 62.35 Mpb

to see the single copy region 

```
> sum(as.numeric(dataframe19[9:70,1]*dataframe19[9:70,2]))/36
[1] 42125135
```

42.12 Mbp of the genome must be of single copy

and the proportion compared to the total genome size

```
> (sum(as.numeric(dataframe19[9:70,1]*dataframe19[9:70,2]))/36) / (sum(as.numeric(dataframe19[9:6020,1]*dataframe19[9:6020,2]))/36)
[1] 0.6755342
```

Around 70 % of the genome came as single copy



Iterate the analyses with different k for all samples and seq lib

replace variable values of this R script

`kmer_gsize.r`

```
#genome size by k-mer coverage
setwd("/Users/REAnAr/LtG/out/jellyfish")

#set df 
dataframe <- read.table("75Lt.76.35-mer.histo")
#set values
tkam <- 9146
start <- 8
end <- 132
maxfreqpoint <- 29

#plotting to get start and end point
plot(dataframe[start:400,], type="l")
points(dataframe[start:end,])

#get maxfrq point
dataframe[start:end,]


#get genome size
sum(as.numeric(dataframe[start:tkam,1]*dataframe[start:tkam,2]))/maxfreqpoint
#get single copy region
sum(as.numeric(dataframe[start:end,1]*dataframe[start:end,2]))/maxfreqpoint
#get single copy %
(sum(as.numeric(dataframe[start:end,1]*dataframe[start:end,2]))/maxfreqpoint) / (sum(as.numeric(dataframe[start:tkam,1]*dataframe[start:tkam,2]))/maxfreqpoint)

```

Capture the data in exel and prepare `k-mer_g.size.csv` for R plotting.

Use the script `boxplot_kmer_gsize.r`.

```
#plotting g. size by k-mer coverage

#set wd
setwd("/Users/REAnAr/LtG/res/")

#load libs
library(ggplot2)

#charge data on a data frame
data <- read.table("k-mer_g.size.csv", sep=",", header=T)

#head(data)
#View(data)

# make the graphyc
ggplot(data=data,
       aes(x=data$Strain, y=data$Genome.size..Mbp.)) +
  geom_boxplot(color = "black") +
  labs(x="Strains",y="Genome size (Mbp)") +
  theme_minimal() +
  theme(text = element_text(size = 18))

```





## 