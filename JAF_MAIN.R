runScript <- function(file_name) {
  message('\n\n====== Staring ',file_name,' ======\n')
  source(file_name)
}

init <- function() {
  runScript("JAF_functions.R")
  JAF_INDICATORS <<- list()
}
if (interactive() && exists("JAF_INDICATORS"))
  repeat {
    answer <- toupper(readline("Re-calculate everything? (Y/N): "))
    if (answer=="Y") {
      init()
      break
    } else if (answer=="N") break
  } else init()

# Order matters:
preCheckInidcators('JAF_indicators__definitions.R')
runScript('JAF_indicators__definitions.R')
runScript('JAF_output.R')
runScript('JAF_KEC.R')
runScript('JAF_Compendium.R')
runScript('JAF_Country_Compendium.R')
runScript('JAF_Main_Indicators.R')
runScript('JAF_PAs.R')
runScript('JAF_Country_Profiles.R')
runScript('JAF_pdf.R')

message('\nAll JAF scripts finished.')
