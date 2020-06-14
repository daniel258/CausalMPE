##########################################################################################
## CausalMPE project
#### Analysis of the hypothetical example given in the appendix of the paper
# Causal inference considerations for molecular pathological epidemiology
##########################################################################################
rm(list =ls())
library(dplyr)


n.sample <- 100000
n.sim <- 1000
beta0 <- c(-5, -5)
betaA <- c(log(1), log(3))
betaU <- c(log(5), log(5))
##########################################################################################
#### Create the artifical example given in the paper appendix ####
set.seed(1)
U <- sample(-2:2, n.sample, replace = T)
e1A0 <- exp(beta0[1] + betaU[1]*U)
e1A1 <- exp(beta0[1] + betaA[1] + betaU[1]*U)
e2A0 <- exp(beta0[2] + betaU[2]*U)
e2A1 <- exp(beta0[2] + betaA[2] + betaU[2]*U)
prA0Y1 <- e1A0/(1 + e1A0 + e2A0)
prA0Y2 <- e2A0/(1 + e1A0 + e2A0)
prA1Y1 <- e1A1/(1 + e1A1 + e2A1)
prA1Y2 <- e2A1/(1 + e1A1 + e2A1)
probsA0 <- cbind(prA0Y1, prA0Y2, 1 - prA0Y1 - prA0Y2)
probsA1 <- cbind(prA1Y1, prA1Y2, 1 - prA1Y1 - prA1Y2)

# Simulate subtypes #
Yctrl <- Ytrt <- vector(length = n.sample)
A <- rbinom(n = n.sample, 1, 0.5)
for (i in 1:n.sample)
{
  Yctrl[i] <- sample(c(1,2,0), 1, replace = T, prob = probsA0[i, ])
  Ytrt[i] <- sample(c(1,2,0), 1, replace = T, prob = probsA1[i, ])
}
Y <- (1 - A)*Yctrl + A*Ytrt
Y1 <- Y==1
Y2 <- Y==2
fit.logistic.Y1 <- glm(Y1 ~ A, family = "binomial", subset = Y!=2)
fit.logistic.true.Y1 <- glm(Y1 ~ A + U, family = "binomial", subset = Y!=2)
exp(coef(fit.logistic.Y1)[2])
exp(coef(fit.logistic.true.Y1)[2])
exp(confint(fit.logistic.Y1)[2,]) %>% round(2)
exp(confint(fit.logistic.true.Y1)[2,]) %>% round(2)

##########################################################################################
#### The data  ####
dd <- data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(n = n())  %>% t 
dd2 <- dd
dd2[4, ] <- c(10000, 10, 10, 10000, 10, 20, 9800, 10, 10, 10000, 10, 50, 9700, 70, 50, 9500, 100, 200, 9500, 400, 350, 
              9000, 300, 900, 7500, 1200, 1300, 6000, 1000, 3000)
dd2
UU <- rep(-2:2, times = c(sum(dd2[4, 1:6]), sum(dd2[4, 7:12]), sum(dd2[4, 13:18]), sum(dd2[4, 19:24]), sum(dd2[4, 25:30])))
table(UU)
length(UU)
AA <- c(rep(0:1, c(sum(dd2[4, 1:3]), sum(dd2[4, 4:6]))), rep(0:1, c(sum(dd2[4, 7:9]), sum(dd2[4, 10:12]))),
       rep(0:1, c(sum(dd2[4, 13:15]), sum(dd2[4, 16:18]))), rep(0:1, c(sum(dd2[4, 19:21]), sum(dd2[4, 22:24]))),
       rep(0:1, c(sum(dd2[4, 25:27]), sum(dd2[4, 28:30]))))
table(AA)
length(AA)
YY <- c(rep(0:2, times = dd2[4, 1:3]), rep(0:2, times = dd2[4, 4:6]), rep(0:2, times = dd2[4, 7:9]), 
        rep(0:2, times = dd2[4, 10:12]), rep(0:2, times = dd2[4, 13:15]), rep(0:2, times = dd2[4, 16:18]), 
        rep(0:2, times = dd2[4, 19:21]), rep(0:2, times = dd2[4, 22:24]), rep(0:2, times = dd2[4, 25:27]), 
        rep(0:2, times = dd2[4, 28:30]))
table(YY)
length(YY)
data.frame(UU, AA, YY) %>% group_by(UU, AA, YY) %>% summarize(n = n())  %>% t 
##########################################################################################
exp(coef(glm(Y1 ~ A + U + A:U, family = "binomial", subset = Y!=2))[2])
exp(coef(glm(Y1 ~ A + U, family = "binomial", subset = Y!=2))[2])
exp(coef(glm(Y1 ~ A, family = "binomial", subset = Y!=2))[2])

YY1 <- YY==1
exp(coef(glm(YY1 ~ AA + UU, family = "binomial", subset = YY!=2))[2])
exp(coef(glm(YY1 ~ AA, family = "binomial", subset = YY!=2))[2])
