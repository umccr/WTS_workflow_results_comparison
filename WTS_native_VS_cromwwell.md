---
title: "bcbio Native versus Cromwell results comparison"
author: "Sehrish Kanwal"
date: "Thu 2019-May-23"
output:
  html_document: 
    keep_md: true
params:
  run_1: '/Users/kanwals/Documents/UMCCR/data/WTS_comparison/CCR180072_VPT_WH16/bcbio_native/run_1'
  run_2: '/Users/kanwals/Documents/UMCCR/data/WTS_comparison/CCR180072_VPT_WH16/bcbio_native/run_2'
---



## Required packages.


```r
library(tidyr)
library(dplyr)
library(kableExtra)
```

## Define functions.


```r
lf <- function(...) {
  data.frame(fname = list.files(...)) %>% 
    knitr::kable(row.names = TRUE)
}
```


## Read input. The script expects two input directories, each containing 'final' results as produced by bcbio. The results in these two input directories will be compared.


```r
run_1 <-file.path(params$run_1)
#list files in the first run directory
lf(run_1)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> fname </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> CCR180072_VPT_WH16-flat.tsv </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> CCR180072_VPT_WH16-ready.counts </td>
  </tr>
</tbody>
</table>

```r

run_2 <- file.path(params$run_2)
#list files in the second run directory
lf(run_2)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> fname </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> CCR180072_VPT_WH16-flat.tsv </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> CCR180072_VPT_WH16-ready.counts </td>
  </tr>
</tbody>
</table>

## Start with the simple line count in the files i.e. the number of entries in the output from both runs is same.


```r
#dealing with the count files first
counts_file_name <- dir(c(run_1, run_2), pattern = ".counts")
counts_file_name[1] <-  paste(run_1, counts_file_name[1], sep = "/")
counts_file_name[2] <-  paste(run_2, counts_file_name[2], sep = "/")


target_file <- data.frame(matrix(ncol = length(counts_file_name), nrow = 0))

for (i in 1:length(counts_file_name)) {
  file <- read.table(counts_file_name[i], sep="\t", as.is=TRUE, header=FALSE)
  target_file <- rbind(target_file, data.frame(counts_file_name[i], nrow(file)))
}
colnames(target_file) <- c("file", "lines_count")
```









