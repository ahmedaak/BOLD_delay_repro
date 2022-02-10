#!/bin/bash

# This script creates BOLD delay maps, averaged across subjects 
# Used in the "BOLD delay reproducibility" study
# Written by Ahmed Khalil, MD PhD 

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/BD_VALS
# directory with vascular territory masks
VT=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/ANALYSIS/TEMPLATES/VT

cd $MAIN_DIR/IMAGES

## for controls - no censoring
	# concatenate all BD maps to 4D image
	fslmerge -t $DATA/merge_control_nocens_D0.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_bd_D0_list_controls.txt)
	fslmerge -t $DATA/merge_control_nocens_D1.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_bd_D1_list_controls.txt)

	# take mean across subjects
	fslmaths $DATA/merge_control_nocens_D0.nii.gz -Tmean $DATA/mean_control_nocens_D0.nii.gz
	fslmaths $DATA/merge_control_nocens_D1.nii.gz -Tmean $DATA/mean_control_nocens_D1.nii.gz
	
	# take SD across subjects
	fslmaths $DATA/merge_control_nocens_D0.nii.gz -Tstd $DATA/sd_control_nocens_D0.nii.gz
	fslmaths $DATA/merge_control_nocens_D1.nii.gz -Tstd $DATA/sd_control_nocens_D1.nii.gz

	# take CoV across subjects
	fslmaths $DATA/sd_control_nocens_D0.nii.gz -div $DATA/mean_control_nocens_D0.nii.gz $DATA/cov_control_nocens_D0.nii.gz
	fslmaths $DATA/sd_control_nocens_D1.nii.gz -div $DATA/mean_control_nocens_D1.nii.gz $DATA/cov_control_nocens_D1.nii.gz


## for controls - censoring
	# concatenate all BD maps to 4D image
	fslmerge -t $DATA/merge_control_cens_D0.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_cens_bd_D0_list_controls.txt)
	fslmerge -t $DATA/merge_control_cens_D1.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_cens_bd_D1_list_controls.txt)

	# take mean across subjects
	fslmaths $DATA/merge_control_cens_D0.nii.gz -Tmean $DATA/mean_control_cens_D0.nii.gz
	fslmaths $DATA/merge_control_cens_D1.nii.gz -Tmean $DATA/mean_control_cens_D1.nii.gz
	
	# take SD across subjects
	fslmaths $DATA/merge_control_cens_D0.nii.gz -Tstd $DATA/sd_control_cens_D0.nii.gz
	fslmaths $DATA/merge_control_cens_D1.nii.gz -Tstd $DATA/sd_control_cens_D1.nii.gz

	# take CoV across subjects
	fslmaths $DATA/sd_control_cens_D0.nii.gz -div $DATA/mean_control_cens_D0.nii.gz $DATA/cov_control_cens_D0.nii.gz
	fslmaths $DATA/sd_control_cens_D1.nii.gz -div $DATA/mean_control_cens_D1.nii.gz $DATA/cov_control_cens_D1.nii.gz


## for stroke patients - no censoring
	# concatenate all BD maps to 4D image
	fslmerge -t $DATA/merge_stroke_nocens_D0.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_bd_D0_list_stroke.txt)
	fslmerge -t $DATA/merge_stroke_nocens_D1.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_bd_D1_list_stroke.txt)

	# take mean across subjects
	fslmaths $DATA/merge_stroke_nocens_D0.nii.gz -Tmean $DATA/mean_stroke_nocens_D0.nii.gz
	fslmaths $DATA/merge_stroke_nocens_D1.nii.gz -Tmean $DATA/mean_stroke_nocens_D1.nii.gz

	# take SD across subjects
	fslmaths $DATA/merge_stroke_nocens_D0.nii.gz -Tstd $DATA/sd_stroke_nocens_D0.nii.gz
	fslmaths $DATA/merge_stroke_nocens_D1.nii.gz -Tstd $DATA/sd_stroke_nocens_D1.nii.gz
	
	# take CoV across subjects
	fslmaths $DATA/sd_stroke_nocens_D0.nii.gz -div $DATA/mean_stroke_nocens_D0.nii.gz $DATA/cov_stroke_cens_D0.nii.gz
	fslmaths $DATA/sd_stroke_nocens_D1.nii.gz -div $DATA/mean_stroke_nocens_D1.nii.gz $DATA/cov_stroke_nocens_D1.nii.gz



