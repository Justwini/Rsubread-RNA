########################################
#Differential gene expression analysis 
######################################## 


######################
# Install Packages 

#install.packages("BiocManager")
#BiocManager::install("Rsubread")
library(Rsubread)


###########################################################
# Build a genome index for reference chromosome 1 sequence

buildindex(basename="chr1",
           reference="hg19_chr1.fa")

####################################
# Align reads to the indexed genome 

align(index="chr1",
      readfile1="one.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="stringent.bam",
      unique=TRUE,
        maxMismatches=3)

align(index="chr1",
      readfile1="one.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="lessstringent.bam",
      unique=FALSE,
      maxMismatches=5)

###############################################################
#Creating table to compare aligments with diffrent parameters

TABLE = propmapped(c("stringent.bam","lessstringent.bam"))
TABLE

###############################################################
#Creating feature caounts to compare aligments with diffrent parametes
#with and without uniqe

counts <- featureCounts(files=c("stringent.bam","lessstringent.bam"),
                        annot.inbuilt="hg19")
counts_lessstringent <- featureCounts(files="lessstringent.bam",
                                  annot.inbuilt = "hg19")
View(counts_stringent$counts)



