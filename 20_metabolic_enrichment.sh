
module load Conda; conda activate anvio-9

# combine modules files into one
head -n 1 GCA_016842065.1_ASM1684206v1_genomic_modules.txt > all_genomic_modules.txt
for f in *_modules.txt; do     tail -n +2 "$f" >> all_genomic_modules.txt; done

# create groups info file
grep -v "Unknown" anvio_metadata.tsv > groups.txt 
sed -i 's/host_species/group/g' groups.txt

# replace metabat assembly names with anvio sanitized ones for now
sed -i 's/metabat2.680.contigs/metabat2_680_contigs/g' groups.txt
sed -i 's/metabat2.939.contigs/metabat2_939_contigs/g' groups.txt
sed -i 's/metabat2.466.contigs/metabat2_466_contigs/g' groups.txt


# run analysis
anvi-compute-metabolic-enrichment     -M all_genomic_modules.txt     -G groups.txt     -o metabolic_enrichment.txt --sample-header genome_name --just-do-it

# make a version without the very wordy accessions
cut -f 1,2,3,4,5,6,8,10 metabolic_enrichment.txt > metabolic_enrichment_noaccessions.txt
