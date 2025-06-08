library(tidyverse)
library(sf)
library(sp)
source("merging_indices.R")

# Mapping data from merging_indices.R using shapefiles

### ENGLAND & WALES ###
lsoa_sf <- st_read("shapefiles/Lower_layer_Super_Output_Areas_Dec_2011_Boundaries_Full_Clipped_BFC_EW_V3_2022_1117503576712596763/LSOA_2011_EW_BFC_V3.shp") |>
  st_transform(crs = 4326) |>
  left_join(combined, by = c("LSOA11CD" = "lsoa11")) |>
  mutate(derived_imd_deciles = as.factor(derived_imd_deciles),
         derived_imd_quartiles = as.factor(derived_imd_quartiles))

### SCOTLAND ###
dz_sf <- st_read("shapefiles/SG_DataZoneBdry_2011/SG_DataZone_Bdry_2011.shp") |>
  st_transform(crs = 4326) |>
  left_join(combined, by = c("DataZone" = "lsoa11")) |>
  mutate(derived_imd_deciles = as.factor(derived_imd_deciles),
         derived_imd_quartiles = as.factor(derived_imd_quartiles))

### NORTHERN IRELAND ###
soa_sf <- st_read("shapefiles/SOA2011_Esri_Shapefile_0/SOA2011.shp") |>
  st_transform(crs = 4326) |>
  left_join(combined, by = c("SOA_CODE" = "lsoa11")) |>
  mutate(derived_imd_deciles = as.factor(derived_imd_deciles),
         derived_imd_quartiles = as.factor(derived_imd_quartiles))
  
create_imd_map <- function(shapefile, title) {
  
  ggplot(shapefile) +
    geom_sf(aes(fill = derived_imd_deciles)) +
    theme_void() +
    scale_fill_manual(name = "IMD Decile\n(1 = most deprived)",
                      breaks = 1:10,
                      values = c("#453B52", "#454F69", "#3F657E", "#317B8D", 
                                 "#239296", "#26A898", "#43BD93", "#6AD189", 
                                 "#98E37D", "#CAF270")) +
    labs(title = title)
  
}

# generate maps
lsoa_map <- create_imd_map(lsoa_sf, "England and Wales : IMD deciles")
dz_map <- create_imd_map(dz_sf, "Scotland: IMD deciles")
soa_map <- create_imd_map(soa_sf, "Northern Ireland: IMD deciles")

# London only
london <- lsoa_map +  
  coord_sf(ylim = c(51.25, 51.75), xlim = -c(-0.4, 0.65)) +
  labs(title = "London: IMD deciles")

# combined map
combined_sf <- bind_rows(dz_sf, lsoa_sf, soa_sf)
combined_map <- ggplot(combined_sf) +
  geom_sf(aes(fill = derived_imd_deciles)) +
  theme_void() +
  scale_fill_manual(name = "IMD Decile\n(1 = most deprived)",
                    breaks = 1:10,
                    values = c("#453B52", "#454F69", "#3F657E", "#317B8D", 
                               "#239296", "#26A898", "#43BD93", "#6AD189", 
                               "#98E37D", "#CAF270"))

# save at higher resolution
ggsave("lsoa_map.png", lsoa_map, width = 40, height = 48, dpi = 300)
ggsave("dz_map.png", dz_map, width = 20, height = 24, dpi = 300)
ggsave("soa_map.png", soa_map, width = 20, height = 24, dpi = 300)
ggsave("london.png", london, width = 20, height = 24, dpi = 300)
ggsave("combined.png", combined_map, width = 40, height = 48, dpi = 300)
