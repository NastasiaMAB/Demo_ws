#----------------------------------------------------
# Super R. User (u1566746)
# 07 March, 2024
# Comparison of the nitrogen pools.
# Plot the different nitrogen and carbon pools between Cocci positive and Cocci negative samples, and between burrow and non-burrow
# samples and between, samples from all site together.
#----------------------------------------------------

library(vegan)
library(tidyverse)
library(multcompView)
library(ggplot2)
library(ggsignif)
library(ggnewscale)
library(ggpubr)
library(FSA)
library(patchwork)
library(ggsci)
library(dplyr)
library(car)
library(scipy.stats)
library(ggforce)
library(nlme)
library(glmmTMB)
library(usethis)
library(gitcreds)



#Reset R's brain
rm(list=ls())

#getwd tells where R is currently looking
getwd()

#setwd tell R where to look
setwd("/Users/u1566746/Documents/Work/RProject/Demo_ws/")

#use getwd to confirm that R is now looking here
getwd()

#read a CSV file containing pH data
read.csv("data.csv")

#request to import data and store the data as an object, with a name, in R's brain
dt<-read.csv("data.csv")

dt$date <- factor(dt$date, levels = c("Nov", "Jan", "Feb", "Mar", "May", "Jun", "Jul"))

plot<- ggplot(dt, aes(x = date, y=so, fill = as.factor(co))) + geom_tile(color = "white", linewidth = 0.05) + scale_x_discrete(expand = c(0,0)) + scale_fill_manual(values=c("#CCCCCC", "#FFC425", "#D11141"), name = "so sample\nCo-detection") + theme_classic() + theme(axis.title=element_blank(), axis.ticks=element_blank(), axis.line=element_blank(), legend.title = element_text(size = 8), legend.text = element_text(size = 7), legend.key.size = unit(0.4, "cm"))

ggsave("/Users/u1566746/Documents/Work/RProject/Demo_ws/Fig.jpeg", plot)

# i am adding description.

usethis::git_sitrep()
