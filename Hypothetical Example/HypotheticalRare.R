##########################################################################################
## CausalMPE project
#### Analysis of the hypothetical example given in the appendix of the paper
# Causal inference considerations for molecular pathological epidemiology
##########################################################################################
library(dplyr)
#### The data  ####
all <- c(10000, 10, 10, 10000, 10, 20, 9800, 10, 10, 10000, 10, 50, 9700, 60, 60, 9500, 100, 200, 9500, 400, 350, 
              9000, 300, 900, 7500, 1200, 1300, 6000, 1000, 3000)
U <- rep(-2:2, times = c(sum(all[1:6]), sum(all[7:12]), sum(all[13:18]), sum(all[19:24]), sum(all[25:30])))
A <- c(rep(0:1, c(sum(all[1:3]), sum(all[4:6]))), rep(0:1, c(sum(all[7:9]), sum(all[10:12]))),
       rep(0:1, c(sum(all[13:15]), sum(all[16:18]))), rep(0:1, c(sum(all[19:21]), sum(all[22:24]))),
       rep(0:1, c(sum(all[25:27]), sum(all[28:30]))))
Y <- c(rep(0:2, times = all[1:3]), rep(0:2, times = all[4:6]), rep(0:2, times = all[7:9]), 
        rep(0:2, times = all[10:12]), rep(0:2, times = all[13:15]), rep(0:2, times = all[16:18]), 
        rep(0:2, times = all[19:21]), rep(0:2, times = all[22:24]), rep(0:2, times = all[25:27]), 
        rep(0:2, times = all[28:30]))
# Check it is the same as in the paper
data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(count = n())  %>% t 
data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(count = n())
#data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(count = n()) %>% write.table("HypoData.txt", row.names = NA)
data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(count = n()) -> hypo.data
##########################################################################################
Y1 <- Y==1
exp(coef(glm(Y1 ~ A + U, family = "binomial", subset = Y!=2))[2])
exp(coef(glm(Y1 ~ A, family = "binomial", subset = Y!=2))[2])

fit.true <- glm(Y1 ~ A + U, family = "binomial", subset = Y!=2)
fit.A <- glm(Y1 ~ A, family = "binomial", subset = Y!=2)

exp(confint(fit.true)[2,]) %>% round(2)
exp(confint(fit.A)[2,]) %>% round(2)
