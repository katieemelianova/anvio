

mkdir dereplicated_genomes_anvio

ls thiodiazotropha_mags_dereplicated/dereplicated_genomes/* | while read i; do basefile=`basename $i`; cut -d" " -f1 $i > dereplicated_genomes_anvio/$basefile; done
