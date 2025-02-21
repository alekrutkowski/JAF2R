

# Functions and constants -------------------------------------------------

sq <- function(...) sQuote(paste0(...),FALSE) # single quote

dq <- function(...) dQuote(paste0(...),FALSE) # double quote

sanitizeForExcel <- function(dt)
  # Otherwise Excel reports a broken file
  dt[, lapply(.SD,
              \(col) if (is.character(col))
                stringi::stri_trans_general(col,"Latin-ASCII") else col)]

JAF_Compendium_Index_raw <-
  JAF_NAMES_DESCRIPTIONS %>%
  .[(for_Compendium), .(Compendium_Number,JAF_KEY)] %>%
  setnames('Compendium_Number','CompendiumNum') %>% 
  # split(by='CompendiumNum') %>% 
  # lapply(order_by_JAF_KEY) %>%  
  # rbindlist()
  order_by_JAF_KEY()

JAF_Compendium_Index <-
  JAF_Compendium_Index_raw %>% 
  merge(JAF_NAMES_DESCRIPTIONS, by='JAF_KEY') %>% 
  
  .[, `Policy Area` := sub("^([^\\.]+)\\..*$", "\\1", JAF_KEY)] %>% 
  .[, Indicator := name] %>% 
  .[, name := NULL] %>% 
  .[, Compendium := 
      paste0("=HYPERLINK(",
             dq("[Compendium-",CompendiumNum,".xlsx]",sq(JAF_KEY),"!A1"),
             ",",
             dq("Compendium - ",CompendiumNum),
             ")")] %>% 
  sanitizeForExcel() %>% 
  # split(by='CompendiumNum') %>% 
  # lapply(order_by_JAF_KEY) %>% 
  # rbindlist() %>% 
  order_by_JAF_KEY() %>% 
  .[, .(JAF_KEY,`Policy Area`,Indicator,Compendium)]

indicTablesForCompendium <- function(JAF_KEY.) {
  selected_dt <-
    JAF_GRAND_TABLE[JAF_KEY==JAF_KEY. & !is.na(value_)] %>% 
    .[, time := as.integer(time)] %>% 
    .[time >= 2000] %>% 
    .[, geo := as.character(geo)]
  col_order <-
    sort(unique(selected_dt$time)) %>% 
    expand.grid(c('value_','flags_'),.) %>% 
    do.call(paste0,.)
  selected_dt %>% 
    dcast(geo ~ time,
          fun.aggregate=identity,
          fill=NA, sep="",
          value.var=c('value_','flags_')) %>% 
    .[, ord. := nchar(geo)] %>% 
    setorder(ord.,geo) %>% 
    .[, ord. := NULL] %>% 
    setcolorder(c('geo',col_order)) %>% 
    list(with_flags = .,
         without_flags =
           .[, !grepl('^flags_',colnames(.)), with=FALSE]) %>% 
    lapply(\(dt) dt %>% 
             # sanitizeForExcel() %>% 
             setnames(colnames(.),
                      colnames(.) %>% sub('^(geo|value_|flags_.+)',"",.)))
}

line_chart_template.xml <-
  readLines("line_chart_template.xml",warn=FALSE) %>% 
  paste(collapse="")

bar_chart_template.xml <-
  readLines("bar_chart_template.xml",warn=FALSE) %>% 
  paste(collapse="")

seriesForLineChartXml <- function(number_of_series) {
  templ <-
    r"(<c:ser>
  <c:idx val="0"/>
  <c:order val="0"/>
  <c:tx>
  <c:strRef>
  <c:f>'PA1.C4.high'!$AY$12</c:f>
  </c:strRef>
  </c:tx>
  <c:spPr>
  <a:ln w="28575" cap="rnd">
  <a:solidFill>
  <a:schemeClr val="accent1"/>
  </a:solidFill>
  <a:round/>
  </a:ln>
  <a:effectLst/>
  </c:spPr>
  <c:marker>
  <c:symbol val="none"/>
  </c:marker>
  <c:cat>
  <c:strRef>
  <c:f>'PA1.C4.high'!$AZ$11:$BV$11</c:f>
  </c:strRef>
  </c:cat>
  <c:val>
  <c:numRef>
  <c:f>'PA1.C4.high'!$AZ$12:$BV$12</c:f>
  </c:numRef>
  </c:val>
  <c:smooth val="0"/>
  <c:extLst>
  <c:ext uri="{C3380CC4-5D6E-409C-BE32-E72D297353CC}" xmlns:c16="http://schemas.microsoft.com/office/drawing/2014/chart">
  <c16:uniqueId val="{00000000-1349-4E51-A7E7-2039255F042E}"/>
  </c:ext>
  </c:extLst>
  </c:ser>)"
  seq.int(0,number_of_series-1) %>% 
    sapply(\(num) templ %>% 
             kit::nif(num>=6,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="60000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=12,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="80000"/><a:lumOff val="20000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=18,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="80000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=24,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="60000"/><a:lumOff val="40000"/></a:schemeClr>',.,fixed=TRUE),
                      default=.) %>% 
             sub('val="{00000000',paste0('val="{',sprintf("%08X",num)),.,fixed=TRUE) %>% 
             sub('<c:idx val="0"/>',paste0('<c:idx val="',num,'"/>'),.,fixed=TRUE) %>% 
             sub('<c:order val="0"/>',paste0('<c:order val="',num,'"/>'),.,fixed=TRUE) %>% 
             sub('val="accent1"',paste0('val="accent',num%%6 + 1,'"'),.,fixed=TRUE) %>% 
             gsub('$12',paste0('$',num+12),.,fixed=TRUE)) %>% 
    paste(collapse="")
}

