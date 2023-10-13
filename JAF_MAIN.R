init = function() {
  source("H:/JAF_functions.R")
  JAF_INDICATORS <<- list()
}
if (interactive() && exists("JAF_INDICATORS")) repeat {
  answer = toupper(readline("Re-calculate everything? (Y/N): "))
  if (answer=="Y") {
    init()
    break
  } else if (answer=="N") break
} else init()

source('JAF_indicators__definitions.R')

source('JAF_output.R')
