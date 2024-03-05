### Compiled automatically by rutkoal
### from `Ioanna's modified and added indicators.xlsx`
### on 2024-03-04 15:49:36.616552
### 
### 

inside(JAF_INDICATORS, indicator_named = "PA1.C3.15-74") = 
specification(
name = "Unemployment rate in age group 15-74 - total",
unit_of_level = "% (of active popn 15-74)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="T", unit="PC", citizen="TOTAL", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.15-74.F") = 
specification(
name = "Unemployment rate in age group 15-74 - women",
unit_of_level = "% (of active women 15-74)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="F", unit="PC", citizen="TOTAL", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.15-74.M") = 
specification(
name = "Unemployment rate in age group 15-74 - men ",
unit_of_level = "% (of active men 15-74)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="M", unit="PC", citizen="TOTAL", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.EU27_2020") = 
specification(
name = "Unemployment rate non-national EU27_2020 citizens (15-74)",
unit_of_level = "% (of active non-nationals)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="T", unit="PC", citizen="EU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.high") = 
specification(
name = "Unemployment rate high education attainment (15-74)",
unit_of_level = "% (of active high educ)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgaed",
   with_filters(isced11="ED5-8", sex="T", unit="PC", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.low") = 
specification(
name = "Unemployment rate low education attainment (15-74)",
unit_of_level = "% (of active low educ)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgaed",
   with_filters(isced11="ED0-2", sex="T", unit="PC", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C3.nonEU27_2020") = 
specification(
name = "Unemployment rate non-EU27_2020 citizens (15-74)",
unit_of_level = "% (of active non-EU27)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C4.high") = 
specification(
name = "Activity rate high education attainment (20-64)",
unit_of_level = "% (of high educ)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_argaed",
   with_filters(isced11="ED5-8", sex="T", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C4.low") = 
specification(
name = "Activity rate low education attainment (20-64)",
unit_of_level = "% (of low educ)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_argaed",
   with_filters(isced11="ED0-2", sex="T", unit="PC", age="Y20-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C4.M") = 
specification(
name = "Activity rate of population 20-64 - men",
unit_of_level = "% (of popn 20-64)",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsi_emp_a",
   with_filters(sex="M", unit="PC_POP", age="Y20-64", indic_em="ACT"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C4.nonEU27_2020") = 
specification(
name = "Activity rate non-EU27_2020 citizens (15-74)",
unit_of_level = "% (of non-EU27_2020)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 1 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_argan",
   with_filters(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C4.W") = 
specification(
name = "Activity rate of population 20-64 - women",
unit_of_level = "% (of popn 20-64)",
indicator_groups = "CONTEXT COMPENDIUM 8 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsi_emp_a",
   with_filters(sex="F", unit="PC_POP", age="Y20-64", indic_em="ACT"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C20-29.M") = 
specification(
name = "Employment rate of young people aged 20-29 - men",
unit_of_level = "% (of popn 20-29)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(age="Y20-29", isced11="TOTAL", sex="M", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA1.C20-29.W") = 
specification(
name = "Employment rate of young people aged 20-29 - women",
unit_of_level = "% (of popn 20-29)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_ergaed",
   with_filters(age="Y20-29", isced11="TOTAL", sex="F", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.S2.") = 
specification(
name = "Youth unemployment rate, for population aged 15-29 - total",
unit_of_level = "% (of active popn 15-29)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("une_rt_a",
   with_filters(sex="T", unit="PC_ACT", age="Y15-29"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.S3.") = 
specification(
name = "Youth unemployment ratio, for population aged 15-24 - total",
unit_of_level = "% (of popn 15-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(100 * a/b,
where = variables(
 a = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-24", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="UNE")),
 b = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-24", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="POP"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.S4.") = 
specification(
name = "Ratio of Youth unemployment ratio (15-24) to Adult unemployment ratio (25-74)",
unit_of_level = "ratio",
unit_of_change = "ratio change",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula((a/b)/((c - a)/(d - b)),
where = variables(
 a = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-24", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="UNE")),
 b = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-24", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="POP")),
 c = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-74", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="UNE")),
 d = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-74", citizen="TOTAL", sex="T", unit="THS_PER", wstatus="POP"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.low.F") = 
specification(
name = "NEET rates for age group 18-24 with low education attainment - women",
unit_of_level = "% (of low-skilled women 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED0-2", sex="F", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.low.M") = 
specification(
name = "NEET rates for age group 18-24 with low education attainment - men",
unit_of_level = "% (of low-skilled men 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED0-2", sex="M", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.low.T") = 
specification(
name = "NEET rates for age group 18-24 with low education attainment - total",
unit_of_level = "% (of low-skilled popn 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED0-2", sex="T", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.med-high.F") = 
specification(
name = "NEET rates for age group 18-24 with upper secondary or tertiary education - women",
unit_of_level = "% (of med&high-skilled women 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED3-8", sex="F", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.med-high.M") = 
specification(
name = "NEET rates for age group 18-24 with upper secondary or tertiary education - men",
unit_of_level = "% (of med&high-skilled men 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED3-8", sex="M", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C2.med-high.T") = 
specification(
name = "NEET rates for age group 18-24 with upper secondary or tertiary education - total",
unit_of_level = "% (of med&high-skilled popn 18-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("edat_lfse_21",
   with_filters(isced11="ED3-8", sex="T", unit="PC", wstatus="NEMP", age="Y18-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C4.F") = 
specification(
name = "Youth unemployment rate, for population aged 15-29 - women",
unit_of_level = "% (of active women 15-29)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("une_rt_a",
   with_filters(sex="F", unit="PC_ACT", age="Y15-29"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C4.M") = 
specification(
name = "Youth unemployment rate, for population aged 15-29 - men",
unit_of_level = "% (of active men 15-29)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("une_rt_a",
   with_filters(sex="M", unit="PC_ACT", age="Y15-29"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C5.F") = 
specification(
name = "Youth unemployment ratio, for population aged 15-24 - women",
unit_of_level = "% (of women 15-29)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(100 * a/b,
where = variables(
 a = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-29", citizen="TOTAL", sex="F", unit="THS_PER", wstatus="UNE")),
 b = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-29", citizen="TOTAL", sex="F", unit="THS_PER", wstatus="POP"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C5.M") = 
specification(
name = "Youth unemployment ratio, for population aged 15-24 - men",
unit_of_level = "% (of men 15-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(100 * a/b,
where = variables(
 a = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-29", citizen="TOTAL", sex="M", unit="THS_PER", wstatus="UNE")),
 b = fromEurostatDataset('lfsa_pganws',
  with_filters(age="Y15-29", citizen="TOTAL", sex="M", unit="THS_PER", wstatus="POP"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C7.15-24.M") = 
specification(
name = "Unemployment rate in age group 15-24 - men ",
unit_of_level = "% (of active men 15-24)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="M", unit="PC", citizen="TOTAL", age="Y15-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C7.15-24.T") = 
specification(
name = "Unemployment rate in age group 15-24 - total",
unit_of_level = "% (of active popn 15-24)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="T", unit="PC", citizen="TOTAL", age="Y15-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1b.C7.15-24.W") = 
specification(
name = "Unemployment rate in age group 15-24 - women",
unit_of_level = "% (of active women  15-24)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="F", unit="PC", citizen="TOTAL", age="Y15-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA1c.C11.M") = 
specification(
name = "Unemployment rate (55-64) -men",
unit_of_level = "% (of active popn 55-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = NA,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="M", unit="PC", citizen="TOTAL", age="Y55-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1c.C11.W") = 
specification(
name = "Unemployment rate (55-64) -women",
unit_of_level = "% (of active popn 55-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = NA,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="F", unit="PC", citizen="TOTAL", age="Y55-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1c.C15.M") = 
specification(
name = "Participation in education and training aged 55-64 - men",
unit_of_level = "% (of popn 55-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("trng_lfs_01",
   with_filters(sex="M", unit="PC", age="Y55-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1c.C15.W") = 
specification(
name = "Participation in education and training aged 55-64 - women",
unit_of_level = "% (of popn 55-64)",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("trng_lfs_01",
   with_filters(sex="F", unit="PC", age="Y55-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C5.F") = 
specification(
name = "Unemployment rate for non-EU nationals aged 15-74- women",
unit_of_level = "% (of active women non-EU nationals)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="F", unit="PC", citizen="NEU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C5.M") = 
specification(
name = "Unemployment rate for non-EU nationals aged 15-74 - men",
unit_of_level = "% (of active men non-EU nationals)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="M", unit="PC", citizen="NEU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C5.T") = 
specification(
name = "Unemployment rate for non-EU nationals aged15-74 - total",
unit_of_level = "% (of active non-EU nationals)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C6.F") = 
specification(
name = "Unemployment rate for people aged 15-74 born outside EU - women",
unit_of_level = "% (of activewomen born out EU27)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgacob",
   with_filters(c_birth="NEU27_2020_FOR", sex="F", unit="PC", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C6.M") = 
specification(
name = "Unemployment rate for people aged 15-74 born outside EU - men",
unit_of_level = "% (of active men born out EU27)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgacob",
   with_filters(c_birth="NEU27_2020_FOR", sex="M", unit="PC", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA1d.C6.T") = 
specification(
name = "Unemployment rate for people aged 15-74 born outside EU - total",
unit_of_level = "% (of active born out EU27)",
unit_of_change = "pp",
indicator_groups = "OUTPUT CONTEXT COMPENDIUM 2 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_urgacob",
   with_filters(c_birth="NEU27_2020_FOR", sex="T", unit="PC", age="Y15-74"))
)

inside(JAF_INDICATORS, indicator_named = "PA2a.S1.Y15-24") = 
specification(
name = "Involuntary temporary employment as % of total employees in age group 15-24",
unit_of_level = "% (of employees 15-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromEurostatDataset("lfsa_etgar",
   with_filters(age="Y15-24", sex="T", reason="NF_PJOB", unit="PC_SAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA2a.S1.Y25-54") = 
specification(
name = "Involuntary temporary employment as % of total employees in age group 25-54",
unit_of_level = "% (of employees 25-54)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula(((a * b) - (c * d))/(e - f),
where = variables(
 a = fromEurostatDataset('lfsa_etgaed',
  with_filters(age="Y25-64", isced11="TOTAL", sex="T", unit="THS_PER")),
 b = fromEurostatDataset('lfsa_etgar',
  with_filters(age="Y25-64", reason="NF_PJOB", sex="T", unit="PC_SAL_TEMP")),
 c = fromEurostatDataset('lfsa_etgaed',
  with_filters(age="Y55-64", isced11="TOTAL", sex="T", unit="THS_PER")),
 d = fromEurostatDataset('lfsa_etgar',
  with_filters(age="Y55-64", reason="NF_PJOB", sex="T", unit="PC_SAL_TEMP")),
 e = fromEurostatDataset('lfsa_eegaed',
  with_filters(age="Y25-64", isced11="TOTAL", sex="T", unit="THS_PER")),
 f = fromEurostatDataset('lfsa_eegaed',
  with_filters(age="Y55-64", isced11="TOTAL", sex="T", unit="THS_PER"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA2a.S6.Y15-24") = 
specification(
name = "Share of temporary employees due to education or training (15-24)",
unit_of_level = "% (of temp employees 15-24) ",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_etgar",
   with_filters(sex="T", reason="EDUC_TNG", unit="PC_SAL_TEMP", age="Y15-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA2b.S2.") = 
specification(
name = "Newly employed young (aged 15-24) in %",
unit_of_level = "% (of young employed 15-24)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_enewasn",
   with_filters(unit="PC", citizen="TOTAL", wstatus="EMP", age="Y15-24"))
)

inside(JAF_INDICATORS, indicator_named = "PA2b.S4.Y15_24") = 
specification(
name = "Job tenure in years (15-24)",
unit_of_level = "job tenure (yrs)",
unit_of_change = "yrs",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_egasjt",
   with_filters(age="Y15-24", sex="T", wstatus="EMP", unit="YR"))
)

inside(JAF_INDICATORS, indicator_named = "PA2b.S4.Y15_64") = 
specification(
name = "Job tenure in years (15-64)",
unit_of_level = "job tenure (yrs)",
unit_of_change = "yrs",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_egasjt",
   with_filters(age="Y15-64", sex="T", wstatus="EMP", unit="YR"))
)

inside(JAF_INDICATORS, indicator_named = "PA2b.S4.Y25_54") = 
specification(
name = "Job tenure in years (25-54)",
unit_of_level = "job tenure (yrs)",
unit_of_change = "yrs",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_egasjt",
   with_filters(age="Y25-54", sex="T", wstatus="EMP", unit="YR"))
)

inside(JAF_INDICATORS, indicator_named = "PA2b.S4.Y55_64") = 
specification(
name = "Job tenure in years (55-64)",
unit_of_level = "job tenure (yrs)",
unit_of_change = "yrs",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 3 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = TRUE,
value = fromEurostatDataset("lfsa_egasjt",
   with_filters(age="Y55-64", sex="T", wstatus="EMP", unit="YR"))
)

inside(JAF_INDICATORS, indicator_named = "PA3.S1.") = 
specification(
name = "Rate of long-term unemployment of the young (as % active population aged 15-29) - total",
unit_of_level = "% (of active popn 15-29)",
unit_of_change = "pp",
indicator_groups = "INPUT SUBINDICATOR COMPENDIUM 4 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula((a * b - 1)/100,
where = variables(
 a = fromEurostatDataset('lfsa_upgan',
  with_filters(age="Y15-29", citizen="TOTAL", sex="T", unit="PC")),
 b = fromEurostatDataset('lfsa_urgan',
  with_filters(age="Y15-29", citizen="TOTAL", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA3.S2.") = 
specification(
name = "Rate of long-term unemployment of the not-young (as % active population aged 25-64) - total",
unit_of_level = "% (of active popn 25-64)",
unit_of_change = "pp",
indicator_groups = "INPUT SUBINDICATOR COMPENDIUM 4 COUNTRY",
source = "Eurostat, EU Labour Force Survey",
high_is_good = FALSE,
value = fromFormula((a * b - 1)/100,
where = variables(
 a = fromEurostatDataset('lfsa_upgan',
  with_filters(age="Y25-64", citizen="TOTAL", sex="T", unit="PC")),
 b = fromEurostatDataset('lfsa_urgan',
  with_filters(age="Y25-64", citizen="TOTAL", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA3.S6.") = 
specification(
name = "Unemployment rate (15-74 year old)",
unit_of_level = "% (of active popn 15-74)",
indicator_groups = "SECONDARY COMPENDIUM 8 COUNTRY",
source = "Eurostat, LFS",
high_is_good = NA,
value = fromEurostatDataset("lfsa_urgan",
   with_filters(age="Y15-74", sex="T", unit="PC", citizen="Total"))
)

inside(JAF_INDICATORS, indicator_named = "PA6a.S5.") = 
specification(
name = "Employment in newly established enterprises",
unit_of_level = "% (of current employment in all active enterprises)",
unit_of_change = "pp",
indicator_groups = "OUTPUT SUBINDICATOR COMPENDIUM 5 COUNTRY",
source = "Eurostat, Structural Business Statistics",
high_is_good = TRUE,
value = fromFormula((a + b + c + d)/e,
where = variables(
 a = fromEurostatDataset('bd_9bd_sz_cl_r2',
  with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16920")),
 b = fromEurostatDataset('bd_9bd_sz_cl_r2',
  with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16941")),
 c = fromEurostatDataset('bd_9bd_sz_cl_r2',
  with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16942")),
 d = fromEurostatDataset('bd_9bd_sz_cl_r2',
  with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16943")),
 e = fromEurostatDataset('bd_9bd_sz_cl_r2',
  with_filters(nace_r2="B-S_X_K642", sizeclas="TOTAL", indic_sb="V16910"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA8.1.C6.T") = 
specification(
name = "Employed ICT specialists - total",
unit_of_level = "Percentage of total employment",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat",
high_is_good = NA,
value = fromEurostatDataset("isoc_sks_itspt",
   with_filters(unit="PC_EMP"))
)

inside(JAF_INDICATORS, indicator_named = "PA8.1.C6.W") = 
specification(
name = "Employed ICT specialists by sex - women",
unit_of_level = "Percentage",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat",
high_is_good = NA,
value = fromEurostatDataset("isoc_sks_itsps",
   with_filters(unit="PC", sex="F"))
)

inside(JAF_INDICATORS, indicator_named = "PA8.1.C7.") = 
specification(
name = "Enterprises that provided training to develop/upgrade ICT skills of their personnel by size class of enterprise",
unit_of_level = "Percentage of enterprises",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat",
high_is_good = NA,
value = fromEurostatDataset("isoc_ske_itts",
   with_filters(unit="PC_ENT", size_emp="GE10", nace_r2="C10-S951_X_K", indic_is="E_ITT2"))
)

inside(JAF_INDICATORS, indicator_named = "PA8.2.S4._added") = 
specification(
name = "General government expenditure by function (COFOG) - education",
unit_of_level = "Percentage of GDP",
indicator_groups = "SECONDARY COMPENDIUM 8",
source = "Eurostat",
high_is_good = NA,
value = fromEurostatDataset("gov_10a_exp",
   with_filters(unit="PC_GDP", sector="S13", cofog99="GF09", na_item="TE"))
)

inside(JAF_INDICATORS, indicator_named = "PA8.2.S4._modified") = 
specification(
name = "Public spending on human resources – total public expenditure in education as % of GDP ",
unit_of_level = "% (of GDP)",
unit_of_change = "pp",
indicator_groups = "INPUT SUBINDICATOR COMPENDIUM 7 COUNTRY",
source = "Eurostat, UOE",
high_is_good = TRUE,
value = fromEurostatDataset("educ_figdp",
   with_filters(indic_ed="FP01_1", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA9.1.S1.") = 
specification(
name = "Pupils from age 3 to the starting age of compulsory education at primary level by sex - % of the population of the corresponding age",
unit_of_level = "% of the population of the corresponding age",
indicator_groups = "SUBINDICATOR COMPENDIUM 8 COUNTRY",
source = "Eurostat",
high_is_good = TRUE,
value = fromEurostatDataset("educ_uoe_enra21",
   with_filters(sex="T", unit="PC"))
)

inside(JAF_INDICATORS, indicator_named = "PA10.C3.") = 
specification(
name = "Labour productivity per person employed (EU-27 = 100, based on PPS per employed person)",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, National Accounts",
high_is_good = TRUE,
value = fromEurostatDataset("tesem160",
   with_filters(na_item="NLPR_PER", unit="PC_EU27_2020_MPPS_CP"))
)

inside(JAF_INDICATORS, indicator_named = "PA10.C4.") = 
specification(
name = "Labour productivity per hour worked, (EU-27 = 100, based on PPS per hour worked)",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, National Accounts",
high_is_good = TRUE,
value = fromEurostatDataset("tesem160",
   with_filters(na_item="NLPR_HW", unit="PC_EU27_2020_MPPS_CP"))
)

inside(JAF_INDICATORS, indicator_named = "PA10.C5.") = 
specification(
name = "Nominal unit labour cost growth (% change from previous year)",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat, National Accounts",
high_is_good = FALSE,
value = fromEurostatDataset("NAMA_10_LP_ULC",
   with_filters(na_item="NULC_PER", unit="PCH_PRE"))
)

inside(JAF_INDICATORS, indicator_named = "PA10.C6.") = 
specification(
name = "Real unit labour cost growth (% change from previous year)",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "AMECO",
high_is_good = FALSE,
value = fromFormula((a/b - 1)*100,
where = variables(
 a = fromAMECO('QLCD'),
 b = fromAMECO('QLCD', time_period = -1)
))
)

inside(JAF_INDICATORS, indicator_named = "PA9.2.C1.25-34") = 
specification(
name = "Completion of tertiary or equivalent education (aged 25-34) / Population by educational attainment level - tertiary",
unit_of_level = "",
indicator_groups = "COMPENDIUM 8",
source = "Eurostat",
high_is_good = TRUE,
value = fromEurostatDataset("edat_lfse_03",
   with_filters(age="Y25-34", sex="T", unit="PC")) # needs isced11
)

inside(JAF_INDICATORS, indicator_named = "PA9.2.C4") = 
specification(
name = "Graduates in tertiary education, in science, math., computing, engineering, manufacturing, construction, by sex - per 1000 of population aged 20-29",
unit_of_level = "",
indicator_groups = "CONTEXT COMPENDIUM 8",
source = "Eurostat",
high_is_good = NA,
value = fromEurostatDataset("educ_uoe_grad04",
   with_filters(sex="T", unit="P_THAB")) # needs isced11
)


### Mis-specified indicators are commented-out below -- but some valid indicators below too,
### the valid ones are those with significantly modified definitions compared to the catalogue




