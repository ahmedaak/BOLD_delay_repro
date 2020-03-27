# This script takes in files of framewise displacement and binarizes them according to a threshold (for motion censoring)
# Written by Ahmed Khalil, 02.11.2018


setwd("S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES")
# loop through subjects

for (i in list.dirs(full.names = TRUE, recursive = F)) {
  # loop through sessions
  for (d in c("D0","D1")){
    # read in FD text files
    print(paste(i, d, sep=" "))
    FD <- read.csv(file=paste(i,d,"fd.txt", sep = "/"), header = F)
    FD <- FD$V1
    # set FD threshold
    FD_thresh <- 0.3
    # binarize FD values 
    FD_bin <- replace(FD, FD>FD_thresh, 1000)
    FD_bin <- replace(FD_bin, FD<FD_thresh, 1)
    FD_bin <- replace(FD_bin, FD_bin==1000, 0)
    # write binarized FD text file
    write.table(as.numeric(FD_bin), file = paste(i,d,"fd_bin.txt", sep = "/"), row.names = F, col.names = F)
    
    # create and save motion plots
    png(filename = paste(i,d,"fd_plot.png", sep = "/"), width=8, height=4, units="in", res=600)
    plot(c(1:length(FD)),FD, type="l", lwd=1, ylab="Framewise displacement (mm)", xlab="Volumes", col="red")
    lines(c(1:length(FD)),FD*FD_bin, col="black")
    abline(h=0.3, lty=2)
          # find a way to get TR automatically, then use this instead (time on x axis):
          #plot(c(1:length(FD))*TR,FD, type="l", lwd=1, ylab="Framewise displacement (mm)")
    # add mean + max FD, % censored to plot
    mtext(paste("Max FD=", round(max(FD),2), ", Mean FD=", round(mean(FD),2), ", % censored=", round(sum(!FD_bin)/length(FD_bin)*100,1)), side = 3)
    
    dev.off()
  }
  
  
}