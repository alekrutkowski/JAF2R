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


# Constants and aliases ---------------------------------------------------

EU_Members_geo_codes <-
  c("BE","BG","CZ","DK","DE","EE","IE","EL","ES","FR",
    "HR","IT","CY","LV","LT","LU","HU","MT","NL","AT",
    "PL","PT","RO","SI","SK","FI","SE") %T>% 
  {stopifnot(length(.)==27, all(nchar(.)==2),
             all(. %in% eurodata::importLabels('geo')$geo))}

large_EU_Members_geo_codes <-
  c('DE','FR','IT','ES','PL','RO','NL') %T>% 
  {stopifnot(all(. %in% EU_Members_geo_codes))}

EU_geo_code <-
  'EU27_2020'

EA_geo_code <-
  'EA20'

`%without%` <- setdiff

delimiter <-
  rep.int('-',80) %>% paste(collapse="") %>% paste0('\n',.,'\n')

`inside<-` <- function(.list,  indicator_named, value) {
  .list[[indicator_named]] <-
    calculate(indicator_named, value)
  .list
}

variables <- list

`%not in%` <- Negate(`%in%`)

memoised_importData <-
  memoise::memoise(eurodata::importData)

memoised_importDataList <-
  memoise::memoise(eurodata::importDataList)


# Functions ---------------------------------------------------------------

fromFormula <- function(formula_expression, where) {
  list_of_data_tables <- 
    where
  letters. <- 
    names(list_of_data_tables)
  if (length(all.vars(substitute(formula_expression)) %without% letters.)!=0)
    stop('Some of the variables used in the formula are not defined in the `where` clause!')
  renameCols <- function(dt, letter..)
    dt %>% 
    copy() %>% 
    setnames(c('value_','flags_'),
             c(letter..,paste0('flags_',letter..)),
             skip_absent=TRUE)
  mergeRenamed <- function(dt, num) {
    letter1 <- 
      letters.[num - 1]
    letter2 <- 
      letters.[num]
    dt2 <-
      list_of_data_tables[[letter2]] %>% 
      renameCols(letter2)
    merge(dt, dt2, by=c('geo','time'))
  }
  merged_data_tables <-
    list_of_data_tables[[1]] %>% 
    renameCols(letters.[1]) %>% 
    `if`(length(list_of_data_tables)>1,
         Reduce(mergeRenamed,
                x = 2:length(list_of_data_tables),
                init = .),
         .)
  eval(bquote(
    merged_data_tables[, value_ :=
                         .(substitute(formula_expression))]
  )) %>% 
    .[, c(letters.,grep('geo|time|value_|flags_',colnames(.),value=TRUE)),
      with=FALSE]
}


specification <- function(...)
  substitute(list(...))

isError <- function(x)
  inherits(x,'simpleError')

# For short-lived network problems
retry <- function(expr, timeout=6, interval=2) {
  t0 <- Sys.time()
  repeat {
    result <-
      withCallingHandlers(
        tryCatch(expr,
                 error = function(e) e),
        warning=function(w)
          if (grepl("restarting interrupted promise evaluation", w$message))
            invokeRestart("muffleWarning")
      )
    if (!isError(result) || Sys.time()-t0 > timeout) break
    Sys.sleep(interval)
    message('Re-trying...')
  }
  result
  if (!isError(result)) result else {
    if (grepl('HTTP error 400',result))
      message('\nCheck if `with_filters()` contains the correct filters!')
    stop(sub('Error in doTryCatch(return(expr), name, parentenv, handler): ',
             "",result,fixed=TRUE), call.=FALSE)
  }
  
}

is.string.scalar <- function(x)
  is.character(x) && length(x)==1

is.logical.scalar <- function(x)
  is.logical(x) && length(x)==1

