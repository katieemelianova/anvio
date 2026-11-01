library(dplyr)
library(tidyr)
library(pheatmap)
library(stringr)
library(tibble)
library(pheatmap)
library(ComplexHeatmap)
library(magrittr)


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






aai <- read_delim("all_aai.txt", col_names = FALSE) %>% 
  dplyr::select(X1, X2, X7) %>%
  set_colnames(c("genome1", "genome2", "AAI")) %>%
  mutate(genome1 = ifelse(startsWith(genome1, "GCA"), paste0("GCA_", str_split_i(genome1, "_", 2)), genome1),
         genome2 = ifelse(startsWith(genome2, "GCA"), paste0("GCA_", str_split_i(genome2, "_", 2)), genome2)) %>%
  mutate(genome1 = str_replace(genome1, ".fna", ""),
         genome2 = str_replace(genome2, ".fna", "")) %>%
  #filter(genome1 %in% c(plant_genomes, clam_genomes) & genome2 %in% c(plant_genomes, clam_genomes)) %>%
  filter(!(genome1 %in% c("query", "target"))) %>%
  dplyr::select(genome1, genome2, AAI) %>%
  pivot_wider(names_from = genome2,
              values_from = AAI) %>%
  column_to_rownames("genome1")

aai[aai==">90%"]<-"90"
aai <- mutate_all(aai, function(x) as.numeric(as.character(x)))


ha <- HeatmapAnnotation(foo = 1:ncol(aai))

ha_values <- data.frame(genome=colnames(aai)) %>%
  mutate(Host=case_when(genome %in% clam_genomes ~"Clam",
                        genome %in% plant_genomes ~"Plant",
                        !(genome %in% c(clam_genomes, plant_genomes)) ~"GTDB")) %>%
  pull(Host)
ha <- HeatmapAnnotation(Host=ha_values, 
                        col = list(Host = c("Clam" = "purple", "Plant" = "seagreen", "GTDB" = "grey78")),
                        annotation_legend_param = list(Host = list(title = "Host"),
                                                       title_gp = gpar(fontsize = 17, fontface = "bold"),
                                                       labels_gp = gpar(fontsize = 23)),
                        gp = gpar(col = "black"),
                        show_annotation_name = FALSE)



png("AAI_heatmap.png", height=2000, width=2000)
Heatmap(as.matrix(aai),
        show_column_dend = FALSE,
        show_row_dend = FALSE,
        top_annotation = ha,
        show_row_names = FALSE,
        heatmap_legend_param=list(title="AAI",
                                  legend_height = unit(10, "cm"),
                                  grid_height   = unit(1, "cm"),
                                  grid_width    = unit(1, "cm"),
                                  title_gp = gpar(fontsize = 17, fontface = "bold"),
                                  labels_gp = gpar(fontsize = 17)))
dev.off()


