
# Functions and constants -------------------------------------------------

Selected_Main_Indicators_Codes <-
  c("PA1.O1.", "PA1.S1.M", "PA1.S1.F", "PA1.S3.", "PA1.S4.", "PA1.C3.T", "PA1.C4.T",
    "PA1.O2.", "PA1b.O1.", "PA1b.O1.n.", "PA1c.O1.", "PA1d.O1.", "PA2a.O1.", "PA2b.O1.",
    "PA3.O1.", "PA4.1.O1.", "PA4.2.O1.", "PA5.O1.", "PA6a.O1.", "PA6b.O1.", "PA7.1.O1.",
    "PA7.2.O1.", "PA8.1.O1.", "PA8.2.O1.", "PA9.1.O1.", "PA10.O1.", "PA11.O1.", "PA11.S1.",
    "PA11.S2.", "PA11.S3.T", "PA11.S4.", "PA11.S5.", "PA11.S8.", "PA11.S15.", "PA11a.O1.",
    "PA11b.O1.", "PA11c.O1.") %>%
  data.table(JAF_KEY=.,
             Main_Indicators_order = seq_along(.))


Selected_Main_Indicators_Multiline_Header <-
  JAF_SCORES %>% 
  .[, .(JAF_KEY, name, high_is_good,
        reference_name_latest_value, reference_name_change,
        reference_latest_value, reference_change,
        reference_time_latest_value, reference_time_change)] %>% 
  .[, reference_latest_value := round(reference_latest_value,1)] %>% 
  .[, reference_change := round(reference_change,1)] %>%
  .[, lapply(., as.character)] %>%
  merge(Selected_Main_Indicators_Codes, by='JAF_KEY') %>% 
  .[!duplicated(.)] %>% 
  .[, 'High is: good = [+], bad = [\u2212]' :=
      ifelse(high_is_good,'[+]','[-]') %>% 
      ifelse(is.na(.),"",.)] %>% 
  melt(id.vars=c('Main_Indicators_order','JAF_KEY','name',
                 'High is: good = [+], bad = [\u2212]'),
       measure.vars=patterns('^reference_')) %>% 
  .[, level_or_change := 
      variable %>% 
      sub('^.+_(.+)$','\\1',.) %>% 
      ifelse(.=='value','latest_value',.)] %>% 
  setorder(Main_Indicators_order) %>% 
  .[, c('Main_Indicators_order','variable') := NULL] %>% 
  setnames(c('value','name'),
           c('Reference type | Ref. value | Ref. year','Indicator')) %>% 
  sanitizeForExcel() %>%
  .[, 'High is: good = [+], bad = [\u2212]' :=
      get('High is: good = [+], bad = [\u2212]') %>% 
      ifelse(.=='[-]','[\u2212]',.)] %>% 
  split(by='level_or_change', keep.by=FALSE) %>%
  lapply(t)

Selected_Main_Indicators_Contents <-
  JAF_SCORES %>% 
  .[, .(geo, JAF_KEY, time, flags_,
        value_latest_value, value_change,
        score_latest_value, score_change,
        reference_time_latest_value, reference_time_change)] %>% 
  merge(Selected_Main_Indicators_Codes, by='JAF_KEY') %>% 
  .[, Main_Indicators_order := 
      sprintf("%03d", Main_Indicators_order)] %>% 
  {sapply(
    c('change','latest_value'),
    simplify = FALSE,
    FUN = function(suffix)
      .[, c('geo','time','flags_','Main_Indicators_order',
            grep(paste0('_',suffix,'$'),colnames(.),value=TRUE))
        , with=FALSE] %>% 
      setnames(colnames(.),
               colnames(.) %>% sub(paste0('_',suffix,'$'),"",.)) %>% 
      .[, Flag :=
          paste(ifelse(!is.na(flags_),flags_,""),
                ifelse(time!=reference_time,time,"")) %>% 
          trimws()] %>% 
      .[, c('time','flags_','reference_time') := NULL] %>% 
      .[, score := round(score,1)] %>% 
      .[, value := round(value,2)] %>% 
      setnames(c('score','value'),
               c('Score',ifelse(suffix=='latest_value','Level','Change'))) %>% 
      sanitizeForExcel() %>% 
      dcast(geo ~ Main_Indicators_order,
            value.var = colnames(.) %without% c('geo','Main_Indicators_order'),
            fun.aggregate=identity,
            fill=NA) %>% 
      setnames(colnames(.) %without% 'geo',
               colnames(.) %without% 'geo' %>% 
                 sub('^(.+)_(.+)$','\\2 \\1',.) %>% 
                 sub('Change','1Change',.) %>% 
                 sub('Level','1Level',.) %>% 
                 sub('Score','2Score',.) %>% 
                 sub('Flag','3Flag',.)) %>% 
      setcolorder(c('geo', sort(colnames(.) %without% 'geo'))) %>% 
      setnames(colnames(.),
               colnames(.) %>% gsub('[0-9| ]',"",.)) %>% 
      .[order(nchar(geo),geo)]
  )}


