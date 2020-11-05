#!bin/sh
#Testing SPAdes assembler with 1 sample and 1 lib
#and 3 k-mer sets

mkdir ../out/spadesTest
#1.- default
spades.py \
    -1 ../data/36Lt.76.R1_val_1.fq \
    -2 ../data/36Lt.76.R2_val_2.fq \
    --careful \
    -t 20 \
    -o ../out/spadesTest/default_36Lt.76

#2.- step 10

spades.py \
    -1 ../data/36Lt.76.R1_val_1.fq \
    -2 ../data/36Lt.76.R2_val_2.fq \
    --careful \
    -t 20 \
    -k 31,41,51,61,71 \
    -o ../out/spadesTest/step10_36Lt.76

#3.- step 5

spades.py \
    -1 ../data/36Lt.76.R1_val_1.fq \
    -2 ../data/36Lt.76.R2_val_2.fq \
    --careful \
    -t 20 \
    -k 31,35,41,45,51,55,61,65,71,75 \
    -o ../out/spadesTest/step5_36Lt.76

#end
