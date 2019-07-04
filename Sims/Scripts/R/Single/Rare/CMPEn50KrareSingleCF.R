rm(list = ls())
library(Daniel)
library(dplyr)
library(nnet)
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
# A, B,C,D,E,F,G - betaE[2] = 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5
# A,B,C, D, E,F - betaU = 2,3,4,5,6,7

patt <- "CF"
beta0 <- -5
betaE <- log(1.5)
betaU <- log(7)
sigmaU <- 1
n.sample <- 50000
n.sim <- 1000
AllY <- vector(length = n.sim)
ace.diff1 <- ace.or1 <- vector(length = n.sim)
ci <- matrix(nr = n.sim, nc = 2)

for (j in 1:n.sim)
{
  CatIndex(j)
# Simulate genetic score
  U <- rnorm(n.sample, 0, sd = sigmaU)
#### Calcualte probabilites for each subtype with and without the exposure ####
  E0 <- exp(beta0[1] + betaU*U)
  E1 <- exp(beta0[1] + betaE + betaU*U)
  prE0 <- E0/(1 + E0)
  prE1 <- E1/(1 + E1)

# Simulate subtypes #
Yctrl <- Ytrt <- vector(length = n.sample)
X <- rbinom(n = n.sample, 1, 0.5)

Yctrl <- rbinom(n.sample, 1, prE0)
Ytrt <- rbinom(n.sample, 1, prE1)
Y <- (1-X)*Yctrl + X*Ytrt
AllY[j] <- sum(Y)


ace.diff1[j] <- mean((Ytrt[X==1]) - mean(Yctrl[X==0]))

fit <- glm(Y~ X, family = "binomial")
ace.or1[j] <- exp(fit$coefficients)[2]
ci[j, ] <- confint(fit)[2,]

}

save.image(paste0("CMPEn50krareSingle",patt,".RData"))
