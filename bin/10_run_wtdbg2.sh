#/bin/sh

#Run wtdbg2 with PB.11Lt and PB.36Lt
###

#Ran in Chichen at [...]/LtG/bin/

#Install wtdbg2 in bin with:

#git clone https://github.com/ruanjue/wtdbg2
#cd wtdbg2 && make
#cd ..

#Run
cd ../out/wtdbg2/
t="8"
for strain in 36Lt 11Lt; do
# assemble long reads
./../../bin/wtdbg2/wtdbg2 \
-x sq -g 70m -t $t \
-i ../../data/$strain.10k.subreads.fasta \
-fo $strain

# derive consensus
./../../bin/wtdbg2/wtpoa-cns -t $t \
-i $strain.ctg.lay.gz \
-fo $strain.raw.fa

# Polishment using short reads
#map SRs

bwa index $strain.raw.fa
bwa mem -t $t $strain.raw.fa \
../../data/$strain.76.R1.fastq \
../../data/$strain.76.R2.fastq | \
samtools sort -O SAM | \
./../../bin/wtdbg2/wtpoa-cns -t $t \
-x sam-sr -d $strain.raw.fa \
-i - -fo $strain.srp.fa

done
#End