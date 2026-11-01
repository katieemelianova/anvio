#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=100GB
#SBATCH --partition=basic
#SBATCH --job-name=runhmms
#SBATCH --time=1-00:00:00

module load Conda; conda activate anvio-9

ls dereplicated_genomes_anvio/*db | while read i; do anvi-run-hmms -T 32 -c $i --add-to-functions-table; done