calculate <- memoise::memoise(
  function(indicator_named, unevaluated_specification_list) {
    if (!is.null(JAF_INDICATORS[[indicator_named]]))
      stop('\nIndicator `',indicator_named,'` is already defined!')
    message(delimiter,'Calculating ',indicator_named)
    retry(do.call(function(name,
                           indicator_group,
                           unit_of_level,
                           unit_of_change="",
                           source,
                           high_is_good,
                           calculate_score_change=TRUE,
                           reference_in_scores=EU_geo_code,
                           value) {
      stopifnot(
        is.string.scalar(name),
        is.string.scalar(indicator_group),
        'Marked as COMPENDIUM and compendium number provided in `indicator_group`'=
          indicator_group %>% {grepl("COMPENDIUM",.,ignore.case=TRUE) &
              grepl("COMPENDIUM\\s+\\d+",.,ignore.case=TRUE)}
        is.string.scalar(unit_of_level),
        is.string.scalar(unit_of_change),
        is.string.scalar(source),
        is.logical.scalar(high_is_good),
        is.logical.scalar(calculate_score_change),
        is.string.scalar(reference_in_scores),
        toupper(reference_in_scores) %in% c('SIMPLE AVERAGE',toupper(EU_geo_code)),
        is.data.frame(value),
        nrow(value)>0,
        'The data.table has all the identifier columns (`geo`, `time`) and the `value_`' =
          c('geo','time','value_') %in% colnames(value),
        'Columns `geo` and `time` uniquely identify the rows in the data.table (there are no duplicates)' =
          nrow(value[,.(geo,time)] %>% .[duplicated(.)])==0,
        'The column `value_` is numeric' =
          is.numeric(value$value_)
      )
      list(name=name,
           indicator_group=toupper(indicator_group),
           unit_of_level=unit_of_level,
           unit_of_change=unit_of_change,
           source=source,
           high_is_good=high_is_good,
           calculate_score_change=calculate_score_change,
           reference_in_scores=reference_in_scores,
           value = value %>% 
             .[, grep('^(geo|time|value_|flags_.*|.)$',
                      colnames(value),value=TRUE),
               with=FALSE] %>% 
             setorder(geo, time))
    }, eval(unevaluated_specification_list)))
  }
)

with_filters <- function(...) {
  filters <-
    list(...)
  if (!identical(filters,list(NA))) {
    if (any(names(filters)==""))
      stop('There is an unnamed element inside with_filters()!')
    if (length(names(filters))!=length(unique(names(filters))))
      stop('There are repeated names of elements inside with_filters()!')
    filters
  }
}

anyProblems <- function(dt) {
  current_year <-
    Sys.Date() %>% 
    substr(1,4) %>% 
    as.integer()
  dt_nonmiss <-
    dt[!is.na(value_)]
  max_time <-
    max(dt_nonmiss$time)
  not_available_geos <-
    dt_nonmiss %>% 
    .$geo %>% 
    unique() %>% 
    setdiff(EU_Members_geo_codes,.)
  dt_nonmiss_last_t <-
    dt_nonmiss[time==max_time]
  not_available_geos_last_time_point <-
    dt_nonmiss_last_t %>% 
    .$geo %>% 
    unique() %>% 
    setdiff(EU_Members_geo_codes,.)
  if_add <- function(list, cond, entry)
    if (cond) c(list, entry) else list
  no_problems <- function(list.)
    (list. %>%
       sapply(is.logical) %>% 
       all()) &&
    (list. %>% 
       unlist() %>% 
       {!.} %>% 
       all())
  to_report <- function(list.)
    list. %>% 
    Filter(\(x) is.logical(x) && x || !is.logical(x),.)
  list(`Old data` = max_time < (current_year - 3),
       `Very old data` = max_time < (current_year - 5),
       `One time point only` = length(unique(dt_nonmiss$time))==1,
       `Many countries missing` = length(not_available_geos)>=10,
       `All large countries missing` = all(large_EU_Members_geo_codes %in% not_available_geos),
       `One or more large countries missing` = any(large_EU_Members_geo_codes %in% not_available_geos),
       `All large countries missing at the last time point` = all(large_EU_Members_geo_codes %in% not_available_geos_last_time_point),
       `One or more large countries missing at the last time point` = any(large_EU_Members_geo_codes %in% not_available_geos_last_time_point),
       `No EU aggregate` = EU_geo_code %not in% unique(dt_nonmiss$geo),
       `No EU aggregate for the last time point` = EU_geo_code %not in% unique(dt_nonmiss_last_t$geo)
       # More checks to be added e.g. if high jumps in values or variance
  ) %>%
    if_add(.$`Old data`,
           list(`Latest time point` = max_time)) %>% 
    if_add(.$`Many countries missing`,
           list(`Not available countries` = not_available_geos)) %>% 
    if_add(.$`One or more large countries missing`,
           list(`Large countries missing` = intersect(large_EU_Members_geo_codes, not_available_geos))) %>% 
    if_add(.$`One or more large countries missing at the last time point`,
           list(`Large countries missing at the last time point` = intersect(large_EU_Members_geo_codes, not_available_geos_last_time_point))) %>% 
    `if`(no_problems(.),.,
         {message('Some problems detected:'); str(to_report(.)); .})
}


