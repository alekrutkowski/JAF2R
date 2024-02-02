### Compiled automatically by rutkoal
### on 2024-02-02 16:52:53

inside(JAF_INDICATORS, indicator_named = "PA11.S20.") = 
specification(
name = "Material and social deprivation rate - total",
unit_of_level = "% (of total popn)",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S20.F") = 
specification(
name = "Material and social deprivation rate - women",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="F", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S20.M") = 
specification(
name = "Material and social deprivation rate - men",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="M", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C10.") = 
specification(
name = "Benefit recipient rate for people (18-64) at risk of poverty in (quasi-) jobless households",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = TRUE,
value = fromEurostatDataset("ILC_LI70",
   with_filters(sex="T", unit="PC", workint="WI0-02", yn_rskpov="YES_ARP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11a.S20.") = 
specification(
name = "Material and social deprivation rate (0-17)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="Y_LT18"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S12.F") = 
specification(
name = "Material and Social Deprivation rate (18-64) - women",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="F", unit="PC", age="Y18-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S12.M") = 
specification(
name = "Material and Social Deprivation rate (18-64) - men",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="M", unit="PC", age="Y18-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S13.F") = 
specification(
name = "In-work material and social deprivation rate ((18-64), for those in employment) - women",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd01",
   with_filters(sex="F", unit="PC", age="Y18-64", wstatus="EMP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S13.M") = 
specification(
name = "In-work material and social deprivation rate ((18-64), for those in employment) - men",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd01",
   with_filters(sex="M", unit="PC", age="Y18-64", wstatus="EMP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.S13.T") = 
specification(
name = "In-work material and social deprivation rate ((18-64), for those in employment) - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd01",
   with_filters(sex="T", unit="PC", age="Y18-64", wstatus="EMP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11b.C10.") = 
specification(
name = "Benefit recipient rate for people (18-64) at risk of poverty in (quasi-)jobless households",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = TRUE,
value = fromEurostatDataset("ILC_LI70",
   with_filters(sex="T", unit="PC", workint="WI0-02", yn_rskpov="YES_ARP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.S20.") = 
specification(
name = "Material and social deprivation rate (65+)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd07",
   with_filters(sex="T", unit="PC", age="Y_GE65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.S21.") = 
specification(
name = "Gender Pension Gap (65 or over)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_PNP13",
   with_filters(age="Y_GE65", unit="AVG"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.C8.F") = 
specification(
name = "Healthy life years at 65 - women",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("hlth_hlye",
   with_filters(sex="F", unit="YR", indic_he="HLY_65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.C8.M") = 
specification(
name = "Healthy life years at 65 - men",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("hlth_hlye",
   with_filters(sex="M", unit="YR", indic_he="HLY_65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.C8.T") = 
specification(
name = "Healthy life years at 65 - Total",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("hlth_hlye",
   with_filters(sex="T", unit="YR", indic_he="HLY_65"))
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

inside(JAF_INDICATORS, indicator_named = "PA11d1.S1.") = 
specification(
name = "S80/S50",
unit_of_level = "ratio",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
calculate_score_change = FALSE,
value = fromEurostatDataset("ilc_di11d",
   with_filters(sex="T", age="TOTAL", unit="RAT"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.S2.") = 
specification(
name = "S50/S20",
unit_of_level = "ratio",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
calculate_score_change = FALSE,
value = fromEurostatDataset("ilc_di11e",
   with_filters(sex="T", age="TOTAL", unit="RAT"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.S3.") = 
specification(
name = "S40/S100",
unit_of_level = "ratio",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
calculate_score_change = FALSE,
value = fromEurostatDataset("ilc_di11f",
   with_filters(sex="T", age="TOTAL", unit="RAT"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.C1.high") = 
specification(
name = "Life expectancy by level of education - high",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("demo_mlexpecedu",
   with_filters(sex="T", isced11="ED5-8", unit="YR", age="Y_LT1"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.C1.Low") = 
specification(
name = "Life expectancy by level of education - low",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("demo_mlexpecedu",
   with_filters(sex="T", isced11="ED0-2", unit="YR", age="Y_LT1"))
)

inside(JAF_INDICATORS, indicator_named = "PA11d1.C1.Medium") = 
specification(
name = "Life expectancy by level of education - medium",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "",
high_is_good = TRUE,
value = fromEurostatDataset("demo_mlexpecedu",
   with_filters(sex="T", isced11="ED3_4", unit="YR", age="Y_LT1"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion rate for people with disabilities  - total",
unit_of_level = "",
indicator_groups = "OVERALL COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("HLTH_DPE010",
   with_filters(sex="T", age="Y_GE16", lev_limit="SM_SEV", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for people with disabilities - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("HLTH_DPE020",
   with_filters(sex="T", age="Y_GE16", lev_limit="SM_SEV", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S2.") = 
specification(
name = "Severe material or social deprivation rate for people with disabilities (7+ items) - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("HLTH_DM010",
   with_filters(sex="T", age="Y_GE16", lev_limit="SM_SEV", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S4.") = 
specification(
name = "Impact of social transfers (including pensions) in reducing poverty of people with disabilities",
unit_of_level = "% reduction in risk of poverty",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = TRUE,
value = fromFormula(100 * ((a - b)/a),
where = variables(
 a = fromEurostatDataset('hlth_dpe030',
  with_filters(age="Y_GE16", lev_limit="SM_SEV", sex="T")),
 b = fromEurostatDataset('hlth_dpe020',
  with_filters(age="Y_GE16", lev_limit="SM_SEV", sex="T"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S5.") = 
specification(
name = "Disability employment gap - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("tepsr_sp200",
   with_filters(sex="T", unit="PC_PNT", lev_limit="SM_SEV"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S6.") = 
specification(
name = "Disability employment gap - men",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("tepsr_sp200",
   with_filters(sex="M", unit="PC_PNT", lev_limit="SM_SEV"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f1.S7.") = 
specification(
name = "Disability employment gap - women",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("tepsr_sp200",
   with_filters(sex="F", unit="PC_PNT", lev_limit="SM_SEV"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for migrants  - total aged 18 and over",
unit_of_level = "",
indicator_groups = "OVERALL COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_PEPS06N",
   with_filters(sex="T", unit="PC", age="Y_GE18", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for migrants - total aged 18 and over",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI32",
   with_filters(sex="T", unit="PC", age="Y_GE18", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.S2.") = 
specification(
name = "Severe material or social deprivation rate for migrants (7+ items) - total aged 18 and over",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd16",
   with_filters(sex="T", unit="PC", age="Y_GE18", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.S3.") = 
specification(
name = "Share of migrants living in (quasi-)jobless households - total aged 18 - 64 years",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LVHL16N",
   with_filters(sex="T", unit="PC", age="Y18-64", c_birth="NEU27_2020_FOR"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f2.S5.") = 
specification(
name = "Employment gap of migrants ",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(a-b,
where = variables(
 a = fromEurostatDataset('lfsa_ergacob',
  with_filters(age="Y15-64", c_birth="NAT", sex="T", unit="PC")),
 b = fromEurostatDataset('lfsa_ergacob',
  with_filters(age="Y15-64", c_birth="NEU27_2020_FOR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for low-skilled people  - total",
unit_of_level = "",
indicator_groups = "OVERALL COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_PEPS04N",
   with_filters(age="Y_GE18", sex="T", isced11="ED0-2", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for low-skilled people - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI07",
   with_filters(age="Y_GE18", sex="T", isced11="ED0-2", unit="PC", indic_il="LI_R_MD60"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.S3.") = 
specification(
name = "Share of low-skilled people (aged 18-64) living in (quasi-)jobless households - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LVHL14N",
   with_filters(age="Y18-64", sex="T", isced11="ED0-2", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f3.S5.") = 
specification(
name = "Employment gap of low-skilled",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(a-b,
where = variables(
 a = fromEurostatDataset('lfsi_emp_a',
  with_filters(age="Y15-64", indic_em="EMP_LFS", sex="T", unit="PC_POP")),
 b = fromEurostatDataset('lfsi_educ_a',
  with_filters(age="Y15-64", isced11="ED0-2", sex="T", unit="PC_POP"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11f4.O1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for people living in (quasi-)jobless households - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ILC_LI06",
   with_filters(age="Y_LT65", indic_il="LI_R_MD60", sex="T", workint="WI0-02", hhtyp="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.O1.") = 
specification(
name = "At-risk-of poverty or social exclusion for young people (18- 24) - total",
unit_of_level = "",
indicator_groups = "OVERALL COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(age="Y18-24", sex="T", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S1.") = 
specification(
name = "At-risk-of poverty rate (60% of median income) for young people (18- 24) - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li02",
   with_filters(age="Y18-24", sex="T", unit="PC", indic_il="LI_R_MD60"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S2.") = 
specification(
name = "Severe material or social deprivation rate for young people (18- 24) - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd11",
   with_filters(age="Y18-24", sex="T", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S3.") = 
specification(
name = "Share of for young people (aged 18-24) living in (quasi-)jobless households - total",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_lvhl11n",
   with_filters(age="Y18-24", sex="T", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S4.") = 
specification(
name = "Impact of social transfers (other than pensions) in reducing poverty of young people (18-24)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = TRUE,
value = fromFormula(100 * ((a - b)/a),
where = variables(
 a = fromEurostatDataset('ilc_li10',
  with_filters(age="Y18-24", indic_il="LI_R_MD60BT", sex="T")),
 b = fromEurostatDataset('ilc_li02',
  with_filters(age="Y18-64", indic_il="LI_R_MD60", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S5.") = 
specification(
name = "NEET rate (15-29)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsi_neet_a",
   with_filters(age="Y15-29", sex="T", unit="PC_POP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S6.") = 
specification(
name = "Early leavers from education and training (aged 18-24) - total",
unit_of_level = "% (of popn 18-24)",
unit_of_change = "pp",
indicator_groups = "SUBINDICATOR COMPENDIUM 9 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_14",
   with_filters(age="Y18-24", sex="T", unit="PC", wstatus="POP"))
)

inside(JAF_INDICATORS, indicator_named = "PA11f5.S7.") = 
specification(
name = "Youth unemployment ratio (15-29)",
unit_of_level = "",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("une_rt_a",
   with_filters(age="Y15-29", sex="T", unit="PC_POP"))
)
