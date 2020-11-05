#!bin/sh

for strain in 36Lt 11Lt; do
 
 SSPACE-LongRead.pl \
 -c ../out/canu/$strain/$strain.contigs.fasta \
 -p ../data/$strain.10k.subreads.fasta \
 -b ../out/sspace-lr/$strain/ \
 -t 20

done
