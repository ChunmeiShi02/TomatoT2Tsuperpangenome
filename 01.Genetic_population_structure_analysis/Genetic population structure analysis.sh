

# Calculates the Genetic Relationship Matrix and PCA using GCTA.
gcta64 --bfile $plink_file --make-grm --autosome --out $output_prefix
##Perform PCA analysis
gcta64 --grm $output_prefix  --pca 10 --out $output_gcta


# Nucleotide Diversity (π) Calculation
vcftools --gzvcf $vcf_file --window-pi 100000 --window-pi-step 10000 --keep $keep_sample --out $out_pi


# Population Differentiation (FST) Analysis
vcftools --gzvcf $vcf_file --weir-fst-pop $sample_list1 --weir-fst-pop $sample_list2 --fst-window-size 100000 --fst-window-step 10000 --out $out_fst


# Population Structure Analysis with ADMIXTURE
# Cross-validation is performed to determine optimal K.
admixture --cv $bed_file -j50  $K | tee log.out