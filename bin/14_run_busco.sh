#!bin/bash
#Run busco analysis for all assemblies generated before
###################
#Rodolfo Angeles 2020

#cd [...]/LtG/bin

#set environment:
#conda init bash
#conda activate busco

#some configuration steps to run only once:
#busco_configurator.py config_config.ini myconfig.ini
#BUSCO_CONFIG_FILE=/space21/PGE/rangeles/LtG/bin/myconfig.ini
#export AUGUSTUS_CONFIG_PATH=/space21/PGE/rangeles/Ltg/bin/config

##run busco

#mkdir ../out/busco
#cd ../res/Assemblies/
#ls *.fasta > genomelist.txt
#mv genomelist.txt ../../bin
#cd ../../bin

for genome in $(cat listforbusco.txt); do
	
	busco -i ../res/Assemblies/$genome \
	-l agaricales_odb10 \
	-o $genome.busco \
	-m geno \
	--out_path ../out/busco \
	-c 16 -f
 
done

##end


