
# Functions and constants -------------------------------------------------

Available_Codes <-
  unique(JAF_GRAND_TABLE$JAF_KEY)

Selected_PAs_Codes <- list(
  PA1 = c(
    'PA1.O1.',
    'PA1.S1.M',
    'PA1.S1.F',
    'PA1.S2.',
    'PA1.S3.',
    'PA1.S4.',
    'PA1.S5.',
    'PA1.O2.'
  ),
  PA1b = c(
    'PA1b.O1.',
    'PA1b.O1.n.',
    'PA1b.S1.M',
    'PA1b.S1.F',
    'PA1b.S2.',
    'PA1b.S3.',
    'PA1b.S4.',
    'PA1b.S5.',
    'PA1b.S6.',
    'PA1b.S1.n.M',
    'PA1b.S1.n.F',
    'PA1b.S5.n.',
    'PA1b.S6.n.'
  ),
  PA1c = c(
    'PA1c.O1.',
    'PA1c.S1.Y55_59',
    'PA1c.S1.Y60-64',
    'PA1c.S1.M',
    'PA1c.S1.F',
    'PA1c.S2.T',
    'PA1c.S2.M',
    'PA1c.S2.F',
    'PA1c.S3.',
    'PA1c.S4.',
    'PA1c.S5.'
  ),
  PA1d = c(
    'PA1d.O1.',
    'PA1d.S1.M',
    'PA1d.S1.F',
    'PA1d.S2.T',
    'PA1d.S2.M',
    'PA1d.S2.F'
  ),
  PA2a = c(
    'PA2a.O1.',
    'PA2a.S1.Y15-24',
    'PA2a.S1.Y25-54',
    'PA2a.S1.Y55-64',
    'PA2a.S2.M',
    'PA2a.S2.F',
    'PA2a.S3.',
    'PA2a.S4.',
    'PA2a.S5.',
    'PA2a.S6.T',
    'PA2a.S6.Y15-24',
    'PA2a.S6.M',
    'PA2a.S6.F'
  ),
  PA2b = c(
    'PA2b.O1.',
    'PA2b.S1.',
    'PA2b.S2.',
    'PA2b.S3.',
    'PA2b.S4.Y15_64',
    'PA2b.S4.Y15_24',
    'PA2b.S4.Y25_54',
    'PA2b.S4.Y55_64',
    'PA2b.S5.',
    'PA2b.S6.',
    'PA2b.S7.',
    'PA2b.S8.'
  ),
  PA3 = c(
    'PA3.O1.',
    'PA3.S1.',
    'PA3.S2.',
    'PA3.S3.',
    'PA3.S4.',
    'PA3.S5.'
  ),
  PA4.1 = c(
    'PA4.1.O1.',
    'PA4.1.S1.',
    'PA4.1.S2.A1',
    'PA4.1.S2.A1_2DCH',
    'PA4.1.S2.A2',
    'PA4.1.S2.A2_2DCH',
    'PA4.1.S3.A1',
    'PA4.1.S3.A1_2DCH',
    'PA4.1.S3.A2',
    'PA4.1.S3.A2_2DCH',
    'PA4.1.S4.',
    'PA4.1.S5.'
  ),
  PA4.2 = c(
    'PA4.2.O1.',
    'PA4.2.S1.',
    'PA4.2.S2.',
    'PA4.2.S3.T',
    'PA4.2.S4.',
    'PA4.2.S5.',
    'PA4.2.S6.'
  ),
  PA5 = c(
    'PA5.O1.',
    'PA5.S1.INAC',
    'PA5.S1.PT',
    'PA5.S1.M',
    'PA5.S1.F',
    'PA5.S2.',
    'PA5.S3.T',
    'PA5.S3.<30',
    'PA5.S3.>30',
    'PA5.S4.T',
    'PA5.S4.<30',
    'PA5.S4.>30',
    'PA5.S5.',
    'PA5.S6.',
    'PA5.S7.'
  ),
  PA6a = c(
    'PA6a.O1.',
    'PA6a.S1.M',
    'PA6a.S1.F',
    'PA6a.S2.AGRI',
    'PA6a.S2.IND',
    'PA6a.S2.CONSTR',
    'PA6a.S2.SERV',
    'PA6a.S3.',
    'PA6a.S4.',
    'PA6a.S5.',
    'PA6a.S6.'
  ),
  PA6b = c(
    'PA6b.O1.', 
    'PA6b.S1.', 
    'PA6b.S2.', 
    'PA6b.S3.', 
    'PA6b.S4.'
  ),
  PA7.1 = c(
    'PA7.1.O1.',
    'PA7.1.S1.Y20-29',
    'PA7.1.S1.Y30-54',
    'PA7.1.S1.Y55-64',
    'PA7.1.S2.F',
    'PA7.1.S3.M',
    'PA7.1.S3.F',
    'PA7.1.S4.',
    'PA7.1.S5.',
    'PA7.1.S6.'
  ),
  PA7.2 = c(
    'PA7.2.O1.',
    'PA7.2.S1.M',
    'PA7.2.S1.F',
    'PA7.2.S2.M',
    'PA7.2.S2.F',
    'PA7.2.S3.',
    'PA7.2.S4.'
  ),
  PA8.1 = c(
    'PA8.1.O1.',
    'PA8.1.S1.MED',
    'PA8.1.S1.HIGH',
    'PA8.1.S2.',
    'PA8.1.S3.',
    'PA8.1.S4.',
    'PA8.1.S5.',
    'PA8.1.S6.'
  ),
  PA8.2 = c(
    'PA8.2.O1.',
    'PA8.2.S1.',
    'PA8.2.S2.',
    'PA8.2.S3.',
    'PA8.2.S4.',
    'PA8.2.S5.'
  ),
  PA9.1 = c(
    'PA9.1.O1.',
    'PA9.1.S1.',
    'PA9.1.S2.n.',
    'PA9.1.S2.',
    'PA9.1.S3.',
    'PA9.1.S4.',
    'PA9.1.S5.',
    'PA9.1.S6.'
  ),
  PA9.2 = c(
    'PA9.2.O1.',
    'PA9.2.S1.READ',
    'PA9.2.S1.MATH',
    'PA9.2.S1.SCIE',
    'PA9.2.S2.',
    'PA9.2.S3.',
    'PA9.2.S4.',
    'PA9.2.S5.',
    'PA9.2.S6.'
  ),
  PA10 = c(
    'PA10.O1.', 
    'PA10.S1.', 
    'PA10.S2.'
  ),
  PA11 = c(
    'PA11.O1.',
    'PA11.S1.',
    'PA11.S2.',
    'PA11.S3.T',
    'PA11.S3.M',
    'PA11.S3.F',
    'PA11.S4.',
    'PA11.S5.',
    'PA11.S6.',
    'PA11.S8.',
    'PA11.S9.',
    'PA11.S10.',
    'PA11.S11.',
    'PA11.S12.',
    'PA11.S13.',
    'PA11.S14.',
    'PA11.S15.'
  ),
  PA11a = c(
    'PA11a.O1.',
    'PA11a.S1.',
    'PA11a.S2.',
    'PA11a.S3.',
    'PA11a.S4.',
    'PA11a.S5.',
    'PA11a.S6.',
    'PA11a.S7.',
    'PA11a.S8.',
    'PA11a.S9.',
    'PA11a.S10.'
  ),
  PA11b = c(
    'PA11b.O1.',
    'PA11b.S1.T',
    'PA11b.S1.M',
    'PA11b.S1.F',
    'PA11b.S2.',
    'PA11b.S3.',
    'PA11b.S4.',
    'PA11b.S5.T',
    'PA11b.S5.M',
    'PA11b.S5.F',
    'PA11b.S6.',
    'PA11b.S7.',
    'PA11b.S8.',
    'PA11b.S9.',
    'PA11b.S10.',
    'PA11b.S11.',
    'PA11b.S12.'
  ),
  PA11c = c(
    'PA11c.O1.',
    'PA11c.S1.T',
    'PA11c.S1.M',
    'PA11c.S1.F',
    'PA11c.S2.T',
    'PA11c.S2.M',
    'PA11c.S2.F',
    'PA11c.S3.',
    'PA11c.S4.',
    'PA11c.S5.',
    'PA11c.S6.',
    'PA11c.S7.',
    'PA11c.S8.'
  )
) %>% 
  lapply(\(x) intersect(x,Available_Codes))

