# The *Laccaria trichodermophora* genomes

This is the repository of the paper:

Ángeles-Argáiz *et al.* in prep. **Long-read sequencing decompresses *Laccaria trichodermophora* (CA15-11, CA15-75, CA15-F10 and EF-36) strains genome assemblies and reveal its intraspecific genome diversity.** for Genes, Genomes, Genetics.



**Aims and scope:**

In order to demonstrate the effect of the read length on the quality of *de novo* genome assembly of an ectomycorrhizal fungus we selected <u>four conspecific strains</u> of *Laccaria trichodermophora* for wide genome shotgun sequencing and <u>*de novo* assembling</u>. We generated and compared the genomic assemblies obtained with <u>two short-read (SR) libraries (76 b, 300 b) and one long-read (LR) library (>10 Kb)</u>. Assemblies were made using each library by it self, the two SR libraries together, and the all three in a hybrid approach. Likewise, we analyzed the <u>effect of the assembly quality</u> on the functional genomic inferences, focused <u>on CAZyme genes</u> to highlight some point differences in functional annotation. Additionally, we demonstrated that large differences in genome size within strains of *L. trichodermophora* correspond to <u>high genomic interspecific variation</u> and are not a methodological artifact.



**Work flow:**

​	1.- SRs assembly (scripts 1-8)

​		1.1.- Clean and trim

​		1.2.- Assembler and parameter selection

​		1.3.- Assembly and refinement of all strains

​	2.- Hybrid assembly (scripts 9-)

​		2.1.- HybridSPAdes

​		2.2.- MaSuRCA

​		2.3.- Wtdbg2

​		2.4.- Canu

​		2.5.- Pilon

​		2.6.- Purge haplotigs

​	3.- Comparison

​	4.- *K*-mer coverage

​	5.- Annotation (CAZy)



All computational protocols were made in the Chichen and Bonampak servers and in the Kayab cluster from Centro de Ciencias Genómicas, Universidad Nacional Autónoma de México (CCG,UNAM).



All scripts must be run from `~/LtG/bin/` dir.



**Working directory:**

`LtG/`

​	`Angeles-Argaiz_LtG_v1.pdf`

​	`README.md`

​	`1_SRs_Assemblies`

​	`2_Hybrid_assembly`

​	`3_Comparison`

​	`4_K-mer_coverage`

​	`5_Annotation_(CAZy)`

​	`bin/`

​	`data/`

​	`out/`

​	`res/`

