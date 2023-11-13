library(data.table)
library(magrittr)
library(eurodata)
library(collapse)
library(stringr)


# Functions and constants -------------------------------------------------

rename_with_mod_time <- function(file_path, time_format="%Y-%m-%d %H.%M.%S") {
  modification_time <- 
    file.info(file_path)$mtime
  time_str <- 
    format(modification_time, time_format)
  new_file_path <-
    sub("(.*)(\\.[a-zA-Z0-9]+)$", paste0("\\1 ",time_str,"\\2"), file_path)
  success <- 
    file.rename(file_path, new_file_path)
  if (success) new_file_path else
    stop("Failed to rename the file.")
}

`doesn't start with S or C or O` <- function(x)
  !grepl('^(S.+|C.+|O.+)$', x)

modifyRows <- function(dt, rowfilter, expr)
  eval(bquote({
    . <- dt[(.(substitute(rowfilter)))] # to make it compatible with %>%
    dt[(.(substitute(rowfilter)))] <- 
      dt[(.(substitute(rowfilter)))][,.(substitute(expr))]
    dt
  }))

parseJAF_KEY <- function(dt) {
  stopifnot('JAF_KEY' %in% colnames(dt))
  newcols <-
    dt$JAF_KEY %>% 
    tstrsplit(split=".", fixed=TRUE)
  newcol_names <-
    c('PolicyArea', 'IndicCode',
      paste0('IndicSpecif',seq_len(length(newcols)-2)))
  dt %>% 
    .[, (newcol_names) := newcols] %>% 
    .[, PolicyArea := sub('^PA',"",PolicyArea)] %>% 
    .[, .temp_row_marker := IndicCode %>% `doesn't start with S or C or O`] %>% 
    modifyRows(.temp_row_marker,
               PolicyArea := paste0(PolicyArea,'.',IndicCode)) %>% 
    modifyRows(.temp_row_marker,
               IndicCode := IndicSpecif1) %>%
    modifyRows(.temp_row_marker,
               grep('IndicSpecif.+',colnames(.),value=TRUE) %>% head(-1) :=
                 .[,grep('IndicSpecif.+',colnames(.),value=TRUE) %>% tail(-1),
                   with=FALSE]) %>%
    modifyRows(.temp_row_marker,
               grep('IndicSpecif.+',colnames(.),value=TRUE) %>% tail(1) :=
                 NA_character_) %>%
    .[, .temp_row_marker := NULL] %>% 
    .[, sapply(.,\(col) !all(is.na(col))), with=FALSE] %>% 
    .[, IndicType := substr(IndicCode,1,1)]
}

sanitiseFilename <- function(string)
  string %>%
  # Replace reserved characters with an underscore
  gsub('[<>:"/\\|?*]', '_', .) %>%
  # Remove trailing spaces or periods
  gsub('[ .]$', '', .) %>%
  # Append an underscore if it matches reserved names
  ifelse(. %in% c('CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 
                  'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 
                  'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9'),
         paste0(., '_'),.) %>%
  # Ensure filename doesn't exceed max length
  substr(1, 255)

isNotNA <- Negate(is.na)

readMarkDownTable <- function(markdown_string)
  markdown_string %>% 
  fread(sep="|", header=TRUE) %>% 
  .[-1] %>% 
  .[, sapply(.,\(col) !is.logical(col)), with=FALSE]

QuantAssessmentTable <-
  # Levels in rows, changes in columns
  '
| Levels  | --  | -  | 0  | +  | ++  |
|---------|-----|----|----|----|-----|
| --      | 1   | 1  | 1  | 4  | 5   |
| -       | 2   | 2  | 2  | 4  | 5   |
| 0       | 10  | 9  |    |    |     |
| +       | 6   |    |    | 7  | 8   |
| ++      |     |    | 3  | 3  | 3   |
' %>% 
  readMarkDownTable() %>%
  melt(id.vars='Levels',variable.name='Changes') %>% 
  .[, value := as.integer(value)] %>% 
  setnames(c('Levels','Changes','value'),
           c('score_category_latest_value',
             'score_category_change',
             'QuantAssessmentNum'))

QuantAssessmentLabels <-
  '
