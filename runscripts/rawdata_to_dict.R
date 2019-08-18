library(data.table)
source("R/convert_to_md.R")
rawdata_pth <- "raw_dict.csv"
dict_table.md_pth <- "dict_table.md"
output_cols <- c("Rbase", "Rdata.table", "tidyverse", "python")

x <- fread(rawdata_pth)

collapse_cols <- function(x,
                          cols,
                          new_col){
    y[, (new_col) := apply(.SD, 1, function(x){
        comb <- paste0(paste0(cols, "::", x, collapse = "() or "),"()")
        comb <- gsub(paste0(paste0(cols,"::\\(\\)( or )?"), collapse = "|"), "", comb)
        comb <- gsub(" or $","",comb)
        
        if(grepl("\\?",comb)) comb <- gsub("base::\\?","?", comb)
        
        comb
    }), .SDcols = cols]
    y[]
}

x <- collapse_cols(x, 
                   cols = c("dplyr","stringr","reshape2","lubridate","tidyr","readr"),
                   new_col = "tidyverse")

x <- collapse_cols(x,
                   cols = c("base","methods","stats"),
                   new_col = "Rbase")

x <- collapse_cols(x,
                   cols = c("data.table"),
                   new_col = "Rdata.table")

out <- x[, mget(output_cols)]
if(any(rowSums(out == "") == ncol(out))) stop("Functions have been lost or dropped!")

out <- as_md_table(out)
writeLines(out, dict_table.md_pth)
