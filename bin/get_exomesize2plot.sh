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
