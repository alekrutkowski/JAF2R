library(magrittr)
library(data.table)
library(memoise)
library(eurodata)
library(collapse)
library(OECD)
library(countrycode)

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

`%not in%` <- Negate(`%in%`)

memoised_importData <-
  memoise::memoise(eurodata::importData)

memoised_importDataList <-
  memoise::memoise(eurodata::importDataList)

fromEurostatDataset <- function(EurostatDatasetCode, with_filters, time_period=0L) {
  cmd_line <-
    paste0('\nfromEurostatDataset("',fromEurostatDataset,'", ',
           deparse(with_filters),
           ifelse(time_period!=0L,
                  paste0(', time_period = ',time_period,')\n'),
                  ")\n"))
  `if`(EurostatDatasetCode %not in% memoised_importDataList()$Code,
       stop(cmd_line,
            '"',EurostatDatasetCode,
            '" not found in the list of Eurostat datasets or tables!\n'))
  memoised_importData(EurostatDatasetCode, with_filters) %>% 
    `if`(nrow(.)==0,
         stop(cmd_line,
              "returned empty data.frame!\n",call.=FALSE),
         .) %>%
    as.data.table() %>% 
    Filter(\(col) length(unique(col))!=1, .) %>% 
    setnames('TIME_PERIOD','time') %>% 
    .[, time := sub('-',"",time,fixed=TRUE)] %>% 
    .[, lapply(., \(col) `if`(is.factor(col),as.character(col),col))] %>% 
    .[, value_lagged := collapse::L(value_, n=-time_period, t=time),
      by = eval(setdiff(colnames(.),
                        c('time','value_','flags_')))] %>% 
    setnames('flags_',paste0('flags__',EurostatDatasetCode))
}


fromOECDdataset <- function(OECDdatasetCode, with_filters) {
  JAF_old_to_new_OECD_map <-
    fread('JAF_old_to_new_OECD_map.csv') %>% 
    .[old_table==OECDdatasetCode]
  `if`(nrow(JAF_old_to_new_OECD_map)!=1,
       stop('\nMultiple or no match in `JAF_old_to_new_OECD_map.csv` for\n',
            'fromOECDdataset("',OECDdatasetCode,'", with_filters(',
            deparse(with_filters),')'))
  OECD::get_dataset(JAF_old_to_new_OECD_map$new_table,
                    `if`(JAF_old_to_new_OECD_map$filter_url,
                         JAF_old_to_new_OECD_map$new_filter_value)) %>% 
    .[get(JAF_old_to_new_OECD_map$new_filter_name)==
        JAF_old_to_new_OECD_map$new_filter_value] %>% 
    Filter(\(col) length(unique(col))!=1, .) %>% 
    setnames(c('Time','ObsValue','COU','COUNTRY','OBS_STATUS'),
             c('time','value_','country','country','flags_'),
             skip_absent=TRUE) %>% 
    .[, geo := countrycode(country,
                           origin='iso3c',
                           destination='eurostat')] %>% 
    .[, country := NULL]
}