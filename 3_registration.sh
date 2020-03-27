#!/usr/bin/env bash

# This script registers time shift analysis maps to template space for the BOLD delay reproducibility project
# Written by Ahmed Khalil, 09.11.2018

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO

# working directory
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES

# EPI template
EPI=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/ANALYSIS/TEMPLATES/AK_103_EPI_template_brain.nii.gz

# loop through subjects

for i in `cat $MAIN_DIR/subjects_all.txt` 

	do

	# loop through sessions
	for x in D0 D1
		
		do
		echo $i $x

		# Register RS data to EPI template space
		antsRegistrationSyN.sh -d 3 -m $DATA/$i/$x/example_func.nii.gz -f $EPI -o $DATA/$i/$x/ANTS/rs2epi_

		# Register TSA maps to EPI template space
		antsApplyTransforms -d 3 -i $DATA/$i/$x/TSA/rt_lagtimes.nii.gz -r $EPI -t $DATA/$i/$x/ANTS/rs2epi_1Warp.nii.gz -t $DATA/$i/$x/ANTS/rs2epi_0GenericAffine.mat -o $DATA/$i/$x/ANTS/TSA_norm.nii.gz
		antsApplyTransforms -d 3 -i $DATA/$i/$x/TSA_C/rt_c_lagtimes.nii.gz -r $EPI -t $DATA/$i/$x/ANTS/rs2epi_1Warp.nii.gz -t $DATA/$i/$x/ANTS/rs2epi_0GenericAffine.mat -o $DATA/$i/$x/ANTS/TSA_cens_norm.nii.gz


	done
done
