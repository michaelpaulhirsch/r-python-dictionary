as_md_table <- function(df){
    paste0('|', paste(names(df), collapse = '|'), '|\n|', 
           paste(rep(':--', length(df)), collapse = '|'), '|\n|', 
           paste(Reduce(function(x, y){paste(x, y, sep = '|')}, df), collapse = '|\n|'), '|')
}
