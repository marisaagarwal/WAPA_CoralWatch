# 2022-02-23


## 1. Set up
  
  # point to data locale
  data_locale = "creation_code/"
    
  # load in the data
  source(paste0(data_locale, "create_NOAAdata.R"))


## 2. Summaries
  
  # monthly SST averages
  monthly_SST_averages = 
    NOAA_data %>%
      group_by(month = floor_date(date, "month")) %>%
      summarize(avg_SST_max = mean(SST_MAX), 
                avg_SST_min = mean(SST_MIN),
                avg_SST90th_HS = mean(`SST@90th_HS`), 
                avg_SSTA90th_HS = mean(`SSTA@90th_HS`))
  
  # daily SST averages
  daily_NOAA_SST_averages = 
    NOAA_data %>%
      group_by(date = floor_date(date, "day")) %>%
      summarize(avg_SST_max = mean(SST_MAX), 
                avg_SST_min = mean(SST_MIN),
                avg_SST90th_HS = mean(`SST@90th_HS`), 
                avg_SSTA90th_HS = mean(`SSTA@90th_HS`)) %>%
    filter(date > "2015-09-01")
  
  
  

