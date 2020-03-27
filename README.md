# Analysis pipeline for "BOLD delay reproducibility" study 

Authors:

- Ahmed Khalil, MD PhD – Center for Stroke Research Berlin, Charité Universitaetsmedizin Berlin

## Background

The pipeline consists of several bash + R scripts that performs various processing steps on resting-state fMRI data. 

## Directory structure

Before processing, the data should be structured as follows:


		
## Details of the pipeline

The pipeline consists of the following scripts:

FOR IMAGE PROCESSING:

- 1_preprocessing.sh: performs basic preprocessing on resting-state fMRI data 
- 1b_fd_binarize.R: takes in framewise displacement files and binarizes them according to a threshold (for motion censoring)
- 2_tsa.sh: performs time shift analysis (i.e. calculates BOLD delay) on preprocessed resting-state fMRI data 
- 3_registration.sh: registered BOLD delay maps + resting-state fMRI data to a custom EPI template
- 4_extract_values.sh: calculates absolute differences between two BOLD delay maps (from two scanning sessions) from the same individual and extracts these differences as well as the BOLD delay values themselves
- 5_gethm_mean.R: calculates the average head motion across two scanning sessions
- 6_plot_BD_vals.R: plots the BOLD delay values within different vascular territories (averaged across subjects) for both scanning sessions

FOR VISUALIZATION / STATISTICAL ANALYSIS: 

- BD_maps.sh: creates BOLD delay maps, averaged across subjects, for both scanning sessions
- change_maps.sh: creates maps of absolute change in BD values over time, averaged across subjects 
- BD_repro_stats_viz_20200205.Rmd: builds mixed model dataframe (if it doesn't already exist), plots and outputs descriptive statistics, tests mixed model assumptions and outputs mixed model results