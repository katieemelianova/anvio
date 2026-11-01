module load Conda; conda activate anvio-9


anvi-compute-functional-enrichment-in-pan -p thiodiazotropha_pangenome/thiodiazotropha_pangenome-PAN.db -g spartina_clam-GENOMES.db  -o test.txt --category-variable host_species --annotation-source COG24_FUNCTION
