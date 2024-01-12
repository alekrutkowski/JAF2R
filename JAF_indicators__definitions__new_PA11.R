### Compiled automatically by rutkoal
### from `New PA11 indicators catalogue.xlsx`, worksheet `IndicatorsTable`
### on 2024-01-12 17:41:20.269521
### 13 defined indicators.
### 0 mis-defined indicators.

inside(JAF_INDICATORS, indicator_named = "PA11.S20.") = 
specification(
name = "Material and social deprivation rate - total",
unit_of_level = "% (of total popn)",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11a.S20.") = 
specification(
name = "Material and social deprivation rate (0-17)",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="Y_LT18"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S12.M") = 
specification(
name = "Material and Social Deprivation rate (18-64) - men",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="M", unit="PC", age="Y18-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.S20.") = 
specification(
name = "Material and social deprivation rate (65+)",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="Y_GE65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.O1.") = 
specification(
name = "S80/S20",
unit_of_level = "ratio",
indicator_groups = "OVERALL COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
calculate_score_change = FALSE,
value = fromEurostatDataset("ilc_di11",
   with_filters(sex="T", age="TOTAL", unit="RAT"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion rate for people with disabilities  - total",
unit_of_level = "NA",
indicator_groups = "OVERALL COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("HLTH_DPE010",
   with_filters(sex="T", age="Y_GE16", lev_limit="SM_SEV", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for people with disabilities - total",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("HLTH_DPE020",
   with_filters(sex="T", age="Y_GE16", lev_limit="SM_SEV", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for migrants  - total aged 18 and over",
unit_of_level = "NA",
indicator_groups = "OVERALL COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_PEPS06N",
   with_filters(sex="T", unit="PC", age="Y_GE18", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for migrants - total aged 18 and over",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI32",
   with_filters(sex="T", unit="PC", age="Y_GE18", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for low-skilled people  - total",
unit_of_level = "NA",
indicator_groups = "OVERALL COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_PEPS04N",
   with_filters(sex="T", unit="PC", isced11="ED0-2", age="Y_GE18"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for low-skilled people - total",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI07",
   with_filters(sex="T", unit="PC", isced11="ED0-2", age="Y_GE18"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f4.O1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for people living in (quasi-)jobless households - total",
unit_of_level = "NA",
indicator_groups = "SUBINDICATOR COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI06",
   with_filters(age="Y_LT65", indic_il="LI_R_MD60", sex="T", workint="WI0-02", hhtyp="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for young people (18- 24) - total",
unit_of_level = "NA",
indicator_groups = "OVERALL COMPENDIUM COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(age="Y18-24", sex="T", unit="PC"))
)


### Mis-specified indicators are commented-out below -- but some valid indicators below too,
### the valid ones are those with significantly modified definitions compared to the catalogue




