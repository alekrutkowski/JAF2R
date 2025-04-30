#############################JAF DIGITAL INDICATORS
#####YEAR 2022


####Read csv & load libraries:

library(pacman)
p_load(expss, tidyverse, readxl, ggthemes, knitr, ggeffects, arm,
       texreg, ggeffects, ROCR, haven, ggmap, sf, sp, countrycode,
       ggpubr, descriptio,writexl,openxlsx, expss, tidyverse, readxl, ggthemes, knitr, ggeffects, arm,
       texreg, ggeffects, ROCR, haven, ggmap, sf, sp, countrycode,
       ggpubr)

library(dplyr)
library(survey)
library(expss)
library(labelled)

#!!!DEFINE DATASET/PATH: 
dataset <- read_csv("P:\\MicroData\\SILC\\Microdata_2024_October\\result\\SILC_C_2022_all.csv")

dataset <- dataset %>% filter(COUNTRY != "NO")

dataset_backup <- dataset

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#1. Calculation for Indicator 1 ----
#Name of indicator: PA15b.O1.	Persons in a household with and without internet access for personal use at home (total population)

table(dataset$PD080)
table(dataset$RB050)

dataset$PD080 <- ifelse(dataset$PD080 == 2 | dataset$PD080 == 3, 2, dataset$PD080)

dataset$PD080 <- factor(dataset$PD080, levels = 1:2, labels = c("Internet access", "No internet access"))
var_label(dataset$PD080) <- "Internet connection for personal use at home"


Persons_WithoutInternet_TotalPopulation <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_WithoutInternet_TotalPopulation$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#2. Calculation for Indicator 2 & Indicator 3 ----
#Name of indicator: PA15b.S1.	Persons in a household without internet access for personal use at home for population at risk of poverty or social exclusion
#Name of indicator: PA15b.S2.Persons in a household without internet access for personal use at home for population not at risk of poverty or social exclusion


table(dataset$RX070)

dataset$AROPE <- ifelse(dataset$RX070 %in% c(1, 10, 11, 100, 101, 110, 111), 1, 
                        ifelse(dataset$RX070 == 0, 0, NA))


Persons_withoutInternet_AROPE <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, AROPE, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()


Persons_withoutInternet_AROPE$AROPE <- ifelse(Persons_withoutInternet_AROPE$AROPE==1, "Yes, AROPE", "No, not AROPE")
Persons_withoutInternet_AROPE$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#3. Calculation for Indicator 4 & Indicator 5 ----
#Name of indicator: PA15b.S3.Persons in a household without internet access for personal use at home for population at risk of poverty
#Name of indicator: PA15b.S4.Persons in a household without internet access for personal use at home for population not at risk of poverty

####Poor is 1 and NOT POOR 0 (this is AROP)

table(dataset$HX080)

dataset$AROP <- ifelse(dataset$HX080 ==0, 0, 
                       ifelse(dataset$HX080 == 1, 1, 0))


Persons_withoutInternet_AROP <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, AROP, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()


Persons_withoutInternet_AROP$AROP <- ifelse(Persons_withoutInternet_AROP$AROP==1, "Yes, AROP", "No, not AROP")
Persons_withoutInternet_AROP$weighted_sum <- NULL


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#4. Calculation for indicator 6 & Indicator 7 & Indicator 8 ----
#Name of indicator: PA15b.S5.Persons aged 0-17 in a household without internet access for personal use at home
#Name of indicator: PA15b.S6.Persons aged 18-64 in a household without internet access for personal use at home
#Name of indicator: PA15b.S7.Persons aged 65+ in a household without internet access for personal use at home


#Defining the age groups variable:

library(dplyr)

table(dataset$RB080)

# A. Create new_RB080: correcting RB080 values for Malta
dataset <- dataset %>%
  mutate(
    new_RB080 = RB080,
    new_RB080 = case_when(
      new_RB080 == 1  ~ 1939,
      new_RB080 == 2  ~ 1941,
      new_RB080 == 3  ~ 1946,
      new_RB080 == 4  ~ 1951,
      new_RB080 == 5  ~ 1956,
      new_RB080 == 6  ~ 1961,
      new_RB080 == 7  ~ 1966,
      new_RB080 == 8  ~ 1971,
      new_RB080 == 9  ~ 1976,
      new_RB080 == 10 ~ 1981,
      new_RB080 == 11 ~ 1986,
      new_RB080 == 12 ~ 1991,
      new_RB080 == 13 ~ 1996,
      new_RB080 == 14 ~ 2001,
      new_RB080 == 15 ~ 2006,
      new_RB080 == 16 ~ 2011,
      new_RB080 == 17 ~ 2016,
      TRUE ~ new_RB080  # keep original if no match
    )
  )

