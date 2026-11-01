library(reshape2)
library(tidyr)
library(dplyr)
library(readr)
library(stringr)
library(tidytree)

# gene clusters are in long format, turn them into a matrix compatible with scoary2
clusters <- read_table("thiodiazotropha_pan_summary/thiodiazotropha_pangenome_gene_clusters_summary.txt") %>% 
  rename("Gene" = "gene_cluster_id")

clusters %>%
  distinct(Gene, genome_name) %>%
  mutate(present = 1L) %>%
  pivot_wider(
    names_from  = genome_name,
    values_from = present,
    values_fill = 0L
  ) %>%
  write_tsv("gene_clusters_long.txt") 


# make the binary traits file from anvio metadata



read_tsv("anvio_metadata.txt") %>%
  mutate(clam_associated=case_when(host_species == "Clam" ~ "1",
                                   host_species != "Clam" ~ "0"),
         plant_associated=case_when(host_species %in% c("Syringodium", "Sporobolus") ~ "1",
                                    !(host_species %in% c("Syringodium", "Sporobolus")) ~ "0")) %>%
  dplyr::select(-c(host, host_species, genome_name)) %>%
  rename("Trait" = "genome") %>%
  write_csv("binary_traits.csv")
  
