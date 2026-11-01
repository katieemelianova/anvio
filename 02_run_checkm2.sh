#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=100GB
#SBATCH --partition=basic
#SBATCH --job-name=checkm
#SBATCH --time=1-00:00:00

module load CheckM2

checkm2 predict --threads 32 --input thiodiazotropha_mags --output-directory thiodiazotropha_mags_checkm2

# remove from the mag directory any MAGs which have either too low completeness or too high contamination
cat thiodiazotropha_mags_checkm2/quality_report.tsv | awk '$2 < 85' | cut -f 1 | while read i; do rm thiodiazotropha_mags/$i".fna"; done
cat thiodiazotropha_mags_checkm2/quality_report.tsv | awk '$3 > 5' | cut -f 1 | while read i; do rm thiodiazotropha_mags/$i".fna"; done

