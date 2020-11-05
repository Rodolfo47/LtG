#!bin/sh
# Assembling L.trichodermophora genomes
# using Hybrid spades

#Avoid perl warning
export LC_ALL=en_US.UTF-8

#run

# Run spades with 3 libraries
for smpl in 11Lt 36Lt; do
    spades.py \
    -1 ../data/$smpl.76.R1_val_1.fq \
    -2 ../data/$smpl.76.R2_val_2.fq \
    -1 ../data/$smpl.300.R1_val_1.fq \
    -2 ../data/$smpl.300.R2_val_2.fq \
    --pacbio ../data/$smpl.10k.subreads.fasta \
    --careful \
    -t 8 \
    -o ../out/hybridSPAdes/$smpl/
done

#END
