#!bin/sh
#Testing ABySS assembler with 1 sample and 1 lib
# and several k sizes

cd ../out/abyss

#run

for kam in 33 43 53 63 73; do
    mkdir $kam
    cd $kam

    abyss-pe k=$kam \
    name=36Lt.k$kam \
    j=18 \
    lib='76lib' \
    76lib='../../../data/36Lt.76.R1_val_1.fq ../../../data/36Lt.76.R2_val_2.fq'
    cd ..
done
