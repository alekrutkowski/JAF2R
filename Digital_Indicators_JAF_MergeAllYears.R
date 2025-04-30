#########################JAF INDICATORS##############
#######MERGE AND CREATE FINAL DATAFRAMES######################



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Persons_withoutInternet_TotalPopulation_filtered_FINAL <- rbind(Persons_withoutInternet_TotalPopulation_filtered,
                                                                Persons_withoutInternet_TotalPopulation_filtered_2022,
                                                                Persons_withoutInternet_TotalPopulation_filtered_2021,
                                                                Persons_withoutInternet_TotalPopulation_filtered_2020)


Persons_withoutInternet_TotalPopulation_filtered_FINAL <- Persons_withoutInternet_TotalPopulation_filtered_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_TotalPopulation_filtered_FINAL <- Persons_withoutInternet_TotalPopulation_filtered_FINAL %>%
  arrange(geo)



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_AROPE_filtered_1_FINAL <- rbind(Persons_withoutInternet_AROPE_filtered_1,
                                                        Persons_withoutInternet_AROPE_filtered_1_2022,
                                                        Persons_withoutInternet_AROPE_filtered_1_2021,
                                                        Persons_withoutInternet_AROPE_filtered_1_2020)


Persons_withoutInternet_AROPE_filtered_1_FINAL <- Persons_withoutInternet_AROPE_filtered_1_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_AROPE_filtered_1_FINAL <- Persons_withoutInternet_AROPE_filtered_1_FINAL %>%
  arrange(geo)



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_notAROPE_filtered_2_FINAL <- rbind(Persons_withoutInternet_notAROPE_filtered_2,
                                                           Persons_withoutInternet_notAROPE_filtered_2_2022,
                                                           Persons_withoutInternet_notAROPE_filtered_2_2021,
                                                           Persons_withoutInternet_notAROPE_filtered_2_2020)


Persons_withoutInternet_notAROPE_filtered_2_FINAL <- Persons_withoutInternet_notAROPE_filtered_2_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_notAROPE_filtered_2_FINAL <- Persons_withoutInternet_notAROPE_filtered_2_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_AROP_filtered_1_FINAL <- rbind(Persons_withoutInternet_AROP_filtered_1,
                                                       Persons_withoutInternet_AROP_filtered_1_2022,
                                                       Persons_withoutInternet_AROP_filtered_1_2021,
                                                       Persons_withoutInternet_AROP_filtered_1_2020)


Persons_withoutInternet_AROP_filtered_1_FINAL <- Persons_withoutInternet_AROP_filtered_1_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_AROP_filtered_1_FINAL <- Persons_withoutInternet_AROP_filtered_1_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_notAROP_filtered_2_FINAL <- rbind(Persons_withoutInternet_notAROP_filtered_2,
                                                          Persons_withoutInternet_notAROP_filtered_2_2022,
                                                          Persons_withoutInternet_notAROP_filtered_2_2021,
                                                          Persons_withoutInternet_notAROP_filtered_2_2020)


Persons_withoutInternet_notAROP_filtered_2_FINAL <- Persons_withoutInternet_notAROP_filtered_2_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_notAROP_filtered_2_FINAL <- Persons_withoutInternet_notAROP_filtered_2_FINAL %>%
  arrange(geo)



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_AgeGroups_Ages1617_FINAL <- rbind(Persons_withoutInternet_AgeGroups_Ages1617,
                                                          Persons_withoutInternet_AgeGroups_Ages1617_2022,
                                                          Persons_withoutInternet_AgeGroups_Ages1617_2021,
                                                          Persons_withoutInternet_AgeGroups_Ages1617_2020)


Persons_withoutInternet_AgeGroups_Ages1617_FINAL <- Persons_withoutInternet_AgeGroups_Ages1617_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_AgeGroups_Ages1617_FINAL <- Persons_withoutInternet_AgeGroups_Ages1617_FINAL %>%
  arrange(geo)




####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_AgeGroups_Ages1864_FINAL <- rbind(Persons_withoutInternet_AgeGroups_Ages1864,
                                                          Persons_withoutInternet_AgeGroups_Ages1864_2022,
                                                          Persons_withoutInternet_AgeGroups_Ages1864_2021,
                                                          Persons_withoutInternet_AgeGroups_Ages1864_2020)


