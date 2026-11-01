#!/bin/bash
#
#SBATCH --cpus-per-task=28
#SBATCH --mem=80GB
#SBATCH --partition=basic
#SBATCH --job-name=anvi_kofams
#SBATCH --time=1-00:00:00

module load Conda; conda activate anvio-9


# this only needs to be run once but keeping it here neverthelness
# anvi-setup-kegg-data --kegg-data-dir $PWD/kegg_data

ls dereplicated_genomes_formatfasta/*db | while read i; do anvi-run-kegg-kofams -c $i -T 28 --kegg-data-dir /lisc/data/scratch/dome/petersen/kemelianova/anvio/kegg_data/; done


