suppressMessages(library(tidyverse))

# CL tool to get IMD decile by postcode 
# Usage: Rscript cl_tools.R "postcode"
# Requires R to be installed and postcodes.csv available in same directory

postcodes <- read_csv("postcodes.csv",
                      show_col_types = F)

get_imd_data <- function(postcode) {
  
  # converts postcode to ONS-friendly version when needed
  align_postcodes <- function(postcode) {
    str_to_upper(
      case_when(
        str_length(postcode) == 8 ~ str_replace(postcode, " ", ""), #e.g. "CB10 1AA" to "CB101AA"
        str_length(postcode) == 7 ~ postcode, 
        str_length(postcode) == 6 & !str_detect(postcode, " ") ~
          str_c(str_sub(postcode, 1, -4), " ", str_sub(postcode, -3)), #e.g. "CB61AA" to "CB6 1AA"
        str_length(postcode) == 6 ~ str_replace(postcode, " ", "  "), #e.g. "M1 1AA" to "M1  1AA"
        str_length(postcode) == 5 ~ str_c(str_sub(postcode, 1, -4), "  ", 
                                          str_sub(postcode, -3)), #e.g. "M11AA" to "M1  1AA"
        TRUE ~ NA
      )
    )
  }
  
  data <- postcodes |>
    filter(pcd == align_postcodes(postcode))
  
  if (nrow(data) == 1) {
    paste0(data$lsoa_name, " IMD decile: ", data$derived_imd_deciles)
  } else {
    paste0("Not a valid postcode")
  }
}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  cat("How to use: Rscript imd_lookup.R <enter single postcode in quotes>\n")
  quit(status = 1)
}

result <- get_imd_data(args[1])
cat(result, "\n")