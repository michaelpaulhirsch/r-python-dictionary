library(data.table)

dict_table.md_pth <- "dict_table.md"
rawdata_pth <- "raw_dict.csv"

x <- fread(dict_table.md_pth, sep = "|", header = T)
empty_cols <- names(Filter(function(x) all(is.na(x)), x) ) 
x[, (empty_cols) := NULL]

is_seperator_row <- x[ , apply(.SD, 1, function(x) all(grepl(":-",x)))]
x <- x[ !is_seperator_row ]

fwrite(x, rawdata_pth)

