#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=100GB
#SBATCH --partition=basic
#SBATCH --job-name=gencontigs
#SBATCH --time=1-00:00:00



module load Conda; conda activate anvio-9


ls dereplicated_genomes_anvio/*fna | while read i; do output=`echo $i | sed -e 's/.fna//g'`; anvi-gen-contigs-database --num-threads 32 -f $i -o $output.db; done



