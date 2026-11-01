module load Conda; conda activate anvio-9


# need to login to the server using following command:
# ssh -L 8080:localhost:8080 emelianova@login01.lisc.univie.ac.at 

anvi-display-pan -p thiodiazotropha_pangenome/thiodiazotropha_pangenome-PAN.db --server-only -P 8080
