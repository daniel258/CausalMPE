##########################################################################################
## CausalMPE project
### illustration of the proposed sensitivity analysis for SSACE in the paper:
# Causal inference considerations for molecular pathological epidemiology
##########################################################################################

### Preform the proposed sensitivity analysis for the simulated dataset created in
# HypoDataSensSSACE.R
library(sandwich) # For robust standard errors
library("scatterplot3d") # For 3D figure
library(dplyr)
##########################################################################################
# A function that carries out the sensitivity analysis suggested in the paper: 
# Check also SensFun.R
SensFun <- function(coef1, coef2, eta1, eta2, coef.covmat)
{
  RR1 <- exp(coef1)
  RR2 <- exp(coef2)
  point1 <- RR1 * eta1 
  point2 <- RR2 * eta2
  point.diff <- point1 - point2
  my.sd <- sqrt(c(point1, -point2)%*%coef.covmat%*%c(point1, -point2))
  ci.l <- point.diff - 1.96 * my.sd
  ci.h <- point.diff + 1.96 *my.sd
  return(list(RR1.sens = point1, RR2.sens = point2, RR.diff = point.diff, CIsens = c(ci.l, ci.h)))
}
###################################################################################
# Load data
my.data <- read.table("my.sim.data.csv")
n.sample <- nrow(my.data)
###################################################################################
# Fit a logistic regression model for the propensity score
fit.ps <- glm(aspirin~ family + pkyr  + bmi, data = my.data, family = "binomial")
summary(fit.ps)
ps <- predict(fit.ps, type = "response")
##########################################################################################
#### Use the proposed data-duplication method to get the covariance matrix.
# Because it is
# The idea is that each participant should appear twice: once for subtype 1 and once for subtype 2.
# Controls are controls for both subtype 1 and subtype 2, while subtype 1 is a case for subtpye 1
# and a control for subtype 2. Similarly for subtpye 2
#####################
# Create duplicated data set
my.dupl.data  <- rbind(my.data, my.data)
my.dupl.data$S1 <- rep(1:0, each = n.sample)
my.dupl.data$S2 <- rep(0:1, each = n.sample)
my.dupl.data$Y.dupl <- ifelse(my.dupl.data$S1==1, my.dupl.data$Y==1, my.dupl.data$Y==2)
my.dupl.data$asp_1 <- my.dupl.data$aspirin * my.dupl.data$S1
my.dupl.data$asp_2 <- my.dupl.data$aspirin * my.dupl.data$S2
fit.logistic.dupl <- glm(Y.dupl ~ S1 + S2 + asp_1 + asp_2 - 1, family = "binomial", data = my.dupl.data)
# Set weights according to the estimated PS and aspirin status 
pr.asp <- mean(my.data$aspirin==1)
wi <- ifelse(my.dupl.data$aspirin==1, pr.asp/ps, (1 - pr.asp)/(1 - ps))
summary(wi)
# Fit the proposed duplication method logistic regression with weights
fit.dupl.w <- glm(Y.dupl ~ S1 + S2 + asp_1 + asp_2 - 1, data = my.dupl.data, family = "binomial", 
                 weights = wi)
# Ignore the warning it is due to the use of weights
# Variance estimation by the sandwich estimator
vcov.sand <- sandwich(fit.dupl.w)
fit.dupl.w
##########################################################################################
##### Calculate naive point estimates and confidence intervals ####
point1.est <- exp(coef(fit.dupl.w)[3])
point2.est <- exp(coef(fit.dupl.w)[4])
point1.est # Naive RR1
point2.est # Naive RR2
point1.ci <- exp(coef(fit.dupl.w)[3]+ c(-1, 1)* 1.96 * sqrt(vcov.sand[3, 3]))
point2.ci <- exp(coef(fit.dupl.w)[4]+ c(-1, 1)* 1.96 * sqrt(vcov.sand[4, 4]))
point1.ci # CI for Naive RR1
point2.ci # CI for Naive RR1

point.est <- unname(point1.est - point2.est)
point.est # Naive RR1 - Naive RR2

# SE by the delta method
my.sd <- sqrt(c(point1.est, -point2.est)%*%vcov.sand[3:4, 3:4]%*%c(point1.est, -point2.est))
c(point.est -   1.96 * my.sd, point.est +   1.96 * my.sd) # These numbers went into the paper
point.est # CI for Naive RR1 - Naive RR2
##########################################################################################
## Finally, the sensitivity analysis - for each combination of values for eta1 and eta2 between 0.5 and 2
my.etas1 <- my.etas2 <-  seq(0.7, 1/0.7, 0.1)
n.etas1 <- length(my.etas1)
n.etas2 <- length(my.etas2)
SACE.sens <- matrix(nr = n.etas1 * n.etas2, nc = 5)
SACE.sens[, 1] <- rep(my.etas1, each = n.etas2)
SACE.sens[, 2] <- rep(my.etas2, n.etas1)
# Apply SensFun for each unique combination
for (i in 1:(n.etas1 * n.etas2))
{
  SACE.sens.temp <- SensFun(coef1 = coef(fit.dupl.w)[3], coef2 = coef(fit.dupl.w)[4], 
                            eta1 = SACE.sens[i, 1], eta2 = SACE.sens[i, 2], 
                            coef.covmat = vcov.sand[3:4, 3:4])
  SACE.sens[i, 3] <- SACE.sens.temp$RR.diff %>% round(2)
  SACE.sens[i, 4:5] <- SACE.sens.temp$CIsens %>% round(2)
}
SACE.sens <- as.data.frame(SACE.sens)
colnames(SACE.sens) <- c("eta1", "eta2", "RR_Diff", "RR_CI_L", "RR_CI_H")
##########################################################################################
## Check if the value zero falls within the CI for  SSACE RR1 - SSACE RR2
CI.in <- apply(SACE.sens[, 4:5], 1, function(A) {findInterval(0, A)})
SACE.sens$out <- CI.in!=1
##########################################################################################
# Create a figure similar to Figure 4 in the paper
SACE.sens$out.ci <- ifelse(SACE.sens$out==0,  "0 is not included in the CI", "0 included in the CI")
colors <- c("#999999", "#56B4E9")
colors <- colors[SACE.sens$out+1]
shapes = c(16, 17) 
shapes <- shapes[SACE.sens$out+1]
scatterplot3d(SACE.sens[, 1:3], pch = shapes, color = colors, box=FALSE, cex.lab=1.5, cex.axis = 1.15,
              xlab=expression(eta[1]), ylab="", zlab="SACE RR Difference", zlim = c(-0.8, 1.2))
legend("topright", legend = c("Zero is in the CI for the RR difference", 
                              "Zero is not in the CI for the RR difference"), 
       pch = c(16, 17), col = c("#999999", "#56B4E9"))
text(x = 5.5, y = -4, expression(eta[2]), srt = 45, cex = 1.8)
