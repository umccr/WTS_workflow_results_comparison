library(tximport)
library(tximportData)
# Read in salmon counts (should be better than alignment based methods)
test_salmon <- list.files("~/Documents/UMCCR/data/WTS_comparison/CCR180072_VPT_WH16/bcbio_native/run_1/salmon/", pattern = "quant.sf", full.names = T)

# Read in the tximport data
dir <- system.file("extdata", package = "tximportData")
tx2ensembl <- read_csv(file.path(dir, "tx2gene.ensembl.v87.csv"))

# Look at countsFromAbundance parameter to change the method to generate the counts
txi.salmon <- tximport(test_salmon, type = "salmon", tx2gene = tx2ensembl)

# How tximport calcuated the counts
txi.salmon$countsFromAbundance

# Gene level counts from TPMs
counts <- txi.salmon$counts

# Gene level TPMs (calculated by tximport from salmon transcript level TPMs)
abundance <- txi.salmon$abundance

#Read the Ensembl gene names off an A5 run
names <- read_tsv("/Users/adpattison/Documents/Projects/Year_2018/A5study/RNA-Seq/Counts_tables/NEB_vs_Illumina_TEST.tsv")%>%
  dplyr::select(ensID = id, symbol)

# Get a list of gene names and IDs for limma
genes_in_salmon <- data.frame(ensID = rownames(counts))%>%
  left_join(names)

# Replace any NAs in 'symbol' with the ensID 
genes_in_salmon$symbol [is.na(genes_in_salmon$symbol)] <- genes_in_salmon$ensID [is.na(genes_in_salmon$symbol)]