#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=100GB
#SBATCH --partition=basic
#SBATCH --job-name=drep
#SBATCH --time=3-00:00:00

module load dRep/3.7.1-foss-2025b

find $PWD/thiodiazotropha_mags/ -name "*.fna"  > mag_list.txt

dRep dereplicate thiodiazotropha_mags_dereplicated -g mag_list.txt -p 32
