library(magrittr)
library(data.table)
library(openxlsx2)

EU_geo_code <-
  'EU27_2020'

`inside<-` <- function(.list,  indicator_named, value) {
  .list[[indicator_named]] <-
    list(indicator_named, value)
  .list
}

specification <- function(name,
                          indicator_groups,
                          unit_of_level,
                          unit_of_change="",
                          source,
                          high_is_good,
                          calculate_score_change=TRUE,
                          calculate_score_change_with_break_in_series=TRUE,
                          reference_in_scores=EU_geo_code,
                          value)
  list(name=name,
       indicator_groups=indicator_groups,
       unit_of_level=unit_of_level,
       unit_of_change=unit_of_change,
       source=source,
       high_is_good=high_is_good,
       calculate_score_change=calculate_score_change,
       calculate_score_change_with_break_in_series=calculate_score_change_with_break_in_series,
       reference_in_scores=reference_in_scores,
       value = substitute(value) %>%
         deparse1() %>% 
         gsub(', where =',',\n  where =',.,fixed=TRUE) %>% 
         gsub('with_filters(','\n    with_filters(',.,fixed=TRUE) %>% 
         gsub('variables(','variables(\n  ',.,fixed=TRUE) %>% 
         gsub(', (.) = ',',\n  \\1 = ',.))

JAF_INDICATORS <- list()

message('\nParsing JAF_indicators__definitions.R...')
source('JAF_indicators__definitions.R')

`JAF_KEY->PA_string` <- function(JAF_KEY)
  sub("PA(.*?)\\.(C|O|S).*",'\\1',JAF_KEY) # e.g. PA11c.S1.T -> 11c ; PA7.2.S2.F -> 7.2

`JAF_KEY->C_O_S_part` <- function(JAF_KEY)
  sub("PA(.*?)\\.(C|O|S)(.+?)\\..*",'\\2\\3',JAF_KEY) # e.g. PA11c.S1.T -> S1 ; PA1.O1. -> O1

sort_JAF_KEY <- function(JAF_KEY) {
  pa <-
    JAF_KEY %>% 
    `JAF_KEY->PA_string` %>% 
    list(gsub('[^0-9.]',"",.) %>% 
           as.numeric() %>% 
           ifelse(.>99,floor(./10),.), # otherwise it becomes e.g. 115 for PA11f5.S2.
         .)
  mid <- 
    JAF_KEY %>% 
    `JAF_KEY->C_O_S_part` %>% 
    {list(substr(.,1,1) %>% kit::nswitch('O',1L, 'S',2L, 'C',3L,
                                         default=4L),
          substr(.,2,nchar(.)) %>% as.integer())}
  JAF_KEY %>% 
    .[order(pa[[1]],pa[[2]],mid[[1]],mid[[2]],.)]
}

order_by_JAF_KEY <- function(dt)
  dt %>% 
  .[, ._.ordering._. := 
      JAF_KEY %>% 
      as.character() %>% 
      factor(levels=
               unique(.) %>% 
               sort_JAF_KEY()) %>% 
      as.integer()] %>% 
  setorder(._.ordering._.) %>% 
  .[, ._.ordering._. := NULL]

JAF_catalogue <-
  JAF_INDICATORS %>%
  names() %>%
  lapply(function(JAF_KEY)
    JAF_INDICATORS[[JAF_KEY]][[2]] %>% 
      as.data.table() %>% 
      .[, JAF_KEY:=JAF_KEY]) %>% 
  rbindlist() %>% 
  order_by_JAF_KEY() %>% 
  setcolorder('JAF_KEY')

set_zoom <- function(x, sheet_views) # from https://stackoverflow.com/a/74239871
  gsub('(?<=zoomScale=")[0-9]+', x,
       sheet_views, perl=TRUE)

setZoomInAllSheets <- function(wb, zoom_level) {
  for (ws in wb$worksheets)
    ws$sheetViews <- set_zoom(zoom_level, ws$sheetViews)
  wb
}

new_col_suffixes <-
  c('INPUT','OUTPUT','MAIN','OVERALL','SUBINDICATOR','COMPENDIUM')

