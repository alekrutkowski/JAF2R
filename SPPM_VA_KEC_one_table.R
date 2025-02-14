


# Actions -----------------------------------------------------------------

message('\nCreating KEC one table file.xlsx...')

dta <- 
  JAF_SCORES %>% 
  merge(IndicsSelectedForKEC, by='JAF_KEY') %>% 
  {data.table(row_order=.$row_order,
              `POLICY AREA` = .$`POLICY AREA`,
              Indicator = .$JAF_KEY,
              Description = .$Description %>% stringi::stri_trans_general("Latin-ASCII"), # stri_trans_general needed to sanitize, otherwise Excel reports broken file
              geo=.$geo,
              QuantAssessmentNum=.$QuantAssessmentNum,
              QuantAssessmentGood=.$QuantAssessmentGood)} %>% 
  .[isNotNA(QuantAssessmentGood)] %>% 
  .[geo %in% EU_Members_geo_codes] %>% 
  .[, QuantAssessmentGood := ifelse(QuantAssessmentGood,'(+)','(\u2212)')] %>% # \u2212 = minus
  dcast(row_order + `POLICY AREA` + Indicator + Description ~
          geo + QuantAssessmentGood,
        fun.aggregate=identity, value.var='QuantAssessmentNum',
        fill=NA_integer_, sep=' ', drop=c(TRUE, FALSE)) %>% 
  setorder(row_order) %>% 
  .[,row_order := NULL] %>% 
  .[, `POLICY AREA` := `POLICY AREA` %>% 
      ifelse(duplicated(.),"",.)]



KEC_wb <-
  openxlsx2::wb_workbook()
KEC_wb$add_worksheet('One table')
KEC_wb$add_data(sheet='One table',
                x=dta,
                na.strings="")
KEC_wb$set_col_widths(sheet='One table',
                      cols=c(1,3),
                      widths=70)
for (ws in KEC_wb$worksheets)
  ws$sheetViews <- set_zoom(75, ws$sheetViews)
wb_save(KEC_wb,paste0(OUTPUT_FOLDER,'/KEC/Key Employment Challenges and Good Outcomes - single table.xlsx'))
message('\nDone.')
