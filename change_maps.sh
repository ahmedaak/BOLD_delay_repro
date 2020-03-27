#!/bin/bash

# This script creates maps of absolute change in BD values over time, averaged across subjects
# Used in the "BOLD delay reproducibility" study
# Written by Ahmed Khalil, MD PhD 

cd /home/khalila/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES/

## for controls - no censoring
# concatenate all difference maps to 4D image
fslmerge -t merge_control_nocens.nii.gz $(cat ../ANALYSIS/TSA_diff_list_controls.txt)
# get absolute values of differences
fslmaths merge_control_nocens.nii.gz -abs merge_control_nocens_abs.nii.gz
# take mean across subjects
fslmaths merge_control_nocens_abs.nii.gz -Tmean mean_control_nocens_abs.nii.gz

## for controls - censoring
# concatenate all difference maps to 4D image
fslmerge -t merge_control_cens.nii.gz $(cat ../ANALYSIS/TSA_cens_diff_list_controls.txt)
# get absolute values of differences
fslmaths merge_control_cens.nii.gz -abs merge_control_cens_abs.nii.gz
# take mean across subjects
fslmaths merge_control_cens_abs.nii.gz -Tmean mean_control_cens_abs.nii.gz


## for stroke patients - no censoring
fslmerge -t merge_stroke_nocens.nii.gz $(cat ../ANALYSIS/TSA_diff_list_stroke.txt)
# get absolute values of differences
fslmaths merge_stroke_nocens.nii.gz -abs merge_stroke_nocens_abs.nii.gz
# take mean across subjects
fslmaths merge_stroke_nocens_abs.nii.gz -Tmean mean_stroke_nocens_abs.nii.gz

## for stroke patients - censoring
fslmerge -t merge_stroke_cens.nii.gz $(cat ../ANALYSIS/TSA_cens_diff_list_stroke.txt)
# get absolute values of differences
fslmaths merge_stroke_cens.nii.gz -abs merge_stroke_cens_abs.nii.gz
# take mean across subjects
fslmaths merge_stroke_cens_abs.nii.gz -Tmean mean_stroke_cens_abs.nii.gz
