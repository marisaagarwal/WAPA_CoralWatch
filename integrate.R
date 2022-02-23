##  Project Name:  WAPA Internship CoralWatch Analyses
##
##  Objective:     Assess how coral color (aka health) has changed
##                 over time.
##
##  Approach:      1. Obtain most recent download of CoralWatch color 
##                    data from from Adelup, Asan, & Agat.
##                 2. Analyze data to fulfill research objective.
##
##  Authors:       Marisa Agarwal
##
##  Start Date:    2022-02-08
##

##  Notes:         RUN THIS FILE BEFORE EVERY SESSION 



##  1. point to working directory

  setwd("research/WAPA_CoralWatch")


##  2. Set up core functionality

  # clean up
  rm(list=ls())
  
  # call to core packages for data manipulation
  library(dplyr)
  library(tidyr)
  library(magrittr)      
  library(purrr)
  library(lubridate)
  library(stringr)
  library(forcats)      
  library(tidyverse)
  library(see)
  library(broom)
  
  # for importing different formats
  library(readr)
  library(readxl)
  library(data.table)
  
  # for easier tidy stats 
  library(rstatix)
  library(easystats)
  library(multcomp)
  library(vegan)
  
  # call to visualisation & output generation
  library(ggplot2)
  library(GGally)
  library(Cairo)
  library(extrafont)
  library(RColorBrewer)
  library(viridis)
  library(ggdist)
  library(ggsci)
  library(plotrix)
  library(multcompView)
  library(ggpubr)

  # # set font for graphical outputs
  # theme_set(theme_bw(base_family = "Helvetica"))
  # CairoFonts(  # slight mod to example in ?CairoFonts page
  # regular    = "Helvetica:style = Regular",
  # bold       = "Helvetica:style = Bold",
  # italic     = "Helvetica:style = Oblique",
  # bolditalic = "Helvetica:style = BoldOblique"
  # )
  
  # # call to map theme
  # source("R/theme_nothing.R")


## 2. Generate core data objects
## if things need to be loaded in before every session, include them here





