init = function() {
  source("JAF_functions.R")
  JAF_INDICATORS <<- list()
}
if (interactive() && exists("JAF_INDICATORS")) repeat {
  answer <- toupper(readline("Re-calculate everything? (Y/N): "))
  if (answer=="Y") {
    init()
    break
  } else if (answer=="N") break
} else init()

# Order matters:

source('JAF_indicators__definitions.R')

source('JAF_output.R')

source('JAF_KEC.R')

source('JAF_Compendium.R')

source('JAF_Country_Compendium.R')

source('JAF_Main_Indicators.R')

source('JAF_PAs.R')

source('JAF_Country_Profiles.R')

source('JAF_pdf.R')

message('\nAll JAF scripts finished.')

# Dev env: {source("H:/JAF_functions.R"); source('H:/JAF_output.R'); source('H:/JAF_KEC.R'); source('H:/JAF_Compendium.R'); source('H:/JAF_Country_Compendium.R'); source('H:/JAF_Main_Indicators.R'); source('H:/JAF_PAs.R'); source('H:/JAF_Country_Profiles.R')}