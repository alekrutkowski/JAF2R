
JAF_KEYs__for_EPM_PartII <-
  c("PA1.O1.","PA1.S1.F","PA1.S1.M","PA1.S2.","PA1.S3.","PA1.S4.","PA1.S5.",
    "PA1.S6.","PA1.C1.","PA10.C3.","PA10.C4.","PA10.C5.","PA10.C6.","PA1b.C7.15-24.T",
    "PA1b.O1.n.","PA2a.O1.","PA2a.S3.","PA2b.O1.","PA3.O1.","PA4.1.O1.","PA1.C3.15-74.T",
    "PA4.2.O1.","PA5.C5.","PA5.O1.","PA6b.O1.","PA7.1.O1.","PA7.2.O1.","PA8.1.O1.",
    "PA9.1.O1.","PA9.2.O1.") # 2 codes to be added for:
# Life long learning - percentage of adult population (aged 25-64) participating in education and training - total
# Adult population (aged 25-64) participating in education and training in the last 12 months, without guided-on-the-job training


current_year <-
  Sys.Date() %>% substr(1,4) %>% as.integer()

countryTableForEPMpartII <- function(geo_code)
  JAF_GRAND_TABLE_with_indic_names_and_PA_codes %>% 
  .[geo==as.character(geo_code)] %>% 
  .[, geo := NULL] %>% 
  .[!is.na(value_)] %>% 
  .[as.integer(time) >= current_year-6L &
      as.integer(time) < current_year] %>% 
  .[JAF_KEY %in% JAF_KEYs__for_EPM_PartII] %>% 
  .[, flags_ := flags_ %>% ifelse(.==':',"",.)] %>% 
  .[, flags_ := flags_ %>% ifelse(is.na(.),"",.)] %>% 
  dcast(JAF_KEY + Description ~ time,
        fun.aggregate=identity,
        fill=NA,
        value.var=c('value_','flags_')) %>% 
  reorderValFlagCols() %>% 
  .[, `2030` := ""]

countryTableForEPMpartII__EU <- 
  countryTableForEPMpartII(EU_geo_code)

splitIntoPairs <- function(x)
  split(x, ceiling(seq_along(x)/2))

# Actions -----------------------------------------------------------------

message('\nCreating `EPM Part II Country Overviews` Excel files...')
WB <-
  openxlsx2::wb_workbook()
for (geo_code in EU_Members_geo_codes) {
  cat(geo_code,"")
  dta <-
    geo_code %>%
    countryTableForEPMpartII() %>%
    merge(countryTableForEPMpartII__EU,
          by=c('JAF_KEY','Description')) %>% 
    order_by_JAF_KEY() %>% 
    sanitizeForExcel() %>%
    setnames(colnames(.),
             colnames(.) %>%
               sub('^value__(.{4})..$','\\1',.) %>%
               sub('^flags__.{4}..$',"",.)) %>% 
    set_names(substr(colnames(.),1,4))
  WB <-
    WB %>%
    wb_add_worksheet(geo_code) %>%
    wb_add_data(x=current_year,
                dims='B2') %>%
    wb_add_data(x=EU_Members_geo_names[geo==geo_code, geo_labels],
                dims='C4') %>%
    wb_add_data(x=EU_geo_code,
                dims='P4') %>%
    wb_add_data(x=dta,
                dims='A5') %>%
    wb_add_data(x='National Targets',
                dims='O4') %>%
    wb_add_data(x='EU Targets',
                dims='AB4') %>%
    wb_set_col_widths(cols=1:28,
                      widths=c(16,30, # JAF_KEY and Description columns
                               rep.int(times=2, # one for country, another one for EU
                                       x=c(rep.int(times=6, # LATEST 6 YEARS
                                                   x=c(6,3)),
                                           9) # the Targets column
                               ))) %>%
    wb_freeze_pane(firstActiveRow=5) %>%
    # wb_add_filter(rows=2, cols=1:4) %>%
    wb_add_font(dims='A1:AB5',
                bold="bold") %>%
    wb_add_font(dims='B2', size=22) %>%
    wb_add_font(dims='C4', size=22) %>%
    wb_add_font(dims='P4', size=22) %>%
    wb_add_cell_style(
      dims='C5:AB5',
      horizontal='center') %>% 
    wb_add_cell_style(
      dims='O4',
      horizontal='center', vertical='center',
      wrapText = "1") %>% 
    wb_add_cell_style(
      dims='AB4',
      horizontal='center', vertical='center',
      wrapText = "1") %>% 
    wb_add_cell_style(
      dims=paste0('B6:B',5+nrow(dta)),
      vertical='center',
      wrapText = "1") %>% 
    wb_merge_cells(rows=4, cols=3:14) %>% 
    wb_merge_cells(rows=4, cols=16:27) %>% 
    Reduce(init=.,
           x=splitIntoPairs(3:14),
           \(wb.,x) wb_merge_cells(wb., rows=5, cols=x)) %>% 
    Reduce(init=.,
           x=splitIntoPairs(16:27),
           \(wb.,x) wb_merge_cells(wb., rows=5, cols=x)) %>% 
    wb_add_border(dims='B5:AB5') %>% 
    wb_add_border(dims=paste0('B6:AB',5+nrow(dta))) %>% 
    wb_add_border(dims=paste0('O4:O',5+nrow(dta))) %>% 
    wb_add_border(dims=paste0('AB4:AB',5+nrow(dta)))
}
WB %>%
  setZoomInAllSheets(75) %>%
  wb_save(paste0(OUTPUT_FOLDER,
                 '/EPM Part II Country Overviews.xlsx'))
message('\nDone.')
