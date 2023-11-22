

# Functions and constants -------------------------------------------------

sq <- function(...) sQuote(paste0(...),FALSE) # single quote

dq <- function(...) dQuote(paste0(...),FALSE) # double quote

sanitizeForExcel <- function(dt)
  # Otherwise Excel reports a broken file
  dt[, lapply(.SD,
              \(col) if (is.character(col))
                stringi::stri_trans_general(col,"Latin-ASCII") else col)]

JAF_Compendium_Index_raw <-
  '
| CompendiumNum  | JAF_KEY                  |
|----------------|--------------------------|
| 1              | PA1.O1.                  |
| 1              | PA1.S1.M                 |
| 1              | PA1.S1.F                 |
| 1              | PA1.S2.                  |
| 1              | PA1.S3.                  |
| 1              | PA1.S4.                  |
| 1              | PA1.S5.                  |
| 1              | PA1.C1.                  |
| 1              | PA1.C2.15-64             |
| 1              | PA1.C2.15-19             |
| 1              | PA1.C2.15-24             |
| 1              | PA1.C2.50-59             |
| 1              | PA1.C2.60-64             |
| 1              | PA1.C2.65-69             |
| 1              | PA1.C2.15-64.M           |
| 1              | PA1.C2.15-19.M           |
| 1              | PA1.C2.15-24.M           |
| 1              | PA1.C2.50-59.M           |
| 1              | PA1.C2.60-64.M           |
| 1              | PA1.C2.M                 |
| 1              | PA1.C2.15-64.F           |
| 1              | PA1.C2.15-19.F           |
| 1              | PA1.C2.15-24.F           |
| 1              | PA1.C2.50-59.F           |
| 1              | PA1.C2.60-64.F           |
| 1              | PA1.C2.65-69.F           |
| 1              | PA1.C3.T                 |
| 1              | PA1.C3.15-64             |
| 1              | PA1.C3.15-19             |
| 1              | PA1.C3.15-24             |
| 1              | PA1.C3.50-59             |
| 1              | PA1.C3.60-64             |
| 1              | PA1.C3.65-69             |
| 1              | PA1.C3.15-64.M           |
| 1              | PA1.C3.15-19.M           |
| 1              | PA1.C3.15-24.M           |
| 1              | PA1.C3.50-59.M           |
| 1              | PA1.C3.60-64.M           |
| 1              | PA1.C3.65-69.M           |
| 1              | PA1.C3.15-64.F           |
| 1              | PA1.C3.15-19.F           |
| 1              | PA1.C3.15-24.F           |
| 1              | PA1.C3.50-59.F           |
| 1              | PA1.C3.60-64.F           |
| 1              | PA1.C3.65-69.F           |
| 1              | PA1.C3.NAT               |
| 1              | PA1.C3.EU27_2020         |
| 1              | PA1.C3.nonEU27_2020      |
| 1              | PA1.C3.low               |
| 1              | PA1.C3.med               |
| 1              | PA1.C3.high              |
| 1              | PA1.C4.T                 |
| 1              | PA1.C4.15-64             |
| 1              | PA1.C4.15-19             |
| 1              | PA1.C4.15-24             |
| 1              | PA1.C4.50-59             |
| 1              | PA1.C4.60-64             |
| 1              | PA1.C4.65-69             |
| 1              | PA1.C4.15-64.M           |
| 1              | PA1.C4.15-19.M           |
| 1              | PA1.C4.15-24.M           |
| 1              | PA1.C4.50-59.M           |
| 1              | PA1.C4.60-64.M           |
| 1              | PA1.C4.65-69.M           |
| 1              | PA1.C4.15-64.F           |
| 1              | PA1.C4.15-19.F           |
| 1              | PA1.C4.15-24.F           |
| 1              | PA1.C4.50-59.F           |
| 1              | PA1.C4.60-64.F           |
| 1              | PA1.C4.65-69.F           |
| 1              | PA1.C4.NAT               |
| 1              | PA1.C4.EU27_2020         |
| 1              | PA1.C4.nonEU27_2020      |
| 1              | PA1.C4.low               |
| 1              | PA1.C4.med               |
| 1              | PA1.C4.high              |
| 2              | PA1b.O1.                 |
| 2              | PA1b.O1.n.               |
| 2              | PA1b.S1.M                |
| 2              | PA1b.S1.F                |
| 2              | PA1b.S2.                 |
| 2              | PA1b.S3.                 |
| 2              | PA1b.S4.                 |
| 2              | PA1b.S5.                 |
| 2              | PA1b.S6.                 |
| 2              | PA1b.S1.n.M              |
| 2              | PA1b.S1.n.F              |
| 2              | PA1b.S5.n.               |
| 2              | PA1b.S6.n.               |
| 2              | PA1b.C1.Y15-19.T         |
| 2              | PA1b.C1.Y15-19.M         |
| 2              | PA1b.C1.Y15-19.F         |
| 2              | PA1b.C1.Y20-24.T         |
| 2              | PA1b.C1.Y20-24.M         |
| 2              | PA1b.C1.Y20-24.F         |
| 2              | PA1b.C1.Y25-29.T         |
| 2              | PA1b.C1.Y25-29.M         |
| 2              | PA1b.C1.Y25-29.F         |
| 2              | PA1b.C2.low.T            |
| 2              | PA1b.C2.low.M            |
| 2              | PA1b.C2.low.F            |
| 2              | PA1b.C2.med-high.T       |
| 2              | PA1b.C2.med-high.M       |
| 2              | PA1b.C2.med-high.F       |
| 2              | PA1b.C3.une.M            |
| 2              | PA1b.C3.une.F            |
| 2              | PA1b.C3.n.une.M          |
| 2              | PA1b.C3.n.une.F          |
| 2              | PA1b.C3.n.inac.M         |
| 2              | PA1b.C3.n.inac.F         |
| 2              | PA1b.C3.inac.M           |
| 2              | PA1b.C3.inac.F           |
| 2              | PA1b.C4.M                |
| 2              | PA1b.C4.F                |
| 2              | PA1b.C5.M                |
| 2              | PA1b.C5.F                |
| 2              | PA1b.C6.15-24.T          |
| 2              | PA1c.O1.                 |
| 2              | PA1c.S1.Y55_59           |
| 2              | PA1c.S1.Y60-64           |
| 2              | PA1c.S1.M                |
| 2              | PA1c.S1.F                |
| 2              | PA1c.S2.T                |
| 2              | PA1c.S2.M                |
| 2              | PA1c.S2.F                |
| 2              | PA1c.S3.                 |
| 2              | PA1c.S4.                 |
| 2              | PA1c.S5.                 |
| 2              | PA1c.C1.55-74            |
| 2              | PA1c.C2.EMP.W            |
| 2              | PA1c.C2.EMP.M            |
| 2              | PA1c.C3.T                |
| 2              | PA1c.C4.M                |
| 2              | PA1c.C4.F                |
| 2              | PA1c.C5.T                |
| 2              | PA1c.C5.M                |
| 2              | PA1c.C5.F                |
| 2              | PA1c.C6.good             |
| 2              | PA1c.C7.high             |
| 2              | PA1c.C7.med              |
| 2              | PA1c.C7.low              |
| 2              | PA1c.C8.T                |
| 2              | PA1c.C9.M.55-59          |
| 2              | PA1c.C9.F.55-59          |
| 2              | PA1c.C9.M.60-64          |
| 2              | PA1c.C9.F.60-64          |
| 2              | PA1c.C10.T               |
| 2              | PA1c.C10.M               |
| 2              | PA1c.C10.F               |
| 2              | PA1c.C11.T               |
| 2              | PA1c.C12.T               |
| 2              | PA1c.C12.M               |
| 2              | PA1c.C12.F               |
| 2              | PA1c.C13.T               |
| 2              | PA1c.C14.T               |
| 2              | PA1c.C14.M               |
| 2              | PA1c.C14.F               |
| 2              | PA1d.O1.                 |
| 2              | PA1d.S1.M                |
| 2              | PA1d.S1.F                |
| 2              | PA1d.S2.T                |
| 2              | PA1d.S2.M                |
| 2              | PA1d.S2.F                |
| 2              | PA1d.C1.T                |
| 2              | PA1d.C1.M                |
| 2              | PA1d.C1.F                |
| 2              | PA1d.C2.T                |
| 2              | PA1d.C2.M                |
| 2              | PA1d.C2.F                |
| 2              | PA1d.C3.T                |
| 2              | PA1d.C3.M                |
| 2              | PA1d.C3.F                |
| 2              | PA1d.C4.T                |
| 2              | PA1d.C4.M                |
| 2              | PA1d.C4.F                |
| 2              | PA1d.C5.T                |
| 2              | PA1d.C5.M                |
| 2              | PA1d.C5.F                |
| 2              | PA1d.C6.T                |
| 2              | PA1d.C6.M                |
| 2              | PA1d.C6.F                |
| 3              | PA2a.O1.                 |
| 3              | PA2a.S1.Y15-24           |
| 3              | PA2a.S1.Y25-54           |
| 3              | PA2a.S1.Y55-64           |
| 3              | PA2a.S2.M                |
| 3              | PA2a.S2.F                |
| 3              | PA2a.S3.                 |
| 3              | PA2a.S4.                 |
| 3              | PA2a.S5.                 |
| 3              | PA2a.S6.T                |
| 3              | PA2a.S6.Y15-24           |
| 3              | PA2a.S6.M                |
| 3              | PA2a.S6.F                |
| 3              | PA2a.C1.temp             |
| 3              | PA2a.C2.REG              |
| 3              | PA2a.C3.TEMP             |
| 3              | PA2a.C4.T                |
| 3              | PA2a.C4.M                |
| 3              | PA2a.C4.F                |
| 3              | PA2a.C5.T                |
| 3              | PA2a.C5.M                |
| 3              | PA2a.C5.F                |
| 3              | PA2b.O1.                 |
| 3              | PA2b.S1.                 |
| 3              | PA2b.S2.                 |
| 3              | PA2b.S3.                 |
| 3              | PA2b.S4.Y15_64           |
| 3              | PA2b.S4.Y15_24           |
| 3              | PA2b.S4.Y25_54           |
| 3              | PA2b.S4.Y55_64           |
| 3              | PA2b.S5.                 |
| 3              | PA2b.S6.                 |
| 3              | PA2b.S7.                 |
| 3              | PA2b.S8.                 |
| 3              | PA2b.C1.TEMP             |
| 3              | PA2b.C1.REG              |
| 3              | PA2b.C2.ch               |
| 4              | PA3.O1.                  |
| 4              | PA3.S1.                  |
| 4              | PA3.S2.                  |
| 4              | PA3.S3.                  |
| 4              | PA3.S4.                  |
| 4              | PA3.S5.                  |
| 4              | PA3.C1.                  |
| 4              | PA3.C4.                  |
| 4              | PA3.C6.                  |
| 4              | PA3.C7.2                 |
| 4              | PA3.C7.4                 |
| 4              | PA3.C7.5                 |
| 4              | PA3.C7.6                 |
| 4              | PA3.C7.7                 |
| 4              | PA4.1.O1.                |
| 4              | PA4.1.S1.                |
| 4              | PA4.1.S2.A1              |
| 4              | PA4.1.S2.A1_2DCH         |
| 4              | PA4.1.S2.A2              |
| 4              | PA4.1.S2.A2_2DCH         |
| 4              | PA4.1.S3.A1              |
| 4              | PA4.1.S3.A1_2DCH         |
| 4              | PA4.1.S3.A2              |
| 4              | PA4.1.S3.A2_2DCH         |
| 4              | PA4.1.C2.                |
| 4              | PA4.1.C3.                |
| 4              | PA4.1.C4.                |
| 4              | PA4.2.O1.                |
| 4              | PA4.2.S1.                |
| 4              | PA4.2.S2.                |
| 4              | PA4.2.S3.T               |
| 4              | PA4.2.S4.                |
| 4              | PA4.2.S5.                |
| 5              | PA5.O1.                  |
| 5              | PA5.S1.INAC              |
| 5              | PA5.S1.PT                |
| 5              | PA5.S1.M                 |
| 5              | PA5.S1.F                 |
| 5              | PA5.S2.                  |
| 5              | PA5.S3.T                 |
| 5              | PA5.S3.<30               |
| 5              | PA5.S3.>30               |
| 5              | PA5.S4.T                 |
| 5              | PA5.S4.<30               |
| 5              | PA5.S4.>30               |
| 5              | PA5.S5.                  |
| 5              | PA5.S6.                  |
| 5              | PA5.C1.M                 |
| 5              | PA5.C1.F                 |
| 5              | PA5.C2.M                 |
| 5              | PA5.C2.F                 |
| 5              | PA5.C3.M                 |
| 5              | PA5.C3.F                 |
| 5              | PA6a.O1.                 |
| 5              | PA6a.S1.M                |
| 5              | PA6a.S1.F                |
| 5              | PA6a.S2.AGRI             |
| 5              | PA6a.S2.IND              |
| 5              | PA6a.S2.CONSTR           |
| 5              | PA6a.S2.SERV             |
| 5              | PA6a.S3.                 |
| 5              | PA6a.S4.                 |
| 5              | PA6a.S5.                 |
| 5              | PA6a.S6.                 |
| 5              | PA6a.C1.SH.AGRI          |
| 5              | PA6a.C1.SH.IND           |
| 5              | PA6a.C1.SH.CONSTR        |
| 5              | PA6a.C1.SH.G_I           |
| 5              | PA6a.C1.SH.J_L           |
| 5              | PA6a.C1.SH.M_N           |
| 5              | PA6a.C1.SH.O-Q           |
| 5              | PA6a.C1.SH.R_U           |
| 5              | PA6a.C2.15-64            |
| 5              | PA6a.C2.15-24            |
| 5              | PA6a.C2.25-54            |
| 5              | PA6a.C2.55-64            |
| 5              | PA6a.C4.                 |
| 5              | PA6a.C5.                 |
| 5              | PA6b.O1.                 |
| 5              | PA6b.S1.                 |
| 5              | PA6b.S2.                 |
| 5              | PA6b.S4.                 |
| 5              | PA6b.C2.                 |
| 6              | PA7.1.O1.                |
| 6              | PA7.1.S1.Y20-29          |
| 6              | PA7.1.S1.Y30-54          |
| 6              | PA7.1.S1.Y55-64          |
| 6              | PA7.1.S2.F               |
| 6              | PA7.1.S3.M               |
| 6              | PA7.1.S3.F               |
| 6              | PA7.1.S4.                |
| 6              | PA7.1.S5.                |
| 6              | PA7.1.S6.                |
| 6              | PA7.1.C1.                |
| 6              | PA7.1.C2.                |
| 6              | PA7.1.C4.                |
| 6              | PA7.1.C5.                |
| 6              | PA7.1.C6.                |
| 6              | PA7.2.O1.                |
| 6              | PA7.2.S1.M               |
| 6              | PA7.2.S1.F               |
| 6              | PA7.2.S2.M               |
| 6              | PA7.2.S2.F               |
| 6              | PA7.2.S3.                |
| 6              | PA7.2.S4.                |
| 6              | PA7.2.C1.                |
| 6              | PA7.2.C3.                |
| 6              | PA7.2.C4.                |
| 7              | PA8.1.O1.                |
| 7              | PA8.1.S1.MED             |
| 7              | PA8.1.S1.HIGH            |
| 7              | PA8.1.S2.                |
| 7              | PA8.1.S3.                |
| 7              | PA8.1.S4.                |
| 7              | PA8.1.S5.                |
| 7              | PA8.1.S6.                |
| 7              | PA8.1.C1.M               |
| 7              | PA8.1.C1.F               |
| 7              | PA8.1.C1.Y25-34          |
| 7              | PA8.1.C1.Y35-44          |
| 7              | PA8.1.C4.                |
| 7              | PA8.1.C5.                |
| 7              | PA8.2.O1.                |
| 7              | PA8.2.S1.                |
| 7              | PA8.2.S2.                |
| 7              | PA8.2.S3.                |
| 7              | PA8.2.S4.                |
| 7              | PA8.2.S5.                |
| 7              | PA8.2.C1.Y25-64.M        |
| 7              | PA8.2.C1.Y25_64.T        |
| 7              | PA8.2.C1.Y25-34.T        |
| 7              | PA8.2.C1.Y25-34.M        |
| 7              | PA8.2.C1.Y25-34.F        |
| 7              | PA8.2.C1.Y35-44.T        |
| 7              | PA8.2.C1.Y35-44.M        |
| 7              | PA8.2.C1.Y35-44.F        |
| 7              | PA8.2.C1.Y45-54.T        |
| 7              | PA8.2.C1.Y45-54.M        |
| 7              | PA8.2.C1.Y45-54.F        |
| 7              | PA8.2.C1.Y55-64.T        |
| 7              | PA8.2.C1.Y55-64.M        |
| 7              | PA8.2.C1.Y55-64.F        |
| 7              | PA9.1.O1.                |
| 7              | PA9.1.S1.                |
| 7              | PA9.1.S2.n.              |
| 7              | PA9.1.S2.                |
| 7              | PA9.1.S3.                |
| 7              | PA9.1.S4.                |
| 7              | PA9.1.S5.                |
| 7              | PA9.1.S6.                |
| 7              | PA9.1.C1.M               |
| 7              | PA9.1.C1.F               |
| 7              | PA9.1.C1.NAT             |
| 7              | PA9.1.C1.EU27_2020       |
| 7              | PA9.1.C1.NONEU27_2020    |
| 7              | PA9.1.C1.SAME            |
| 7              | PA9.1.C1.OTHEREU27_2020  |
| 7              | PA9.1.C1.OUTEU27_2020    |
| 7              | PA9.1.C2.n.NEET.M        |
| 7              | PA9.1.C2.n.NEET.F        |
| 7              | PA9.1.C2.NEET.M          |
| 7              | PA9.1.C2.NEET.F          |
| 7              | PA9.1.C3.M               |
| 7              | PA9.1.C3.F               |
| 7              | PA9.1.C4.M               |
| 7              | PA9.1.C4.F               |
| 7              | PA9.2.O1.                |
| 7              | PA9.2.S1.READ            |
| 7              | PA9.2.S1.MATH            |
| 7              | PA9.2.S1.SCIE            |
| 7              | PA9.2.S2.                |
| 7              | PA9.2.S3.                |
| 7              | PA9.2.S4.                |
| 7              | PA9.2.S5.                |
| 7              | PA9.2.C1.HIGH.M          |
| 7              | PA9.2.C1.HIGH.F          |
| 7              | PA9.2.C1.NAT             |
| 7              | PA9.2.C1.EU27_2020       |
| 7              | PA9.2.C1.NONEU27_2020    |
| 7              | PA9.2.C1.SAME            |
| 7              | PA9.2.C1.OTHEREU27_2020  |
| 7              | PA9.2.C1.OUTEU27_2020    |
| 7              | PA9.2.C2.M               |
| 7              | PA9.2.C2.F               |
| 7              | PA9.2.C3.M               |
| 7              | PA9.2.C3.F               |
| 7              | PA9.2.C4.                |
| 7              | PA10.O1.                 |
| 7              | PA10.S1.                 |
| 7              | PA10.S2.                 |
| 7              | PA10.C1.                 |
| 7              | PA10.C2.                 |
| 8              | PA11.O1.                 |
| 8              | PA11.S1.                 |
| 8              | PA11.S2.                 |
| 8              | PA11.S3.T                |
| 8              | PA11.S3.M                |
| 8              | PA11.S3.F                |
| 8              | PA11.S4.                 |
| 8              | PA11.S5.                 |
| 8              | PA11.S6.                 |
| 8              | PA11.S8.                 |
| 8              | PA11.S9.                 |
| 8              | PA11.S10.                |
| 8              | PA11.S11.                |
| 8              | PA11.S12.                |
| 8              | PA11.S13.                |
| 8              | PA11.S14.                |
| 8              | PA11.S15.                |
| 8              | PA11.C1.                 |
| 8              | PA11.C2.                 |
| 8              | PA11.C3.n.M              |
| 8              | PA11.C3.n.F              |
| 8              | PA11.C4.T                |
| 8              | PA11.C4.M                |
| 8              | PA11.C4.F                |
| 8              | PA11.C5.T                |
| 8              | PA11.C5.1                |
| 8              | PA11.C5.2                |
| 8              | PA11.C5.3                |
| 8              | PA11.C5.4                |
| 8              | PA11.C5.5                |
| 8              | PA11.C5.6                |
| 8              | PA11.C5.7                |
| 8              | PA11.C5.8                |
| 8              | PA11.C5.9                |
| 8              | PA11.C5.10               |
| 8              | PA11.C5.11               |
| 8              | PA11.C6.                 |
| 8              | PA11.C7.                 |
| 8              | PA11.C8.M                |
| 8              | PA11.C8.F                |
| 8              | PA11.C9.M                |
| 8              | PA11.C9.F                |
| 8              | PA11.C11.T               |
| 8              | PA11.C11.Q1              |
| 8              | PA11.C11.Q2              |
| 8              | PA11.C11.Q3              |
| 8              | PA11.C11.Q4              |
| 8              | PA11.C11.Q5              |
| 8              | PA11.C12.                |
| 9              | PA11a.O1.                |
| 9              | PA11a.S1.                |
| 9              | PA11a.S2.                |
| 9              | PA11a.S3.                |
| 9              | PA11a.S4.                |
| 9              | PA11a.S5.                |
| 9              | PA11a.S6.                |
| 9              | PA11a.S7.                |
| 9              | PA11a.S8.                |
| 9              | PA11a.S9.                |
| 9              | PA11a.S10.               |
| 9              | PA11a.C1.ATWORK          |
| 9              | PA11a.C1.NOTWORK         |
| 9              | PA11a.C2.1               |
| 9              | PA11a.C2.2               |
| 9              | PA11a.C2.3               |
| 9              | PA11a.C2.4               |
| 9              | PA11a.C2.5               |
| 9              | PA11a.C2.6               |
| 9              | PA11a.C3.                |
| 9              | PA11a.C4.                |
| 9              | PA11b.O1.                |
| 9              | PA11b.S1.T               |
| 9              | PA11b.S1.M               |
| 9              | PA11b.S1.F               |
| 9              | PA11b.S2.                |
| 9              | PA11b.S3.                |
| 9              | PA11b.S4.                |
| 9              | PA11b.S5.T               |
| 9              | PA11b.S5.M               |
| 9              | PA11b.S5.F               |
| 9              | PA11b.S6.                |
| 9              | PA11b.S7.                |
| 9              | PA11b.S8.                |
| 9              | PA11b.S9.                |
| 9              | PA11b.S10.               |
| 9              | PA11b.S11.               |
| 9              | PA11b.S12.               |
| 9              | PA11b.C4.                |
| 9              | PA11b.C5.UNE             |
| 9              | PA11b.C5.INAC            |
| 9              | PA11b.C6.T               |
| 9              | PA11b.C6.Q1              |
| 9              | PA11b.C6.Q2              |
| 9              | PA11b.C6.Q3              |
| 9              | PA11b.C6.Q4              |
| 9              | PA11b.C6.Q5              |
| 9              | PA11c.O1.                |
| 9              | PA11c.S1.T               |
| 9              | PA11c.S1.M               |
| 9              | PA11c.S1.F               |
| 9              | PA11c.S2.T               |
| 9              | PA11c.S2.M               |
| 9              | PA11c.S2.F               |
| 9              | PA11c.S3.                |
| 9              | PA11c.S4.                |
| 9              | PA11c.S5.                |
| 9              | PA11c.S6.                |
| 9              | PA11c.S7.                |
| 9              | PA11c.S8.                |
| 9              | PA11c.C1.                |
| 9              | PA11c.C2.                |
| 9              | PA11c.C6.M               |
| 9              | PA11c.C6.F               |
| 9              | PA11c.C7.                |
' %>% 
  readMarkDownTable() %>% 
  .[, CompendiumNum := as.integer(CompendiumNum)] %>% 
  .[, JAF_KEY := JAF_KEY %>% sub('^(PA11\\.C3)\\.n(\\..)$','\\1\\2',.)] # remove n from PA11.C3.n.M and PA11.C3.n.F

