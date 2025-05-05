library(magrittr)
library(data.table)
library(openxlsx2)


# Functions and constants -------------------------------------------------

PolicyAreaLabels <- '
| PolicyArea | POLICY AREA                                                                                               |
|------------|-----------------------------------------------------------------------------------------------------------|
| 1          | Increase overall employment                                                                               |
| 1b         | Improve labour market situation of youth                                                                  |
| 1c         | Increase employment of older workers                                                                      |
| 1d         | Increase employment of migrants                                                                           |
| 1e         | Disability employment gap                                                                                 |
| 2a         | Combating segmentation                                                                                    |
| 2b         | Labour market fluidity                                                                                    |
| 3          | Active labour market policies                                                                             |
| 4.1        | Adequate social security systems                                                                          |
| 4.2        | Make work pay                                                                                             |
| 5          | Work-life balance                                                                                         |
| 6a         | Exploiting job creation possibilities                                                                     |
| 6b         | Demand creation                                                                                           |
| 7.1        | Gender employment gap                                                                                     |
| 7.2        | Gender pay gap                                                                                            |
| 8.1        | Improving skills supply and productivity, lifelong learning                                               |
| 8.2        | Lifelong learning                                                                                         |
| 9.1        | Improving education and training systems                                                                  |
| 9.2        | Improving higher education                                                                                |
| 10         | Wage setting mechanisms and labour cost developments                                                      |
| 11         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty - total population |
| 11a        | Tackling child poverty and exclusion                                                                      |
| 11b        | Tackling poverty and exclusion in working age - active inclusion                                          |
| 11c        | Tackling old age poverty and exclusion                                                                    |
| 11d        | Inequality and inequality of opportunity                                                                  |
| 11e        | Access to quality social services and benefits                                                            |
| 11f1       | Focus on poverty and exclusion of disadvantaged groups - people with disabilities                         |
| 11f2       | Focus on poverty and exclusion of disadvantaged groups - migrants                                         |
| 11f3       | Focus on poverty and exclusion of disadvantaged groups - low-skilled people                               |
| 11f4       | Focus on poverty and exclusion of disadvantaged groups - (quasi-)jobless households                       |
| 11f5       | Focus on poverty and exclusion of disadvantaged groups - youth                                            |
| 14b        | Social fairness and distributional aspects of the green transition                                        |
| 15b        | Social fairness and distributional aspects of the digital transition                                      |
' %>% 
  readMarkDownTable()

PolicyAreaLabels_General <- '
| PolicyArea  | POLICY AREA                                                                            |
|-------------|----------------------------------------------------------------------------------------|
| 1           | Increase labour market participation                                                   |
| 1b          | Increase labour market participation                                                   |
| 1c          | Increase labour market participation                                                   |
| 1d          | Increase labour market participation                                                   |
| 1e          | Increase labour market participation                                                   |
| 2a          | Enhancing labour market functioning                                                    |
| 2b          | Enhancing labour market functioning                                                    |
| 3           | Active labour market policies                                                          |
| 4.1         | Adequate and employment oriented social security systems                               |
| 4.2         | Adequate and employment oriented social security systems                               |
| 5           | Work-life balance                                                                      |
| 6a          | Exploiting job creation possibilities                                                  |
| 6b          | Exploiting job creation possibilities                                                  |
| 7.1         | Gender equality                                                                        |
| 7.2         | Gender equality                                                                        |
| 8.1         | Improving skills supply and productivity, effective life-long learning                 |
| 8.2         | Improving skills supply and productivity, effective life-long learning                 |
| 9.1         | Improving education and training systems                                               |
| 9.2         | Improving education and training systems                                               |
| 10          | Wage setting mechanisms and labour cost developments                                   |
| 11          | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11a         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11b         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11c         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11d         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11e         | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11f1        | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11f2        | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11f3        | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11f4        | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 11f5        | Promoting equal opportunities for all, fostering social inclusion and fighting poverty |
| 14b         | Social fairness and distributional aspects of the green transition                     |
| 15b         | Social fairness and distributional aspects of the digital transition                   |
' %>% 
  readMarkDownTable()

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
  order_by_JAF_KEY()

