#!bin/sh
#Refine L.trichodermophora genomes
#Refine usin 76 and 300 bp(x2) clean reads


#run gap filler
cd ../out/gapfiller_SRs

for smpl in 10Lt 11Lt 36Lt 75Lt; do
    for lib in SR 300 76; do
    GapFiller.pl \
    -l ../../bin/lib$smpl.$lib.txt \
    -s ../sspace/$smpl.$lib/$smpl.$lib.final.scaffolds.fasta \
    -b $smpl.$lib \
    -T 16
    done
done


#END
