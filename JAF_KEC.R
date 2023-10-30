library(magrittr)
library(data.table)
library(openxlsx2)


# Functions and constants -------------------------------------------------

PolicyAreaLabels <- '
| PolicyArea  | POLICY AREA                                                                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| 1           | Increase labour market participation                                                                                                            |
| 1b          | Increase labour market participation                                                                                                            |
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

IndicsSelectedForKEC <- '
| #    | JAF_KEY               |
|------|-----------------------|
| 1    | PA1.O1.               |
| 2    | PA1.S1.M              |
| 3    | PA1.S1.F              |
| 4    | PA1.S2.               |
| 5    | PA1.S3.               |
| 6    | PA1.S4.               |
| 7    | PA1.S5.               |
| 8    | PA1.C3.T              |
| 9    | PA1.C4.T              |
| 10   | PA1.O2.               |
| 11   | PA1b.O1.              |
| 12   | PA1b.O1.n.            |
| 13   | PA1b.S1.M             |
| 14   | PA1b.S1.F             |
| 15   | PA1b.S2.              |
| 16   | PA1b.S3.              |
| 17   | PA1b.S4.              |
| 18   | PA1b.S5.              |
| 19   | PA1b.S6.              |
| 20   | PA1b.S1.n.M           |
| 21   | PA1b.S1.n.F           |
| 22   | PA1b.S5.n.            |
| 23   | PA1b.S6.n.            |
| 24   | PA1c.O1.              |
| 25   | PA1c.S1.Y55_59        |
| 26   | PA1c.S1.Y60-64        |
| 27   | PA1c.S1.M             |
| 28   | PA1c.S1.F             |
| 29   | PA1c.S2.T             |
| 30   | PA1c.S2.M             |
| 31   | PA1c.S2.F             |
| 32   | PA1c.S3.              |
| 33   | PA1c.S4.              |
| 34   | PA1c.S5.              |
| 35   | PA1d.O1.              |
| 36   | PA1d.S1.M             |
| 37   | PA1d.S1.F             |
| 38   | PA1d.S2.T             |
| 39   | PA1d.S2.M             |
| 40   | PA1d.S2.F             |
| 41   | PA2a.O1.              |
| 42   | PA2a.S1.Y15-24        |
| 43   | PA2a.S1.Y25-54        |
| 44   | PA2a.S1.Y55-64        |
| 45   | PA2a.S2.M             |
| 46   | PA2a.S2.F             |
| 47   | PA2a.S3.              |
| 48   | PA2a.S4.              |
| 49   | PA2a.S5.              |
| 50   | PA2a.S6.T             |
| 51   | PA2a.S6.Y15-24        |
| 52   | PA2a.S6.M             |
| 53   | PA2a.S6.F             |
| 54   | PA2b.O1.              |
| 55   | PA2b.S1.              |
| 56   | PA2b.S2.              |
| 57   | PA2b.S3.              |
| 58   | PA2b.S4.Y15_64        |
| 59   | PA2b.S4.Y15_24        |
| 60   | PA2b.S4.Y25_54        |
| 61   | PA2b.S4.Y55_64        |
| 62   | PA2b.S5.              |
| 63   | PA2b.S6.              |
| 64   | PA2b.S7.              |
| 65   | PA2b.S8.              |
| 66   | PA3.O1.               |
| 67   | PA3.S1.               |
| 68   | PA3.S2.               |
| 69   | PA3.S3.               |
| 70   | PA3.S4.               |
| 71   | PA3.S5.               |
| 72   | PA4.1.O1.             |
| 73   | PA4.1.S1.             |
| 74   | PA4.1.S2.A1           |
| 75   | PA4.1.S2.A1_2DCH      |
| 76   | PA4.1.S2.A2           |
| 77   | PA4.1.S2.A2_2DCH      |
| 78   | PA4.1.S3.A1           |
| 79   | PA4.1.S3.A1_2DCH      |
| 80   | PA4.1.S3.A2           |
| 81   | PA4.1.S3.A2_2DCH      |
| 82   | PA4.1.S4.             |
| 83   | PA4.1.S5.             |
| 84   | PA4.2.O1.             |
| 85   | PA4.2.S1.             |
| 86   | PA4.2.S2.             |
| 87   | PA4.2.S3.T            |
| 88   | PA4.2.S4.             |
| 89   | PA4.2.S5.             |
| 90   | PA4.2.S6.             |
| 91   | PA5.O1.               |
| 92   | PA5.S1.INAC           |
| 93   | PA5.S1.PT             |
| 94   | PA5.S1.M              |
| 95   | PA5.S1.F              |
| 96   | PA5.S2.               |
| 97   | PA5.S3.T              |
| 98   | PA5.S3.<30            |
| 99   | PA5.S3.>30            |
| 100  | PA5.S4.T              |
| 101  | PA5.S4.<30            |
| 102  | PA5.S4.>30            |
| 103  | PA5.S5.               |
| 104  | PA5.S6.               |
| 105  | PA5.S7.               |
| 106  | PA6a.O1.              |
| 107  | PA6a.S1.M             |
| 108  | PA6a.S1.F             |
| 109  | PA6a.S2.AGRI          |
| 110  | PA6a.S2.IND           |
| 111  | PA6a.S2.CONSTR        |
| 112  | PA6a.S2.SERV          |
| 113  | PA6a.S3.              |
| 114  | PA6a.S4.              |
| 115  | PA6a.S5.              |
| 116  | PA6a.S6.              |
| 117  | PA6b.O1.              |
| 118  | PA6b.S1.              |
| 119  | PA6b.S2.              |
| 120  | PA6b.S3.              |
| 121  | PA6b.S4.              |
| 122  | PA7.1.O1.             |
| 123  | PA7.1.S1.Y20-29       |
| 124  | PA7.1.S1.Y30-54       |
| 125  | PA7.1.S1.Y55-64       |
| 126  | PA7.1.S2.F            |
| 127  | PA7.1.S3.M            |
| 128  | PA7.1.S3.F            |
| 129  | PA7.1.S4.             |
| 130  | PA7.1.S5.             |
| 131  | PA7.1.S6.             |
| 132  | PA7.2.O1.             |
| 133  | PA7.2.S1.M            |
| 134  | PA7.2.S1.F            |
| 135  | PA7.2.S2.M            |
| 136  | PA7.2.S2.F            |
| 137  | PA7.2.S3.             |
| 138  | PA7.2.S4.             |
| 139  | PA8.1.O1.             |
| 140  | PA8.1.S1.MED          |
| 141  | PA8.1.S1.HIGH         |
| 142  | PA8.1.S2.             |
| 143  | PA8.1.S3.             |
| 144  | PA8.1.S4.             |
| 145  | PA8.1.S5.             |
| 146  | PA8.1.S6.             |
| 147  | PA8.2.O1.             |
| 148  | PA8.2.S1.             |
| 149  | PA8.2.S2.             |
| 150  | PA8.2.S3.             |
| 151  | PA8.2.S4.             |
| 152  | PA8.2.S5.             |
| 153  | PA9.1.O1.             |
| 154  | PA9.1.S1.             |
| 155  | PA9.1.S2.n.           |
| 156  | PA9.1.S2.             |
| 157  | PA9.1.S3.             |
| 158  | PA9.1.S4.             |
| 159  | PA9.1.S5.             |
| 160  | PA9.1.S6.             |
| 161  | PA9.2.O1.             |
| 162  | PA9.2.S1.READ         |
| 163  | PA9.2.S1.MATH         |
| 164  | PA9.2.S1.SCIE         |
| 165  | PA9.2.S2.             |
| 166  | PA9.2.S3.             |
| 167  | PA9.2.S4.             |
| 168  | PA9.2.S5.             |
| 169  | PA9.2.S6.             |
| 170  | PA10.O1.              |
| 171  | PA10.S1.              |
| 172  | PA10.S2.              |
| 173  | PA11.O1.              |
| 174  | PA11.S1.              |
| 175  | PA11.S2.              |
| 176  | PA11.S3.T             |
| 177  | PA11.S3.M             |
| 178  | PA11.S3.F             |
| 179  | PA11.S4.              |
| 180  | PA11.S5.              |
| 181  | PA11.S6.              |
| 182  | PA11.S8.              |
| 183  | PA11.S9.              |
| 184  | PA11.S10.             |
| 185  | PA11.S11.             |
| 186  | PA11.S12.             |
| 187  | PA11.S13.             |
| 188  | PA11.S14.             |
| 189  | PA11.S15.             |
| 190  | PA11a.O1.             |
| 191  | PA11a.S1.             |
| 192  | PA11a.S2.             |
| 193  | PA11a.S3.             |
| 194  | PA11a.S4.             |
| 195  | PA11a.S5.             |
| 196  | PA11a.S6.             |
| 197  | PA11a.S7.             |
| 198  | PA11a.S8.             |
| 199  | PA11a.S9.             |
| 200  | PA11a.S10.            |
| 201  | PA11b.O1.             |
| 202  | PA11b.S1.T            |
| 203  | PA11b.S1.M            |
| 204  | PA11b.S1.F            |
| 205  | PA11b.S2.             |
| 206  | PA11b.S3.             |
| 207  | PA11b.S4.             |
| 208  | PA11b.S5.T            |
| 209  | PA11b.S5.M            |
| 210  | PA11b.S5.F            |
| 211  | PA11b.S6.             |
| 212  | PA11b.S7.             |
| 213  | PA11b.S8.             |
| 214  | PA11b.S9.             |
| 215  | PA11b.S10.            |
| 216  | PA11b.S11.            |
| 217  | PA11b.S12.            |
| 218  | PA11c.O1.             |
| 219  | PA11c.S1.T            |
| 220  | PA11c.S1.M            |
| 221  | PA11c.S1.F            |
| 222  | PA11c.S2.T            |
| 223  | PA11c.S2.M            |
| 224  | PA11c.S2.F            |
| 225  | PA11c.S3.             |
| 226  | PA11c.S4.             |
| 227  | PA11c.S5.             |
| 228  | PA11c.S6.             |
| 229  | PA11c.S7.             |
' %>% 
  readMarkDownTable() %>% 
  .[, `#` := as.integer(`#`)]

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
# for (geo_code in 'BE') {
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
