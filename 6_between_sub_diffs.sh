#!/bin/bash

# This script creates maps of change in BD values over time, averaged across subjects
# Used in the "BOLD delay reproducibility" study
# Written by Ahmed Khalil, MD PhD 

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/BD_VALS

cd $MAIN_DIR/IMAGES

# FOR EACH DATASET SEPERATELY 
# loop through datasets
for i in tbi csb modafinil mpi msc nf yale stroke
do
# NO CENSORING
	# concatenate all difference maps to 4D image
	fslmerge -t $DATA/merge_${i}_nocens.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_diff_list_${i}.txt)
	# get mean across subjects
	fslmaths $DATA/merge_${i}_nocens.nii.gz -Tmean $DATA/mean_${i}_nocens.nii.gz
	# get median across subjects
	fslmaths $DATA/merge_${i}_nocens.nii.gz -Tmedian $DATA/median_${i}_nocens.nii.gz
	# get SD across subjects
	fslmaths $DATA/merge_${i}_nocens.nii.gz -Tstd $DATA/sd_${i}_nocens.nii.gz
	# get absolute mean across subjects
	fslmaths $DATA/mean_${i}_nocens.nii.gz -abs $DATA/absmean_${i}_nocens.nii.gz
	# get relative SD across subjects
	fslmaths $DATA/sd_${i}_nocens.nii.gz -div $DATA/absmean_${i}_nocens.nii.gz $DATA/relsd_${i}_nocens.nii.gz
	
# CENSORING
	# concatenate all difference maps to 4D image
	fslmerge -t $DATA/merge_${i}_cens.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_cens_diff_list_${i}.txt)
	# get mean across subjects
	fslmaths $DATA/merge_${i}_cens.nii.gz -Tmean $DATA/mean_${i}_cens.nii.gz
	# get median across subjects
	fslmaths $DATA/merge_${i}_cens.nii.gz -Tmedian $DATA/median_${i}_cens.nii.gz
	# get SD across subjects
	fslmaths $DATA/merge_${i}_cens.nii.gz -Tstd $DATA/sd_${i}_cens.nii.gz
	# get absolute mean across subjects
	fslmaths $DATA/mean_${i}_cens.nii.gz -abs $DATA/absmean_${i}_cens.nii.gz
	# get relative SD across subjects
	fslmaths $DATA/sd_${i}_cens.nii.gz -div $DATA/absmean_${i}_cens.nii.gz $DATA/relsd_${i}_cens.nii.gz

done 

# FOR ALL DATASETS TOGETHER 
# NO CENSORING
	# concatenate all difference maps to 4D image
	fslmerge -t $DATA/merge_all_nocens.nii.gz $DATA/merge_tbi_nocens.nii.gz $DATA/merge_csb_nocens.nii.gz $DATA/merge_modafinil_nocens.nii.gz $DATA/merge_mpi_nocens.nii $DATA/merge_msc_nocens.nii.gz $DATA/merge_nf_nocens.nii.gz $DATA/merge_yale_nocens.nii.gz $DATA/merge_stroke_nocens.nii.gz
	# get mean across subjects
	fslmaths $DATA/merge_all_nocens.nii.gz -Tmean $DATA/mean_all_nocens.nii.gz
	# get median across subjects
	fslmaths $DATA/merge_all_nocens.nii.gz -Tmedian $DATA/median_all_nocens.nii.gz
	# get SD across subjects
	fslmaths $DATA/merge_all_nocens.nii.gz -Tstd $DATA/sd_all_nocens.nii.gz
	# get absolute mean across subjects
	fslmaths $DATA/mean_all_nocens.nii.gz -abs $DATA/absmean_all_nocens.nii.gz
	# get relative SD across subjects
	fslmaths $DATA/sd_all_nocens.nii.gz -div $DATA/absmean_all_nocens.nii.gz $DATA/relsd_all_nocens.nii.gz

# CENSORING
	# concatenate all difference maps to 4D image
	fslmerge -t $DATA/merge_all_cens.nii.gz $DATA/merge_tbi_cens.nii.gz $DATA/merge_csb_cens.nii.gz $DATA/merge_modafinil_cens.nii.gz $DATA/merge_mpi_cens.nii $DATA/merge_msc_cens.nii.gz $DATA/merge_nf_cens.nii.gz $DATA/merge_yale_cens.nii.gz $DATA/merge_stroke_cens.nii.gz
	# take mean across subjects
	fslmaths $DATA/merge_all_cens.nii.gz -Tmean $DATA/mean_all_cens.nii.gz
	# take median across subjects
	fslmaths $DATA/merge_all_cens.nii.gz -Tmedian $DATA/median_all_cens.nii.gz
	# get SD across subjects
	fslmaths $DATA/merge_all_cens.nii.gz -Tstd $DATA/sd_all_cens.nii.gz
	# get absolute mean across subjects
	fslmaths $DATA/mean_all_cens.nii.gz -abs $DATA/absmean_all_cens.nii.gz
	# get relative SD across subjects
	fslmaths $DATA/sd_all_cens.nii.gz -div $DATA/absmean_all_cens.nii.gz $DATA/relsd_all_cens.nii.gz

