# this script calculates the average head motion across two scanning sessions for the BD reproducibility project
# Written by Ahmed Khalil

library(epiR)

# loop through subjects
subs <- list.files(path= "S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES/", full.names = F, recursive = F)
FD_mean_all <- c()
FD_D0_all <- c()
FD_D1_all <- c()

for(i in subs) {
  
  # read first session framewise displacement file
  FD_0 <- read.table(file = paste("S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES/",i,"/D0/fd.txt", sep=""), header = F)
  # read second session framewise displacement file
  FD_1 <- read.table(file = paste("S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/IMAGES/",i,"/D1/fd.txt", sep=""), header = F)
  # get mean of both
  FD_D0 <- mean(FD_0$V1)
  FD_D1 <- mean(FD_1$V1)
  FD_mean <- (FD_D0 + FD_D1)/2
  
  FD_D0_all <- c(FD_D0_all, FD_D0)
  FD_D1_all <- c(FD_D1_all, FD_D1)
  FD_mean_all <- c(FD_mean_all, FD_mean)
  
  
}
# write mean FD values to text file
write.table(FD_mean_all, file = "S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/fd_mean.txt", row.names = F, col.names = "FD_mean")

# calculate ICC of HM metrics between scanning sessions
agr_hm <- epi.ccc(FD_D0_all, FD_D1_all)
print(paste("The correlation between mean FD on D0 and D1 is r =", round(cor(FD_D0_all, FD_D1_all),3), "| The agreement is ICC =", round(agr_hm$rho.c[1],3)))