# 1.- SRs Assemblies

Short-reads assemblies of the four *L. trichodermophora* strains using the one ("76": Next-Seq 500; 76x2), the other one ("300": Mi-Seq; 300x2) or two Illumina libraries.

All scripts were run from the bin directory.



**Work flow:**

1.1.- Clean and trim

1.2.- Assembler and parameter selection

1.3.- Four strain and tree library assembly and refinement



**Run:**

All scripts must be run from `~/LtG/bin/` dir.

## 1.1.- Clean and trim

Prior to clean and trim, for each strain, the four NextSeq flow-cell data were merge and symbolic links were created with standard file names in `data/` dir. 

Raw data quality control with **FastQC** (v0.11.8):

```
mkdir ../data/FASTQC_raw
cd ../data/
```

```
fastqc -o FASTQC_raw -f fastq *.*.R1.fastq *.*.R2.fastq
```

### Trim_galore (v 0.6.4)

```
export LC_ALL=en_US.UTF-8
```

Example line:

```
trim_galore \
 --paired --illumina --retain_unpaired --fastqc \
 -o . 10Lt.76.R1.fastq 10Lt.76.R2.fastq
```

Execute in bach:

```
cd ../bin/
nohup sh 1_run_trim_galore.sh > run_trim_galore.nohup.out &
```

ok, 4 hrs runing

```
#store fastqc.html report in specific directory
cd ../data; mkdir FASTQC_clean
mv *fastqc.html FASTQC_clean
```

Results:

Clean and trimmed `*.fq` files in `/LtG/data/`.

|                                  | <u>10Lt.76.R1</u>        | <u>10Lt.76.R2</u>        |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 26,730,981               | 26,730,981               |
| Reads with adapters:             | 10,536,589 (39.4%)       | 10,490,526 (39.2%)       |
| Reads written (passing filters): | 26,730,981 (100.0%)      | 26,730,981 (100.0%)      |
| Total basepairs processed:       | 2,013,881,901 bp         | 2,010,722,400 bp         |
| Quality-trimmed:                 | 7,624,135 bp (0.4%)      | 32,641,786 bp (1.6%)     |
| Total written (filtered):        | 1,991,850,314 bp (98.9%) | 1,963,852,404 bp (97.7%) |

|                                  | <u>10Lt.300.R1</u>     | <u>10Lt.300.R2</u>     |
| -------------------------------- | ---------------------- | ---------------------- |
| Total reads processed:           | 2,040,731              | 2,040,731              |
| Reads with adapters:             | 667,789 (32.7%)        | 725,136 (35.5%)        |
| Reads written (passing filters): | 2,040,731 (100.0%)     | 2,040,731 (100.0%)     |
| Total basepairs processed:       | 590,472,860 bp         | 591,188,333 bp         |
| Quality-trimmed:                 | 34,432,349 bp (5.8%)   | 105,337,904 bp (17.8%) |
| Total written (filtered):        | 555,076,365 bp (94.0%) | 484,862,840 bp (82.0%) |



|                                  | <u>11Lt.76.R1</u>        | <u>11Lt.76.R2</u>        |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 64,249,826               | 64,249,826               |
| Reads with adapters:             | 25,370,796 (39.5%)       | 24,966,088 (38.9%)       |
| Reads written (passing filters): | 64,249,826 (100.0%)      | 64,249,826 (100.0%)      |
| Total basepairs processed:       | 4,787,459,330 bp         | 4,781,641,197 bp         |
| Quality-trimmed:                 | 17,357,340 bp (0.4%)     | 74,737,880 bp (1.6%)     |
| Total written (filtered):        | 4,735,320,730 bp (98.9%) | 4,672,839,633 bp (97.7%) |

|                                  | <u>11Lt.300.R1</u>     | <u>11Lt.300.R2</u>     |
| -------------------------------- | ---------------------- | ---------------------- |
| Total reads processed:           | 4,066,964              | 4,066,964              |
| Reads with adapters:             | 1,228,562 (30.2%)      | 1,319,374 (32.4%)      |
| Reads written (passing filters): | 4,066,964 (100.0%)     | 4,066,964 (100.0%)     |
| Total basepairs processed:       | 1,013,796,921 bp       | 1,017,597,220 bp       |
| Quality-trimmed:                 | 44,383,789 bp (4.4%)   | 143,606,094 bp (14.1%) |
| Total written (filtered):        | 967,541,978 bp (95.4%) | 872,091,941 bp (85.7%) |



