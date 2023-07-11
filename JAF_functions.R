library(magrittr)
library(tibble)
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

specification <- memoise::memoise(
  function(name,
           unit,
           source,
           high_is_good,
           value) {
    stopifnot(
      is.character(name),
      length(name)==1,
      is.character(source),
      length(source)==1,
      is.logical(high_is_good),
      length(high_is_good)==1,
      is.data.frame(value),
      'value_' %in% colnames(value),
      nrow(value)>0
    )
    list(name=name,
         unit=unit,
         source=source,
         value=value)
  })


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
    tibble::tribble(
      ~old_table                , ~old_filter_name, ~old_filter_value, ~new_table      , ~filter_url, ~new_filter_name, ~new_filter_value ,
      "OECD_STR_EP"             , "indicator"     , "epl_reg"        , "EPL_OV"        , FALSE      , "SERIES"        , "EPRC_V4"         ,
      "OECD_STR_EP"             , "indicator"     , "epl_temp"       , "EPL_T"         , FALSE      , "SERIES"        , "EPT_V4"          ,
      "educ_outc_pisa"          , NA              , NA               , "go to Eurostat", NA         , NA              , NA                ,
      "consultations_per_capita", "indicator"     , "CONSCOVI"       , "HEALTH_PROC"   , TRUE       , "VAR"           , "CONSCOVI"        ) %>% 
    as.data.table() %>% 
    .[old_table==OECDdatasetCode]
  `if`(nrow(JAF_old_to_new_OECD_map)!=1,
       stop('\nMultiple or no match in `JAF_old_to_new_OECD_map.csv` for\n',
            'fromOECDdataset("',OECDdatasetCode,'", with_filters(',
            deparse(with_filters),'))'))
  `if`(JAF_old_to_new_OECD_map$new_table=='go to Eurostat',
       fromEurostatDataset(OECDdatasetCode,with_filters),
       OECD::get_dataset(JAF_old_to_new_OECD_map$new_table,
                         `if`(JAF_old_to_new_OECD_map$filter_url,
                              JAF_old_to_new_OECD_map$new_filter_value)) %>% 
         as.data.table() %>% 
         `if`(!is.na(JAF_old_to_new_OECD_map$new_filter_name),
              .[get(JAF_old_to_new_OECD_map$new_filter_name)==
                  JAF_old_to_new_OECD_map$new_filter_value],
              .) %>% 
         finaliseOECDdataset()
       )
}


finaliseOECDdataset <- function(dt)
  dt %>% 
  Filter(\(col) length(unique(col))!=1, .) %>% 
  setnames(c('Time','ObsValue','COU','COUNTRY','LOCATION','OBS_STATUS'),
           c('time','value_','country','country','country','flags_'),
           skip_absent=TRUE) %>% 
  .[, geo := countrycode(country,
                         origin='iso3c',
                         destination='eurostat')] %>% 
  .[, country := NULL]


fromLMPdataset <- function(LMPdatasetCode, with_filters) {
  stopifnot(is.character(LMPdatasetCode),
            length(LMPdatasetCode)==1,
            is.list(with_filters),
            length(with_filters)>0)
  if (any(names(with_filters)=="")) 
    stop("All elements of `filters` must be named.")
  web_dataset_code <-
    LMPdatasetCode %>% 
    ifelse(.=='lmp_expenditure','LMP_IND_EXP',.) %>% 
    toupper()
  url <-
    paste0('https://webgate.ec.europa.eu/empl/redisstat/api/dissemination/sdmx/2.1/data/',
           web_dataset_code,'/',
           LMPurlFilters(web_dataset_code, with_filters),
           '/?format=TSV&i')
  RawData <-
    url %>% 
    data.table::fread(sep="\t", colClasses="character", 
                      header=TRUE)
  FirstColName <-
    colnames(RawData)[1]
  IdNames <-
    FirstColName %>% 
    strsplit(",|\\\\") %>% 
    .[[1]]
  ColIdName <-
    IdNames %>%
    tail(1)
  RowIdNames <-
    IdNames %>%
    head(-1)
  RawData %>% 
    as.data.table() %>% 
    .[, (RowIdNames) := tstrsplit(get(FirstColName), split=",")] %>% 
    .[, (FirstColName) := NULL] %>% 
    melt(id.vars=RowIdNames, 
         variable.name=ColIdName, value.name="value_") %>% 
    .[, flags_ := gsub("[0-9\\.-]", "", value_)] %>% 
    .[, value_ := gsub("[^0-9\\.-]", "", value_) %>% as.numeric()] %>% 
    Filter(\(col) length(unique(col))!=1, .) %>% 
    setnames('TIME_PERIOD','time') 
}


LMPurlStructure <- function(ds_code) 
  ds_code %>%
  toupper() %>%
  paste0("https://webgate.ec.europa.eu/empl/redisstat/api/dissemination/sdmx/2.1/dataflow/EMPL/",
         .,
         "/1.0?references=descendants&detail=referencepartial&format=sdmx_2.1_generic&compressed=false") %>%
  xml2::read_xml() %>%
  xml2::as_list() %>% {
    .$Structure$Structures$DataStructures$DataStructure$
      DataStructureComponents$DimensionList
  } %>% sapply(\(x) attr(x$ConceptIdentity$Ref, "id"))


LMPurlFilters <- function(ds_code, filters_list) {
  filters <-
    filters_list %>% 
    `names<-`(toupper(names(.)))
  ds_code %>% 
    LMPurlStructure() %>% 
    toupper() %>% 
    .[.!='TIME_PERIOD'] %T>% {
      not_present_dims <- setdiff(names(filters),.)
      `if`(length(not_present_dims) > 0,
           warning("`filters` contains dimension(s) not present in the dataset, ignored:\n", 
                   paste(not_present_dims, collapse=", "), 
                   call.=FALSE, immediate.=TRUE))
    } %>% filters[.] %>% lapply(paste, collapse = "+") %>% 
    {do.call(paste, c(., sep="."))}
}


fromBenefitsAndWages <- function(OECDdatasetCode, with_filters) {
  dataset_code <-
    OECDdatasetCode %>% 
    switch(.,
      "nrr_ub" = 'NRR',
      .)
  filters <-
    with_filters$indicator %>% 
    sub('E','EARNER',.,fixed=TRUE) %>% 
    sub('S','SINGLE',.,fixed=TRUE) %>% 
    sub('.67','.67AW',.,fixed=TRUE)
  OECD::get_dataset(dataset_code,
                    paste0('.', # all countries
                           filters,
                           '.0.0') # Not "Include social assistance benefits" and Not "Include housing benefits"
  ) %>% 
    as.data.table() %>% 
    finaliseOECDdataset()
}










