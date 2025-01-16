#### ####
# Differential gene expression analysis course - RNAseq - alignment
#### ####

#### ####
# Packages
# You should install 'Rsubread' package 
#### ####
source("http://bioconductor.org/biocLite.R")
biocLite("Rsubread")

library(Rsubread)

#### ####
# Build a genome index for reference chromosome 1 sequence
#### ####
buildindex(basename="chr1",
           reference="hg19_chr1.fa")

#### ####
# Align reads to the indexed genome 
#### ####
align(index="chr1",
      readfile1="sequencing_sample.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="sequencing_sample.bam",
      unique=TRUE)

#### ####
# Calculate the proportion of mapped reads
#### ####
propmapped("sequencing_sample.bam")

#### ####
# Count numbers of reads mapped to built-in NCBI Refseq genes
#### ####
counts <- featureCounts(files="sequencing_sample.bam",
                        annot.inbuilt="hg19"())
View(counts$counts)
View(counts$annotation)
View(counts$stat)
