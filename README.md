# RPF Indices of Multiple Deprivation task

- **Task 1:** Merging IMD datasets - `merging_indices.R`  
- **Task 2:** Visualise IMD data - `mapping.R`  
- **Task 3:** Command line postcode lookup tool - `cl_tool.R`  

See `approach_and_narrative.docx` for assumptions and limitations.

---

## Requirements

- To reproduce `merging_indices.R`:
  - R and required packages (listed in the file) must be installed.
  - Raw datasets are located in `/data`.

- To reproduce `mapping.R`:
  - Required packages must be installed.
  - Shapefiles must be placed in `/shapefiles`.

- To run the command line tool:
  - The location of the R executable (`Rscript.exe`) must be in your system `PATH`.
  - You must run the tool from the project directory.
  - `postcodes.csv` must be available in the project directory.

---

## Data sources

### IMD datasets

- **England:**  
  [IMD2019 Index of Multiple Deprivation](https://assets.publishing.service.gov.uk/media/5d8b3abded915d0373d3540f/File_1_-_IMD2019_Index_of_Multiple_Deprivation.xlsx)

- **Scotland:**  
  [Scottish Index of Multiple Deprivation 2020 Postcode Lookup](https://www.gov.scot/binaries/content/documents/govscot/publications/statistics/2020/01/scottish-index-of-multiple-deprivation-2020-postcode-look-up-file/documents/simd-2020-postcode-lookup-v5/simd-2020-postcode-lookup-v5/govscot%3Adocument/SIMD%2B2020v2%2B-%2Bpostcode%2Blookup%2B-%2Bupdated%2B2025.xlsx)
  [Scottish Index of Multiple Deprivation 2020 Datazone Lookup](https://www.gov.scot/binaries/content/documents/govscot/publications/statistics/2020/01/scottish-index-of-multiple-deprivation-2020-data-zone-look-up-file/documents/scottish-index-of-multiple-deprivation-data-zone-look-up/scottish-index-of-multiple-deprivation-data-zone-look-up/govscot%3Adocument/SIMD%2B2020v2%2B-%2Bdatazone%2Blookup%2B-%2Bupdated%2B2025.xlsx)

- **Wales:**  
  [Welsh Index of Multiple Deprivation](https://statswales.gov.wales/Catalogue/Community-Safety-and-Social-Inclusion/Welsh-Index-of-Multiple-Deprivation)  
  *(Select the Postcode to WIMD rank lookup and save as xlsx)*

- **Northern Ireland:**  
  [NIMDM17 SOA Results](https://www.nisra.gov.uk/files/nisra/publications/NIMDM17_SOAresults.xls)

### Postcode lookup

- [OND Postcode Directory with Scottish Data Zones](https://geoportal.statistics.gov.uk/datasets/3be72478d8454b59bb86ba97b4ee325b/about)

### Shapefiles

- **England and Wales:**  
  [ONS Lower Layer Super Output Areas December 2021 Boundaries (EW BSC V4.2)](https://geoportal.statistics.gov.uk/datasets/ons::lower-layer-super-output-areas-december-2021-boundaries-ew-bsc-v4-2/about)

- **Scotland:**  
  [Scottish Data Zone Boundaries 2011](https://maps.gov.scot/ATOM/shapefiles/SG_DataZoneBdry_2011.zip)

- **Northern Ireland:**  
  [SOA2011 Esri Shapefile](https://www.nisra.gov.uk/files/nisra/publications/SOA2011_Esri_Shapefile_0.zip)
