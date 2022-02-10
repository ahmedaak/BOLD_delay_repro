#!/usr/bin/env bash

# This script registers time shift analysis maps to template space for the BOLD delay reproducibility project
# Written by Ahmed Khalil, 09.11.2018

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO

# working directory
DATA=$MAIN_DIR/IMAGES

# EPI template
EPI=$MAIN_DIR/ANALYSIS/TEMPLATES/AK_103_EPI_template_brain.nii.gz

# loop through subjects

for i in `cat $MAIN_DIR/subjects_all.txt` 

	do

	# loop through sessions
	for x in D0 D1
		
		do
		echo $i $x


		# Register TSA maps to EPI template space
		antsApplyTransforms -d 3 -i $DATA/$i/$x/TSA/rt_lagtimes.nii.gz -r $EPI -t $DATA/$i/$x/ANTS/rest_1InverseWarp.nii.gz -t [ $DATA/$i/$x/ANTS/rest_0GenericAffine.mat, 1] -o $DATA/$i/$x/ANTS/TSA_norm.nii.gz
		
		antsApplyTransforms -d 3 -i $DATA/$i/$x/TSA_C/rt_c_lagtimes.nii.gz -r $EPI -t $DATA/$i/$x/ANTS/rest_1InverseWarp.nii.gz -t [ $DATA/$i/$x/ANTS/rest_0GenericAffine.mat, 1] -o $DATA/$i/$x/ANTS/TSA_cens_norm.nii.gz


	done
done
