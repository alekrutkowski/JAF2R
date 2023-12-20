library(magrittr)
library(data.table)
library(openxlsx2)


# Functions and constants -------------------------------------------------

PolicyAreaLabels <- '
| PolicyArea | POLICY AREA                                                                                                                                    |
|------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| 1          | Increase overall employment                                                                                                                    |
| 1b         | Improve labour market situation of youth                                                                                                       |
| 1c         | Increase employment of older workers                                                                                                           |
| 1d         | Increase employment of migrants                                                                                                                |
| 2a         | Combating segmentation                                                                                                                         |
| 2b         | Labour market fluidity                                                                                                                         |
| 3          | Active labour market policies                                                                                                                  |
| 4.1        | Adequate social security systems                                                                                                               |
| 4.2        | Make work pay                                                                                                                                  |
| 5          | Work-life balance                                                                                                                              |
| 6a         | Exploiting job creation possibilities                                                                                                          |
| 6b         | Demand creation                                                                                                                                |
| 7.1        | Gender employment gap                                                                                                                          |
| 7.2        | Gender pay gap                                                                                                                                 |
| 8.1        | Improving skills supply and productivity, lifelong learning                                                                                    |
| 8.2        | Lifelong learning                                                                                                                              |
| 9.1        | Improving education and training systems                                                                                                       |
| 9.2        | Improving higher education                                                                                                                     |
| 10         | Wage setting mechanisms and labour cost developments                                                                                           |
| 11         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services |
| 11a        | Breaking the intergenerational transmission of poverty \u2013 tackling child poverty                                                           |
| 11b        | Active inclusion \u2013 tackling poverty in working age                                                                                        |
| 11c        | Elderly poverty                                                                                                                                |
' %>% 
  readMarkDownTable()

PolicyAreaLabels_General <- '
| PolicyArea  | POLICY AREA                                                                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| 1           | Increase labour market participation                                                                                                            |
| 1b          | Increase labour market participation                                                                                                            |
| 1c          | Increase labour market participation                                                                                                            |
| 1d          | Increase labour market participation                                                                                                            |
| 2a          | Enhancing labour market functioning                                                                                                             |
| 2b          | Enhancing labour market functioning                                                                                                             |
| 3           | Active labour market policies                                                                                                                   |
| 4.1         | Adequate and employment oriented social security systems                                                                                        |
| 4.2         | Adequate and employment oriented social security systems                                                                                        |
| 5           | Work-life balance                                                                                                                               |
| 6a          | Exploiting job creation possibilities                                                                                                           |
| 6b          | Exploiting job creation possibilities                                                                                                           |
| 7.1         | Gender equality                                                                                                                                 |
| 7.2         | Gender equality                                                                                                                                 |
| 8.1         | Improving skills supply and productivity, effective life-long learning                                                                          |
| 8.2         | Improving skills supply and productivity, effective life-long learning                                                                          |
| 9.1         | Improving education and training systems                                                                                                        |
| 9.2         | Improving education and training systems                                                                                                        |
| 10          | Wage setting mechanisms and labour cost developments                                                                                            |
| 11          | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11a         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11b         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11c         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
' %>% 
  readMarkDownTable()

IndicsSelectedForKEC <- 
  JAF_NAMES_DESCRIPTIONS %>%
  .[(for_KEC), JAF_KEY] %>%
  sort_JAF_KEY() %>% 
  data.table(`#`=seq_along(.), JAF_KEY=.)

countrySheet <- function(geo_code)
  JAF_SCORES %>% 
  .[geo==geo_code] %>% 
  merge(IndicsSelectedForKEC, by='JAF_KEY') %>% 
  merge(PolicyAreaLabels, by='PolicyArea') %>% 
  {data.table(row_order = .$`#`,
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
  setorder(row_order) %>% 
  .[,row_order := NULL] %>% 
  .[, `POLICY AREA` := `POLICY AREA` %>% 
      ifelse(duplicated(.),"",.)]

countrySheet_add <- function(geo_code)
  JAF_SCORES %>% 
  .[geo==geo_code] %>% 
  merge(IndicsSelectedForKEC, by='JAF_KEY') %>% 
  merge(PolicyAreaLabels, by='PolicyArea') %>% 
  {data.table(row_order = .$`#`,
              `POLICY AREA` = .$`POLICY AREA`,
              Indicator = .$JAF_KEY,
              Description = .$Description %>% stringi::stri_trans_general("Latin-ASCII"), # stri_trans_general needed to sanitize, otherwise Excel reports broken file
              `Employment/Social challenges` = 
                ifelse(.$QuantAssessmentGood,"",.$`Quantitative assessment`),
              `Good labour market/social outcomes` = 
                ifelse(.$QuantAssessmentGood,.$`Quantitative assessment`,""),
              Changes = .$score_category_change,
              Flags = .$flags_,
              ` ` = "", # blank separator column
              Level = round(.$value_latest_value,2),
              Change = round(.$value_change,2),
              `Score level` = round(.$score_latest_value,1),
              `Score change` = round(.$score_change,1),
              Year = .$time)} %>% 
  setorder(row_order) %>% 
  .[,row_order := NULL] %>% 
  .[, `POLICY AREA` := `POLICY AREA` %>% 
      ifelse(duplicated(.),"",.)]

set_zoom <- function(x, sheet_views) # from https://stackoverflow.com/a/74239871
  gsub('(?<=zoomScale=")[0-9]+', x,
       sheet_views, perl=TRUE)


# Actions -----------------------------------------------------------------

message('\nCreating KEC.xlsx...')

createFolder(paste0(OUTPUT_FOLDER,'/KEC'))

KEC_wb <-
  openxlsx2::wb_workbook()

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
                    startRow=4,
                    x=dta)
    KEC_wb$freeze_pane(sheet=sheet_name,
                       firstActiveRow=5)
    KEC_wb$add_fill(sheet=sheet_name,
                    dims=paste0('A4:',int2col(ncol(dta)),'4'),
                    color=wb_color(hex='e7e6e6'))
    KEC_wb$add_font(sheet=sheet_name,
                    dims='B1',
                    bold="bold",
                    size=18,
                    color=wb_color(hex='4472c4'))
    KEC_wb$add_font(sheet=sheet_name,
                    dims=paste0('A4:',int2col(ncol(dta)),'4'),
                    bold="bold")
    KEC_wb$set_col_widths(sheet=sheet_name,
                          cols=seq_along(colnames(dta)),
                          widths="auto")
    KEC_wb$set_col_widths(sheet=sheet_name,
                          cols=c(1,3),
                          widths=70)
    if (dim2=='_add')
      KEC_wb$set_col_widths(sheet=sheet_name,
                            cols=3:4,
                            widths=50)
  }
}
for (ws in KEC_wb$worksheets)
  ws$sheetViews <- set_zoom(75, ws$sheetViews)
wb_save(KEC_wb,paste0(OUTPUT_FOLDER,'/KEC/KEC.xlsx'))
message('\nDone.')