Persons_withoutInternet_AgeGroups_Ages1864_FINAL <- Persons_withoutInternet_AgeGroups_Ages1864_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_AgeGroups_Ages1864_FINAL <- Persons_withoutInternet_AgeGroups_Ages1864_FINAL %>%
  arrange(geo)




####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_AgeGroups_Ages65Over_FINAL <- rbind(Persons_withoutInternet_AgeGroups_Ages65Over,
                                                            Persons_withoutInternet_AgeGroups_Ages65Over_2022,
                                                            Persons_withoutInternet_AgeGroups_Ages65Over_2021,
                                                            Persons_withoutInternet_AgeGroups_Ages65Over_2020)


Persons_withoutInternet_AgeGroups_Ages65Over_FINAL <- Persons_withoutInternet_AgeGroups_Ages65Over_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_AgeGroups_Ages65Over_FINAL <- Persons_withoutInternet_AgeGroups_Ages65Over_FINAL %>%
  arrange(geo)




####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_GENDER_filtered_Men_FINAL <- rbind(Persons_withoutInternet_GENDER_filtered_Men,
                                                           Persons_withoutInternet_GENDER_filtered_Men_2022,
                                                           Persons_withoutInternet_GENDER_filtered_Men_2021,
                                                           Persons_withoutInternet_GENDER_filtered_Men_2020)


Persons_withoutInternet_GENDER_filtered_Men_FINAL <- Persons_withoutInternet_GENDER_filtered_Men_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_GENDER_filtered_Men_FINAL <- Persons_withoutInternet_GENDER_filtered_Men_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_GENDER_filtered_Female_FINAL <- rbind(Persons_withoutInternet_GENDER_filtered_Female,
                                                              Persons_withoutInternet_GENDER_filtered_Female_2022,
                                                              Persons_withoutInternet_GENDER_filtered_Female_2021,
                                                              Persons_withoutInternet_GENDER_filtered_Female_2020)


Persons_withoutInternet_GENDER_filtered_Female_FINAL <- Persons_withoutInternet_GENDER_filtered_Female_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_GENDER_filtered_Female_FINAL <- Persons_withoutInternet_GENDER_filtered_Female_FINAL %>%
  arrange(geo)




####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_URBANISATION_Urban_FINAL <- rbind(Persons_withoutInternet_URBANISATION_Urban,
                                                          Persons_withoutInternet_URBANISATION_Urban_2022,
                                                          Persons_withoutInternet_URBANISATION_Urban_2021,
                                                          Persons_withoutInternet_URBANISATION_Urban_2020)


Persons_withoutInternet_URBANISATION_Urban_FINAL <- Persons_withoutInternet_URBANISATION_Urban_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_URBANISATION_Urban_FINAL <- Persons_withoutInternet_URBANISATION_Urban_FINAL %>%
  arrange(geo)



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_URBANISATION_Rural_FINAL <- rbind(Persons_withoutInternet_URBANISATION_Rural,
                                                          Persons_withoutInternet_URBANISATION_Rural_2022,
                                                          Persons_withoutInternet_URBANISATION_Rural_2021,
                                                          Persons_withoutInternet_URBANISATION_Rural_2020)


Persons_withoutInternet_URBANISATION_Rural_FINAL <- Persons_withoutInternet_URBANISATION_Rural_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_URBANISATION_Rural_FINAL <- Persons_withoutInternet_URBANISATION_Rural_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_Education_Low_FINAL <- rbind(Persons_withoutInternet_Education_Low,
                                                     Persons_withoutInternet_Education_Low_2022,
                                                     Persons_withoutInternet_Education_Low_2021,
                                                     Persons_withoutInternet_Education_Low_2020)


Persons_withoutInternet_Education_Low_FINAL <- Persons_withoutInternet_Education_Low_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_Education_Low_FINAL <- Persons_withoutInternet_Education_Low_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_Education_Medium_FINAL <- rbind(Persons_withoutInternet_Education_Medium,
                                                        Persons_withoutInternet_Education_Medium_2022,
                                                        Persons_withoutInternet_Education_Medium_2021,
                                                        Persons_withoutInternet_Education_Medium_2020)


