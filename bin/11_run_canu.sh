#!bin/sh

for str in 11Lt 36Lt; do
	canu -p $str \
	-d ../out/canu/$str \
	genomeSize=70m \
	-pacbio-raw ../data/$str.10k.subreads.fasta
done