## for stroke patients - censoring
	# concatenate all BD maps to 4D image
	fslmerge -t $DATA/merge_stroke_cens_D0.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_cens_bd_D0_list_stroke.txt)
	fslmerge -t $DATA/merge_stroke_cens_D1.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/TSA_cens_bd_D1_list_stroke.txt)

	# take mean across subjects
	fslmaths $DATA/merge_stroke_cens_D0.nii.gz -Tmean $DATA/mean_stroke_cens_D0.nii.gz
	fslmaths $DATA/merge_stroke_cens_D1.nii.gz -Tmean $DATA/mean_stroke_cens_D1.nii.gz
	
	# take SD across subjects
	fslmaths $DATA/merge_stroke_cens_D0.nii.gz -Tstd $DATA/sd_stroke_cens_D0.nii.gz
	fslmaths $DATA/merge_stroke_cens_D1.nii.gz -Tstd $DATA/sd_stroke_cens_D1.nii.gz

	# take CoV across subjects
	fslmaths $DATA/sd_stroke_cens_D0.nii.gz -div $DATA/mean_stroke_cens_D0.nii.gz $DATA/cov_stroke_cens_D0.nii.gz
	fslmaths $DATA/sd_stroke_cens_D1.nii.gz -div $DATA/mean_stroke_cens_D1.nii.gz $DATA/cov_stroke_cens_D1.nii.gz

# for ALL subjects
# no censoring
		# merge
fslmerge -t $DATA/merge_all_nocens_D0.nii.gz $DATA/merge_control_nocens_D0.nii.gz $DATA/merge_stroke_nocens_D0.nii.gz 
fslmerge -t $DATA/merge_all_nocens_D1.nii.gz $DATA/merge_control_nocens_D1.nii.gz $DATA/merge_stroke_nocens_D1.nii.gz 

		# mean
fslmaths  $DATA/merge_all_nocens_D0.nii.gz -Tmean  $DATA/mean_all_nocens_D0.nii.gz
fslmaths  $DATA/merge_all_nocens_D1.nii.gz -Tmean  $DATA/mean_all_nocens_D1.nii.gz

		# SD
fslmaths  $DATA/merge_all_nocens_D0.nii.gz -Tstd  $DATA/sd_all_nocens_D0.nii.gz
fslmaths  $DATA/merge_all_nocens_D1.nii.gz -Tstd  $DATA/sd_all_nocens_D1.nii.gz

		# CoV
fslmaths $DATA/sd_all_nocens_D0.nii.gz -div $DATA/mean_all_nocens_D0.nii.gz $DATA/cov_all_nocens_D0.nii.gz
fslmaths $DATA/sd_all_nocens_D1.nii.gz -div $DATA/mean_all_nocens_D1.nii.gz $DATA/cov_all_nocens_D1.nii.gz
	
# censoring
		# merge
fslmerge -t $DATA/merge_all_cens_D0.nii.gz $DATA/merge_control_cens_D0.nii.gz $DATA/merge_stroke_cens_D0.nii.gz 
fslmerge -t $DATA/merge_all_cens_D1.nii.gz $DATA/merge_control_cens_D1.nii.gz $DATA/merge_stroke_cens_D1.nii.gz 

		# mean
fslmaths  $DATA/merge_all_cens_D0.nii.gz -Tmean  $DATA/mean_all_cens_D0.nii.gz
fslmaths  $DATA/merge_all_cens_D1.nii.gz -Tmean  $DATA/mean_all_cens_D1.nii.gz

		# SD
fslmaths  $DATA/merge_all_cens_D0.nii.gz -Tstd  $DATA/sd_all_cens_D0.nii.gz
fslmaths  $DATA/merge_all_cens_D1.nii.gz -Tstd  $DATA/sd_all_cens_D1.nii.gz

		# CoV
fslmaths $DATA/sd_all_cens_D0.nii.gz -div $DATA/mean_all_cens_D0.nii.gz $DATA/cov_all_cens_D0.nii.gz
fslmaths $DATA/sd_all_cens_D1.nii.gz -div $DATA/mean_all_cens_D1.nii.gz $DATA/cov_all_cens_D1.nii.gz
	

# extract BD values

	# loop through mean BD maps
for i in mean_control_nocens_D0.nii.gz mean_control_nocens_D1.nii.gz mean_control_cens_D0.nii.gz mean_control_cens_D1.nii.gz mean_stroke_nocens_D0.nii.gz mean_stroke_nocens_D1.nii.gz mean_stroke_cens_D0.nii.gz mean_stroke_cens_D1.nii.gz
do 
	# loop through VTs
		for v in rmca raca rpca lmca laca lpca
		
			do
			echo $i $v
			# Extract BD values (mean across subjects) from each vascular territory
				# differences
			fslmeants -i $DATA/$i -o $DATA/${i}_${v}_vals.txt -m $VT/vt_${v}.nii.gz --transpose --showall
	
			
			done 
done
