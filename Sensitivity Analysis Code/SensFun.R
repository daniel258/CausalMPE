##########################################################################################
## CausalMPE project
### illustration of the proposed senstivity sensitivity for SSACE in the paper:
# Causal effects in the presence of disease etiologic heterogeneity 
##########################################################################################
# A function that carries out the senstivity sensitivity suggested in the paper: 
SensFun <- function(coef1, coef2, eta1, eta2, coef.covmat)
{
  RR1 <- exp(coef1)
  RR2 <- exp(coef2)
  point1 <- RR1/eta1 
  point2 <- RR2/eta2
  point.diff <- point1 - point2
  my.sd <- sqrt(c(point1, -point2)%*%coef.covmat%*%c(point1, -point2))
  ci.l <- point.diff - 1.96 * my.sd
  ci.h <- point.diff + 1.96 *my.sd
  return(list(RR1.sens = point1, RR2.sens = point2, RR.diff = point.diff, CIsens = c(ci.l, ci.h)))
}