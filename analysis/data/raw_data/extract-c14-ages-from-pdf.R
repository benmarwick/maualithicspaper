
# this script reads in the PDF and extracts a data frame of the
# dating results, ready for further analysis

library(tidyverse)
library(tabulizer) # remotes::install_github(c("ropensci/tabulizerjars", "ropensci/tabulizer"))
input_file <- str_glue('{here::here()}/analysis/data/raw_data/Results UW-40.pdf')
pdf_table <- extract_tables(input_file)[[1]] %>% as_data_frame()

pdf_table_nice <-
  pdf_table[-c(1:7),] %>%  # drop first seven rows that have no data
  separate(V2, into = c("Square", "Level"), sep = "  ") %>%
  separate(V4, into = c("pMC", "pMC error"), sep = " ") %>%
  separate(V5, into = c("Radiocarbon age BP", "Radiocarbon age error"), sep = " ") %>%
  rename("Lab code" = "V1") %>%
  rename("13C per mil" = "V3") %>%
  filter(`Radiocarbon age BP` != "") %>%
  mutate_at(vars(`13C per mil`,
                 pMC,
                 `pMC error`,
                 `Radiocarbon age BP`,
                 `Radiocarbon age error`),
            as.numeric)

write_csv(pdf_table_nice,
          here::here("analysis/data/derived_data/mau-a-radiocarbon-ages.csv"))
