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
      .[, max. := max(score,na.rm=TRUE), by=JAF_KEY] %>% 
      .[, min. := min(score,na.rm=TRUE), by=JAF_KEY] %>% 
      .[, p25 := quantile(score,.25,na.rm=TRUE), by=JAF_KEY] %>% 
      .[, p75 := quantile(score,.75,na.rm=TRUE), by=JAF_KEY]
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
    if (nrow(dta[!is.na(score)])>0)
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
          expand_limits(y = .$score %>%
                          {1.1*c(min(.,na.rm=TRUE),max(.,na.rm=TRUE))}) + # to avoid truncating the labels
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

extendedScale <- function(vals., fun.) {
  range. <- max(vals.,na.rm=TRUE) - min(vals.,na.rm=TRUE)
  op. <- ifelse(fun.=='max',`+`,`-`)
  get(fun.)(vals.,na.rm=TRUE) %>% 
    op.(0.1*range.)
}

paCountryMSOfficeChart <- function(pa_code, geo_code, level_or_change) {
  dta <-
    memo_paCountryData(pa_code) %>% 
    .[[level_or_change]] %>% 
    .[geo==geo_code] %>%
    .[, c('pos_score','neg_score') := list(ifelse(score>=0,score,NA_real_),
                                           ifelse(score<0,score,NA_real_))] %>% 
    .[, Indicator :=
        Indicator %>% 
        gsub('\n',' ',.,fixed=TRUE) %>% 
        strwrap(15) %>% 
        paste(collapse="\n")
      , by=Indicator] %>% 
    .[, id := as.factor(Indicator) %>% as.integer()] %>% 
    .[, ind_pos := 0] %>% 
    melt(id.vars=c('id','Indicator'),
         measure=c('max.','min.','p25','p75','pos_score','neg_score','ind_pos')) %>% 
    .[, value := ifelse(variable=='ind_pos',extendedScale(value,'min'),value)] %>% 
    .[, value. := 
        kit::nif(grepl('score',variable),
                 value %>% 
                   sprintf("%01.1f",.) %>% 
                   sub('-','\u2212',.,fixed=TRUE) %>% 
                   paste0('           ',.),
                 variable=='ind_pos',
                 Indicator,
                 default="")]
  chart <-
    if (nrow(dta)>0)
      ms_scatterchart(dta, x="id", y="value", group="variable", labels="value.") %>%
    chart_data_labels(position='b') %>% 
    chart_data_fill(values = 
                      c(min.="#c2c2c2", max.="#c2c2c2",
                        p25="#c2c2c2", p75="#c2c2c2",
                        neg_score="red", pos_score="#b6d4f2")) %>% 
    chart_data_stroke(values = 
                        c(min.="#c2c2c2", max.="#c2c2c2",
                          p25="#c2c2c2", p75="#c2c2c2",
                          neg_score="black", pos_score="black")) %>% 
    chart_data_symbol(values = 
                        c(min.="dash", max.="dash",
                          p25="circle", p75="circle",
                          neg_score="square", pos_score="square",
                          ind_pos="none")) %>% 
    chart_data_size(values = 
                      c(min.=20, max.=20,
                        p25=16, p75=16,
                        neg_score=12, pos_score=12)) %>% 
    chart_labels_text(list(ind_pos=fp_text(font.size=8, shading.color='white',bol=TRUE),
                           pos_score=fp_text(color="#b6d4f2",font.size=14, bold=TRUE),
                           neg_score=fp_text(color="red",font.size=14, bold=TRUE))) %>% 
    chart_ax_x(display=FALSE,
               limit_min=0,
               limit_max=max(dta$id)+1) %>% 
    # chart_ax_y(limit_min=5*floor(extendedScale(dta$value,'min')/5),
    #            limit_min=5*floor(extendedScale(dta$value,'max')/5)) %>% 
    chart_labels(title=
                   paste0(EU_Members_geo_names[geo==geo_code,geo_labels],
                          '  \u25AA  [',pa_code,'] ',
                          PolicyAreaLabels[paste0('PA',PolicyArea)==pa_code,`POLICY AREA`],
                          '  \u25AA  ',
                          ifelse(level_or_change=='change','CHANGES','LEVELS')), 
                 xlab="", ylab="") %>% 
    chart_theme(legend_position='n')
  chart
}


# Actions -----------------------------------------------------------------

createFolder(paste0(OUTPUT_FOLDER,'/Country Profiles'))
message('\nCreating Policy Area / Country charts (PNG files)...')
for (geo_code in EU_Members_geo_codes) {
  createFolder(paste0(OUTPUT_FOLDER,'/Country Profiles/',geo_code))
  message('Starting ',geo_code,'...')
  for (pa_code in names(Selected_PAs_Codes)) {
    cat(paste0(" ",pa_code,': '))
    for (indic_type in c('change','latest_value')) {
      Indic_Type <-
        ifelse(indic_type=='change','changes','levels')
      cat(Indic_Type,"")
      paCountryChart(pa_code, geo_code, indic_type) %>%
        {if (!is.null(.$chart))
          ggsave(paste0(OUTPUT_FOLDER,'/Country Profiles/',geo_code,'/',
                        pa_code,'_',Indic_Type,'_',geo_code,'.png'),
                 .$chart, bg="white",
                 width=1000, height=900*(.$nrows/8)+150, units='px', dpi=120) else cat('skipping')}
    }
  }
  message()
}
message('All PNG files have been saved.')

# The following product used to be a huge Excel file with embedded png charts (a worksheet per country).
# Now it is a PowerPoint slide deck for each country with native Office charts.
message('\nPreparing Country_profile PowerPoint files...')
pptx0 <-
  read_pptx("Blank_16x9.pptx") # 16:9 proportion and Arial
for (geo_code in EU_Members_geo_codes) {
  message('Starting ',geo_code,'...')
  pptx <-
    pptx0 %>%
    ph_with(value=paste0('JAF charts for ',
                         EU_Members_geo_names[geo==geo_code,geo_labels]),
            location=ph_location_type(type="ctrTitle")) %>%
    ph_with(value=paste0('European Commission, DG EMPL\n',Sys.Date()),
            location=ph_location_type(type="subTitle"))
  for (pa_code in names(Selected_PAs_Codes)) {
    cat(paste0(" ",pa_code,': '))
    for (indic_type in c('change','latest_value')) {
      cat(ifelse(indic_type=='change','changes','levels'),"")
      chart <-
        paCountryMSOfficeChart(pa_code, geo_code, indic_type)
      if (!is.null(chart))
        pptx <-
        pptx %>%
        add_slide() %>%
        ph_with(chart,
                ph_location_fullsize()) else cat('skipping')
    }
  }
  message('Saving...')
  print(pptx,
        target=paste0(OUTPUT_FOLDER,'/Country Profiles/Country_profile_',
                      geo_code,'.pptx'))
}
message('All PowerPoint files have been saved.')
