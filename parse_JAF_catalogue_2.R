library(openxlsx2)
library(magrittr)
library(data.table)
library(kit)


# Constants ---------------------------------------------------------------

table_names_without_cond_or_factor <-
  c('DESI_Connectivity',
    'earn_nt_unemtrp',
    'vacancy_rate',
    'earn_nt_taxwedge',
    'tepsr_lm210') %>% 
  paste(collapse="|")

Number_of_redefined_indics_in_Codelines <- 4 # PA6a.S5.; PA4.2.S2.; PA9.1.S5.; PA9.2.S4.
Number_of_defined_indics_message <- ""
Number_of_undefined_indics_message <- ""
Undefined_indics <- character(0)


# Functions ---------------------------------------------------------------

`%+%` <- function(x,y) paste0(x,y)

parseFactor <- function(factor_string, comment)
  factor_string %>% 
  sub('[','fromEurostatDataset( ',.,fixed=TRUE) %>% 
  sub('[',paste0('\n',comment,'with_filters('),.,fixed=TRUE) %>% 
  gsub(']',')',.,fixed=TRUE) %>% 
  gsub("'\\s*([^,]*)\\s*=\\s*([^,]*)\\s*'",
       ' \\1="\\2"',.) %>% 
  gsub("^(.*),(-?\\d+)\\)\\s*$",'\\1, time_period=\\2)',.)

parseCond <- function(cond_string)
  cond_string %>% 
  gsub("\\s*(.*)\\s*=\\s*(.*)\\s*",
       '\\1="\\2"',.)

numToLetter <- function(int)
  letters[int]

quoteAndEscapeQuotes <- function(str)
  gsub('"','\\"',str,fixed=TRUE) %>% 
  paste0('"',.,'"')

GENSENSE_to_Bool <- function(str)
  str=="+" # str may be: "+" or "-" or NA 

processCatalog <- function(catalog_dt, comment="")
  catalog_dt %>% 
  .[, c(id_cols,NumberedCatalogColumnNames), with=FALSE] %>%  
  {`if`(comment=="",
        .[!is.na(table) & (!is.na(cond1) | !is.na(formula)) | grepl(table_names_without_cond_or_factor,table)] %T>% 
          {message(Number_of_defined_indics_message <<- paste(nrow(.)+Number_of_redefined_indics_in_Codelines,'defined indicators.'))},
        .[!(!is.na(table) & (!is.na(cond1) | !is.na(formula)) | grepl(table_names_without_cond_or_factor,table))] %T>% 
          {message(Number_of_undefined_indics_message <<- paste(nrow(.)-Number_of_redefined_indics_in_Codelines,'mis-defined indicators.'))
            Undefined_indics <<- unique(.$JAF_KEY)})} %>% 
  melt(measure.vars=NumberedCatalogColumnNames,
       variable.name="factor_or_cond",
       value.name="definitions",
       variable.factor=FALSE,
       na.rm=FALSE) %>%     
  `if`(comment=="",
       .[!is.na(definitions) | grepl(table_names_without_cond_or_factor,table)] %>% 
         .[grepl(table_names_without_cond_or_factor,table) & factor_or_cond=='cond1' | !grepl(table_names_without_cond_or_factor,table)],
       .) %>% 
  `if`(comment!="",
       .[!is.na(definitions) | factor_or_cond=='cond1'],
       .) %>% 
  .[, sep :=
      factor_or_cond %>% 
      sub("(\\D+)(\\d{1}$)", "\\10\\2", .) %>% # add leading zeros e.g. factor5 => factor05 for correct sort/max
      {ifelse(.==max(.),"",
              ifelse(grepl('cond',.),
                     ", ",",\n"))},
    by=id_cols] %>% 
  .[, definitions :=
      ifelse(grepl('cond',factor_or_cond),
             definitions %>% 
               parseCond(),
             factor_or_cond %>% 
               sub("^factor([0-9]+)$","\\1",.) %>% 
               as.integer() %>% 
               numToLetter() %>% 
               paste(comment,.,'=',
                     parseFactor(definitions, comment)))] %>% 
  .[, definitions := paste0(definitions,sep)]  %>%     
  .[, .(definitions =
          definitions %>% 
          paste(collapse="")),
    by=id_cols] %>% 
  .[, func :=
      SOURCE %>% 
      {kit::nif(grepl('lfse_',table), 'fromLFSspecialFile',
                grepl('DESI_Connectivity',table),'fromDESI',
                (grepl("^Eurostat,",.) & table!='vacancy_rate') |
                  .=='DG CONNECT' |
                  table %in% c('earn_nt_unemtrp','earn_nt_taxwedge'), 'fromEurostatDataset',
                grepl("^OECD, Pisa",.), 'fromEurostatDataset',
                grepl("^OECD,",.), 'fromOECDdataset',
                grepl("Labour Market Policy",.), 'fromLMPdataset',
                grepl("Benefits and wages",.), 'fromBenefitsAndWages',
                ### TODO - fromLFSfile ???
                default='fromSpecialCalculation')}] %>% 
  .[, definitions :=
      ifelse(!is.na(formula),
             paste0('fromFormula( ',formula,
                    ',\nwhere = variables(\n',
                    definitions,
                    '\n))'),
             paste0(func,'(',
                    '"',table,'"',
                    ',\n',
                    comment,' with_filters(',
                    definitions,
                    '))'))] %>%
  .[, definitions :=
      paste0('\n',
             comment,'inside(JAF_INDICATORS, indicator_named = "',JAF_KEY,'") = \n',
             comment,'specification(\n',
             comment,'name = ',quoteAndEscapeQuotes(INDICATOR_FULL),',\n',
             comment,'unit = ',quoteAndEscapeQuotes(UNITLONG),',\n',
             comment,'source = ',quoteAndEscapeQuotes(SOURCE),',\n',
             comment,'high_is_good = ',GENSENSE_to_Bool(GENSENSE),',\n',
             comment,'value = ',definitions,'\n',
             comment,')')] %>%  # ,
  # ifelse(row_num!=max(row_num),',\n',""))] %>% 
  .[order(row_num)] 

