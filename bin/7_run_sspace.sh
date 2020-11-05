#!bin/sh
#Refine L.trichodermophora genomes
#using sspace
#usin 76 and 300 bp(x2)(SR) clean reads
#avoid perl warning/error
export LC_ALL=en_US.UTF-8

#1.- bwa mapping
#2.- sspace scaffolding

#1.- bwa
#create -l files
#lib of 300 read length
echo "Lib1 bwa ../../data/10Lt.300.R1_val_1.fq ../../data/10Lt.300.R2_val_2.fq 700 0.1 FR" > lib10Lt.300.txt
echo "Lib1 bwa ../../data/11Lt.300.R1_val_1.fq ../../data/11Lt.300.R2_val_2.fq 700 0.1 FR" > lib11Lt.300.txt
echo "Lib1 bwa ../../data/36Lt.300.R1_val_1.fq ../../data/36Lt.300.R2_val_2.fq 700 0.1 FR" > lib36Lt.300.txt
echo "Lib1 bwa ../../data/75Lt.300.R1_val_1.fq ../../data/75Lt.300.R2_val_2.fq 700 0.1 FR" > lib75Lt.300.txt
#lib of 76 read length
echo "Lib1 bwa ../../data/10Lt.76.R1_val_1.fq ../../data/10Lt.76.R2_val_2.fq 150 0.1 FR" > lib10Lt.76.txt
echo "Lib1 bwa ../../data/11Lt.76.R1_val_1.fq ../../data/11Lt.76.R2_val_2.fq 150 0.1 FR" > lib11Lt.76.txt
echo "Lib1 bwa ../../data/36Lt.76.R1_val_1.fq ../../data/36Lt.76.R2_val_2.fq 150 0.1 FR" > lib36Lt.76.txt
echo "Lib1 bwa ../../data/75Lt.76.R1_val_1.fq ../../data/75Lt.76.R2_val_2.fq 150 0.1 FR" > lib75Lt.76.txt
#lib of both reads
echo "Lib1 bwa ../../data/10Lt.300.R1_val_1.fq ../../data/10Lt.300.R2_val_2.fq 700 0.1 FR" > lib10Lt.SR.txt
echo "Lib2 bwa ../../data/10Lt.76.R1_val_1.fq ../../data/10Lt.76.R2_val_2.fq 150 0.1 FR" >> lib10Lt.SR.txt

echo "Lib1 bwa ../../data/11Lt.300.R1_val_1.fq ../../data/11Lt.300.R2_val_2.fq 700 0.1 FR" > lib11Lt.SR.txt
echo "Lib2 bwa ../../data/11Lt.76.R1_val_1.fq ../../data/11Lt.76.R2_val_2.fq 150 0.1 FR" >> lib11Lt.SR.txt

echo "Lib1 bwa ../../data/36Lt.300.R1_val_1.fq ../../data/36Lt.300.R2_val_2.fq 700 0.1 FR" > lib36Lt.SR.txt
echo "Lib2 bwa ../../data/36Lt.76.R1_val_1.fq ../../data/36Lt.76.R2_val_2.fq 150 0.1 FR" >> lib36Lt.SR.txt

echo "Lib1 bwa ../../data/75Lt.300.R1_val_1.fq ../../data/75Lt.300.R2_val_2.fq 700 0.1 FR" > lib75Lt.SR.txt
echo "Lib2 bwa ../../data/75Lt.76.R1_val_1.fq ../../data/75Lt.76.R2_val_2.fq 150 0.1 FR" >> lib75Lt.SR.txt

#run
#2.- sspace
cd ../out/sspace
for smpl in 10Lt 11Lt 36Lt 75Lt; do
    for lib in SR 76 300; do
        SSPACE_Standard_v3.0.pl \
        -l ../../bin/lib$smpl.$lib.txt \
        -s ../spades/$smpl.$lib/contigs.fasta \
        -x 1 \
        -k 5 -a 0.7 -m 32 -o 20 -T 30 \
        -b $smpl.$lib
    done
done

#3.- gap filler

#END
