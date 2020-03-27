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
	#get BOLD delay difference maps

	fslmaths $DATA/$i/D0/ANTS/TSA_norm.nii.gz -min $DATA/$i/D1/ANTS/TSA_norm.nii.gz $DATA/$i/TSA_diff.nii.gz
	fslmaths $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz -min $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz $DATA/$i/TSA_cens_diff.nii.gz
			
	#make directory to store values
	mkdir $DATA/$i/VALS

		 #loop through VTs
		 for v in mca aca pca
		
			 do
			 echo $i $v
			# Extract values
				# differences
			fslmeants -i $DATA/$i/TSA_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_diff_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
			fslmeants -i $DATA/$i/TSA_cens_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_diff_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
				# actual values
			fslmeants -i $DATA/$i/D0/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D0_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
			fslmeants -i $DATA/$i/D1/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D1_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
			
			fslmeants -i $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D0_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
			fslmeants -i $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D1_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall			
			
			done 
			
			fslmeants -i $DATA/$i/TSA_abs_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_diff_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/TSA_cens_abs_diff.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_diff_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			
			fslmeants -i $DATA/$i/TSA_diff.nii.gz -o $DATA/$i/VALS/${i}_nocens_diff_vals_atlas.txt --label=../TEMPLATES/ADHD200_parcellate_400_2mm_final.nii.gz --transpose
			fslmeants -i $DATA/$i/TSA_cens_diff.nii.gz -o $DATA/$i/VALS/${i}_cens_diff_vals_atlas.txt --label=../TEMPLATES/ADHD200_parcellate_400_2mm_final.nii.gz --transpose
			
			fslmeants -i $DATA/$i/D0/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D0_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/D0/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D0_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
		
			fslmeants -i $DATA/$i/D1/ANTS/TSA_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_nocens_D1_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose
			fslmeants -i $DATA/$i/D1/ANTS/TSA_cens_norm.nii.gz -o $DATA/$i/VALS/${i}_${v}_cens_D1_vals_atlas.txt --label=../TEMPLATES/VT_ROIs/vt_${v}_atlas.nii.gz --transpose		
		done
done
