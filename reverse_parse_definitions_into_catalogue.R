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
                   paste0("['",
                          l$value[[2]][[x]][[1]],"',[",
                          l$value[[2]][[x]][[2]] %>% {paste0("'",names(.),'=',unlist(.),"'",collapse=",")},
                          if (length(l$value[[2]][[x]])==3) paste0(',',l$value[[2]][[x]][[3]]) else "",
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


###############################################################################################
# A bigger version specified by Lorise for consulting F1 & D1 before indicator changes --------
SelectedColumns <-
  c("POLICY_CODE","OS_CODE","INPUTOUTPUT",
    # "POLICY","SUBPOLICY",
    "JAF_KEY",
    "IFMAIN","NBMAIN","IFCOUNTRY","NBCOUNTRY","IFCOMPEDIUM","NBCOMPEDIUM","COMPENDIUMID",
    "INDICATOR_EXPLANATION","REFYEAR","REFERNECPOINT","UNITCHANGE",
    "CHANGE_CALCUL","FOOTNOTE_MAIN","IFPOPWEIGHT","SILC_INCOME","DECIMALX")
source_of_definitions <-
  c('Indicators Table - JAF 2017 FINAL SPRING 2023.xlsx',
    'catalogue - jaf_h_2021 FINAL SPRING 2023.csv')
prepareColumns <- function(dt)
  dt[, SelectedColumns, with=FALSE] %>% 
  # .[, c('new POLICY_CODE','new POLICY','new SUBPOLICY') := .("","","")] %>% 
  merge(copy(JAF_catalogue) %>% 
          .[, Catalogue :=
              ifelse(grepl('_health$',JAF_KEY),'JAF Health','General JAF')] %>% 
          .[, JAF_KEY :=
              sub('_health$',"",JAF_KEY)]
          ,by='JAF_KEY')
Form_For_F1_D1 <-
  openxlsx2::read_xlsx(source_of_definitions[1],
                       sheet='IndicatorsTable') %>% 
  as.data.table() %>%  
  rbind(
    fread(file=source_of_definitions[2],
          encoding='UTF-8') %>% 
      as.data.table() %>% 
      .[, JAF_KEY := paste0(JAF_KEY,'_health')],
    fill=TRUE
  ) %>% 
  prepareColumns() %>% 
  setcolorder(c('JAF_KEY','Catalogue' # ,
                # 'POLICY_CODE','POLICY','SUBPOLICY',
                # 'new POLICY_CODE','new POLICY','new SUBPOLICY'
                )) %>% 
  cbind(data.table(instructions=""),.) %>% 
  list('To be DELETED or MODIFIED'=.,
       'To be ADDED'=.) %T>% 
  openxlsx2::write_xlsx(paste0('Form for JAF indicator modifications ',
                               Sys.Date(),'.xlsx'),
                        na.strings="")
