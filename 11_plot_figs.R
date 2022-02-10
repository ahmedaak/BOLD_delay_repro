# This script plots images for the BOLD delay reproducibility project
# Written by Ahmed Khalil on 9.3.2021

# define data directory
data_dir <- "S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/BD_VALS/"

# load necessary packages
library(oro.nifti)
library(colorspace)
library(neurobase)
library(RColorBrewer)
library(heatmaply)

# define colormaps
jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
fire.colors <- colorRampPalette(c("#000000","#120056","#32009f","#6500d7","#8d00be","#ae0291","#c60854","#de2c23","#f25600","#fb7a00","#ff9900","#ffb700","#ffd400","#ffec33","#ffff90"))

# loop through studies 
for (s in c("tbi", "csb", "modafinil", "mpi", "msc", "nf", "yale", "stroke","all")) {
  if (s == "all") {
    window_range <- c(-0.3,0.3)
  }
  else {
    window_range <- c(-1,1)
  }
# MEAN BD DIFFERENCES ACROSS SUBJECTS
  for (c in c("cens","nocens")) {
# read in NIFTI files
  bd_diff <- readNIfTI(paste(data_dir,"mean_",s,"_",c,".nii.gz",sep=""))
# plot and save NIFTI file
png(paste(data_dir,"mean_",s,"_",c,"_mosaic.png",sep=""))
oro.nifti::slice(bd_diff, z = seq(20,65,2),col=cool_warm(500),bg="#DCDDDD",zlim=window_range)
dev.off()
  }
# MEAN tSNR ACROSS SUBJECTS
  tsnr <- readNIfTI(paste(data_dir,"mean_tSNR_",s,".nii.gz",sep=""))
  # plot and save NIFTI file
  png(paste(data_dir,"mean_tSNR_",s,"_mosaic.png",sep=""))
  oro.nifti::slice(tsnr, z = seq(20,65,2),col=fire.colors(15),bg="black",zlim=c(0,300))
  dev.off()  
}
