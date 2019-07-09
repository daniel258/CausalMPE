##########################################################################################
## CausalMPE project
### illustration of the proposed senstivity analysis for SSACE in the paper:
# Causal effects in the presence of disease etiologic heterogeneity 
##########################################################################################

### Preform the proposed senstivity analysis for the simulated dataset created in
# HypoDataSensSSACE.R
library(sandwich) # For robust standard errors
library("scatterplot3d") # For 3D figure
##########################################################################################
# A function that carries out the senstivity analysis suggested in the paper
SensFun <- function(coef1, coef2, eta1, eta2, coef.covmat)
{
  RR1 <- exp(coef1)
  RR2 <- exp(coef2)
  point1 <- RR1/eta1 
  point2 <- RR2/eta2
  point.diff <- point1 - point2
  my.sd <- sqrt(c(point1, -point2)%*%coef.covmat%*%c(point1, -point2))
  ci.l <- point.diff - 1.96 * my.sd
  ci.h <- point.diff + 1.96 *my.sd
  return(list(RR1.sens = point1, RR2.sens = point2, RR.diff = point.diff, CIsens = c(ci.l, ci.h)))
}
###################################################################################
# Load data
my.data <- read.table("my.sim.data.csv")
###################################################################################
# Fit a logistic regression model for the propensity score
fit.ps <- glm(aspirin~ family + pkyr  + bmi, data = my.data, family = "binomial")
summary(fit.ps)
ps <- predict(fit.ps, type = "response")
##########################################################################################
#### Use the augmentation method of Wang et al.(Stat Med, 2015, Section 3.3) to fit 
# the multinomial regression model and get standard errors
# The idea is that each control should appear twice: once for subtype 1 and once for subtype 2.
# Then each column that is not constrained to have the same effect has to appear twice.
my.data$type <- 1
my.data$type[my.data$Y==1] <- 1
my.data$type[my.data$Y==2] <- 2
my.data.controls <- my.data %>% filter(Y==0)
my.data.controls$type <- 2 
my.data.aug <- rbind(my.data, my.data.controls)
my.data.aug$asp_1 <- ifelse(my.data.aug$type==1, my.data.aug$aspirin, 0)
my.data.aug$asp_2 <- ifelse(my.data.aug$type==2, my.data.aug$aspirin, 0)
my.data.aug$Y.any <- ifelse(my.data.aug$Y==0, 0, 1) # Y.any is indicator that Y>0
# Set weights according to the estimated PS and aspirin status 
wi <- ifelse(my.data.aug$aspirin==1, 1/ps, 1/(1-ps))
summary(wi)
# Fit the duplication method logistic regression with weights
fit.aug.w <- glm(Y.any ~ asp_1 + asp_2 + factor(type), data = my.data.aug, family = "binomial", 
                 weights = wi)
# Ignore the warning it is due to the use of weights
# Variance estimation by the sandwuch estimator
vcov.sand <- sandwich(fit.aug.w)
fit.aug.w
##########################################################################################
# Calculate naive point estimates and confidence intervals
point1.est <- exp(coef(fit.aug.w)[2])
point2.est <- exp(coef(fit.aug.w)[3])
point1.est # Naive RR1
point2.est # Naive RR2
point1.ci <- exp(coef(fit.aug.w)[2]+ c(-1, 1)* 1.96 * sqrt(vcov.sand[2, 2]))
point2.ci <- exp(coef(fit.aug.w)[3]+ c(-1, 1)* 1.96 * sqrt(vcov.sand[3, 3]))
point1.ci # CI for Naive RR1
point2.ci # CI for Naive RR1
point.est <- point1.est - point2.est
point.est # Naive RR1 - Naive RR2

# SE by the delta method
my.sd <- sqrt(c(point1.est, -point2.est)%*%vcov.sand[2:3, 2:3]%*%c(point1.est, -point2.est))
c(point.est -   1.96 * my.sd, point.est +   1.96 * my.sd) # These numbers went into the paper
point.est # CI for Naive RR1 - Naive RR2
##########################################################################################
## Finally, the senstivity analysis - for each combination of values for eta1 and eta2 between 0.5 and 2
my.etas1 <- my.etas2 <-  seq(0.5, 2, 0.1)
n.etas1 <- length(my.etas1)
n.etas2 <- length(my.etas2)
SACE.sens <- matrix(nr = n.etas1 * n.etas2, nc = 5)
SACE.sens[, 1] <- rep(my.etas1, each = n.etas2)
SACE.sens[, 2] <- rep(my.etas2, n.etas1)
# Apply SensFun for each unique combination
for (i in 1:(n.etas1 * n.etas2))
{
  SACE.sens.temp <- SensFun(coef1 = coef(fit.aug.w)[2], coef2 = coef(fit.aug.w)[3], 
                            eta1 = SACE.sens[i, 1], eta2 = SACE.sens[i, 2], 
                            coef.covmat = vcov.sand[2:3, 2:3])
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
# Created a figure similiar to Figure 4 in the paper
SACE.sens$out.ci <- ifelse(SACE.sens$out==0,  "0 is not included in the CI", "0 included in the CI")
colors <- c("#999999", "#56B4E9")
colors <- colors[SACE.sens$out+1]
shapes = c(16, 17) 
shapes <- shapes[SACE.sens$out+1]
scatterplot3d(SACE.sens[, 1:3], pch = shapes, color = colors, box=FALSE, cex.lab=1.75, cex.axis = 1.15,
              xlab=expression(eta[1]), ylab="", zlab="SACE RR Difference")
legend("topright", legend = c("Zero is in the CI for the RR difference", 
                              "Zero is not in the CI for the RR difference"), 
       pch = c(16, 17), col = c("#999999", "#56B4E9"))
text(x = 5.5, y = -4, expression(eta[2]), srt = 45, cex = 1.8)
