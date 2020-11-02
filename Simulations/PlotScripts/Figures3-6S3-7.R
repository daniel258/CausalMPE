rm(list = ls())
library(Daniel)
library(ggplot2)
library(dplyr)
library(xtable)

n.sample <- 50000
all.res.main <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.main.csv")
all.res.scen1 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen1.csv")
all.res.scen1a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen1a.csv")
all.res.scen2 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen2.csv")
all.res.scen3 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen3.csv")
all.res.scen4 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen4.csv")
all.res.scen5 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen5.csv")
all.res.scen6 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen6.csv")
all.res.scen7 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen7.csv")
all.res.scen8 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen8.csv")
all.res.scen8a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen8a.csv")
all.res.scen9 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen9.csv")
all.res.scen9a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen9a.csv")
all.res.scen10 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen10.csv")
all.res.scen11 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen11.csv")
all.res.scen11a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen11a.csv")
all.res.scen12 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen12.csv")
all.res.scen13 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen13.csv")
all.res.scen14 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen14.csv")
all.res.scen15 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen15.csv")
all.res.scen16 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen16.csv")
all.res.scen17 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen17.csv")
all.res.scen18 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen18.csv")
all.res.scen18a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen18a.csv")
all.res.scen19 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen19.csv")
all.res.scen19a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen19a.csv")
all.res.scen20 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen20.csv")
all.res.scen21 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen21.csv")
all.res.scen21a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen21a.csv")
all.res.scen22 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen22.csv")
all.res.scen23 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen23.csv")
all.res.scen24 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen24.csv")
all.res.scen25 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen25.csv")
all.res.scen26 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen26.csv")
all.res.scen27 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen27.csv")
all.res.scen28 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen28.csv")
all.res.scen28a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen28a.csv")
all.res.scen29 <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen29.csv")
all.res.scen29a <- read.csv("/Users/danielnevo/Dropbox/CausalMPE/R/CausalMPE/Simulations/Results/all.res.scen29a.csv")



df <- rbind(all.res.main, all.res.scen1, all.res.scen1a, all.res.scen2, all.res.scen3, 
            all.res.scen4, all.res.scen5, all.res.scen6, all.res.scen7, all.res.scen8, 
            all.res.scen8a, all.res.scen9, all.res.scen9a, all.res.scen10, all.res.scen11,
            all.res.scen11a, all.res.scen12,  all.res.scen13, all.res.scen14, all.res.scen15, all.res.scen16, 
            all.res.scen17, all.res.scen18, all.res.scen18a, all.res.scen19, all.res.scen19a, 
            all.res.scen20, all.res.scen21, all.res.scen21a, all.res.scen22, all.res.scen23, 
            all.res.scen24, all.res.scen25, all.res.scen26, all.res.scen27, all.res.scen28,
            all.res.scen28a, all.res.scen29, all.res.scen29a)
df$Scen <- rep(c("Main", 1, "1a", 2:8,"8a", 9, "9a", 10, 11, "11a", 12:18, "18a", 19,
                 "19a", 20, 21, "21a", 22:28, "28a", 29, "29a"), each = 36000) %>% as.factor

df.summ <- df %>% group_by(Scen, betaE1, betaE2, betaU1, betaU2) %>% 
  summarise(prop.health = mean(AllY1/n.sample), prop.s1 = mean(AllY2/n.sample), prop.s2 = mean(AllY3/n.sample),
            m.ace.diff1 = mean(ace.diff1), m.ace.diff2 = mean(ace.diff2),
            m.ace.or1 = mean(ace.or1), m.ace.or2 = mean(ace.or2))

## Reformatting for the paper
override.color <- 1:6
override.linetype <- 1:6


#### Figure 3 #####

df.summ %>% filter(Scen=="Main") %>% ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
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
        legend.key.width = unit(1.5,"cm")) +  ylim(c(0.85, 1.05)) + geom_hline(aes(yintercept = 1), size = 1.2)

