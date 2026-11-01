#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=500GB
#SBATCH --partition=basic
#SBATCH --job-name=iqtree
#SBATCH --time=1-00:00:00

module load MAFFT
module load Conda; conda activate anvio-9
module load IQ-TREE/3.1.4


# softcore
# anvi-get-sequences-for-gene-clusters -p thiodiazotropha_pangenome/thiodiazotropha_pangenome-PAN.db --min-num-genomes-gene-cluster-occurs 53 --max-num-genes-from-each-genome 1 -o core-sequences.fasta -g thiodiazotropha-GENOMES.db --concatenate-gene-clusters

#align and trim
#mafft-linsi --thread 32 core-sequences.fasta > core-sequences.aln.fasta

# tree
iqtree3 -s core-sequences.aln.fasta -m TEST -T 32 -B 1000

