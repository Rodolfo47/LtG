# 2.- Hybrid assemblies

Assemblies of two strains (11Lt and 36Lt) of *L. trichodermophora* using just long reads or in hybrid approaches.

All scripts were run from the `~/LtG/bin/` directory.



**Work flow:** 

2.1.- HybridSPAdes

2.2.- MaSuRCa

2.3.- Wtdbg2

2.4.- Canu

2.5.- Pilon

2.6.- PurgeHaplotigs 



**Data:**

Put the pacbio dir in `~/LtG/data/` and create liks to the subreads



**Run:**

## 2.1.- HybridSPAdes (v3.13.1)

 [Citation](Antipov, D., Korobeynikov, A., McLean, J.S., Pevzner, P.A.: hybridspades: an algorithm for hybrid assembly of short and long reads. Bioinformatics 32(7), 1009–1015 (2015))

Example line:

```
spades.py \
    -1 ../data/$smpl.76.R1_val_1.fq \
    -2 ../data/$smpl.76.R2_val_2.fq \
    -1 ../data/$smpl.300.R1_val_1.fq \
    -2 ../data/$smpl.300.R2_val_2.fq \
    --pacbio ../data/$smpl.10k.subreads.fasta \
    --careful \
    -t 16 \
    -o ../out/hybridSPAdes/$smpl/
```

Execute both assemblies (11Lt and 36Lt):

```
nohup sh 9_run_spadesHyb.sh > 9_run_spadesHyb.out.sh &
```



