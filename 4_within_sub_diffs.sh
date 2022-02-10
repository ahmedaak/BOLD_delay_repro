#!/usr/bin/env bash

# This script extracts BOLD delay values from normalized TSA maps (vascular territories, without CSF) for the BOLD delay reproducibility project
# Written by Ahmed Khalil, 12.11.2018

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO

# working directory
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES

# directory with vascular territory masks
VT=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/ANALYSIS/TEMPLATES/VT
# loop through subjects

for i in `cat $MAIN_DIR/subjects_all.txt`  

	do
	echo $i
	#get BOLD delay difference maps by subtracting the day 1 map from the day 0 map
	fslmaths $DATA/$i/D0/ANTS/TSA_norm.nii.gz -sub $DATA/$i/D1/ANTS/TSA_norm.nii.gz -abs $DATA/$i/TSA_diff.nii.gz
	fslmaths $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz -sub $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz -abs $DATA/$i/TSA_cens_diff.nii.gz
	
	
	# NO CENSORING
		# concatenate BOLD delay maps across time
		fslmerge -t $DATA/$i/TSA_merge.nii.gz  $DATA/$i/D0/ANTS/TSA_norm.nii.gz  $DATA/$i/D1/ANTS/TSA_norm.nii.gz  
		
		# calculate  SD of BOLD delay values over time 
		fslmaths $DATA/$i/TSA_merge.nii.gz -Tstd $DATA/$i/TSA_SD.nii.gz
		
		# calculate mean of BOLD delay values over time
		fslmaths $DATA/$i/TSA_merge.nii.gz -Tmean $DATA/$i/TSA_mean.nii.gz
		
		# calculate CoV of BOLD delay values over time
		fslmaths $DATA/$i/TSA_SD.nii.gz -div $DATA/$i/TSA_mean.nii.gz  $DATA/$i/TSA_CoV.nii.gz 
		
		# calculate coefficient of repeatability for BOLD delay values over time
		fslmaths $DATA/$i/TSA_SD.nii.gz -mul 2.77 $DATA/$i/TSA_CoR.nii.gz
	
	# CENSORING
		# concatenate BOLD delay maps across time
		fslmerge -t $DATA/$i/TSA_merge_cens.nii.gz  $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz  $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz  
		
		# calculate  SD of BOLD delay values over time 
		fslmaths $DATA/$i/TSA_merge_cens.nii.gz -Tstd $DATA/$i/TSA_SD_cens.nii.gz
		
		# calculate mean of BOLD delay values over time
		fslmaths $DATA/$i/TSA_merge_cens.nii.gz -Tmean $DATA/$i/TSA_mean_cens.nii.gz
		
		# calculate CoV of BOLD delay values over time
		fslmaths $DATA/$i/TSA_SD_cens.nii.gz -div $DATA/$i/TSA_mean_cens.nii.gz  $DATA/$i/TSA_CoV_cens.nii.gz 
		
		# calculate coefficient of repeatability for BOLD delay values over time
		fslmaths $DATA/$i/TSA_SD_cens.nii.gz -mul 2.77 $DATA/$i/TSA_CoR_cens.nii.gz
		
		
	# make directory to store values
	mkdir $DATA/$i/VALS

		 # #loop through VTs
		  for v in mca aca pca
		
			  do
			  echo $i $v
			# Extract BD differences 
			
			fslmeants -i $DATA/$i/TSA_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_reldiff_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/TSA_cens_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_reldiff_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			
			# Extract BD values
			fslmeants -i $DATA/$i/D0/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D0_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D0_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
		
			fslmeants -i $DATA/$i/D1/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D1_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D1_vals_atlas.txt --label=TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose		
		 done
 done