# Actions -----------------------------------------------------------------

createFolder(paste0(OUTPUT_FOLDER,'/Main'))
message('\nCreating Main_Indicators.xlsx file...')
wb_Main_Indic <-
  openxlsx2::wb_workbook()
for (indic_type in c('change','latest_value')) {
  Indic_Type <-
    ifelse(indic_type=='change','Changes',
           'Levels')
  cat(Indic_Type,"")
  head. <-
    Selected_Main_Indicators_Multiline_Header[[indic_type]]
  vals. <-
    Selected_Main_Indicators_Contents[[indic_type]]
  wb_Main_Indic <-
    wb_Main_Indic %>%
    wb_add_worksheet(Indic_Type) %>%
    wb_add_data(x=c('Main Indicators',Indic_Type),
                dims='A1') %>%
    wb_add_data(x=head.,
                dims='A3',
                colNames=FALSE,
                rowNames=TRUE) %>%
    wb_add_data(x=vals.,
                dims=paste0('A',3 + nrow(head.))) %>%
    wb_set_col_widths(cols=1,
                      widths=33) %>%
    wb_freeze_pane(firstActiveRow=8,firstActiveCol=2) %>%
    wb_add_filter(rows=7, cols=1) %>%
    wb_add_font(dims='A1:A2',
                bold="bold",
                size=18) %>%
    wb_add_font(dims=paste0('A3:',int2col(ncol(head.)),'5'),
                bold="bold",
                size=12) %>%
    wb_add_font(dims=paste0('A',7+nrow(vals.)-1,':',int2col(ncol(vals.)),7+nrow(vals.)),
                bold="bold") %>%
    wb_add_fill(every_nth_row = 2,
                dims=paste0("A8:",int2col(ncol(vals.)),8+nrow(vals.)),
                color= wb_color(hex="e6f1ff")) %>%
    Reduce(init=.,
           x=seq.int(2,2+ncol(head.)-3,3),
           f=\(wb.,x)
           Reduce(init=wb.,
                  x=3:5,
                  f=\(wb..,y)
                  wb_merge_cells(wb..,
                                 rows=y,
                                 cols=seq.int(x,x+2)) %>%
                    wb_add_cell_style(
                      dims=paste0(int2col(x),y,':',int2col(x+2),y),
                      horizontal='center', vertical='center',
                      wrapText = "1"))) %>%
    Reduce(init=.,
           x=seq.int(2,2+ncol(head.)-3,3) %>%
             {paste0(int2col(.),'3:',int2col(.+2),2+nrow(head.)+nrow(vals.)+1)},
           f=\(wb.,x)
           wb_add_border(wb.,
                         dims=x)) %>%
    wb_add_border(dims=paste0('A3:A',2+nrow(head.)+nrow(vals.)+1)) %>%
    wb_set_row_heights(rows=4, heights=60) %>%
    wb_set_col_widths(cols=seq.int(2,2+ncol(head.)-1,3),
                      widths=13.2) %>%
    setZoomInAllSheets(75)
}
wb_Main_Indic %>%
  wb_save(paste0(OUTPUT_FOLDER,
                 '/Main/Main_Indicators.xlsx'))
message('\nDone.')