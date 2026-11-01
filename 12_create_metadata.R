library(dplyr)
library(readr)
library(stringr)
library(tidytree)
library(tidyr)
library(ggplot2)
library(magrittr)

rolando_genomes <- read.table("rolando_mag_accessions.txt") %>% pull(V1)
huang_genomes <- read.table("huang_mag_accessions.txt") %>% pull(V1)
osvatic_genomes <- read.table("osvatic_mag_accessions.txt") %>% pull(V1)
giani_genomes <- read.table("giani_mag_accessions.txt") %>% pull(V1)
morel_genomes <- read.table("morel_mag_accessions.txt") %>% pull(V1)
petersen_clam <- c("luna_ont_bin1", "lotti_ont_bin1")
sanger_genomes <- read.table("sanger_mag_accessions.txt") %>% pull(V1)
sudo_genomes <- read.table("sudo_mag_accessions.txt") %>% pull(V1)
petersen_genomes <- read.table("petersen_mag_accessions.txt") %>% pull(V1)
PRJEB85476_genomes <- read.table("PRJEB85476_mag_accessions.txt") %>% pull(V1)
PRJEB87551_genomes <- read.table("PRJEB87551_mag_accessions.txt") %>% pull(V1)
mpi_genomes <- c("GCF_963455295.1_xbCteDecu1.Thiodiazotropha_sp._1.1_genomic", "GCF_963455295.1")

seagrass_genomes <- c("S10C43", "S6C31", "S6C37", "metabat2.111.contigs", "metabat2.466.contigs", "metabat2.680.contigs", "metabat2.898.contigs", "metabat2.939.contigs")
seagrass_genomes <- c("metabat2.680.contigs", "metabat2.939.contigs", "metabat2.85.contigs", "S6C37", "metabat2.83.contigs", "Maxbin.009_sub.contigs", "Maxbin.016.contigs", 
                      "metabat2.242_sub.contigs", "metabat2.111.contigs", "S10C43", "metabat2.292.contigs", "metabat2.338.contigs", "metabat2.941.contigs", "metabat2.980.contigs", 
                      "metabat2.67.contigs", "metabat2.898.contigs", "metabat2.719.contigs", "metabat2.182.contigs", "metabat2.310.contigs", "metabat2.466.contigs", "Maxbin.003.contigs" , "S6C31")


ficus_genomes <- c("PIE_T1P1_root_Marsh_MG__3300081559_11",
                   "PIE_T1P1_root_Marsh_MG__3300081559_s3",
                   "PIE_T2P3_root_Marsh_MG__3300077085_6",
                   "PIE_T3P3_root_Marsh_MG__3300077490_s15")

sporobolus_genomes <- c(ficus_genomes, rolando_genomes, huang_genomes)
plant_genomes <- c(sporobolus_genomes, seagrass_genomes)
clam_genomes <- c(PRJEB85476_genomes, PRJEB87551_genomes, petersen_clam, petersen_genomes, morel_genomes, giani_genomes, osvatic_genomes, sanger_genomes, sudo_genomes, mpi_genomes)
sedimenticola_outgroup <- c("GCA_027068675.1")


read_tsv("genome_ids.txt", col_names = FALSE) %>%
  mutate(matchcol = ifelse(startsWith(X1, "GCA"), paste0("GCA_", str_split_i(X1, "_", 2)), X1)) %>%
  mutate(host = case_when(matchcol %in% plant_genomes ~"Plant",
                          matchcol %in% clam_genomes ~"Clam",
                          matchcol %in% sedimenticola_outgroup ~"Outgroup"),
         host_species = case_when(matchcol %in% sporobolus_genomes ~"Sporobolus",
                                  matchcol %in% seagrass_genomes ~"Syringodium",
                                  matchcol %in% clam_genomes ~"Clam",
                                  matchcol %in% sedimenticola_outgroup ~"Outgroup"),
         genome_source = case_when(matchcol %in% rolando_genomes ~ "Spartina Rolando",
                                   matchcol %in% huang_genomes ~ "Spartina Huang",
                                   matchcol %in% osvatic_genomes ~ "Clam Osvatic",
                                   matchcol %in% giani_genomes ~ "Clam Giani",
                                   matchcol %in% morel_genomes ~ "Clam Morel",
                                   matchcol %in% petersen_clam ~ "Clam Petersen",
                                   matchcol %in% petersen_genomes ~ "Clam Petersen",
                                   matchcol %in% ficus_genomes ~"Spartina Ficus",
                                   matchcol %in% sanger_genomes ~"Clam Sanger",
                                   matchcol %in% mpi_genomes ~"Clam MPI",
                                   matchcol %in% sudo_genomes ~"Clam Sudo",
                                   matchcol %in% c(PRJEB85476_genomes, PRJEB87551_genomes) ~ "Clam Sanger",
                                   matchcol %in% c(seagrass_genomes) ~ "Seagrass Carlotta",
                                   matchcol %in% sedimenticola_outgroup ~ "Outgroup")) %>%
  set_colnames(c("genome", "matchcol", "host", "host_species", "genome_name")) %>%
  mutate(genome = str_replace_all(genome, "\\.", "_")) %>%
  mutate(genome = str_replace_all(genome, "__", "_")) %>%
  dplyr::select(-matchcol) %>%
  write_tsv("anvio_metadata.txt") 
  



