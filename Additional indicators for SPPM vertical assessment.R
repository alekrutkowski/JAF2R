# Based on JAF indicators for SPPM vertical assessment - KSC-GSO_to F4_6 10 23.xlsx
# from Maria (D1) on 6 Oct. 2023

inside(JAF_INDICATORS, indicator_named = "PA11.O1.M") = 
specification(
name = "People at-risk-of poverty or social exclusion - men",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(sex="M", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.O1.F") = 
specification(
name = "People at-risk-of poverty or social exclusion - women",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(sex="F", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S1.M") = 
specification(
name = "At-risk-of poverty rate (60% of median income) - men",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li02",
   with_filters(sex="M", unit="PC", indic_il="LI_R_MD60", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S1.F") = 
specification(
name = "At-risk-of poverty rate (60% of median income) - women",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li02",
   with_filters(sex="F", unit="PC", indic_il="LI_R_MD60", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S2.M") = 
specification(
name = "Severe material and social deprivation rate (7+ items) - men",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd11",
   with_filters(sex="M", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S2.F") = 
specification(
name = "Severe material and social deprivation rate (7+ items) - women",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_mdsd11",
   with_filters(sex="F", unit="PC", age="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.O1.M") = 
specification(
name = "People at risk of poverty or social exclusion (aged 65+) - men",
unit = "% (of popn 65+)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(sex="M", unit="PC", age="Y_GE65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11c.O1.F") = 
specification(
name = "People at risk of poverty or social exclusion (aged 65+) - women",
unit = "% (of popn 65+)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_peps01n",
   with_filters(sex="F", unit="PC", age="Y_GE65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S9.0-17") = 
specification(
name = "Persistent at-risk-of-poverty rate (0-17)",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li21",
   with_filters(sex="T", indic_il="LIP_MD60", age="Y_LT18"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S9.18-64") = 
specification(
name = "Persistent at-risk-of-poverty rate (18-64)",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li21",
   with_filters(sex="T", indic_il="LIP_MD60", age="Y18-64"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S9.GE65") = 
specification(
name = "Persistent at-risk-of-poverty rate (18-64)",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li21",
   with_filters(sex="T", indic_il="LIP_MD60", age="Y_GE65"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S6.18-64") = 
specification(
name = "At-risk of poverty rate for population living in (quasi-)jobless households (18-64)",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li06",
   with_filters(sex="T", workint="WI0-02", indic_il="LI_R_MD60", age="Y18-64", hhtyp="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.S6.18-64.WI02-045") = 
specification(
name = "At-risk of poverty rate for population living in low work intensity households (18-64)",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromEurostatDataset("ilc_li06",
   with_filters(sex="T", workint="WI02-045", indic_il="LI_R_MD60", age="Y18-64", hhtyp="TOTAL"))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.T.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - total",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="TOTAL", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q1.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - Q1",
unit = "% (of popn in q1)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU1", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q2.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - Q2",
unit = "% (of popn in q2)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU2", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q3.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - Q3",
unit = "% (of popn in q3)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU3", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q4.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - Q4",
unit = "% (of popn in q4)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU4", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q5.TOOEXP") = 
specification(
name = "Unmet need for medical care due to cost by income quintile - Q5",
unit = "% (of popn in q5)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU5", reason="TOOEXP", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.T.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - total",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="TOTAL", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q1.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - Q1",
unit = "% (of popn in q1)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU1", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q2.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - Q2",
unit = "% (of popn in q2)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU2", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q3.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - Q3",
unit = "% (of popn in q3)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU3", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q4.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - Q4",
unit = "% (of popn in q4)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU4", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q5.TOOFAR") = 
specification(
name = "Unmet need for medical care due to distance by income quintile - Q5",
unit = "% (of popn in q5)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU5", reason="TOOFAR", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.T.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - total",
unit = "% (of total popn)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="TOTAL", reason="NOTIME", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q1.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - Q1",
unit = "% (of popn in q1)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU1", reason="NOTIME", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q2.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - Q2",
unit = "% (of popn in q2)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU2", reason="NOTIME", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q3.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - Q3",
unit = "% (of popn in q3)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU3", reason="NOTIME", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q4.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - Q4",
unit = "% (of popn in q4)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU4", reason="NOTIME", sex="T", unit="PC"))
))
)

inside(JAF_INDICATORS, indicator_named = "PA11.C11.Q5.NOTIME") = 
specification(
name = "Unmet need for medical care due to waiting time by income quintile - Q5",
unit = "% (of popn in q5)",
source = "Eurostat, EU Statistics on Income and Living Conditions",
high_is_good = FALSE,
value = fromFormula(a,
where = variables(
 a = fromEurostatDataset('hlth_silc_08',
  with_filters(age="Y_GE16", quantile="QU5", reason="NOTIME", sex="T", unit="PC"))
))
)
