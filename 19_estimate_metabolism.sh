

module load Conda; conda activate anvio-9



ls prokka2anvio_dbs/*db | while read i; do base=`basename $i`; outfile=`echo $base | sed 's/.db//g'`; anvi-estimate-metabolism -c $i -O $outfile --kegg-data-dir /lisc/data/scratch/dome/petersen/kemelianova/anvio/kegg_data/; done