|                                  | <u>36Lt.76.R1</u>        | <u>36Lt.76.R2</u>        |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 128,404,683              | 128,404,683              |
| Reads with adapters:             | 49,449,288 (38.5%)       | 48,181,752 (37.5%)       |
| Reads written (passing filters): | 128,404,683 (100.0%)     | 128,404,683 (100.0%)     |
| Total basepairs processed:       | 9,357,605,856 bp         | 9,356,690,528 bp         |
| Quality-trimmed:                 | 51,247,321 bp (0.5%)     | 162,384,169 bp (1.7%)    |
| Total written (filtered):        | 9,238,084,475 bp (98.7%) | 9,127,810,111 bp (97.6%) |

|                                  | 36Lt.300.R1              | <u>36Lt.300.R2</u>       |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 7,981,238                | 7,981,238                |
| Reads with adapters:             | 2,157,945 (27.0%)        | 2,296,095 (28.8%)        |
| Reads written (passing filters): | 7,981,238 (100.0%)       | 7,981,238 (100.0%)       |
| Total basepairs processed:       | 1,622,029,112 bp         | 1,636,795,522 bp         |
| Quality-trimmed:                 | 41,989,855 bp (2.6%)     | 178,801,344 bp (10.9%)   |
| Total written (filtered):        | 1,576,595,078 bp (97.2%) | 1,454,503,704 bp (88.9%) |



|                                  | <u>75Lt.76.R1</u>        | <u>75Lt.76.R2</u>        |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 106,996,984              | 106,996,984              |
| Reads with adapters:             | 41,142,011 (38.5%)       | 40,128,786 (37.5%)       |
| Reads written (passing filters): | 106,996,984 (100.0%)     | 106,996,984 (100.0%)     |
| Total basepairs processed:       | 7,798,240,124 bp         | 7,797,021,749 bp         |
| Quality-trimmed:                 | 42,989,225 bp (0.6%)     | 135,877,755 bp (1.7%)    |
| Total written (filtered):        | 7,698,443,464 bp (98.7%) | 7,605,771,805 bp (97.5%) |

|                                  | <u>75Lt.300.R1</u>       | <u>75Lt.300.R2</u>       |
| -------------------------------- | ------------------------ | ------------------------ |
| Total reads processed:           | 6,797,912                | 6,797,912                |
| Reads with adapters:             | 1,863,971 (27.4%)        | 1,970,277 (29.0%)        |
| Reads written (passing filters): | 6,797,912 (100.0%)       | 6,797,912 (100.0%)       |
| Total basepairs processed:       | 1,418,207,600 bp         | 1,430,745,935 bp         |
| Quality-trimmed:                 | 38,265,836 bp (2.7%)     | 173,548,880 bp (12.1%)   |
| Total written (filtered):        | 1,376,992,685 bp (97.1%) | 1,254,221,644 bp (87.7%) |

FastQC results of trim_galore and of the raw data are presented in supplementary material of the paper.



## 1.2.- Assembler and parameter selection

As the first assembling approach we test four pair-end assemblers by using only one library and only one sample.

```
cd ../bin/
mkdir ../out/abyss ../out/idba ../out/spades ../out/velvet
```



### ABySS (2.0.1)

Example line:

```
abyss-pe k=53 \
    name=36Lt.k53 \
    j=18 \
    lib='76lib' \
    76lib='../../../data/36Lt.76.R1_val_1.fq ../../../data/36Lt.76.R2_val_2.fq'
    cd ..
```

Execute the bulk:

```
nohup sh 2_run_abyss.sh > 2_run_abyss.sh &
```

Evaluate the results:

```
cd ../out/abyss
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent */*Lt.*contigs.fa */*Lt.*scaffolds.fa
```

Some of this quast results integrate supplementary tables of the paper.

### IDBA_UD

Consisting in 2 steps:

1.- Prepare input reads

2.- Do the assembly

```
cd ../../bin
```

Example lines:

```
# interlave the paired reads in a single file
interleave-reads.py ../../data/10Lt.76.R1_val_1.fq ../../data/10Lt.76.R2_val_2.fq -o 10Lt.76.inter.fq
# delete qualities
fastq_to_fasta -n -v -i 10Lt.76.inter.fq -o 10Lt.76.inter.fa
```

```
# assembling with several k-mer sizes with a step of 10 bases
idba_ud -r 10Lt.76.inter.fa --mink 31 --maxk 121 --step 10 --pre_correction -o idba_31-121_s10 --num_threads 16
```

Ran with the script and storage the log

```
nohup sh 3_run_idba.sh > 3_run_idba.nohup.out &
```

Evaluate the results:

```
cd ../out/idba
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent idba_31-121_s10/contig-*.fa idba_31-121_s10/contig.fa idba_31-121_s10/scaffold.fa
```

Some of this quast results integrate supplementary tables of the paper.

