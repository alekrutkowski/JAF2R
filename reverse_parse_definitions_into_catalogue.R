library(magrittr)

`inside<-` <- function(.list,  indicator_named, value) {
  .list[[indicator_named]] <-
    calculate(indicator_named, value)
  .list
}
specification <- list
with_filters <- list
variables <- list
calculate <- list
fromFormula <- function(formula., where)
  list(paste(deparse(substitute(formula.)),collapse=""), where=where)
fromEurostatDataset <- list
fromOECDdataset <- list
fromLFSspecialFile <- list
fromLMPdataset <- list
fromBenefitsAndWages <- list
fromSpecialCalculation <- list
fromDESI <- list
JAF_INDICATORS <- list()

message("\nPaste the full file path to the JAF2R definitions script to be reverse-parsed:")
filepath <- readline(">>>")
eval(bquote(stopifnot(file.exists(.(filepath)))))
source(filepath)

JAF_catalogue <-
  JAF_INDICATORS %>%
  names() %>%
  lapply(
    function(JAF_KEY) {
      l <- JAF_INDICATORS[[JAF_KEY]][[2]]
      dt <- data.table(JAF_KEY = JAF_KEY,
                       INDICATOR_FULL = l$name,
                       UNITLONG = l$unit,
                       SOURCE = l$source,
                       GENSENSE = ifelse(l$high_is_good,'+','-') %>% ifelse(is.na(.),"",.))
      has_formula <- 'where' %in% (names(l$value))
      if (has_formula) {
        dt[, formula := l$value[[1]]]
        Reduce(init=dt,
               x=seq_along(l$value[[2]]),
               f=function(dt,x) {
                 factor_name <- 
                   paste0('factor',x)
                 factor_contents <- 
                   paste0("['",l$value[[2]][[x]][[1]],"',[",
                          l$value[[2]][[x]][[2]] %>% {paste0("'",names(.),'=',unlist(.),"'",collapse=",")},
                          "]]")
                 
                 dt[, (factor_name) := factor_contents]
               }
        )
      } else {
        dt[, table := l$value[[1]]]
        conds_names <- paste0('cond',seq_along(l$value[[2]]))
        conds_contents <- l$value[[2]] %>% {paste0(names(.),'=',unlist(.))}
        dt[, (conds_names) := as.list(conds_contents)]
      }
    }
  ) %>% 
  rbindlist(fill=TRUE) %T>% 
  fwrite(paste0('JAF_mini_catalogue_',
                Sys.time() %>% gsub(':',".",.,fixed=TRUE),'.csv') %T>%
           message('Saving ',.))