JAF_Compendium_Index <-
  JAF_Compendium_Index_raw %>% 
  merge(JAF_NAMES_DESCRIPTIONS, by='JAF_KEY') %>% 
  
  .[, `Policy Area` := sub("^([^\\.]+)\\..*$", "\\1", JAF_KEY)] %>% 
  .[, Indicator := name] %>% 
  .[, name := NULL] %>% 
  .[, Compendium := 
      paste0("=HYPERLINK(",
             dq("[..\\JAF Compendium\\Compendium-",CompendiumNum,".xlsx]",sq(JAF_KEY),"!A1"),
             ",",
             dq("Compendium - ",CompendiumNum),
             ")")] %>% 
  sanitizeForExcel() %>% 
  order_by_JAF_KEY() %>% 
  .[, .(JAF_KEY,`Policy Area`,Indicator,Compendium)]

getCompendiumLinkColumn <- function(dt)
  copy(dt) %>% 
  .[, row_order := .I] %>% 
  merge(JAF_Compendium_Index, by.x='Indicator', by.y='JAF_KEY') %>% 
  setorder(row_order) %>% 
  .$Compendium

IndicsSelectedForKEC <- 
  JAF_NAMES_DESCRIPTIONS %>%
  .[!(JAF_KEY %>% `JAF_KEY->C_O_S_part` %>% grepl('C',.))] %>% 
  .[(for_KEC), JAF_KEY] %>%
  sort_JAF_KEY() %>% 
  data.table(`#`=seq_along(.), JAF_KEY=.)

countrySheet <- function(geo_code, all_geos=FALSE)
  JAF_SCORES %>% 
  .[geo %in% geo_code] %>% 
  merge(IndicsSelectedForKEC, by='JAF_KEY') %>% 
  merge(PolicyAreaLabels, by='PolicyArea') %>% 
  {data.table(row_order = .$`#`,
              Country = if (all_geos) .$geo,
              `POLICY AREA` = .$`POLICY AREA`,
              Indicator = .$JAF_KEY,
              Description = .$Description %>% stringi::stri_trans_general("Latin-ASCII"), # stri_trans_general needed to sanitize, otherwise Excel reports broken file
              Levels = .$score_category_latest_value,
              Changes = .$score_category_change,
              Flags = .$flags_,
              ` ` = "", # blank separator column
              Level = round(.$value_latest_value,2),
              Change = round(.$value_change,2),
              `Score level` = round(.$score_latest_value,1),
              `Score change` = round(.$score_change,1),
              Year = .$time)} %>% 
  {`if`(all_geos, setorder(.,Country,row_order), setorder(.,row_order))} %>% 
  .[, row_order := NULL] %>% 
  .[, `POLICY AREA` := `POLICY AREA` %>% 
      ifelse(!all_geos & duplicated(.),"",.)]

countrySheet_add <- function(geo_code, all_geos=FALSE)
  JAF_SCORES %>% 
  .[geo %in% geo_code] %>% 
  merge(IndicsSelectedForKEC, by='JAF_KEY') %>% 
  merge(PolicyAreaLabels, by='PolicyArea') %>% 
  {data.table(row_order = .$`#`,
              Country = if (all_geos) .$geo,
              `POLICY AREA` = .$`POLICY AREA`,
              Indicator = .$JAF_KEY,
              Description = .$Description %>% stringi::stri_trans_general("Latin-ASCII"), # stri_trans_general needed to sanitize, otherwise Excel reports broken file
              `Employment/Social challenges` = 
                ifelse(.$QuantAssessmentGood,"",.$`Quantitative assessment`),
              `Good labour market/social outcomes` = 
                ifelse(.$QuantAssessmentGood,.$`Quantitative assessment`,""),
              Levels = .$score_category_latest_value,
              Changes = .$score_category_change,
              Flags = .$flags_,
              ` ` = "", # blank separator column
              Level = round(.$value_latest_value,2),
              Change = round(.$value_change,2),
              `Score level` = round(.$score_latest_value,1),
              `Score change` = round(.$score_change,1),
              Year = .$time)} %>% 
  {`if`(all_geos, setorder(.,Country,row_order), setorder(.,row_order))} %>% 
  .[, row_order := NULL] %>% 
  .[, `POLICY AREA` := `POLICY AREA` %>% 
      ifelse(!all_geos & duplicated(.),"",.)]

