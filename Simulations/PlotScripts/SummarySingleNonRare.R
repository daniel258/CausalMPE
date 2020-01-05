rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 5000
all.res.single <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.single.nonrare.csv")

df <- all.res.single %>% as.data.frame 
df.summ <- df %>% group_by(betaE, betaU) %>% summarise(prop.disease = mean(Y/n.sample),
                                            m.ace.diff1 = mean(ace.diff1),
                                            m.ace.or1 = mean(ace.or1))
# Formatting
override.color <- 1:6
override.linetype <- 1:6

# Supplementary Figure 1 
df.summ %>% ggplot(aes(x = betaU, group = factor(betaE) , y = m.ace.or1)) +
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE), linetype = factor(betaE))) + 
  scale_y_continuous(limits = c(0.95,2.25), breaks=seq(1, 2.25, 0.25)) + 
  ylab("Mean estimated RR disease/control") +
  xlab("True RR between U and disease") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for disease/control"),
         linetype = guide_legend(title = "True RR for disease/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm")) 
#+ ylim(c(0.95,2.45)) +
 #  scale_y_continuous(breaks=seq(1, 2.25, 0.25))
