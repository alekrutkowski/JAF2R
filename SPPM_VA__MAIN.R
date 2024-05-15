runScript <- function(file_name) {
  message('\n\n====== Starting ',file_name,' ======\n')
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
preCheckInidcators('SPPM_VA_indicators__definitions.R')
runScript('SPPM_VA_indicators__definitions.R')
runScript('JAF_output.R')
runScript('SPPM_VA_KEC.R')

message('\nAll SPPM VA scripts finished.')