#test <- dataset %>% dplyr::select(RB080, new_RB080, RX010, COUNTRY)

# B. Create new_RX010: adjusted age for Malta
dataset <- dataset %>%
  mutate(
    new_RX010 = RX010,
    new_RX010 = if_else(COUNTRY %in% c("MT"), YEAR - new_RB080, new_RX010)
  )

# C. Create age_group variable
dataset <- dataset %>%
  mutate(
    age_group = case_when(
      !is.na(new_RX010) & new_RX010 >= 0  & new_RX010 < 18  ~ 1,
      new_RX010 >= 18 & new_RX010 <= 64  ~ 2,
      new_RX010 >= 65 ~ 3,
      TRUE ~ NA_real_
    )
  )


# D. Label age groups
age_group_labels <- c("16-17 years old", "18-64 years old", "65+ years")
dataset$age_group <- factor(dataset$age_group, levels = 1:3, labels = age_group_labels)

test <- dataset %>% dplyr::select(RX010, new_RX010, new_RB080, age_group, COUNTRY, PD080)


Persons_withoutInternet_AgeGroups <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, age_group, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_withoutInternet_AgeGroups$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#5. Calculation for indicator 9 & Indicator 10 ----
#Name of indicator: PA15b.S8.Persons in a household without internet access for personal use at home - men
#Name of indicator: PA15b.S9.Persons in a household without internet access for personal use at home - women

table(dataset$PB150)

Persons_withoutInternet_GENDER <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, PB150, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_withoutInternet_GENDER$PB150 <- ifelse(Persons_withoutInternet_GENDER$PB150==1, "Male", "Female")
Persons_withoutInternet_GENDER$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#6. Calculation for indicator 11 & Indicator 12 ----
#Name of indicator: PA15b.S10.Persons in a household without internet access for personal use at home living in an urban setting
#Name of indicator: PA15b.S11.Persons in a household without internet access for personal use at home living in a rural setting

dataset <- dataset %>%
  mutate(
    Urbanisation = case_when(
      DB100==1 | DB100==2  ~ "Urban Areas",
      DB100==3 ~ "Rural Areas",
      TRUE ~ NA_character_
    )
  )


Persons_withoutInternet_URBANISATION <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, Urbanisation, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_withoutInternet_URBANISATION$weighted_sum <- NULL


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#7. Calculation for indicator 13 & Indicator 14 & Indicator 15 ----
#Name of indicator: PA15b.S12.Persons with low educational attainment level in a household without internet access for personal use at home 
#Name of indicator: PA15b.S13.Persons with medium educational attainment level in a household without internet access for personal use at home 
#Name of indicator: PA15b.S14.Persons with high educational attainment level in a household without internet access for personal use at home 

#Create the EDUC variable:

dataset <- dataset %>%
  mutate(
    # 1. Lower secondary education
    lower_secondary = case_when(
      !is.na(PE041) & PE041 <= 200 & COUNTRY!="IE" ~ 1,
      COUNTRY=="IE" & PE041 <=2 ~ 1,
      is.na(PE041)                 ~ NA_real_,
      TRUE                         ~ 0
    ),
    
    # 2. Upper secondary education
    upper_secondary = case_when(
      !is.na(PE041) & PE041 > 200 & PE041 < 500 & COUNTRY!= "IE" ~ 1,
      COUNTRY == "IE" & PE041 >2 & PE041 <5 ~ 1,
      is.na(PE041)                              ~ NA_real_,
      TRUE                                      ~ 0
    ),
    
    # 3. Tertiary education
    tertiary = case_when(
      !is.na(PE041) & PE041 >= 500 & COUNTRY != "IE" ~ 1,
      COUNTRY=="IE" & PE041 >=5 ~ 1,
      is.na(PE041)                 ~ NA_real_,
      TRUE                         ~ 0
    ),
    
    # 4. Education category (character variable)
    educ = case_when(
      lower_secondary == 1 ~ "lower_secondary/ Low Education",
      upper_secondary == 1 ~ "upper_secondary / Medium Education",
      tertiary == 1        ~ "tertiary/ High Education",
      is.na(PE041)         ~ "missing"
    )
  )


