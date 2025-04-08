library(magrittr)
library(data.table)

`%not in%` <- Negate(`%in%`)

commaSeries <- function(x)
  if (length(x)==0) 'None' else
    x %>% sort %>% paste(collapse=',')

suffix <- function(file_name,suffix.)
  file_name %>% 
  paste0('___',suffix.,'.csv')

all_files <-
  list.files(pattern="^IESS")

old_files <-
  list.files(pattern="^IESS.*___.*\\.csv$")

new_files <- # just received from Eurostat (Frank Bauer) and NOT RENAMED
  setdiff(all_files, old_files)

if (length(new_files)==0)
  stop('\nNo new IESS_... files found!',call.=FALSE)

# Rename new files, add year suffix
current_year <-
  Sys.Date() %>% substr(1,4)
new_files %>% 
  file.rename(suffix(.,current_year))

# Append time series only if not present in the newer file

vintages <-
  list.files(pattern="^IESS") %>% 
  grep('CONSOLIDATED',.,value=TRUE,invert=TRUE) %>% 
  sub('.*___(....)\\.csv','\\1',.) %>% 
  unique() %>% sort %>% rev

accumulate_dt <- function(accumulated_dt, older_dt) {
  if (identical(accumulated_dt,data.table())) older_dt else {
    existing_year <-
      accumulated_dt %>% 
      .$YEAR %>% 
      unique
    message('\nExisting:',commaSeries(existing_year))
    older_dt_without_existing_years <-
      older_dt %>% 
      .[YEAR %not in% existing_year]
    message('Added:',commaSeries(unique(older_dt_without_existing_years$YEAR)))
    rbind(accumulated_dt,
          older_dt_without_existing_years) %>% 
      .[!duplicated(.)]
  }
}

consolidated_IESS_datasets <-
  new_files %>%
  set_names(.,.) %>% 
  lapply(function(original_file_name) {
    message('\nConsolidating ',original_file_name,' ...')
    Reduce(init=data.table(),
           x=vintages,
           f=function(dt,x) {
             cat('Loading',x," ")
             original_file_name %>% 
               suffix(x) %>% 
               fread() %>% 
               accumulate_dt(dt,.)
           }) %T>% 
      fwrite(suffix(original_file_name,'CONSOLIDATED'))
  })
