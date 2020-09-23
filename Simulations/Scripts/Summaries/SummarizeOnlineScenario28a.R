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
all.res <- matrix(nr = length(all.patts)*1000, nc = 25)
keep <- list(c("keep", "all.patts","all.res", "ii"))
#j <- 1
setwd("/home/dn84/CausalMPE/Results/Scenario 28a")
for (ii in 1:length(all.patts))
{
 # j <- j + 1
  temp.patt <- all.patts[ii] 
  load(paste0("CMPEn50krareScen28a",temp.patt,".RData"))
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 1:3] <- AllY
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 4] <- pop.never.s1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 5] <- pop.never.s2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 6] <- sace.diff1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 7] <- sace.diff2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 8] <- ace.diff1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 9] <- ace.diff2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 10:11] <- ci1 
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 12:13] <- ci2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 14] <- ace.or1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 15] <- ace.or2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 16] <- sace.or1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 17] <- sace.or2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 18] <- exp(betaE[1])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 19] <- exp(betaE[2])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 20] <- exp(betaU[1])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 21] <- exp(betaU[2])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 22] <- or.approx1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 23] <- or.approx2
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 24] <- or.approx.true1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 25] <- or.approx.true2
  #rm(list = setdiff(ls(),keep))
}

colnames(all.res) <- c(paste0("AllY",1:3), "pop.never.s1", "pop.never.s2", "sace.diff1", 
                       "sace.diff2", "ace.diff1", "ace.diff2", "ci1.L", "ci1.H", 
                       "ci2.L", "ci2.H", "ace.or1", "ace.or2", "sace.or1", "sace.or2",
                       "betaE1", "betaE2", "betaU1", "betaU2", 
                       "or.approx1", "or.approx2", "or.approx.true1","or.approx.true2")

setwd("/home/dn84/CausalMPE/")
write.csv(all.res, "all.res.scen28a.csv", row.names = F)