Persons_withoutInternet_Education <- dataset %>%
  filter(!is.na(PD080), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, educ, PD080) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_withoutInternet_Education$weighted_sum <- NULL


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#8. Calculation for indicator 16 ----
#Name of indicator: Persons in a household without a computer (total population)

table(dataset$HS090)

dataset$HS090 <- ifelse(dataset$HS090 == 2 | dataset$HS090 == 3, 2, dataset$HS090)

dataset$HS090 <- factor(dataset$HS090, levels = 1:2, labels = c("Having computer", "No computer"))
var_label(dataset$HS090) <- "Do you have a computer?"

Persons_WithoutComputer_TotalPopulation <- dataset %>%
  filter(!is.na(HS090), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, HS090) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_WithoutComputer_TotalPopulation$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#10. Calculation for indicator 17 & indicator 18 ----
#Name of indicator: PA15b.S16.Persons in a household without a computer for population at risk of poverty
#Name of indicator: PA15b.S17.Persons in a household without a computer for population not at risk of poverty


Persons_withoutComputer_AROP <- dataset %>%
  filter(!is.na(HS090), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, AROP, HS090) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()


Persons_withoutComputer_AROP$AROP <- ifelse(Persons_withoutComputer_AROP$AROP==1, "Yes, AROP", "No, not AROP")
Persons_withoutComputer_AROP$weighted_sum <- NULL

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#11. Calculation for indicator 19 and indicator 20 ----
#Name of indicator: PA15b.S18.Persons in a household without a computer living in an urban setting
#Name of indicator: PA15b.S17.PA15b.S19.Persons in a household without a computer living in a rural setting


Persons_withoutComputer_URBANISATION <- dataset %>%
  filter(!is.na(HS090), !is.na(RB050), !is.na(COUNTRY)) %>%
  group_by(COUNTRY, Urbanisation, HS090) %>%
  summarise(weighted_sum = sum(RB050), .groups = "drop_last") %>%
  mutate(weighted_prop = (weighted_sum / sum(weighted_sum))*100) %>%
  ungroup()

Persons_withoutComputer_URBANISATION$weighted_sum <-  NULL


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
######################FINAL SECTION################################
#Filters to create the final indicators based on the above dataframes:

##PA15b.O1.Persons in a household without internet access for personal use at home (total population)
Persons_withoutInternet_TotalPopulation_filtered_2022 <- Persons_WithoutInternet_TotalPopulation %>% 
  filter(PD080 == "No internet access")

Persons_withoutInternet_TotalPopulation_filtered_2022$time <- 2022

Persons_withoutInternet_TotalPopulation_filtered_2022 <- Persons_withoutInternet_TotalPopulation_filtered_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S1.Persons in a household without internet access for personal use at home for population at risk of poverty or social exclusion
Persons_withoutInternet_AROPE_filtered_1_2022 <- Persons_withoutInternet_AROPE %>%
  filter(PD080== "No internet access" & AROPE == "Yes, AROPE")

Persons_withoutInternet_AROPE_filtered_1_2022$time <- 2022

Persons_withoutInternet_AROPE_filtered_1_2022 <- Persons_withoutInternet_AROPE_filtered_1_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S2.Persons in a household without internet access for personal use at home for population not at risk of poverty or social exclusion
Persons_withoutInternet_notAROPE_filtered_2_2022 <- Persons_withoutInternet_AROPE %>%
  filter(PD080== "No internet access" & AROPE != "Yes, AROPE")

Persons_withoutInternet_notAROPE_filtered_2_2022$time <- 2022

Persons_withoutInternet_notAROPE_filtered_2_2022 <- Persons_withoutInternet_notAROPE_filtered_2_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S3.Persons in a household without internet access for personal use at home for population at risk of poverty
Persons_withoutInternet_AROP_filtered_1_2022 <- Persons_withoutInternet_AROP %>%
  filter(PD080 == "No internet access" & AROP == "Yes, AROP")

Persons_withoutInternet_AROP_filtered_1_2022$time <- 2022

Persons_withoutInternet_AROP_filtered_1_2022 <- Persons_withoutInternet_AROP_filtered_1_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S4.Persons in a household without internet access for personal use at home for population not at risk of poverty
Persons_withoutInternet_notAROP_filtered_2_2022 <- Persons_withoutInternet_AROP %>%
  filter(PD080 == "No internet access" & AROP != "Yes, AROP")

