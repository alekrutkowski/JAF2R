library(ggplot2)

# Functions and constants -------------------------------------------------

paCountryData <- function(pa_code)
  JAF_SCORES %>% 
  .[, .(geo, JAF_KEY, name, time, flags_,
        score_latest_value, score_change,
        reference_time_latest_value, reference_time_change)] %>% 
  .[JAF_KEY %in% Selected_PAs_Codes[[pa_code]]] %>% 
  .[geo %in% EU_Members_geo_codes] %>% 
  {sapply(
    c('change','latest_value'),
    simplify = FALSE,
    FUN = function(suffix)
      .[, c('JAF_KEY','name','geo','time','flags_',
            grep(paste0('_',suffix,'$'),colnames(.),value=TRUE))
        , with=FALSE] %>% 
      setnames(colnames(.),
               colnames(.) %>% sub(paste0('_',suffix,'$'),"",.)) %>% 
      .[, Flag :=
          paste(ifelse(!is.na(flags_),flags_,""),
                ifelse(time!=reference_time,time,"")) %>% 
          trimws()] %>% 
      .[, Indicator :=
          paste0('[',JAF_KEY,'] ',name) %>% 
          gsub(' - ',' \u2013 ',.,fixed=TRUE) %>% 
          ifelse(Flag!="",paste0(.,' (',Flag,')'),.) %>% 
          strwrap(45) %>% 
          paste(collapse='\n'), by=.(geo,JAF_KEY)] %>% 
      .[, c('time','flags_','reference_time','Flag','name') := NULL] %>% 
      .[, max. := max(score), by=JAF_KEY] %>% 
      .[, min. := min(score), by=JAF_KEY] %>% 
      .[, p25 := quantile(score,.25), by=JAF_KEY] %>% 
      .[, p75 := quantile(score,.75), by=JAF_KEY]
  )}

memo_paCountryData <- memoise::memoise(paCountryData)

paCountryChart <- function(pa_code, geo_code, level_or_change) {
  dta <-
    memo_paCountryData(pa_code) %>% 
    .[[level_or_change]] %>% 
    .[geo==geo_code] %>% 
    .[, fill. := ifelse(score[geo==geo_code]>=0,'white','red'), by=JAF_KEY] %>% 
    .[, hjust. := ifelse(score[geo==geo_code]>=0,-.3,1.3), by=JAF_KEY]
  chart <-
    dta %>% {
      ggplot2::ggplot(., aes(x = Indicator, y = 0)) +
        geom_crossbar(aes(ymin=min., ymax=max.),
                      width = 0.8, fill = "grey90", linetype=0) +
        geom_crossbar(aes(ymin = p25, ymax = p75),
                      width = 0.65, fill = "grey75", linetype=0) +
        geom_crossbar(aes(ymin=0, ymax=score),
                      width=0.4, fill=.$fill., linetype=0) +
        geom_text(aes(label = score %>% 
                        sprintf('%01.1f',.) %>% sub('-','\u2212',.,fixed=TRUE),
                      y=score),
                  hjust=.$hjust.) +
        theme_minimal() +
        scale_y_continuous(labels=\(x) sub('-','\u2212',x),
                           sec.axis = dup_axis()) +
        theme(axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.x=element_text(color="black"),
              axis.text.y=element_text(color="black"),
              text = element_text(size=13) # ,
              # aspect.ratio=length(.$JAF_KEY)/8
              ) +
        geom_hline(aes(yintercept = 0)) +
        coord_flip() +
        ggtitle(EU_Members_geo_names[geo==geo_code,geo_labels],
                subtitle =
                  paste0('[',pa_code,'] ',
                         PolicyAreaLabels[paste0('PA',PolicyArea)==pa_code,`POLICY AREA`],
                         '  \u25AA  ',
                         ifelse(level_or_change=='change','C H A N G E S','L E V E L S'))
        )
    }
  list(nrows=nrow(dta), chart=chart)
}


# # Actions -----------------------------------------------------------------
# Temporarily commented out for faster development of the next stages
# createFolder(paste0(OUTPUT_FOLDER,'/Country Profiles'))
# message('\nCreating Policy Area / Country charts (PNG files)...')
# for (geo_code in EU_Members_geo_codes[1]) {
#   createFolder(paste0(OUTPUT_FOLDER,'/Country Profiles/',geo_code))
#   message('Starting ',geo_code,'...')
#   for (pa_code in names(Selected_PAs_Codes)[1]) {
#     cat(paste0(" ",pa_code,': '))
#     for (indic_type in c('change','latest_value')) {
#       Indic_Type <-
#         ifelse(indic_type=='change','changes','levels')
#       cat(Indic_Type,"")
#       paCountryChart(pa_code, geo_code, indic_type) %>% 
#         {ggsave(paste0(OUTPUT_FOLDER,'/Country Profiles/',geo_code,'/',
#                        pa_code,'_',Indic_Type,'_',geo_code,'.png'),
#                 .$chart, bg="white",
#                 width=1000, height=1000*(.$nrows/8), units='px', dpi=120)}
#     }
#   }
# }
