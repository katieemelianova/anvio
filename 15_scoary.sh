module load Conda; conda activate anvio-9

# set a default colection
anvi-script-add-default-collection -p thiodiazotropha_pangenome/thiodiazotropha_pangenome-PAN.db

# get a gene clustert presence absence matrix using all clusters in the default collection
anvi-summarize -p thiodiazotropha_pangenome/thiodiazotropha_pangenome-PAN.db -g thiodiazotropha-GENOMES.db -C DEFAULT -o thiodiazotropha_pan_summary

gunzip thiodiazotropha_pan_summary/thiodiazotropha_pangenome_gene_clusters_summary.txt.gz

module load R

# resahpe the data frame to be scoary2 comaptible and make the binary traits file
Rscript prepare_scoary_files.R

conda activate scoary-2

# run scoary2
scoary2 --genes gene_clusters_long.txt --gene-data-type 'gene-count:\t' --outdir scoary_out --n-permut 1000 --traits binary_traits.csv --trait-data-type binary:,
