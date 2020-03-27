#!/bin/bash

# This script creates BOLD delay maps, averaged across subjects 
# Used in the "BOLD delay reproducibility" study
# Written by Ahmed Khalil, MD PhD 

# create maps of averaged BD values (across subjects)
cd /home/khalila/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES/

## for controls - no censoring
# concatenate all BD maps to 4D image
fslmerge -t merge_control_nocens_D0.nii.gz $(cat ../ANALYSIS/TSA_bd_D0_list_controls.txt)
fslmerge -t merge_control_nocens_D1.nii.gz $(cat ../ANALYSIS/TSA_bd_D1_list_controls.txt)

# take mean across subjects
fslmaths merge_control_nocens_D0.nii.gz -Tmean mean_control_nocens_D0.nii.gz
fslmaths merge_control_nocens_D1.nii.gz -Tmean mean_control_nocens_D1.nii.gz

## for controls - censoring
# concatenate all BD maps to 4D image
fslmerge -t merge_control_cens_D0.nii.gz $(cat ../ANALYSIS/TSA_cens_bd_D0_list_controls.txt)
fslmerge -t merge_control_cens_D1.nii.gz $(cat ../ANALYSIS/TSA_cens_bd_D1_list_controls.txt)

# take mean across subjects
fslmaths merge_control_cens_D0.nii.gz -Tmean mean_control_cens_D0.nii.gz
fslmaths merge_control_cens_D1.nii.gz -Tmean mean_control_cens_D1.nii.gz


## for stroke patients - no censoring
# concatenate all BD maps to 4D image
fslmerge -t merge_stroke_nocens_D0.nii.gz $(cat ../ANALYSIS/TSA_bd_D0_list_stroke.txt)
fslmerge -t merge_stroke_nocens_D1.nii.gz $(cat ../ANALYSIS/TSA_bd_D1_list_stroke.txt)

# take mean across subjects
fslmaths merge_stroke_nocens_D0.nii.gz -Tmean mean_stroke_nocens_D0.nii.gz
fslmaths merge_stroke_nocens_D1.nii.gz -Tmean mean_stroke_nocens_D1.nii.gz

## for stroke patients - censoring
# concatenate all BD maps to 4D image
fslmerge -t merge_stroke_cens_D0.nii.gz $(cat ../ANALYSIS/TSA_cens_bd_D0_list_stroke.txt)
fslmerge -t merge_stroke_cens_D1.nii.gz $(cat ../ANALYSIS/TSA_cens_bd_D1_list_stroke.txt)

# take mean across subjects
fslmaths merge_stroke_cens_D0.nii.gz -Tmean mean_stroke_cens_D0.nii.gz
fslmaths merge_stroke_cens_D1.nii.gz -Tmean mean_stroke_cens_D1.nii.gz

# extract values
# directory with vascular territory masks
VT=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/TEMPLATES/VT
# loop through mean BD maps
for i in mean_control_nocens_D0.nii.gz mean_control_nocens_D1.nii.gz mean_control_cens_D0.nii.gz mean_control_cens_D1.nii.gz mean_stroke_nocens_D0.nii.gz mean_stroke_nocens_D1.nii.gz mean_stroke_cens_D0.nii.gz mean_stroke_cens_D1.nii.gz
do 
# loop through VTs
		for v in rmca raca rpca lmca laca lpca
		
			do
			echo $i $v
			# Extract values
				# differences
			fslmeants -i $i -o ${i}_${v}_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
	
			
			done 
done
