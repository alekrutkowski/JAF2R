### Compiled automatically by rutkoal
### from `Additional Indicators from Ioanna.xlsx`
### on 2024-03-06 15:32:12.683933
### 
### 

inside(JAF_INDICATORS, indicator_named = "PA1.S5.") = 
specification(
name = "Employment rate of population aged 30-54 - total",
unit_of_level = "% (of popn 30-54)",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(age="Y30-54", isced11="TOTAL", sex="T", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C2.30-54.F") = 
specification(
name = "Employment rate of  population aged 30-54 - women",
unit_of_level = "% (of popn 30-54)",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(age="Y30-54", isced11="TOTAL", sex="F", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C2.30-54.M") = 
specification(
name = "Employment rate of  population aged 30-54 - men",
unit_of_level = "% (of popn 30-54)",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(age="Y30-54", isced11="TOTAL", sex="M", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C5.20-64.F") = 
specification(
name = "Employment rate of low-skilled population aged 20-64 - women",
unit_of_level = "% (of low-skilled popn 20-64)",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(isced11="ED0-2", sex="F", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C5.20-64.M") = 
specification(
name = "Employment rate of low-skilled population aged 20-64 - men",
unit_of_level = "% (of low-skilled popn 20-64)",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(isced11="ED0-2", sex="M", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C6.20-64.F") = 
specification(
name = "Employment rate of high skilled (20-64) women",
unit_of_level = "% (of high-skilled popn 20-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(isced11="ED5-8", sex="F", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C6.20-64.M") = 
specification(
name = "Employment rate of high skilled (20-64) men",
unit_of_level = "% (of high-skilled popn 20-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(isced11="ED5-8", sex="M", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C6.20-64.T") = 
specification(
name = "Employment rate of high skilled (20-64) ",
unit_of_level = "% (of high-skilled popn 20-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(isced11="ED5-8", sex="T", unit="PC", age="Y20-64"))
)


### Mis-specified indicators are commented-out below -- but some valid indicators below too,
### the valid ones are those with significantly modified definitions compared to the catalogue




