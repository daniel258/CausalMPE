#############################################
## CausalMPE project
# This script combines the results from multiple simulation scripts carried online on the O2 cluster
# This set of simulations concerned a scenario where there is only one subtype. 
# This is a benchmark for problems from not using U
#########################################
rm(list = ls())
#library(Daniel)
library(dplyr)
x <- c(1:6)
all.patts <- chartr("123456", "ABCDEFGHI", x)
all.res <- matrix(nr = length(all.patts)*1000, nc = 19)
keep <- list(c("keep", "all.patts","all.res", "ii"))
#j <- 1
setwd("/home/dn84/CausalMPE/Results/Null")
for (ii in 1:length(all.patts))
{
 # j <- j + 1
  temp.patt <- all.patts[ii]
  load(paste0("CMPEn50krare",temp.patt,"null.RData"))
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
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 18] <- exp(betaE[2])
  all.res[((ii - 1) * 1000 + 1):(ii * 1000) , 19] <- exp(betaU[2])
  #rm(list = setdiff(ls(),keep))
}

colnames(all.res) <- c(paste0("AllY",1:3), "pop.never.s1", "pop.never.s2", "sace.diff1", 
                       "sace.diff2", "ace.diff1", "ace.diff2", "ci1.L", "ci1.H", 
                       "ci2.L", "ci2.H", "ace.or1", "ace.or2", "sace.or1", "sace.or2",
                       "betaE","betaU")
setwd("/home/dn84/CausalMPE/")
write.csv(all.res, "all.res.null.csv", row.names = F)