Persons_withoutInternet_notAROP_filtered_2_2022$time <- 2022

Persons_withoutInternet_notAROP_filtered_2_2022 <- Persons_withoutInternet_notAROP_filtered_2_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S5.Persons aged 0-17 in a household without internet access for personal use at home
Persons_withoutInternet_AgeGroups_Ages1617_2022 <- Persons_withoutInternet_AgeGroups %>%
  filter(PD080 == "No internet access" & age_group == "16-17 years old")

Persons_withoutInternet_AgeGroups_Ages1617_2022$time <- 2022

Persons_withoutInternet_AgeGroups_Ages1617_2022 <- Persons_withoutInternet_AgeGroups_Ages1617_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S6.Persons aged 18-64 in a household without internet access for personal use at home
Persons_withoutInternet_AgeGroups_Ages1864_2022 <- Persons_withoutInternet_AgeGroups %>%
  filter(PD080 == "No internet access" & age_group == "18-64 years old")

Persons_withoutInternet_AgeGroups_Ages1864_2022$time <- 2022

Persons_withoutInternet_AgeGroups_Ages1864_2022 <- Persons_withoutInternet_AgeGroups_Ages1864_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S7.Persons aged 65+ in a household without internet access for personal use at home
Persons_withoutInternet_AgeGroups_Ages65Over_2022 <- Persons_withoutInternet_AgeGroups %>%
  filter(PD080 == "No internet access" & age_group == "65+ years")

Persons_withoutInternet_AgeGroups_Ages65Over_2022$time <- 2022

Persons_withoutInternet_AgeGroups_Ages65Over_2022 <- Persons_withoutInternet_AgeGroups_Ages65Over_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S8.Persons in a household without internet access for personal use at home - men
Persons_withoutInternet_GENDER_filtered_Men_2022 <- Persons_withoutInternet_GENDER %>%
  filter(PD080 == "No internet access" & PB150 == "Male")


Persons_withoutInternet_GENDER_filtered_Men_2022$time <- 2022

Persons_withoutInternet_GENDER_filtered_Men_2022 <- Persons_withoutInternet_GENDER_filtered_Men_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S9.Persons in a household without internet access for personal use at home - women
Persons_withoutInternet_GENDER_filtered_Female_2022 <- Persons_withoutInternet_GENDER %>%
  filter(PD080 == "No internet access" & PB150 == "Female")

Persons_withoutInternet_GENDER_filtered_Female_2022$time <- 2022

Persons_withoutInternet_GENDER_filtered_Female_2022 <- Persons_withoutInternet_GENDER_filtered_Female_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S10.Persons in a household without internet access for personal use at home living in an urban setting
Persons_withoutInternet_URBANISATION_Urban_2022 <- Persons_withoutInternet_URBANISATION %>%
  filter(PD080 == "No internet access" & Urbanisation == "Urban Areas")

Persons_withoutInternet_URBANISATION_Urban_2022$time <- 2022

Persons_withoutInternet_URBANISATION_Urban_2022 <- Persons_withoutInternet_URBANISATION_Urban_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S11.Persons in a household without internet access for personal use at home living in a rural setting
Persons_withoutInternet_URBANISATION_Rural_2022 <- Persons_withoutInternet_URBANISATION %>%
  filter(PD080 == "No internet access" & Urbanisation == "Rural Areas")

Persons_withoutInternet_URBANISATION_Rural_2022$time <- 2022

Persons_withoutInternet_URBANISATION_Rural_2022 <- Persons_withoutInternet_URBANISATION_Rural_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S12.Persons with low educational attainment level in a household without internet access for personal use at home 
Persons_withoutInternet_Education_Low_2022 <- Persons_withoutInternet_Education %>%
  filter(PD080 == "No internet access" & educ == "lower_secondary/ Low Education")


Persons_withoutInternet_Education_Low_2022$time <- 2022

Persons_withoutInternet_Education_Low_2022 <- Persons_withoutInternet_Education_Low_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S13.Persons with medium educational attainment level in a household without internet access for personal use at home 
Persons_withoutInternet_Education_Medium_2022 <- Persons_withoutInternet_Education %>%
  filter(PD080 == "No internet access" & educ == "upper_secondary / Medium Education")

Persons_withoutInternet_Education_Medium_2022$time <- 2022

