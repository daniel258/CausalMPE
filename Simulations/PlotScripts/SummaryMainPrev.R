rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 2000
all.res <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.main.prev.csv")


df <- all.res %>% as.data.frame 

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
                                            # m.approx1 = mean(or.approx1),
                                            # m.approx2 = mean(or.approx2),
                                            # m.approx.true1 = mean(or.approx.true1),
                                            # m.approx.true2 = mean(or.approx.true2)
                                       #     ci.sace.or1 = mean((gamma.est - qnorm(0.975)*gamma.se)< 0 & 
                                        #                         (gamma.est + qnorm(0.975)*gamma.se) > 0)
                                            )
df.summ %>% select(betaE,prop.health, prop.s1, prop.s2, prop.never.s1, prop.never.s2) 
df.summ %>% select(betaE,prop.health, prop.s1, prop.s2, prop.never.s1, prop.never.s2) %>% 
  summarise(m.s1 = mean(prop.s1))

df.summ %>% select(betaE, betaU, m.ace.or1, m.ace.or2) %>% View

## Reformatting for the paper
override.color <- 1:6
override.linetype <- 1:6

df.summ %>% ggplot(aes(x = betaU, group = factor(betaE) , y = m.ace.or1)) + 
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
        ) + ylim(c(0.75,1.05))

df.summ %>% ggplot(aes(x = betaU, group = factor(betaE) , y = m.ace.or2)) + 
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE), linetype = factor(betaE))) + 
  ylab("Mean estimated RR Subtype 2/control") +
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
  ) + ylim(c(1.15,2.5))

df.summ %>% ggplot(aes(x = betaU, col = factor(betaE), y = m.ace.or2)) + theme_bw() + 
  geom_line(size = 2) + 
  ylab("Mean estimated RR Subtype2/control") +
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




