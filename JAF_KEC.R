library(magrittr)
library(data.table)
library(openxlsx2)


# Functions and constants -------------------------------------------------

PolicyAreaLabels <-
  '
| PolicyArea  | POLICY AREA                                                                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| 1           | Increase labour market participation                                                                                                            |
| 1b          | Increase labour market participation                                                                                                            |
| 1b          | Increase labour market participation                                                                                                            |
| 1c          | Increase labour market participation                                                                                                            |
| 1d          | Increase labour market participation                                                                                                            |
| 2a          | Enhancing labour market functioning                                                                                                             |
| 2b          | Enhancing labour market functioning                                                                                                             |
| 3           | Active labour market policies                                                                                                                   |
| 4.1         | Adequate and employment oriented social security systems                                                                                        |
| 4.2         | Adequate and employment oriented social security systems                                                                                        |
| 5           | Work-life balance                                                                                                                               |
| 6a          | Exploiting job creation possibilities                                                                                                           |
| 6b          | Exploiting job creation possibilities                                                                                                           |
| 7.1         | Gender equality                                                                                                                                 |
| 7.2         | Gender equality                                                                                                                                 |
| 8.1         | Improving skills supply and productivity, effective life-long learning                                                                          |
| 8.2         | Improving skills supply and productivity, effective life-long learning                                                                          |
| 9.1         | Improving education and training systems                                                                                                        |
| 9.2         | Improving education and training systems                                                                                                        |
| 10          | Wage setting mechanisms and labour cost developments                                                                                            |
| 11          | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11a         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11b         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
| 11c         | Preventing poverty and social exclusion through inclusive labour markets, adequate and sustainable social protection and high quality services  |
' %>% 
  readMarkDownTable()