#############################################
## CausalMPE project
# This script combines the results from multiple simualation scripts carried online on the O2 cluster
# This set of simulations concerned a scenario where the effect of the exposure was zero on both 
# cancer subtypes.
#########################################
rm(list = ls())
library(Daniel)
library(dplyr)
x <- c(11:16, 21:26, 31:36, 41:46, 51:56, 61:66)
all.patts <- chartr("123456789", "ABCDEFGHI", x)
all.res <- matrix(nr = length(all.patts)*1000, nc = 7)
keep <- list(c("keep", "all.patts","all.res", "ii"))
#j <- 1
setwd("/home/dn84/CausalMPE/Results/Single")
for (ii in 1:length(all.patts))
{
 # j <- j + 1
  CatIndex(ii)
  temp.patt <- all.patts[ii]
  load(paste0("CMPEn50krareSingle",temp.patt,".RData"))
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 1] <- AllY
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 2] <- ace.diff1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 3:4] <- ci
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 5] <- ace.or1
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 6] <- exp(betaE)
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 7] <- exp(betaU)
  #rm(list = setdiff(ls(),keep))
}

colnames(all.res) <- c("Y", "ace.diff1", "ci1.L", "ci1.H", "ace.or1", "betaE","betaU")
setwd("/home/dn84/CausalMPE/")
write.csv(all.res, "all.res.single.csv", row.names = F)
