library(rmarkdown)

# Functions and constants -------------------------------------------------


# # Actions -----------------------------------------------------------------
# 
# ### OUTPUT_FOLDER <- 'C:/Users/rutkoal/JAF output 2023-11-13 09.28.24' # tmp precompiled charts
# 
# 
# createFolder(paste0(OUTPUT_FOLDER,'/pdf'))
# createFolder(paste0(OUTPUT_FOLDER,'/pdf/countries'))
# for (geo_code in list.dirs(paste0(OUTPUT_FOLDER,'/Country Profiles/'),
#                            full.names=FALSE) %>% .[.!=""]) { # empty string is for the root dir 'Country Profiles' itself
#   message('Producing PDF file with charts for ',geo_code,'...')
#   rmd_string <-
#     paste0(OUTPUT_FOLDER,'/Country Profiles/',geo_code) %>% 
#     list.files(full.names=TRUE) %>% 
#     .[order(file.info(.)$mtime)] %>% 
#     paste0('
# \\vspace*{\\fill}
# \\begin{center}
#   \\includegraphics[width=0.95\\textwidth,height=0.95\\textheight,keepaspectratio]{',.,'}
# \\end{center}
# \\vspace*{\\fill}
# 
# \\clearpage
#            ') %>% 
#     paste(collapse='\n\n') %>% 
#     paste0('
# ---
# title: "JAF charts for ',EU_Members_geo_names[geo==geo_code,geo_labels],'"
# author: "European Commission, DG EMPL"
# date: "',Sys.Date(),'"
# output: pdf_document
# documentclass: article
# classoption: a4paper
# geometry: margin=1.5cm
# header-includes:
#   - \\usepackage{fancyhdr}
#   - \\usepackage{titling}
#   - \\pretitle{\\begin{center}\\Huge}
#   - \\posttitle{\\par\\end{center}\\vfill}
#   - \\renewcommand{\\maketitlehooka}{\\null\\mbox{}\\vfill}
#   - \\pagestyle{empty}
#   - \\usepackage[scaled]{helvet}
#   - \\usepackage[T1]{fontenc}
#   - \\renewcommand\\familydefault{\\sfdefault}
#   - \\usepackage{fancyhdr}
#   - \\pagestyle{fancy}
#   - \\fancyhf{}
#   - \\fancyfoot[C]{\\thepage}
#   - \\renewcommand{\\headrulewidth}{0pt}
#   - \\fancypagestyle{plain}{
#       \\fancyhf{}
#       \\renewcommand{\\headrulewidth}{0pt}
#       \\renewcommand{\\footrulewidth}{0pt}
#     }
# ---
# \n\\newpage
# ',.)
#   rmd_tmpfile <-
#     tempfile(fileext='.Rmd')
#   cat(rmd_string, file=rmd_tmpfile)
#   rmarkdown::render(input=rmd_tmpfile,
#                     output_file=paste0(OUTPUT_FOLDER,'/pdf/countries/',geo_code))
# }
