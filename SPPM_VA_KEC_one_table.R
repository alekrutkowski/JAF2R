


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
KEC_wb$add_font(sheet='One table',
                dims=paste0('A1:',int2col(ncol(dta)),'1'),
                bold="bold")
KEC_wb$add_cell_style(sheet='One table',
                      dims=paste0('D1:',int2col(ncol(dta)),'1'),
                      horizontal="right")
KEC_wb$set_col_widths(sheet='One table',
                      cols=c(1,2,3),
                      widths=c(70,22,70))
KEC_wb$freeze_pane(sheet='One table',
                   first_active_row=2,
                   first_active_col=4)
KEC_wb$set_col_widths(sheet='One table',
                      cols=seq_len(ncol(dta)) %>% tail(-3),
                      widths=6)
for (ws in KEC_wb$worksheets)
  ws$sheetViews <- set_zoom(75, ws$sheetViews)
wb_save(KEC_wb,paste0(OUTPUT_FOLDER,'/KEC/Key Social Challenges and Good Social Outcomes - single table.xlsx'))
message('\nDone.')
