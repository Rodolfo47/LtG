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