JAF_Compendium_Index <-
  JAF_Compendium_Index_raw %>% 
  merge(JAF_NAMES_DESCRIPTIONS, by='JAF_KEY') %>% 
  .[, `Policy Area` := sub("^([^\\.]+)\\..*$", "\\1", JAF_KEY)] %>% 
  .[, Indicator := name] %>% 
  .[, name := NULL] %>% 
  .[, Compendium := 
      paste0("=HYPERLINK(",
             dq("[Compendium-",CompendiumNum,".xlsx]",sq(JAF_KEY),"!A1"),
             ",",
             dq("Compendium - ",CompendiumNum),
             ")")] %>% 
  .[, c('CompendiumNum','unit') := NULL] %>% 
  sanitizeForExcel()

indicTablesForCompendium <- function(JAF_KEY.) {
  selected_dt <-
    JAF_GRAND_TABLE[JAF_KEY==JAF_KEY. & !is.na(value_)] %>% 
    .[, time := as.integer(time)] %>% 
    .[time >= 2000] %>% 
    .[, geo := as.character(geo)]
  col_order <-
    sort(unique(selected_dt$time)) %>% 
    expand.grid(c('value_','flags_'),.) %>% 
    do.call(paste0,.)
  selected_dt %>% 
    dcast(geo ~ time,
          fun.aggregate=identity,
          fill=NA, sep="",
          value.var=c('value_','flags_')) %>% 
    .[, ord. := nchar(geo)] %>% 
    setorder(ord.,geo) %>% 
    .[, ord. := NULL] %>% 
    setcolorder(c('geo',col_order)) %>% 
    list(with_flags = .,
         without_flags =
           .[, !grepl('^flags_',colnames(.)), with=FALSE]) %>% 
    lapply(\(dt) dt %>% 
             # sanitizeForExcel() %>% 
             setnames(colnames(.),
                      colnames(.) %>% sub('^(geo|value_|flags_.+)',"",.)))
}

