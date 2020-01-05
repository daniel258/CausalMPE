rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 50000
all.res.single.main <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.single.csv")

df <- all.res.single.main %>% as.data.frame 
df.summ.main <- df %>% group_by(betaE, betaU) %>% summarise(prop.disease = mean(Y/n.sample),
                                            m.ace.diff1 = mean(ace.diff1),
                                            m.ace.or1 = mean(ace.or1))

n.sample <- 5000
all.res.single.nonrare <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.single.nonrare.csv")
df <- all.res.single.nonrare %>% as.data.frame 
df.summ.nonrare <- df %>% group_by(betaE, betaU) %>% summarise(prop.disease = mean(Y/n.sample),
                                                       m.ace.diff1 = mean(ace.diff1),
                                                       m.ace.or1 = mean(ace.or1))

n.sample <- 2000
all.res.single.prev <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.single.prev.csv")
df <- all.res.single.prev %>% as.data.frame 
df.summ.prev <- df %>% group_by(betaE, betaU) %>% summarise(prop.disease = mean(Y/n.sample),
                                                       m.ace.diff1 = mean(ace.diff1),
                                                       m.ace.or1 = mean(ace.or1))

df.summ.all <- rbind(df.summ.main, df.summ.nonrare, df.summ.prev)

df.summ.all$Scenario <- factor(rep(c("Rare", "Less Rare", "Prevalent"), each = 42), levels = c("Rare", "Less Rare", "Prevalent"))

# Formatting
override.color <- 1:7
override.linetype <- 1:7

# Supplementary Figure 5
df.summ.all %>% ggplot(aes(x = betaU, group = factor(betaE) , y = m.ace.or1)) +  facet_wrap(.~Scenario) +
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE), linetype = factor(betaE))) + 
  scale_y_continuous(limits = c(0.95,2.6), breaks=seq(1, 2.5, 0.25)) + 
  ylab("Mean estimated OR disease/control") +
  xlab("True OR between U and disease") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True OR for disease/control"),
         linetype = guide_legend(title = "True OR for disease/control")) + 
  theme(strip.text = element_text(size=14),
        axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position="bottom"
  )
# + ylim(c(0.95,2.45)) +
#  scale_y_continuous(breaks=seq(1, 2.25, 0.25))
