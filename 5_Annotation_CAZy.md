# 5.- Annotation (CAZy)

Gene model prediction of the 16 assemblies of the 4 strains of *L. trichodermophora* and its CAZome annotation.



**Work flow:**

5.1.- `16_run_augustus.sh`

5.2.- `17_run_dbcan.sh`

5.3.- `get_cazyMatrix.sh`

5.4.- Plotting

### 5.1.- Augustus

[git](https://github.com/Gaius-Augustus/Augustus)

Augustus were pre-installed with conda

```
conda activate busco
export LC_ALL=en_US.UTF-8
```

o

```
source activate /usr/local/bioconda/envs/busco
```

Configuration steps:

```
#copy config_cofing.ini and /config/ from root to LtG/bin
cp -r /usr/local/bioconda/envs/busco/config/ .

busco_configurator.py config_config.ini myconfig.ini
export BUSCO_CONFIG_FILE=/space21/PGE/rangeles/Busco/bin/myconfig.ini
export AUGUSTUS_CONFIG_PATH=/space21/PGE/rangeles/Busco/config
```

Example line:

```
nohup augustus --species=laccaria_bicolor --progress=true --singlestrand=true --genemodel=complete ../../res/Assemblies/75Lt.SR.fasta > 775Lt.SR.fasta.gff &

getAnnoFasta.pl 75Lt.SR.fasta.gff 
```

Execute:

Make a list of the genomes to be predicted (`/LtG/bin/listforaugustus.txt`) and run the augustus script `16_run_augustus.sh` .



Count genes and exome size with `sh get_exomesize2plot.sh` and use the `exomesizes2plot.csv` in r plotting.

```
#!bin/sh
#get the exome sizes of a bunch of predicted proteomes
#and create.csv containing:
# sample file (col 1)
# gene number (col 2)
# exome sizr in Mbp (col 3) 

#set wd
cd ../out/augustus

#extract total number of aa from a .aa file
ls *.aa > listforexomesize.txt
for aa in $(cat listforexomesize.txt); do
    grep -c ">" $aa >> gencoun.txt
    
    totaa=$(grep -v ">" $aa | tr -d '\n' | wc -c)
    #mutiply the aa by 3 to combert on na
    totna=$(expr $totaa \* 3)
    #expres the total na in Mbp
    echo "scale=2; $totna/1000000" | bc >> exosize.txt
 
done
#create file with file name and exome size value
paste -d "," listforexomesize.txt gencoun.txt exosize.txt > exomesizes2plot.csv
#delete intermediate files
rm listforexomesize.txt gencoun.txt exosize.txt

cat exomesizes2plot.csv
mv exomesizes2plot.csv ../../res
echo "/LtG/res/exomesizes2plot.csv"
#end
```

File are placed in res/

Must be manual edited prior to use with `barplot_gsize.r`.



### 5.2.- db_CAN2

[git](https://github.com/linnabrown/run_dbcan) 

**Instal**

Instal anaconda in my usr in chichen

```
conda activate
(base) [rangeles@chichen bin]$
```

```
#set and mk wd
cd /space21/PGE/rangeles/bin

#get installer
wget https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh
#install
sh Anaconda2-2019.10-Linux-x86_64.sh
```

Instal dbcan as an ambient 

```
#create an environment with some dependences
conda create -n run_dbcan python=3.8 diamond hmmer prodigal -c conda-forge -c bioconda
#activate this environment
conda activate run_dbcan
# instal
pip install run-dbcan==2.0.11
# databases
test -d db || mkdir db
cd db \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/CAZyDB.07312018.fa && diamond makedb --in CAZyDB.07312018.fa -d CAZy \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/dbCAN-HMMdb-V8.txt && mv dbCAN-HMMdb-V8.txt dbCAN.txt && hmmpress dbCAN.txt \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/tcdb.fa && diamond makedb --in tcdb.fa -d tcdb \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/tf-1.hmm && hmmpress tf-1.hmm \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/tf-2.hmm && hmmpress tf-2.hmm \
    && wget http://bcb.unl.edu/dbCAN2/download/Databases/stp.hmm && hmmpress stp.hmm \
    && cd ../ && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.fna \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.faa \
    && wget http://bcb.unl.edu/dbCAN2/download/Samples/EscheriaColiK12MG1655.gff
```

Check program

```
run_dbcan.py EscheriaColiK12MG1655.fna prok --out_dir output_EscheriaColiK12MG1655
#all ok
rm -r *Esch*
```



**Run dbcan**

Use the augustus predictions `$genes.aa` to search the CAZy models and functional domains.

dbCAN do 3 similar analyses: HMMER, DIAMOND and HotPep.

Activate the conda dbCAN ambient:

```
source activate /home/rangeles/.conda/envs/run_dbcan
```

Example line:

```
run_dbcan.py ../out/augustus/11Lt.Canu.fasta.aa protein --out_dir ../out/dbcan2/11Lt.Canu/ --db_dir ../../db/
```

Execute:

```
nohup sh run_dbCAN.sh > run_dbCAN.nohup.out &
```

The script `17_run_dbCAN.sh` just contain:

```
#!bin/sh
#Get the CAZy enzymes from the predicted proteomes

#mkdir ../out/dbCAN
#mk list for the loop and set wd
#cd ../out/augustus/
#ls *.aa > listofproteomes.txt
#mv listofproteomes.txt ../dbCAN
#cd ../dbCAN

#if the avove code blok are comented thern set wd
#or coment the next line
cd ../out/dbCAN

#run dbCAN
for proteome in $(cat listofproteomes.txt); do

    run_dbcan.py \
    ../augustus/$proteome protein \
    --db_dir ../../bin/db/ \
    --out_dir . \
    --out_pre $proteome.

done
#END
```

To do the dbCAN analyses on  some new proteomes just manually edit the ` list.txt` and comment (#) the first code block.



### 5.3.- get_cazyMatrix

Use the script `get_cazyMatrix.sh` to get the cazy matrix with the counts.

The script must be run including all but just the samples to be plotted in order to include the count "0" when some gene are present in some sample but not in other. 

```
#!bin/bash
# Parse and counting for CAZy
#############################################
#Rodolfo Angeles
#March 2020

#Run in Chichen at [...]/LtG/bin/

#¡¡¡ $strain and $assem must be customised
# for the actual cazomes in 2 for loops!!!

#run
cd ../out/dbCAN
mkdir counts
cd counts

#clean hmmr res from $overview.txt
for strain in 36Lt 11Lt; do
    for assem in Canu HybSPADes MaSuRCA Pilon1 Pilon2 Pilon3; do

    #delete 1st row (headers)| cut columns 1 and 2| delete (*)| delete CAZy less raw
    sed "1d" ../$strain.$assem.fasta.aa.overview.txt | \
    cut -f1,2  | \
    sed 's/([^)]*)//g;s/  / /g' | \
    grep -v "-" \
    > $strain.$assem.txt

    #get only CAZy column
    cut -f2 $strain.$assem.txt > $strain.$assem.only.txt
    #counting
    uniq -c $strain.$assem.only.txt > $strain.$assem.count

    done
done

#make the list of total CAZy from all samples
cat *.only.txt >> all.only.txt
sort all.only.txt | uniq -c > all.uniq.count
sort all.only.txt | uniq > all.uniq

#make counts file fore each sample vs total "pancazome"
#file with 0s
for strain in 36Lt 11Lt; do
    for assem in Canu HybSPADes MaSuRCA Pilon1 Pilon2 Pilon3; do
        for s in $(cat all.uniq); do 
        
        grep -c -w $s $strain.$assem.only.txt \
        >> $strain.$assem.full_count
        
        done
        #insert sample name as headers
        echo $strain.$assem | \
        cat - $strain.$assem.full_count \
        > $strain.$assem.full_count.head
        
    done
done

#insert header on cazy names column
echo CAZy | cat - all.uniq > 00.head
#merge samples as columns on final matrix.csv
paste -d "," *.head > cazyMatrix.csv

#End
```

Results were paced in`/LtG/out/dbCAN/counts/cazyMatrix.csv`.

Don't worry about:

```
sed: can't read ../10Lt.Canu.fasta.aa.overview.txt: No such file or directory
sed: can't read ../10Lt.PurgeHap.fasta.aa.overview.txt: No such file or directory
sed: can't read ../75Lt.Canu.fasta.aa.overview.txt: No such file or directory
sed: can't read ../75Lt.PurgeHap.fasta.aa.overview.txt: No such file or directory
```

cause those assembles no exist so are no used.



### 5.4.- Plotting



Delete empty columns and set column order in `cazyMatrix.csv`-> `res/cazyMatrix.ed.csv`.

Use `heatmapCAZy.r` to plotting `cazyMatrix.ed.csv` to create Figure 3C and S12.

To create figure 3A use `barplot_cazydif.r` on the same edited matrix `cazyMatrix.ed.csv`.

Use `venn_cazy.r` to create figure 3B.

Also use the `correlationTest.r` to test some assertions made in the text about the relationship between assemblies, the size of the genomes and the CAZomes.

