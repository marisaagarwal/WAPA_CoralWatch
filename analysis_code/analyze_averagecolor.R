# 2022-02-09


## 1. Set up

  # point to data locale
  data_locale = "creation_code/"
  
  # load in the data
  source(paste0(data_locale, "create_CoralWatch_data.R"))
  
  # check data structure
  str(CoralWatch_data)

  
## 2. Split color data up further

  CoralWatch_data %<>%
    separate(colorcode_lightest, 
             c("lightcode_group", "lightcode_value"),
             sep = cumsum(c(1,1)), remove = F) %>%
    separate(colorcode_darkest, 
             c("darkcode_group", "darkcode_value"),
             sep = cumsum(c(1,1)), remove = F)
  
    
## 3. Summarize data
  
  # average color score by each survey
  CoralWatch_average_colorcodes =   
    CoralWatch_data %>%
      group_by(site, date_time, water_temp_C, coral_type) %>%
      summarise(average_colorcode = mean(colorcode_average))
  
  # average color score by month
  monthly_color_averages = 
    CoralWatch_data %>%
    group_by(site, 
             month = floor_date(date_time, "month")) %>%
    summarize(monthly_avg_colorcode = mean(colorcode_average))
  
  # distribution of dark scores
  darkcolor_distribution = 
    CoralWatch_data %>%
      group_by(site, date, darkcode_value) %>%
      summarise(count_colorcode = n())
  
  
## 4. Explore data
  
  # dates surveyed (Sept 2015 - present)
  unique(CoralWatch_data$date_time)
  min(CoralWatch_data$date_time)
  max(CoralWatch_data$date_time)
  
  
  
  

  
  