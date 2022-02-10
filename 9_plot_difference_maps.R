# This script makes figures of maps of BOLD delay differences over time
# Written by Ahmed Khalil

# load necessary packages
library(oro.nifti)
library(neurobase)
library(RColorBrewer)
library(png)

# define colormaps
#jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))

for(m in c("csb","stroke","msc","nf","modafinil","yale","tbi","mpi","all")) {
  for(c in c("cens","nocens")) {
  map <- readNIfTI(paste("../mean",m,c,"abs.nii.gz", sep="_"))
  png(filename = paste("../mean",m,c,"fig.png",sep = "_"))
  slice(map, z = c(15,22,29,36,42,49,56,63,70), col = tim.colors(30), zlim = c(0,7), bg = "#00008F")
  dev.off()
  
  map <- readNIfTI(paste("../mean_CoR_",m,"_",c,".nii.gz", sep = ""))
  png(filename = paste("../mean_CoR",m,c,"fig.png",sep = "_"))
  slice(map, z = c(15,22,29,36,42,49,56,63,70), col = tim.colors(30), zlim = c(0,15), bg = "#00008F")
  dev.off()
  }
}