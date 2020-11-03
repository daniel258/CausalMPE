#############################################
## CausalMPE project
# This script combines the results from multiple simualation scripts carried online on the O2 cluster
# This set of simulations concerned a scenario where there are two subtypes, one with a null effect. 
#########################################
rm(list = ls())
#library(Daniel) 
library(dplyr)
x <- c(11:16, 21:26, 31:36, 41:46, 51:56, 61:66)
all.patts <- chartr("123456789", "ABCDEFGHI", x)
all.res <- matrix(nr = length(all.patts)*1000, nc = 11)
keep <- list(c("keep", "all.patts","all.res", "ii"))
#j <- 1
setwd("/home/dn84/CausalMPE/Results/MedScenario 1")
for (ii in 1:length(all.patts))
{
 # j <- j + 1
  temp.patt <- all.patts[ii] 
  load(paste0("CMPEn50krareMedScen1",temp.patt,".RData"))
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 1:3] <- AllY
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 4] <- ace.or1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 5] <- ace.or2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 6] <- ace.cond.or1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 7] <- ace.cond.or2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 8] <- exp(betaE[1])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 9] <- exp(betaE[2])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 10] <- exp(betaU[1])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 11] <- exp(betaU[2])
  #rm(list = setdiff(ls(),keep))
}

colnames(all.res) <- c(paste0("AllY",1:3), "ace.or1", "ace.or2",
                       "ace.cond.or1", "ace.cond.or2",
                       "betaE1", "betaE2", "betaU1", "betaU2")

setwd("/home/dn84/CausalMPE/")
write.csv(all.res, "all.res.med.scen1.csv", row.names = F)
