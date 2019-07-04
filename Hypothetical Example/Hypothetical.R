##########################################################################################
## CausalMPE project
#### Analysis of the hypothetical example given in the appendix of the paper
# Causal effects in the presence of disease etiologic heterogeneity 
##########################################################################################
rm(list =ls())
library(dplyr)


##########################################################################################
#### Create the artifical example given in the paper appendix ####

U <- rep(0:1, times = c(300, 700))
A <- c(rep(0:1, times = c(230, 70)), rep(0:1, times = c(540, 160)))
Y <- c(rep(0:2, c(185, 20, 25)), rep(0:2, c(50, 10, 10)), rep(0:2, c(250, 140, 150)), 
       rep(0:2, c(40, 100, 20)))
##########################################################################################
#### The data  ####
data.frame(U, A, Y) %>% group_by(U, A, Y) %>% summarize(n = n())  %>% t

##########################################################################################
# Define Y2 to be the indicator Y==2
Y2 <- Y==2
# The OR between Subtype 2 and control coniditonal on A is 1.002776
exp(coef(glm(Y2 ~ A + U, family = "binomial", subset = Y!=1))[2])
# The marginla OR between Subtype 2 and  on A is 0.8285714
exp(coef(glm(Y2 ~ A, family = "binomial", subset = Y!=1))[2])