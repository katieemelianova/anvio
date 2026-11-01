#!/bin/bash
#
#SBATCH --cpus-per-task=28
#SBATCH --mem=80GB
#SBATCH --partition=basic
#SBATCH --job-name=cogs
#SBATCH --time=1-00:00:00

module load Conda; conda activate anvio-9

ls dereplicated_genomes_anvio/*db | while read i; do anvi-run-ncbi-cogs --cog-data-dir $PWD/cogs -T 28 -c $i; done
