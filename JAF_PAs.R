
# Functions and constants -------------------------------------------------

Available_Codes <-
  unique(JAF_GRAND_TABLE$JAF_KEY)

sort_PAs <- function(pa_codes)
  pa_codes %>% 
  data.table(num=as.numeric(gsub('[^0-9.]',"",.)) %>% 
               ifelse(.>=100,floor(./10),.),# so that codes like PA11f1 don't become 111
             str=.) %>% 
  .[order(num,str)] %>% 
  .$str

Selected_PAs_Codes <- 
  JAF_NAMES_DESCRIPTIONS %>%
  .[(for_KEC), JAF_KEY] %>%
  data.table(JAF_KEY=.,
             PA = paste0('PA',`JAF_KEY->PA_string`(.))) %>% 
  # .[order(PA,sort_JAF_KEY(JAF_KEY))] %>% 
  split(by='PA',keep.by=FALSE) %>%
  lapply(\(dt)dt[[1]]) %>% 
  .[names(.) %>% sort_PAs()] %>% 
  c(list(PA1_popweighted = 
           IndicatorsWithPopulationWeigths$JAF_KEY %>% 
           paste0('_popweighted_score')),
    .) %>% 
  lapply(sort_JAF_KEY)

selected_PAs_Indicators_Multiline_Header <- function(JAF_KEY_codes)
  JAF_SCORES %>% 
  .[JAF_KEY %in% JAF_KEY_codes] %>% 
  .[, .(JAF_KEY, name, high_is_good,
        reference_name_latest_value, reference_name_change,
        reference_latest_value, reference_change,
        reference_time_latest_value, reference_time_change)] %>% 
  .[, grep('^reference_',colnames(.),value=TRUE) := 
      mget(grep('^reference_',colnames(.),value=TRUE)) %>% 
      lapply(. %>% .[!is.na(.)] %>% unique() %>% 
               `if`(length(.)>1,
                    stop('\nMore than 1 unique values:\n',paste(.,collapse='\n')),
                    .))
    , by=JAF_KEY] %>% 
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

createFolder(paste0(OUTPUT_FOLDER,'/Policy Areas'))
message('\nCreating PA Excel files...')
for (pa_code in names(Selected_PAs_Codes)) {
  message('Starting ',pa_code,'...')
  wb_PA_Indic <-
    openxlsx2::wb_workbook()
  for (indic_type in c('latest_value','change')) {
    Indic_Type <-
      ifelse(indic_type=='change','Changes',
             'Levels')
    cat(Indic_Type,"")
    vals. <-
      Selected_PAs_Codes[[pa_code]] %>%
      selected_PAs_Indicators_Contents() %>%
      .[[indic_type]]
    head. <-
      Selected_PAs_Codes[[pa_code]] %>%
      selected_PAs_Indicators_Multiline_Header() %>%
      .[[indic_type]]
    if (ncol(head.)+1 != ncol(vals.)) # +1 because head. row names are to be used as the first column
      stop("\nThe number of header columns (",ncol(head.)+1,
           ") doesn't equal the number of data columns (",ncol(vals.),")!")
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
                            start_row=4,
                            start_col=3+x-2)) %>%
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
      wb_add_fill(every_nth_row = 2,
                  dims=paste0("A10:",int2col(ncol(vals.)+1),9+nrow(vals.)),
                  color= wb_color(hex="e6f1ff")) %>%
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
  message('\nSaving...')
  wb_PA_Indic %>%
    wb_save(paste0(OUTPUT_FOLDER,
                   paste0('/Policy Areas/',pa_code,'.xlsx')))
}
message('Done.')
