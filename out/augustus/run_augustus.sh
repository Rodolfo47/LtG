#!bin/bash
# augustus prediction on the main assembly res

# run
for genome in $(cat listforaugustus.txt); do
    augustus \
    --species=laccaria_bicolor \
    --progress=true \
    --singlestrand=true \
    --genemodel=complete \
    ../../res/Assemblies/$genome > $genome.gff

    getAnnoFasta.pl $genome.gff

done
# end
