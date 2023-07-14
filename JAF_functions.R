library(magrittr)
library(tibble)
library(data.table)
library(memoise)
library(eurodata)
library(collapse)
library(OECD)
library(countrycode)
library(rvest)
library(kit)


`inside<-` <- function(.list,  indicator_named, value) {
  pfix <-
    ifelse(indicator_named %in% names(.list),
           'Modifying', 'Creating')
  message(pfix," JAF_INDICATORS\U2019 element `",indicator_named,"`...")
  .list[[indicator_named]] <- value
  .list
}


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

with_filters <- function(...) {
  filters <-
    list(...)
  if (!identical(filters,list(NA))) {
    if (any(names(filters)!=""))
      stop('There is an unnamed element inside with_filters()!')
    if (length(names(filters))!=length(unique(names(filters))))
      stop('There are repeated names of elements inside with_filters()!')
  }
  filters
}


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


fromBenefitsAndWages <- function(table_code, with_filters) {
  url_dataset <-
    table_code %>% 
    switch(.,
           "nrr_ub" = 'NRR/NRRUB',
           "earn_nt_lowwtrp" = 'TR/',
           "tax_ben_traps" = 'TR/',
           .)
  url_filters <-
    with_filters$indicator %>% 
    gsub('.','/',.,fixed=TRUE) %>% 
    `if`(table_code %in% c('earn_nt_lowwtrp','tax_ben_traps'),
         sub('LW/(.+)/.+/(.+/.+)','LW/\\2/\\1',.) %>% 
           sub('IT/(.+)/(.+)/.+/.+','IT/\\2/\\1',.),
         .)
  url_pfix <-
    'https://europa.eu/economy_finance/db_indicators/tab/wq/details_all_webquery.php?url='
  url_geos <-
    'BE,BG,CZ,DK,DE,EE,IE,GR,ES,FR,HR,IT,CY,LV,LT,LU,HU,MT,NL,AT,PL,PT,RO,SI,SK,FI,SE'
  url_years <-
    2000:as.integer(format(Sys.Date(),"%Y")) %>% 
    paste(collapse=',')
  url <-
    paste0(url_pfix,url_dataset,'/',url_filters,'/filter/',url_geos,'/',url_years)
  url %>% 
    getTaxBenTable() %>% 
    `if`(table_code=='nrr_ub',
         melt(., id.vars='Country',
              measure.vars = colnames(.) %>% .[!is.na(as.integer(.))],
              variable.name='time', value.name='value_'),
         .) %>% 
    `if`(table_code %in% c('earn_nt_lowwtrp','tax_ben_traps'),
         .[,.(Country,Year,METR)] %>% 
           setnames(c('Year','METR'),
                    c('time','value_')),
         .) %>% 
    .[, time := as.integer(time)] %>% 
    .[, value_ := as.numeric(value_)] %>% 
    .[!is.na(value_)] %>% 
    .[, geo := countrycode(Country,
                           origin='country.name',
                           destination='eurostat')] %>% 
    .[, Country := NULL]
}


getTaxBenTable <- function(url)
  url %>% 
  read_html() %>% 
  html_node(xpath='/html/body/table') %>% 
  html_table(convert=FALSE) %>% # wrong colnames = title "European Commission	Economic and Financial Affairs	Tax and Benefits"
  as.data.table() %>%
  setnames(seq_along(.),
           as.character(.[1])) %>% 
  .[-c(1,nrow(.))] # last row includes date e.g. "Last update :	20-03-2023"


memoised_fread <- memoise(fread)


fromLFSspecialFile <- function(jaf_lfs_code, with_filters) {
  name_of_raw_file_from_estat <-
    jaf_lfs_code %>% 
    switch(
      'lfse_jobtenure'="IESS_PA2_S5_v2_Y.csv",
      'lfse_nacegap'="IESS_17_PA7_1_C6_N1_N2_AA.csv",
      'lfse_iscogap'="IESS_16_PA7_1_C5_AA.csv",
      'lfse_erfgap2064'="IESS_15_PA7_1_C4_2064_FTE_AA.csv",
      'lfse_er_child'="IESS_11_PA7_2_S1_Y.csv",
      'lfse_inactpt_lackcare'="IESS_10_PA5_C3_mod_Y.csv",
      'lfse_overtime'="IESS_PA2_C3_AA.csv",
      .
    )
  memoised_fread(name_of_raw_file_from_estat) %>% 
    setnames(colnames(.),
             colnames(.) %>% tolower()) %>% 
    .[, c('quarter','flag','flag_break') := NULL] %>% 
    setnames(c('country','year','value'),
             c('geo','time','value_')) %>% 
    .[, time := as.integer(time)] %>% 
    .[, value_ := as.numeric(value_)] %>% 
    Reduce(\(dt,x) dt[dt[[tolower(x)]] %in% with_filters[[x]]],
           x=names(with_filters),
           init=.)
}


fromDESI <- function(desi_indic, with_filters) {
  tmpfile <- tempfile()
  download.file("https://digital-agenda-data.eu/download/DESI.csv.zip",
                tmpfile)
  unzip(tmpfile) %>% 
    fread() %>% 
    Reduce(\(dt,x) dt[dt[[x]] %in% with_filters[[x]]],
           x=names(with_filters),
           init=.) # %>% 
    # TODO:
    # setnames(c("observation","time_period","ref_area","indicator","breakdown","unit_measure","value","flag","note"))
}



