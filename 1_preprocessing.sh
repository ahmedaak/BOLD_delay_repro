# This script performs basic preprocessing on resting-state fMRI data 
# Used in the "BOLD delay reproducibility" study
# Written by Ahmed Khalil, MD PhD 

MAIN_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO
SUBJECTS_DIR=~/CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES #path of the datasets

for i in `cat $MAIN_DIR/subjects_all.txt`
do   

  echo "Preprocessing subject: ${i} ..."

		for x in D0 D1
				do 
					cd ${SUBJECTS_DIR}/${i}/${x}
 			
			  ## 1. Dropping TRs (~10 seconds, # of volumes depends on TR)
				if [[ $i = sub0* ]]
					then 
					TR_drop=0 # for the stroke patients, 25 TRs have already been dropped
				elif [[ $i = C* ]]
					then
					TR_drop=25
				elif [[ $i = sub-control* ]]
					then
					TR_drop=6
				elif [[ $i = msc* ]]
					then
					TR_drop=5
				elif [[ $i = sub-cont?? ]]
					then
					TR_drop=5
				elif [[ $i = sub_?? ]]
					then
					TR_drop=3
				elif [[ $i = sub-?????? ]]
					then
					TR_drop=10
				fi
				
				
			  3dcalc -a rest.nii.gz[$TR_drop..$] -expr 'a' -prefix rest.tr.nii 

			  ##2. Deoblique
			  3drefit -deoblique rest.tr.nii

			  ## Reorient into fsl friendly space (what AFNI calls RPI)
			  3dresample -orient RPI -inset rest.tr.nii -prefix rest.ro.nii

			  ##4. Motion correct to average of timeseries
			  3dTstat -mean -prefix rest.ro.mean.nii rest.ro.nii
			  3dvolreg -Fourier -twopass -base rest.ro.mean.nii -zpad 4 -prefix rest.mc.nii -1Dfile rest.mc.1D -maxdisp1D rest.maxdisp.1D rest.ro.nii

			  ##5. Remove skull/edge detect
			  3dAutomask -prefix rest.ro.mask.nii -dilate 1 rest.mc.nii
			  3dcalc -a rest.mc.nii -b rest.ro.mask.nii -expr 'a*b' -prefix rest.st.nii 

			  ##6. Get example image for use in registration
			  fsl5.0-fslroi rest.st.nii example_func 1 1

			  ##7. Spatial smoothing
			  sigma=$(echo "scale=10;6/2.3548" | bc)
			  fsl5.0-fslmaths rest.st.nii -kernel gauss ${sigma} -fmean -mas rest.ro.mask.nii rest.ss.nii 

			  ##8. Grandmean scaling
			  fsl5.0-fslmaths rest.ss.nii -ing 10000 rest.gin.nii -odt float

			  ##9. Temporal filtering
			  3dFourier -lowpass 0.15 -highpass 0.01 -retrend -prefix rest.tf.nii rest.gin.nii.gz 

			  ##10.Detrending: Removing linear and quadratic trends
			  3dTstat -mean -prefix rest.dt.mean.nii rest.tf.nii 
			  3dDetrend -polort 2 -prefix rest.dt.nii rest.tf.nii
			  fsl5.0-fslmaths rest.dt.nii -add rest.dt.mean rest.pp.nii

			  ##11.Create Mask
			  fsl5.0-fslmaths rest.pp.nii -Tmin -bin rest.mask.nii -odt char

			  ##12. save 6 head motion parameters
			  awk '{print $1}' rest.mc.1D > rest.mc1.1D
			  awk '{print $2}' rest.mc.1D > rest.mc2.1D
			  awk '{print $3}' rest.mc.1D > rest.mc3.1D
			  awk '{print $4}' rest.mc.1D > rest.mc4.1D
			  awk '{print $5}' rest.mc.1D > rest.mc5.1D
			  awk '{print $6}' rest.mc.1D > rest.mc6.1D
			  
			  ##13. calculate and save framewise displacement
			  fsl_motion_outliers -i rest.nii.gz -o fd_conf -s fd.txt --fd --dummy=$TR_drop
		done

  cd ${SUBJECTS_DIR}
done
echo "Finito!"

