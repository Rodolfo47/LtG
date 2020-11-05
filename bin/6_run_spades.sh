#!bin/sh
#Assembling L.trichodermophora genomes
#Assemble using 76 bp(x2) clean reads

#1.- Using library 75
#2.- Using library 300
#3.- Using both libraries 

#run
#1.- Using library 75

for smpl in 10Lt 11Lt 36Lt 75Lt; do
    spades.py \
    -1 ../data/$smpl.76.R1_val_1.fq \
    -2 ../data/$smpl.76.R2_val_2.fq \
    --careful \
    -t 20 \
    -o ../out/spades/$smpl.76/
done

#2.- Using library 300
for smpl in 10Lt 11Lt 36Lt 75Lt; do
    spades.py \
    -1 ../data/$smpl.300.R1_val_1.fq \
    -2 ../data/$smpl.300.R2_val_2.fq \
    --careful \
    -t 20 \
    -o ../out/spades/$smpl.300/
done

#3.- Using both libraries 
for smpl in 10Lt 11Lt 36Lt 75Lt; do
    spades.py \
    -1 ../data/$smpl.76.R1_val_1.fq \
    -2 ../data/$smpl.76.R2_val_2.fq \
    -1 ../data/$smpl.300.R1_val_1.fq \
    -2 ../data/$smpl.300.R2_val_2.fq \
    --careful \
    -t 20 \
    -o ../out/spades/$smpl.SR/
done

#END
