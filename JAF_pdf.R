library(rmarkdown)

# Functions and constants -------------------------------------------------

JAF_SCORES_for_Main_Indicators <- 
  JAF_SCORES %>% 
  .[, .(geo, JAF_KEY, name, time, flags_,
        score_latest_value, score_change,
        reference_time_latest_value, reference_time_change)] %>% 
  .[geo %in% EU_Members_geo_codes] %>% 
  merge(Selected_Main_Indicators_Codes, by='JAF_KEY') %>% 
  {sapply(
    c('change','latest_value'),
    simplify = FALSE,
    FUN = function(suffix)
      .[, c('JAF_KEY','name','geo','time','flags_','Main_Indicators_order',
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
          strwrap(60) %>% 
          paste(collapse='\n'), by=.(geo,JAF_KEY)] %>% 
      .[, Indicator := factor(Indicator,
                              levels=
                                unique(.[,.(Indicator,Main_Indicators_order)]) %>% 
                                setorder(Main_Indicators_order) %>% 
                                .$Indicator)] %>% 
      .[, c('time','flags_','reference_time','Flag','name') := NULL] %>% 
      .[, max. := max(score), by=JAF_KEY] %>% 
      .[, min. := min(score), by=JAF_KEY] %>% 
      .[, p25 := quantile(score,.25), by=JAF_KEY] %>% 
      .[, p75 := quantile(score,.75), by=JAF_KEY]
  )}

mainIndicCountryChart <- function(geo_code, level_or_change) {
  dta <-
    JAF_SCORES_for_Main_Indicators %>% 
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
        expand_limits(y = .$score %>%
                        {1.1*c(min(.,na.rm=TRUE),max(.,na.rm=TRUE))}) + # to avoid truncating the labels
        scale_y_continuous(labels=\(x) sub('-','\u2212',x),
                           sec.axis = dup_axis()) +
        theme(plot.title.position = "plot",
              plot.title = element_text(hjust = 0.5),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              axis.text.x=element_text(color="black", size=8),
              axis.text.y=element_text(color="black"),
              text = element_text(size=13) # ,
              # aspect.ratio=length(.$JAF_KEY)/8
        ) +
        geom_hline(aes(yintercept = 0)) +
        coord_flip() +
        ggtitle(paste0(EU_Members_geo_names[geo==geo_code,geo_labels],
                       '  \u25AA  Main Indicators  \u25AA  ',
                       ifelse(level_or_change=='change','CHANGES','LEVELS')))
    }
  list(nrows=nrow(dta), chart=chart)
}

# Actions -----------------------------------------------------------------