Persons_withoutInternet_Education_Medium_2022 <- Persons_withoutInternet_Education_Medium_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)



##PA15b.S14.Persons with high educational attainment level in a household without internet access for personal use at home 
Persons_withoutInternet_Education_High_2022 <- Persons_withoutInternet_Education %>%
  filter(PD080 == "No internet access" & educ == "tertiary/ High Education")

Persons_withoutInternet_Education_High_2022$time <- 2022

Persons_withoutInternet_Education_High_2022 <- Persons_withoutInternet_Education_High_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S15.Persons in a household without a computer (total population)
Persons_WithoutComputer_TotalPopulation_filtered_2022 <- Persons_WithoutComputer_TotalPopulation %>%
  filter(HS090 == "No computer")


Persons_WithoutComputer_TotalPopulation_filtered_2022$time <- 2022

Persons_WithoutComputer_TotalPopulation_filtered_2022 <- Persons_WithoutComputer_TotalPopulation_filtered_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S16.Persons in a household without a computer for population at risk of poverty
Persons_withoutComputer_AROP_filtered_1_2022 <-  Persons_withoutComputer_AROP %>%
  filter(HS090 == "No computer" & AROP == "Yes, AROP")


Persons_withoutComputer_AROP_filtered_1_2022$time <- 2022

Persons_withoutComputer_AROP_filtered_1_2022 <- Persons_withoutComputer_AROP_filtered_1_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S17.Persons in a household without a computer for population not at risk of poverty
Persons_withoutComputer_notAROP_filtered_2_2022 <-  Persons_withoutComputer_AROP %>%
  filter(HS090 == "No computer" & AROP == "No, not AROP")

Persons_withoutComputer_notAROP_filtered_2_2022$time <- 2022

Persons_withoutComputer_notAROP_filtered_2_2022 <- Persons_withoutComputer_notAROP_filtered_2_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S18.Persons in a household without a computer living in an urban setting
Persons_withoutComputer_URBANISATION_Urban_2022 <- Persons_withoutComputer_URBANISATION %>%
  filter(HS090 == "No computer" & Urbanisation == "Urban Areas")

Persons_withoutComputer_URBANISATION_Urban_2022$time <- 2022

Persons_withoutComputer_URBANISATION_Urban_2022 <- Persons_withoutComputer_URBANISATION_Urban_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


##PA15b.S19.Persons in a household without a computer living in a rural setting
Persons_withoutComputer_URBANISATION_Rural_2022 <- Persons_withoutComputer_URBANISATION %>%
  filter(HS090 == "No computer" & Urbanisation == "Rural Areas")

Persons_withoutComputer_URBANISATION_Rural_2022$time <- 2022

Persons_withoutComputer_URBANISATION_Rural_2022 <- Persons_withoutComputer_URBANISATION_Rural_2022 %>%
  rename(
    geo = COUNTRY,
    value = weighted_prop
  ) %>% dplyr::select(geo, time, value)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###Final datasets to use: ####

#Persons_withoutInternet_TotalPopulation_filtered_2022
#Persons_withoutInternet_AROPE_filtered_1_2022
#Persons_withoutInternet_notAROPE_filtered_2_2022
#Persons_withoutInternet_AROP_filtered_1_2022
#Persons_withoutInternet_notAROP_filtered_2_2022
#Persons_withoutInternet_AgeGroups_Ages1617_2022
#Persons_withoutInternet_AgeGroups_Ages1864_2022
#Persons_withoutInternet_AgeGroups_Ages65Over_2022
#Persons_withoutInternet_GENDER_filtered_Men_2022
#Persons_withoutInternet_GENDER_filtered_Female_2022
#Persons_withoutInternet_URBANISATION_Urban_2022
#Persons_withoutInternet_URBANISATION_Rural_2022
#Persons_withoutInternet_Education_Low_2022
#Persons_withoutInternet_Education_Medium_2022
#Persons_withoutInternet_Education_High_2022
#Persons_WithoutComputer_TotalPopulation_filtered_2022
#Persons_withoutComputer_AROP_filtered_1_2022
#Persons_withoutComputer_notAROP_filtered_2_2022
#Persons_withoutComputer_URBANISATION_Urban_2022
#Persons_withoutComputer_URBANISATION_Rural_2022



rstudioapi::getSourceEditorContext()$path

rm(list = setdiff(ls(), ls(pattern = "_2022")))


