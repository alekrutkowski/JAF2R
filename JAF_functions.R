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
# library(retry)

delimiter <-
  rep.int('-',80) %>% paste(collapse="") %>% paste0('\n',.,'\n')

`inside<-` <- function(.list,  indicator_named, value) {
  .list[[indicator_named]] <-
    calculate(indicator_named, value)
  .list
}


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
    merge(dt, dt2,
          by = 
            intersect(colnames(dt),
                      colnames(dt2)) %>%
            setdiff(c(letter1,letter2) %>% c(paste0('flags_',.))))
  }
  merged_data_tables <-
    Reduce(mergeRenamed,
           x = 
             2:length(list_of_data_tables),
           init =
             list_of_data_tables[[1]] %>% 
             renameCols(letters.[1]))
  eval(bquote(
    merged_data_tables[, value_ :=
                         .(substitute(formula_expression))]
  ))
}


variables <- list

`%not in%` <- Negate(`%in%`)

memoised_importData <-
  memoise::memoise(eurodata::importData)

memoised_importDataList <-
  memoise::memoise(eurodata::importDataList)

specification <- function(...)
  substitute(list(...))

isError <- function(x)
  inherits(x,'simpleError')

# For very temporary network problems
retry <- function(expr, timeout=5, interval=1) {
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
  if (!isError(result)) result else
    stop(sub('Error in doTryCatch(return(expr), name, parentenv, handler): ',
             "",result,fixed=TRUE), call.=FALSE)
}

calculate <- memoise::memoise(
  function(indicator_named, unevaluated_specification_list) {
    message('\nCalculating ',indicator_named)
    retry(do.call(function(name,
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
           value=value,
           problems=anyProblems(value))
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
  }
  filters
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
       `No EU aggregate` = 'EU27_2020' %not in% unique(dt_nonmiss$geo),
       `No EU aggregate for the last time point` = 'EU27_2020' %not in% unique(dt_nonmiss_last_t$geo)
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
  memoised_importData(EurostatDatasetCode, with_filters) %>% 
    `if`(nrow(.)==0,
         stop(cmd_line,
              "returned empty data.frame!\n",call.=FALSE),
         .) %>%
    as.data.table() %>% 
    .[, sapply(colnames(.),
               \(colname) colname %in% c('geo','TIME_PERIOD') ||
                 length(unique(.[[colname]]))!=1),
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
           "earn_nt_lowwtrp" = 'TR/',
           "tax_ben_traps" = 'TR/',
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
    'BE,BG,CZ,DK,DE,EE,IE,GR,ES,FR,HR,IT,CY,LV,LT,LU,HU,MT,NL,AT,PL,PT,RO,SI,SK,FI,SE'
  url_years <-
    2000:as.integer(format(Sys.Date(),"%Y")) %>% 
    paste(collapse=',')
  url <-
    paste0(url_pfix,url_dataset,'/',url_filters,'/filter/',url_geos,'/',url_years)
  url %T>% message('Opening:\n',.) %>%
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
  as.data.table()%>% ### TODO debug
  setnames(seq_along(.),
           as.character(.[1])) %>% 
  .[-c(1,nrow(.))]  %T>% str # last row includes date e.g. "Last update :	20-03-2023"


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
  tmpfile <- tempfile()
  download.file("https://digital-agenda-data.eu/download/DESI.csv.zip",
                tmpfile)
  unzip(tmpfile) %>% 
    fread() %>% 
    Reduce(\(dt,x) dt[dt[[x]] %in% with_filters[[x]]],
           x=names(with_filters),
           init=.) %>% 
    `if`(desi_indic=='DESI_Connectivity',
         .[indicator=="desi" & breakdown=="desi_conn" & unit_measure=="pc_desi"],
         .) %>% 
    .[,.(time_period,ref_area,value,flag)] %>% 
    setnames(c('time_period','ref_area','value','flag'),
             c('time','geo','value_','flags_'))
}

fromSpecialCalculation <- function(indicator, with_filters=NULL)
  get(indicator)(with_filters)

EU_Members_geo_codes <-
  c("BE","BG","CZ","DK","DE","EE","IE","EL","ES","FR",
    "HR","IT","CY","LV","LT","LU","HU","MT","NL","AT",
    "PL","PT","RO","SI","SK","FI","SE")

large_EU_Members_geo_codes <-
  c('DE','FR','IT','ES','PL','RO','NL')

`%without%` <- setdiff

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