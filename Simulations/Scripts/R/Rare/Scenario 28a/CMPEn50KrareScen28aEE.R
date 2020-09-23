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

patt <- "EE"
beta0 <- c(-6, -5)
betaE <- c(log(1.5), log(2.25))
betaU <- c(log(6), log(1.5))
sigmaU <- 1
n.sample <- 50000
n.sim <- 1000
AllY <- matrix(nr = n.sim, nc = 3)
sace.diff1 <- sace.diff2 <- ace.diff1 <- ace.diff2 <-
sace.or1 <- sace.or2 <- ace.or1 <- ace.or2 <-
  or.approx1 <- or.approx2 <- or.approx.true1 <- or.approx.true2 <- 
  pop.never.s1 <- pop.never.s2 <-   vector(length = n.sim)
ci1 <- ci2 <- matrix(nr = n.sim, nc = 2)

for (j in 1:n.sim)
{
  CatIndex(j)
# Simulate genetic score
  U <- rnorm(n.sample, 0, sd = sigmaU)
#### Calcualte probabilites for each subtype with and without the exposure ####
  e1E0 <- exp(beta0[1] + betaU[1]*U)
  e1E1 <- exp(beta0[1] + betaE[1] + betaU[1]*U)
  e2E0 <- exp(beta0[2] + betaU[2]*U)
  e2E1 <- exp(beta0[2] + betaE[2] + betaU[2]*U)
  prE0Y1 <- e1E0/(1 + e1E0 + e2E0)
  prE0Y2 <- e2E0/(1 + e1E0 + e2E0)
  prE1Y1 <- e1E1/(1 + e1E1 + e2E1)
  prE1Y2 <- e2E1/(1 + e1E1 + e2E1)
  probsE0 <- cbind(prE0Y1, prE0Y2, 1 - prE0Y1 - prE0Y2)
  probsE1 <- cbind(prE1Y1, prE1Y2, 1 - prE1Y1 - prE1Y2)

# Simulate subtypes #
Yctrl <- Ytrt <- vector(length = n.sample)
X <- rbinom(n = n.sample, 1, 0.5)
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

pop.never.s1[j] <- mean(Y1ctrl==0 & Y1trt==0)
pop.never.s2[j] <- mean(Y2ctrl==0 & Y2trt==0)
# estimate causal parameters
sace.diff1[j] <- mean((Y1trt - Y1ctrl)[Y2ctrl==0 & Y2trt==0])
sace.diff2[j]<- mean((Y2trt - Y2ctrl)[Y1ctrl==0 & Y1trt==0])
ace.diff1[j] <- mean((Y1trt[Y2trt==0 & X==1]) - mean(Y1ctrl[Y2ctrl==0 & X==0]))
ace.diff2[j] <- mean((Y2trt[Y1trt==0 & X==1]) - mean(Y2ctrl[Y1ctrl==0 & X==0]))

# Ypo <- c(Yctrl, Ytrt)
# Upo <- rep(U,2)
# Xpo <- rep(x = c(0,1), each = n.sample)
# fit.full.po <- multinom(Ypo~ Xpo + Upo)
# fit.po <- multinom(Ypo~ Xpo)
fit <- multinom(Y~ X)

cis <- CalcCImultinom(fit)
ci1[j, ] <- cis[1, ]
ci2[j, ] <- cis[2, ]

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

Y1only.sace <- Y[Ytrt <2 & Yctrl < 2]
X1only.sace <- X[Ytrt <2 & Yctrl < 2]
U1only.sace <-U[Ytrt <2 & Yctrl < 2]

Y2only.sace <- Y[Ytrt!=1 & Y1ctrl!=1]
X2only.sace <- X[Ytrt!=1 & Y1ctrl!=1]
U2only.sace <-U[Ytrt!=1 & Y1ctrl!=1]
Y2only.sace[Y2only.sace>0] <- 1

vec.for.or.sace1 <- c(sum((1 - Y1only.sace) * (1 - X1only.sace)) , sum(Y1only.sace * (1 - X1only.sace)),
                      sum((1 - Y1only.sace) * X1only.sace), sum(Y1only.sace*X1only.sace))
vec.for.or.sace2 <- c(sum((1 - Y2only.sace) * (1 - X2only.sace)) , sum(Y2only.sace * (1 - X2only.sace)),
                      sum((1 - Y2only.sace) * X2only.sace), sum(Y2only.sace*X2only.sace))

sace.or1[j] <- CalcOR(vec.for.or.sace1)
sace.or2[j] <- CalcOR(vec.for.or.sace2)
Y1 <- Y==1
Y2 <- Y==2
fit.logistic.Y1 <- glm(Y1 ~ X, family = "binomial")
fit.logistic.true.Y1 <- glm(Y1 ~ X + U, family = "binomial")
fit.logistic.Y2 <- glm(Y2 ~ X, family = "binomial")
fit.logistic.true.Y2 <- glm(Y2 ~ X + U, family = "binomial")
or.approx1[j] <- exp(coef(fit.logistic.Y1)[2])
or.approx.true1[j] <- exp(coef(fit.logistic.true.Y1)[2])
or.approx2[j] <- exp(coef(fit.logistic.Y2)[2])
or.approx.true2[j] <- exp(coef(fit.logistic.true.Y2)[2])
}
save.image(paste0("CMPEn50krareScen28a",patt,".RData"))