## 2.2.- MaSuRCA (v3.3.8b)

 [GitHub](https://github.com/alekseyzimin/masurca) [Citation](Zimin, A.V., Puiu, D., Luo, M.C., Zhu, T., Koren, S., Marc ̧ais, G., Yorke, J.A., Dvoˇra ́k, J., Salzberg, S.L.: Hybrid assembly of the large and highly repetitive genome of aegilops tauschii, a progenitor of bread wheat, with the masurca mega-reads algorithm. Genome research 27(5), 787–792 (2017))



**Installation:**

```
tar -xvf MaSuRCA-3.3.8b.tar.gz
cd MaSuRCA-3.3.8b
./install.sh
```



**Run:**

1.- Create configuration file.

2.- Run the `masurca` script (which generate a script `assemble.sh`).

3.- Run the script `assemble.sh`.

**Configuration file:**

Replace (of the manual)  `/install_path`  with

`[...]/LtG/bin/MaSuRCA-3.3.8b`

Just set the PE, JUMP, PACBIO y JF_SIZE values for my data

`[...]/LtG/bin/sr_config_36Lt.txt`

Modified content of `sr_config_36Lt.txt` -> `config.masurca.36Lt.txt`

```
#
#
#
DATA
#
PE= pe 76 5  ../data/Illumina/Nex-Seq/EF-36/EF-36_R1.fastq  ../data/Illumina/Nex-Seq/EF-36/EF-36_R2.fastq
#
JUMP= sh -700 700  ../data/Illumina/Mi-Seq/EF-36/EF-36_long_R1.fastq ../data/Illumina/Mi-Seq/EF-36/EF-36_long_R2.fastq
#
PACBIO=../data/PacBio/PB.36Lt/36Lt_m54229_190211_052059.subreads.fasta
#
END

PARAMETERS

#
NUM_THREADS = 16
#
JF_SIZE = 500000000
#
END
```

**Masurca scrips:**

```
MaSuRCA-3.3.8b/bin/masurca config.masurca.36Lt.txt
```

**Assembly:**

```
nohup ./assemble.sh > masurca36Lt.nohup.out &
```

move the output from the wd to `/out/masurca/*Lt/`

Repeat the 3 steps on the 11Lt strain data.

the  assembly are in: `/LtG/out/masurca/11Lt/CA.mr.41.15.17.0.029/final.genome.scf.fasta`

mv `final.genome.scf.fasta` and rename.



## 2.3.- Wtdbg2 (v2.5)

[github](https://github.com/ruanjue/wtdbg2) [Citation](Ruan, J. and Li, H. (2019) Fast and accurate long-read assembly with wtdbg2. *Nat Methods* doi:10.1038/s41592-019-0669-3)



**Installation:**

```
git clone https://github.com/ruanjue/wtdbg2
cd wtdbg2 && make
```

**Run:**

```
nohup sh 10_run_wtdbg2.sh > 10_run_wtdbg2.nohup.out &
```

Script content:

```
#/bin/sh

#Run wtdbg2 with PB.11Lt and PB.36Lt
###

#Ran in Chichen at [...]/LtG/bin/

#Install wtdbg2 in bin with:

#git clone https://github.com/ruanjue/wtdbg2
#cd wtdbg2 && make
#cd ..

#Run
cd ../out/wtdbg2/
t="8"
for strain in 36Lt 11Lt; do
# assemble long reads
./../../bin/wtdbg2/wtdbg2 \
-x sq -g 70m -t $t \
-i ../../data/$strain.10k.subreads.fasta \
-fo $strain

# derive consensus
./../../bin/wtdbg2/wtpoa-cns -t $t \
-i $strain.ctg.lay.gz \
-fo $strain.raw.fa

# Polishment using short reads
#map SRs
bwa index $strain.raw.fa
bwa mem -t $t $strain.raw.fa \
../../data/$strain.76.R1.fastq \
../../data/$strain.76.R2.fastq | \
samtools sort -O SAM | \
./../../bin/wtdbg2/wtpoa-cns -t $t \
-x sam-sr -d $strain.raw.fa \
-i - -fo $strain.srp.fa
```



## 2.4.- Canu (v2.0)

Example line:

```
canu -p 11Lt \
	-d ../out/canu/11Lt \
	genomeSize=70m \
	-pacbio-raw ../data/11Lt.10k.subreads.fasta
```

Execute:

```
nohup sh 11_run_canu.sh &
```



## 2.5.- Pilon (v1.23)

[Github](https://github.com/broadinstitute/pilon/wiki) [Download](https://github.com/broadinstitute/pilon/releases) [Citation](Walker, B.J., Abeel, T., Shea, T., Priest, M., Abouelliel, A., Sakthikumar, S., Cuomo, C.A., Zeng, Q., Wortman, J., Young, S.K., et al.: Pilon: an integrated tool for comprehensive microbial variant detection and genome assembly improvement. PloS one 9(11), e112963 (2014))

Input files:

`genome_assembly.fa`

`reads.bam (can be several)`



I use the Canu assemblies and the 3 sequencing libraries mapped on the same assemblies.

**WF:**

1.- Scaffolding Canu assembly with SSPACE-LongRead

2.- Filling gaps with GapFiller

3.- Illumina mappings with Bowtie2

4.- PacBio mappings with Minimap2

5.- Convert from sam to bam with samtools



### SSPACE-LongRead (v1-1)

Example line:

```
SSPACE-LongRead.pl -c ../out/canu/36Lt/36Lt.contigs.fasta -p ../data/36Lt.10k.subreads.fasta -b ../out/sspace-lr/36Lt/
```

Execute:

```
nohup 12_run_sspace-lr.sh > 12_run_sspace-lr.nohup.sh
```



### GapFiller (v1-10)

Create the `lib.txt`

```
echo "lib1 bwa ../data/36Lt.300.R1.fastq ../data/36Lt.300.R2.fastq 700 0.75 FR" > 36Lt.gapfiller.txt
echo "lib2 bwa ../data/36Lt.76.R1.fastq ../data/36Lt.76.R2.fastq 150 0.75 FR" >> 36Lt.gapfiller.txt
```

Run GapFiller

```
nohup GapFiller.pl -l 36Lt.gapfiller.txt -s ../out/sspace-lr/36Lt/scaffolds.fasta -b 36Lt -T 16 &

nohup GapFiller.pl -l 11Lt.gapfiller.txt -s ../out/sspace-lr/11Lt/scaffolds.fasta -b 11Lt -T 16 &
```

Move results

```
mv *Lt/ ../out/gapfiller
```



**Preparing bam files to Pilon with Bowtie and Minimap**

Prepare wd

```
#cd /LtG/out
mkdir pilon
cd pilon
ln -s ../gapfiller/36Lt/36Lt.gapfilled.final.fa 36Lt.fasta
ln -s ../gapfiller/11Lt/11Lt.gapfilled.final.fa 11Lt.fasta
```

### Bowtie2 (v2.3.5)

example lines:

```
#indexin the reference genome
bowtie2-build ../../../data/36.10K.fn 36.10K.fn --threads 16

#mapping the 76b reads
bowtie2 -p 16 -x 36.10K.fn -1 ../../../data/Illumina/Nex-Seq/EF-36/EF-36_R1.fastq -2 ../../../data/Illumina/Nex-Seq/EF-36/EF-36_R2.fastq -S 36Lt.76.1.sam

#sam to bam
samtools view -@ 16 -Sb -o 36Lt.76.1.bam 36Lt.76.1.sam
#sort bam file
samtools sort -@ 16 -o 36Lt.76.1.sorted.bam 36Lt.76.1.bam
#index obtained mapping
samtools index 36Lt.76.1.sorted.bam

#the same for the 300b lib
bowtie2 -p 16 -x 36.10K.fn -1 ../../../data/Illumina/Mi-Seq/EF-36/EF-36_long_R1.fastq -2 ../../../data/Illumina/Mi-Seq/EF-36/EF-36_long_R2.fastq -S 36Lt.300.1.sam

samtools view -@ 16 -Sb -o 36Lt.300.1.bam 36Lt.300.1.sam
samtools sort -@ 16 -o 36Lt.300.1.sorted.bam 36Lt.300.1.bam
samtools index 36Lt.300.1.sorted.bam

#delete unnecessary files
rm 36.10K.fn.1.bt2 36.10K.fn.2.bt2 36.10K.fn.3.bt2 36.10K.fn.4.bt2 36.10K.fn.rev.1.bt2 36.10K.fn.rev.2.bt2 36Lt.300.1.bam 36Lt.300.1.sam 36Lt.76.1.bam 36Lt.76.1.sam
```



### Minimap2 (v2.17)

[Github](https://github.com/lh3/minimap2)

Installing

```
curl -L https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17_x64-linux.tar.bz2 | tar -jxvf -
```

 

Mapping LR, convert, sort and index

example lines:

```
./minimap2-2.17_x64-linux/minimap2 -ax map-pb ../data/36.10K.fn -t 16 -o ../out/minimap2/36Lt.10k.1.sam ../data/PacBio/PB.36Lt/36Lt_m54229_190211_052059.subreads.fasta

samtools view -@ 16 -Sb -o ../out/minimap2/36Lt.10k.1.bam ../out/minimap2/36Lt.10k.1.sam
samtools sort -@ 16 -o ../out/minimap2/36Lt.10k.1.sorted.bam ../out/minimap2/36Lt.10k.1.bam
samtools index ../out/minimap2/36Lt.10k.1.sorted.bam

rm 36Lt.10k.1.bam 36Lt.10k.1.sam
```



### Pilon

Example line

```
java -jar -Xmx500G pilon-1.23.jar \
	--genome ../data/11.10K.fasta \
	--frags ../out/11/76.1.sorted.bam \
	--frags ../out/11/300.1.sorted.bam \
	--pacbio ../out/11/10k.1.sorted.bam \
	--fix all --diploid --mingap 50 --changes --threads 24 \
	--output pilon1 --outdir ../out/11
```

Use the script `LtG/bin/13_run_pilon.sh` to do bot strains in 3 loops, one for pilon round including mapping steps



**Quast**

Quast  analyses of the development of the assembly trout the pilon pipeline

Sym link to some res to rename file

```
cd /space21/PGE/rangeles/LtG/out/pilon/quast
ln -s ../../canu/11Lt/11Lt.contigs.fasta 11Lt.canu.fasta
ln -s ../../sspace-lr/11Lt/scaffolds.fasta 11Lt.sspace.fasta
ln -s ../../gapfiller/11Lt/11Lt.gapfilled.final.fa 11Lt.gapfiller.fasta
```

```
quast 11Lt.canu.fasta 11Lt.sspace.fasta 11Lt.gapfiller.fasta ../11Lt.pilon1.fasta ../11Lt.pilon2.fasta ../11Lt.pilon3.fasta
```



## 2.6.- Purge_haplotigs (v1.1.1)

[git](https://github.com/skingan/purge_haplotigs_multiBAM)

Nead several dependences, almost all of them all ready in chichen but lastz

Instal [lastz-1.04.03.tar.gz](http://www.bx.psu.edu/~rsharris/lastz/)

```
#cd LtG/bin
tar -xvf lastz-1.04.03.tar.gz
mv lastz-distrib-1.04.03/ lastz-distrib
cd lastz-distrib/
```

Define installDir, open and edit by hand `make-include.mak`

```
nano make-include.mak

#-----------
# make-include.mak--
#       Defines variables used by all LASTZ Makefiles
#-----------

INSTALL =  install
ARCH    ?= $(shell uname -m)

ifdef LASTZ_INSTALL
installDir = ${LASTZ_INSTALL}
else
installDir = /home/rangeles/bin   # relative to somepath/lastz-distrib-X.XX.XX/src
endif
```

build the LASTZ executable

```
cd /space21/PGE/rangeles/LtG/bin/lastz-distrib/src
make
make install
make test
```



Instalar Purge Haplotigs

[github](https://github.com/skingan/purge_haplotigs_multiBAM)

```
git clone https://github.com/skingan/purge_haplotigs_multiBAM.git

cd purge_haplotigs_multiBAM/bin
export PATH=$PATH:$PWD

purge_haplotigs
# y ya me dio el help

cd ../test
make test
```

**Run** Purge haplotigs

0.- Prepare .bam file

1.- Meke an histogram and manual step

2.- Produces a contig coverage stats .csv file

3.- Run the purging pipeline

4.- Further curation



**Strain 11Lt:**

0.- Prepare .bam file with minimap with subreads on the pilon3 assemblies 

```
#map the reads over the contigs
./minimap2-2.17_x64-linux/minimap2 -ax map-pb ../res/Assemblies/11Lt.Pilon3.fasta -t 16 -o ../out/purge_haplotigs/11Lt.Pilon3.sam ../data/PacBio/PB.11Lt/11Lt_m54229_190211_153610.subreads.fasta

#sam to bam, sort and index bam
cd ../out/purge_haplotigs

samtools view -@ 16 -Sb -o 11Lt.Pilon3.bam 11Lt.Pilon3.sam
samtools sort -@ 16 -o 11Lt.Pilon3.sorted.bam 11Lt.Pilon3.bam
samtools index 11Lt.Pilon3.sorted.bam

#index the contigs
samtools faidx ../../res/Assemblies/11Lt.Pilon3.fasta -o 11Lt.Pilon3.faidx.fasta
#creo que no es necesario el -o
#generó `11Lt.Pilon3.fasta.fai` en `res/Assemblies/`

```

**1.- Meke an histogram and manual step**

```
nohup purge_haplotigs readhist -b 11Lt.Pilon3.sorted.bam -g ../../res/Assemblies/11Lt.Pilon3.fasta -t 16 &
```

in the histogram there are just one pike the diploid one

the small one (haploid to the left) is barely visible

detect the L, M and H values

11= 3, 7 , 180

mean diploid coverage =  55

2.- Produces a contig coverage stats .csv file

```
purge_haplotigs contigcov -i 11Lt.Pilon3.sorted.bam.gencov -l 3 -m 7 -h 180 -s 55 -j 101

mv coverage_stats.csv coverage_stats.11.csv
```

3.-

```
nohup purge_haplotigs purge  -g ../../res/Assemblies/11Lt.Pilon3.fasta -c coverage_stats.11.csv -b 11Lt.Pilon3.sorted.bam -dotplots -t 16 -o curated11 &
```

```
grep -c ">" curated11*fasta

curated11.artefacts.fasta:0
curated11.fasta:876
curated11.haplotigs.fasta:10
```

**Strain 36Lt:**

0.-

```
minimap2 -ax map-pb ../../res/Assemblies/36Lt.Pilon3.fasta -t 16 -o 36Lt.Pilon3.sam ../../data/PacBio/PB.36Lt/36Lt_m54229_190211_052059.subreads.fasta

samtools view -@ 16 -Sb -o 36Lt.Pilon3.bam 36Lt.Pilon3.sam
samtools sort -@ 16 -o 36Lt.Pilon3.sorted.bam 36Lt.Pilon3.bam
samtools index 36Lt.Pilon3.sorted.bam

samtools faidx ../../res/Assemblies/36Lt.Pilon3.fasta
```

1.-

```
purge_haplotigs readhist -b 36Lt.Pilon3.sorted.bam -g ../../res/Assemblies/36Lt.Pilon3.fasta -t 16
```

2.-

```
purge_haplotigs  contigcov  -i 36Lt.Pilon3.sorted.bam.gencov -l 20 -m 45 -h 180 -s 85 -j 101

mv coverage_stats.csv coverage_stats.36.csv
```

3.-

```
nohup purge_haplotigs purge  -g ../../res/Assemblies/36Lt.Pilon3.fasta -c coverage_stats.36.csv -b 36Lt.Pilon3.sorted.bam -dotplots -t 16 -o curated36 &

mv dotplots_reassigned_contigs dotplots_reassigned_contigs_36
```

```
grep -c ">" curated36*fasta
curated36.artefacts.fasta:0
curated36.fasta:77
curated36.haplotigs.fasta:0
```



## Quast (v5.2.0)

```
cd /space21/PGE/rangeles/LtG/res/Assemblies
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent 11Lt.Canu.fasta 11Lt.HybSPADes.fasta 11Lt.MaSuRCA.fasta  11Lt.Wtdbg2.fasta 11Lt.PurgeHap.fasta 11Lt.Pilon3.fasta 
```

Some of this results integrate table S6 on the paper.
