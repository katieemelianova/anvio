library(tidydr)
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)
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

all_genomes <- rbind(data.frame(genome=rolando_genomes, study = "rolando", host="plant"),
data.frame(genome=huang_genomes, study = "huang", host="plant"),
data.frame(genome=osvatic_genomes, study = "osvatic", host="clam"),
data.frame(genome=giani_genomes, study = "giani", host="clam"),
data.frame(genome=morel_genomes, study = "morel", host="clam"),
data.frame(genome=petersen_clam, study = "petersen", host="clam"),
data.frame(genome=ficus_genomes, study = "ficus", host="plant"))




genomes <- read_delim("spartina_clam_mags_fastaNI_all_v_all", col_names = FALSE) %>% 
  mutate(X1 = str_replace(X1, "/lisc/data/scratch/spartina/thio_mags/spartina_clam_mags/", "")) %>%
  mutate(X1 = str_replace(X1, ".fna", "")) %>%
  mutate(X1 = ifelse(startsWith(X1, "GCA"), paste0("GCA_", str_split_i(X1, "_", 2)), X1)) %>%
  mutate(X2 = str_replace(X2, "/lisc/data/scratch/spartina/thio_mags/spartina_clam_mags/", "")) %>%
  mutate(X2 = str_replace(X2, ".fna", "")) %>%
  mutate(X2 = ifelse(startsWith(X2, "GCA"), paste0("GCA_", str_split_i(X2, "_", 2)), X2)) %>%
  set_colnames(c("genome", "genome_reference", "ANI", "blah1", "blah2")) %>%
  dplyr::left_join(all_genomes) %>%
  set_colnames(c("genome_query", "genome", "ANI", "blah1", "blah2", "query_study", "query_host")) %>%
  dplyr::left_join(all_genomes) %>%
  set_colnames(c("genome_query", "genome", "ANI", "blah1", "blah2", "query_study", "query_host", "reference_study", "reference_host")) %>%
  filter(query_host %in% c("plant", "clam") & reference_host %in% c("plant", "clam"))





library(patchwork)
plant_ani_hist <- genomes %>%  
  filter(query_host == "plant" & reference_host == "plant") %>%
  ggplot(aes(x=ANI)) + 
  geom_histogram() +
  ylab("Plant Count")

clam_ani_hist <- genomes %>%  
  filter(query_host == "clam" & reference_host == "clam") %>%
  ggplot(aes(x=ANI)) + 
  geom_histogram() +
  ylab("Clam Count")

(plant_ani_hist / clam_ani_hist)



genomes %>% filter(ANI > 85 & ANI < 90 & genome_query != genome & reference_host == "plant")

genomes %>% filter(genome_query != genome & reference_host == "plant" & reference_study == "ficus") %>%
  ggplot(aes(x=ANI)) + 
  geom_histogram() +
  ylab("Ficus Count")



genomes %>% filter(ANI > 85 & ANI < 90 & reference_host == "plant")

genomes %>%  
  filter(query_host == "clam" & 
           reference_host == "clam" & 
           #ANI > 85 &
           #ANI < 90 &
           genome_query != genome) %>%
  ggplot(aes(x=ANI)) + 
  geom_histogram() +
  ylab("Plant Count")



### my conclusions from the ANI histogram: #####
# 
# one species in two clades in clams (100ish and 95% peaks)
# 
# only one par of MAGs from same species in plant (two rolando ones)
# 
# both plant and clam mags have a peak at just below 90 (rolando-huang pair)
#
#
#
#
#
#
#


library(igraph)

#links <- data.frame(
#  source=c("A","A", "A", "A", "A","J", "B", "B", "C", "C", "D","I"),
#  target=c("B","B", "C", "D", "J","A","E", "F", "G", "H", "I","I"),
#  importance=(sample(1:10, 12, replace=T))
#)


links <- genomes %>% dplyr::select(genome_query, genome, ANI) %>% set_colnames(c("source", "target", "importance")) %>% as.data.frame()


#nodes <- data.frame(
#  name=LETTERS[1:10],
#  carac=c( rep("young",3),rep("adult",2), rep("old",5))
#)

nodes <- genomes %>% 
  dplyr::select(-c(ANI, blah1, blah2, genome_query, query_study, query_host)) %>% 
  unique() %>%
  set_colnames(c("name", "study", "host"))



network <- graph_from_data_frame(d=links, vertices=nodes, directed=F) 



library(RColorBrewer)
coul  <- brewer.pal(3, "Set1") 

# Create a vector of color
my_color <- coul[as.numeric(as.factor(V(network)$host))]

# Make the plot
plot(network, vertex.color=my_color)










