#!/bin/bash
#
#SBATCH --cpus-per-task=32
#SBATCH --mem=100GB
#SBATCH --partition=basic
#SBATCH --job-name=pangenome
#SBATCH --time=0-05:00:00


module load Conda; conda activate anvio-9

anvi-pan-genome -g thiodiazotropha-GENOMES.db -n thiodiazotropha_pangenome -T 32 --min-occurrence 5 --mcl-inflation 2 --minbit 0.4

# below commands used for benchmarking

#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl15_mb_05 -T 32 --min-occurrence 1 --mcl-inflation 1.5 --minbit 0.5 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl15_mb_04 -T 32 --min-occurrence 1 --mcl-inflation 1.5 --minbit 0.4 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl15_mb_03 -T 32 --min-occurrence 1 --mcl-inflation 1.5 --minbit 0.3 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl15_mb_02 -T 32 --min-occurrence 1 --mcl-inflation 1.5 --minbit 0.2 --skip-alignments

#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl2mb_05 -T 32 --min-occurrence 1 --mcl-inflation 2 --minbit 0.5 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl2mb_04 -T 32 --min-occurrence 1 --mcl-inflation 2 --minbit 0.4 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl2mb_03 -T 32 --min-occurrence 1 --mcl-inflation 2 --minbit 0.3 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl2mb_02 -T 32 --min-occurrence 1 --mcl-inflation 2 --minbit 0.2 --skip-alignments

#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl25_mb_05 -T 32 --min-occurrence 1 --mcl-inflation 2.5 --minbit 0.5 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl25_mb_04 -T 32 --min-occurrence 1 --mcl-inflation 2.5 --minbit 0.4 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl25_mb_03 -T 32 --min-occurrence 1 --mcl-inflation 2.5 --minbit 0.3 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenome_mcl25_mb_02 -T 32 --min-occurrence 1 --mcl-inflation 2.5 --minbit 0.2 --skip-alignments

#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenomemcl3_mb_05 -T 32 --min-occurrence 1 --mcl-inflation 3 --minbit 0.5 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenomemcl3_mb_04 -T 32 --min-occurrence 1 --mcl-inflation 3 --minbit 0.4 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenomemcl3_mb_03 -T 32 --min-occurrence 1 --mcl-inflation 3 --minbit 0.3 --skip-alignments
#anvi-pan-genome -g spartina_clam-GENOMES.db -n thiodiazotropha_pangenomemcl3_mb_02 -T 32 --min-occurrence 1 --mcl-inflation 3 --minbit 0.2 --skip-alignments