selected_PAs_Indicators_Multiline_Header <- function(JAF_KEY_codes)
  JAF_SCORES %>% 
  .[JAF_KEY %in% JAF_KEY_codes] %>% 
  .[, .(JAF_KEY, name, high_is_good,
        reference_name_latest_value, reference_name_change,
        reference_latest_value, reference_change,
        reference_time_latest_value, reference_time_change)] %>% 
  .[, reference_latest_value := round(reference_latest_value,1)] %>% 
  .[, reference_change := round(reference_change,1)] %>%
  .[, lapply(., as.character)] %>%
  merge(data.table(JAF_KEY=JAF_KEY_codes,
                   Main_Indicators_order=seq_along(JAF_KEY_codes)),
        by='JAF_KEY') %>% 
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

selected_PAs_Indicators_Contents <- function(JAF_KEY_codes)
  JAF_SCORES %>% 
  .[, .(geo, JAF_KEY, time, flags_,
        value_latest_value, value_change,
        score_latest_value, score_change,
        reference_time_latest_value, reference_time_change)] %>% 
  merge(data.table(JAF_KEY=JAF_KEY_codes,
                   Main_Indicators_order=seq_along(JAF_KEY_codes)),
        by='JAF_KEY') %>% 
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


# createFolder(paste0(OUTPUT_FOLDER,'/PAs'))
message('\nCreating PA Excel files...')
for (pa_code in names(Selected_PAs_Codes)) {
  message('Starting ',pa_code)
  wb_PA_Indic <-
    openxlsx2::wb_workbook()
  for (indic_type in c('change','latest_value')) {
    Indic_Type <-
      ifelse(indic_type=='change','Changes',
             'Levels')
    cat(Indic_Type,"")
    head. <-
      Selected_PAs_Codes[[pa_code]] %>% 
      selected_PAs_Indicators_Multiline_Header() %>% 
      .[[indic_type]]
    vals. <-
      Selected_PAs_Codes[[pa_code]] %>% 
      selected_PAs_Indicators_Contents() %>% 
      .[[indic_type]]
    wb_PA_Indic <-
      wb_PA_Indic %>%
      wb_add_worksheet(paste(pa_code,'-',Indic_Type)) %>%
      wb_add_data(x=pa_code, dims='A1') %>%
      wb_add_data(x=Indic_Type, dims='B1') %>%
      wb_add_data(x=c(PolicyAreaLabels %>% 
                        .[paste0('PA',PolicyArea)==pa_code, `POLICY AREA`],
                      paste('General Policy Area:',
                            PolicyAreaLabels_General %>% 
                              .[paste0('PA',PolicyArea)==pa_code, `POLICY AREA`])), 
                  dims='A2:A3') %>%
      wb_add_data(x=head.,
                  dims='B5',
                  colNames=FALSE,
                  rowNames=TRUE) %>%
      wb_add_data(x=vals.,
                  dims=paste0('B',5 + nrow(head.))) %>% 
      wb_set_col_widths(cols=1:2,
                        widths=c(13,33)) %>%
      Reduce(init=.,
             x=seq_len(ncol(head.))[-1],
             \(wb.,x)
             wb_add_formula(wb.,
                            x=head.[1,x] %>% 
                              {paste0('=HYPERLINK("[..\\compendium\\Compendium-',
                                      JAF_Compendium_Index_raw[JAF_KEY==., CompendiumNum],
                                      '.xlsx]\'',.,'\'!A1", "Compendium")')},
                            startRow=4,
                            startCol=3+x-2)) %>%
      wb_add_formula(x=vals.$geo %>% 
                       head(-2) %>% # without last two i.e. EU and EA
                       {paste0('=HYPERLINK("..\\Country Profiles\\',.,
                               '\\',pa_code,'_',Indic_Type,'_',.,'.png", "Country profile")')},
                     dims='A10') %>%
      wb_freeze_pane(firstActiveRow=10,firstActiveCol=3) %>%
      wb_add_filter(rows=9, cols=2) %>%
      wb_add_font(dims='A1:B2',
                  bold="bold",
                  size=18) %>%
      wb_add_font(dims=paste0('B5:',int2col(ncol(head.)),'7'),
                  bold="bold",
                  size=12) %>%
      wb_add_font(dims=paste0('A',9+nrow(vals.)-1,':',int2col(ncol(vals.)),9+nrow(vals.)),
                  bold="bold") %>%
      Reduce(init=.,
             x=seq.int(10,10+nrow(vals.),2) %>%
               paste0("A",.,":",int2col(ncol(vals.)+1),.),
             f=\(wb.,x)
             wb_add_fill(wb.,
                         dims=x,
                         color= wb_color(hex="e6f1ff"))) %>%
      Reduce(init=.,
             x=seq.int(3,3+ncol(head.)-3,3),
             f=\(wb.,x)
             Reduce(init=wb.,
                    x=4:7,
                    f=\(wb..,y)
                    wb_merge_cells(wb..,
                                   rows=y,
                                   cols=seq.int(x,x+2)) %>% 
                      wb_add_cell_style(
                        dims=paste0(int2col(x),y,':',int2col(x+2),y),
                        horizontal='center', vertical='center',
                        wrapText = "1"))) %>% 
      Reduce(init=.,
             x=seq.int(3,3+ncol(head.)-3,3) %>%
               {paste0(int2col(.),'5:',int2col(.+2),4+nrow(head.)+nrow(vals.)+1)},
             f=\(wb.,x)
             wb_add_border(wb.,
                           dims=x)) %>%
      wb_add_border(dims=paste0('A5:B',4+nrow(head.)+nrow(vals.)+1)) %>% 
      wb_set_row_heights(rows=6, heights=60) %>% 
      wb_set_col_widths(cols=seq.int(3,3+ncol(head.)-1,3),
                        widths=13.2) %>%
      setZoomInAllSheets(75)
  }
  wb_PA_Indic %>% 
    wb_save(paste0(OUTPUT_FOLDER,
                   paste0('/PAs/',pa_code,'.xlsx')))
  message()
}
message('Done.')