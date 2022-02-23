# created 2022-02-23
# updated with new data 2022-02-23


# NOTE: all data and characterizations pulled from NOAA CoralReefWatch time
# series data at https://coralreefwatch.noaa.gov/product/vs/gauges/guam.php


## 1. Set up

  # drag in newest data from NOAA coral reef watch website
  NOAA_data_initial = fread('https://coralreefwatch.noaa.gov/product/vs/data/guam.txt')
  
  # check structure of data
  str(NOAA_data_initial)
  
  
## 2. Beautify data
  
  # create new dataframe for clean manipulation
  NOAA_data = NOAA_data_initial
  
  # change around date formatting
  
      # combine yyyy, mm, & dd columns
      NOAA_data$date = paste(NOAA_data$YYYY, NOAA_data$MM, NOAA_data$DD, 
                             sep = "-")
    
      #convert yyyy-mm-dd into POSIXct format
      NOAA_data$date = as.POSIXct(NOAA_data$date)
      
      
## 3. Filter data      
      
  # remove old date columns
  NOAA_data %<>% 
    dplyr::select(-c("YYYY", "MM", "DD"))
  
  # prune dates for only those covered by CoralWatch surveys (Sept 5, 2015 - present)
  NOAA_data %<>% filter(date>"2015-09-04")
  

## 4. Add in Bleaching Alert Level characterizations
  
  NOAA_data %<>%
    mutate(BAL = case_when(BAA_7day_max == 0 ~ "No Stress",
                           BAA_7day_max == 1 ~ "Bleaching Watch", 
                           BAA_7day_max == 2 ~ "Bleaching Warning", 
                           BAA_7day_max == 3 ~ "Alert Level 1",
                           BAA_7day_max == 4 ~ "Alert Level 2"))
  
  

  
  
  