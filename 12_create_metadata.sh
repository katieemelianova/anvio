
ml R

ls dereplicated_genomes_anvio/*db | while read i; do basename $i | sed 's/.db//g'; done > genome_ids.txt
Rscript 12_create_metadata.R