# /pdf/countries pdf country files
message('\nStarting the production of the country PDF files...')
createFolder(paste0(OUTPUT_FOLDER,'/pdf'))
createFolder(paste0(OUTPUT_FOLDER,'/pdf/countries'))
for (geo_code in list.dirs(paste0(OUTPUT_FOLDER,'/Country Profiles/'),
                           full.names=FALSE) %>% .[.!=""]) { # empty string is for the root dir 'Country Profiles' itself
  message('\n\nProducing the PDF file with charts for ',geo_code,'...')
  rmd_string <-
    getwd() %>% 
    paste0('/',OUTPUT_FOLDER,'/Country Profiles/',geo_code) %>%
    list.files(full.names=TRUE) %>%
    .[order(file.info(.)$mtime)] %>%
    paste0('
\\vspace*{\\fill}
\\begin{center}
  \\includegraphics[width=0.95\\textwidth,height=0.95\\textheight,keepaspectratio]{',.,'}
\\end{center}
\\vspace*{\\fill}

\\clearpage
           ') %>%
    paste(collapse='\n\n') %>%
    paste0('
---
title: "JAF charts for ',EU_Members_geo_names[geo==geo_code,geo_labels],'"
author: "European Commission, DG EMPL"
date: "',Sys.Date(),'"
output: pdf_document
documentclass: article
classoption: a4paper
geometry: margin=1.5cm
header-includes:
  - \\usepackage{fancyhdr}
  - \\usepackage{titling}
  - \\pretitle{\\begin{center}\\Huge}
  - \\posttitle{\\par\\end{center}\\vfill}
  - \\renewcommand{\\maketitlehooka}{\\null\\mbox{}\\vfill}
  - \\pagestyle{empty}
  - \\usepackage[scaled]{helvet}
  - \\usepackage[T1]{fontenc}
  - \\renewcommand\\familydefault{\\sfdefault}
  - \\usepackage{fancyhdr}
  - \\pagestyle{fancy}
  - \\fancyhf{}
  - \\fancyfoot[C]{\\thepage}
  - \\renewcommand{\\headrulewidth}{0pt}
  - \\fancypagestyle{plain}{
      \\fancyhf{}
      \\renewcommand{\\headrulewidth}{0pt}
      \\renewcommand{\\footrulewidth}{0pt}
    }
---
\n\\newpage
',.)
  rmd_tmpfile <-
    tempfile(fileext='.Rmd')
  cat(rmd_string, file=rmd_tmpfile)
  rmarkdown::render(input=rmd_tmpfile,
                    output_dir=paste0(OUTPUT_FOLDER,'/pdf/countries'),
                    output_file=paste0(geo_code,'.pdf'))
}
message('All country PDF files done.')

# /Main/chart png charts -- needed for /pdf/Main.pdf
message('\nCreating Main Indicators / Country charts (PNG files)...')
createFolder(paste0(OUTPUT_FOLDER,'/Main/charts'))
for (geo_code in EU_Members_geo_codes) {
  cat(paste0("  ",geo_code,': '))
  for (indic_type in c('change','latest_value')) {
    Indic_Type <-
      ifelse(indic_type=='change','changes','levels')
    cat(Indic_Type,"")
    mainIndicCountryChart(geo_code, indic_type) %>%
      {ggsave(paste0(OUTPUT_FOLDER,'/Main/charts/Main_Indicators_',geo_code,
                     '_',Indic_Type,'.png'),
              .$chart, bg="white",
              width=1300, height=410*(.$nrows/8)+20, units='px', dpi=120)}
  }
}
message('All PNG files have been saved.')

# /pdf/Main.pdf
message('\nProducing PDF file with charts for Main Indicators...')
rmd_string <-
  getwd() %>% 
  paste0('/',OUTPUT_FOLDER,'/Main/charts/') %>% 
  list.files(full.names=TRUE) %>%
  .[order(file.info(.)$mtime)] %>%
  paste0('
\\vspace*{\\fill}
\\begin{center}
  \\includegraphics[width=0.95\\textwidth,height=0.95\\textheight,keepaspectratio]{',.,'}
\\end{center}
\\vspace*{\\fill}

\\clearpage
           ') %>%
  paste(collapse='\n\n') %>%
  paste0('
---
title: "JAF charts for Main Indicators"
author: "European Commission, DG EMPL"
date: "',Sys.Date(),'"
output: pdf_document
documentclass: article
classoption: a4paper
geometry: margin=1.5cm
header-includes:
  - \\usepackage{fancyhdr}
  - \\usepackage{titling}
  - \\pretitle{\\begin{center}\\Huge}
  - \\posttitle{\\par\\end{center}\\vfill}
  - \\renewcommand{\\maketitlehooka}{\\null\\mbox{}\\vfill}
  - \\pagestyle{empty}
  - \\usepackage[scaled]{helvet}
  - \\usepackage[T1]{fontenc}
  - \\renewcommand\\familydefault{\\sfdefault}
  - \\usepackage{fancyhdr}
  - \\pagestyle{fancy}
  - \\fancyhf{}
  - \\fancyfoot[C]{\\thepage}
  - \\renewcommand{\\headrulewidth}{0pt}
  - \\fancypagestyle{plain}{
      \\fancyhf{}
      \\renewcommand{\\headrulewidth}{0pt}
      \\renewcommand{\\footrulewidth}{0pt}
    }
---
\n\\newpage
',.)
rmd_tmpfile <-
  tempfile(fileext='.Rmd')
cat(rmd_string, file=rmd_tmpfile)
rmarkdown::render(input=rmd_tmpfile,
                  output_dir=paste0(OUTPUT_FOLDER,'/pdf'),
                  output_file='Main.pdf')
message('Main.pdf done.')
