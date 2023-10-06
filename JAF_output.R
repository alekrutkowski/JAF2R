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
      setcolorder('JAF_KEY')
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
JAF_GRAND_TABLE_with_scores <-
  JAF_GRAND_TABLE %>%
  .[, .(JAF_KEY,geo,time, value_,flags_)] %>% 
  .[, sufficiently_many_countries :=
      value_ %>% 
      isNotNA() %>% 
      length() %>% 
      {.>=20}
    , by=.(JAF_KEY,time)] %>% 
  .[, latest_year_overall :=
      max(time[sufficiently_many_countries])
    , by=JAF_KEY] %>% 
  .[, latest_year_individual :=
      max(time[isNotNA(value_)]) %>% 
      ifelse(.<latest_year_overall, ., latest_year_overall)
    , by=.(JAF_KEY,geo)] %>% 
  .[, previous_year := latest_year_individual - 3] %>% 
  .[, latest_value := value_[time==latest_year_individual]
    , by=.(JAF_KEY,geo)] %>% 
  .[, previous_value := value_[time==latest_year_individual]
    , by=.(JAF_KEY,geo)]
  
  
  