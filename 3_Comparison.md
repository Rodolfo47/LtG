# 3.- Comparison

## 3.1.- Quast (v5.2.0)

Particular quast analyses are placed in the assembling sections (1 and 2) of this repository.

Quast comparison of 36Lt or 11Lt with icarus viewer for supplementary figures:

```
#cd /LtG/res/Assemblies
quast --memory-efficient -m 1000 -i 500 -x 7000 --silent 36Lt.76.fasta 36Lt.300.fasta 36Lt.SR.fasta 36Lt.Canu.fasta 36Lt.Pilon3.fasta -r 36Lt.Pilon3.fasta --fragmented

quast --memory-efficient -m 1000 -i 500 -x 7000 --silent 11Lt.76.fasta 11Lt.300.fasta 11Lt.SR.fasta 11Lt.Canu.fasta 11Lt.Pilon3.fasta -r 11Lt.Pilon3.fasta --fragmented
```



## 3.2.- Busco (v4.0.5)

Busco analyses search in the assembly a specific set of genes to identify the completeness of the assembly.

**Run:**

Activate the conda ambient:

```
source activate /usr/local/bioconda/envs/busco
```

Prior to execute the program, some configuration steps must be done:

```
#copiar config_cofing.ini y /config/ del root a LtG/bin
cd bin
cp -r /usr/local/bioconda/envs/busco/config/ .

busco_configurator.py config_config.ini myconfig.ini
export BUSCO_CONFIG_FILE=/space21/PGE/rangeles/Busco/bin/myconfig.ini
export AUGUSTUS_CONFIG_PATH=/space21/PGE/rangeles/Busco/config
```

Example line:

```
busco -i ../data/36Lt.SR.fna -l agaricales_odb10 -o 36Lt.SR -m geno --out_path ../out -c 8 -f
```

Do the analyses of a bunch of assemblies using the script that first create a `list.txt` and then run busco.

```
nohup sh 14_run_busco.sh > 14_run_busco.nohup.out &
```

**Main results:**

10Lt.300.fasta	C:65.3%[S:63.0%,D:2.3%],F:12.7%,M:22.0%,n:3870

10Lt.76.fasta	C:46.2%[S:45.7%,D:0.5%],F:15.3%,M:38.5%,n:3870

10Lt.SR.fasta	C:64.7%[S:58.0%,D:6.7%],F:12.0%,M:23.3%,n:3870

11Lt.300.fasta	C:60.6%[S:53.6%,D:7.0%],F:13.3%,M:26.1%,n:3870

11Lt.76.fasta	C:50.8%[S:49.1%,D:1.7%],F:15.0%,M:34.2%,n:3870

11Lt.HybSPADes.fasta	C:82.4%[S:63.4%,D:19.0%],F:6.3%,M:11.3%,n:3870

11Lt.SR.fasta	C:61.4%[S:52.7%,D:8.7%],F:12.8%,M:25.8%,n:3870

36Lt.300.fasta	C:97.3%[S:96.0%,D:1.3%],F:0.8%,M:1.9%,n:3870

36Lt.76.fasta	C:97.4%[S:96.4%,D:1.0%],F:0.7%,M:1.9%,n:3870

36Lt.HybSPADes.fasta	C:97.6%[S:96.3%,D:1.3%],F:0.5%,M:1.9%,n:3870

36Lt.SR.fasta	C:97.5%[S:96.3%,D:1.2%],F:0.6%,M:1.9%,n:3870

75Lt.300.fasta	C:57.8%[S:48.4%,D:9.4%],F:13.2%,M:29.0%,n:3870

75Lt.76.fasta	C:48.1%[S:45.4%,D:2.7%],F:14.0%,M:37.9%,n:3870

75Lt.SR.fasta	C:65.1%[S:49.9%,D:15.2%],F:13.1%,M:21.8%,n:3870



## 3.3.- VizBin

[Download](http://claczny.github.io/VizBin/) the `VizBin-dist.jar` on my mac (2.5 GHz, Intel Core i5, 8 GB, 1067 MHz DDR3, OS 10.15.6 19G73, java v1.8.0_121) and execute it.

Use the assemblies uploaded to genbank.

Modify the <u>perplexity</u> parameter to <u>20</u> in ordther to allow less than 100 seq multifasta files.

Select dot groups distant for the main cloud and BLASTn online each contig

**Results:**

All contig match on *Laccaria bicolor* sequences. 

BLASTn results and vizbin scatterplots are placed in `/space21/PGE/rangeles/LtG/out/vizbin`.
