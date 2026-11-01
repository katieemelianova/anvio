


library(dplyr)
library(tidyr)
library(pheatmap)
library(stringr)
library(tibble)
library(pheatmap)

rolando_genomes <- read.table("rolando_mag_accessions.txt") %>% pull(V1)
huang_genomes <- read.table("huang_mag_accessions.txt") %>% pull(V1)
osvatic_genomes <- read.table("osvatic_mag_accessions.txt") %>% pull(V1)
giani_genomes <- read.table("giani_mag_accessions.txt") %>% pull(V1)
morel_genomes <- read.table("morel_mag_accessions.txt") %>% pull(V1)
petersen_clam <- c("luna_ont_bin1", "lotti_ont_bin1")
ficus_genomes <- c("PIE_T1P1_root_Marsh_MG__3300081559_11",
                   "PIE_T1P1_root_Marsh_MG__3300081559_s3",
                   "PIE_T2P3_root_Marsh_MG__3300077085_6",
                   "PIE_T3P3_root_Marsh_MG__3300077490_s15")



plant_genomes <- c(rolando_genomes, huang_genomes, ficus_genomes)
clam_genomes <- c(petersen_clam, morel_genomes, giani_genomes, osvatic_genomes)




read_delim("spartina_clam_mags_compareM_AAI/aai/aai_summary.tsv", col_names = TRUE) %>% 
  dplyr::select(`#Genome A`, `Genome B`, `Mean AAI`) %>%
  set_colnames(c("genome1", "genome2", "AAI")) %>%
  mutate(genome1 = ifelse(startsWith(genome1, "GCA"), paste0("GCA_", str_split_i(genome1, "_", 2)), genome1),
         genome2 = ifelse(startsWith(genome2, "GCA"), paste0("GCA_", str_split_i(genome2, "_", 2)), genome2)) %>%
  filter(genome1 %in% c(plant_genomes, clam_genomes) & genome2 %in% c(plant_genomes, clam_genomes)) %>%
  dplyr::select(genome1, genome2, AAI) %>%
  mutate(host1 = case_when(genome1 %in% plant_genomes ~ "plant",
                           genome1 %in% clam_genomes ~"clam"),
         host2 = case_when(genome2 %in% plant_genomes ~ "plant",
                           genome2 %in% clam_genomes ~"clam"))








ani <- read_delim("spartina_clam_mags_compareM_AAI/aai/aai_summary.tsv", col_names = TRUE) %>% 
  dplyr::select(`#Genome A`, `Genome B`, `Mean AAI`) %>%
  set_colnames(c("genome1", "genome2", "AAI")) %>%
  mutate(genome1 = ifelse(startsWith(genome1, "GCA"), paste0("GCA_", str_split_i(genome1, "_", 2)), genome1),
         genome2 = ifelse(startsWith(genome2, "GCA"), paste0("GCA_", str_split_i(genome2, "_", 2)), genome2)) %>%
  filter(genome1 %in% c(plant_genomes, clam_genomes) & genome2 %in% c(plant_genomes, clam_genomes)) %>%
  dplyr::select(genome1, genome2, AAI) %>%
  pivot_wider(names_from = genome2,
              values_from = AAI) %>%
  column_to_rownames("genome1") %>%
  as.matrix() 





pheatmap(ani, na_col = "grey78", color = colorRampPalette(c("dodgerblue", "white", "red"))(20))



