# This script plots the BOLD delay values from different vascular territories (averaged across subjects) across time (D0 + D1)
# Written by Ahmed Khalil

# define paths
data_path <- c("S:/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/BD_REPRO/BD_VALS/")
data_files <- list.files(path = data_path, pattern = "*.txt")

data_values_all <- c()

for (i in data_files){
  print(i)
  data_values_vt <- read.csv(file = paste(data_path, i, sep = ""), header = FALSE, sep = "")
  data_values_vt <- data_values_vt$V4
  
  data_values_all <- cbind(data_values_all, data_values_vt)
}
 
colnames(data_values_all) <- data_files
data_values_all <- as.data.frame(data_values_all)

# plotting options
line_width = 1.5
col_d0 = "blue"
col_d1 = "red"
x_label = "BOLD delay (s)"
font_size = "1.5"
y_limits = c(0,2)
x_limits = c(-2, 2)

pdf(file = paste(data_path, "density_plots.pdf"), width=12, height=5)
par(mfrow=c(2,6))
# plot BD values in PCA for controls without censoring
pca_cont_nocens_D0 <- density(rbind(data_values_all$mean_control_nocens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_lpca_vals.txt))
plot(pca_cont_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "PCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits) 
pca_cont_nocens_D1 <- density(rbind(data_values_all$mean_control_nocens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_lpca_vals.txt))
lines(pca_cont_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in ACA for controls without censoring
aca_cont_nocens_D0 <- density(rbind(data_values_all$mean_control_nocens_D0.nii.gz_raca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_laca_vals.txt))
plot(aca_cont_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "ACA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
aca_cont_nocens_D1 <- density(rbind(data_values_all$mean_control_nocens_D1.nii.gz_raca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_laca_vals.txt))
lines(aca_cont_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in MCA for controls without censoring
mca_cont_nocens_D0 <- density(rbind(data_values_all$mean_control_nocens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_lmca_vals.txt))
plot(mca_cont_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "MCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
mca_cont_nocens_D1 <- density(rbind(data_values_all$mean_control_nocens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_lmca_vals.txt))
lines(mca_cont_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in PCA for controls with censoring
pca_cont_cens_D0 <- density(rbind(data_values_all$mean_control_cens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_lpca_vals.txt))
plot(pca_cont_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "PCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
pca_cont_cens_D1 <- density(rbind(data_values_all$mean_control_cens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_lpca_vals.txt))
lines(pca_cont_cens_D1, col = col_d1, lwd = line_width)

# plot BD values in ACA for controls with censoring
aca_cont_cens_D0 <- density(rbind(data_values_all$mean_control_cens_D0.nii.gz_raca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_laca_vals.txt))
plot(aca_cont_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "ACA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
aca_cont_cens_D1 <- density(rbind(data_values_all$mean_control_cens_D1.nii.gz_raca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_laca_vals.txt))
lines(aca_cont_cens_D1, col = col_d1, lwd = line_width)

# plot BD values in MCA for controls with censoring
mca_cont_cens_D0 <- density(rbind(data_values_all$mean_control_cens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_lmca_vals.txt))
plot(mca_cont_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "MCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
mca_cont_cens_D1 <- density(rbind(data_values_all$mean_control_cens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_lmca_vals.txt))
lines(mca_cont_cens_D1, col = col_d1, lwd = line_width)


#################

# plot BD values in PCA for strokes without censoring
pca_stroke_nocens_D0 <- density(rbind(data_values_all$mean_stroke_nocens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_lpca_vals.txt))
plot(pca_stroke_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "PCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
pca_stroke_nocens_D1 <- density(rbind(data_values_all$mean_stroke_nocens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_lpca_vals.txt))
lines(pca_stroke_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in ACA for strokes without censoring
aca_stroke_nocens_D0 <- density(rbind(data_values_all$mean_stroke_nocens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_laca_vals.txt))
plot(aca_stroke_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "ACA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
aca_stroke_nocens_D1 <- density(rbind(data_values_all$mean_stroke_nocens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_laca_vals.txt))
lines(aca_stroke_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in MCA for strokes without censoring
mca_stroke_nocens_D0 <- density(rbind(data_values_all$mean_stroke_nocens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_lmca_vals.txt))
plot(mca_stroke_nocens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "MCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
mca_stroke_nocens_D1 <- density(rbind(data_values_all$mean_stroke_nocens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_lmca_vals.txt))
lines(mca_stroke_nocens_D1, col = col_d1, lwd = line_width)

# plot BD values in PCA for strokes with censoring
pca_stroke_cens_D0 <- density(rbind(data_values_all$mean_stroke_cens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_lpca_vals.txt))
plot(pca_stroke_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "PCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
pca_stroke_cens_D1 <- density(rbind(data_values_all$mean_stroke_cens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_lpca_vals.txt))
lines(pca_stroke_cens_D1, col = col_d1, lwd = line_width)

# plot BD values in ACA for strokes with censoring
aca_stroke_cens_D0 <- density(rbind(data_values_all$mean_stroke_cens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_laca_vals.txt))
plot(aca_stroke_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "ACA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
aca_stroke_cens_D1 <- density(rbind(data_values_all$mean_stroke_cens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_laca_vals.txt))
lines(aca_stroke_cens_D1, col = col_d1, lwd = line_width)

# plot BD values in MCA for strokes with censoring
mca_stroke_cens_D0 <- density(rbind(data_values_all$mean_stroke_cens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_lmca_vals.txt))
plot(mca_stroke_cens_D0, col = col_d0, lwd = line_width, xlab = x_label, main = "MCA", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits)
mca_stroke_cens_D1 <- density(rbind(data_values_all$mean_stroke_cens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_lmca_vals.txt))
lines(mca_stroke_cens_D1, col = col_d1, lwd = line_width)
dev.off()


pdf(file = paste(data_path, "density_plots_2.pdf"), width=7, height=7)
par(mfrow=c(2,2))

# organize data
pca_d0_nocens <- rbind(data_values_all$mean_control_nocens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_lpca_vals.txt)
pca_d1_nocens <- rbind(data_values_all$mean_control_nocens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_lpca_vals.txt)

mca_d0_nocens <- rbind(data_values_all$mean_control_nocens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_lmca_vals.txt)
mca_d1_nocens <- rbind(data_values_all$mean_control_nocens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_lmca_vals.txt)

aca_d0_nocens <- rbind(data_values_all$mean_control_nocens_D0.nii.gz_raca_vals.txt, data_values_all$mean_control_nocens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D0.nii.gz_laca_vals.txt)
aca_d1_nocens <- rbind(data_values_all$mean_control_nocens_D1.nii.gz_raca_vals.txt, data_values_all$mean_control_nocens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_nocens_D1.nii.gz_laca_vals.txt)

pca_d0_cens <- rbind(data_values_all$mean_control_cens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_lpca_vals.txt)
pca_d1_cens <- rbind(data_values_all$mean_control_cens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_rpca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_lpca_vals.txt)

mca_d0_cens <- rbind(data_values_all$mean_control_cens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_lmca_vals.txt)
mca_d1_cens <- rbind(data_values_all$mean_control_cens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_rmca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_lmca_vals.txt)

aca_d0_cens <- rbind(data_values_all$mean_control_cens_D0.nii.gz_raca_vals.txt, data_values_all$mean_control_cens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D0.nii.gz_laca_vals.txt)
aca_d1_cens <- rbind(data_values_all$mean_control_cens_D1.nii.gz_raca_vals.txt, data_values_all$mean_control_cens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_raca_vals.txt, data_values_all$mean_stroke_cens_D1.nii.gz_laca_vals.txt)

# plot BD values without censoring
plot(density(pca_d0_nocens), col = "#7570b3", lwd = line_width, xlab = x_label, main = "Session 1", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits) 
lines(density(mca_d0_nocens), col = "#d95f02", lwd = line_width)
lines(density(aca_d0_nocens), col = "#1b9e77", lwd = line_width)

plot(density(pca_d1_nocens), col = "#7570b3", lwd = line_width, xlab = x_label, main = "Session 2", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits) 
lines(density(mca_d1_nocens), col = "#d95f02", lwd = line_width)
lines(density(aca_d1_nocens), col = "#1b9e77", lwd = line_width)

# plot BD values with censoring
plot(density(pca_d0_cens), col = "#7570b3", lwd = line_width, xlab = x_label, main = "Session 1", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits) 
lines(density(mca_d0_cens), col = "#d95f02", lwd = line_width)
lines(density(aca_d0_cens), col = "#1b9e77", lwd = line_width)

plot(density(pca_d1_cens), col = "#7570b3", lwd = line_width, xlab = x_label, main = "Session 2", cex.lab=font_size, cex.axis=font_size, cex.main=font_size, ylim = y_limits, xlim = x_limits) 
lines(density(mca_d1_cens), col = "#d95f02", lwd = line_width)
lines(density(aca_d1_cens), col = "#1b9e77", lwd = line_width)
dev.off()