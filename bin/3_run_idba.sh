#!bin/sh
#Testing IDBA_UD assembler with 1 sample and 1 lib
# and several k sizes
# 1.- Prepare data
# 2.- Assembling
cd ../out/idba
# interlave the paired reads in a single file
interleave-reads.py \
../../data/36Lt.76.R1_val_1.fq \
../../data/36Lt.76.R2_val_2.fq \
-o 36Lt.76.inter.fq

# delete qualities
fastq_to_fasta -n -v -i 36Lt.76.inter.fq -o 36Lt.76.inter.fa

#assembling
idba_ud -r 36Lt.76.inter.fa \
--mink 31 --maxk 121 --step 10 --pre_correction \
-o idba_31-121_s10 \
--num_threads 16

# End
