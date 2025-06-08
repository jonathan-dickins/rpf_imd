library(tidyverse)
library(readxl)

# Merging IMD data from England, Wales, Scotland, and NI

# ensure consistent column names
rename_cols <- function(data) {
  names(data)[1:3] <- c("lsoa11", "lsoa_name", "imd_rank")
  data
}

# calculate IMD quantiles flexibly from rank
create_ntiles <- function(data, tiles, new_col) {
  data |>
    mutate({{ new_col }} := ntile(imd_rank, tiles)) 
}

### ENGLAND ###
eng <- read_xlsx("data/File_1_-_IMD2019_Index_of_Multiple_Deprivation.xlsx", 
                sheet = 2) |>
  select(`LSOA code (2011)`,
         `LSOA name (2011)`,
         `Index of Multiple Deprivation (IMD) Rank`) |>
  mutate(country = "England") |>
  rename_cols() |>
  create_ntiles(tiles = 10, new_col = "derived_imd_deciles") |>
  create_ntiles(tiles = 4, new_col = "derived_imd_quartiles")

### WALES ###
wales <- read_xlsx("data/Postcode to WIMD Rank Lookup.xlsx", sheet = 3,
                   skip = 2) |>
  select(-`Welsh Postcode`) |>
  unique() |>
  select(`LSOA Code`, 
         `LSOA Name (English)`,
         `WIMD 2019 LSOA Rank`) |>
  mutate(country = "Wales") |>
  rename_cols() |>
  create_ntiles(tiles = 10, new_col = "derived_imd_deciles") |>
  create_ntiles(tiles = 4, new_col = "derived_imd_quartiles")

### SCOTLAND ###
# data zone names aren't in the IMD postcode data so need to be added in
scot_zone_name <- read_xlsx("data/SIMD+2020v2+-+datazone+lookup+-+updated+2025.xlsx",
                            sheet = 3) |>
  select(DZ, DZname)

scot <- read_xlsx("data/SIMD+2020v2+-+postcode+lookup+-+updated+2025.xlsx",
                  sheet = 2) |>
  select(-Postcode) |>
  unique() |>
  left_join(scot_zone_name, by = "DZ") |>
  select(DZ, 
         DZname,
         SIMD2020_Rank) |>
  mutate(country = "Scotland") |>
  rename_cols() |>
  create_ntiles(tiles = 10, new_col = "derived_imd_deciles") |>
  create_ntiles(tiles = 4, new_col = "derived_imd_quartiles")

### NI ###
ni <- read_xls("data/NIMDM17_SOAresults.xls", sheet = 2) |>
  select(SOA2001, 
         SOA2001_name,
         `Multiple Deprivation Measure Rank \n(where 1 is most deprived)`) |>
  mutate(country = "Northern Ireland") |>
  rename_cols() |>
  create_ntiles(tiles = 10, new_col = "derived_imd_deciles") |>
  create_ntiles(tiles = 4, new_col = "derived_imd_quartiles")

combined <- bind_rows(eng, scot, wales, ni) 

# joining newly calculated IMD data to postcode lookup
postcodes <- read_csv("data/ONSPD_MAY_2025_UK.csv") |>
  select(pcd, lsoa11) |>
  left_join(combined, by = "lsoa11")

write.csv(postcodes, "postcodes.csv", row.names = FALSE)