Persons_withoutInternet_Education_Medium_FINAL <- Persons_withoutInternet_Education_Medium_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_Education_Medium_FINAL <- Persons_withoutInternet_Education_Medium_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutInternet_Education_High_FINAL <- rbind(Persons_withoutInternet_Education_High,
                                                      Persons_withoutInternet_Education_High_2022,
                                                      Persons_withoutInternet_Education_High_2021,
                                                      Persons_withoutInternet_Education_High_2020)


Persons_withoutInternet_Education_High_FINAL <- Persons_withoutInternet_Education_High_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutInternet_Education_High_FINAL <- Persons_withoutInternet_Education_High_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_WithoutComputer_TotalPopulation_filtered_FINAL <- rbind(Persons_WithoutComputer_TotalPopulation_filtered,
                                                                Persons_WithoutComputer_TotalPopulation_filtered_2022,
                                                                Persons_WithoutComputer_TotalPopulation_filtered_2021,
                                                                Persons_WithoutComputer_TotalPopulation_filtered_2020)


Persons_WithoutComputer_TotalPopulation_filtered_FINAL <- Persons_WithoutComputer_TotalPopulation_filtered_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_WithoutComputer_TotalPopulation_filtered_FINAL <- Persons_WithoutComputer_TotalPopulation_filtered_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutComputer_AROP_filtered_1_FINAL <- rbind(Persons_withoutComputer_AROP_filtered_1,
                                                       Persons_withoutComputer_AROP_filtered_1_2022,
                                                       Persons_withoutComputer_AROP_filtered_1_2021,
                                                       Persons_withoutComputer_AROP_filtered_1_2020)


Persons_withoutComputer_AROP_filtered_1_FINAL <- Persons_withoutComputer_AROP_filtered_1_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutComputer_AROP_filtered_1_FINAL <- Persons_withoutComputer_AROP_filtered_1_FINAL %>%
  arrange(geo)



####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutComputer_notAROP_filtered_2_FINAL <- rbind(Persons_withoutComputer_notAROP_filtered_2,
                                                          Persons_withoutComputer_notAROP_filtered_2_2022,
                                                          Persons_withoutComputer_notAROP_filtered_2_2021,
                                                          Persons_withoutComputer_notAROP_filtered_2_2020)


Persons_withoutComputer_notAROP_filtered_2_FINAL <- Persons_withoutComputer_notAROP_filtered_2_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutComputer_notAROP_filtered_2_FINAL <- Persons_withoutComputer_notAROP_filtered_2_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutComputer_URBANISATION_Urban_FINAL <- rbind(Persons_withoutComputer_URBANISATION_Urban,
                                                          Persons_withoutComputer_URBANISATION_Urban_2022,
                                                          Persons_withoutComputer_URBANISATION_Urban_2021,
                                                          Persons_withoutComputer_URBANISATION_Urban_2020)


Persons_withoutComputer_URBANISATION_Urban_FINAL <- Persons_withoutComputer_URBANISATION_Urban_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutComputer_URBANISATION_Urban_FINAL <- Persons_withoutComputer_URBANISATION_Urban_FINAL %>%
  arrange(geo)


####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Persons_withoutComputer_URBANISATION_Rural_FINAL <- rbind(Persons_withoutComputer_URBANISATION_Rural,
                                                          Persons_withoutComputer_URBANISATION_Rural_2022,
                                                          Persons_withoutComputer_URBANISATION_Rural_2021,
                                                          Persons_withoutComputer_URBANISATION_Rural_2020)


Persons_withoutComputer_URBANISATION_Rural_FINAL <- Persons_withoutComputer_URBANISATION_Rural_FINAL %>% filter(!geo %in% c("RS", "CH"))
Persons_withoutComputer_URBANISATION_Rural_FINAL <- Persons_withoutComputer_URBANISATION_Rural_FINAL %>%
  arrange(geo)



rm(list = setdiff(ls(), ls(pattern = "_FINAL")))