lineChartXml <- function(JAF_KEY.,
                         num_of_cols_with_flags, num_of_cols_without_flags,
                         num_of_rows)
  line_chart_template.xml %>% 
  sub('<!-- ###### Generated series to be pasted here ###### -->',
      seriesForLineChartXml(num_of_rows),.,fixed=TRUE) %>% 
  gsub('PA1.C4.high',escapeSpecialXmlChars(JAF_KEY.),.,fixed=TRUE) %>% 
  gsub("'!$AY",paste0("'!$",int2col(num_of_cols_with_flags+4)),.,fixed=TRUE) %>% 
  gsub("'!$AZ",paste0("'!$",int2col(num_of_cols_with_flags+5)),.,fixed=TRUE) %>% 
  gsub(":$BV$",paste0(":$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE) %>% 
  gsub(":$BV$",paste0(":$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE)

barChartXml <- function(JAF_KEY.,
                        num_of_cols_with_flags, num_of_cols_without_flags,
                        num_of_rows,
                        n_years_before=5)
  bar_chart_template.xml %>% 
  gsub('PA1.C4.high',escapeSpecialXmlChars(JAF_KEY.),.,fixed=TRUE) %>% 
  gsub("$AY$",paste0("$",int2col(num_of_cols_with_flags+4),'$'),.,fixed=TRUE) %>% 
  gsub("$BQ$",paste0("$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags-n_years_before),"$"),.,fixed=TRUE) %>% 
  gsub("$BV$",paste0("$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE) %>% 
  gsub('$40<',paste0('$',num_of_rows+11,'<'),.,fixed=TRUE)

escapeSpecialXmlChars <- function(charvec)
  charvec %>% 
  sub('&','&amp;',.,fixed=TRUE) %>%
  sub('"','&quot;',.,fixed=TRUE) %>% 
  sub("'",'&apos;',.,fixed=TRUE) %>% 
  sub('<','&lt;',.,fixed=TRUE) %>% 
  sub('>','&gt;',.,fixed=TRUE)
  


# Actions -----------------------------------------------------------------

message('\nCreating Compendium files...')

createFolder(paste0(OUTPUT_FOLDER,'/JAF Compendium'))

message('Creating Index.xlsx...')
openxlsx2::wb_workbook() %>%
  wb_add_worksheet('Index') %>%
  wb_add_data(dims='C1',
              x='Index Compendium') %>%
  wb_add_font(dims='C1',
              bold="bold",
              size=18) %>%
  wb_add_data(start_row=2,
              x=JAF_Compendium_Index %>%
                .[, !'Compendium', with=FALSE]) %>%
  wb_add_formula(x=JAF_Compendium_Index$Compendium,
                 start_col=ncol(JAF_Compendium_Index),
                 start_row=3) %>%
  wb_add_data(x='Link to the file and worksheet',
              start_col=ncol(JAF_Compendium_Index),
              start_row=2) %>%
  wb_freeze_pane(firstActiveRow=3) %>%
  wb_add_font(dims=paste0('A2:',int2col(ncol(JAF_Compendium_Index)),'2'),
              bold="bold",
              size=12) %>%
  wb_set_col_widths(cols=seq_along(JAF_Compendium_Index),
                    widths="auto") %>%
  wb_set_col_widths(cols=3,
                    widths=70) %>%
  {for (ws in .$worksheets)
    ws$sheetViews <- set_zoom(75, ws$sheetViews); .} %>%
  wb_save(paste0(OUTPUT_FOLDER,'/JAF Compendium/Index.xlsx'))
message('Done.')

for (CompendiumNum. in unique(JAF_Compendium_Index_raw$CompendiumNum)) {
  message('\nCreating Compendium-',CompendiumNum.,'.xlsx...')
  wb <-
    openxlsx2::wb_workbook()
  for (JAF_KEY. in
       JAF_Compendium_Index_raw[CompendiumNum==CompendiumNum., JAF_KEY] %>%
       intersect(unique(JAF_GRAND_TABLE$JAF_KEY))) { # to make sure that the indicator is in the JAF_GRAND_TABLE
    cat(JAF_KEY.," ")
    PA <-
      JAF_Compendium_Index[JAF_KEY==JAF_KEY., `Policy Area`]
    list_of_dts <-
      indicTablesForCompendium(JAF_KEY.)
    wb <-
      wb %>%
      wb_add_worksheet(JAF_KEY.) %>%
      wb_add_formula(JAF_KEY.,
                     r"{=HYPERLINK("[Index.xlsx]'Index'!A1","Back to index")}") %>%
      `if`(JAF_KEY.=='PA8.2.C3.',
           wb_add_data(., JAF_KEY.,
                       'The 2007 AES was a large sample pilot exercise carried out on a voluntary basis in all Member States, except Ireland and Luxembourg, between 2005 and 2008. On this basis, adjustments were implemented in the next wave. As from 2011, the AES is underpinned by a European legal act and thus carried out in all Member States on a mandatory basis.',
                       dims='D5'),
           .) %>% 
      wb_add_data(JAF_KEY.,
                  PA,
                  dims='A3') %>%
      wb_add_data(JAF_KEY.,
                  PolicyAreaLabels_General %>% 
                    copy %>% 
                    .[,PolicyArea := sub("^(\\d+).*$", "\\1", PolicyArea)] %>% # extract only the integer PA
                    .[!duplicated(.)] %>% 
                    .[paste0('PA',PolicyArea)==PA, `POLICY AREA`],
                  dim='B3') %>%
      wb_add_data(JAF_KEY.,
                  JAF_INDICATORS[[JAF_KEY.]]$name %>% stringi::stri_trans_general("Latin-ASCII"),
                  dim='B5') %>%
      wb_add_data(JAF_KEY.,
                  JAF_INDICATORS[[JAF_KEY.]]$unit %>% stringi::stri_trans_general("Latin-ASCII"),
                  dim='B6') %>%
      wb_add_data(JAF_KEY.,
                  paste('Source: ',JAF_INDICATORS[[JAF_KEY.]]$source %>% stringi::stri_trans_general("Latin-ASCII")),
                  dim='B7') %>%
      wb_add_data(JAF_KEY.,
                  'Table with flags -- For the table without flags scroll to the right =>',
                  start_col=3, start_row=10) %>%
      wb_add_data(JAF_KEY.,
                  list_of_dts$with_flags,
                  start_col=2, start_row=11) %>%
      wb_add_data(JAF_KEY.,
                  'Table without flags',
                  start_col=5+ncol(list_of_dts$with_flags), start_row=10) %>%
      wb_add_data(JAF_KEY.,
                  list_of_dts$without_flags,
                  start_col=4+ncol(list_of_dts$with_flags), start_row=11) %>%
      wb_add_filter(JAF_KEY., rows=11, cols=2) %>%
      wb_add_data(JAF_KEY.,
                  'Use the filter in cell B11 to see only one or more selected coutries in the charts below.',
                  start_col=3, start_row=42+nrow(list_of_dts$with_flags)-29) %>%
      wb_add_chart_xml(JAF_KEY.,
                       dims=paste0('C',
                                   44+nrow(list_of_dts$with_flags)-29),
                       lineChartXml(JAF_KEY.,ncol(list_of_dts$with_flags),ncol(list_of_dts$without_flags),
                                    nrow(list_of_dts$with_flags))) %>%
      wb_add_chart_xml(JAF_KEY.,
                       dims=paste0('C',
                                   78+nrow(list_of_dts$with_flags)-29),
                       barChartXml(JAF_KEY.,ncol(list_of_dts$with_flags),ncol(list_of_dts$without_flags),
                                   nrow(list_of_dts$with_flags))) %>%
      Reduce(init=.,
             x=c('A3','B3','B5','B6','C42'),
             f=\(wb,x) wb_add_font(wb, JAF_KEY.,
                                   dims=x,
                                   bold="bold",
                                   size=13)) %>%
      wb_set_col_widths(JAF_KEY.,
                        cols=2,
                        widths="auto") %>%
      wb_add_fill(JAF_KEY.,
                  every_nth_row = 2,
                  dims = paste0("B12:",
                                int2col(ncol(list_of_dts$with_flags)+1),
                                12+nrow(list_of_dts$with_flags)),
                  color = wb_color(hex = "f2f2f2")) %>%
      wb_add_fill(JAF_KEY.,
                  every_nth_row = 2,
                  dims = paste0(int2col(ncol(list_of_dts$with_flags)+4),"12:",
                                int2col(ncol(list_of_dts$without_flags)+ncol(list_of_dts$with_flags)+3),
                                12+nrow(list_of_dts$without_flags)),
                  color = wb_color(hex = "e6f1ff")) %>%
      wb_freeze_pane(JAF_KEY., firstActiveCol=3, firstActiveRow=10) %>%
      wb_set_row_heights(JAF_KEY.,
                         rows=c(2,4,8,9),
                         heights=3)
    
  }
  for (ws in wb$worksheets)
    ws$sheetViews <- set_zoom(65, ws$sheetViews)
  message('\nSaving...')
  wb %>%
    # wb_set_sheet_names(wb_get_sheet_names(.),
    #                    wb_get_sheet_names(.) %>% escapeSpecialXmlChars()) %>%
    wb_save(paste0(OUTPUT_FOLDER,
                   '/JAF Compendium/Compendium-',CompendiumNum.,'.xlsx'))
  message('Compendium-',CompendiumNum.,'.xlsx saved.')
}
