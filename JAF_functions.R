fromFormula <- function(formula_expression, where) {
  list_of_data_tables <- 
    where
  letters. <- 
    names(list_of_data_tables)
  mergeRenamed <- function(dt, num) {
    letter1 <- 
      letters.[num - 1]
    letter2 <- 
      letters.[num]
    dt2 <- 
      copy(list_of_data_tables[[letter2]])
    setnames(dt2,
             'values_',letter2)
    merge(dt, dt2,
          by = 
            intersect(colnames(dt),
                      colnames(dt2)) %>%
            setdiff(c(letter1,letter2)))
  }
  merged_data_tables <-
    Reduce(mergeRenamed,
           x = 
             2:length(list_of_data_tables),
           init =
             list_of_data_tables[[1]] %>% 
             copy() %>% 
             setnames('values_',letters.[1]))
  eval(bquote(
    merged_data_tables[, values_ :=
                         .(substitute(formula_expression))]
  ))
}

variables <- list