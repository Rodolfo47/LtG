#!bin/bash
##Hybrid assembly of Lt with Pilon##
#############################################
#Rodolfo Angeles
#March 2020

#This script run in the Chichen server at
#[...]/LtG/bin

#Dependences:
#   Bowtie2 (instaled)
#   samtools (instaled)
#   Minimap2 (./bin/)
#   Pilon (java -jar -Xmx500G /bin/)

#input files for this script are:
#1.- Canu/sspace/gapfiller assembly (.fasta)
#2.- Sequencing short and long reads (.fastq and .fasta)

#Mine steps:
#1.- Create .bam files (bowtie2 and minimap2)
#2.- Polish assembly (pilon)
#3.- Repear steps 1 and 2 (contained in a function)
#    other 2 times using as input the ouput of the last round
#    with the reads mapped to the last round genome
#    by set the values of some variables

##################################################


##Run pilon rounds with the function by set var values
###########
#1st roun
inGeno="pilon0" 
bamRound="1" 
outGeno="pilon1"

for strain in 36Lt 11Lt; do
    cd ../out/pilon #set wd    
    
    ##Creating 3.bam files (1st step)
    #indexin the reference genome
    bowtie2-build $strain.$inGeno.fasta $strain.$inGeno.fasta --threads 20

    #mapping the SRs
    for lib in 76 300; do

        bowtie2 -p 20 -x $strain.$inGeno.fasta -1 ../../data/$strain.$lib.R1.fastq -2 ../../data/$strain.$lib.R2.fastq -S $strain.$lib.$bamRound.sam

        #sam to bam
        samtools view -@ 20 -Sb -o $strain.$lib.$bamRound.bam $strain.$lib.$bamRound.sam
        #sort bam file
        samtools sort -@ 20 -o $strain.$lib.$bamRound.sorted.bam $strain.$lib.$bamRound.bam
        #index obtained mapping
        samtools index $strain.$lib.$bamRound.sorted.bam

    done
        
    #Minimap mapping 10kb reads on canu/sspace/gapfiller assembly and 
    ./../../bin/minimap2-2.17_x64-linux/minimap2 -ax map-pb $strain.$inGeno.fasta -t 20 -o $strain.10k.$bamRound.sam ../../out/canu/$strain/$strain.correctedReads.fasta.gz

    #sam to bam and aff
    samtools view -@ 20 -Sb -o $strain.10k.$bamRound.bam $strain.10k.$bamRound.sam
    samtools sort -@ 20 -o $strain.10k.$bamRound.sorted.bam $strain.10k.$bamRound.bam
    samtools index $strain.10k.$bamRound.sorted.bam

    cd ../../bin 

    ##polish with pilon (2nd step)
    java -jar -Xmx500G pilon-1.23.jar --genome ../out/pilon/$strain.$inGeno.fasta --frags ../out/pilon/$strain.76.$bamRound.sorted.bam --frags ../out/pilon/$strain.300.$bamRound.sorted.bam --pacbio ../out/pilon/$strain.10k.$bamRound.sorted.bam --fix all --diploid --mingap 50 --changes --threads 20 --output $strain.$outGeno --outdir ../out/pilon
    
done

#2nd roun
inGeno="pilon1"
bamRound="2"
outGeno="pilon2"

for strain in 36Lt 11Lt; do
    cd ../out/pilon #set wd    
    
    ##Creating 3.bam files (1st step)
    #indexin the reference genome
    bowtie2-build $strain.$inGeno.fasta $strain.$inGeno.fasta --threads 20

    #mapping the SRs
    for lib in 76 300; do

        bowtie2 -p 20 -x $strain.$inGeno.fasta -1 ../../data/$strain.$lib.R1.fastq -2 ../../data/$strain.$lib.R2.fastq -S $strain.$lib.$bamRound.sam

        #sam to bam
        samtools view -@ 20 -Sb -o $strain.$lib.$bamRound.bam $strain.$lib.$bamRound.sam
        #sort bam file
        samtools sort -@ 20 -o $strain.$lib.$bamRound.sorted.bam $strain.$lib.$bamRound.bam
        #index obtained mapping
        samtools index $strain.$lib.$bamRound.sorted.bam

    done
        
    #Minimap mapping 10kb reads on canu/sspace/gapfiller assembly and 
    ./../../bin/minimap2-2.17_x64-linux/minimap2 -ax map-pb $strain.$inGeno.fasta -t 20 -o $strain.10k.$bamRound.sam ../../out/canu/$strain/$strain.correctedReads.fasta.gz

    #sam to bam and aff
    samtools view -@ 20 -Sb -o $strain.10k.$bamRound.bam $strain.10k.$bamRound.sam
    samtools sort -@ 20 -o $strain.10k.$bamRound.sorted.bam $strain.10k.$bamRound.bam
    samtools index $strain.10k.$bamRound.sorted.bam

    cd ../../bin 

    ##polish with pilon (2nd step)
    java -jar -Xmx500G pilon-1.23.jar --genome ../out/pilon/$strain.$inGeno.fasta --frags ../out/pilon/$strain.76.$bamRound.sorted.bam --frags ../out/pilon/$strain.300.$bamRound.sorted.bam --pacbio ../out/pilon/$strain.10k.$bamRound.sorted.bam --fix all --diploid --mingap 50 --changes --threads 20 --output $strain.$outGeno --outdir ../out/pilon
    
done

#3rd roun
inGeno="pilon2"
bamRound="3"
outGeno="pilon3"

for strain in 36Lt 11Lt; do
    cd ../out/pilon #set wd    
    
    ##Creating 3.bam files (1st step)
    #indexin the reference genome
    bowtie2-build $strain.$inGeno.fasta $strain.$inGeno.fasta --threads 20

    #mapping the SRs
    for lib in 76 300; do

        bowtie2 -p 20 -x $strain.$inGeno.fasta -1 ../../data/$strain.$lib.R1.fastq -2 ../../data/$strain.$lib.R2.fastq -S $strain.$lib.$bamRound.sam

        #sam to bam
        samtools view -@ 20 -Sb -o $strain.$lib.$bamRound.bam $strain.$lib.$bamRound.sam
        #sort bam file
        samtools sort -@ 20 -o $strain.$lib.$bamRound.sorted.bam $strain.$lib.$bamRound.bam
        #index obtained mapping
        samtools index $strain.$lib.$bamRound.sorted.bam

    done
        
    #Minimap mapping 10kb reads on canu/sspace/gapfiller assembly and 
    ./../../bin/minimap2-2.17_x64-linux/minimap2 -ax map-pb $strain.$inGeno.fasta -t 20 -o $strain.10k.$bamRound.sam ../../out/canu/$strain/$strain.correctedReads.fasta.gz

    #sam to bam and aff
    samtools view -@ 20 -Sb -o $strain.10k.$bamRound.bam $strain.10k.$bamRound.sam
    samtools sort -@ 20 -o $strain.10k.$bamRound.sorted.bam $strain.10k.$bamRound.bam
    samtools index $strain.10k.$bamRound.sorted.bam

    cd ../../bin 

    ##polish with pilon (2nd step)
    java -jar -Xmx500G pilon-1.23.jar --genome ../out/pilon/$strain.$inGeno.fasta --frags ../out/pilon/$strain.76.$bamRound.sorted.bam --frags ../out/pilon/$strain.300.$bamRound.sorted.bam --pacbio ../out/pilon/$strain.10k.$bamRound.sorted.bam --fix all --diploid --mingap 50 --changes --threads 20 --output $strain.$outGeno --outdir ../out/pilon
    
done

##End of script