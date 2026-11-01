

module load ncbi-datasets

################################################################
#  download each dataset, rename and remove not needed files   #
################################################################

datasets download genome accession --inputfile rolando_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset rolando_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt

datasets download genome accession --inputfile huang_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset huang_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile osvatic_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset osvatic_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile morel_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset morel_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile giani_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset giani_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile sudo_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset sudo_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt

datasets download genome accession --inputfile PRJEB85476_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset PRJEB85476_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt

datasets download genome accession --inputfile PRJEB87551_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset PRJEB87551_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt

datasets download genome accession --inputfile petersen_mag_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset petersen_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile thiodiazotropha_species_reps_accessions.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset thiodiazotropha_speciesrep_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


datasets download genome accession --inputfile sedimenticola_outgroup_accession.txt --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset sedimenticola_outgroup_ncbi_dataset
rm ncbi_dataset.zip README.md md5sum.txt


#datasets download genome accession --inputfile sedimenticolaceae_all_accessions.txt --dehydrated
#unzip ncbi_dataset.zip
#datasets rehydrate --directory .
#mv ncbi_dataset sedimenticolaceae_all_ncbi_dataset
#rm ncbi_dataset.zip README.md md5sum.txt


#################################################
#        symlink everything into one dir        #                           
#################################################


ln -s $PWD/*ncbi_dataset/data/*/*fna $PWD/thiodiazotropha_mags
ln -s $PWD/non_gtdb_dataset/*fna $PWD/thiodiazotropha_mags
ln -s $PWD/seagrass_dataset/*fna $PWD/thiodiazotropha_mags


