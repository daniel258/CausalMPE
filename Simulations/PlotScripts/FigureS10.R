rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 50000
# Load simulation results and computed effects
all.res.med.scen <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.med.scen1.csv")
true.effects.med <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/EffectsMedScen1.csv")
## Summarize simulation results
df.summ <- all.res.med.scen %>% group_by(betaE1, betaE2, betaU1, betaU2) %>% 
  summarise(prop.health = mean(AllY1/n.sample), prop.s1 = mean(AllY2/n.sample), prop.s2 = mean(AllY3/n.sample),
            m.ace.or1 = mean(ace.or1), m.ace.or2 = mean(ace.or2),
            m.ace.cond.or1 = mean(ace.cond.or1), m.ace.cond.or2 = mean(ace.cond.or2))

# Combine into a single data frame
df.summ$TE.or1 <-  df.summ$m.ace.or1
df.summ1 <- df.summ %>% select(starts_with("beta"), TE.or1)
df.true.effects.med <- true.effects.med %>% select(starts_with("beta"), TE.or1)
df.summ1$type <- "Estimated"
df.true.effects.med$type <- "True"
df.figure <- rbind(df.summ1, df.true.effects.med)

## Reformatting for the figure
override.color <- 1:6
override.linetype <- 1:6

#### Figure S10 #####
df.figure$betaE2.new <- case_when(df.figure$betaE2==1.25 ~ "True Conditional RR Subtype 2/control: 1.25",
                                  df.figure$betaE2==1.5 ~ "True Conditional RR Subtype 2/control: 1.5",
                                  df.figure$betaE2==1.75 ~ "True Conditional RR Subtype 2/control: 1.75",
                                  df.figure$betaE2==2 ~ "True Conditional RR Subtype 2/control: 2",
                                  df.figure$betaE2==2.25 ~ "True Conditional RR Subtype 2/control: 2.25",
                                  df.figure$betaE2==2.5 ~ "True Conditional RR Subtype 2/control: 2.5")
df.figure %>%  ggplot(aes(x = betaU1, y = TE.or1)) + 
  theme_bw() + geom_line(size = 1.5, aes(linetype = factor(type))) + 
  facet_wrap(. ~betaE2.new) + 
    #geom_line(size = 2, aes(col = factor(betaE2), y = TE.or1))# + 
  ylab("RR Subtype1/control") +
  xlab("True RR between U and each subtype") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                             colour = override.color))) + 
         guides(linetype = guide_legend(title = "Type")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom") +  ylim(c(1, 5))

