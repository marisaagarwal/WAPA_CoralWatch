# 2022-02-09


## 1. Set up

  # point to data locale
  data_locale = "creation_code/"
  
  # load in the data
  source(paste0(data_locale, "create_CoralWatch_data.R"))
  
  # check data structure
  str(CoralWatch_data)

  
## 2. Summarize data for average color score by each survey
  
  CoralWatch_average_colorcodes =   
    CoralWatch_data %>%
      group_by(site, date_time, water_temp_C, coral_type) %>%
      summarise(average_colorcode = mean(colorcode_average))
  
## 3. Explore data
  
  # dates surveyed (Sept 2015 - present)
  unique(CoralWatch_data$date_time)
  min(CoralWatch_data$date_time)
  max(CoralWatch_data$date_time)
  
  
  
  

  
  