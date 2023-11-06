
# Functions and constants -------------------------------------------------

reorderValFlagCols <- function(dt,
                               sep='__', value_prefix='value', flags_prefix='flags',
                               nchar_of_timeval=4) # assumed a year i.e. 4 digits
  dt %>% 
  colnames(.) %>% 
  {c(setdiff(., grep(paste0('^(',value_prefix,'|',flags_prefix,').+$'),.,value=TRUE)),
     grep('^(value_|flags_).+$',.,value=TRUE) %>% 
       set_names(sub(paste0('^(.+)',sep,'(.{',nchar_of_timeval,'})$'),
                     paste0('\\2',sep,'\\1'),.) %>% 
                   sub(value_prefix,paste0('*',value_prefix),.,fixed=TRUE)) %>% # to make "flags" follow "value" in an alphabetical sort order
       .[sort(names(.))]
  )} %>% 
  setcolorder(dt, .)

JAF_GRAND_TABLE_with_indic_names_and_PA_codes <-
  JAF_GRAND_TABLE %>% 
  .[, `Policy Area` := sub("^([^\\.]+)\\..*$", "\\1", JAF_KEY)] %>% 
  merge(JAF_NAMES_DESCRIPTIONS, by='JAF_KEY') %>% 
  setnames(c('name','unit'),
           c('Description','Unit'))

countryTableForCountryCompendium <- function(geo_code)
  JAF_GRAND_TABLE_with_indic_names_and_PA_codes %>% 
  .[geo==as.character(geo_code)] %>% 
  .[, geo := NULL] %>% 
  .[!is.na(value_)] %>% 
  .[as.integer(time)>=2000] %>% 
  .[, flags_ := flags_ %>% ifelse(.==':',"",.)] %>% 
  dcast(`Policy Area` + JAF_KEY + Description + Unit ~ time,
        fun.aggregate=identity,
        fill=NA,
        value.var=c('value_','flags_')) %>% 
  reorderValFlagCols()

setZoomInAllSheets <- function(wb, zoom_level) {
  for (ws in wb$worksheets)
    ws$sheetViews <- set_zoom(zoom_level, ws$sheetViews)
  wb
}


# Actions -----------------------------------------------------------------
message('\nCreating Country Compendium files...')
createFolder(paste0(OUTPUT_FOLDER,'/Country Compendium'))
for (geo_code in unique(JAF_GRAND_TABLE$geo)) {
  cat(geo_code,"")
  dta <-
    geo_code %>% 
    countryTableForCountryCompendium() %>% 
    sanitizeForExcel() %>% 
    setnames(colnames(.),
             colnames(.) %>%
               sub('^value__(.{4})$','\\1',.) %>%
               sub('^flags__.{4}$',"",.))
  openxlsx2::wb_workbook() %>%
    wb_add_worksheet(geo_code) %>%
    wb_add_data(x=EU_Members_geo_names[geo==geo_code, geo_labels],
                dims='C1') %>% 
    wb_add_data(x=dta,
                dims='A2') %>%
    wb_add_data(x='Values are in columns denoted with year headers. They are immediatelly followed by the corresponding flags in the columns without the headers.',
                dims='E1') %>%
    wb_set_col_widths(cols=1:4,
                      widths=c(12,20,50,30)) %>% 
    wb_freeze_pane(firstActiveRow=3) %>%
    wb_add_filter(rows=2, cols=1:4) %>%
    wb_add_font(dims='C1',
                bold="bold",
                size=18) %>% 
    wb_add_font(dims=paste0('A2:',int2col(ncol(dta)),'2'),
                bold="bold") %>% 
    Reduce(init=.,
           x=seq.int(3,3+nrow(dta),2) %>%
             paste0("A",.,":",int2col(ncol(dta)),.),
           f=\(wb.,x) wb_add_fill(wb.,
                                  dims=x,
                                  color= wb_color(hex="e6f1ff"))) %>% 
    setZoomInAllSheets(75) %>% 
    wb_save(paste0(OUTPUT_FOLDER,
                   '/Country Compendium/',geo_code,'.xlsx'))
}