fromEurostatDataset <- function(EurostatDatasetCode, with_filters, time_period=0L) {
  cmd_line <-
    paste0('\nfromEurostatDataset("',EurostatDatasetCode,'", ',
           deparse(with_filters),
           ifelse(time_period!=0L,
                  paste0(', time_period = ',time_period,')\n'),
                  ")\n"))
  `if`(EurostatDatasetCode %not in% c(memoised_importDataList()$Code,
                                      # The datasets below are for some reason absent in
                                      # https://ec.europa.eu/eurostat/api/dissemination/catalogue/toc/txt?lang=EN
                                      'lfsa_ergaed','lfsa_ergan','lfsa_urgaed',
                                      'lfsa_argaed','edat_lfse_20'), 
       stop(cmd_line,
            '"',EurostatDatasetCode,
            '" not found in the list of Eurostat datasets or tables!\n',
            'check https://ec.europa.eu/eurostat/api/dissemination/catalogue/toc/txt?lang=EN'))
  memoised_importData(EurostatDatasetCode,
                      c(with_filters,
                        list(geo=c(EU_Members_geo_codes,EU_geo_code,EA_geo_code)))) %>% 
    `if`(nrow(.)==0,
         stop(cmd_line,
              "returned empty data.frame!\n",call.=FALSE),
         .) %>%
    as.data.table() %>% 
    # .[geo %in% c(EU_Members_geo_codes,EU_geo_code,EA_geo_code)] %>% moved to imortData
    .[, sapply(colnames(.), # 
               \(colname) colname %in% c('geo','TIME_PERIOD','value_','flags_') ||
                 length(unique(.[[colname]]))!=1), # drop columns with identifiers = single category
      with=FALSE] %>%
    setnames('TIME_PERIOD','time') %>% 
    .[, time := sub('-',"",time,fixed=TRUE)] %>% 
    .[, lapply(., \(col) `if`(is.factor(col),as.character(col),col))] %>% 
    `if`(time_period!=0L,
         .[, value_ := collapse::L(value_, n=-time_period, t=time),
           by = eval(setdiff(colnames(.),
                             c('time','value_','flags_')))],
         .)
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
    .[old_table==OECDdatasetCode] %>% 
    `if`(nrow(.)!=1,
         .[old_filter_name==names(with_filters) & old_filter_value==with_filters[[1]]],
         .)
  `if`(nrow(JAF_old_to_new_OECD_map)!=1,
       stop('\nMultiple or no match in `tribble` for\n',
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
  .[,sapply(.,\(col) length(unique(col))!=1), with=FALSE] %>% 
  setnames(c('Time','ObsValue','COU','COUNTRY','LOCATION','OBS_STATUS'),
           c('time','value_','country','country','country','flags_'),
           skip_absent=TRUE) %>% 
  .[, geo := countrycode(country,
                         origin='iso3c',
                         destination='eurostat')] %>% 
  .[, value_ := as.numeric(value_)] %>% 
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
    setnames('TIME_PERIOD','time') %>% 
    .[, time := as.integer(as.character(time))] %>% # converting from factor
    setnames(colnames(.),tolower(colnames(.)))
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
           "earn_nt_lowwtrp" = 'TR',
           "tax_ben_traps" = 'TR',
           .)
  url_filters <-
    with_filters$indicator %>% 
    gsub('.','/',.,fixed=TRUE) %>% 
    sub('^S/',"1EC/",.) %>% 
    `if`(table_code=='nrr_ub',
         sub('^(.+)/(.+)/(.+)$',"\\1/\\3/\\2",.),
         .) %>% 
    `if`(table_code %in% c('earn_nt_lowwtrp','tax_ben_traps'),
         sub('LW/(.+)/.+/(.+/.+)','LW/\\2/\\1',.) %>% 
           sub('IT/(.+)/(.+)/.+/.+','IT/\\2/\\1',.),
         .)
  url_pfix <-
    'https://europa.eu/economy_finance/db_indicators/tab/wq/details_all_webquery.php?url='
  url_geos <-
    EU_Members_geo_codes %>% 
    sub('EL','GR',.,fixed=TRUE) %>% 
    paste(collapse=',')
  url_years <-
    2000:as.integer(format(Sys.Date(),"%Y")) %>% 
    paste(collapse=',')
  url <-
    paste0(url_pfix,url_dataset,'/',url_filters,'/filter/',url_geos,'/',url_years)
  url %T>% message('Opening:\n',.) %>%
    getTaxBenTable() %>% 
    `if`(table_code=='nrr_ub',
         Filter(\(colvals) !all(colvals==""), .) %>% 
           .[, c(1,2,length(.)), with=FALSE] %>% 
           setnames(colnames(.),
                    c('Country','time','value_')),
         .) %>%
    `if`(table_code %in% c('earn_nt_lowwtrp','tax_ben_traps'),
         setnames(., seq_along(.),
                  as.character(.[1])) %>%
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
  # setnames(seq_along(.),
  #          as.character(.[1])) %>% 
  .[-c(nrow(.))] # last row includes date e.g. "Last update :	20-03-2023"


memoised_fread <- memoise(fread)


fromLFSspecialFile <- function(jaf_lfs_code, with_filters) {
  name_of_raw_file_from_estat <-
    jaf_lfs_code %>% 
    switch(.,
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
    copy() %>% 
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
  'https://digital-decade-desi.digital-strategy.ec.europa.eu/api/v1/chart-groups/desi-2022/facts/' %>% 
    fread() %>% 
    Reduce(\(dt,x) dt[dt[[x]] %in% with_filters[[x]]],
           x=names(with_filters),
           init=.) %>% 
    `if`(desi_indic=='DESI_Connectivity',
         .[indicator=="desi" & breakdown=="desi_conn" & unit=="pc_desi"],
         .) %>% 
    .[,.(period,country,value,flags)] %>% 
    setnames(c('period','country','value','flags'),
             c('time','geo','value_','flags_'))
}


fromSpecialCalculation <- function(indicator, with_filters=NULL)
  tryCatch(get(indicator),
           error = function(e) {
             stop('Function `',indicator,'` is not implemented!', call.=FALSE)
           })(with_filters)


vacancy_rate <- function(with_filters=NULL) {
  f <- eurodata::importData
  dt1 <-
    f('jvs_q_nace2',
      list(indic_em='JOBRATE', s_adj='NSA',
           nace_r2='B-S', sizeclas='TOTAL',
           geo = EU_Members_geo_codes %without% c('IT','DK','FR','MT') ))
  dt2 <-
    f('jvs_q_nace2', 
      list(indic_em='JOBRATE', s_adj='NSA',
           nace_r2='B-N', sizeclas='GE10', geo='IT'))
  dt3 <-
    f('jvs_q_nace2', 
      list(indic_em='JOBRATE', s_adj='NSA',
           nace_r2='B-N', sizeclas='TOTAL', geo='DK'))
  dt4 <-
    f('jvs_q_nace2', 
      list(indic_em='JOBRATE', s_adj='NSA',
           nace_r2='B-S', sizeclas='GE10', geo=c('FR','MT')))
  list(dt1, dt2, dt3, dt4) %>% 
    lapply(as.data.table) %>% 
    rbindlist() %>% 
    setnames('TIME_PERIOD','time') %>% 
    .[, time := as.integer(substr(time, 1, 4))] %>%  # quarters to years
    .[, .(value_ = mean(value_, na.rm=TRUE)),
      by=.(geo,time)] %>% # across quarters
    merge(data.table(time = seq.int(min(.$time, na.rm=TRUE),max(.$time, na.rm=TRUE)) ),
          by='time', all.y=TRUE) %>% # fill in potentially missing years for the correct setting of the rolling mean window
    setorder(geo,time) %>% 
    .[, value_ := frollmean(value_, 3, algo='exact'),
      by=geo] %>% 
    .[!is.na(value_)]
}