excelFormula__is_X <- function(suffix)
  paste0('ISNUMBER(SEARCH("',suffix,'",jaf[indicator_groups]))')

excelFormula__PA_code <-
  paste0('=MID(jaf[JAF_KEY], 3, MIN(IFERROR(SEARCH(".C", jaf[JAF_KEY]), ',
         'LEN(jaf[JAF_KEY])), IFERROR(SEARCH(".O", jaf[JAF_KEY]), ',
         'LEN(jaf[JAF_KEY])), IFERROR(SEARCH(".S", jaf[JAF_KEY]), ',
         'LEN(jaf[JAF_KEY]))) - 3)')

wb_workbook() %>% 
  wb_add_worksheet(format(Sys.time(),"%Y-%m-%d %H:%M:%S") %>% 
                     paste0('compiled on ',.) %>% 
                     gsub(':','.',.,fixed=TRUE)) %>% 
  wb_add_data(dims=paste0(int2col(ncol(JAF_catalogue)+length(new_col_suffixes)+2),'1'),
              x=readLines('JAF_indicators__definitions.R') %>% 
                grep('^###',.,value=TRUE) %>% 
                paste0(collapse='\n') %>% 
                paste0('Compiled by ',Sys.getenv("USERNAME"),
                       ' \nfrom JAF_indicators__definitions.R \n',
                       'which had the following comments: \n',.)) %>% 
  wb_add_data_table(x=JAF_catalogue,
                    start_row=2,
                    table_style = "TableStyleLight1",
                    table_name='JAF') %>% 
  wb_add_data(x='Main columns defining the indicators',
              start_col=1, start_row=1) %>% 
  wb_add_data(x='Ctrl + Shift + U',
              start_col=ncol(JAF_catalogue), start_row=1) %>% 
  wb_add_data(x="Derived helper columns for easier filtering \u2013 don't edit them",
              start_col=ncol(JAF_catalogue)+1, start_row=1) %>% 
  wb_add_font(dims=paste0('A1:',int2col(ncol(JAF_catalogue)+1),'1'),
              bold="bold",
              size=20) %>% 
  wb_add_filter(rows=2,
                cols=(ncol(JAF_catalogue)+1):
                  (ncol(JAF_catalogue)+length(new_col_suffixes)+1)) %>% 
  Reduce(init=.,
         x=seq_along(new_col_suffixes),
         f=function(wb,x)
           wb %>% 
           wb_add_data(x=paste0('is_',new_col_suffixes[x]),
                       start_row=2,
                       start_col=ncol(JAF_catalogue)+x) %>% 
           wb_add_formula(x=rep.int(excelFormula__is_X(new_col_suffixes[x]),
                                    nrow(JAF_catalogue)), 
                          start_row=3,
                          start_col=ncol(JAF_catalogue)+x)) %>% 
  wb_add_data(x='PA_code',
              start_row=2,
              start_col=ncol(JAF_catalogue)+length(new_col_suffixes)+1) %>% 
  wb_add_formula(x=rep.int(excelFormula__PA_code,
                           nrow(JAF_catalogue)), 
                 start_row=3,
                 start_col=ncol(JAF_catalogue)+length(new_col_suffixes)+1) %>% 
  wb_set_col_widths(cols=1:(ncol(JAF_catalogue)+length(new_col_suffixes)+1),
                    widths=c(17,50,50,30,15,26,15,23,21,30,
                             12,12,12,13,18,18,10)) %>%
  wb_freeze_pane(first_active_row=3, first_active_col=2) %>% 
  wb_add_worksheet('Comments') %>% 
  wb_add_data(dims=paste0(int2col(ncol(JAF_catalogue)+length(new_col_suffixes)+2),'1'),
              x=readLines('JAF_indicators__definitions.R') %>% 
                grep('^###',.,value=TRUE) %>% 
                paste0(collapse='\n') %>% 
                paste0('Compiled by ',Sys.getenv("USERNAME"),
                       ' \nfrom JAF_indicators__definitions.R \n',
                       'which had the following comments: \n',.)) %>% 
  setZoomInAllSheets(50) %>% 
  wb_save('JAF_indicators__definitions.xlsx')

message('Saved JAF_indicators__definitions.xlsx')
