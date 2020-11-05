#!bin/sh
#Testing Velvet assembler with 1 sample and 1 lib
# and several k sizes

cd ../out
mkdir velvet
for k in 63 65 67 69 71 73 75; do
    #hash and k-mers
    velveth velvet/36Lt_$k $k \
    -fastq -shortPaired \
    ../data/36Lt.76.R1_val_1.fq ../data/36Lt.76.R2_val_2.fq
    
    #graph and contigs
    velvetg velvet/36Lt_$k \
    -cov_cutoff 10 \
    -min_contig_lgth 1000
done

#end
