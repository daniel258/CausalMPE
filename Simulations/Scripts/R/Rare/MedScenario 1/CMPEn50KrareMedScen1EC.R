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
# A, B,C,D,E,F - betaE[2] = 1.25, 1.5, 1.75, 2, 2.25, 2.5
# A,B,C, D, E,F - betaU = 2,3,4,5,6,7
# EC
patt <- "EC"
beta0 <- c(-6, -5)
betaE <- c(log(1), log(2.25))
betaU <- c(log(4), log(4))
sigmaU <- 1
n.sample <- 50000
n.sim <- 1000
AllY <- matrix(nr = n.sim, nc = 3)
ace.cond.or1 <- ace.cond.or2 <- ace.or1 <- ace.or2 <- vector(length = n.sim)


for (j in 1:n.sim)
{
  CatIndex(j)
# Simulate genetic score
  U0 <- rnorm(n.sample, 0, sd = sigmaU)
  U1 <- 1.15  + U0 # gives a 0.5 correlation between X and U
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
for (i in 1:n.sample)
{
Yctrl[i] <- sample(c(1,2,0), 1, replace = T, prob = probsE0[i, ])
Ytrt[i] <- sample(c(1,2,0), 1, replace = T, prob = probsE1[i, ])
}
Y <- (1-X)*Yctrl + X*Ytrt
AllY[j, ] <- table(Y)
Y1ctrl <- Yctrl==1
Y1trt <- Ytrt==1
Y2ctrl <- Yctrl==2
Y2trt <- Ytrt==2

Y1only <- Y[Y<2]
X1only <- X[Y<2]
U1only <-U[Y<2]

Y2only <- Y[Y!=1]
X2only <- X[Y!=1]
U2only <-U[Y!=1]
Y2only[Y2only>0] <- 1

vec.for.or.1only <- c(sum((1 - Y1only) * (1 - X1only)) , sum(Y1only * (1 - X1only)),
                sum((1 - Y1only) * X1only), sum(Y1only*X1only))
vec.for.or.2only <- c(sum((1 - Y2only) * (1 - X2only)) , sum(Y2only * (1 - X2only)),
                      sum((1 - Y2only) * X2only), sum(Y2only*X2only))

ace.or1[j] <- CalcOR(vec.for.or.1only)
ace.or2[j] <- CalcOR(vec.for.or.2only)

Y1 <- Y==1
Y2 <- Y==2
fit.logistic.Y1.cond <- glm(Y1 ~ X + U, family = "binomial", subset = Y2==0)
fit.logistic.Y2.cond <- glm(Y2 ~ X + U, family = "binomial", subset = Y1==0)
ace.cond.or1[j] <- exp(coef(fit.logistic.Y1.cond)[2])
ace.cond.or2[j] <- exp(coef(fit.logistic.Y2.cond)[2])
}

save.image(paste0("CMPEn50krareMedScen1",patt,".RData"))