line_chart_template.xml <-
  readLines("line_chart_template.xml",warn=FALSE) %>% 
  paste(collapse="")

bar_chart_template.xml <-
  readLines("bar_chart_template.xml",warn=FALSE) %>% 
  paste(collapse="")

seriesForLineChartXml <- function(number_of_series) {
  templ <-
    r"(<c:ser>
  <c:idx val="0"/>
  <c:order val="0"/>
  <c:tx>
  <c:strRef>
  <c:f>'PA1.C4.high'!$AY$12</c:f>
  </c:strRef>
  </c:tx>
  <c:spPr>
  <a:ln w="28575" cap="rnd">
  <a:solidFill>
  <a:schemeClr val="accent1"/>
  </a:solidFill>
  <a:round/>
  </a:ln>
  <a:effectLst/>
  </c:spPr>
  <c:marker>
  <c:symbol val="none"/>
  </c:marker>
  <c:cat>
  <c:strRef>
  <c:f>'PA1.C4.high'!$AZ$11:$BV$11</c:f>
  </c:strRef>
  </c:cat>
  <c:val>
  <c:numRef>
  <c:f>'PA1.C4.high'!$AZ$12:$BV$12</c:f>
  </c:numRef>
  </c:val>
  <c:smooth val="0"/>
  <c:extLst>
  <c:ext uri="{C3380CC4-5D6E-409C-BE32-E72D297353CC}" xmlns:c16="http://schemas.microsoft.com/office/drawing/2014/chart">
  <c16:uniqueId val="{00000000-1349-4E51-A7E7-2039255F042E}"/>
  </c:ext>
  </c:extLst>
  </c:ser>)"
  seq.int(0,number_of_series-1) %>% 
    sapply(\(num) templ %>% 
             kit::nif(num>=6,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="60000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=12,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="80000"/><a:lumOff val="20000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=18,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="80000"/></a:schemeClr>',.,fixed=TRUE),
                      num>=24,
                      gsub('<a:schemeClr val="accent1"/>',
                           '<a:schemeClr val="accent1"><a:lumMod val="60000"/><a:lumOff val="40000"/></a:schemeClr>',.,fixed=TRUE),
                      default=.) %>% 
             sub('val="{00000000',paste0('val="{',sprintf("%08X",num)),.,fixed=TRUE) %>% 
             sub('<c:idx val="0"/>',paste0('<c:idx val="',num,'"/>'),.,fixed=TRUE) %>% 
             sub('<c:order val="0"/>',paste0('<c:order val="',num,'"/>'),.,fixed=TRUE) %>% 
             sub('val="accent1"',paste0('val="accent',num%%6 + 1,'"'),.,fixed=TRUE) %>% 
             gsub('$12',paste0('$',num+12),.,fixed=TRUE)) %>% 
    paste(collapse="")
}