| Quantitative assessment                                                    | Challenge  | Positive Outcome  |
|----------------------------------------------------------------------------|------------|-------------------|
| 1. Indicator significantly worse than EU average                           | X          |                   |
| 2. Indicator worse than EU average                                         | X          |                   |
| 3. Indicator significantly better than EU average                          |            | X                 |
| 4. Indicator worse than EU average & some positive development             | X          |                   |
| 5. Indicator worse than EU average & significantly positive development    | X          |                   |
| 6. Indicator better than EU average & significantly negative development   | X          |                   |
| 7. Indicator above EU average & some positive development                  |            | X                 |
| 8. Indicator above EU average & significantly positive development         |            | X                 |
| 9. Indicator around EU average & some negative development                 | X          |                   |
| 10. Indicator around EU average & significantly negative development       | X          |                   |
' %>% 
  readMarkDownTable() %>% 
  .[, QuantAssessmentNum := .I] %>% 
  .[, QuantAssessmentGood :=
      kit::nif(`Positive Outcome`=='X', TRUE,
               Challenge=='X', FALSE,
               default=NA)] %>% 
  .[,.(QuantAssessmentNum, `Quantitative assessment`, QuantAssessmentGood)]

QuantAssessmentDescriptions <-
  merge(QuantAssessmentTable, QuantAssessmentLabels,
        all.x=TRUE,
        by='QuantAssessmentNum')

EU_Members_geo_names <-
  importLabels('geo') %>% 
  as.data.table() %>% 
  .[, lapply(.,as.character)] %>% 
  .[geo %in% c(EU_Members_geo_codes,EU_geo_code,EA_geo_code)]

OUTPUT_FOLDER <-
  Sys.time() %>% 
  paste('JAF output',.) %>% 
  gsub(':','.',.,fixed=TRUE)

reportProblem <- function(message.) 
  function(x) { # x = error or warning
    message('Something went wrong:\n',x)
    stop(message.,call.=FALSE)
  }

createFolder <- function(folder_name) {
  message('\nCreating a new output directory/folder:\n',
          paste0(getwd(),'/',folder_name))
  reportProblem('Folder not created!') %>% 
    tryCatch(dir.create(folder_name),
             error = .,
             warning = .)
}


# Actions -----------------------------------------------------------------

### Temporary dev version
# if (file.exists('JAF_INDICATORS.Rds')) {
#   message('\nRenaming/archiving the exisitng/old\nJAF_INDICATORS.Rds -> ',
#           appendLF=FALSE)
#   message(rename_with_mod_time('JAF_INDICATORS.Rds'))
# }
# message('Saving new JAF_INDICATORS.Rds...')
# JAF_INDICATORS %>%
#   saveRDS('JAF_INDICATORS.Rds')
JAF_INDICATORS <-
  readRDS('JAF_INDICATORS.Rds')
###

JAF_NAMES_DESCRIPTIONS <-
  JAF_INDICATORS %>% 
  names() %>% 
  lapply(\(x) data.table(JAF_KEY=x,
                         name=JAF_INDICATORS[[x]]$name, 
                         unit=JAF_INDICATORS[[x]]$unit)) %>% 
  rbindlist()

message('\nPreparing JAF_GRAND_TABLE...')
JAF_GRAND_TABLE <-
  JAF_INDICATORS %>% 
  names() %>% 
  lapply(function(x)
    JAF_INDICATORS[[x]]$value %>% 
      .[, JAF_KEY:=x] %>% 
      .[, high_is_good := JAF_INDICATORS[[x]]$high_is_good] %>% 
      setcolorder(c('JAF_KEY','high_is_good'))
  ) %>% rbindlist(fill=TRUE) %>% 
  .[, grep('^(JAF_KEY|high_is_good|geo|time|value_|flags_.*|.)$',
           colnames(.),value=TRUE),
    with=FALSE] %>% 
  setcolorder(c('JAF_KEY','geo','time','value_','flags_',
                grep('^.$',colnames(.),value=TRUE),
                grep('^flags_.$',colnames(.),value=TRUE)))

