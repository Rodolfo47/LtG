#!bin/bash
#K-mer count with jellyfish
#############################################
#Rodolfo Angeles
#March 2020

#Run in Chichen at [...]/LtG/bin/
run from 
#set wd
cd ../out/jellyfish

#asign the strain, library and k-mer variables
for strain in 36Lt 11Lt 10Lt 75Lt; do
    for lib in 76 300; do
        for kmer in 19 23 27 31 35; do

        # counting
        ./../../bin/jellyfish-2.3.0/bin/jellyfish count \
        -C -m $kmer -s 10G -t 8 \
        -o $strain.$lib.$kmer-mer \
        ../../data/$strain.$lib.R1.val.fastq \
        ../../data/$strain.$lib.R2.val.fastq
        
        #get data frame for the histograme
        ./../../bin/jellyfish-2.3.0/bin/jellyfish histo \
        -o $strain.$lib.$kmer-mer.histo $strain.$lib.$kmer-mer
        
        done
    done
done

wc -l *.histo > kmernum.txt

#End