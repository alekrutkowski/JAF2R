library(magrittr)
library(data.table)
library(openxlsx2)

EU_geo_code <-
  'EU27_2020'

message('\nParsing JAF_indicators__definitions.xlsx...')

`if`(exists('MODIFICATIONS'))
     message('Programmatic MODIFICATIONS will be injected!')

JAF_definitions <-
  read_xlsx('JAF_indicators__definitions.xlsx',
            sheet=1,
            start_row=2,
            cols=1:10) %>% 
  as.data.table() %>% 
  `if`(exists('MODIFICATIONS'),
       MODIFICATIONS(.), # injected function to make programmatic modifications if the function `MODIFICATIONS` exists in the environment
       .) %>% 
  .[, def := 
      paste0('inside(JAF_INDICATORS, indicator_named = "',JAF_KEY,'") = 
specification(
name = "',name,'",
unit_of_level = "',unit_of_level,'",
unit_of_change = "',unit_of_change,'",
indicator_groups = "',indicator_groups,'",
source = "',source,'",
high_is_good = ',high_is_good,',\n',
ifelse(!calculate_score_change,
       paste0('calculate_score_change = ',calculate_score_change,',\n'),
       ""),
ifelse(!calculate_score_change_with_break_in_series,
       paste0('calculate_score_change_with_break_in_series = ',calculate_score_change_with_break_in_series,',\n'),
       ""),
ifelse(reference_in_scores!=EU_geo_code,
       paste0('reference_in_scores = "',reference_in_scores,'",\n'),
       ""),
'value = ',value,
'\n)\n')] %>% 
  .$def %>% 
  c(paste('###',length(.),'indicators'),
    paste('### compiled automatically by',Sys.getenv("USERNAME")),
    paste('### on',format(Sys.time(),"%Y-%m-%d %H:%M:%S")),
    paste('### from `JAF_indicators__definitions.xlsx`, worksheet',
          wb_load('JAF_indicators__definitions.xlsx',sheet=1) %>% 
            wb_get_sheet_names() %>% 
            paste0('"',.,'"')),
    `if`(exists('MODIFICATIONS'),
         c('### With subsequent modifications:',
           paste('###',deparse(MODIFICATIONS))),
         ""),
    "",
    .) %>% 
  cat(file='JAF_indicators__definitions.R',sep='\n')

message('Saved JAF_indicators__definitions.R')