#### Figure 4 #####

df.summ %>% filter(Scen=="Main") %>%  ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or2)) + 
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
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
        legend.key.width = unit(1.5,"cm")) 

###### Figure 5 ##########
df.summ123689 <- df.summ %>% filter(Scen %in% c(1, 2, 3, 6, 8, 9))
df.summ123689$Scen.new <- case_when(df.summ123689$Scen==1 ~ "True RR U-Subtype 1: 5",
          df.summ123689$Scen==2 ~ "True RR U-Subtype 1: 2.5",
          df.summ123689$Scen==3 ~ "True RR U-Subtype 1: 0.4",
          df.summ123689$Scen==6 ~ "True RR U-Subtype 1: 0.2",
          df.summ123689$Scen==8 ~ "True RR U-Subtype 1: 1.5",
          df.summ123689$Scen==9 ~ "True RR U-Subtype 1: 0.66")
df.summ123689 %>% ggplot(aes(x = betaU2, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 2") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
  ylim(c(0.85, 1.05)) + geom_hline(aes(yintercept = 1), size = 1.2)

###### Figure 6 ##########
df.summ2123689 <- df.summ %>% filter(Scen %in% c(21, 22, 23, 26, 28, 29))
df.summ2123689$Scen.new <- case_when(df.summ2123689$Scen==21 ~ "True RR U-Subtype 1: 5",
                                     df.summ2123689$Scen==22 ~ "True RR U-Subtype 1: 2.5",
                                     df.summ2123689$Scen==23 ~ "True RR U-Subtype 1: 0.4",
                                     df.summ2123689$Scen==26 ~ "True RR U-Subtype 1: 0.2",
                                     df.summ2123689$Scen==28 ~ "True RR U-Subtype 1: 1.5",
                                     df.summ2123689$Scen==29 ~ "True RR U-Subtype 1: 0.66")
df.summ2123689 %>% ggplot(aes(x = betaU2, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 2") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
  #  ylim(c(1.85, 3.05)) 
  geom_hline(aes(yintercept = 1.5), size = 1.2)

###### Figure 7 ##########
df.summ1123689 <- df.summ %>% filter(Scen %in% c(11, 12, 13, 16, 18, 19))
df.summ1123689$Scen.new <- case_when(df.summ1123689$Scen==11 ~ "True RR U-Subtype 1: 5",
                                    df.summ1123689$Scen==12 ~ "True RR U-Subtype 1: 2.5",
                                    df.summ1123689$Scen==13 ~ "True RR U-Subtype 1: 0.4",
                                    df.summ1123689$Scen==16 ~ "True RR U-Subtype 1: 0.2",
                                    df.summ1123689$Scen==18 ~ "True RR U-Subtype 1: 1.5",
                                    df.summ1123689$Scen==19 ~ "True RR U-Subtype 1: 0.66")
df.summ1123689 %>% ggplot(aes(x = betaU2, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 2") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
#  ylim(c(1.85, 3.05)) 
 geom_hline(aes(yintercept = 2.5), size = 1.2)


###### Figure S3 ##########
df.summ.main1020 <- df.summ %>% filter(Scen %in% c("Main", 10, 20))
df.summ.main1020$Scen.new <- case_when(df.summ.main1020$Scen=="Main" ~ "True RR A-Subtype 1: 1",
                                       df.summ.main1020$Scen==10 ~ "True RR A-Subtype 1: 2.5",
                                       df.summ.main1020$Scen==20 ~ "True RR A-Subtype 1: 1.5")
df.summ.main1020  %>%  ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or2)) + 
  theme_bw() + geom_line(size = 2, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(Scen.new ~.) + 
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
        legend.key.width = unit(1.5,"cm"),
        legend.position = "botton") 



###### Figure S4 ##########
df.summ1a4578a9a <- df.summ %>% filter(Scen %in% c("1a", 4, 5,7, "8a", "9a"))
df.summ1a4578a9a$Scen.new <- case_when(df.summ1a4578a9a$Scen=="1a" ~ "True RR U-Subtype 2: 5",
                                       df.summ1a4578a9a$Scen==4 ~ "True RR U-Subtype 2: 2.5",
                                       df.summ1a4578a9a$Scen==5 ~ "True RR U-Subtype 2: 0.4",
                                       df.summ1a4578a9a$Scen==7 ~ "True RR U-Subtype 2: 0.2",
                                       df.summ1a4578a9a$Scen=="8a" ~ "True RR U-Subtype 2: 1.5",
                                       df.summ1a4578a9a$Scen=="9a" ~ "True RR U-Subtype 2: 0.66")
df.summ1a4578a9a %>% ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 1") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
  ylim(c(0.85, 1.05)) + geom_hline(aes(yintercept = 1), size = 1.2)

###### Figure S5 ##########
df.summ21a4578a9a <- df.summ %>% filter(Scen %in% c("21a", 24, 25, 27, "28a", "29a"))
df.summ21a4578a9a$Scen.new <- case_when(df.summ21a4578a9a$Scen=="21a" ~ "True RR U-Subtype 2: 5",
                                        df.summ21a4578a9a$Scen==24 ~ "True RR U-Subtype 2: 2.5",
                                        df.summ21a4578a9a$Scen==25 ~ "True RR U-Subtype 2: 0.4",
                                        df.summ21a4578a9a$Scen==27 ~ "True RR U-Subtype 2: 0.2",
                                        df.summ21a4578a9a$Scen=="28a" ~ "True RR U-Subtype 2: 1.5",
                                        df.summ21a4578a9a$Scen=="29a" ~ "True RR U-Subtype 2: 0.66")
df.summ21a4578a9a %>% ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 2") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
  #ylim(c(0.85, 1.05)) +
  geom_hline(aes(yintercept = 1.5), size = 1.2)

###### Figure S6 ##########
df.summ11a4578a9a <- df.summ %>% filter(Scen %in% c("11a", 14, 15, 17, "18a", "19a"))
df.summ11a4578a9a$Scen.new <- case_when(df.summ11a4578a9a$Scen=="11a" ~ "True RR U-Subtype 2: 5",
                                        df.summ11a4578a9a$Scen==14 ~ "True RR U-Subtype 2: 2.5",
                                        df.summ11a4578a9a$Scen==15 ~ "True RR U-Subtype 2: 0.4",
                                        df.summ11a4578a9a$Scen==17 ~ "True RR U-Subtype 2: 0.2",
                                        df.summ11a4578a9a$Scen=="18a" ~ "True RR U-Subtype 2: 1.5",
                                        df.summ11a4578a9a$Scen=="19a" ~ "True RR U-Subtype 2: 0.66")
df.summ11a4578a9a %>% ggplot(aes(x = betaU1, group = factor(betaE2) , y = m.ace.or1)) + 
  theme_bw() + geom_line(size = 1.25, aes(col = factor(betaE2), linetype = factor(betaE2))) + 
  facet_wrap(. ~Scen.new) + 
  ylab("Mean estimated RR Subtype1/control") +
  xlab("True RR between U and Subtype 1") + 
  guides(override.aes = list(guide_legend(linetype = override.linetype,
                                          colour = override.color))) + 
  guides(colour = guide_legend(title = "True RR for Subtype 2/control"),
         linetype = guide_legend(title = "True RR for Subtype 2/control")) + 
  theme(axis.title = element_text(size = 14),
        axis.text=element_text(size=12),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.key.width = unit(1.5,"cm"),
        legend.position = "bottom",
        strip.text.x = element_text(size = 12)) + 
  #ylim(c(0.85, 1.05)) +
  geom_hline(aes(yintercept = 2.5), size = 1.2)

