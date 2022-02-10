#!/usr/bin/env bash

# This script performs time shift analysis on BOLD resting state data for the BOLD delay reproducibility project
# Written by Ahmed Khalil, 02.11.2018

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO

# working directory
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES

# EPI template
EPI=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/ANALYSIS/TEMPLATES/AK_103_EPI_template_brain.nii.gz

# venous sinus template
VS=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/ANALYSIS/TEMPLATES/venous_sinus_template.nii.gz

# loop through subjects

for i in `cat $MAIN_DIR/subjects_all.txt`
	do

	# loop through sessions
	for x in D0 D1
		
		do
		echo $i $x

		# Create registration (ANTS) folder
		mkdir $DATA/$i/$x/ANTS

		# Register EPI template to native RS space
		antsRegistrationSyN.sh -d 3 -m $EPI -f $DATA/$i/$x/example_func.nii.gz -o $DATA/$i/$x/ANTS/rest_
	
		# Register VS template to native RS space
		antsApplyTransforms -d 3 -i $VS -r $DATA/$i/$x/example_func.nii.gz -o $DATA/$i/$x/ANTS/vs_reg.nii.gz -t $DATA/$i/$x/ANTS/rest_0GenericAffine.mat -t $DATA/$i/$x/ANTS/rest_1Warp.nii.gz

		# Extract venous sinus signal from RS data in native space using VS in native space
		fslmeants -i $DATA/$i/$x/rest.pp.nii.gz -m $DATA/$i/$x/ANTS/vs_reg.nii.gz -o $DATA/$i/$x/vs_tc.txt

		# Create TSA (rapidtide) folder - WITHOUT motion censoring
		mkdir $DATA/$i/$x/TSA

		# Perform TSA with rapidtide - WITHOUT motion censoring
		rapidtide2 $DATA/$i/$x/rest.gin.nii.gz $DATA/$i/$x/TSA/rt -L -r -5,5 --limitoutput --multiproc --noglm --regressor=$DATA/$i/$x/vs_tc.txt;

		# Create TSA (rapidtide) folder - WITH motion censoring
		mkdir $DATA/$i/$x/TSA_C

		# Perform TSA with rapidtide - WITH motion censoring
		rapidtide2 $DATA/$i/$x/rest.gin.nii.gz $DATA/$i/$x/TSA_C/rt_c -L -r -5,5 --limitoutput --multiproc --noglm --regressor=$DATA/$i/$x/vs_tc.txt --tmask=$DATA/$i/$x/fd_bin.txt;

	done
done
