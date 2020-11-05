#!bin/sh
#Clean and trim L. trichodermophora raw sequencing data
#using trim_galore
#run

cd ../data

for smpl in 10Lt 11Lt 36Lt 75Lt; do
    for lib in 76 300; do
    trim_galore \
    --paired --illumina --retain_unpaired --fastqc \
    -o . $smpl.$lib.R1.fastq $smpl.$lib.R2.fastq 
    done
done

#END
