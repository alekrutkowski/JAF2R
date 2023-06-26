### Compiled automatically by rutkoal
### from `JAF Indicators Table.xlsx`, worksheet `IndicatorsTable`
### on 2023-06-26 16:05:21


JAF_INDICATORS = list(
        
        
        "PA1.O1." = specification(
                name = "Employment rate of population aged 20-64 - total",
                unit = "% (of popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y20-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1.S1.M" = specification(
                name = "Employment rate of population aged 20-64 - men",
                unit = "% (of men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="M", unit="PC_POP", age="Y20-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1.S1.F" = specification(
                name = "Employment rate of population aged 20-64 - women",
                unit = "% (of women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="F", unit="PC_POP", age="Y20-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1.S2." = specification(
                name = "Employment rate of older population aged 55-64 - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y55-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1.S3." = specification(
                name = "Employment rate of young people aged 20-29 - total",
                unit = "% (of popn 20-29)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergaed", with_filters=list(age="Y20-29", isced11="TOTAL", sex="T", unit="PC"))
        ),
        
        
        "PA1.S4." = specification(
                name = "Employment rate of low-skilled population aged 20-64 - total",
                unit = "% (of low-skilled popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergaed", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1.S5." = specification(
                name = "Employment rate of non-EU nationals aged 20-64 - total",
                unit = "% (of non-EU national popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1.C1." = specification(
                name = "Overall employment growth",
                unit = "% growth",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="T", unit="THS_PER")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="T", unit="THS_PER"), time_period=-1)
                                    ))
        ),
        
        
        "PA1.C2.15-64" = specification(
                name = "Employment rate of population aged 15-64 - total",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C2.15-19" = specification(
                name = "Employment rate of population aged 15-19 - total",
                unit = "% (of popn 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C2.15-24" = specification(
                name = "Employment rate of population aged 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C2.50-59" = specification(
                name = "Employment rate of population aged 50-59 - total",
                unit = "% (of popn 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C2.60-64" = specification(
                name = "Employment rate of population aged 60-64 - total",
                unit = "% (of popn 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C2.65-69" = specification(
                name = "Employment rate of population aged 65-69 - total",
                unit = "% (of popn 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C2.15-64.M" = specification(
                name = "Employment rate of population aged 15-64 - men ",
                unit = "% (of men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C2.15-19.M" = specification(
                name = "Employment rate of population aged 15-19 - men ",
                unit = "% (of men 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C2.15-24.M" = specification(
                name = "Employment rate of population aged 15-24 - men ",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C2.50-59.M" = specification(
                name = "Employment rate of population aged 50-59 - men",
                unit = "% (of men 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C2.60-64.M" = specification(
                name = "Employment rate of population aged 60-64 - men",
                unit = "% (of men 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C2.M" = specification(
                name = "Employment rate of population aged 65-69 - men",
                unit = "% (of men 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C2.15-64.F" = specification(
                name = "Employment rate of population aged 15-64 - women",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C2.15-19.F" = specification(
                name = "Employment rate of population aged 15-19 - women",
                unit = "% (of women 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C2.15-24.F" = specification(
                name = "Employment rate of population aged 15-24 - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C2.50-59.F" = specification(
                name = "Employment rate of population aged 50-59 - women",
                unit = "% (of women 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C2.60-64.F" = specification(
                name = "Employment rate of population aged 60-64 - women",
                unit = "% (of women 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C2.65-69.F" = specification(
                name = "Employment rate of population aged 65-69 - women",
                unit = "% (of women 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C3.T" = specification(
                name = "Unemployment rate of labour force 15+ ",
                unit = "% (of active popn)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_rt_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-74"))
        ),
        
        
        "PA1.C3.15-64" = specification(
                name = "Unemployment rate in age group 15-64 - total",
                unit = "% (of active popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C3.15-19" = specification(
                name = "Unemployment rate in age group 15-19 - total",
                unit = "% (of active popn 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C3.15-24" = specification(
                name = "Unemployment rate in age group 15-24 - total",
                unit = "% (of active popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C3.50-59" = specification(
                name = "Unemployment rate in age group 50-59 - total",
                unit = "% (of active popn 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C3.60-64" = specification(
                name = "Unemployment rate in age group 60-64 - total",
                unit = "% (of active popn 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C3.65-69" = specification(
                name = "Unemployment rate in age group 65-69 - total",
                unit = "% (of active popn 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C3.15-64.M" = specification(
                name = "Unemployment rate in age group 15-64 - men ",
                unit = "% (of active men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C3.15-19.M" = specification(
                name = "Unemployment rate in age group 15-19 - men ",
                unit = "% (of active men 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C3.15-24.M" = specification(
                name = "Unemployment rate in age group 15-24 - men ",
                unit = "% (of active men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C3.50-59.M" = specification(
                name = "Unemployment rate in age group 50-59 - men",
                unit = "% (of active men 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C3.60-64.M" = specification(
                name = "Unemployment rate in age group 60-64 - men",
                unit = "% (of active men 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C3.65-69.M" = specification(
                name = "Unemployment rate in age group 65-69 - men",
                unit = "% (of active men 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C3.15-64.F" = specification(
                name = "Unemployment rate in age group 15-64 - women",
                unit = "% (of active women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C3.15-19.F" = specification(
                name = "Unemployment rate in age group 15-19 - women",
                unit = "% (of active women 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C3.15-24.F" = specification(
                name = "Unemployment rate in age group 15-24 - women",
                unit = "% (of active women  15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C3.50-59.F" = specification(
                name = "Unemployment rate in age group 50-59 - women",
                unit = "% (of active women 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C3.60-64.F" = specification(
                name = "Unemployment rate in age group 60-64 - women",
                unit = "% (of active women 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C3.65-69.F" = specification(
                name = "Unemployment rate in age group 65-69 - women",
                unit = "% (of active women 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C3.NAT" = specification(
                name = "Unemployment rate national citizens (15-64)",
                unit = "% (of active nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="NAT", age="Y15-64"))
        ),
        
        
        "PA1.C3.EU27_2020" = specification(
                name = "Unemployment rate non-national EU27_2020 citizens (15-64)",
                unit = "% (of active non-nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="EU27_2020_FOR", age="Y15-64"))
        ),
        
        
        "PA1.C3.nonEU27_2020" = specification(
                name = "Unemployment rate non-EU27_2020 citizens (15-64)",
                unit = "% (of active non-EU27)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y15-64"))
        ),
        
        
        "PA1.C3.low" = specification(
                name = "Unemployment rate low education attainment (15-64)",
                unit = "% (of active low educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgaed", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1.C3.med" = specification(
                name = "Unemployment rate medium education attainment (15-64)",
                unit = "% (of active medium educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgaed", with_filters=list(isced11="ED3_4", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1.C3.high" = specification(
                name = "Unemployment rate high education attainment (15-64)",
                unit = "% (of active high educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgaed", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1.C4.T" = specification(
                name = "Activity rate of population 20-64 - total",
                unit = "% (of popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y20-64", indic_em="ACT"))
        ),
        
        
        "PA1.C4.15-64" = specification(
                name = "Activity rate of population aged 15-64 - total",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C4.15-19" = specification(
                name = "Activity rate of population aged 15-19 - total",
                unit = "% (of popn 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C4.15-24" = specification(
                name = "Activity rate of population aged 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C4.50-59" = specification(
                name = "Activity rate of population aged 50-59 - total",
                unit = "% (of popn 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C4.60-64" = specification(
                name = "Activity rate of population aged 60-64 - total",
                unit = "% (of popn 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C4.65-69" = specification(
                name = "Activity rate of population aged 65-69 - total",
                unit = "% (of popn 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C4.15-64.M" = specification(
                name = "Activity rate of population aged 15-64 - men ",
                unit = "% (of men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C4.15-19.M" = specification(
                name = "Activity rate of population aged 15-19 - men ",
                unit = "% (of men 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C4.15-24.M" = specification(
                name = "Activity rate of population aged 15-24 - men ",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C4.50-59.M" = specification(
                name = "Activity rate of population aged 50-59 - men",
                unit = "% (of men 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C4.60-64.M" = specification(
                name = "Activity rate of population aged 60-64 - men",
                unit = "% (of men 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C4.65-69.M" = specification(
                name = "Activity rate of population aged 65-69 - men",
                unit = "% (of men 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C4.15-64.F" = specification(
                name = "Activity rate of population aged 15-64 - women",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-64"))
        ),
        
        
        "PA1.C4.15-19.F" = specification(
                name = "Activity rate of population aged 15-19 - women",
                unit = "% (of women 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-19"))
        ),
        
        
        "PA1.C4.15-24.F" = specification(
                name = "Activity rate of population aged 15-24 - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1.C4.50-59.F" = specification(
                name = "Activity rate of population aged 50-59 - women",
                unit = "% (of women 50-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y50-59"))
        ),
        
        
        "PA1.C4.60-64.F" = specification(
                name = "Activity rate of population aged 60-64 - women",
                unit = "% (of women 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1.C4.65-69.F" = specification(
                name = "Activity rate of population aged 65-69 - women",
                unit = "% (of women 65-69)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y65-69"))
        ),
        
        
        "PA1.C4.NAT" = specification(
                name = "Activity rate national citizens (15-64)",
                unit = "% (of nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="NAT", age="Y15-64"))
        ),
        
        
        "PA1.C4.EU27_2020" = specification(
                name = "Activity rate non-national EU27_2020 citizens (15-64)",
                unit = "% (of non-nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="EU27_2020_FOR", age="Y15-64"))
        ),
        
        
        "PA1.C4.nonEU27_2020" = specification(
                name = "Activity rate non-EU27_2020 citizens (15-64)",
                unit = "% (of non-EU27_2020)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argan", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y15-64"))
        ),
        
        
        "PA1.C4.low" = specification(
                name = "Activity rate low education attainment (15-64)",
                unit = "% (of low educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argaed", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1.C4.med" = specification(
                name = "Activity rate medium education attainment (15-64)",
                unit = "% (of medium educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argaed", with_filters=list(isced11="ED3_4", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1.C4.high" = specification(
                name = "Activity rate high education attainment (15-64)",
                unit = "% (of high educ)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_argaed", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA1b.O1." = specification(
                name = "NEET rate for population aged 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.S1.M" = specification(
                name = "NEET rate for population aged 15-24 - men",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.S1.F" = specification(
                name = "NEET rate for population aged 15-24 - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.S2." = specification(
                name = "Youth unemployment rate, for population aged 15-24 - total",
                unit = "% (of active popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_rt_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-24"))
        ),
        
        
        "PA1b.S3." = specification(
                name = "Youth unemployment ratio, for population aged 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="THS", wstatus="UNE")),
                                            b = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="THS", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1b.S4." = specification(
                name = "Ratio of Youth unemployment ratio (15-24) to Adult unemployment ratio (25-74)",
                unit = "ratio",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula((a/b)/((c-a)/(d-b)),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="THS", wstatus="UNE")),
                                            b = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="THS", wstatus="POP")),
                                            c = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-74", citizen="TOTAL", sex="T", unit="THS", wstatus="UNE")),
                                            d = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-74", citizen="TOTAL", sex="T", unit="THS", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1b.S5." = specification(
                name = "NEET rates for age group 15-24 unemployed - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="UNE", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.S6." = specification(
                name = "NEET rates for age group 15-24 inactive - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="INAC", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y15-19.T" = specification(
                name = "NEET rate for population aged 15-19 - total",
                unit = "% (of popn 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="NEMP", age="Y15-19", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y15-19.M" = specification(
                name = "NEET rate for population aged 15-19 - men",
                unit = "% (of men 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="NEMP", age="Y15-19", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y15-19.F" = specification(
                name = "NEET rate for population aged 15-19 - women",
                unit = "% (of women 15-19)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="NEMP", age="Y15-19", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y20-24.T" = specification(
                name = "NEET rate for population aged 20-24 - total",
                unit = "% (of popn 20-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="NEMP", age="Y20-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y20-24.M" = specification(
                name = "NEET rate for population aged 20-24 - men",
                unit = "% (of men 20-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="NEMP", age="Y20-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y20-24.F" = specification(
                name = "NEET rate for population aged 20-24 - women",
                unit = "% (of women 20-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="NEMP", age="Y20-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y25-29.T" = specification(
                name = "NEET rate for population aged 25-29 - total",
                unit = "% (of popn 25-29)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="NEMP", age="Y25-29", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y25-29.M" = specification(
                name = "NEET rate for population aged 25-29 - men",
                unit = "% (of men 25-29)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="NEMP", age="Y25-29", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C1.Y25-29.F" = specification(
                name = "NEET rate for population aged 25-29 - women",
                unit = "% (of women 25-29)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="NEMP", age="Y25-29", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C2.low.T" = specification(
                name = "NEET rates for age group 18-24 with low education attainment - total",
                unit = "% (of low-skilled popn 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED0-2", sex="T", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C2.low.M" = specification(
                name = "NEET rates for age group 18-24 with low education attainment - men",
                unit = "% (of low-skilled men 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED0-2", sex="M", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C2.low.F" = specification(
                name = "NEET rates for age group 18-24 with low education attainment - women",
                unit = "% (of low-skilled women 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED0-2", sex="F", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C2.med-high.T" = specification(
                name = "NEET rates for age group 18-24 with upper secondary or tertiary education - total",
                unit = "% (of med&high-skilled popn 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED3-8", sex="T", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C2.med-high.M" = specification(
                name = "NEET rates for age group 18-24 with upper secondary or tertiary education - men",
                unit = "% (of med&high-skilled men 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED3-8", sex="M", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C2.med-high.F" = specification(
                name = "NEET rates for age group 18-24 with upper secondary or tertiary education - women",
                unit = "% (of med&high-skilled women 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_21", with_filters=list(isced11="ED3-8", sex="F", unit="PC", wstatus="NEMP", age="Y18-24"))
        ),
        
        
        "PA1b.C3.une.M" = specification(
                name = "NEET rates for age group 15-24 unemployed - men",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="UNE", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C3.une.F" = specification(
                name = "NEET rates for age group 15-24 unemployed - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="UNE", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C3.inac.M" = specification(
                name = "NEET rates for age group 15-24 inactive - men",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="INAC", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C3.inac.F" = specification(
                name = "NEET rates for age group 15-24 inactive - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="INAC", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA1b.C4.M" = specification(
                name = "Youth unemployment rate, for population aged 15-24 - men",
                unit = "% (of active men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_rt_a", with_filters=list(sex="M", unit="PC_ACT", age="Y15-24"))
        ),
        
        
        "PA1b.C4.F" = specification(
                name = "Youth unemployment rate, for population aged 15-24 - women",
                unit = "% (of active women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_rt_a", with_filters=list(sex="F", unit="PC_ACT", age="Y15-24"))
        ),
        
        
        "PA1b.C5.M" = specification(
                name = "Youth unemployment ratio, for population aged 15-24 - men",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="M", unit="THS", wstatus="UNE")),
                                            b = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="M", unit="THS", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1b.C5.F" = specification(
                name = "Youth unemployment ratio, for population aged 15-24 - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="F", unit="THS", wstatus="UNE")),
                                            b = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="F", unit="THS", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1b.C6.15-24.T" = specification(
                name = "Employment rate of population aged 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y15-24"))
        ),
        
        
        "PA1c.O1." = specification(
                name = "Employment rate of population aged 55-64 - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y55-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1c.S1.Y55_59" = specification(
                name = "Employment rate of population aged 55-59 - total",
                unit = "% (of popn 55-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y55-59"))
        ),
        
        
        "PA1c.S1.Y60-64" = specification(
                name = "Employment rate of population aged 60-64 - total",
                unit = "% (of popn 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1c.S1.M" = specification(
                name = "Employment rate of population aged 55-64 - men",
                unit = "% (of men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="M", unit="PC_POP", age="Y55-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1c.S1.F" = specification(
                name = "Employment rate of population aged 55-64 - women",
                unit = "% (of women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="F", unit="PC_POP", age="Y55-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA1c.S2.T" = specification(
                name = "Duration of working life - total",
                unit = "years",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_dwl_a", with_filters=list(sex="T"))
        ),
        
        
        "PA1c.S2.M" = specification(
                name = "Duration of working life - men",
                unit = "years",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_dwl_a", with_filters=list(sex="M"))
        ),
        
        
        "PA1c.S2.F" = specification(
                name = "Duration of working life - women",
                unit = "years",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_dwl_a", with_filters=list(sex="F"))
        ),
        
        
        "PA1c.S3." = specification(
                name = "Participation in education and training aged 55-64",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.S4." = specification(
                name = "Part-time work due to personal and family broad reasons - education or training, own illness or disability, care for children and incapacitated adults, and other personal and family responsibilities (55-64 ) over employment - total",
                unit = "% (of employed 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a*(100-b-c)/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_eppga', with_filters=list(age="Y55-64", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="NF_FTJOB", sex="T", unit="PC")),
                                            c = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="OTH", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.S5." = specification(
                name = "Employment rate gap between groups aged 20-54 and 55-64",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(((a-b)/(c-d)-b/d)*100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y20-64", citizen="TOTAL", sex="T", unit="THS", wstatus="EMP")),
                                            b = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y55-64", citizen="TOTAL", sex="T", unit="THS", wstatus="EMP")),
                                            c = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y20-64", citizen="TOTAL", sex="T", unit="THS", wstatus="POP")),
                                            d = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y55-64", citizen="TOTAL", sex="T", unit="THS", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1c.C1.55-74" = specification(
                name = "Participation in education and training among employed aged 55-74",
                unit = "% (of employed 55-74)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_03", with_filters=list(sex="T", unit="PC", wstatus="EMP", age="Y55-74"))
        ),
        
        
        "PA1c.C2.EMP.W" = specification(
                name = "Part-time work due to personal and family broad reasons - education or training, own illness or disability, care for children and incapacitated adults, and other personal and family responsibilities (55-64 ) over employment women",
                unit = "% (of employed women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a*(100-b-c)/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_eppga', with_filters=list(age="Y55-64", sex="F", unit="PC")),
                                            b = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="NF_FTJOB", sex="F", unit="PC")),
                                            c = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="OTH", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C2.EMP.M" = specification(
                name = "Part-time work due to personal and family broad reasons - education or training, own illness or disability, care for children and incapacitated adults, and other personal and family responsibilities (55-64 ) over employment - men",
                unit = "% (of employed men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a*(100-b-c)/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_eppga', with_filters=list(age="Y55-64", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="NF_FTJOB", sex="M", unit="PC")),
                                            c = fromEurostatDataset('lfsa_epgar', with_filters=list(age="Y55-64", reason="OTH", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C3.T" = specification(
                name = "Share of Inactivity due to personal and family responsibilities (55-64) over total population - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula((100-a)*(b+c)/100,
                                    where=variables(
                                            sex="T", unit="PC_POP", age="Y55-64", reason="FAM_CARE_PER_OTH",  a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y55-64", indic_em="ACT", sex="T", unit="PC_POP")),
                                            b = fromEurostatDataset('lfsa_igar', with_filters=list(age="Y55-64", reason="FAM_CARE_PER_OTH", sex="T", unit="PC")),
                                            c = fromEurostatDataset('lfsa_igar', with_filters=list(age="Y55-64", reason="FAM_CARE_PER_OTH", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C4.M" = specification(
                name = "Healthy life years at 50 - male",
                unit = "years",
                source = "Eurostat, Demographic Statistics and EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="M", indic_he="HLY_50", unit="YR"))
        ),
        
        
        "PA1c.C4.F" = specification(
                name = "Healthy life years at 50 - female",
                unit = "years",
                source = "Eurostat, Demographic Statistics and EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="F", indic_he="HLY_50", unit="YR"))
        ),
        
        
        "PA1c.C5.T" = specification(
                name = "Life expectancy at 50 - total",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("demo_mlexpec", with_filters=list(sex="T", unit="YR", age="Y50"))
        ),
        
        
        "PA1c.C5.M" = specification(
                name = "Life expectancy at 50 - male",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("demo_mlexpec", with_filters=list(sex="M", unit="YR", age="Y50"))
        ),
        
        
        "PA1c.C5.F" = specification(
                name = "Life expectancy at 50 - female",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("demo_mlexpec", with_filters=list(sex="F", unit="YR", age="Y50"))
        ),
        
        
        "PA1c.C6.good" = specification(
                name = "Self-perceived health (very good + good)",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_01', with_filters=list(age="Y55-64", levels="VGOOD", sex="T", wstatus="POP")),
                                            b = fromEurostatDataset('hlth_silc_01', with_filters=list(age="Y55-64", levels="GOOD", sex="T", wstatus="POP"))
                                    ))
        ),
        
        
        "PA1c.C7.high" = specification(
                name = "Employment rate (55-64) - high-skilled",
                unit = "% (of high-skilled popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergaed", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.C7.med" = specification(
                name = "Employment rate (55-64) - medium-skilled",
                unit = "% (of medium-skilled popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergaed", with_filters=list(isced11="ED3_4", sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.C7.low" = specification(
                name = "Employment rate (55-64) - low-skilled",
                unit = "% (of low-skilled popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergaed", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.C8.T" = specification(
                name = "Employment rate (50-54) - total",
                unit = "% (of popn 50-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y50-54"))
        ),
        
        
        "PA1c.C9.M.55-59" = specification(
                name = "Employment rate of population aged 55-59 - men",
                unit = "% (of men 55-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y55-59"))
        ),
        
        
        "PA1c.C9.F.55-59" = specification(
                name = "Employment rate of population aged 55-59 - women",
                unit = "% (of women 55-59)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y55-59"))
        ),
        
        
        "PA1c.C9.M.60-64" = specification(
                name = "Employment rate of population aged 60-64 - men",
                unit = "% (of men 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1c.C9.F.60-64" = specification(
                name = "Employment rate of population aged 60-64 - women",
                unit = "% (of women 60-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="TOTAL", age="Y60-64"))
        ),
        
        
        "PA1c.C10.T" = specification(
                name = "Activity rate (55-64) - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y55-64", indic_em="ACT"))
        ),
        
        
        "PA1c.C10.M" = specification(
                name = "Activity rate (55-64) - men",
                unit = "% (of men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="M", unit="PC_POP", age="Y55-64", indic_em="ACT"))
        ),
        
        
        "PA1c.C10.F" = specification(
                name = "Activity rate (55-64) - women",
                unit = "% (of women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="F", unit="PC_POP", age="Y55-64", indic_em="ACT"))
        ),
        
        
        "PA1c.C11.T" = specification(
                name = "Unemployment rate (55-64) -total",
                unit = "% (of active popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y55-64"))
        ),
        
        
        "PA1c.C12.T" = specification(
                name = "Long-term unemployment rate (55-64) - total",
                unit = "% (of active popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_upgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C12.M" = specification(
                name = "Long-term unemployment rate (55-64) - men",
                unit = "% (of active men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_upgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C12.F" = specification(
                name = "Long-term unemployment (55-64) - women",
                unit = "% (of active women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_upgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="F", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y55-64", citizen="TOTAL", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA1c.C13.T" = specification(
                name = "Share of long-term unemployed (55-64) - total",
                unit = "% (of unemployed popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_upgan", with_filters=list(sex="T", unit="PC", citizen="TOTAL", age="Y55-64"))
        ),
        
        
        "PA1c.C14.T" = specification(
                name = "Tertiary education attaintment (55-64) - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.C14.M" = specification(
                name = "Tertiary education attainment (55-64) - men",
                unit = "% (of men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="M", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1c.C14.F" = specification(
                name = "Tertiary education attainment (55-64) - women",
                unit = "% (of women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="F", unit="PC", age="Y55-64"))
        ),
        
        
        "PA1d.O1." = specification(
                name = "Employment rate of non-EU nationals (20-64) - total",
                unit = "% (of non-EU national popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.S1.M" = specification(
                name = "Employment rate of non-EU nationals aged 20-64 - men",
                unit = "% (of non-EU national men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="M", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.S1.F" = specification(
                name = "Employment rate of non-EU nationals aged 20-64 - women",
                unit = "% (of non-EU national women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergan", with_filters=list(sex="F", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.S2.T" = specification(
                name = "Employment rate of recent immigrants to the EU (non-EU nationals) - total",
                unit = "% (of recently arrived non-EU national popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfst_rimgenga", with_filters=list(age="Y20-64", sex="T", citizen="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.S2.M" = specification(
                name = "Employment rate of recent immigrants to the EU (non-EU nationals) - men ",
                unit = "% (of recently arrived non-EU national men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfst_rimgenga", with_filters=list(age="Y20-64", sex="M", citizen="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.S2.F" = specification(
                name = "Employment rate of recent immigrants to the EU (non-EU nationals) - women",
                unit = "% (of recently arrived non-EU national women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfst_rimgenga", with_filters=list(age="Y20-64", sex="F", citizen="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.C1.T" = specification(
                name = "Employment rate of persons aged 20-64 born outside the EU - total",
                unit = "% (of non-EU born popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="T", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1d.C1.M" = specification(
                name = "Employment rate of persons aged 20-64 born outside the EU - men",
                unit = "% (of non-EU born men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="M", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1d.C1.F" = specification(
                name = "Employment rate of persons aged 20-64 born outside the EU - women",
                unit = "% (of non-EU born women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_ergacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="F", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1d.C2.T" = specification(
                name = "Employment rate of recent immigrants to the EU aged 20-64 (non-EU born) - total ",
                unit = "% (of recently arrived non-EU born popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgecga", with_filters=list(age="Y20-64", sex="T", c_birth="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.C2.M" = specification(
                name = "Employment rate of recent immigrants to the EU aged 20-64 (non-EU born) - men ",
                unit = "% (of recently arrived non-EU born men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgecga", with_filters=list(age="Y20-64", sex="M", c_birth="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.C2.F" = specification(
                name = "Employment rate of recent immigrants to the EU aged 20-64 (non-EU born) - women ",
                unit = "% (of recently arrived non-EU born women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgecga", with_filters=list(age="Y20-64", sex="F", c_birth="NEU27_2020_FOR", unit="PC_RIMG"))
        ),
        
        
        "PA1d.C3.T" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU nationals) (% of population) - total",
                unit = "% (of popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpnga", with_filters=list(age="Y20-64", sex="T", citizen="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C3.M" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU nationals) (% of population) - men",
                unit = "% (of men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpnga", with_filters=list(age="Y20-64", sex="M", citizen="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C3.F" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU nationals) (% of population) -women",
                unit = "% (of women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpnga", with_filters=list(age="Y20-64", sex="F", citizen="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C4.T" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU born) (% of population) - total",
                unit = "% (of popn 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpcga", with_filters=list(age="Y20-64", sex="T", c_birth="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C4.M" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU born) (% of population) - men",
                unit = "% (of men 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpcga", with_filters=list(age="Y20-64", sex="M", c_birth="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C4.F" = specification(
                name = "Recent immigrants to the EU aged 20-64 (non-EU born) (% of population) - women",
                unit = "% (of women 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfst_rimgpcga", with_filters=list(age="Y20-64", sex="F", c_birth="NEU27_2020_FOR", unit="PC_POP"))
        ),
        
        
        "PA1d.C5.T" = specification(
                name = "Unemployment rate for non-EU nationals aged 20-64 - total",
                unit = "% (of active non-EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.C5.M" = specification(
                name = "Unemployment rate for non-EU nationals aged 20-64 - men",
                unit = "% (of active men non-EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="M", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.C5.F" = specification(
                name = "Unemployment rate for non-EU nationals aged 20-64 - women",
                unit = "% (of active women non-EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgan", with_filters=list(sex="F", unit="PC", citizen="NEU27_2020_FOR", age="Y20-64"))
        ),
        
        
        "PA1d.C6.T" = specification(
                name = "Unemployment rate for people aged 20-64 born outside EU - total",
                unit = "% (of active born out EU27)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="T", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1d.C6.M" = specification(
                name = "Unemployment rate for people aged 20-64 born outside EU - men",
                unit = "% (of active men born out EU27)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="M", unit="PC", age="Y20-64"))
        ),
        
        
        "PA1d.C6.F" = specification(
                name = "Unemployment rate for people aged 20-64 born outside EU - women",
                unit = "% (of activewomen born out EU27)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_urgacob", with_filters=list(c_birth="NEU27_2020_FOR", sex="F", unit="PC", age="Y20-64"))
        ),
        
        
        "PA2a.O1." = specification(
                name = "Involuntary temporary employment as % of total employees 15-64",
                unit = "% (of employees 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            age="Y15-64", sex="T", reason="NF_PJOB", unit="PC_SAL",  a = fromEurostatDataset('lfsa_etpgan', with_filters=list(age="Y15-64", sex="T", unit="PC", citizen="TOTAL")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y15-64", reason="NF_PJOB", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA2a.S1.Y15-24" = specification(
                name = "Involuntary temporary employment as % of total employees in age group 15-24",
                unit = "% (of employees 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            age="Y15-24", sex="T", reason="NF_PJOB", unit="PC_SAL",  a = fromEurostatDataset('lfsa_etpgan', with_filters=list(age="Y15-24", sex="T", unit="PC", citizen="TOTAL")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y15-24", reason="NF_PJOB", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA2a.S1.Y25-54" = specification(
                name = "Involuntary temporary employment as % of total employees in age group 25-54",
                unit = "% (of employees 25-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(((a*b)-(c*d))/(e-f),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y25-64", isced11="TOTAL", sex="T", unit="THS")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y25-64", reason="NF_PJOB", sex="T", unit="PC_SAL_TEMP")),
                                            c = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y55-64", isced11="TOTAL", sex="T", unit="THS")),
                                            d = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y55-64", reason="NF_PJOB", sex="T", unit="PC_SAL_TEMP")),
                                            e = fromEurostatDataset('lfsa_eegaed', with_filters=list(age="Y25-64", isced11="TOTAL", sex="T", unit="THS")),
                                            f = fromEurostatDataset('lfsa_eegaed', with_filters=list(age="Y55-64", isced11="TOTAL", sex="T", unit="THS"))
                                    ))
        ),
        
        
        "PA2a.S1.Y55-64" = specification(
                name = "Involuntary temporary employment as % of total employees in age group 55-64",
                unit = "% (of employees 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            age="Y55-64", sex="T", reason="NF_PJOB", unit="PC_SAL",  a = fromEurostatDataset('lfsa_etpgan', with_filters=list(age="Y55-64", sex="T", unit="PC", citizen="TOTAL")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y55-64", reason="NF_PJOB", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA2a.S2.M" = specification(
                name = "Involuntary temporary employment as % of total employees in age group 15-64 - men",
                unit = "% (of male employees 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            age="Y15-64", sex="M", reason="NF_PJOB", unit="PC_SAL",  a = fromEurostatDataset('lfsa_etpgan', with_filters=list(age="Y15-64", sex="M", unit="PC", citizen="TOTAL")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y15-64", reason="NF_PJOB", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA2a.S2.F" = specification(
                name = "Involuntary temporary employment as % of total employees in age group 15-64 - women",
                unit = "% (of female employees 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a*b/100,
                                    where=variables(
                                            age="Y15-64", sex="F", reason="NF_PJOB", unit="PC_SAL",  a = fromEurostatDataset('lfsa_etpgan', with_filters=list(age="Y15-64", sex="F", unit="PC", citizen="TOTAL")),
                                            b = fromEurostatDataset('lfsa_etgar', with_filters=list(age="Y15-64", reason="NF_PJOB", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA2a.S3." = specification(
                name = "Share of employees (15-64) in temporary employment contracts",
                unit = "% (of employees 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_etpgan", with_filters=list(sex="T", unit="PC", age="Y15-64", citizen="TOTAL"))
        ),
        
        
        "PA2a.S4." = specification(
                name = "Involuntary temporary employment share",
                unit = "% (of employees 15-64 in temp empl)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_etgar", with_filters=list(sex="T", reason="NF_PJOB", unit="PC_SAL_TEMP", age="Y15-64"))
        ),
        
        
        "PA2a.S5." = specification(
                name = "Transition rate from temporary to permanent employment",
                unit = "% (of employees with temp job)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_lvhl32", with_filters=list(sex="T", trans1y="TO_PERM", wstatus="SAL_TEMP"))
        ),
        
        
        "PA2a.S6.T" = specification(
                name = "Share of temporary employees due to education or training (15-64)",
                unit = "% (of temp employees 15-64) ",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_etgar", with_filters=list(sex="T", reason="EDUC_TNG", unit="PC_SAL_TEMP", age="Y15-64"))
        ),
        
        
        "PA2a.S6.Y15-24" = specification(
                name = "Share of temporary employees due to education or training (15-24)",
                unit = "% (of temp employees 15-24) ",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_etgar", with_filters=list(sex="T", reason="EDUC_TNG", unit="PC_SAL_TEMP", age="Y15-24"))
        ),
        
        
        "PA2a.S6.M" = specification(
                name = "Share of temporary employees due to education or training (men)",
                unit = "% (of male temp employees 15-64) ",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_etgar", with_filters=list(sex="M", reason="EDUC_TNG", unit="PC_SAL_TEMP", age="Y15-64"))
        ),
        
        
        "PA2a.S6.F" = specification(
                name = "Share of temporary employees due to education or training (women)",
                unit = "% (of female temp employees 15-64) ",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_etgar", with_filters=list(sex="F", reason="EDUC_TNG", unit="PC_SAL_TEMP", age="Y15-64"))
        ),
        
        
        "PA2a.C1.temp" = specification(
                name = "Wage penalty on temporary contracts versus permanent contracts",
                unit = "% (of av gross hrly earnings of perm employees)",
                source = "Eurostat, Structure of Earnings Survey",
                high_is_good = FALSE,
                value = fromFormula(100*(a-b)/a,
                                    where=variables(
                                            a = fromEurostatDataset('earn_ses10_15', with_filters=list(currency="EUR", emp_cont="NLTD", indic_se="ERN", nace_r2="B-S_X_O", sex="T", sizeclas="GE10")),
                                            b = fromEurostatDataset('earn_ses10_15', with_filters=list(currency="EUR", emp_cont="LTD_X_APP_TRN", indic_se="ERN", nace_r2="B-S_X_O", sex="T", sizeclas="GE10"))
                                    ))
        ),
        
        
        "PA2a.C2.REG" = specification(
                name = "Employment protection legislation (EPL) on regular contracts",
                unit = "score",
                source = "OECD, EPL",
                high_is_good = FALSE,
                value = fromOECDdataset("OECD_STR_EP", with_filters=list(indicator="epl_reg"))
        ),
        
        
        "PA2a.C3.TEMP" = specification(
                name = "Employment protection legislation (EPL) on temporary contracts ",
                unit = "score",
                source = "OECD, EPL",
                high_is_good = TRUE,
                value = fromOECDdataset("OECD_STR_EP", with_filters=list(indicator="epl_temp"))
        ),
        
        
        "PA2a.C4.T" = specification(
                name = "Persons with low educational attainment in population 15-64",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y15-64"))
        ),
        
        
        "PA2a.C4.M" = specification(
                name = "Persons with low educational attainment in population 15-64 - men",
                unit = "% (of male popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED0-2", sex="M", unit="PC", age="Y15-64"))
        ),
        
        
        "PA2a.C4.F" = specification(
                name = "Persons with low educational attainment in population 15-64 - women",
                unit = "% (of female popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED0-2", sex="F", unit="PC", age="Y15-64"))
        ),
        
        
        "PA2a.C5.T" = specification(
                name = "Share of persons with low educational attainment in temporary employees",
                unit = "% (of temp employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*(a/(b+c+d)),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="T", unit="THS")),
                                            b = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED3_4", sex="T", unit="THS")),
                                            c = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="T", unit="THS")),
                                            d = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED5-8", sex="T", unit="THS"))
                                    ))
        ),
        
        
        "PA2a.C5.M" = specification(
                name = "Share of persons with low educational attainment in temporary employees - men",
                unit = "% (of male temp employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*(a/(b+c+d)),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="M", unit="THS")),
                                            b = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED3_4", sex="M", unit="THS")),
                                            c = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="M", unit="THS")),
                                            d = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED5-8", sex="M", unit="THS"))
                                    ))
        ),
        
        
        "PA2a.C5.F" = specification(
                name = "Share of persons with low educational attainment in temporary employees - women",
                unit = "% (of female temp employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*(a/(b+c+d)),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="F", unit="THS")),
                                            b = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED3_4", sex="F", unit="THS")),
                                            c = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED0-2", sex="F", unit="THS")),
                                            d = fromEurostatDataset('lfsa_etgaed', with_filters=list(age="Y15-64", isced11="ED5-8", sex="F", unit="THS"))
                                    ))
        ),
        
        
        "PA2b.O1." = specification(
                name = "Newly employed in %",
                unit = "% (of employment 15+)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_enewasn", with_filters=list(unit="PC", citizen="TOTAL", wstatus="EMP", age="Y_GE15"))
        ),
        
        
        "PA2b.S1." = specification(
                name = "Newly self-empoyed in %",
                unit = "% (of self-employed 15+)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_enewasn", with_filters=list(unit="PC", citizen="TOTAL", wstatus="SELF", age="Y_GE15"))
        ),
        
        
        "PA2b.S2." = specification(
                name = "Newly employed young (aged 15-24) in %",
                unit = "% (of young employed 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_enewasn", with_filters=list(unit="PC", citizen="TOTAL", wstatus="EMP", age="Y15-24"))
        ),
        
        
        "PA2b.S3." = specification(
                name = "Transitions from temporary to permanent employment - total",
                unit = "% (of individuals moving from temp to perm)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_lvhl32", with_filters=list(sex="T", trans1y="TO_PERM", wstatus="SAL_TEMP"))
        ),
        
        
        "PA2b.S4.Y15_64" = specification(
                name = "Job tenure in years (15-64)",
                unit = "job tenure (yrs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_egasjt", with_filters=list(age="Y15-64", sex="T", wstatus="EMP", unit="YR"))
        ),
        
        
        "PA2b.S4.Y15_24" = specification(
                name = "Job tenure in years (15-24)",
                unit = "job tenure (yrs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_egasjt", with_filters=list(age="Y15-24", sex="T", wstatus="EMP", unit="YR"))
        ),
        
        
        "PA2b.S4.Y25_54" = specification(
                name = "Job tenure in years (25-54)",
                unit = "job tenure (yrs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_egasjt", with_filters=list(age="Y25-54", sex="T", wstatus="EMP", unit="YR"))
        ),
        
        
        "PA2b.S4.Y55_64" = specification(
                name = "Job tenure in years (55-64)",
                unit = "job tenure (yrs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsa_egasjt", with_filters=list(age="Y55-64", sex="T", wstatus="EMP", unit="YR"))
        ),
        
        
        "PA2b.S5." = specification(
                name = "Hiring rate",
                unit = "% (of employed)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfse_jobtenure", with_filters=list(age="Y15-64", sex="T", hatlev1d="TOTAL", indicator="hir_rate"))
        ),
        
        
        "PA2b.S6." = specification(
                name = "Separation rate",
                unit = "% (of employed)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_jobtenure", with_filters=list(age="Y15-64", sex="T", hatlev1d="TOTAL", indicator="sep_rate"))
        ),
        
        
        "PA2b.S7." = specification(
                name = "Rate of long-term unemployment (as % active population) - total",
                unit = "% (of active population)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_ltu_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-74", indic_em="LTU"))
        ),
        
        
        "PA2b.S8." = specification(
                name = "Share of long-term unemployed in total unemployment - total",
                unit = "% (of total unemployment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_ltu_a", with_filters=list(sex="T", unit="PC_UNE", age="Y15-74", indic_em="LTU"))
        ),
        
        
        "PA2b.C1.TEMP" = specification(
                name = "Employment protection legislation (EPL) on temporary contracts",
                unit = "score",
                source = "OECD, EPL",
                high_is_good = FALSE,
                value = fromOECDdataset("OECD_STR_EP", with_filters=list(indicator="epl_temp"))
        ),
        
        
        "PA2b.C1.REG" = specification(
                name = "Employment protection legislation (EPL) on regular contracts",
                unit = "score",
                source = "OECD, EPL",
                high_is_good = FALSE,
                value = fromOECDdataset("OECD_STR_EP", with_filters=list(indicator="epl_reg"))
        ),
        
        
        "PA2b.C2.ch" = specification(
                name = "Change in the employment rate (over last 3 years)",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y20-64", indic_em="EMP_LFS", sex="T", unit="PC_POP")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y20-64", indic_em="EMP_LFS", sex="T", unit="PC_POP"), time_period=-3)
                                    ))
        ),
        
        
        "PA3.O1." = specification(
                name = "Rate of long-term unemployment (as % active population) - total",
                unit = "% (of active popn)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_ltu_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-74", indic_em="LTU"))
        ),
        
        
        "PA3.S1." = specification(
                name = "Rate of long-term unemployment of the young (as % active population aged 15-24) - total",
                unit = "% (of active popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula((a*b-1)/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_upgan', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA3.S2." = specification(
                name = "Rate of long-term unemployment of the not-young (as % active population aged 25-64) - total",
                unit = "% (of active popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula((a*b-1)/100,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_upgan', with_filters=list(age="Y25-64", citizen="TOTAL", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y25-64", citizen="TOTAL", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA3.S3." = specification(
                name = "Expenditure on ALMP (client services 1.1 and measures 2-7) per person wanting to work",
                unit = "PPS per person wanting to work",
                source = "European Commission, Labour Market Policy",
                high_is_good = TRUE,
                value = fromLMPdataset("lmp_expenditure", with_filters=list(lmp_type="TOT11_7", exptype="XTOT", unit="PPS_PWW"))
        ),
        
        
        "PA3.S4." = specification(
                name = "Expenditure on ALMP (client services 1.1 and measures 2-7) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = TRUE,
                value = fromLMPdataset("lmp_expenditure", with_filters=list(lmp_type="TOT11_7", exptype="XTOT", unit="PC_GDP"))
        ),
        
        
        "PA3.S5." = specification(
                name = "Activation – number of participants in regular activation measures (cat. 2-7) in relation to persons wanting to work ",
                unit = "% (of persons wanting to work)",
                source = "European Commission, Labour Market Policy",
                high_is_good = TRUE,
                value = fromLMPdataset("lmp_ind_actsup", with_filters=list(sex="T", unit="RT", lmp_type="TOT2_7", age="TOTAL"))
        ),
        
        
        "PA3.C1." = specification(
                name = "Activation of registered unemployed (LMP cat. 2-7) ",
                unit = "NA",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_actru", with_filters=list(sex="T", unit="RT", regis_es="REG_UNE", age="TOTAL", lmp_type="TOT2_7"))
        ),
        
        
        "PA3.C4." = specification(
                name = "Activation of long-term unemployed (LMP cat. 2-7) ",
                unit = "NA",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_actru", with_filters=list(sex="T", unit="RT", regis_es="REG_UNE_LT", age="TOTAL", lmp_type="TOT2_7"))
        ),
        
        
        "PA3.C6." = specification(
                name = "Timely activation (Regular activation = cat 2-7, assisted activation = 1.1.2) ",
                unit = "NA",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_actime", with_filters=list(sex="T", unit="PC", lmp_type="TOT2_7", age="TOTAL"))
        ),
        
        
        "PA3.C7.2" = specification(
                name = "Expenditure on ALMP (cat. 2 training) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="2"))
        ),
        
        
        "PA3.C7.4" = specification(
                name = "Expenditure on ALMP (cat 4. employment incentives) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="4"))
        ),
        
        
        "PA3.C7.5" = specification(
                name = "Expenditure on ALMP (cat 5. supported employment and rehabilitation) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="5"))
        ),
        
        
        "PA3.C7.6" = specification(
                name = "Expenditure on ALMP (cat 6. direct job creation) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="6"))
        ),
        
        
        "PA3.C7.7" = specification(
                name = "Expenditure on ALMP (cat 7. start-up incentives) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = NA,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="7"))
        ),
        
        
        "PA4.1.O1." = specification(
                name = "At-risk-of-poverty rate of unemployed",
                unit = "% (of unemployed aged 18+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li04", with_filters=list(sex="T", wstatus="UNE", indic_il="LI_R_MD60", age="Y_GE18"))
        ),
        
        
        "PA4.1.S1." = specification(
                name = "Share of long-term unemployed in total unemployment - total",
                unit = "% (of unemployed)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_ltu_a", with_filters=list(sex="T", unit="PC_UNE", age="Y15-74", indic_em="LTU"))
        ),
        
        
        "PA4.1.S2.A1" = specification(
                name = "Net replacement rate after 6 months of unemployment - single person, no children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="S.7.67"))
        ),
        
        
        "PA4.1.S2.A1_2DCH" = specification(
                name = "Net replacement rate after 6 months of unemployment - one earner couple, no children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="1EC.7.67"))
        ),
        
        
        "PA4.1.S2.A2" = specification(
                name = "Net replacement rate after 6 months of unemployment - lone parent, with 2 children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="S2C.7.67"))
        ),
        
        
        "PA4.1.S2.A2_2DCH" = specification(
                name = "Net replacement rate after 6 months of unemployment - one earner couple, with 2 children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="1EC2C.7.67"))
        ),
        
        
        "PA4.1.S3.A1" = specification(
                name = "Net replacement rate after 12 months of unemployment - single person, no children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="S.13.67"))
        ),
        
        
        "PA4.1.S3.A1_2DCH" = specification(
                name = "Net replacement rate after 12 months of unemployment - one earner couple, no children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="1EC.13.67"))
        ),
        
        
        "PA4.1.S3.A2" = specification(
                name = "Net replacement rate after 12 months of unemployment - lone parent, with 2 children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="S2C.13.67"))
        ),
        
        
        "PA4.1.S3.A2_2DCH" = specification(
                name = "Net replacement rate after 12 months of unemployment - one earner couple, with 2 children",
                unit = "% (of net wage previously earned)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = TRUE,
                value = fromBenefitsAndWages("nrr_ub", with_filters=list(indicator="1EC2C.13.67"))
        ),
        
        
        "PA4.1.C2." = specification(
                name = "Expenditure on LMP supports (cat 8: out of work income maintenance) per person wanting to work",
                unit = "PPS per person wanting to work",
                source = "European Commission, Labour Market Policy",
                high_is_good = TRUE,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PPS_PWW", lmp_type="8"))
        ),
        
        
        "PA4.1.C3." = specification(
                name = "Expenditure on LMP supports (cat. 8: out of work income maintenance) as % of GDP ",
                unit = "% (of GDP)",
                source = "European Commission, Labour Market Policy",
                high_is_good = TRUE,
                value = fromLMPdataset("lmp_ind_exp", with_filters=list(unit="PC_GDP", lmp_type="8"))
        ),
        
        
        "PA4.1.C4." = specification(
                name = "Unemployment rate of labour force 15+ ",
                unit = "% (of active popn 15+)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_rt_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-74"))
        ),
        
        
        "PA4.2.S1." = specification(
                name = "In-work-poverty risk",
                unit = "% (of people in work)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="T", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA4.2.S2." = specification(
                name = "Low wage trap – tax rate on low wage earners ",
                unit = "% (of increase in gross earnings)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("earn_nt_lowwtrp", with_filters=list(indicator="LW.S.0.33.33"))
        ),
        
        
        "PA4.2.S3.T" = specification(
                name = "Transitions by pay level - total",
                unit = "%",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b+c,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="T", trans1y="NO_CHG")),
                                            b = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="T", trans1y="TO_1UP")),
                                            c = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="T", trans1y="TO_GT1UP"))
                                    ))
        ),
        
        
        "PA4.2.S4." = specification(
                name = "Inactivity trap for the second member of a couple: marginal effective tax rate on labour income from a second member of a couple moving from social assistance to work ",
                unit = "% (of change in gross income)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="IT.2EC67.67.0.0"))
        ),
        
        
        "PA4.2.S5." = specification(
                name = "Low wage trap for second earner income ",
                unit = "% (of increase in gross earnings)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="LW.2EC67.0.67.33"))
        ),
        
        
        "PA5.O1." = specification(
                name = "Inactivity and part-time work due to personal and family responsibilities - total",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="T", indicator="INACTPT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.S1.INAC" = specification(
                name = "Inactivity due to personal and family responsibilities - total",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="T", indicator="INACT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.S1.PT" = specification(
                name = "Part-time work due to personal and family responsibilities - total",
                unit = "% (of popn 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="T", indicator="PT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.S1.M" = specification(
                name = "Inactivity and part-time work due to personal and family responsibilities - men",
                unit = "% (of men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="M", indicator="INACTPT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.S1.F" = specification(
                name = "Inactivity and part-time work due to personal and family responsibilities - women",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="F", indicator="INACTPT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.S2." = specification(
                name = "Inactivity and part-time work due to lack of care services for children and other dependents",
                unit = "% (of persons 15-64 with care responsibilities)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="T", indicator="INACTPT_LACKCARE_ONFAMPERCARE"))
        ),
        
        
        "PA5.S3.T" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) (age 3 to mandatory school age) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H1-29")),
                                            b = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H_GE30"))
                                    ))
        ),
        
        
        "PA5.S3.<30" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) less than 30h a usual week as a proportion of all children in the same age group (age 3 to mandatory school age) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y3-CSA", duration="H1-29"))
        ),
        
        
        "PA5.S3.>30" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) 30h or more a usual week as a proportion of all children in the same age group (age 3 to mandatory school age) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y3-CSA", duration="H_GE30"))
        ),
        
        
        "PA5.S4.T" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) (age 0 to 3) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y_LT3", duration="H1-29")),
                                            b = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y_LT3", duration="H_GE30"))
                                    ))
        ),
        
        
        "PA5.S4.<30" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) less than 30h a usual week as a proportion of all children in the same age group (age 0 to 3) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y_LT3", duration="H1-29"))
        ),
        
        
        "PA5.S4.>30" = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) 30h or more a usual week as a proportion of all children in the same age group (age 0 to 3) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y_LT3", duration="H_GE30"))
        ),
        
        
        "PA5.S5." = specification(
                name = "Employment impact of parenthood ",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="no", sex="T")),
                                            b = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="yes", sex="T"))
                                    ))
        ),
        
        
        "PA5.S6." = specification(
                name = "Employees for whom overtime is given as the main reason for actual hours worked during the reference week being different from the person's usual hous worked",
                unit = "% (of employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_overtime", with_filters=list(sex="T", age="Y20-64"))
        ),
        
        
        "PA5.C1.M" = specification(
                name = "Inactivity due to personal and family responsibilities - men",
                unit = "% (of men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="M", indicator="INACT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.C1.F" = specification(
                name = "Inactivity due to personal and family responsibilities - women",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="F", indicator="INACT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.C2.M" = specification(
                name = "Part-time work due to personal and family responsibilities-men",
                unit = "% (of men 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="M", indicator="PT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.C2.F" = specification(
                name = "Part-time work due to personal and family responsibilities - women",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="F", indicator="PT_CARERESP_ONPOP"))
        ),
        
        
        "PA5.C3.M" = specification(
                name = "Inactivity and part-time work due to lack of care services for children and other dependents - men",
                unit = "% (of men 15-64 with care responsibilities)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="M", indicator="INACTPT_LACKCARE_ONFAMPERCARE"))
        ),
        
        
        "PA5.C3.F" = specification(
                name = "Inactivity and part-time work due to lack of care services for children and other dependents - women",
                unit = "% (of women 15-64 with care responsibilities)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="F", indicator="INACTPT_LACKCARE_ONFAMPERCARE"))
        ),
        
        
        "PA6a.O1." = specification(
                name = "Overall employment growth: total growth over 3 most recent periods - total",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="T", unit="THS_PER")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="T", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S1.M" = specification(
                name = "Overall employment growth: total growth over 3 most recent periods - men",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="M", unit="THS_PER")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="M", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S1.F" = specification(
                name = "Overall employment growth: total growth over 3 most recent periods - women",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="F", unit="THS_PER")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y15-64", indic_em="EMP_LFS", sex="F", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S2.AGRI" = specification(
                name = "Employment growth in agriculture, forestry and fishing (over last 3 years)",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="A", na_item="EMP_DC", unit="THS_PER")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="A", na_item="EMP_DC", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S2.IND" = specification(
                name = "Employment growth in industry (except construction) (over last 3 years)",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="B-E", na_item="EMP_DC", unit="THS_PER")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="B-E", na_item="EMP_DC", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S2.CONSTR" = specification(
                name = "Employment growth in construction (over last 3 years)",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="F", na_item="EMP_DC", unit="THS_PER")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="F", na_item="EMP_DC", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S2.SERV" = specification(
                name = "Employment growth in services (over last 3 years)",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a+b+c+d+e+f+g)/(h+i+j+k+l+m+n)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="G-I", na_item="EMP_DC", unit="THS_PER")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="J", na_item="EMP_DC", unit="THS_PER")),
                                            c = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="K", na_item="EMP_DC", unit="THS_PER")),
                                            d = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="L", na_item="EMP_DC", unit="THS_PER")),
                                            e = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="M_N", na_item="EMP_DC", unit="THS_PER")),
                                            f = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="O-Q", na_item="EMP_DC", unit="THS_PER")),
                                            g = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="R-U", na_item="EMP_DC", unit="THS_PER")),
                                            h = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="G-I", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            i = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="J", na_item="EMP_DC", unit="THS_PER"), time_period=-3) j = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="K", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            k = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="L", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            l = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="M_N", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            m = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="O-Q", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            n = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="R-U", na_item="EMP_DC", unit="THS_PER"), time_period=-3),
                                            
                                    ))
        ),
        
        
        "PA6a.S3." = specification(
                name = "Change in share of part-time employment in overall employment (over last 3 years)",
                unit = "percentage points",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_pt_a', with_filters=list(age="Y15-64", sex="T", unit="PC_EMP", wstatus="EMP_PT")),
                                            b = fromEurostatDataset('lfsi_pt_a', with_filters=list(age="Y15-64", sex="T", unit="PC_EMP", wstatus="EMP_PT"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S4." = specification(
                name = "Change in share of temporary employees in all employees (over last 3 years)",
                unit = "percentage points",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_pt_a', with_filters=list(age="Y15-64", sex="T", unit="PC_EMP", wstatus="EMP_TEMP")),
                                            b = fromEurostatDataset('lfsi_pt_a', with_filters=list(age="Y15-64", sex="T", unit="PC_EMP", wstatus="EMP_TEMP"), time_period=-3)
                                    ))
        ),
        
        
        "PA6a.S6." = specification(
                name = "Self-employment – Share of self-employed workers among overall employment ",
                unit = "% (of total employment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(100*a/b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_egaps', with_filters=list(age="Y15-64", sex="T", unit="THS", wstatus="SELF")),
                                            b = fromEurostatDataset('lfsa_egaps', with_filters=list(age="Y15-64", sex="T", unit="THS", wstatus="EMP"))
                                    ))
        ),
        
        
        "PA6a.C1.SH.AGRI" = specification(
                name = "Share of employment in agriculture, forestry and fishing",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="A"))
        ),
        
        
        "PA6a.C1.SH.IND" = specification(
                name = "Share of employment in industry (except construction) ",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="B-E"))
        ),
        
        
        "PA6a.C1.SH.CONSTR" = specification(
                name = "Share of employment in construction",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="F"))
        ),
        
        
        "PA6a.C1.SH.G_I" = specification(
                name = "Share of employment in wholesale and retail trade, transport, accommodation and food service activities",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="G-I"))
        ),
        
        
        "PA6a.C1.SH.J_L" = specification(
                name = "Share of employment in information and communication; financial and insurance activities; real estate activities",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula((a+b+c)/d*100,
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="J", na_item="EMP_DC", unit="PC_TOT_PER")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="K", na_item="EMP_DC", unit="PC_TOT_PER")),
                                            c = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="L", na_item="EMP_DC", unit="PC_TOT_PER")),
                                            d = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="PC_TOT_PER"))
                                    ))
        ),
        
        
        "PA6a.C1.SH.M_N" = specification(
                name = "Share of employment in professional, scientific, and technical activities; administrative and support activities",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="M_N"))
        ),
        
        
        "PA6a.C1.SH.O-Q" = specification(
                name = "Share of employment in public administration, defence, education, human health and social work activities",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="O-Q"))
        ),
        
        
        "PA6a.C1.SH.R_U" = specification(
                name = "Share of employment in arts, entertainment and recreation; other service activities; activities of households and extra-territorial organizations and bodies",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromEurostatDataset("nama_10_a10_e", with_filters=list(unit="PC_TOT_PER", na_item="EMP_DC", nace_r2="R-U"))
        ),
        
        
        "PA6a.C2.15-64" = specification(
                name = "Labour reserve 15-64",
                unit = "% (of pop 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/(b+c),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y15-64", sex="T", unit="THS", wantwork="YES")),
                                            b = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y15-64", sex="T", unit="THS", wantwork="TOTAL")),
                                            c = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-64", citizen="TOTAL", sex="T", unit="THS", wstatus="ACT"))
                                    ))
        ),
        
        
        "PA6a.C2.15-24" = specification(
                name = "Labour reserve 15-24",
                unit = "% (of pop 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/(b+c),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y15-24", sex="T", unit="THS", wantwork="YES")),
                                            b = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y15-24", sex="T", unit="THS", wantwork="TOTAL")),
                                            c = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y15-24", citizen="TOTAL", sex="T", unit="THS", wstatus="ACT"))
                                    ))
        ),
        
        
        "PA6a.C2.25-54" = specification(
                name = "Labour reserve 24-54",
                unit = "% (of pop 25-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*(a-b)/(c-d+e),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y25-64", sex="T", unit="THS", wantwork="YES")),
                                            b = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y55-64", sex="T", unit="THS", wantwork="YES")),
                                            c = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y25-64", sex="T", unit="THS", wantwork="TOTAL")),
                                            d = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y55-64", sex="T", unit="THS", wantwork="TOTAL")),
                                            e = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y25-54", citizen="TOTAL", sex="T", unit="THS", wstatus="ACT"))
                                    ))
        ),
        
        
        "PA6a.C2.55-64" = specification(
                name = "Labour reserve 55-64",
                unit = "% (of pop 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(100*a/(b+c),
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y55-64", sex="T", unit="THS", wantwork="YES")),
                                            b = fromEurostatDataset('lfsa_igaww', with_filters=list(age="Y55-64", sex="T", unit="THS", wantwork="TOTAL")),
                                            c = fromEurostatDataset('lfsa_pganws', with_filters=list(age="Y55-64", citizen="TOTAL", sex="T", unit="THS", wstatus="ACT"))
                                    ))
        ),
        
        
        "PA6a.C4." = specification(
                name = "White coat jobs – Share of employment in care and health care activities ",
                unit = "% (of employment)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*(a+b)/c,
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a64_e', with_filters=list(nace_r2="Q86", na_item="EMP_DC", unit="THS_PER")),
                                            b = fromEurostatDataset('nama_10_a64_e', with_filters=list(nace_r2="Q87_Q88", na_item="EMP_DC", unit="THS_PER")),
                                            c = fromEurostatDataset('nama_10_a64_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="THS_PER"))
                                    ))
        ),
        
        
        "PA6a.C5." = specification(
                name = "Green jobs – employment in the environmental goods and services sector ",
                unit = "FTE (Full time equivalent)",
                source = "Eurostat, EGSS data collection",
                high_is_good = TRUE,
                value = fromEurostatDataset("env_ac_egss1", with_filters=list(unit="FTE", na_item="EMP_DC", ceparema="TOTAL", ty="TOT_EGSS", nace_r2="TOTAL"))
        ),
        
        
        "PA6b.S2." = specification(
                name = "Employment protection legislation (EPL) on regular contracts",
                unit = "score",
                source = "OECD, EPL",
                high_is_good = FALSE,
                value = fromOECDdataset("OECD_STR_EP", with_filters=list(indicator="epl_reg"))
        ),
        
        
        "PA6b.S4." = specification(
                name = "Average real GDP growth over 3 years",
                unit = "% growth (av over 3 yrs)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula((a+b+c)/3,
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_gdp', with_filters=list(na_item="B1GQ", unit="CLV_PCH_PRE")),
                                            b = fromEurostatDataset('nama_10_gdp', with_filters=list(na_item="B1GQ", unit="CLV_PCH_PRE"), time_period=-1),
                                            c = fromEurostatDataset('nama_10_gdp', with_filters=list(na_item="B1GQ", unit="CLV_PCH_PRE"), time_period=-2)
                                    ))
        ),
        
        
        "PA6b.C2." = specification(
                name = "Nominal unit labour cost - growth over 3 years",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = FALSE,
                value = fromEurostatDataset("nama_10_lp_ulc", with_filters=list(unit="PCH_3Y", na_item="NULC_PER"))
        ),
        
        
        "PA7.1.O1." = specification(
                name = "Employment gender gap (aged 20-64)",
                unit = "percentage points (difference in ERs 20-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y20-64", indic_em="EMP_LFS", sex="M", unit="PC_POP")),
                                            b = fromEurostatDataset('lfsi_emp_a', with_filters=list(age="Y20-64", indic_em="EMP_LFS", sex="F", unit="PC_POP"))
                                    ))
        ),
        
        
        "PA7.1.S1.Y20-29" = specification(
                name = "Employment gender gap (aged 20-29)",
                unit = "Percentage points (difference in ERs 20-29)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-29", isced11="TOTAL", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-29", isced11="TOTAL", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA7.1.S1.Y30-54" = specification(
                name = "Employment gender gap (aged 30-54)",
                unit = "Percentage points (difference in ERs 30-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y30-54", isced11="TOTAL", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y30-54", isced11="TOTAL", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA7.1.S1.Y55-64" = specification(
                name = "Employment gender gap (aged 55-64)",
                unit = "Percentage points (difference in ERs 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y55-64", isced11="TOTAL", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y55-64", isced11="TOTAL", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA7.1.S2.F" = specification(
                name = "Employment impact of parenthood - women ",
                unit = "Percentage points (difference in ERs 20-49)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="no", sex="F")),
                                            b = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="yes", sex="F"))
                                    ))
        ),
        
        
        "PA7.1.S3.M" = specification(
                name = "Share of employees working in involuntary fixed-term or part-time contracts - men",
                unit = "% (of men employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_eetpgar", with_filters=list(age="Y_GE15", sex="M", reason="NF_FT_PJOB", unit="PC_SAL"))
        ),
        
        
        "PA7.1.S3.F" = specification(
                name = "Share of employees working in involuntary fixed-term or part-time contracts -women",
                unit = "% (of women employees)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfsa_eetpgar", with_filters=list(age="Y_GE15", sex="F", reason="NF_FT_PJOB", unit="PC_SAL"))
        ),
        
        
        "PA7.1.S4." = specification(
                name = "Inactivity and part-time work due to personal and family responsibilities – women ",
                unit = "% (of women 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("lfse_inactpt_lackcare", with_filters=list(age="Y15-64", sex="F", indicator="INACTPT_CARERESP_ONPOP"))
        ),
        
        
        "PA7.1.S5." = specification(
                name = "Inactivity trap for the second member of a couple: marginal effective tax rate on labour income from a second member of a couple moving from social assistance to work ",
                unit = "% (of increase in gross wage)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="IT.2EC67.67.0.0"))
        ),
        
        
        "PA7.1.C1." = specification(
                name = "Unemployment gender gap (20-64) ",
                unit = "Percentage points (difference in URs 20-49)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y20-64", citizen="TOTAL", sex="F", unit="PC")),
                                            b = fromEurostatDataset('lfsa_urgan', with_filters=list(age="Y20-64", citizen="TOTAL", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA7.1.C2." = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) (age 3 to mandatory school age) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H1-29")),
                                            b = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H_GE30"))
                                    ))
        ),
        
        
        "PA7.1.C4." = specification(
                name = "Employment gender gap in fte (20-64) ",
                unit = "Percentage points (difference in ERs fte 20-49)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfse_erfgap2064', with_filters=list(age="Y20-64", sex="M")),
                                            b = fromEurostatDataset('lfse_erfgap2064', with_filters=list(age="Y20-64", sex="F"))
                                    ))
        ),
        
        
        "PA7.1.C5." = specification(
                name = "Gender segregation in occupations ",
                unit = "% (of employment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_iscogap", with_filters=list(age="Y_GE15", sex="M"))
        ),
        
        
        "PA7.1.C6." = specification(
                name = "Gender segregation in sectors ",
                unit = "% (of employment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_nacegap", with_filters=list(age="Y_GE15", sex="M"))
        ),
        
        
        "PA7.2.O1." = specification(
                name = "Gender pay gap",
                unit = "% (of men's average gross hourly earnings (paid employees))",
                source = "Eurostat, Structure of Earnings Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("earn_gr_gpgr2", with_filters=list(unit="PC", nace_r2="B-S_X_O"))
        ),
        
        
        "PA7.2.S1.M" = specification(
                name = "Employment impact of parenthood - men ",
                unit = "Percentage points (difference in ERs 20-49)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="no", sex="M")),
                                            b = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="yes", sex="M"))
                                    ))
        ),
        
        
        "PA7.2.S1.F" = specification(
                name = "Employment impact of parenthood - women ",
                unit = "Percentage points (difference in ERs 20-49)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="no", sex="F")),
                                            b = fromEurostatDataset('lfse_er_child', with_filters=list(age="Y20-49", children="yes", sex="F"))
                                    ))
        ),
        
        
        "PA7.2.S2.M" = specification(
                name = "Transitions by pay level - men",
                unit = "%",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b+c,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="M", trans1y="NO_CHG")),
                                            b = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="M", trans1y="TO_1UP")),
                                            c = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="M", trans1y="TO_GT1UP"))
                                    ))
        ),
        
        
        "PA7.2.S2.F" = specification(
                name = "Transitions by pay level - women",
                unit = "%",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b+c,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="F", trans1y="NO_CHG")),
                                            b = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="F", trans1y="TO_1UP")),
                                            c = fromEurostatDataset('ilc_lvhl34', with_filters=list(quantile="TOTAL", sex="F", trans1y="TO_GT1UP"))
                                    ))
        ),
        
        
        "PA7.2.S3." = specification(
                name = "Inactivity trap for the second member of a couple",
                unit = "% (of change in gross income)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="IT.2EC67.67.0.0"))
        ),
        
        
        "PA7.2.S4." = specification(
                name = "Low wage trap for second earner income ",
                unit = "% (of increase in gross earnings)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="LW.2EC67.0.67.33"))
        ),
        
        
        "PA7.2.C1." = specification(
                name = "Child care – Children cared for (by formal arrangements other than by the family) (age 3 to mandatory school age) ",
                unit = "% (of children of 3 years to mandatory school age)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(a+b,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H1-29")),
                                            b = fromEurostatDataset('ilc_caindformal', with_filters=list(age="Y3-CSA", duration="H_GE30"))
                                    ))
        ),
        
        
        "PA7.2.C3." = specification(
                name = "Gender segregation in occupations ",
                unit = "% (of employment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_iscogap", with_filters=list(age="Y_GE15", sex="M"))
        ),
        
        
        "PA7.2.C4." = specification(
                name = "Gender segregation in sectors ",
                unit = "% (of employment)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = NA,
                value = fromEurostatDataset("lfse_nacegap", with_filters=list(age="Y_GE15", sex="M"))
        ),
        
        
        "PA8.1.O1." = specification(
                name = "Share of adult population (aged 25-64) with upper secondary or tertiary education - total",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="T", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.S1.MED" = specification(
                name = "Share of adult population (aged 25-64) having attained medium (upper secondary) education - total",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3_4", sex="T", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.S1.HIGH" = specification(
                name = "Share of adult population (aged 25-64) having attained high (tertiary) education - total",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.S2." = specification(
                name = "Youth education attainment level (aged 20-24) - total",
                unit = "% (of popn 20-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="T", unit="PC", age="Y20-24"))
        ),
        
        
        "PA8.1.S3." = specification(
                name = "Graduates (ISCED 5-6) aged 20-29 per 1 000 of the corresponding age population",
                unit = "per 1000 (of popn 20-29)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_itertc", with_filters=list(indic_ed="TC05_1"))
        ),
        
        
        "PA8.1.S4." = specification(
                name = "Labour productivity growth - GDP per employed person - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_lp_ulc', with_filters=list(na_item="RLPR_PER", unit="I10")),
                                            b = fromEurostatDataset('nama_10_lp_ulc', with_filters=list(na_item="RLPR_PER", unit="I10"), time_period=-3)
                                    ))
        ),
        
        
        "PA8.1.S6." = specification(
                name = "Individuals who have basic or above basic overall digital skills",
                unit = "% (of popn 16-74)",
                source = "DG CONNECT",
                high_is_good = TRUE,
                value = fromEurostatDataset("tepsr_sp410", with_filters=list(ind_type="IND_TOTAL"))
        ),
        
        
        "PA8.1.C1.M" = specification(
                name = "Share of adult population (aged 25-64) with upper secondary or tertiary education - men",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="M", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.C1.F" = specification(
                name = "Share of adult population (aged 25-64) with upper secondary or tertiary education - women",
                unit = "% (of women 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="F", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.C1.Y25-34" = specification(
                name = "Share of adult population (aged 25-34) with upper secondary or tertiary education",
                unit = "% (of people 25-34)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="T", unit="PC", age="Y25-34"))
        ),
        
        
        "PA8.1.C1.Y35-44" = specification(
                name = "Share of adult population (aged 35-44) with upper secondary or tertiary education",
                unit = "% (of people 35-44)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="T", unit="PC", age="Y35-44"))
        ),
        
        
        "PA8.1.C4." = specification(
                name = "Share of adult population (aged 25-64) having attained low (at most lower secondary) and high (tertiary) education ",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED0-2", sex="T", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.1.C5." = specification(
                name = "Average effective annual hours actually worked per person employed ",
                unit = "hours worked per year",
                source = "Eurostat, National Accounts",
                high_is_good = FALSE,
                value = fromFormula(a/b,
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a64_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="THS_HW")),
                                            b = fromEurostatDataset('nama_10_a64_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="THS_PER"))
                                    ))
        ),
        
        
        "PA8.2.O1." = specification(
                name = "Life long learning - percentage of adult population (aged 25-64) participating in education and training - total",
                unit = "% (of popn 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.2.S1." = specification(
                name = "Percentage of adult population (aged 25-64) participating in education and training - unemployed ",
                unit = "% (of unemployed 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfse_02", with_filters=list(sex="T", unit="PC", wstatus="UNE", age="Y25-64"))
        ),
        
        
        "PA8.2.S2." = specification(
                name = "Percentage of adult population (aged 25-64) participating in education and training - employed",
                unit = "% (of employed 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfse_02", with_filters=list(sex="T", unit="PC", wstatus="EMP", age="Y25-64"))
        ),
        
        
        "PA8.2.S3." = specification(
                name = "Percentage of adult population (aged 25-64) participating in education and training - inactive",
                unit = "% (of inactive 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfse_02", with_filters=list(sex="T", unit="PC", wstatus="INAC", age="Y25-64"))
        ),
        
        
        "PA8.2.S4." = specification(
                name = "Public spending on human resources – total public expenditure in education as % of GDP ",
                unit = "% (of GDP)",
                source = "Eurostat, UOE",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_figdp", with_filters=list(indic_ed="FP01_1", unit="PC"))
        ),
        
        
        "PA8.2.S5." = specification(
                name = "Transitions in labour status and pay level ",
                unit = "% (of popn 16-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_lvhl35", with_filters=list(sex="T", trans1y="TO_GEQUA", wstatus="POP"))
        ),
        
        
        "PA8.2.C1.Y25-64.M" = specification(
                name = "Percentage of adult population participating in education and training (aged 25-64) - men",
                unit = "% (of men 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="M", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.2.C1.Y25_64.T" = specification(
                name = "Percentage of adult population participating in education and training (aged 25-64) - women",
                unit = "% (of women 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="F", unit="PC", age="Y25-64"))
        ),
        
        
        "PA8.2.C1.Y25-34.T" = specification(
                name = "Percentage of adult population participating in education and training (aged 25-34) - total",
                unit = "% (of popn 25-34)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y25-34"))
        ),
        
        
        "PA8.2.C1.Y25-34.M" = specification(
                name = "Percentage of adult population participating in education and training (aged 25-34) - men",
                unit = "% (of men 25-34)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="M", unit="PC", age="Y25-34"))
        ),
        
        
        "PA8.2.C1.Y25-34.F" = specification(
                name = "Percentage of adult population participating in education and training (aged 25-34) - women",
                unit = "% (of women 25-34)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="F", unit="PC", age="Y25-34"))
        ),
        
        
        "PA8.2.C1.Y35-44.T" = specification(
                name = "Percentage of adult population participating in education and training (aged 35-44) - total",
                unit = "% (of popn 35-44)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y35-44"))
        ),
        
        
        "PA8.2.C1.Y35-44.M" = specification(
                name = "Percentage of adult population participating in education and training (aged 35-44) - men",
                unit = "% (of men 35-44)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="M", unit="PC", age="Y35-44"))
        ),
        
        
        "PA8.2.C1.Y35-44.F" = specification(
                name = "Percentage of adult population participating in education and training (aged 35-44) - women",
                unit = "% (of women 35-44)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="F", unit="PC", age="Y35-44"))
        ),
        
        
        "PA8.2.C1.Y45-54.T" = specification(
                name = "Percentage of adult population participating in education and training (aged 45-54) - total",
                unit = "% (of popn 45-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y45-54"))
        ),
        
        
        "PA8.2.C1.Y45-54.M" = specification(
                name = "Percentage of adult population participating in education and training (aged 45-54) - men",
                unit = "% (of men 45-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="M", unit="PC", age="Y45-54"))
        ),
        
        
        "PA8.2.C1.Y45-54.F" = specification(
                name = "Percentage of adult population participating in education and training (aged 45-54) - women",
                unit = "% (of women 45-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="F", unit="PC", age="Y45-54"))
        ),
        
        
        "PA8.2.C1.Y55-64.T" = specification(
                name = "Percentage of adult population participating in education and training (aged 55-64) - total",
                unit = "% (of popn 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="T", unit="PC", age="Y55-64"))
        ),
        
        
        "PA8.2.C1.Y55-64.M" = specification(
                name = "Percentage of adult population participating in education and training (aged 55-64) - men",
                unit = "% (of men 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="M", unit="PC", age="Y55-64"))
        ),
        
        
        "PA8.2.C1.Y55-64.F" = specification(
                name = "Percentage of adult population participating in education and training (aged 55-64) - women",
                unit = "% (of women 55-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_01", with_filters=list(sex="F", unit="PC", age="Y55-64"))
        ),
        
        
        "PA9.1.O1." = specification(
                name = "Early leavers from education and training (aged 18-24) - total",
                unit = "% (of popn 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_14", with_filters=list(sex="T", unit="PC", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.S1." = specification(
                name = "Share of children between 4 years old and the age of starting compulsory education that participate in early childhood education",
                unit = "% (of children aged 4 to mandatory school age)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_ipart", with_filters=list(indic_ed="P02_0"))
        ),
        
        
        "PA9.1.S2." = specification(
                name = "NEET rates for age group 15-24 - total",
                unit = "% (of popn 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="T", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA9.1.S3." = specification(
                name = "Difference in employment rate for low and medium education attainment (20-64)",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED0-2", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA9.1.S4." = specification(
                name = "Share of women aged 45-54 with low educational attainment",
                unit = "% (of popn 45-54)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED0-2", sex="F", unit="PC", age="Y45-54"))
        ),
        
        
        "PA9.1.S6." = specification(
                name = "Participation in VET for people with secondary educational attainment",
                unit = "% (of popn 30-36)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_ipart_s", with_filters=list(indic_ed="PS01_2", sex="T"))
        ),
        
        
        "PA9.1.C1.M" = specification(
                name = "Early leavers from education and training - men",
                unit = "% (of men 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("t2020_40", with_filters=list(sex="M"))
        ),
        
        
        "PA9.1.C1.F" = specification(
                name = "Early leavers from education and training - women",
                unit = "% (of women 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("t2020_40", with_filters=list(sex="F"))
        ),
        
        
        "PA9.1.C1.NAT" = specification(
                name = "Early leavers from education and training - nationals",
                unit = "% (of nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_01", with_filters=list(sex="T", unit="PC", citizen="NAT", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C1.EU27_2020" = specification(
                name = "Early leavers from education and training - EU27_2020 nationals",
                unit = "% (of EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_01", with_filters=list(sex="T", unit="PC", citizen="EU27_2020_FOR", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C1.NONEU27_2020" = specification(
                name = "Early leavers from education and training - non-EU nationals",
                unit = "% (of non-EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_01", with_filters=list(sex="T", unit="PC", citizen="NEU27_2020_FOR", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C1.SAME" = specification(
                name = "Early leavers from education and training - same born",
                unit = "% (of same born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_02", with_filters=list(c_birth="NAT", sex="T", unit="PC", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C1.OTHEREU27_2020" = specification(
                name = "Early leavers from education and training - other EU27_2020 born",
                unit = "% (of other EU born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_02", with_filters=list(c_birth="EU27_2020_FOR", sex="T", unit="PC", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C1.OUTEU27_2020" = specification(
                name = "Early leavers from education and training - non-EU27_2020 born",
                unit = "% (of non-EU born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_02", with_filters=list(c_birth="NEU27_2020_FOR", sex="T", unit="PC", wstatus="POP", age="Y18-24"))
        ),
        
        
        "PA9.1.C2.NEET.M" = specification(
                name = "NEET rates for age group 15-24 - men",
                unit = "% (of men 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="M", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA9.1.C2.NEET.F" = specification(
                name = "NEET rates for age group 15-24 - women",
                unit = "% (of women 15-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("edat_lfse_20", with_filters=list(sex="F", unit="PC", wstatus="NEMP", age="Y15-24", training="NO_FE_NO_NFE"))
        ),
        
        
        "PA9.1.C3.M" = specification(
                name = "Difference in employment rate for low and medium education attainment (20-64) - men",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED0-2", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA9.1.C3.F" = specification(
                name = "Difference in employment rate for low and medium education attainment (20-64) -women",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED0-2", sex="F", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA9.1.C4.M" = specification(
                name = "Participation in VET for people with secondary educational attainment-men",
                unit = "% (of popn 30-36)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_ipart_s", with_filters=list(indic_ed="PS01_2", sex="M"))
        ),
        
        
        "PA9.1.C4.F" = specification(
                name = "Participation in VET for people with secondary educational attainment -women",
                unit = "% (of popn 30-36)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_ipart_s", with_filters=list(indic_ed="PS01_2", sex="F"))
        ),
        
        
        "PA9.2.O1." = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - total",
                unit = "% (of popn 30-36)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("t2020_41", with_filters=list(sex="T", age="Y30-34", unit="PC", isced11="ED5-8"))
        ),
        
        
        "PA9.2.S1.READ" = specification(
                name = "Share of low-achieving 15-years olds in reading",
                unit = "% (of 15 yrs old)",
                source = "OECD, Pisa",
                high_is_good = FALSE,
                value = fromOECDdataset("educ_outc_pisa", with_filters=list(sex="T", field="READ", unit="PC"))
        ),
        
        
        "PA9.2.S1.MATH" = specification(
                name = "Share of low-achieving 15-years olds in mathematics",
                unit = "% (of 15 yrs old)",
                source = "OECD, Pisa",
                high_is_good = FALSE,
                value = fromOECDdataset("educ_outc_pisa", with_filters=list(sex="T", field="EF461", unit="PC"))
        ),
        
        
        "PA9.2.S1.SCIE" = specification(
                name = "Share of low-achieving 15-years olds in science",
                unit = "% (of 15 yrs old)",
                source = "OECD, Pisa",
                high_is_good = FALSE,
                value = fromOECDdataset("educ_outc_pisa", with_filters=list(sex="T", field="SCI", unit="PC"))
        ),
        
        
        "PA9.2.S2." = specification(
                name = "Difference in employment rate for medium and high education attainment (20-64)",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="T", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED5-8", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA9.2.S3." = specification(
                name = "Share of females aged 55-64 with tertiary education",
                unit = "% (of women)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="F", unit="PC", age="Y55-64"))
        ),
        
        
        "PA9.2.S5." = specification(
                name = "Share of population aged 20-24 having completed at least upper secondary education",
                unit = "% (of population)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="T", unit="PC", age="Y20-24"))
        ),
        
        
        "PA9.2.C0." = specification(
                name = "TO REVIEW: Youth education attainment level – Percentage of the population aged 20-24 having attained at least upper secondary education",
                unit = "% (of popn 20-24)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED5-8", sex="T", unit="PC", age="Y20-24"))
        ),
        
        
        "PA9.2.C1.HIGH.M" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - men",
                unit = "% (of men 30-36)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("t2020_41", with_filters=list(sex="M", age="Y30-34", unit="PC", isced11="ED5-8"))
        ),
        
        
        "PA9.2.C1.HIGH.F" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - women",
                unit = "% (of women 30-36)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("t2020_41", with_filters=list(sex="F", age="Y30-34", unit="PC", isced11="ED5-8"))
        ),
        
        
        "PA9.2.C1.NAT" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - nationals",
                unit = "% (of nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9911", with_filters=list(isced11="ED5-8", sex="T", unit="PC", citizen="NAT", age="Y30-34"))
        ),
        
        
        "PA9.2.C1.EU27_2020" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - other-EU nationals",
                unit = "% (of other EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9911", with_filters=list(isced11="ED5-8", sex="T", unit="PC", citizen="EU27_2020_FOR", age="Y30-34"))
        ),
        
        
        "PA9.2.C1.NONEU27_2020" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - non-EU nationals",
                unit = "% (of non-EU nationals)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9911", with_filters=list(isced11="ED5-8", sex="T", unit="PC", citizen="NEU27_2020_FOR", age="Y30-34"))
        ),
        
        
        "PA9.2.C1.SAME" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - same born",
                unit = "% (of same born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9912", with_filters=list(c_birth="NAT", isced11="ED5-8", sex="T", unit="PC", age="Y30-34"))
        ),
        
        
        "PA9.2.C1.OTHEREU27_2020" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - other EU born",
                unit = "% (of other EU born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9912", with_filters=list(c_birth="EU27_2020_FOR", isced11="ED5-8", sex="T", unit="PC", age="Y30-34"))
        ),
        
        
        "PA9.2.C1.OUTEU27_2020" = specification(
                name = "Completion of tertiary or equivalent education (aged 30-34) - non-EU born",
                unit = "% (of non-EU born)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfs_9912", with_filters=list(c_birth="NEU27_2020_FOR", isced11="ED5-8", sex="T", unit="PC", age="Y30-34"))
        ),
        
        
        "PA9.2.C2.M" = specification(
                name = "Difference in employment rate for medium and high education attainment (20-64) - men",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="M", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED5-8", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA9.2.C2.F" = specification(
                name = "Difference in employment rate for medium and high education attainment (20-64) - women",
                unit = "percentage points (difference in ERs)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = FALSE,
                value = fromFormula(a-b,
                                    where=variables(
                                            a = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED3_4", sex="F", unit="PC")),
                                            b = fromEurostatDataset('lfsa_ergaed', with_filters=list(age="Y20-64", isced11="ED5-8", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA9.2.C3.M" = specification(
                name = "Share of population aged 20-24 having completed at least upper secondary education - men",
                unit = "% (of population)",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="M", unit="PC", age="Y20-24"))
        ),
        
        
        "PA9.2.C3.F" = specification(
                name = "Share of population aged 20-24 having completed at least upper secondary education - women",
                unit = "graduates every 1000",
                source = "Eurostat, EU labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("edat_lfse_03", with_filters=list(isced11="ED3-8", sex="F", unit="PC", age="Y20-24"))
        ),
        
        
        "PA9.2.C4." = specification(
                name = "Tertiary graduates in science and technology per 1000 of population aged 20-29",
                unit = "% (of population)",
                source = "Eurostat, Education Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("educ_thflds", with_filters=list(indic_ed="TC02_10"))
        ),
        
        
        "PA10.O1." = specification(
                name = "Nominal unit labour cost - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = FALSE,
                value = fromEurostatDataset("nama_10_lp_ulc", with_filters=list(unit="PCH_3Y", na_item="NULC_PER"))
        ),
        
        
        "PA10.S1." = specification(
                name = "(Nominal) compensation per employee - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = FALSE,
                value = fromFormula(100*(((a/b)/(c/d))-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10', with_filters=list(nace_r2="TOTAL", na_item="D1", unit="CP_MNAC")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="SAL_DC", unit="THS_PER")),
                                            c = fromEurostatDataset('nama_10_a10', with_filters=list(nace_r2="TOTAL", na_item="D1", unit="CP_MNAC"), time_period=-3),
                                            d = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="SAL_DC", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA10.S2." = specification(
                name = "Labour productivity growth - GDP per employed person - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = TRUE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_lp_ulc', with_filters=list(na_item="RLPR_PER", unit="I10")),
                                            b = fromEurostatDataset('nama_10_lp_ulc', with_filters=list(na_item="RLPR_PER", unit="I10"), time_period=-3)
                                    ))
        ),
        
        
        "PA10.C1." = specification(
                name = "Real unit labour cost - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = FALSE,
                value = fromFormula((((a/b)/(c/d))/((e/f)/(g/h))-1)*100,
                                    where=variables(
                                            a = fromEurostatDataset('nama_10_a10', with_filters=list(nace_r2="TOTAL", na_item="D1", unit="CP_MNAC")),
                                            b = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="SAL_DC", unit="THS_PER")),
                                            c = fromEurostatDataset('nama_10_a10', with_filters=list(nace_r2="TOTAL", na_item="D1", unit="CP_MNAC"), time_period=-3),
                                            d = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="SAL_DC", unit="THS_PER"), time_period=-3),
                                            e = fromEurostatDataset('nama_10_gdp', with_filters=list(na_item="B1GQ", unit="CP_MNAC")),
                                            f = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="THS_PER")),
                                            g = fromEurostatDataset('nama_10_gdp', with_filters=list(na_item="B1GQ", unit="CP_MNAC"), time_period=-3),
                                            h = fromEurostatDataset('nama_10_a10_e', with_filters=list(nace_r2="TOTAL", na_item="EMP_DC", unit="THS_PER"), time_period=-3)
                                    ))
        ),
        
        
        "PA10.C2." = specification(
                name = "Real effective exchange rate (relative to 37 industrial countries) - growth over 3 most recent periods ",
                unit = "% growth (compared to t-3)",
                source = "Eurostat, National Accounts ",
                high_is_good = FALSE,
                value = fromFormula(100*((a/b)-1),
                                    where=variables(
                                            a = fromEurostatDataset('ert_eff_ic_a', with_filters=list(exch_rt="REER_IC37_ULCT", unit="I10")),
                                            b = fromEurostatDataset('ert_eff_ic_a', with_filters=list(exch_rt="REER_IC37_ULCT", unit="I10"), time_period=-3)
                                    ))
        ),
        
        
        "PA11.O1." = specification(
                name = "People at-risk-of poverty or social exclusion - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_peps01n", with_filters=list(sex="T", unit="PC", age="TOTAL"))
        ),
        
        
        "PA11.S1." = specification(
                name = "At-risk-of poverty rate (60% of median income) - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="T", unit="PC", indic_il="LI_R_MD60", age="TOTAL"))
        ),
        
        
        "PA11.S2." = specification(
                name = "Severe material deprivation rate (4+ items) - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="T", unit="PC", age="TOTAL"))
        ),
        
        
        "PA11.S3.T" = specification(
                name = "People (aged 0-59) living in (quasi-)jobless households - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvhl11", with_filters=list(sex="T", unit="PC_Y_LT60", age="Y_LT60"))
        ),
        
        
        "PA11.S3.M" = specification(
                name = "People (aged 0-59) living in (quasi-)jobless households - men",
                unit = "% (of male popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvhl11", with_filters=list(sex="M", unit="PC_Y_LT60", age="Y_LT60"))
        ),
        
        
        "PA11.S3.F" = specification(
                name = "People (aged 0-59) living in (quasi-)jobless households - women",
                unit = "% (of female popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvhl11", with_filters=list(sex="F", unit="PC_Y_LT60", age="Y_LT60"))
        ),
        
        
        "PA11.S4." = specification(
                name = "Impact of social transfers (other than pensions) in reducing poverty",
                unit = "% reduction in risk of poverty",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li10', with_filters=list(age="TOTAL", indic_il="LI_R_MD60BT", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="TOTAL", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.S5." = specification(
                name = "Impact of social transfers (incl pensions) in reducing poverty",
                unit = "% reduction in risk of poverty",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li09', with_filters=list(age="TOTAL", indic_il="LI_R_MD60BTP", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="TOTAL", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.S6." = specification(
                name = "At-risk of poverty rate for population living in (quasi-)jobless households",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li06", with_filters=list(sex="T", workint="WI0-02", indic_il="LI_R_MD60", age="Y_LT60", hhtyp="TOTAL"))
        ),
        
        
        "PA11.S7.T" = specification(
                name = "In-work poverty - total",
                unit = "% (of popn in work)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="T", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11.S7.M" = specification(
                name = "In-work poverty - men",
                unit = "% (of popn in work)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="M", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11.S7.F" = specification(
                name = "In-work poverty - women",
                unit = "% (of popn in work)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="F", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11.S8." = specification(
                name = "Relative median poverty risk gap",
                unit = "% (of AROP threshold)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li11", with_filters=list(sex="T", indic_il="LI_GAP_MD60", age="TOTAL"))
        ),
        
        
        "PA11.S9." = specification(
                name = "Persistent at-risk-of-poverty rate",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li21", with_filters=list(sex="T", indic_il="LIP_MD60", age="TOTAL"))
        ),
        
        
        "PA11.S10." = specification(
                name = "S80/S20",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_di11", with_filters=list(sex="T", age="TOTAL", unit="RAT"))
        ),
        
        
        "PA11.S11." = specification(
                name = "S80/S50",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_di11d", with_filters=list(sex="T", age="TOTAL", unit="RAT"))
        ),
        
        
        "PA11.S12." = specification(
                name = "S50/S20",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_di11e", with_filters=list(sex="T", age="TOTAL", unit="RAT"))
        ),
        
        
        "PA11.S13." = specification(
                name = "S40/S100",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_di11f", with_filters=list(sex="T", age="TOTAL", unit="RAT"))
        ),
        
        
        "PA11.S14." = specification(
                name = "Housing cost overburden",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvho07a", with_filters=list(sex="T", incgrp="TOTAL", unit="PC", age="TOTAL"))
        ),
        
        
        "PA11.S15." = specification(
                name = "Housing Deprivation",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_mddd04b', with_filters=list(age="TOTAL", n_item="0", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C1." = specification(
                name = "Poverty threshold (60% of median income) - value of threshold (in PPS)",
                unit = "PPS",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_li01", with_filters=list(indic_il="LI_C_MD60", hhtyp="A1", currency="PPS"))
        ),
        
        
        "PA11.C2." = specification(
                name = "S80/S20",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_di11", with_filters=list(sex="T", age="TOTAL", unit="RAT"))
        ),
        
        
        "PA11.C4.T" = specification(
                name = "Employment rate (15-64) total",
                unit = "% (of population 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="T", unit="PC_POP", age="Y15-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA11.C4.M" = specification(
                name = "Employment rate (15-64) men",
                unit = "% (of male population 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="M", unit="PC_POP", age="Y15-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA11.C4.F" = specification(
                name = "Employment rate (15-64) women",
                unit = "% (of female population 15-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("lfsi_emp_a", with_filters=list(sex="F", unit="PC_POP", age="Y15-64", indic_em="EMP_LFS"))
        ),
        
        
        "PA11.C5.T" = specification(
                name = "Social protection expenditure by function (% of GDP) - Total",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="TOTALNOREROUTE"))
        ),
        
        
        "PA11.C5.1" = specification(
                name = "Social protection expenditure by function (% of GDP) - Social protection benefits",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="SPBENEFNOREROUTE"))
        ),
        
        
        "PA11.C5.2" = specification(
                name = "Social protection expenditure by function (% of GDP) - Admin costs",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="ADMIN"))
        ),
        
        
        "PA11.C5.3" = specification(
                name = "Social protection expenditure by function (% of GDP) - Other expenditure",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="OTHER"))
        ),
        
        
        "PA11.C5.4" = specification(
                name = "Social protection expenditure by function (% of GDP) - Sickness/Healthcare",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="SICK"))
        ),
        
        
        "PA11.C5.5" = specification(
                name = "Social protection expenditure by function (% of GDP) - Disability",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="DISA"))
        ),
        
        
        "PA11.C5.6" = specification(
                name = "Social protection expenditure by function (% of GDP) - Old age",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="OLD"))
        ),
        
        
        "PA11.C5.7" = specification(
                name = "Social protection expenditure by function (% of GDP) - Survivors",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="SURVIV"))
        ),
        
        
        "PA11.C5.8" = specification(
                name = "Social protection expenditure by function (% of GDP) - Family/Children",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="FAM"))
        ),
        
        
        "PA11.C5.9" = specification(
                name = "Social protection expenditure by function (% of GDP) - Unemployment",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="UNEMPLOY"))
        ),
        
        
        "PA11.C5.10" = specification(
                name = "Social protection expenditure by function (% of GDP) - Housing",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="HOUSE"))
        ),
        
        
        "PA11.C5.11" = specification(
                name = "Social protection expenditure by function (% of GDP) - Social exclusion n.e.c.",
                unit = "% (of GDP)",
                source = "Eurostat, ESSPROS",
                high_is_good = TRUE,
                value = fromEurostatDataset("spr_exp_sum", with_filters=list(unit="PC_GDP", spdeps="EXCLU"))
        ),
        
        
        "PA11.C6." = specification(
                name = "Median relative income ratio of elderly people (65+)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp2", with_filters=list(sex="T", indic_il="R_GE65_LT65"))
        ),
        
        
        "PA11.C7." = specification(
                name = "Aggregate replacement ratio (excluding other social benefits)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp3", with_filters=list(sex="T", unit="PC"))
        ),
        
        
        "PA11.C8.M" = specification(
                name = "Healthy life years at birth - men",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="M", indic_he="HLY_0", unit="YR"))
        ),
        
        
        "PA11.C8.F" = specification(
                name = "Healthy life years at birth - women",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="F", indic_he="HLY_0", unit="YR"))
        ),
        
        
        "PA11.C9.M" = specification(
                name = "Life expectancy at birth - men",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="M", indic_he="LE_0", unit="YR"))
        ),
        
        
        "PA11.C9.F" = specification(
                name = "Life expectancy at birth - women",
                unit = "years",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("hlth_hlye", with_filters=list(sex="F", indic_he="LE_0", unit="YR"))
        ),
        
        
        "PA11.C11.T" = specification(
                name = "Unmet need for medical care by income quintile - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="TOTAL", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C11.Q1" = specification(
                name = "Unmet need for medical care by income quintile - Q1",
                unit = "% (of popn in q1)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="QU1", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C11.Q2" = specification(
                name = "Unmet need for medical care by income quintile - Q2",
                unit = "% (of popn in q2)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="QU2", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C11.Q3" = specification(
                name = "Unmet need for medical care by income quintile - Q3",
                unit = "% (of popn in q3)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="QU3", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C11.Q4" = specification(
                name = "Unmet need for medical care by income quintile - Q4",
                unit = "% (of popn in q4)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="QU4", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C11.Q5" = specification(
                name = "Unmet need for medical care by income quintile - Q5",
                unit = "% (of popn in q5)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE16", quantile="QU5", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11.C12." = specification(
                name = "Care utilisation: Doctor consultations",
                unit = "consultations per capita",
                source = "OECD, Health Statistics",
                high_is_good = NA,
                value = fromOECDdataset("consultations_per_capita", with_filters=list(indicator="CONSCOVI"))
        ),
        
        
        "PA11a.O1." = specification(
                name = "Children at-risk-of poverty or social exclusion (aged 0-17)",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_peps01n", with_filters=list(sex="T", unit="PC", age="Y_LT18"))
        ),
        
        
        "PA11a.S1." = specification(
                name = "At-risk-of poverty rate of children (aged 0-17)",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="T", unit="PC", indic_il="LI_R_MD60", age="Y_LT18"))
        ),
        
        
        "PA11a.S2." = specification(
                name = "Children living in a household suffering from severe material deprivation(4+)",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="T", unit="PC", age="Y_LT18"))
        ),
        
        
        "PA11a.S3." = specification(
                name = "Children (aged 0-17) living in (quasi-)jobless households",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvhl11", with_filters=list(sex="T", unit="PC_Y_LT60", age="Y_LT18"))
        ),
        
        
        "PA11a.S4." = specification(
                name = "Impact of social transfers (other than pensions) in reducing child poverty",
                unit = "% reduction in risk of poverty for children (0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li10', with_filters=list(age="Y_LT18", indic_il="LI_R_MD60BT", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="Y_LT18", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11a.S5." = specification(
                name = "Impact of social transfers (incl pensions) in reducing child poverty",
                unit = "% reduction in risk of poverty for children (0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li09', with_filters=list(age="Y_LT18", indic_il="LI_R_MD60BTP", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="Y_LT18", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11a.S6." = specification(
                name = "Relative median poverty risk gap (0-17)",
                unit = "% (of AROP threshold)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li11", with_filters=list(sex="T", indic_il="LI_GAP_MD60", age="Y_LT18"))
        ),
        
        
        "PA11a.S7." = specification(
                name = "Housing cost overburden (0-17)",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvho07a", with_filters=list(sex="T", incgrp="TOTAL", unit="PC", age="Y_LT18"))
        ),
        
        
        "PA11a.S8." = specification(
                name = "Housing deprivation (0-17)",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_mddd04b', with_filters=list(age="Y_LT18", n_item="0", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11a.S9." = specification(
                name = "At-risk-of poverty rate of children living in household at work (0.2<WI<=0.55) ",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula((a*b+c*d)/(b+d),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li06', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", indic_il="LI_R_MD60", sex="T", workint="WI02-045")),
                                            b = fromEurostatDataset('ilc_lvps03', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", sex="T", workint="WI02-045")),
                                            c = fromEurostatDataset('ilc_li06', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", indic_il="LI_R_MD60", sex="T", workint="WI045-055")),
                                            d = fromEurostatDataset('ilc_lvps03', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", sex="T", workint="WI045-055"))
                                    ))
        ),
        
        
        "PA11a.S10." = specification(
                name = "At-risk-of poverty rate of children living in household at work (0.55<WI<=1) ",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula((a*b+c*d)/(b+d),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li06', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", indic_il="LI_R_MD60", sex="T", workint="WI055-085")),
                                            b = fromEurostatDataset('ilc_lvps03', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", sex="T", workint="WI055-085")),
                                            c = fromEurostatDataset('ilc_li06', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", indic_il="LI_R_MD60", sex="T", workint="WI085-1")),
                                            d = fromEurostatDataset('ilc_lvps03', with_filters=list(age="Y_LT18", hhtyp="HH_DCH", sex="T", workint="WI085-1"))
                                    ))
        ),
        
        
        "PA11a.C1.ATWORK" = specification(
                name = "At-risk-of poverty rate of children living in household at work (WI>=0.2) ",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li06", with_filters=list(sex="T", workint="WI02-1", indic_il="LI_R_MD60", age="Y_LT18", hhtyp="TOTAL"))
        ),
        
        
        "PA11a.C1.NOTWORK" = specification(
                name = "At-risk-of poverty rate of children living in household not at work (WI<0.2) ",
                unit = "% (of popn 0-17)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li06", with_filters=list(sex="T", workint="WI0-02", indic_il="LI_R_MD60", age="Y_LT18", hhtyp="TOTAL"))
        ),
        
        
        "PA11a.C2.1" = specification(
                name = "Childcare (under 3 yrs, 0-29 hrs)",
                unit = "% (of popn <3yrs)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y_LT3", duration="H1-29"))
        ),
        
        
        "PA11a.C2.2" = specification(
                name = "Childcare (under 3 yrs, 30+ hrs)",
                unit = "% (of popn <3yrs)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y_LT3", duration="H_GE30"))
        ),
        
        
        "PA11a.C2.3" = specification(
                name = "Childcare (3 yrs to min CSA, 0-29 hrs)",
                unit = "% (of popn 3yrs to CSA)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y3-CSA", duration="H1-29"))
        ),
        
        
        "PA11a.C2.4" = specification(
                name = "Childcare (3 yrs to min CSA, 30+ hrs)",
                unit = "% (of popn 3yrs to CSA)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="Y3-CSA", duration="H_GE30"))
        ),
        
        
        "PA11a.C2.5" = specification(
                name = "Childcare (min CSA to 12 yrs, 0-29 hrs)",
                unit = "% (of popn min CSA to 12 yrs)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="CSA-Y12", duration="H1-29"))
        ),
        
        
        "PA11a.C2.6" = specification(
                name = "Childcare (min CSA to 12 yrs, 30+ hrs)",
                unit = "% (of popn min CSA to 12 yrs)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_caindformal", with_filters=list(age="CSA-Y12", duration="H_GE30"))
        ),
        
        
        "PA11a.C3." = specification(
                name = "Early leavers from education and training (aged 18-24) - total",
                unit = "% (of popn 18-24)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("t2020_40", with_filters=list(sex="T"))
        ),
        
        
        "PA11a.C4." = specification(
                name = "Infant mortality",
                unit = "per 1000 live births",
                source = "Eurostat, Demographic Statistics",
                high_is_good = FALSE,
                value = fromEurostatDataset("demo_minfind", with_filters=list(unit="RT", indic_de="INFMORRT"))
        ),
        
        
        "PA11b.O1." = specification(
                name = "People at risk of poverty or social exclusion (18-64)",
                unit = "% (of popn 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_peps01n", with_filters=list(sex="T", unit="PC", age="Y18-64"))
        ),
        
        
        "PA11b.S1.T" = specification(
                name = "At-risk-of poverty rate (aged 18-64) - total",
                unit = "% (of popn 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="T", unit="PC", indic_il="LI_R_MD60", age="Y18-64"))
        ),
        
        
        "PA11b.S1.M" = specification(
                name = "At-risk-of poverty rate (aged 18-64) - men",
                unit = "% (of men 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="M", unit="PC", indic_il="LI_R_MD60", age="Y18-64"))
        ),
        
        
        "PA11b.S1.F" = specification(
                name = "At-risk-of poverty rate (aged 18-64) - women",
                unit = "% (of women 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="F", unit="PC", indic_il="LI_R_MD60", age="Y18-64"))
        ),
        
        
        "PA11b.S2." = specification(
                name = "Adults (aged 18-64) living in a household suffering from severe material deprivation (4+)",
                unit = "% (of popn 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="T", unit="PC", age="Y18-64"))
        ),
        
        
        "PA11b.S3." = specification(
                name = "Adults (aged 18-59) not students living in (quasi-)jobless households",
                unit = "% (of popn 18-59)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvhl11", with_filters=list(sex="T", unit="PC_Y_LT60", age="Y18-59"))
        ),
        
        
        "PA11b.S4." = specification(
                name = "Rate of long-term unemployment (as % active population) - total",
                unit = "% (of active popn)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = FALSE,
                value = fromEurostatDataset("une_ltu_a", with_filters=list(sex="T", unit="PC_ACT", age="Y15-74", indic_em="LTU"))
        ),
        
        
        "PA11b.S5.T" = specification(
                name = "In-work poverty (18-64) - total",
                unit = "% (of employed 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="T", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11b.S5.M" = specification(
                name = "In-work poverty (18-64) - men",
                unit = "% (of employed men 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="M", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11b.S5.F" = specification(
                name = "In-work poverty (18-64) - women",
                unit = "% (of employed women 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_iw01", with_filters=list(sex="F", wstatus="EMP", age="Y18-64"))
        ),
        
        
        "PA11b.S6." = specification(
                name = "Impact of social transfers (other than pensions) in reducing working age poverty (18-64)",
                unit = "% reduction in risk of poverty for working age popn (18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li10', with_filters=list(age="Y18-64", indic_il="LI_R_MD60BT", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="Y18-64", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.S7." = specification(
                name = "Impact of social transfers (incl pensions) in reducing working age poverty (18-64)",
                unit = "% reduction in risk of poverty for working age popn (18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li09', with_filters=list(age="Y18-64", indic_il="LI_R_MD60BTP", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="Y18-64", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.S8." = specification(
                name = "At-risk of poverty rate for population living in (quasi-)jobless households (18-59)",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li06", with_filters=list(sex="T", workint="WI0-02", indic_il="LI_R_MD60", age="Y18-59", hhtyp="TOTAL"))
        ),
        
        
        "PA11b.S9." = specification(
                name = "Relative median poverty risk gap (18-64)",
                unit = "% (of AROP threshold)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li11", with_filters=list(sex="T", indic_il="LI_GAP_MD60", age="Y18-64"))
        ),
        
        
        "PA11b.S10." = specification(
                name = "Housing cost overburden (18-64)",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvho07a", with_filters=list(sex="T", incgrp="TOTAL", unit="PC", age="Y18-64"))
        ),
        
        
        "PA11b.S11." = specification(
                name = "Housing deprivation (18-64)",
                unit = "% (of popn 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_mddd04b', with_filters=list(age="Y18-64", n_item="0", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.S12." = specification(
                name = "Material and Social deprivation",
                unit = "% (of popn 18-64)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mdsd07", with_filters=list(sex="T", unit="PC", age="Y18-64"))
        ),
        
        
        "PA11b.C1.Y" = specification(
                name = "Adequacy of benefits: Net income of social assistance as a % of poverty threshold (Single person, qualifies for housing assistance)",
                unit = "NA",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = NA,
                value = fromBenefitsAndWages("adequacy_minimum_income", with_filters=list(indicator="WITH_HOUSING"))
        ),
        
        
        "PA11b.C1.N" = specification(
                name = "Adequacy of benefits: Net income of social assistance as a % of poverty threshold (Single person, does not qualifies for housing assistance)",
                unit = "NA",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = NA,
                value = fromBenefitsAndWages("adequacy_minimum_income", with_filters=list(indicator="NO_HOUSING"))
        ),
        
        
        "PA11b.C4." = specification(
                name = "Inactivity trap for the second member of a couple: marginal effective tax rate on labour income from a second member of a couple moving from social assistance to work ",
                unit = "% (of change in gross income)",
                source = "OECD and European Commission, Benefits and wages",
                high_is_good = FALSE,
                value = fromBenefitsAndWages("tax_ben_traps", with_filters=list(indicator="IT.2EC67.67.0.0"))
        ),
        
        
        "PA11b.C5.UNE" = specification(
                name = "Percentage of adult population (aged 25-64) participating in education and training - unemployed",
                unit = "% (of unemployed 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_03", with_filters=list(sex="T", unit="PC", wstatus="UNE", age="Y25-64"))
        ),
        
        
        "PA11b.C5.INAC" = specification(
                name = "Percentage of adult population (aged 25-64) participating in education and training - inactive",
                unit = "% (of inactive 25-64)",
                source = "Eurostat, EU Labour Force Survey",
                high_is_good = TRUE,
                value = fromEurostatDataset("trng_lfs_03", with_filters=list(sex="T", unit="PC", wstatus="INAC", age="Y25-64"))
        ),
        
        
        "PA11b.C6.T" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - total",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="TOTAL", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.C6.Q1" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - Q1",
                unit = "% (of popn in q1)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="QU1", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.C6.Q2" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - Q2",
                unit = "% (of popn in q2)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="QU2", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.C6.Q3" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - Q3",
                unit = "% (of popn in q3)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="QU3", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.C6.Q4" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - Q4",
                unit = "% (of popn in q4)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="QU4", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11b.C6.Q5" = specification(
                name = "Unmet need for medical care by income quintile (16-64) - Q5",
                unit = "% (of popn in q5)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y16-64", quantile="QU5", reason="NO_UNMET", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11c.O1." = specification(
                name = "People at risk of poverty or social exclusion (aged 65+) - total",
                unit = "% (of popn 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_peps01n", with_filters=list(sex="T", unit="PC", age="Y_GE65"))
        ),
        
        
        "PA11c.S1.T" = specification(
                name = "At-risk-of poverty rate of older people (aged 65+) - total",
                unit = "% (of popn 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="T", unit="PC", indic_il="LI_R_MD60", age="Y_GE65"))
        ),
        
        
        "PA11c.S1.M" = specification(
                name = "At-risk-of poverty rate of older people (aged 65+) - men",
                unit = "% (of men 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="M", unit="PC", indic_il="LI_R_MD60", age="Y_GE65"))
        ),
        
        
        "PA11c.S1.F" = specification(
                name = "At-risk-of poverty rate of older people (aged 65+) - women",
                unit = "% (of women 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li02", with_filters=list(sex="F", unit="PC", indic_il="LI_R_MD60", age="Y_GE65"))
        ),
        
        
        "PA11c.S2.T" = specification(
                name = "Severe material deprivation of older people (aged 65+) - total",
                unit = "% (of popn 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="T", unit="PC", age="Y_GE65"))
        ),
        
        
        "PA11c.S2.M" = specification(
                name = "Severe material deprivation of older people (aged 65+) - men",
                unit = "% (of men 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="M", unit="PC", age="Y_GE65"))
        ),
        
        
        "PA11c.S2.F" = specification(
                name = "Severe material deprivation of older people (aged 65+) - women",
                unit = "% (of women 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_mddd11", with_filters=list(sex="F", unit="PC", age="Y_GE65"))
        ),
        
        
        "PA11c.S3." = specification(
                name = "Impact of social transfers (incl pensions) in reducing old age poverty (65+)",
                unit = "% reduction in risk of poverty for elderly popn (65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromFormula(100*((a-b)/a),
                                    where=variables(
                                            a = fromEurostatDataset('ilc_li09', with_filters=list(age="Y_GE65", indic_il="LI_R_MD60BTP", sex="T")),
                                            b = fromEurostatDataset('ilc_li02', with_filters=list(age="Y_GE65", indic_il="LI_R_MD60", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11c.S4." = specification(
                name = "Relative median poverty risk gap (65+)",
                unit = "% (of AROP threshold)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_li11", with_filters=list(sex="T", indic_il="LI_GAP_MD60", age="Y_GE65"))
        ),
        
        
        "PA11c.S5." = specification(
                name = "Aggregate replacement ratio (excl other social benefits)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp3", with_filters=list(sex="T", unit="PC"))
        ),
        
        
        "PA11c.S6." = specification(
                name = "Median relative income of elderly people (65+)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp2", with_filters=list(sex="T", indic_il="R_GE65_LT65"))
        ),
        
        
        "PA11c.S7." = specification(
                name = "Housing cost overburden (65+)",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromEurostatDataset("ilc_lvho07a", with_filters=list(sex="T", incgrp="TOTAL", unit="PC", age="Y_GE65"))
        ),
        
        
        "PA11c.S8." = specification(
                name = "Housing deprivation (65+)",
                unit = "% (of popn 65+)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('ilc_mddd04b', with_filters=list(age="Y_GE65", n_item="0", sex="T", unit="PC"))
                                    ))
        ),
        
        
        "PA11c.C1." = specification(
                name = "Aggregate replacement ratio (excluding other social benefits)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp3", with_filters=list(sex="T", unit="PC"))
        ),
        
        
        "PA11c.C2." = specification(
                name = "Median relative income of elderly people (65+)",
                unit = "ratio",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = TRUE,
                value = fromEurostatDataset("ilc_pnp2", with_filters=list(sex="T", indic_il="R_GE65_LT65"))
        ),
        
        
        "PA11c.C6.M" = specification(
                name = "Unmet need for medical care (men 65+) ",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE65", quantile="TOTAL", reason="NO_UNMET", sex="M", unit="PC"))
                                    ))
        ),
        
        
        "PA11c.C6.F" = specification(
                name = "Unmet need for medical care (women 65+)",
                unit = "% (of total popn)",
                source = "Eurostat, EU Statistics on Income and Living Conditions",
                high_is_good = FALSE,
                value = fromFormula(100-a,
                                    where=variables(
                                            a = fromEurostatDataset('hlth_silc_08', with_filters=list(age="Y_GE65", quantile="TOTAL", reason="NO_UNMET", sex="F", unit="PC"))
                                    ))
        ),
        
        
        "PA11c.C7." = specification(
                name = "Life expectancy at 65 - total",
                unit = "years ",
                source = "Eurostat, Demographic Statistics",
                high_is_good = TRUE,
                value = fromEurostatDataset("demo_mlexpec", with_filters=list(sex="T", unit="YR", age="Y65"))
        )
        
        
        ### Mis-specified indicators:
        
        
)