set_zoom <- function(x, sheet_views) # from https://stackoverflow.com/a/74239871
  gsub('(?<=zoomScale=")[0-9]+', x,
       sheet_views, perl=TRUE)

plainInlineXLString <- function(txt)
  paste0('<r><t xml:space="preserve">',txt,'</t></r>')

boldInlineXLString <- function(txt)
  paste0('<r><rPr><b/></rPr><t xml:space="preserve">',txt,'</t></r>')


# Actions -----------------------------------------------------------------

message('\nCreating KEC files...')

createFolder(paste0(OUTPUT_FOLDER,'/KEC'))

KEC_wb <-
  openxlsx2::wb_workbook()
KEC_wb$add_worksheet('Info')
KEC_wb$add_data(sheet='Info',
                x=paste0(plainInlineXLString('Classification used in the '),
                         boldInlineXLString('Employment/Social challenges'),
                         plainInlineXLString(' and&#10;'), # &#10; = line break
                         boldInlineXLString('Good labour market/social outcomes'),
                         plainInlineXLString(' columns in '),
                         boldInlineXLString('..._add'),
                         plainInlineXLString(' worksheets:')), 
                inline_strings=TRUE)
KEC_wb$add_cell_style(sheet='Info', wrap_text=TRUE,)
KEC_wb$add_data(sheet='Info',
                start_row=2,
                x=QuantAssessmentLabels %>% 
                  .[,.(`Quantitative assessment`,QuantAssessmentGood)] %>% 
                  .[, `Good or bad?` := ifelse(QuantAssessmentGood,'+ Good','\u2212 Bad')] %>% 
                  .[,.(`Quantitative assessment`,`Good or bad?`)])
KEC_wb$set_col_widths(sheet='Info',
                      cols=1:2,
                      widths=c(63,12))
KEC_wb$add_fill(sheet='Info',
                color=wb_color(hex='#FFFF00'),
                dims=paste0('A2:B',2+nrow(QuantAssessmentLabels)))

for (geo_code in EU_Members_geo_codes) {
  cat(geo_code,"")
  for (dim2 in c("",'_add')) {
    dta <-
      get(paste0('countrySheet',dim2))(geo_code) %>%
      .[, lapply(.,. %>% `if`(is.character(.),ifelse(is.na(.),"",.),.))]
    sheet_name <-
      paste0(geo_code,dim2)
    KEC_wb$add_worksheet(sheet_name)
    KEC_wb$add_data(sheet=sheet_name,
                    dims='B1',
                    x=EU_Members_geo_names[geo==geo_code]$geo_labels)
    KEC_wb$add_data(sheet=sheet_name,
                    start_row=4,
                    x=dta)
    KEC_wb$freeze_pane(sheet=sheet_name,
                       firstActiveRow=5)
    KEC_wb$add_fill(sheet=sheet_name,
                    dims=paste0('A4:',int2col(ncol(dta)),'4'),
                    color=wb_color(hex='#e7e6e6'))
    KEC_wb$add_font(sheet=sheet_name,
                    dims='B1',
                    bold=TRUE,
                    size=18,
                    color=wb_color(hex='#4472c4'))
    KEC_wb$add_font(sheet=sheet_name,
                    dims=paste0('A4:',int2col(ncol(dta)),'4'),
                    bold=TRUE)
    KEC_wb$set_col_widths(sheet=sheet_name,
                          cols=seq_along(colnames(dta)),
                          widths="auto")
    KEC_wb$set_col_widths(sheet=sheet_name,
                          cols=c(1,3),
                          widths=70)
    KEC_wb$set_col_widths(sheet=sheet_name,
                          cols=ncol(dta),
                          widths=5)
    if (dim2=='_add')
      KEC_wb$set_col_widths(sheet=sheet_name,
                            cols=c(4,5),
                            widths=50)
    KEC_wb$add_data(sheet=sheet_name,
                    start_row=4, start_col=ncol(dta)+1, col_names=FALSE,
                    x='Compendium')
    KEC_wb$add_formula(sheet=sheet_name,
                       start_row=5, start_col=ncol(dta)+1,
                       x=getCompendiumLinkColumn(dta))
  }
}
for (ws in KEC_wb$worksheets %>% tail(-1))
  ws$sheetViews <- set_zoom(75, ws$sheetViews)