lineChartXml <- function(JAF_KEY.,
                         num_of_cols_with_flags, num_of_cols_without_flags,
                         num_of_rows)
  line_chart_template.xml %>% 
  sub('<!-- ###### Generated series to be pasted here ###### -->',
      seriesForLineChartXml(num_of_rows),.,fixed=TRUE) %>% 
  gsub('PA1.C4.high',escapeSpecialXmlChars(JAF_KEY.),.,fixed=TRUE) %>% 
  gsub("'!$AY",paste0("'!$",int2col(num_of_cols_with_flags+4)),.,fixed=TRUE) %>% 
  gsub("'!$AZ",paste0("'!$",int2col(num_of_cols_with_flags+5)),.,fixed=TRUE) %>% 
  gsub(":$BV$",paste0(":$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE) %>% 
  gsub(":$BV$",paste0(":$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE)

barChartXml <- function(JAF_KEY.,
                        num_of_cols_with_flags, num_of_cols_without_flags,
                        num_of_rows,
                        n_years_before=5)
  bar_chart_template.xml %>% 
  gsub('PA1.C4.high',escapeSpecialXmlChars(JAF_KEY.),.,fixed=TRUE) %>% 
  gsub("$AY$",paste0("$",int2col(num_of_cols_with_flags+4),'$'),.,fixed=TRUE) %>% 
  gsub("$BQ$",paste0("$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags-n_years_before),"$"),.,fixed=TRUE) %>% 
  gsub("$BV$",paste0("$",int2col(num_of_cols_with_flags+3+num_of_cols_without_flags),"$"),.,fixed=TRUE) %>% 
  gsub('$40<',paste0('$',num_of_rows+11,'<'),.,fixed=TRUE)

escapeSpecialXmlChars <- function(charvec)
  charvec %>% 
  sub('"','&quot;',.,fixed=TRUE) %>% 
  sub("'",'&apos;',.,fixed=TRUE) %>% 
  sub('<','&lt;',.,fixed=TRUE) %>% 
  sub('>','&gt;',.,fixed=TRUE) %>% 
  sub('&','&amp;',.,fixed=TRUE)


# Actions -----------------------------------------------------------------

message('\nCreating Compendium files...')

createFolder(paste0(OUTPUT_FOLDER,'/JAF Compendium'))

message('Creating Index.xlsx...')
openxlsx2::wb_workbook() %>%
  wb_add_worksheet('Index') %>%
  wb_add_data(dims='C1',
              x='Index Compendium') %>%
  wb_add_font(dims='C1',
              bold="bold",
              size=18) %>%
  wb_add_data(startRow=2,
              x=JAF_Compendium_Index %>%
                .[, colnames(.) %without% 'Compendium', with=FALSE]) %>%
  wb_add_formula(x=JAF_Compendium_Index$Compendium,
                 startCol=ncol(JAF_Compendium_Index),
                 startRow=3) %>%
  wb_add_data(x='Link to the file and worksheet',
              startCol=ncol(JAF_Compendium_Index),
              startRow=2) %>%
  wb_freeze_pane(firstActiveRow=3) %>%
  wb_add_font(dims=paste0('A2:',int2col(ncol(JAF_Compendium_Index)),'2'),
              bold="bold",
              size=12) %>%
  wb_set_col_widths(cols=seq_along(JAF_Compendium_Index),
                    widths="auto") %>%
  wb_set_col_widths(cols=3,
                    widths=70) %>%
  {for (ws in .$worksheets)
    ws$sheetViews <- set_zoom(75, ws$sheetViews); .} %>%
  wb_save(paste0(OUTPUT_FOLDER,'/JAF Compendium/Index.xlsx'))

message('Done.')

for (CompendiumNum. in unique(JAF_Compendium_Index_raw$CompendiumNum)) {
  message('\nCreating Compendium-',CompendiumNum.,'.xlsx...')
  wb <-
    openxlsx2::wb_workbook()
  for (JAF_KEY. in
       JAF_Compendium_Index_raw[CompendiumNum==CompendiumNum., JAF_KEY] %>%
       intersect(unique(JAF_GRAND_TABLE$JAF_KEY))) { # to make sure that the indicator is in the JAF_GRAND_TABLE
    cat(JAF_KEY.," ")
    PA <-
      JAF_Compendium_Index[JAF_KEY==JAF_KEY., `Policy Area`]
    list_of_dts <-
      indicTablesForCompendium(JAF_KEY.)
    wb <-
      wb %>%
      wb_add_worksheet(JAF_KEY.) %>%
      wb_add_formula(JAF_KEY.,
                     r"{=HYPERLINK("[Index.xlsx]'Index'!A1","Back to index")}") %>%
      wb_add_data(JAF_KEY.,
                  PA,
                  dims='A3') %>%
      wb_add_data(JAF_KEY.,
                  PolicyAreaLabels[paste0('PA',PolicyArea)==PA, `POLICY AREA`],
                  dim='B3') %>%
      wb_add_data(JAF_KEY.,
                  JAF_INDICATORS[[JAF_KEY.]]$name %>% stringi::stri_trans_general("Latin-ASCII"),
                  dim='B5') %>%
      wb_add_data(JAF_KEY.,
                  JAF_INDICATORS[[JAF_KEY.]]$unit %>% stringi::stri_trans_general("Latin-ASCII"),
                  dim='B6') %>%
      wb_add_data(JAF_KEY.,
                  paste('Source: ',JAF_INDICATORS[[JAF_KEY.]]$source %>% stringi::stri_trans_general("Latin-ASCII")),
                  dim='B7') %>%
      wb_add_data(JAF_KEY.,
                  'Table with flags',
                  startCol=3, startRow=10) %>%
      wb_add_data(JAF_KEY.,
                  list_of_dts$with_flags,
                  startCol=2, startRow=11) %>%
      wb_add_data(JAF_KEY.,
                  'Table without flags',
                  startCol=5+ncol(list_of_dts$with_flags), startRow=10) %>%
      wb_add_data(JAF_KEY.,
                  list_of_dts$without_flags,
                  startCol=4+ncol(list_of_dts$with_flags), startRow=11) %>%
      wb_add_filter(JAF_KEY., rows=11, cols=2) %>%
      wb_add_data(JAF_KEY.,
                  'Use the filter in cell B11 to see only one or more selected coutries in the charts below.',
                  startCol=3, startRow=42+nrow(list_of_dts$with_flags)-29) %>%
      wb_add_chart_xml(JAF_KEY.,
                       dims=paste0('C',
                                   44+nrow(list_of_dts$with_flags)-29),
                       lineChartXml(JAF_KEY.,ncol(list_of_dts$with_flags),ncol(list_of_dts$without_flags),
                                    nrow(list_of_dts$with_flags))) %>%
      wb_add_chart_xml(JAF_KEY.,
                       dims=paste0('C',
                                   78+nrow(list_of_dts$with_flags)-29),
                       barChartXml(JAF_KEY.,ncol(list_of_dts$with_flags),ncol(list_of_dts$without_flags),
                                   nrow(list_of_dts$with_flags))) %>%
      {suppressWarnings(wb_add_font(.,JAF_KEY.,
                                    dims=c('A3','B3','B5','B6','C42'), # a vector generates a warning
                                    bold="bold",
                                    size=13))} %>%
      wb_set_col_widths(JAF_KEY.,
                        cols=2,
                        widths="auto") %>%
      wb_add_fill(JAF_KEY.,
                  every_nth_row = 2,
                  dims = paste0("B12:",
                                int2col(ncol(list_of_dts$with_flags)+1),
                                12+nrow(list_of_dts$with_flags)),
                  color = wb_color(hex = "f2f2f2")) %>%
      wb_add_fill(JAF_KEY.,
                  every_nth_row = 2,
                  dims = paste0(int2col(ncol(list_of_dts$with_flags)+4),"12:",
                                int2col(ncol(list_of_dts$without_flags)+ncol(list_of_dts$with_flags)+3),
                                12+nrow(list_of_dts$without_flags)),
                  color = wb_color(hex = "e6f1ff")) %>%
      wb_freeze_pane(JAF_KEY., firstActiveCol=3, firstActiveRow=10) %>%
      wb_set_row_heights(JAF_KEY.,
                         rows=c(2,4,8,9),
                         heights=3)

  }
  for (ws in wb$worksheets)
    ws$sheetViews <- set_zoom(65, ws$sheetViews)
  wb %>%
    wb_set_sheet_names(wb_get_sheet_names(.),
                       wb_get_sheet_names(.) %>% escapeSpecialXmlChars()) %>%
    wb_save(paste0(OUTPUT_FOLDER,
                   '/JAF Compendium/Compendium-',CompendiumNum.,'.xlsx'))
  message('\nCompendium-',CompendiumNum.,'.xlsx saved.')
}
