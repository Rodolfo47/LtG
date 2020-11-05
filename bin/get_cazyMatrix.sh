#!bin/bash
# Parse and counting for CAZy
#############################################
#Rodolfo Angeles
#March 2020

#Run in Chichen at [...]/LtG/bin/

### $strain and $assem must be customised
### for the actual cazomes in 2 (two!) for loops!!!

#run
cd ../out/dbCAN
mkdir counts
cd counts

#clean hmmr res from $overview.txt
for strain in 10Lt 11Lt 36Lt 75Lt; do
    for assem in 76 300 SR Canu PurgeHap; do

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
for strain in 10Lt 11Lt 36Lt 75Lt; do
    for assem in 76 300 SR Canu PurgeHap; do
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
#delete intermediary files

#End