# Actions -----------------------------------------------------------------

Catalog <-
  openxlsx2::read_xlsx('//NET1.cec.eu.int/offline/03/rutkoal/Desktop/Indicators Table - JAF 2017 29062023.xlsx',
                       sheet='IndicatorsTable') %>% 
  as.data.table %>%  
  .[, row_num := .I]

StandardCatalogColumnNames <-
  quote(c(
    INDICATOR_FULL, # full name
    UNITLONG, # unit
    JAF_KEY, # unique indicator code
    SOURCE, # data source -> specific function?
    GENSENSE, # + if high is good, - if high is bad, blank otherwise
    formula, # if not blank, use it together with factor1, factor2, factor3, etc. mapped to a, b, c, etc. in formula
    table # use it if formula is blank, together with cond1, cond2, cond3, etc
  )) %>%
  as.character() %>% 
  .[-1] # remove 'c'

NumberedCatalogColumnNames <-
  colnames(Catalog) %>% 
  grep("^(cond|factor)[0-9]+$",.,value=TRUE)
FactorColnames <-
  grep('factor',NumberedCatalogColumnNames,value=TRUE)
CondColnames <-
  grep('cond',NumberedCatalogColumnNames,value=TRUE)

SelectedCatalogColumnNames <-
  c(StandardCatalogColumnNames,
    NumberedCatalogColumnNames)

id_cols <-
  c('row_num',StandardCatalogColumnNames)

CatalogFormulaOrCond <-
  Catalog %>% 
  # .[!is.na(table) | !is.na(cond1) | !is.na(formula)] %>% 
  processCatalog()
# [1] "Eurostat, EU Labour Force Survey"                                                  
# [2] "Eurostat, Demographic Statistics and EU Statistics on Income and Living Conditions"
# [3] "Eurostat, Demographic Statistics"                                                  
# [4] "Eurostat, EU Statistics on Income and Living Conditions"           ooo                
# [5] "Eurostat, Structure of Earnings Survey"                                            
# [6] "OECD, EPL"                                                                         
# [7] "European Commission, Labour Market Policy"        ***                                 
# [8] "OECD and European Commission, Benefits and wages"               <<<                   
# [9] "Eurostat, National Accounts "                                                      
# [10] "Eurostat, EGSS data collection"                                                    
# [11] "Eurostat, Education Statistics"                                                    
# [12] "DG CONNECT"         +++                                                               
# [13] "Eurostat, National Accounts"                                                       
# [14] "Eurostat, UOE"                                                                     
# [15] "Eurostat, EU labour Force Survey"                   >>>                               
# [16] "OECD, Pisa"                                                                        
# [17] "Eurostat, ESSPROS"                                                                 
# [18] "OECD, Health Statistics"         


