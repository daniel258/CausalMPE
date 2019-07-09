##########################################################################################
## CausalMPE project
### illustration of the proposed senstivity analysis for SSACE in the paper:
# Causal effects in the presence of disease etiologic heterogeneity 
##########################################################################################

### This file createa an hypothetical dataset similiar to the dataset used in the paper based on the
# Nurses' Health Study cohort
# Outcome: Y: 0: healty, 1: non-MSI-high cancer 2: MSI-high cancer 
# Exposure: aspirin (0 not taking, 1 taking)
# Confounders: 
###   family (family history of colorectal cancer). 
# About 5000 out of 65000 Pr(family=1)=0.077
###   pkyr (pack-year smoking). Two stage simulation:
# 1) about 44% are pkyr=0 (no smoking)
# 2) Among smokers, simulate pkyr from log normal with mean 2.5 and sd=1.13
#bmi (continious), 
# sample.size
n.sample <- 65000
# set.seed for reproducability
set.seed(314)
###################################################################################
# Simulate confounders according to distribution similiar to the distribution in the 
# illustrative example dataset
family <- rbinom(n = n.sample, size = 1, prob = 0.077) # about 5000 out of 65000
pkyr.zero <- rbinom(n = n.sample, size = 1, prob = 0.44) # about 44% pkyr=0
pkyr <- vector(length = n.sample)
pkyr[pkyr.zero==1] <- 0
pkyr[pkyr.zero==0] <- round(exp(rnorm(n = sum(pkyr.zero==0), mean = 2.5, sd = 1.13)), 0)
bmi <- rnorm(n.sample, mean = 25, sd = 2.75)
bmi[bmi > 35] <- sample(25:35, sum(bmi > 35), replace = T)
bmi[bmi < 15] <- sample(15:25, sum(bmi < 15), replace = T)
###################################################################################
#Simulate exposure (aspirin) values according to the estimated PS model in the
# illustrative example dataset
term.for.prob <- -1.35 + 0.06*family + 0.0044*pkyr + 0.015*bmi
prob.asp <- exp(term.for.prob)/(1 + exp(term.for.prob))
aspirin <- rbinom(n = n.sample, size = 1, prob = prob.asp)
#Simulate outcome from a fitted multinomial regression model similiar to the
# illustrative example dataset (for non.msi aspirin effect was somewhat closer to null)
#Order:  (Intercept)     aspirin    family      bmicont        pkyr
beta.non.msi <- c(-5.7, -0.25, 0.5, -0.0014, 0.007) 
beta.msi <- c(-8.3, -0.02, 0.17, 0.0018, 0.015) 
# Add U 
U <- rnorm(n.sample, 0, 1)
beta.non.msi <- c(beta.non.msi, log(5))
beta.msi <- c(beta.msi, log(5))
# Calclate outcome probabilities
term.for.pr1 <- cbind(1,  aspirin, family, bmi, pkyr, U)%*%beta.non.msi
term.for.pr2 <- cbind(1,  aspirin, family, bmi, pkyr, U)%*%beta.msi
PrY1 <- exp(term.for.pr1)/(1 + exp(term.for.pr1) + exp(term.for.pr2))
PrY2 <- exp(term.for.pr2)/(1 + exp(term.for.pr1) + exp(term.for.pr2))
PrY0 <- 1- PrY1 - PrY2 
probs.outcome <- cbind(PrY0, PrY1, PrY2)
Y <- vector(length = n.sample)
for (i in 1:n.sample)
{
  Y[i] <- sample(c(0,1,2), 1, replace = T, prob = probs.outcome[i,])
}
table(Y)
# Put all in one data.frame and then save it to disc
my.data <- data.frame(aspirin, family, pkyr, bmi, Y)
setwd("Sensitivity Analysis Code/")
write.table(my.data, "my.sim.data.csv")
###################################################################################
