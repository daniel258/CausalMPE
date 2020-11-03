rm(list = ls())
library(Daniel)
library(dplyr)
library(nnet)

set.seed(314)
CalcCImultinom <- function(fit)
{
  s <- summary(fit)
  coef <- s$coefficients
  ses <- s$standard.errors
  ci.1 <- coef[1,2] + c(-1, 1)*1.96*ses[1, 2]
  ci.2 <- coef[2,2] + c(-1, 1)*1.96*ses[2, 2]
  return(rbind(ci.1,ci.2))
}
#key
# A, B,C,D,E,F - betaE[2] = 1.25, 1.5, 1.75, 2, 2.25, 2.5
# A,B,C, D, E,F - betaU = 2,3,4,5,6,7


beta0 <- c(-6, -5)
betaE <- c(log(1), log(1.25))
betaU <- c(log(2), log(2))
all.betasE <- all.betasU <- matrix(nr = 36, nc =2)
all.betasE[, 1] <- 0
all.betasE[, 2] <- rep(log(c(1.25, 1.5, 1.75, 2, 2.25, 2.5)), each = 6)
all.betasU[, 1] <- all.betasU[, 2] <- rep(log(2:7), 6)
all.betas <- cbind(all.betasE, all.betasU)
sigmaU <- 1
n.sample <- 5000000

TE.diff <- TE.rr <- TE.or <- matrix(nrow = nrow(all.betas), nc = 2)
for (i in 1:nrow(all.betas))
{
  betaE <- all.betasE[i, ]
  betaU <- all.betasU[i, ]
  CatIndex(i)
# Simulate genetic score
  U0 <- rnorm(n.sample, 0, sd = sigmaU)
  U1 <- 1.15  + U0 # gives a 0.5 correlation between A and U
#### Calculate probabilities for each subtype with and without the exposure ####
  e1E0 <- exp(beta0[1] + betaU[1]*U0)
  e1E1 <- exp(beta0[1] + betaE[1] + betaU[1]*U1)
  e2E0 <- exp(beta0[2] + betaU[2]*U0)
  e2E1 <- exp(beta0[2] + betaE[2] + betaU[2]*U1)
  prE0Y1 <- e1E0/(1 + e1E0 + e2E0)
  prE0Y2 <- e2E0/(1 + e1E0 + e2E0)
  prE1Y1 <- e1E1/(1 + e1E1 + e2E1)
  prE1Y2 <- e2E1/(1 + e1E1 + e2E1)
  probsE0 <- cbind(prE0Y1, prE0Y2, 1 - prE0Y1 - prE0Y2)
  probsE1 <- cbind(prE1Y1, prE1Y2, 1 - prE1Y1 - prE1Y2)
# Simulate subtypes #
Yctrl <- Ytrt <- vector(length = n.sample)
X <- rbinom(n = n.sample, 1, 0.5)
U <- U0
U[X==1] <- U1[X==1]
for (j in 1:n.sample)
{
Yctrl[j] <- sample(c(1,2,0), 1, replace = T, prob = probsE0[j, ])
Ytrt[j] <- sample(c(1,2,0), 1, replace = T, prob = probsE1[j, ])
}
Y1ctrl <- Yctrl==1
Y1trt <- Ytrt==1
Y2ctrl <- Yctrl==2
Y2trt <- Ytrt==2

m1.trt <- mean(Y1trt)
m2.trt <- mean(Y2trt)
m1.ctrl <- mean(Y1ctrl)
m2.ctrl <- mean(Y1ctrl)
# TE stands for total effect
TE.diff[i, 1] <- m1.trt - m1.ctrl
TE.diff[i, 2] <- m2.trt - m2.ctrl
TE.rr[i, 1] <- m1.trt/m1.ctrl
TE.rr[i, 2] <- m2.trt/m2.ctrl
TE.or[i, 1] <- (m1.trt/(1  - m1.trt))/(m1.ctrl/(1  - m1.ctrl))
TE.or[i, 2] <- (m2.trt/(1  - m2.trt))/(m2.ctrl/(1  - m2.ctrl))
}
all.TE <- cbind(exp(all.betas), TE.diff, TE.rr, TE.or)
colnames(all.TE) <- c("betaE1", "betaE2", "betaU1", "betaU2", "TE.diff1", "TE.diff2", "TE.rr1", "TE.rr2", "TE.or1", "TE.or2")
setwd("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/")

save.image("EffectsMedScen1.RData")
write.csv(all.TE, "EffectsMedScen1.csv", row.names = F)
