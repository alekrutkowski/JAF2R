library(ggplot2)
library(mschart)
library(officer)

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
        expand_limits(y = .$score*1.1 %>%
                        {c(min(.,na.rm=TRUE),max(.,na.rm=TRUE))}) + # to avoid truncating the labels
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
                         '\u00A0\u00A0\u25AA\u00A0\u00A0',
                         ifelse(level_or_change=='change','CHANGES','LEVELS')  
                  ) %>% strwrap(50) %>% paste(collapse='\n')
        )
    }
  list(nrows=nrow(dta), chart=chart)
}

paCountryExcelChart <- function(pa_code, geo_code, level_or_change) {
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
        expand_limits(y = .$score*1.1 %>%
                        {c(min(.,na.rm=TRUE),max(.,na.rm=TRUE))}) + # to avoid truncating the labels
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
                         '\u00A0\u00A0\u25AA\u00A0\u00A0',
                         ifelse(level_or_change=='change','CHANGES','LEVELS')  
                  ) %>% strwrap(50) %>% paste(collapse='\n')
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
#                 width=1000, height=900*(.$nrows/8)+150, units='px', dpi=120)}
#     }
#   }
#   message()
# }
# message('All PNG files have been saved.")

# The following product used to be a huge Excel file with embedded png charts.
# Now it is still in folder 'pdf' but it is an Excel file with native charts.
message('\nPreparing Country_profile PowerPoint files...')

# Sample data
df <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(2, 1, 4, 3, 5),
  label = c("A", "B", "C", "D", "E")
)

# Create a scatter plot
scatter_chart <- ms_scatterchart(data = df, x = "x", y = "y", labels = "label") # make labels below point TODO

# Create a PowerPoint object
ppt <- read_pptx() %>%
  add_slide(layout = "Title and Content", master = "Office Theme") %>%
  ph_with(scatter_chart, ph_location_fullsize())

# Save the PowerPoint
print(ppt, target = "scatter_plot_presentation.pptx") # 16:9 proportion TODO