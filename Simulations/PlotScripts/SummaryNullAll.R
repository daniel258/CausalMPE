rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 50000
all.res.null.main <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.null.csv")

df <- all.res.null.main %>% as.data.frame 
# How many health? How mayn of each subtype?
df.summ.main <- df %>% group_by(betaE, betaU) %>% summarise(prop.health = mean(AllY1/n.sample),
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


n.sample <- 5000
all.res.null.nonrare <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.null.nonrare.csv")
df <- all.res.null.nonrare %>% as.data.frame 
df.summ.nonrare <- df %>% group_by(betaE, betaU) %>% summarise(prop.health = mean(AllY1/n.sample),
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
n.sample <- 2000
all.res.null.prev <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.null.prev.csv")

df <- all.res.null.prev %>% as.data.frame 
# How many health? How mayn of each subtype?
df.summ.prev <- df %>% group_by(betaE, betaU) %>% summarise(prop.health = mean(AllY1/n.sample),
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
df.summ.all <- rbind(df.summ.main, df.summ.nonrare, df.summ.prev)

df.summ.all$Scenario <- factor(rep(c("Rare", "Less Rare", "Prevalent"), each = 6), levels = c("Rare", "Less Rare", "Prevalent"))


## Reformatting for the paper
override.color <- 1:2
override.linetype <- 1:2



# Supplementary Figure 6
df.plot <- data.frame(betaU = rep(df.summ.all$betaU, 2), m.or.est = c(df.summ.all$m.ace.or1, df.summ.all$m.ace.or2), 
                      Subtype = rep(c("1", "2"), each = 6))  
df.plot$Scenario <- factor(rep(c("Rare", "Less Rare", "Prevalent"), each = 6), levels = c("Rare", "Less Rare", "Prevalent"))

df.plot %>% ggplot(aes(x = betaU,  y = m.or.est, group = Subtype)) + theme_bw() + facet_wrap(.~Scenario) +
  geom_line(size = 2, aes(col = Subtype, linetype = Subtype)) + 
  ylab("Mean estimated OR Subtype/control") +
  xlab("True OR between U and each subtype") + 
  ylim(c(0.7,1.3)) + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  theme(strip.text = element_text(size=14),
        axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position="bottom"
  )
        


