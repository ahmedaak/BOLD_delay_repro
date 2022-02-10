#!/usr/bin/env bash

# This script calculates temporal SNR (tSNR) for the BOLD delay reproducibility project
# Written by Ahmed Khalil, 01.03.2021

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO

# working directory
DATA=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES
OUTPUT=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/BD_VALS

# EPI template
EPI=$MAIN_DIR/ANALYSIS/TEMPLATES/AK_103_EPI_template_brain.nii.gz


# CALCULATE tSNR of EPI data
# loop through subjects
for i in `cat $MAIN_DIR/subjects_all.txt`  

do echo $i

		3dTstat -prefix $DATA/$i/tSNR_D0.nii -tsnr $DATA/$i/D0/rest.gin.nii.gz
		3dTstat -prefix $DATA/$i/tSNR_D1.nii -tsnr $DATA/$i/D1/rest.gin.nii.gz
		 

# REGISTER tSNR MAPS TO TEMPLATE SPACE
antsApplyTransforms -d 3 -i $DATA/$i/tSNR_D0.nii -r $EPI -t $DATA/$i/D0/ANTS/rest_1InverseWarp.nii.gz -t [ $DATA/$i/D0/ANTS/rest_0GenericAffine.mat, 1] -o $DATA/$i/tSNR_D0_norm.nii.gz
antsApplyTransforms -d 3 -i $DATA/$i/tSNR_D1.nii -r $EPI -t $DATA/$i/D1/ANTS/rest_1InverseWarp.nii.gz -t [ $DATA/$i/D1/ANTS/rest_0GenericAffine.mat, 1] -o $DATA/$i/tSNR_D1_norm.nii.gz
done

# GET MAPS OF MEAN tSNR FOR EACH STUDY
cd $DATA
for s in csb modafinil mpi stroke msc nf tbi yale

do echo $s
	# concatenate all tSNR maps to 4D image
	fslmerge -t $OUTPUT/merge_tSNR_${s}.nii.gz $(cat ${MAIN_DIR}/ANALYSIS/tSNR_${s}.txt)

	# take mean across subjects
	fslmaths $OUTPUT/merge_tSNR_${s}.nii.gz -Tmean $OUTPUT/mean_tSNR_${s}.nii.gz
	
	done 