wb_save(KEC_wb,paste0(OUTPUT_FOLDER,'/KEC/Key Employment Challenges and Good Outcomes.xlsx'))
message('\nDone `Key Employment Challenges and Good Outcomes.xlsx`')


### Extra KEC file
KEC_wb <-
  openxlsx2::wb_workbook()
KEC_wb$add_worksheet('Info')
KEC_wb$add_data(sheet='Info',
                x=paste0(plainInlineXLString('Classification used in the '),
                         boldInlineXLString('Employment/Social challenges'),
                         plainInlineXLString(' and&#10;'), # &#10; = line break
                         boldInlineXLString('Good labour market/social outcomes'),
                         plainInlineXLString(' columns:'),
                inline_strings=TRUE))
KEC_wb$add_cell_style(sheet='Info', wrap_text=TRUE,)
KEC_wb$add_data(sheet='Info',
                start_row=2,
                x=QuantAssessmentLabels %>%
                  .[,.(`Quantitative assessment`,QuantAssessmentGood)] %>%
                  .[, `Good or bad?` := ifelse(QuantAssessmentGood,'+ Good','\u2212 Bad')] %>%
                  .[,.(`Quantitative assessment`,`Good or bad?`)])
KEC_wb$set_col_widths(sheet='Info',
                      cols=1:2,
                      widths=c(63,12))
KEC_wb$add_fill(sheet='Info',
                color=wb_color(hex='#FFFF00'),
                dims=paste0('A2:B',2+nrow(QuantAssessmentLabels)))

dta <-
  countrySheet_add(EU_Members_geo_codes, all_geos=TRUE) %>%
  .[, lapply(.,. %>% `if`(is.character(.),ifelse(is.na(.),"",.),.))]
sheet_name <-
  'All countries'
KEC_wb$add_worksheet(sheet_name)
KEC_wb$add_data(sheet=sheet_name,
                start_row=1,
                x=dta)
KEC_wb$freeze_pane(sheet=sheet_name,
                   firstActiveRow=2)
KEC_wb$add_fill(sheet=sheet_name,
                dims=paste0('A1:',int2col(ncol(dta)),'1'),
                color=wb_color(hex='#e7e6e6'))
KEC_wb$add_font(sheet=sheet_name,
                dims=paste0('A1:',int2col(ncol(dta)),'1'),
                bold=TRUE)
KEC_wb$set_col_widths(sheet=sheet_name,
                      cols=seq_along(colnames(dta)),
                      widths="auto")
KEC_wb$set_col_widths(sheet=sheet_name,
                      cols=c(2,4),
                      widths=70)
KEC_wb$set_col_widths(sheet=sheet_name,
                      cols=5:6,
                      widths=50)
KEC_wb$set_col_widths(sheet=sheet_name,
                      cols=c(1,7,8,14),
                      widths=10)
KEC_wb$add_filter(sheet=sheet_name, rows=1, cols=1:8)
KEC_wb$add_data(sheet=sheet_name,
                start_row=1, start_col=ncol(dta)+1, col_names=FALSE,
                x='Compendium')
KEC_wb$add_formula(sheet=sheet_name,
                   start_row=2, start_col=ncol(dta)+1,
                   x=getCompendiumLinkColumn(dta))
for (ws in KEC_wb$worksheets %>% tail(-1))
  ws$sheetViews <- set_zoom(75, ws$sheetViews)
wb_save(KEC_wb,paste0(OUTPUT_FOLDER,'/KEC/Key Employment Challenges and Good Outcomes - single sheet.xlsx'))
message('Done `Key Employment Challenges and Good Outcomes - single sheet.xlsx`')

