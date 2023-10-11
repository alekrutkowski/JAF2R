library(data.table)
library(magrittr)
library(collapse)

message('Saving JAF_INDICATORS.Rds...')
JAF_INDICATORS %>%
  saveRDS('JAF_INDICATORS.Rds')

message('Preparing and saving JAF_GRAND_TABLE.csv...')
JAF_GRAND_TABLE <-
  JAF_INDICATORS %>% 
  names() %>% 
  lapply(function(x)
    JAF_INDICATORS[[x]]$value %>% 
      .[, JAF_KEY:=x] %>% 
      .[, high_is_good := JAF_INDICATORS[[x]]$high_is_good] %>% 
      setcolorder(c('JAF_KEY','high_is_good'))
  ) %>% rbindlist(fill=TRUE) %>% 
  .[, grep('^(JAF_KEY|geo|time|value_|flags_.*|.)$',
           colnames(.),value=TRUE),
    with=FALSE] %>% 
  setcolorder(c('JAF_KEY','geo','time','value_','flags_',
                grep('^.$',colnames(.),value=TRUE),
                grep('^flags_.$',colnames(.),value=TRUE))) %T>% 
  fwrite('JAF_GRAND_TABLE.csv')

message('Compressing JAF_GRAND_TABLE.csv into JAF_GRAND_TABLE.csv.zip...')
utils::zip('JAF_GRAND_TABLE.csv.zip',
           'JAF_GRAND_TABLE.csv')

isNotNA <- Negate(is.na)

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
  .[geo %in% c(EU_Members_geo_codes,'EU27_2022','EA20')] %>% 
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
  melt(id.vars=c('JAF_KEY','geo','time','high_is_good'),
       measure.vars=c('latest_value','change'),
       variable.name="variable", value.name="value",
       na.rm=TRUE) %>%
  .[, reference :=
      value[geo=='EU27_2020'] %>% 
      ifelse(length(.)==0, # EU not available
             mean(value[geo %in% EU_Members_geo_codes]),
             .)
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
  dcast(JAF_KEY + geo + time ~ variable,
        value.var=c('value','score','score_category'),
        fun.aggregate=identity,
        fill=NA) %>% 
  .[, comment := time %>% 
      {paste(.,'for latest_value;',.,'minus',.-3,'for change')}] %>% 
  setorder(JAF_KEY,geo,period)


## TODO
# Warning messages:
# 1: In max(time[sufficiently_many_countries]) :
#   no non-missing arguments to max; returning -Inf
# 2: In `[.data.table`(., , `:=`(latest_year_overall, max(time[sufficiently_many_countries])),  :
#   Group 476 column 'latest_year_overall': -inf (type 'double') at RHS position 1 truncated (precision lost) when assigning to type 'integer'
# 3: In max(time[sufficiently_many_countries]) :
#   no non-missing arguments to max; returning -Inf
# 4: In `[.data.table`(., , `:=`(latest_year_overall, max(time[sufficiently_many_countries])),  :
#   Group 477 column 'latest_year_overall': -inf (type 'double') at RHS position 1 truncated (precision lost) when assigning to type 'integer'