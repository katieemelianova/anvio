

ls dereplicated_genomes_clam_plant/* | while read i; do basefile=`basename $i`; cut -d" " -f1 $i > dereplicated_genomes_formatfasta/$basefile; done