### SPAdes (3.12.0)

```
cd ../../bin
```

Testing SPAdes using default k-mer size and custom -k

Example line:

```
spades.py \
    -1 ../data/36Lt.76.R1_val_1.fq \
    -2 ../data/36Lt.76.R2_val_2.fq \
    --careful \
    -t 20 \
    -k 31,41,51,61,71 \
    -o ../out/spadesTest/step10_36Lt.76
```

Execute in bulk:

```
nohup sh 4_run_spadesTest.sh > 4_run_spadesTest.nohup.out &
```

Evaluate the results:

```
cd ../out/spadesTest
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent -L *_36Lt.76/contigs.fasta *_36Lt.76/scaffolds.fasta 
```

Some of this quast results integrate supplementary tables of the paper.

### Velvet (1.2.10)

```
cd ../../bin
```

Velvet pipeline is also consisting in 2 steps:

1.- Create the k-mers

2.- Create the contigs

Example lines:

```
#hash and k-mers
	velveth velvet/36Lt_71 71 \
	-fastq -shortPaired \
	../data/36Lt.76.R1_val_1.fq ../data/36Lt.76.R2_val_2.fq
    
#graph and contigs
	velvetg velvet/36Lt_71 \
	-cov_cutoff 10 \
	-min_contig_lgth 1000
```

Execute in bulk

```
nohup sh 5_run_velvet.sh > 5_run_velvet.nohup.out &
```

```
cd ../out/velvet
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent -L 36Lt_*/contigs.fa
```

Some of this quast results integrate supplementary tables of the paper.

### Quast (v5.0.2)

Comparing between the best result of each assembler

```
cd ..
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent -L abyss/63/36Lt.k63-contigs.fa abyss/63/36Lt.k63-scaffolds.fa idba/idba_31-121_s10/contig.fa idba/idba_31-121_s10/scaffold.fa spadesTest/default_36Lt.76/contigs.fasta spadesTest/default_36Lt.76/scaffolds.fasta velvet/36Lt_63/contigs.fa
```

The results of this quast are the supplemantary table S5.

## 1.3.- Assembly and refinement of all strains

In the previous section the SPADes assembler were selected for the forward analyses and procedures of all strains. Then, refinement were done by scaffolding and gap filling. 



### Spades (v 3.13.1)

Assemble all strains using one, the other or both SRs libraries together.

In the server there are Python v 3.7.3.

```
cd ../bin
```

Example line:

```
spades.py -1 ../data/36Lt.76.R1_val_1.fq -2 ../data/36Lt.76.R2_val_2.fq --careful -t 40 -o ../out/spades/36Lt.76/
```

Execute all assemblies in bulk:

```
nohup sh 6_run_spades.sh > 6_run_spades.nohup.out &
```



### SSPACE_Standard (v3.0)

Scaffolding with sspace the scaffolds proposed with sspace:

Example lines:

```
#create configuration file
echo "Lib1 bwa ../../data/36Lt.300.R1_val_1.fq ../../data/36Lt.300.R2_val_2.fq 700 0.1 FR" > lib36Lt.300.txt

#run scaffolding
SSPACE_Standard_v3.0.pl -l ../../bin/lib36Lt.300.txt -s ../spades/36Lt.300/scaffolds.fasta -x 1 -k 5 -a 0.7 -m 32 -o 20 -T 10 -b 36Lt.300
```

Execute bulk scaffolding including configuration file creation and scaffolding:

```
nohup sh 7_run_sspace.sh > 7_run_sspace.nohup.out &
```



### GapFiller (v1-10)

Filling gaps in the scaffolds with GapFiller using the same `lib*.txt` of sspace:

Example line

```
GapFiller.pl \
    -l ../../bin/lib36Lt.76.txt \
    -s ../sspace/36Lt.76/36Lt.76.final.scaffolds.fasta \
    -b 36Lt.76 \
    -T 16
```

Run the in bulk:

```
nohup sh 8_run_gapfillerSRs.sh > 8_run_gapfillerSRs.nohup.out &
```



Place the main results in `/res/Assemblies/`:

```
cd ../res; mkdir Assemblies/; cd Assemblies/
cp ../../out/gapfiller_SRs/75Lt.76/*gapfilled.final.fa .
mv *.gapfilled.final.fa 75Lt.76.fasta
#repeat this for all assemblies (strain/library)
```

Get the quast qualifiers to include them in table 3 of the paper (run after finish the `2_Hybrid assemblies.md` work flow):

```
quast -t 20 --memory-efficient -m 1000 -i 500 -x 7000 --silent *.76.fasta *.300.fasta *.SR.fasta *.Canu.fasta *.PurgeHap.fasta
```

