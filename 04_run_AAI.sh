#!/bin/bash
#
#SBATCH --cpus-per-task=28
#SBATCH --mem=50GB
#SBATCH --partition=basic
#SBATCH --job-name=fastaai
#SBATCH --time=1-00:00:00


module load FastAAI/0.1.20-foss-2025b




fastaai build_db --genomes thiodiazotropha_mags_dereplicated/dereplicated_genomes/ --threads 4 --verbose --output thiodiazotropha_mags_dereplicated_fastaai_build --database thiodiazotropha_mags_derep.db --compress

fastaai db_query --query thiodiazotropha_mags_dereplicated_fastaai_build/database/thiodiazotropha_mags_derep.db --target thiodiazotropha_mags_dereplicated_fastaai_build/database/thiodiazotropha_mags_derep.db --threads 28 --verbose --output thiodiazotropha_mags_dereplicated_fastaai


cat thiodiazotropha_mags_dereplicated_fastaai/results/* | grep -v "query" > all_aai.txt 
