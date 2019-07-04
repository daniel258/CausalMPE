rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 50000
all.res.null <- read.csv("Dropbox/CausalMPE/R/CausalMPE/Sims/Results/n50000/all.res.null.csv")
all.res.null <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Sims/Results/n50000/all.res.null.csv")

df <- all.res.null %>% as.data.frame 
# How many health? How mayn of each subtype?
df.summ <- df %>% group_by(betaE, betaU) %>% summarise(prop.health = mean(AllY1/n.sample),
                                            prop.s1 = mean(AllY2/n.sample),
                                            prop.s2 = mean(AllY3/n.sample),
                                            prop.never.s1 = mean(pop.never.s1),
                                            prop.never.s2 = mean(pop.never.s2),
                                            m.sace.diff1 = mean(sace.diff1),
                                            m.sace.diff2 = mean(sace.diff2),
                                            m.ace.diff1 = mean(ace.diff1),
                                            m.ace.diff2 = mean(ace.diff2),
                                            m.sace.or1 = mean(sace.or1),
                                            m.sace.or2 = mean(sace.or2),
                                            m.ace.or1 = mean(ace.or1),
                                            m.ace.or2 = mean(ace.or2)
                                            )

df.summ %>% select(prop.health, prop.s1, prop.s2, prop.never.s1, prop.never.s2)
## Reformatting for the paper
override.color <- 1:2
override.linetype <- 1:2

# Supplementary Figure 2
df.plot <- data.frame(betaU = rep(df.summ$betaU, 2), m.or.est = c(df.summ$m.ace.or1, df.summ$m.ace.or2), 
                      Subtype = rep(c("1", "2"), each = 6))
df.plot %>% ggplot(aes(x = betaU,  y = m.or.est, group = Subtype)) + theme_bw() + 
  geom_line(size = 2, aes(col = Subtype, linetype = Subtype)) + 
  ylab("Mean estimated RR Subtype/control") +
  xlab("True RR between U and each subtype") + 
  ylim(c(0.7,1.3)) + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"))
        )


df.plot %>% ggplot(aes(x = betaU, group = factor(betaE) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE), linetype = factor(betaE))) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and each subtype") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm")
  )