message('Calculating scores')
JAF_SCORES <-
  JAF_GRAND_TABLE %>%
  .[, .(JAF_KEY,geo,time,high_is_good,value_,flags_)] %T>% 
  {if (nrow(.)!=nrow(unique(.[,.(JAF_KEY,geo,time)]))) {
    View(.[duplicated(.[,.(JAF_KEY,geo,time)])])
    stop('\n`JAF_KEY`, `geo`, `time` do not uniquely identify the riows in `JAF_GRAND_TABLE`!\n',
         'The offending rows are shown in data viewer.')
  }} %>%
  .[, time := as.integer(time)] %>% 
  .[, value_ := as.numeric(value_)] %>% 
  .[isNotNA(value_)] %>% 
  .[geo %in% c(EU_Members_geo_codes,EU_geo_code,EA_geo_code)] %>% 
  .[, sufficiently_many_countries :=
      value_[geo %in% EU_Members_geo_codes] %>% 
      {length(.)>=20}
    , by=.(JAF_KEY,time)] %>% 
  .[, latest_year_overall :=
      suppressWarnings(max(time[sufficiently_many_countries])) %>% # suppressed warning if time[sufficiently_many_countries] is empty i.e. -> max = -Inf
      ifelse(is.infinite(.), NA_integer_, .)
    , by=JAF_KEY] %>% 
  .[, latest_year_individual :=
      max(time) %>%
      kit::nif(is.na(latest_year_overall), .,
               . < latest_year_overall, .,
               default = latest_year_overall)
    , by=.(JAF_KEY,geo)] %>% 
  .[, previous_year := latest_year_individual - 3] %>% 
  .[, latest_value := value_[time==latest_year_individual]
    , by=.(JAF_KEY,geo)] %>% 
  .[, previous_value := value_[time==previous_year]
    , by=.(JAF_KEY,geo)] %>%
  .[, change := latest_value - previous_value] %>%
  .[time==latest_year_individual] %>%
  melt(id.vars=c('JAF_KEY','geo','time','high_is_good','flags_'),
       measure.vars=c('latest_value','change'),
       variable.name="variable", value.name="value",
       na.rm=TRUE) %>%
  .[, reference_name :=
      value[geo==EU_geo_code] %>% 
      {ifelse(length(.)==0, # EU not available
              'Simple Average', # *** should be consistent
              EU_geo_code)}
    , by=.(JAF_KEY, variable)] %>% 
  .[, reference :=
      value[geo==EU_geo_code] %>% 
      ifelse(length(.)==0, # EU not available
             mean(value[geo %in% EU_Members_geo_codes]), # *** should be consistent
             .)
    , by=.(JAF_KEY, variable)] %>% 
  .[, reference_time :=
      value[geo==EU_geo_code] %>% 
      {ifelse(length(.)==0, # EU not available
              paste(sort(unique(time[geo %in% EU_Members_geo_codes])),
                    collapse=', '),
              as.character(time[geo==EU_geo_code]))}
    , by=.(JAF_KEY, variable)] %>% 
  .[, std := sd(value[geo %in% EU_Members_geo_codes]),
    , by=.(JAF_KEY, variable)] %>% 
  .[, score := 
      ifelse(high_is_good,1,-1)*
      10*(value - reference)/std] %>% 
  .[, score_category :=
      score %>% 
      {kit::nif(. < -13, '--',
                . < -7, '-',
                . <= 7, '0',
                . < 13, '+',
                . >= 13, '++')}] %>% 
  dcast(JAF_KEY + geo + time + flags_ + high_is_good ~ variable,
        value.var=c('value','score','score_category',
                    'reference','reference_name', 'reference_time'),
        fun.aggregate=identity,
        fill=NA) %>% 
  .[, comment := time %>% 
      {paste0(.,' for latest_value; ',.,' minus ',.-3,' for change',
              ifelse(grepl('b',flags_),
                     ' (but there is a break in time series!)',"")
      )}] %>% 
  setorder(JAF_KEY,geo,time) %>% 
  parseJAF_KEY() %>% 
  merge(QuantAssessmentDescriptions,
        by=c('score_category_latest_value','score_category_change')) %>% 
  merge(EU_Members_geo_names,
        by='geo') %>% 
  merge(JAF_NAMES_DESCRIPTIONS,
        by='JAF_KEY') %>% 
  .[, Description := paste0(name,', ',unit)]

createFolder(OUTPUT_FOLDER)