CatalogNoFormulaOrCond <-
  Catalog %>%
  # .[is.na(table) & is.na(cond1) & is.na(formula)] %>%
  processCatalog(comment="# ")
# [1] "National Sources/LFS"
# [2] "National sources"
# [3] NA
# [4] "European Commission, Labour Market Policy"     ***
# [5] "OECD and European Commission, Benefits and wages"                <<<
# [6] "Eurostat, EU Statistics on Income and Living Conditions"         ooo
# [7] "SPC-OV 9b               (OECD - EC ?)"
# [8] "OECD and AWG?"
# [9] "Eurostat, EU Labour Force Survey"                         >>>
# [10] "Eurostat, Structural Business Statistics "
# [11] "National sources "
# [12] "Eurostat, EU Job Vacancy Statistics"
# [13] "Eurostat, EU Labour Force Survey and Job Vacancy Statistics"
# [14] "CEDEFOP"
# [15] "DG CONNECT"              +++
# [16] "CVTS"
# [17] "ICT household survey "
# [18] "Eurostat, EU Labour Force Survey, National Accounts and Education statistics"
# [19] "Eurostat, ESSPROS and EPC/AWG (under preparation)"
# [20] "EPC/AWG (under preparation)"

# helpers <-
#   c('source("JAF_functions.R")\n',
#     '`inside<-` <- function(.list, create_indicator, value) {',
#     'message("Modifying JAF_INDICATORS element `",create_indicator,"`...")',
#   '.list[[create_indicator]] <- value',
#   '.list',
#   '}') %>% 
#   paste(collapse='\n')

saveAsUtf8 <- function(contents, file_name) {
  file_conn <-
    file("JAF_indicators__definitions.R", open="wt", encoding="UTF-8")
  on.exit(close(file_conn))
  cat(contents, file=file_conn, sep='\n')
}


CodeLines <-
  c(paste('### Compiled automatically by',Sys.getenv("USERNAME")),
    '### from `JAF Indicators Table.xlsx`, worksheet `IndicatorsTable`',
    paste('### ',
          c('on ' %+% Sys.time(),
            Number_of_defined_indics_message,
            Number_of_undefined_indics_message)),
    'source("JAF_functions.R")',
    'JAF_INDICATORS = list()',
    # helpers,
    CatalogFormulaOrCond$definitions,
    '\n\n### Mis-specified indicators are commented-out below -- but some valid indicators below too,\n',
    '\n\n### the valid ones are those with significantly modified definitions compared to the catalogue\n',
    CatalogNoFormulaOrCond$definitions,
    '\n')  %>% 
  gsub('fromEurostatDataset( ','fromEurostatDataset(',.,fixed=TRUE)  %>% 
  gsub('with_filters( ','with_filters(',.,fixed=TRUE)  %>% 
  gsub('fromFormula( ','fromFormula(',.,fixed=TRUE) %>% 
  # enc2utf8() %>% 
  # Special treatment:
  sub(
    '
# inside(JAF_INDICATORS, indicator_named = "PA6a.S5.") = 
# specification(
# name = "Employment in newly established enterprises ",
# unit = "% (of current employment in all active enterprises)",
# source = "Eurostat, Structural Business Statistics ",
# high_is_good = TRUE,
# value = fromEurostatDataset("empl_new_enterprises",
#  with_filters(NA))
# )',
'
inside(JAF_INDICATORS, indicator_named = "PA6a.S5.") = 
specification(
name = "Employment in newly established enterprises",
unit = "% (of current employment in all active enterprises)",
source = "Eurostat, Structural Business Statistics",
high_is_good = TRUE,
value = fromFormula((a + b + c + d)/e,
where = variables(
 a = fromEurostatDataset("bd_9bd_sz_cl_r2",
with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16920")),
 b = fromEurostatDataset("bd_9bd_sz_cl_r2",
with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16941")),
 c = fromEurostatDataset("bd_9bd_sz_cl_r2",
with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16942")),
 d = fromEurostatDataset("bd_9bd_sz_cl_r2",
with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16943")),
 e = fromEurostatDataset("bd_9bd_sz_cl_r2",
with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16910"))
)))',
.,
fixed=TRUE)  %>% 
  # Special treatment:
  sub(
    '
inside(JAF_INDICATORS, indicator_named = "PA4.2.S2.") = 
specification(
name = "Low wage trap – tax rate on low wage earners ",
unit = "% (of increase in gross earnings)",
source = "OECD and European Commission, Benefits and wages",
high_is_good = FALSE,
value = fromEurostatDataset("earn_nt_lowwtrp",
 with_filters(NA))
)',
'
inside(JAF_INDICATORS, indicator_named = "PA4.2.S2.") = 
specification(
name = "Low wage trap – tax rate on low wage earners ",
unit = "% (of increase in gross earnings)",
source = "OECD and European Commission, Benefits and wages",
high_is_good = FALSE,
value = fromEurostatDataset("earn_nt_lowwtrp",
 with_filters(NA))
)',
.,
fixed=TRUE) %>% 
  sub('
# inside(JAF_INDICATORS, indicator_named = "PA9.1.S5.") = 
# specification(
# name = "Annual expenditure in primary (ISCED 1) and secondary (ISCED 2-4) education per capita age group 6-18",
# unit = "ratio (expenditure/GDP)",
# source = "Eurostat, EU Labour Force Survey, National Accounts and Education statistics",
# high_is_good = TRUE,
# value = fromEurostatDataset("educ_exp0_4",
#  with_filters(NA))
# )',
'
inside(JAF_INDICATORS, indicator_named = "PA9.1.S5.") = 
specification(
name = "Annual expenditure in primary and secondary education per capita of age group 5-19 relative to GDP per capita",
unit = "ratio of ratios (expenditure/young population)/(GDP/total population)",
source = "Eurostat",
high_is_good = TRUE,
value = fromFormula( ((a + b + c)/(d + e + f))/(g/h),
where = variables(
 a = fromEurostatDataset("educ_uoe_fine01",
with_filters(unit="MIO_EUR", sector="S1", isced11="ED1")),
 b = fromEurostatDataset("educ_uoe_fine01",
with_filters(unit="MIO_EUR", sector="S1", isced11="ED2")),
 c = fromEurostatDataset("educ_uoe_fine01",
with_filters(unit="MIO_EUR", sector="S1", isced11="ED3")),
 d = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="Y5-9")),
 e = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="Y10-14")),
 f = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="Y15-19")),
 g = fromEurostatDataset("nama_10_gdp",
with_filters(unit="CP_MEUR", na_item="B1GQ")),
 h = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="TOTAL"))
)))',
., fixed=TRUE) %>% 
  sub('
# inside(JAF_INDICATORS, indicator_named = "PA9.2.S4.") = 
# specification(
# name = "Annual expenditure in tertiary education (ISCED 5+6) per capita age group 20-24",
# unit = "ratio (expenditure/GDP)",
# source = "Eurostat, EU Labour Force Survey, National Accounts and Education statistics",
# high_is_good = TRUE,
# value = fromEurostatDataset("educ_exp5_6",
#  with_filters(NA))
# )',
'
inside(JAF_INDICATORS, indicator_named = "PA9.2.S4.") = 
specification(
name = "Annual expenditure in tertiary education per capita of age group 20-24 relative to GDP per capita",
unit = "ratio of ratios (expenditure/young population)/(GDP/total population)",
source = "Eurostat",
high_is_good = TRUE,
value = fromFormula( (a/b)/(c/d),
where = variables(
 a = fromEurostatDataset("educ_uoe_fine01",
with_filters(unit="MIO_EUR", sector="S1", isced11="ED5-8")),
 b = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="Y20-24")),
 c = fromEurostatDataset("nama_10_gdp",
with_filters(unit="CP_MEUR", na_item="B1GQ")),
 d = fromEurostatDataset("demo_pjangroup",
with_filters(unit="NR", sex="T", age="TOTAL"))
)))',
., fixed=TRUE) %T>%
  saveAsUtf8()



